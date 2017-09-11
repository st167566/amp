 Vue.component('model', {
        props: ['list', 'isactive'],
        template: `<div class="overlay" v-show="isactive">
                <div class ="modal fade" id="layer" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
            <div class ="modal-dialog " role="document" style="width: 800px;">
                <div class ="modal-content" style="margin-top: 15%;">
                    <div class ="modal-header">
                        <button type="button" class ="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times; </span></button>
                        <h4 class ="modal-title">编辑焦点图</h4>
                    </div>
                    <div class ="modal-body" style="padding: 15px 25px;">
                        <center><img id="FocusPhoto"  style="width: 600px; height: 180px; margin-right: 15px;" :src="modifylist.PhotoSrc" v-model="modifylist.PhotoSrc"/></center>
                        <p></p>
  <div class ="form-inline pull-right">
  <div class ="form-group">
    <label for="exampleInputName2"> 链接：</label>
    <input type="text" class ="form-control"  v-model="modifylist.LinkURL">
  </div>
  <div class ="form-group">
    <label for="exampleInputEmail2">排序：</label>
    <input type="email" class ="form-control" id="exampleInputEmail2"  style="width:30px" v-model="modifylist.Orders">
  </div>
   <div class ="checkbox">
    <label>
        显示: <input type="checkbox" id="ValidCheckBox" v-model="modifylist.Valid">
    </label>
  </div>
</div>
                        <div style="clear: both;"></div>
                    </div>
                    <div class ="modal-footer">
                       
                        <input type="button" @click="modify" data-dismiss="modal"  style="margin: 0 5px" class ="btn btn-info"  value="保存">
                         <button type="button" class ="btn btn-default"  data-dismiss="modal" @click="changeActive" >关闭</button>
                 
                
                    </div>
                </div>
            </div>
        </div>
                    </div>`,
        computed: {
            modifylist() {
                return this.list;
            }
        },
        methods: {
            changeActive() {
                this.$emit('change');
            },
            modify() {
                this.$emit('modify', this.modifylist);
            }
        }
    });


    var nv = new Vue({
        el: '#box',
        data: {
            batch: false,//是否显示多选宽
            datas: [],//总的数据
            items: [],//显示的数据
            nowIndex: -100,//表格不存在index
            isActive: false,//模态框是否被激活
            selected: -1,//选中模态框表格列的ID
            selectedlist: {},//打开模态框被选中表格列数据
            webselected: ''//网站是否被选中


        },
        created: function () {//加载数据items
            if ($("#ctl00_ContentPlaceHolder1_role_id").val() > 2) {
                $("#webselect").css("opacity", "0");
            }
            var a = "";
            $.ajax({
                type: "get",
                url: "User_WebService.asmx/InitFocuses",
                async: false,  //同步，既做完才往下
                success: function (str) { a = $(str).find("string").text(); }
            });
            var json = eval('(' + a + ')');
            this.datas = json;
            this.items = json;
            var webid = $('#ctl00_ContentPlaceHolder1_web_id').val();
            this.webselected = webid;
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
        methods:
            {
                // 修改数据
                showOverlay(index) {
                    this.selected = index;
                    this.selectedlist = JSON.parse(JSON.stringify(this.datas[index])); // 先转换为字符串，然后再转换,深度复制，防止值联动改变
                    this.changeOverlay();
                },
                // 点击保存按钮
                modify(arr) {
                    $.ajax({
                        type: "post",
                        url: "User_WebService.asmx/updateFocus",
                        data:
                            {
                                ID: arr.ID,
                                LinkURL: arr.LinkURL,
                                Orders: arr.Orders,
                                Valid: arr.Valid
                            },
                        success: function (str)
                        {
                            console.log(str);
                        }
                    });
                    if (this.selected > -1) {
                        Vue.set(this.datas, this.selected, arr);
                    } else {
                        this.datas.push(arr);
                    }
                    this.setSlist(this.datas);
                    this.changeOverlay();
                },
                // 获取需要渲染到页面中的数据
                setSlist(arr) {
                    this.items = JSON.parse(JSON.stringify(arr));
                },
                changeOverlay() {
                    this.isActive = !this.isActive;
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
                        url: "User_WebService.asmx/DelFocuses",
                        success: function (str) { console.log(str); }
                    });
                },
            } 
        , watch: {
            webselected: function () {
                var ss = [];
                this.datas.forEach(function (item) {
                    if (item.WebID == nv.webselected) {
                        ss.push(item);

                    }
                })
                this.setSlist(ss);
            }
        }
    })

    $("#OrdersBtn").click(function () {
        //存储数据
        var ids = "",orders= "";
        //遍历选择的数据
        $(".table  input[type='text']").each(function (index, item) {
            //添加数据
            orders += $(item).val() + ",";//每个数后面加个点，这样好区分
            //传递数据
      
        });

        //$("#tb tr").each(function () {
        //    var text = $(this).children("#idval").val();
        //    alert(text);
        //})

        $(".table  input[type='hidden']").each(function (index, item) {
            ids += $(item).val() + ",";
     
        })
        ids = ids.substring(0, ids.lastIndexOf(','));
        orders = orders.substring(0, orders.lastIndexOf(','));

        $.ajax({
            type: "post",
            url: "User_WebService.asmx/updateFocusOrder",
            data: { "IDs": ids , "Orders": orders},
            async: false,  //同步，既做完才往下
            success: function (str) {
                nv.items = eval('(' + $(str).find("string").text() + ')');
            },
            error: function (msg) {

                console.log(msg);

            }
        })
    });