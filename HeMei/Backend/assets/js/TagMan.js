Vue.component('model', {
    props: ['list', 'isactive'],
    template: `<div class="overlay" v-show="isactive">
           <div class ="modal fade" id="addTagModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class ="modal-dialog " role="document" style="width: 800px;">
                <div class ="modal-content" style="margin-top: 15%;">
                    <div class ="modal-header">
                        <button type="button" class ="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times; </span></button>
                        <h4 class ="modal-title">标签添加</h4>
                    </div>
                    <div class ="modal-body" style="padding: 25px 25px 0 25px;"  v-on: submit.prevent="addTag">

                  <div class ="form-group">
                    <span class ="text-primary">标签名：</span>
                    <span></span>
                    <span class ="input-icon icon-right">
                        <input type="text" class ="form-control" id="TagName"  v-model="modifylist.TagName" placeholder="此字段不能为空">
                    </span>
                </div>

                    <div class ="form-group">
                    <span class ="text-primary">标签描述：</span>

                   <textarea class ="form-control" rows="3" placeholder="关于你的标签" id="TagDescription"  v-model="modifylist.Description"></textarea>
                </div>
 <ul class ="errors">
    <li v-show="!validation.TagName">标签名不能为空.</li>
  </ul>

                        <div style="margin-bottom:60px"></div>
                    </div>
                    <div class ="modal-footer" >
                      <input  type="submit" @click="modify" data-dismiss="modal"  style="margin: 0 5px" class ="btn btn-info"  value="保存">
                      <button type="button" class ="btn btn-default"  data-dismiss="modal" @click="changeActive" >关闭</button>
                    </div>
                </div>
            </div>
        </div>
                    </div>`,
    computed: {
        modifylist() {
            return this.list;
            
        },
        validation: function () {//验证输入表单是否符合条件
            return {
                TagName: !!this.modifylist.TagName,
            }
        },
        isValid: function () {
            var validation = this.validation
            return Object.keys(validation).every(function (key) {
                return validation[key]
            })
        }
    },
    methods: {
        changeActive() {
            this.$emit('change');
        },
        modify() {
            if (this.isValid) {
                this.$emit('modify', this.modifylist);
            }
        }
    }
});


var nv = new Vue({
    el: '#box',
    data:
        {
            batch: false,//是否显示多选宽
            datas: [],//总的数据
            items: [],//显示的数据
            tagUsers: [],//标签中的用户
            webUsers: [],//该网站用户
            filterUsers: [],//过滤后用户
            selected: -1,//选中模态框表格列的索引
            selectedlist: {},//打开模态框被选中表格列数据
            isActive: false,//模态框是否被激活
            rowid: -1,
            searchlist: [],//查询提示词
            webselected: '',//网站是否被选中
            pageSize: '',//翻页每页显示数据
            curPage: 0,//当前页面
            pageCount: '',//总共页面数
            onn: true,//默认显示分页
            pageShow: [],//分页按钮的data
            moreleft: false,
            moreright: true,
            datanums: '',
        },
    created: function () {
        if ($("#ctl00_ContentPlaceHolder1_role_id").val() > 2) {
            $("#webselect").css("opacity", "0");
        }
        var a = "";
        var users = "";
        $.ajax({
            type: "get",
            url: "User_WebService.asmx/InitUserTagMan",
            async: false,  //同步，既做完才往下
            success: function (str) { a = $(str).find("string").text(); }
        });
        $.ajax({
            type: "get",
            url: "User_WebService.asmx/InitWebUser",
            async: false,  //同步，既做完才往下
            success: function (str) { users = $(str).find("string").text(); }
        });
        var json = eval('(' + a + ')');
        var json2 = eval('(' + users + ')');
        this.datas = json;
        this.items = json.slice(0, 5);
        this.setSlist(this.items);
        this.webUsers = json2;
        var webid = $('#ctl00_ContentPlaceHolder1_web_id').val();
        this.webselected = webid;
        this.pageSize = 5;
        this.pageCount = Object.keys(this.datas).length / this.pageSize;
        if (this.pageCount < 4) {
            for (var i = 0; i < this.pageCount; i++) { this.pageShow.push(i + 1); }
            this.moreright = false;
        } else {
            for (var i = 0; i < 4; i++) { this.pageShow.push(i + 1); }
            this.moreright = true;
        }
       
    },
    computed: {
        webs: function () {
            var a = ""
            $.ajax({
                type: "post",
                url: "User_WebService.asmx/getWebData",
                async: false,  //同步，既做完才往下
                success: function (str) { a = $(str).find("string").text(); }
            });
            return eval("(" + a + ")");
        }
    },
    watch: {
    webselected: function () {
         var ss = [];
                this.datas.forEach(function (item) {
                    if (item.WebID == nv.webselected) {
                        ss.push(item);

                    }
                })
                this.setSlist(ss);
         
    }
},
    methods:
        {
            add: function () {
                this.selectedlist = {
                    TagName: '',
                    Description: ''
                };
                this.isActive = true;
            },
            // 修改数据
            showOverlay(index) {
                this.selected = index;
                this.selectedlist = JSON.parse(JSON.stringify(this.datas[index])); // 先转换为字符串，然后再转换,深度复制，防止值联动改变
                this.changeOverlay();
            
            },
            // 点击保存按钮
            modify(arr) {
                if (this.selected > -1) {//表示编辑状态
                    $.ajax({
                        type: "post",
                        url: "User_WebService.asmx/updateTag",
                        data:
                            {
                                ID: arr.ID,
                                TagName: arr.TagName,
                                Description: arr.Description
                            },
                        success: function (str) {
                            console.log(str);
                        }
                    });
                    Vue.set(this.datas, this.selected, arr);
                } else {//表示新增状态
                  
                     var a;
                    ajax1 = $.ajax({
                        type: "post",
                        url: "User_WebService.asmx/checkTag",
                        async: false,  //同步，既做完才往下
                        data: { TagName: $("#TagName").val() },
                        success: function (str) {
                            a = $(str).find("int").text();
                        }
                    })

                    $.when(ajax1).done(function () {
                        //所做操作
                        if (a == 1) {
                            alert("标签名已存在");

                        }
                        else {
                            this.datas.push(arr);
                            $.ajax({
                                type: "post",
                                url: "User_WebService.asmx/addTag",
                                async: false,  //同步，既做完才往下
                                data: { TagName: $("#TagName").val(), TagDescription: $("#TagDescription").val() },
                                success: function (str) { alert(str) },
                                error: function (msg) { alert(msg) }
                            })
                        }
                    });
                  
                }
                this.setSlist(this.datas);
                this.changeOverlay();
            },
            changeOverlay() {
                this.isActive = !this.isActive;
            },
            // 获取需要渲染到页面中的数据
            setSlist(arr) {
                this.items = JSON.parse(JSON.stringify(arr));
            },
            setWebUser(arr) {
                this.webUsers = JSON.parse(JSON.stringify(arr));
            },
            Delete: function (id) {
                //实际项目中参数操作肯定会涉及到id去后台删除，这里只是展示，先这么处理。
                for (var i = 0; i < this.items.length; i++) {
                    if (this.items[i].ID == id) {
                        this.items.splice(i, 1);
                        break;
                    }
                }

                $.ajax({
                    type: "post",
                    data: {
                        ID: id,
                    },
                    url: "User_WebService.asmx/DelTag",
                    success: function (str) { console.log(str); }
                });
            },
            showTagUser: function (id,index)
            {
                this.selected = id;
                this.rowid = index;
                $.ajax({
                    type: "get",
                    data: {
                        TagID: id
                    },
                    async: false,  //同步，既做完才往下
                    url: "User_WebService.asmx/getTagUser",
                    success: function (str) { a = $(str).find("string").text(); }

                })
                var json = eval('(' + a + ')');
                this.tagUsers = json;
            },
            delTagUser: function (id) {
                var chk_value = [];
                $('input[name="tagUsers"]:checked').each(function () {
                    chk_value.push($(this).val());
                });
                var ids = chk_value.toString();
                var len = chk_value.length;

                var users;
                this.items.forEach(function (item) {
                    if (item.ID == id)
                    {
                        users = item.Users - len;
                        item.Users = users;
                     
                  
                    }
                })
          
                $.ajax({
                    type: "post",
                    data:
                        {
                            TagID: id,
                            UserID: ids
                        },
                    async: false,
                    url: "User_WebService.asmx/delTagUser",
                    success: function (str) {
                        console.log(str);
                       
                    }
                })

                
            },
            addTagUser: function (id)
            {
                var chk_value = [];
                var username = [];
                $('input[name="webUsers"]:checked').each(function () {
                    chk_value.push($(this).val());
                    username.push($(this).prev().text());
                   
                });
                var ids = chk_value.toString();
                var len = chk_value.length;
              $.ajax({
                    type: "post",
                    data:
                        {
                            TagID: id,
                            UserID: ids
                        },
                    async: false,
                    url: "User_WebService.asmx/addWebUser",
                    success: function (str) {
                        console.log(str);
                      
                    }
              })

              var users;
              this.items.forEach(function (item) {
                  if (item.ID == id) {
                      users = item.Users + len;
                      item.Users = users;


                  }
              })


                for (var i = 0; i < len; i++) {

                    var json =
                        {
                            UserName: username[i]
                        }
                    this.tagUsers.push(json);

                }
            },
            filterData: function ()
            {
                var json = this.tagUsers;
                var json2 = this.webUsers;
                for (var i in json) {
                    for (var j in json2) {
                    if (json[i].ID == json2[j].ID)
                    {
                       this.webUsers.splice(j, 1);
                    }
                    }
                }
            },
            // 搜索标签
            search(e) {
                var v = e.target.value,
                    self = this;
              
                self.searchlist = [];
                if (v) {
                    var ss = [];
                   // 过滤需要的数据
                    this.datas.forEach(function (item) {
                        if (item.TagName.indexOf(v) > -1) {
                            if (self.searchlist.indexOf(item.TagName) == -1) {
                                self.searchlist.push(item.TagName);
                               
                            }
                            ss.push(item);
                        } 
                    });
                    this.setSlist(ss); // 将过滤后的数据给了slist
                } else {
                    // 没有搜索内容，则展示全部数据
                    this.setSlist(this.datas);
                }
            },
            // 搜索用户
            searchUser(e) {
                var v = e.target.value,
                    self = this;
                self.searchlist = [];
                if (v) {
                    var ss = [];
                    // 过滤需要的数据
                    this.webUsers.forEach(function (item) {
                     
                        if (item.UserName.indexOf(v) > -1) {
                            if (self.searchlist.indexOf(item.UserName) == -1) {
                            
                                self.searchlist.push(item.UserName);

                            }
                            ss.push(item);
                        }
                    });
                    this.setWebUser(ss); // 将过滤后的数据给了slist
                } else {
                    // 没有搜索内容，则展示全部数据
                    this.setWebUser(this.webUsers);
                }
            },
            page: function (el) {//点击翻页                 
                el == 'last' ? this.curPage-- : this.curPage++;
                var curtotal = this.curPage * this.pageSize;
                var tiaoshu = this.curPage * this.pageSize + this.pageSize;
                this.items = this.datas.slice(curtotal, tiaoshu);
                var a = this.curPage;
            },
            page1: function (a) {
                if (a == 'right') {
                    a = this.curPage = (this.curPage / this.pageSize + 1) * this.pageSize - 1;
                    for (var i in nv.pageShow) {
                        nv.pageShow[i] += nv.pageSize - 1;
                        if (nv.pageShow[i] > nv.pageCount) this.moreright = false;
                    }
                    this.moreleft = true;
                }
                if (a == 'left') {
                    a = this.curPage = (this.curPage / this.pageSize - 1) * this.pageSize + 1;
                    for (var i in nv.pageShow) {
                        nv.pageShow[i] -= nv.pageSize - 1;
                    }
                    if (nv.pageShow[0] == 1) this.moreleft = false;
                    this.moreright = true;
                }
                this.curPage = a;
                var curtotal = a * this.pageSize;
                var tiaoshu = a * this.pageSize + this.pageSize;
                this.items = this.datas.slice(curtotal, tiaoshu);
            },
            fanye: function () {//分页处理
                var _this = this;
                _this.items = [];
                if (_this.datas) {
                    _this.pageCount = Math.ceil(_this.datas.length / _this.pageSize);
                    for (var i = 0; i < _this.pageSize; i++) {
                        if (_this.datas[i]) {
                            _this.items.push(_this.datas[i]);
                        };
                    };
                };
            }
        },
})