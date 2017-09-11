<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="User_Manage.aspx.cs" Inherits="User_Manage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <input id="web_id" type="hidden" runat="server" />
        <input id="role_id" type="hidden" runat="server" />
     <style type="text/css">
          .img-circle2 {
            width:50px;
            height:50px;
            margin:0 auto;
            border-radius: 50%;
            background-color:#5bc1ef;
        }
            .img-circle2 p {
			 font-weight:bold;
			 font-size:16px;
			 color:white;
			  margin:0 auto;
			  text-align:center;
			  line-height:3;
			   
            }
                [v-cloak] {
            display: none
        }
    </style>

       <div id="CurrentPosition">当前位置：<a href="User_Manage.aspx">用户管理</a></div>
      <div class="page-body" style="padding: 18px 20px 24px;" id="box" v-cloak>
                            <div class="row">
                                <div class="col-xs-12 col-md-12">
                                    <div class="widget">
                                        <div class="widget-header ">
                                            <span class="widget-caption">用户管理</span>
                                            <div class="widget-buttons">
                                                <a href="#" data-toggle="maximize">
                                                    <i class="fa fa-expand"></i>
                                                </a>
                                                <a href="#" data-toggle="collapse">
                                                    <i class="fa fa-minus"></i>
                                                </a>
                                                <a href="#" data-toggle="dispose">
                                                    <i class="fa fa-times"></i>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="widget-body">
                                          
                                            <div class="col-xs-6 col-md-6">
                                                <span class="input-icon">
                                                      <input id="SearchTB" type="text" placeholder="查询用户名,真实姓名，联系方式，邮箱" class="form-control input-sm" @input="searchUser" list="words" />
                                                    <i class="glyphicon glyphicon-search danger circular"></i>
                                                <datalist id="words">
                                   <option v-for="item in searchlist" :value="item"></option>
                                   </datalist>  </span>

                                            </div>

                  <button id="addUser" type="button" class="btn btn-info login" @click="addUser">添加用户</button>&nbsp;&nbsp;&nbsp;&nbsp;
                  <input type="button" id="czBtn" value="批量操作" class="btn btn-warning" v-show="!batch" v-on:click="batch=true" />
                 <input type="button" id="xzBtn" value="选择操作" data-toggle="modal" data-target="#batch" class="btn btn-warning" v-show="batch" v-on:click="batchselect" />
                                             &nbsp;&nbsp;  &nbsp;&nbsp;   
        <%-- <select v-model="webselected" id="webselect">
                <option v-for="item in  weblist" v-bind:value="item.ID">{{item.WebName}}</option>
          </select>--%>
                               
       <select v-model="roleselected" id="roleselect" >
               <option value="-1">权限</option>
                <option v-for="item in  rolelist" v-bind:value="item.ID">{{item.RoleName}}</option>
          </select>

         <select v-model="validselected" id="validselect" >
               <option value="-1">用户状态</option>
               <option value="1">True</option>
               <option value="0">False</option>
          </select>
<p></p>
<div class="row">
                                       <div class="col-md-4 pull-right">
                                    总共：<span id="Label1" style="color: #5D7B9D; font-weight: bold">{{totalCount}}</span>
                                    条记录，每页显示：
                                   <select id="PageSizeDDL" style="font-weight: bold; color: #5D7B9D" v-model="pagesize"  v-on:change="showPage(curPage,$event,true)" number>
                                        <option value="5">5</option>
                                        <option value="10">10</option>
                                        <option value="20">20</option>
                                        <option value="50">50</option>
                                    </select>
                                    条记录，共<span id="Label2" style="font-weight: bold; color: #5D7B9D">{{pageCount}}</span>页
                                </div>
    </div>
                                    <p></p>

                        <table id="tb" class="table table-bordered table-hover">
                             <thead>
                            <tr class="text-danger">
                                <th class="text-center" v-show="batch">
                                    <input id="Checkbox1" value="0" type="checkbox" /></th>
                                <th class="text-center" v-show="!batch">序</th>
                                <th class="text-center">用户名<i class="glyphicon glyphicon-sort" v-on:click="order('User',user_order)"></i></th>
                                 <th class="text-center">姓名</th>
                                <th class="text-center">Email</th>
                                <th class="text-center">联系方式</th>
                                <th class="text-center">头像</th>
                                 <th class="text-center">角色</th>
                                 <th class="text-center">有效性<i class="glyphicon glyphicon-sort" v-on:click="order('Valid',isvalid_order)"></i></th>
                                 <th class="text-center">操作</th>
                            </tr>
                                 </thead>
                             <tbody>
                                 <template v-for="(item,index) of items" v-model="items"  v-clock>
                        <tr class="text-center"> 
                             <td v-show="batch">
                                 <input type="checkbox" v-bind:value="item.ID"/>
                             </td>
                            <td v-show="!batch">{{index+1}}</td>
                             <td>
                               <%--  <a :href="['User_Edit.aspx?ID='+item.ID]">--%>
                                     {{item.UserName}}
                             <%--    </a>--%>

                             </td>
                                 <td>{{item.TrueName}}</td>
                                <td>{{item.Email}}</td>
                            <td>{{item.Telephone}}</td>
                            <td>
             <img :src="item.Avatar" alt="" class="img-circle img-responsive text-center" style="height:60px;width:60px">

                            </td>
                                <td>{{item.RoleName}}</td>
                                <td>{{item.Valid1}}</td>
                                <td>
                                    <a  href="javascript:;" data-toggle="modal" data-target="#addUserModal" @click="showOverlay(index,item.ID)" class="btn btn-info btn-xs">
                                        <i class="fa fa-edit"></i>编辑

                                    </a>&nbsp;&nbsp;
                                    <a href="#" data-toggle="modal" data-target="#delUserModal" @click="nowIndex=item.ID" class="btn btn-danger btn-xs delete">
                                        <i class="fa fa-trash-o"></i>删除
                                     </a>
                                </td>
                        </tr>
                             </template>
                              </tbody>
                        </table>

  <div style="clear: both"></div>
   <div class="page-header"></div>
   <div class="pager" id="pager">
   <template v-for="item in pageCount+1">
                        <span v-if="item==1" class="btn btn-default" v-on:click="showPage(1,$event)">
                            首页
                        </span>
                        <span v-if="item==1" class="btn btn-default" v-on:click="showPage(curPage-1,$event)">
                            上一页
                        </span>
                        <span v-if="item==1" class="btn btn-default" v-on:click="showPage(item,$event)">
                            {{item}}
                        </span>
                        <span v-if="item==1&&item<=showPagesStart-2" class="btn btn-default disabled">
                            ...
                        </span>
                        <span v-if="item>=2&&item<=pageCount-1&&item>=showPagesStart&&item<=showPageEnd&&item<=pageCount" class="btn btn-default" v-on:click="showPage(item,$event)">
                            {{item}}
                        </span>
                        <span v-if="item==pageCount&&item>showPageEnd+1" class="btn btn-default disabled">
                            ...
                        </span>
                        <span v-if="item==pageCount" class="btn btn-default" v-on:click="showPage(item,$event)">
                            {{item}}
                        </span>
                        <span v-if="item==pageCount" class="btn btn-default" v-on:click="showPage(curPage+1,$event)">
                            下一页
                        </span>
                        <span v-if="item==pageCount" class="btn btn-default" v-on:click="showPage(pageCount,$event)">
                            尾页
                        </span>
                    </template>
                            <span class="form-inline">
                                <input class="pageIndex form-control" style="width: 60px; text-align: center" type="text" v-model="curPage" v-on:keyup.enter="showPage(curPage,$event,true)" />
                            </span>
                            <span>{{curPage}}/{{pageCount}}</span>
                        </div>

  <model :list='selectedlist'  :roles='rolelist' :isactive="isActive" :mode="Mode" v-cloak @change="changeOverlay" @modify="modify"></model>
                                            </div>
                                        </div>
                                    </div>


                                </div>

    <%--删除用户的Modal--%>
    <div class="modal fade bs-example-modal-sm" id="delUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog  modal-sm " role="document" >
            <div class="modal-content" style="margin-top: 15%;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">操作</h4>
                </div>
                <div class="modal-body" style="padding: 25px 25px 0 25px;">
                    <div class="text-center">
                    <span ><strong>是否确认删除？</strong></span>
                        <p></p>
                   <input type="button" value="删除" @click="Delete(nowIndex)" class="btn btn-danger btn-sm" style="margin: 0 5px" data-dismiss="modal"/>
                    <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">关闭</button>
                 
               </div>
<div style="margin-top: 18px">
                    </div>
                </div>
                  <div class="modal-footer">
               
                </div>
            </div>
              
        </div>
    </div>

            <%--展示用户网站的Modal--%>
      <%--<div class="modal fade" id="delUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">所属网站</h4>
                    </div>
                    <div class="modal-body"  style="max-height: 250px; overflow-y: scroll; padding-left:5%; padding-top:10px;">
                          <ul>
                     <li style="padding-left:16px;display:inline-block" v-for="(item,index) of userWeb">
                    
                        <div class="img-circle2">
                  <p>{{item.WebName}}</p> 
                            </div>
                     <input type="checkbox"   :value="item.WebID" name="tagUsers" class="text-center"/>
                          </li>
                              </ul>
                    </div>
                    <div class="modal-footer">
                         <button type="button" class="btn btn-info" data-toggle="modal" data-target="#webModal" @click="filterData"/ >增加</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal" @click="delWebUser"/ >删除</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>--%>

            <%--展示网站群的Modal--%>
          <%--<div class="modal fade" id="webModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">网站群</h4>
                    </div>
                    <div class="modal-body"  style="max-height: 250px; overflow-y: scroll; padding-left:5%; padding-top:10px;">
                          <ul>
                     <li style="padding-left:16px;display:inline-block" v-for="(item,index) of weblist">
                 
                        <div class="img-circle2">
                  <p>{{item.WebName}}</p> 
                            </div>
                     <input type="checkbox"   :value="item.ID" name="webs" class="text-center"/>
                          </li>
                              </ul>

                     <div class="pull-right">
                    <span class ="text-primary">所属权限：</span>
                   <label class ="radio-inline"  v-for="item in   rolelist" >
                   <input type="radio" name="Roles2"  v-bind:id="item.ID" v-bind:value="item.ID">{{item.RoleName}}
                   </label>
                         </div>
                    </div>
                    <div class="modal-footer">
                         <button type="button" class="btn btn-info"  data-dismiss="modal" data-target="#AddUserModal" @click="addWebUser"/ >增加</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>--%>

             <%--批量操作用户的Modal--%>
        <div class="modal fade" id="batch" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog " role="document" style="width: 800px;">
            <div class="modal-content" style="margin-top: 15%;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">操作</h4>
                </div>
                <div class="modal-body" style="padding: 25px 25px 0 25px;">
                     <ul>
                     <li style="padding-left:16px;display:inline-block" v-for="(item,index) of chosedata" >
                        <%-- :src="item.Avatar" --%>
                          <img alt='' src="assets/img/timg.jpg" style="border-radius: 50%; width: 60px; height: 40px; vertical-align: middle;" />
                         <br />
                          <span class="text-center" style="margin-left:6px">{{item.UserName}}</span>
                         <a v-on:click="cancel(item.ID)" style="cursor:default">x</a>
                          </li>
                              </ul>
                        <div v-if="chosedata.length == 0">您暂无选中任何用户</div>
                 
                    <div style="margin-top: 8px">
                    </div>

                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-success" value="启用" style="margin: 0 5px" @click="ensureUser()"/>
                    <input type="button" value="禁用" class="btn btn-danger" style="margin: 0 5px" @click="forbiddenUser()"/>
                    <input type="button" value="删除" class="btn btn-warning" style="margin: 0 5px" @click="delAllUser()" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
                            </div>


    
                     
       <script src="assets/js/User_Man.js"></script>
       <script src="assets/js/VerifyPsd.js"></script>
        <script type="text/javascript">
            $("#addUser").click(function () {
                $("#addUserModal").modal("show");
            });
            function InitiateWidgets()
            { $('.widget-buttons *[data-toggle="maximize"]').on("click", function (n) { n.preventDefault(); var t = $(this).parents(".widget").eq(0), i = $(this).find("i").eq(0), r = "fa-compress", u = "fa-expand"; t.hasClass("maximized") ? (i && i.addClass(u).removeClass(r), t.removeClass("maximized"), t.find(".widget-body").css("height", "auto")) : (i && i.addClass(r).removeClass(u), t.addClass("maximized"), maximize(t)) }); $('.widget-buttons *[data-toggle="collapse"]').on("click", function (n) { n.preventDefault(); var t = $(this).parents(".widget").eq(0), r = t.find(".widget-body"), i = $(this).find("i"), u = "fa-plus", f = "fa-minus", e = 300; t.hasClass("collapsed") ? (i && i.addClass(f).removeClass(u), t.removeClass("collapsed"), r.slideUp(0, function () { r.slideDown(e) })) : (i && i.addClass(u).removeClass(f), r.slideUp(200, function () { t.addClass("collapsed") })) }); $('.widget-buttons *[data-toggle="dispose"]').on("click", function (n) { n.preventDefault(); var i = $(this), t = i.parents(".widget").eq(0); t.hide(300, function () { t.remove() }) }) }
            function maximize(n) { if (n) { var t = $(window).height(), i = n.find(".widget-header").height(); n.find(".widget-body").height(t - i) } } function scrollTo(n, t) { var i = n && n.size() > 0 ? n.offset().top : 0; jQuery("html,body").animate({ scrollTop: i + (t ? t : 0) }, "slow") }
            function hasClass(n, t) { var i = " " + n.className + " ", r = " " + t + " "; return i.indexOf(r) != -1 } var themeprimary = getThemeColorFromCss("themeprimary"), themesecondary = getThemeColorFromCss("themesecondary"), themethirdcolor = getThemeColorFromCss("themethirdcolor"), themefourthcolor = getThemeColorFromCss("themefourthcolor"), themefifthcolor = getThemeColorFromCss("themefifthcolor"), rtlchanger, popovers, hoverpopovers; $("#skin-changer li a").click(function () { createCookie("current-skin", $(this).attr("rel"), 10); window.location.reload() }); rtlchanger = document.getElementById("rtl-changer"); location.pathname != "/index-rtl-fa.html" && location.pathname != "/index-rtl-ar.html" && (readCookie("rtl-support") ? (switchClasses("pull-right", "pull-left"), switchClasses("databox-right", "databox-left"), switchClasses("item-right", "item-left"), $(".navbar-brand small img").attr("src", "assets/img/logo-rtl.png"), rtlchanger != null && (document.getElementById("rtl-changer").checked = !0)) : rtlchanger != null && (rtlchanger.checked = !1), rtlchanger != null && (rtlchanger.onchange = function () { this.checked ? createCookie("rtl-support", "true", 10) : eraseCookie("rtl-support"); setTimeout(function () { window.location.reload() }, 600) })); $(window).load(function () { setTimeout(function () { $(".loading-container").addClass("loading-inactive") }, 0) }); $("#btn-setting").on("click", function () { $(".navbar-account").toggleClass("setting-open") }); $("#fullscreen-toggler").on("click", function () { var n = document.documentElement; $("body").hasClass("full-screen") ? ($("body").removeClass("full-screen"), $("#fullscreen-toggler").removeClass("active"), document.exitFullscreen ? document.exitFullscreen() : document.mozCancelFullScreen ? document.mozCancelFullScreen() : document.webkitExitFullscreen && document.webkitExitFullscreen()) : ($("body").addClass("full-screen"), $("#fullscreen-toggler").addClass("active"), n.requestFullscreen ? n.requestFullscreen() : n.mozRequestFullScreen ? n.mozRequestFullScreen() : n.webkitRequestFullscreen ? n.webkitRequestFullscreen() : n.msRequestFullscreen && n.msRequestFullscreen()) }); popovers = $("[data-toggle=popover]"); $.each(popovers, function () { $(this).popover({ html: !0, template: '<div class="popover ' + $(this).data("class") + '"><div class="arrow"><\/div><h3 class="popover-title ' + $(this).data("titleclass") + '">Popover right<\/h3><div class="popover-content"><\/div><\/div>' }) }); hoverpopovers = $("[data-toggle=popover-hover]"); $.each(hoverpopovers, function () { $(this).popover({ html: !0, template: '<div class="popover ' + $(this).data("class") + '"><div class="arrow"><\/div><h3 class="popover-title ' + $(this).data("titleclass") + '">Popover right<\/h3><div class="popover-content"><\/div><\/div>', trigger: "hover" }) }); $("[data-toggle=tooltip]").tooltip({ html: !0 }); InitiateSettings(); InitiateWidgets();
      </script>
</asp:Content>

