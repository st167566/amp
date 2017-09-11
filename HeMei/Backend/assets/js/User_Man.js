Vue.component('model', {
    props: ['list', 'roles', 'isactive', 'mode'],
    template: `<div class="overlay" v-show="isactive">
        <div class ="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class ="modal-dialog " role="document" style="width: 800px;">
                <div class ="modal-content" style="margin-top: 15%;">
                    <div class ="modal-header">
                        <button type="button" class ="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times; </span></button>
                        <h4 class ="modal-title">用户添加</h4>
                    </div>
                    <div class ="modal-body" style="padding: 25px 25px 0 25px;">

                  <div class ="form-group">
                    <span class ="text-primary">登录名：</span>
                    <span></span>
                    <span class ="input-icon icon-right">
                        <input type="text" class ="form-control" id="UserName" v-model="modifylist.UserName">
                        <i class ="fa fa-user success circular"></i>
                    </span>
                </div>

                    <div class ="form-group">
                    <span class ="text-primary">姓名：</span>

                    <span class ="input-icon icon-right">
                       <input type="text" class ="form-control" id="TrueName" v-model="modifylist.TrueName" >
                        <i class ="fa fa-user darkorange"></i>
                    </span>
                </div>

                <div class ="form-group"  style="margin-bottom:-30px;">
                    <span class ="text-primary">密码：</span>

                    <span class ="input-icon icon-right">
                          <input type="password"   id="Password"  class ="form-control" placeholder="密码"  @blur="inputBlur('Password',modifylist.Password)" v-model="modifylist.Password">
                        <i class ="fa fa-unlock success circular"></i>
                        <span class ="text-center tips" id="divpassword1">{{userinfo.passwordError}}</span>
                    </span>
                    <span>
                </span>
                </div>

              <div class ="form-group"  style="margin-top:30px;">
                   <span class ="text-primary">确认密码：</span>
                    <span class ="input-icon icon-right">
                          <input type="password"   id="Password2" class ="form-control" @blur="inputBlur('Password',modifylist.Password)"  placeholder="再次确认密码" v-model="modifylist.Password" >
                        <i class ="fa fa-unlock darkorange"></i>
                         <span  id="divpassword2">{{userinfo.passwordError2}}</span>
                    </span>
                </div>

                 <div class ="form-group">
                    <span class ="text-primary">邮箱：</span>
                    <span class ="input-icon">
                        <input id="Email" class ="form-control"  v-model="modifylist.Email">
                        <i class ="fa fa-envelope palegreen"></i>
                    </span>
                </div>



                    <span class ="text-primary">角色：</span>
                   <label class ="radio-inline"  v-for="item in  modifyroles" >
                   <input type="radio" name="Roles"  v-bind:id="item.ID" v-bind:value="item.ID">{{item.RoleName}}
                   </label>

               <br/>

                    <input id="Hidden2" type="hidden" runat="server" />
   
                 <p></p>
                    </div>
                    <div class ="modal-footer">
                     <input  id="Psd_Upd" type="submit" @click="modify" data-dismiss="modal"  style="margin: 0 5px" class ="btn btn-azure"  value="保存" v-bind:disabled="userinfo.beDisabled">
                         <button type="button" class ="btn btn-default"  data-dismiss="modal" @click="changeActive" >关闭</button>
                    </div>
                </div>
            </div>
        </div>
                         </div>`,
    data () {
        return {
            userinfo: {//表单中的参数
                user: '',
                password: '',
                passwordError: '',
                beDisabled: true
              
            },
        }
    },
    created: function () {
      
    },
    computed:
        {
            modifylist() {
                return this.list;
            },
            modifyroles() {
             
                // $($('#' + this.list.RoleID)).prop('checked', true);
                if (this.list.RoleID == 1) {
                    $($('#' + this.list.RoleID).eq(0)).prop('checked', false);
                } else { $($('#' + this.list.RoleID).eq(0)).prop('checked', true); }
   
                if (this.mode == 2)
                {
                   this.userinfo.beDisabled = false;
                }
             
                return this.roles;
                // $("input:radio[name='Roles']").eq(this.list.RoleID).attr("checked", 'checked');
            },
        },
    methods:
        {
            resetForm: function () {
             
                this.userinfo.Password = '';
                this.userinfo.passwordError = '';
            },
            inputBlur: function (errorItem, inputContent) {
                var flagZM = false;//验证字母

                var flagSZ = false;//验证数字

                var flagQT = false;//允许包含特殊字符

               if (errorItem === 'Password') {
                    psd = $("#Password").val();
                    if (psd.length < 6 || psd.length > 30) {
                        this.userinfo.passwordError = '密码长度大于6位小于30位字符';
                        $("#Psd_Upd").attr("disabled", true);
                    } else {
                      
                            for (i = 0; i < psd.length; i++) {
                                if ((psd.charAt(i) >= 'A' && psd.charAt(i) <= 'Z') || (psd.charAt(i) >= 'a' && psd.charAt(i) <= 'z')) {
                                    flagZM = true;
                                }
                                else if (psd.charAt(i) >= '0' && psd.charAt(i) <= '9') {
                                    flagSZ = true;
                                }
                                else {
                                    flagQT = true;
                                }
                            }

                        if (!flagZM || !flagSZ || flagQT) {
                            $("#Psd_Upd").attr("disabled", true);
                            this.userinfo.passwordError = '密码必须是字母数字的组合';
                        } else {
                            $("#Psd_Upd").attr("disabled", false);
                            this.userinfo.passwordError = '输入正确';
                        }
                    }

                    //对于按钮的状态进行修改
                    if (this.userinfo.Password != '') {
                        this.userinfo.beDisabled = false;
                    } else {
                        this.userinfo.beDisabled = true;
                    }
                }
            },
            changeActive() {
                this.$emit('change');
            },
            modify() {
                this.$emit('modify', this.modifylist);
            }
        }
})


var nv = new Vue({
    el: "#box",
    data: {
        totalCount: 200,//总项目数
        pageCount: 20, //分页数
        curPage: 1,//当前页面
        pagesize: 5,//分页大小
        showPages: 11, //显示分页按钮数
        showPagesStart: 1,//开始显示的分页按钮
        showPageEnd: 100,//结束显示的分页按钮

        batch: false,
        datas: [],//总的数据
        items: [],//显示的数据
        selected: -1,//选中模态框表格列的索引值
        selectedlist: {},//打开模态框被选中表格列数据
        weblist: {},//网站选项
        rolelist:{},//权限选项
        isActive: false,//模态框是否被激活
        Mode: '',
        userWeb: [],
        user_order: false,//用于之后排序false是大到小,下同
        isvalid_order: false,
        searchlist: [],//查询提示词
        datanums: '',
        webselected: '',//网站是否被选中
        roleselected: '-1',//权限是否被选中
        validselected: '-1',
        chosedata:[],//选中的
    },
    created: function () {
        if ($("#ctl00_ContentPlaceHolder1_role_id").val() > 2) {
            $("#webselect").css("opacity", "0");
        }
        var a = "";
        var webs = "";
        var roles = "";
        $.ajax({
            type: "get",
            url: "User_WebService.asmx/InitManUser",
            async: false,
            success: function (str) { a = $(str).find("string").text(); }
        })
        $.ajax({
            type: "post",
            url: "User_WebService.asmx/getWebData",
            async: false,  //同步，既做完才往下
            success: function (str) { webs = $(str).find("string").text(); }
        });
        $.ajax({
            type: "post",
            url: "User_WebService.asmx/getRoles",
            async: false,  //同步，既做完才往下
            success: function (str) { roles = $(str).find("string").text(); }
        });
        var json = eval('(' + a + ')');
        var webjson = eval("(" + webs + ")");
        var rolejson = eval("(" + roles + ")");
        this.datas = json;
        this.items = json.slice(0, 5);
        this.setSlist(this.items);
        this.weblist = webjson;
        this.rolelist = rolejson;
   
       
        var jlengtjh = 0;
        for (var i in json) { jlengtjh++; }
        this.totalCount = jlengtjh//总项目数
        this.pageCount = parseInt(this.totalCount / this.pagesize) + 1; //分页数
  
        var webid = $('#ctl00_ContentPlaceHolder1_web_id').val();
        this.webselected = webid;
        var roleid = $('#ctl00_ContentPlaceHolder1_role_id').val();
        //if (roleid == 1) {
        //    this.roleselected = 2;
        //} else
        //{
        //    this.roleselected = roleid;
        //}
    },
    watch: {
     
        roleselected: function () {
            var ss = [];
            this.datas.forEach(function (item) {
                if (item.RoleID == nv.roleselected) {
                    ss.push(item);

                }
            })
            this.setSlist(ss);

        },

        validselected: function()
        {
            var ss = [];
            this.datas.forEach(function (item) {
                if (item.Valid1 == nv.validselected) {
                    ss.push(item);

                }
            })
            this.setSlist(ss);    
        }
    },
    methods:
        {
            batchselect:function(){
                this.batch = false;
              
             
                nv.chosedata = [];
                $('#batch').on('show.bs.modal', function (e) {
                    var ids = [];
                    var ss = [];
                    $("#tb input[type=checkbox]").each(function () {
                        if ($(this).val() != 0) {
                            if ($(this).prop('checked')) {
                                ids.push($(this).val());
                            }
                        }
                    });
                    nv.items.forEach(function (item) {
                        for(var i = 0;i<=ids.length;i++)
                        {
                            if (item.ID == ids[i]) 
                            {
                              ss.push(item)
                            }
                        }
                    
                    })
                    nv.chosedata = ss;
                   
                  
                })
             
            },
            cancel: function (i) {
                var newarry = [];
                for (var d in nv.chosedata) {
                    if (nv.chosedata[d].ID != i) newarry.push(nv.chosedata[d]);
                }
                nv.chosedata=newarry;
            },
            forbiddenUser: function(){
                var userids = "";
                for (var i in nv.chosedata) {
                    if (nv.chosedata[i]) userids += nv.chosedata[i].ID + ",";
                }
                if (userids.lastIndexOf(",") == userids.length - 1) userids=userids.substring(0, userids.length - 1);
                if (userids != "") {
                    $.ajax({
                        type: "get",
                        url: "User_WebService.asmx/forbiddenUser",
                        data: { "ids":  userids },
                        success: function (str) {
                            alert("已成功禁用用户");
                            window.location.reload();
                        }
                    });
                }           
            },
            ensureUser: function(){
                var userids = "";
                for (var i in nv.chosedata) {
                    if (nv.chosedata[i]) userids += nv.chosedata[i].ID + ",";
                }
                if (userids.lastIndexOf(",") == userids.length - 1) userids=userids.substring(0, userids.length - 1);
                if (userids != "") {
                    $.ajax({
                        type: "get",
                        url: "User_WebService.asmx/ensureUser",
                        data: { "ids":  userids },
                        success: function (str) {
                            alert("已成功启用用户");
                            window.location.reload();
                        }
                    });
                }           
            },
            delAllUser: function(){
                var userids = "";
                for (var i in nv.chosedata) {
                    if (nv.chosedata[i]) userids += nv.chosedata[i].ID + ",";
                }
                if (userids.lastIndexOf(",") == userids.length - 1) userids=userids.substring(0, userids.length - 1);
                if (userids != "") {
                    $.ajax({
                        type: "get",
                        url: "User_WebService.asmx/delAllUser",
                        data: { "ids":  userids },
                        success: function (str) {
                            alert("已成功删除用户");
                            window.location.reload();
                        }
                    });
                }           
            },
            order: function (sx, judge) {
                function down(a, b) {//按该字段倒序
                    if (sx == "User") { nv.user_order = true; return (a.UserName + '').localeCompare(b.UserName + '') }
                    if (sx == "Valid") { nv.isvalid_order = true; return (a.Valid + '').localeCompare(b.Valid + '') }
                }
                function up(a, b) {//按该字段顺序
                    if (sx == "User") { nv.user_order = false; return (b.UserName + '').localeCompare(a.UserName + '') }
                    if (sx == "Valid") { nv.isvalid_order = false; return (b.Valid + '').localeCompare(a.Valid + '') }
                }
                judge == false ? nv.items.sort(down) : nv.items.sort(up);
            },
            addUser: function () {
                this.selectedlist = {
                    UserName: '',
                   
                };
                this.isActive = true;
                this.Mode = 1;//表示新增
            },
            // 获取需要渲染到页面中的数据
            setSlist(arr) {
                this.items = JSON.parse(JSON.stringify(arr));
            },
            // 修改数据
            showOverlay(index,id) {
                var ss;
               for (var i in this.datas) {
              
                    if (this.datas[i].ID == id) {
                       ss = i;
                        break
                        }
                 
                }
               this.selected = index;
                this.selectedlist = JSON.parse(JSON.stringify(this.datas[ss])); // 先转换为字符串，然后再转换,深度复制，防止值联动改变
                this.weblist = JSON.parse(JSON.stringify(this.weblist));
                this.rolelist = JSON.parse(JSON.stringify(this.rolelist));
                this.Mode = 2;//表示修改
                this.changeOverlay();
             

            },
            changeOverlay() {
                this.isActive = !this.isActive;
            },
            // 点击保存按钮
            modify(arr) {
                if (this.selected > -1) {//表示编辑状态
                    $.ajax({
                        type: "post",
                        url: "User_WebService.asmx/updateUserInfo",
                        data:
                            {
                                UserID: arr.ID,
                                UserName: arr.UserName,
                                TrueName: arr.TrueName,
                                Password: arr.Password,
                                Email: arr.Email,
                                RoleID: $("input[name='Roles']:checked").val(),//*同一组的radio选中的value值
                                //WebID: $("#web option:selected").val()
                            },
                        success: function (str) {
                            alert(添加成功);
                        },
                        error: function (msg) {
                            alert(msg);
                        }
                    })
                    Vue.set(this.datas, this.selected, arr);

               
                } else {//表示新增状态
                    var a;
                    ajax1 = $.ajax({
                        type: "post",
                        url: "User_WebService.asmx/checkUser",
                        async: false,  //同步，既做完才往下
                        data: { UserName: $("#UserName").val() },
                        success: function (str) {
                            a = $(str).find("int").text();
                        }
                    })
            
                    $.when(ajax1).done(function () {
                        //所做操作
                        if (a == 1) {
                            alert("用户名已存在");

                        }
                        else {
                            $.ajax({
                                type: "post",
                                url: "User_WebService.asmx/addUser",
                                data:
                                    {
                                        UserName: $("#UserName").val(),
                                        TrueName: $("#TrueName").val(),
                                        Password: $("#Password2").val(),
                                        Email: $("#Email").val(),
                                        RoleID: $("input[name='Roles']:checked").val(),//*同一组的radio选中的value值
                                        //WebID: $("#web option:selected").val()
                                    },
                                success: function (str) {
                                    alert(添加成功);
                                },
                                error: function (msg) {
                                    alert(msg);
                                }
                            })
                        }
                    })
               
                }
                this.setSlist(this.datas);
                this.changeOverlay();
            },
            //展示用户所属网站
            showWeb: function (id) {
                var a = "";
                $.ajax({
                    type: "get",
                    data: { UserID: id },
                    async: false,  //同步，既做完才往下
                    url: "User_WebService.asmx/showWeb",
                    success:function(str){ a = $(str).find("string").text()}
                })
                this.userWeb = eval('(' + a + ')');
                this.selected = id;
                
            },
            //删除用户关联表信息
            delWebUser: function()
            {
                var chk_value = [];
                $('input[name="tagUsers"]:checked').each(function () {
                    chk_value.push($(this).val());
                });
                var ids = chk_value.toString();
                $.ajax({
                    type: "post",
                    data:
                        {
                            UserID: this.selected,
                            WebID: ids
                        },
                    async: false,
                    url: "User_WebService.asmx/delWebUser",
                    success: function (str) {
                        console.log(str);

                    }
                })
            },
            addWebUser: function ()
            {
                var chk_value = [];
                var webname = [];
                $('input[name="webs"]:checked').each(function () {
                    chk_value.push($(this).val());
                    webname.push($(this).prev().text());

                });
                var ids = chk_value.toString();
                var len = chk_value.length;
          
                $.ajax({
                    type: "post",
                    data:
                        {
                            UserID: this.selected,
                            WebID: ids,
                            RoleID: $("input[name='Roles2']:checked").val()
                        },
                    async: false,
                    url: "User_WebService.asmx/addUserIntoWeb",
                    success: function (str) {
                        console.log(str);

                    }
                })

                for (var i = 0; i < len; i++) {

                    var json =
                        {
                            WebName: webname[i]
                        }
                    this.userWeb.push(json);

                }
            },
            filterData: function () {
                var json = this.userWeb;
                var json2 = this.weblist;
                for (var i in json) {
                    for (var j in json2) {
                        if (json[i].WebID == json2[j].ID) {
                            this.weblist.splice(j, 1);
                        }
                    }
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
                    this.datas.forEach(function (item) {
                        if (item.UserName.indexOf(v) > -1) {
                                if (self.searchlist.indexOf(item.UserName) == -1) {
                                    self.searchlist.push(item.UserName);
                                }
                                ss.push(item);
                           
                        } else if (item.TrueName)
                        {
                            if (item.TrueName.indexOf(v) > -1)
                            {
                                if (self.searchlist.indexOf(item.TrueName) == -1) {
                                    self.searchlist.push(item.TrueName);
                                }
                                ss.push(item);
                            }
                           
                        } else if (item.Email) {
                            if (item.Email.indexOf(v) > -1)
                            {
                                if (self.searchlist.indexOf(item.Email) == -1) {
                                    self.searchlist.push(item.Email);
                                }
                                ss.push(item);
                            }
                           
                        } else if (item.TelePhone) {
                            if (item.TelePhone.indexOf(v) > -1)
                            {
                                if (self.searchlist.indexOf(item.TelePhone) == -1) {
                                    self.searchlist.push(item.TelePhone);
                                }
                                ss.push(item);
                            }
                           
                        }
                    });
                    this.setSlist(ss); // 将过滤后的数据给了slist
                } else {
                    // 没有搜索内容，则展示全部数据
                    this.setSlist(this.datas);
                }
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
                    url: "User_WebService.asmx/DelUser",
                    success: function (str) { console.log(str); }
                });
            },
showPage: function (pageIndex, $event, forceRefresh) {

    if (pageIndex > 0) {


        if (pageIndex > this.pageCount) {
            pageIndex = this.pageCount;
        }

        //判断数据是否需要更新
        var currentPageCount = Math.ceil(this.totalCount / this.pagesize);
        if (currentPageCount != this.pageCount) {
            pageIndex = 1;
            this.pageCount = currentPageCount;
        }
        else if (this.curPage == pageIndex && currentPageCount == this.pageCount && typeof (forceRefresh) == "undefined") {
            console.log("not refresh");
            return;
        }

        this.curPage = pageIndex;
        //测试数据 随机生成的
        var newPageInfo = [];
        for (var i = 0; i < this.pagesize; i++) {
            var j = (this.curPage - 1) * this.pagesize + i;
            if (this.datas[j]) {
                newPageInfo.push(this.datas[j]);
            }
        }
        this.items = newPageInfo;

        //计算分页按钮数据
        if (this.pageCount > this.showPages) {
            if (pageIndex <= (this.showPages - 1) / 2) {
                this.showPagesStart = 1;
                this.showPageEnd = this.showPages - 1;
                console.log("showPage1")
            }
            else if (pageIndex >= this.pageCount - (this.showPages - 3) / 2) {
                this.showPagesStart = this.pageCount - this.showPages + 2;
                this.showPageEnd = this.pageCount;
                console.log("showPage2")
            }
            else {
                console.log("showPage3")
                this.showPagesStart = pageIndex - (this.showPages - 3) / 2;
                this.showPageEnd = pageIndex + (this.showPages - 3) / 2;
            }
        }
        console.log("showPagesStart:" + this.showPagesStart + ",showPageEnd:" + this.showPageEnd + ",pageIndex:" + pageIndex);
    }
    //处理分页点中样式
    setTimeout(function () {
        var buttons = $("#pager").find("span");
        for (var i = 0; i < buttons.length; i++) {
            if (buttons.eq(i).html() != pageIndex) {
                buttons.eq(i).removeClass("active");
            }
            else {
                buttons.eq(i).addClass("active");
            }
        }
    }, 100);
},
        }
})


$('#Checkbox1').click(function () {
    var ch = false;
    if ($('#Checkbox1').prop('checked')) ch = true;
    $("#tb input[type=checkbox]").each(function () {
        if (ch) $(this).prop("checked", true);
        else { $(this).prop("checked", false); }
    })
});