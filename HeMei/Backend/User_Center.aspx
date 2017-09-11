<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="User_Center.aspx.cs" Inherits="User_Center" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div style="margin-left:20px;">当前位置：<a href="#">用户中心</a></div>
              <asp:Label ID="UserIDs" runat="server" Text="" Visible="false"></asp:Label>
                            <asp:Label ID="Label5" runat="server" Text="" Visible="false"></asp:Label>
                            <asp:Label ID="Label6" runat="server" Text="" Visible="false"></asp:Label>
                            <asp:Label ID="IsTrueUsers" runat="server" Text="" Visible="false"></asp:Label>
                        <div style="margin-left:150px;margin-top:-20px;">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
         <ContentTemplate>  
      <asp:DropDownList ID="RoleName" runat="server"  Height="30" AutoPostBack="True"  OnSelectedIndexChanged="OrderDDL_SelectedIndexChanged" Visible="false">
                      </asp:DropDownList>
                      </ContentTemplate>
                   </asp:UpdatePanel>
                  <p></p>
             <%--   <uc1:Search_Box runat="server" id="Search_Box" />--%>
                     </div>
                        <div class="page-body" style="padding: 18px 20px 24px;">
                             
                            <div class="row">
                                <div class="col-xs-12 col-md-12">
                                    <div class="widget">
                                        <div class="widget-header ">
                                            <span class="widget-caption">定制您的功能</span>
                                            <div class="widget-buttons compact">
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
                                        <div class="text-primary" style="font-size:20px;font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;text-indent:10px;letter-spacing:3px;"> 欢迎使用Hemei<sup>Tm</sup>——全媒体平台!</div>
                          <h5 class="text-muted" style="text-indent:10px;margin-top:20px;">我们准备了几个链接供您开始：</h5>
                       
                                         <div class="row">
                                             <div class="col-lg-4 col-sm-4 col-xs-10">
                                                 <h4 style="text-indent:10px;">开始使用</h4>
                                                   <asp:HyperLink ID="BackToIndex" runat="server"  target="_blank" class="palegreen" style="margin-left:10px;font-size:15px;margin-top:15px;">
                                                     前台主页
                                                </asp:HyperLink>
                                            
                                              </div>
                                             <div class="col-lg-4 col-sm-4 col-xs-10">
                                                 <div style="text-indent:10px;">
                                                   <h4 >接下来</h4>
                                                 <a href="Article_Add.aspx"><i class="fa fa-pencil-square-o"></i>&nbsp;&nbsp;发表文章</a>
                                                   <p></p>
                                                 <a href="File_Man.aspx"><i class="fa  fa-file"></i>&nbsp;&nbsp;资源管理</a>
                                                      <p></p>
                                                     <asp:PlaceHolder ID="UserMamPanel" runat="server">
                                                 <a href="User_Manage.aspx"><i class="fa   fa-user"></i>&nbsp;&nbsp;用户管理</a>
                                                    </asp:PlaceHolder>
                                                 
                                                     </div>
                                              </div>
                                             <asp:PlaceHolder ID="MorePanel" runat="server">
                                             <div class="col-lg-4 col-sm-4 col-xs-10">
                                                 <div style="text-indent:10px;">
                                                   <h4 >更多操作</h4>
                                                 <a href="User_History.aspx" class="success"><i class="fa  fa-bullhorn"></i>&nbsp;&nbsp;历史记录</a>
                                                   <p></p>
                                                 <a href="Cat_Man.aspx" class="success"><i class="fa  fa-book"></i>&nbsp;&nbsp;分类管理</a>
                                                      <p></p>
                                                 <a href="Focus_Man.aspx" class="success"><i class="fa   fa-picture-o"></i>&nbsp;&nbsp;焦点图管理</a>
                                                 
                                                </div>
                                              </div>
                                                 </asp:PlaceHolder>
                                         </div>
                                          

                                  <h5 class="text-muted" style="text-indent:10px;">工作列表：</h5>
                                    <div class="row">
                                         <div class="col-lg-1 col-sm-1 col-xs-0"></div>
                                                <div class="col-lg-3 col-sm-3 col-xs-12">
                                    <asp:PlaceHolder ID="WaitForAuditPanel" runat="server">
                                        
                                      <a href="Article_Audit.aspx" style="padding-left:10px;">待审核（<asp:Label ID="WaitForAudit" runat="server" Text=""></asp:Label>）</a>
                                           
                                        </asp:PlaceHolder>
                                     
                                         <asp:PlaceHolder ID="WaitForAuditExceptAdminPanel" runat="server">
                                    
                                      <a href="Article_Audit.aspx" style="padding-left:10px;">待审核（<asp:Label ID="WaitForAuditExceptAdmin" runat="server" Text=""></asp:Label>）</a>
                                          
                                        </asp:PlaceHolder>
                                         <br />
                                         <p></p>
                                         
                                      <a href="Article_draft.aspx" style="padding-left:10px;">草稿箱（<asp:Label ID="Draft" runat="server" Text=""></asp:Label>）</a>
                                        <br />
                                        <p></p>   
                                        <asp:PlaceHolder ID="ForPassPanel" runat="server">
                                     
                                      <a href="Article_Recycle.aspx" style="padding-left:10px;">回收站（<asp:Label ID="ForPass" runat="server" Text=""></asp:Label>）</a>
                                     
                                        </asp:PlaceHolder>
                                        <asp:PlaceHolder ID="ForPassExceptAdminPanel" runat="server">
                                   
                                      <a href="Article_Recycle.aspx" style="padding-left:10px;">回收站（<asp:Label ID="ForPassExceptAdmin" runat="server" Text=""></asp:Label>）</a>
                                         
                                            </asp:PlaceHolder>
                                      
                                 </div>
                                            
                                <div class="col-lg-4 col-sm-4 col-xs-10">
                                    <asp:PlaceHolder ID="NewAddRecent7" runat="server">
                                        
                                   <a href="#" style="padding-left:10px;">最近一周新增文章（<asp:Label ID="NewAddRecent7Text" runat="server" Text=""></asp:Label>）</a>
                                           
                                   </asp:PlaceHolder>

                                   <asp:PlaceHolder ID="NewAddRecent7ExceptAdmin" runat="server">
                                        
                                   <a href="#" style="padding-left:10px;">最近一周发表文章（<asp:Label ID="NewAddRecent7ExceptAdminText" runat="server" Text=""></asp:Label>）</a>
                                           
                                   </asp:PlaceHolder>
                                     <br />
                                    <p></p>

                                 <asp:PlaceHolder ID="PassArticle7" runat="server">
                                        
                                   <a href="#" style="padding-left:10px;">最近一周审核通过文章数（<asp:Label ID="PassArticle7Text" runat="server" Text=""></asp:Label>）</a>
                                           
                                  </asp:PlaceHolder>

                                 <asp:PlaceHolder ID="PassArticle7ExceptAdmin" runat="server">
                                        
                                   <a href="#" style="padding-left:10px;">最近一周发表文章数（<asp:Label ID="PassArticle7ExceptAdminText" runat="server" Text=""></asp:Label>）</a>
                                           
                                  </asp:PlaceHolder>
                                    <br />
                                    <p></p>

                                  <asp:PlaceHolder ID="NotPassArticle7" runat="server">
                                        
                                   <a href="#" style="padding-left:10px;">最近一周审核未过文章数（<asp:Label ID="NotPassArticle7Text" runat="server" Text=""></asp:Label>）</a>
                                           
                                  </asp:PlaceHolder>

                                  <asp:PlaceHolder ID="NotPassArticle7ExceptAdmin" runat="server">
                                        
                                   <a href="#" style="padding-left:10px;">最近一周未通过文章数（<asp:Label ID="NotPassArticle7ExceptAdminText" runat="server" Text=""></asp:Label>）</a>
                                           
                                  </asp:PlaceHolder>
                                </div>

                               <div class="col-lg-4 col-sm-4 col-xs-10">
                                   <asp:PlaceHolder ID="MixedPanel" runat="server">
                                 <a href="User_Manage.aspx" style="padding-left:10px;">最近一周新增用户（<asp:Label ID="NewUsers" runat="server" Text=""></asp:Label>）</a>
                                     <br />
                                    <p></p>
                                 <a href="File_Man.aspx" style="padding-left:10px;">最近一周新增资源（<asp:Label ID="NewFiles" runat="server" Text=""></asp:Label>）</a>
                                   <br />
                                    <p></p>
                                 <a href="#" style="padding-left:10px;">最近一周新增评论（<asp:Label ID="NewComments" runat="server" Text=""></asp:Label>）</a>
                                 <br />
                                 <p></p>
                                 <a href="#" style="padding-left:10px;">最近一周点赞数（<asp:Label ID="Label1" runat="server" Text=""></asp:Label>）</a>
                                  </asp:PlaceHolder>
                               </div>
                                         </div>
                               <p></p>

                                    
                                    </div>


                                </div>
                            </div>
                        </div>

                                    
                    <div class="row">
                        <div class="col-lg-6 col-sm-6 col-xs-12">
                             <div class="widget">
                                        <div class="widget-header ">
                                            <span class="widget-caption">概览</span>
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
                                             <div class="row">
                                             <div class="col-lg-4 col-sm-4 col-xs-6">
                                                   <asp:PlaceHolder ID="ALLArctileNumsPanel" runat="server">
                                                  <div>
                                                  <i class="fa fa-pencil-square-o"></i>&nbsp;&nbsp;文章数&nbsp;<a href="Article_Man.aspx"><asp:Label ID="ALLArctileNums" runat="server" Text=""></asp:Label></a>    
                                             
                                                  </div>
                                                   <p></p>
                                                       </asp:PlaceHolder>
                                                  <asp:PlaceHolder ID="ArctileNumsPanel" runat="server">
                                                 <div>
                                                   
                                                  <%--<i class="fa fa-pencil-square-o"></i>&nbsp;&nbsp;发表了<a href="Article_Man.aspx"><asp:Label ID="ArctileNums" runat="server" Text=""></asp:Label></a>篇文章--%>

                                                 </div>
                                                 <p></p>
                                                    <asp:PlaceHolder ID="UserTagNumsPanel" runat="server">
                                                 
                                          <div>
                                              <i class="fa fa-film"></i>&nbsp;&nbsp;资源数&nbsp;<a href="File_Man.aspx"><asp:Label ID="FileNums" runat="server" Text=""></asp:Label></a>
                                             </div>
                                               </asp:PlaceHolder>
                                                 </asp:PlaceHolder>
                                                 
                                             </div>

                                              <div class="col-lg-4 col-sm-4 col-xs-6" style="float:right">
                                                  <asp:PlaceHolder ID="UserNumsPanel" runat="server">
                                                  <div ><i class="fa fa-user"></i>&nbsp;&nbsp;用户数&nbsp;<a href="User_Manage.aspx"><asp:Label ID="UserNums" runat="server" Text=""></asp:Label></a></div>
                                                      <p></p>
                                                           
                                            <div> 
                                     <i class="fa fa-users"></i>&nbsp;&nbsp;用户标签数&nbsp;<a href="Tags_Man.aspx"><asp:Label ID="UserTagNums" runat="server" Text=""></asp:Label></a>         
                                             
                                           </div>
                                                  </asp:PlaceHolder>
                                         
                                                        </div>
                                             </div>
                                            <asp:PlaceHolder ID="Repeater1Panel" runat="server">
                                        <br />
                                       <h4 class="danger" style="text-align:center">最火文章(最近一月)</h4>
                                           <asp:Repeater ID="Repeater1" runat="server">
                                                <HeaderTemplate> <!-- 显示头部 -->
                                                <div style="font-size:16px;">
                                                   <span style="padding-right:50px;">文章标题</span>
                                                    <span style="float:right;padding-right:30px;">点击数</span>
                                                </div>
                                              </HeaderTemplate>
                                <ItemTemplate>
                                        <h6><a href='Article_View.aspx?ID=<%# Eval("ID") %>' target="_blank"><%# Eval("Title") %></a></h6>
                                        <div style="float: right; margin-top: -30px;margin-bottom:8px; margin-right:29px;">
                                            <%# Eval("ViewTimes") %>&nbsp;&nbsp;
                
                                        </div>
                              </ItemTemplate>
                            </asp:Repeater>
                     </asp:PlaceHolder>  
                                            </div>
                                          </div>
                                 </div>

            <div class="col-lg-6 col-sm-6 col-xs-12">
                             <div class="widget">
                                        <div class="widget-header ">
                                            <span class="widget-caption">关于平台</span>
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
      <table class="table table-hover">
        <tr class="active" style="text-align:center;"><td>用户权限</td><td>Administrator</td><td>Editor</td><td>Contributor</td><td>Author</td><td>User</td>
        </tr>
        <tr class="success" style="text-align:center;"><td>用户管理</td><td>Yes</td><td>No</td><td>No</td><td>No</td><td>No</td>
        </tr>
        <tr class="warning" style="text-align:center;"><td>文章管理</td><td>Yes</td><td>Yes</td><td>No</td><td>No</td><td>No</td>
        </tr>
        <tr class="danger" style="text-align:center;"><td>发布作品</td><td>无需</td><td>无需</td><td>无需</td><td>需审核</td><td>需审核</td>
        </tr>
        <tr class="active" style="text-align:center;"><td>作品管理</td><td>不限</td><td>不限</td><td>不限</td><td>限自己</td><td>限自己</td>
        </tr>
    </table>
                                            </div>
                                 </div>
                        </div>

                        </div>
                        

                    </div>
    <script type="text/javascript">
        function InitiateWidgets()
        { $('.widget-buttons *[data-toggle="maximize"]').on("click", function (n) { n.preventDefault(); var t = $(this).parents(".widget").eq(0), i = $(this).find("i").eq(0), r = "fa-compress", u = "fa-expand"; t.hasClass("maximized") ? (i && i.addClass(u).removeClass(r), t.removeClass("maximized"), t.find(".widget-body").css("height", "auto")) : (i && i.addClass(r).removeClass(u), t.addClass("maximized"), maximize(t)) }); $('.widget-buttons *[data-toggle="collapse"]').on("click", function (n) { n.preventDefault(); var t = $(this).parents(".widget").eq(0), r = t.find(".widget-body"), i = $(this).find("i"), u = "fa-plus", f = "fa-minus", e = 300; t.hasClass("collapsed") ? (i && i.addClass(f).removeClass(u), t.removeClass("collapsed"), r.slideUp(0, function () { r.slideDown(e) })) : (i && i.addClass(u).removeClass(f), r.slideUp(200, function () { t.addClass("collapsed") })) }); $('.widget-buttons *[data-toggle="dispose"]').on("click", function (n) { n.preventDefault(); var i = $(this), t = i.parents(".widget").eq(0); t.hide(300, function () { t.remove() }) }) }
        function maximize(n) { if (n) { var t = $(window).height(), i = n.find(".widget-header").height(); n.find(".widget-body").height(t - i) } } function scrollTo(n, t) { var i = n && n.size() > 0 ? n.offset().top : 0; jQuery("html,body").animate({ scrollTop: i + (t ? t : 0) }, "slow") }
        function hasClass(n, t) { var i = " " + n.className + " ", r = " " + t + " "; return i.indexOf(r) != -1 } var themeprimary = getThemeColorFromCss("themeprimary"), themesecondary = getThemeColorFromCss("themesecondary"), themethirdcolor = getThemeColorFromCss("themethirdcolor"), themefourthcolor = getThemeColorFromCss("themefourthcolor"), themefifthcolor = getThemeColorFromCss("themefifthcolor"), rtlchanger, popovers, hoverpopovers; $("#skin-changer li a").click(function () { createCookie("current-skin", $(this).attr("rel"), 10); window.location.reload() }); rtlchanger = document.getElementById("rtl-changer"); location.pathname != "/index-rtl-fa.html" && location.pathname != "/index-rtl-ar.html" && (readCookie("rtl-support") ? (switchClasses("pull-right", "pull-left"), switchClasses("databox-right", "databox-left"), switchClasses("item-right", "item-left"), $(".navbar-brand small img").attr("src", "assets/img/logo-rtl.png"), rtlchanger != null && (document.getElementById("rtl-changer").checked = !0)) : rtlchanger != null && (rtlchanger.checked = !1), rtlchanger != null && (rtlchanger.onchange = function () { this.checked ? createCookie("rtl-support", "true", 10) : eraseCookie("rtl-support"); setTimeout(function () { window.location.reload() }, 600) })); $(window).load(function () { setTimeout(function () { $(".loading-container").addClass("loading-inactive") }, 0) }); $("#btn-setting").on("click", function () { $(".navbar-account").toggleClass("setting-open") }); $("#fullscreen-toggler").on("click", function () { var n = document.documentElement; $("body").hasClass("full-screen") ? ($("body").removeClass("full-screen"), $("#fullscreen-toggler").removeClass("active"), document.exitFullscreen ? document.exitFullscreen() : document.mozCancelFullScreen ? document.mozCancelFullScreen() : document.webkitExitFullscreen && document.webkitExitFullscreen()) : ($("body").addClass("full-screen"), $("#fullscreen-toggler").addClass("active"), n.requestFullscreen ? n.requestFullscreen() : n.mozRequestFullScreen ? n.mozRequestFullScreen() : n.webkitRequestFullscreen ? n.webkitRequestFullscreen() : n.msRequestFullscreen && n.msRequestFullscreen()) }); popovers = $("[data-toggle=popover]"); $.each(popovers, function () { $(this).popover({ html: !0, template: '<div class="popover ' + $(this).data("class") + '"><div class="arrow"><\/div><h3 class="popover-title ' + $(this).data("titleclass") + '">Popover right<\/h3><div class="popover-content"><\/div><\/div>' }) }); hoverpopovers = $("[data-toggle=popover-hover]"); $.each(hoverpopovers, function () { $(this).popover({ html: !0, template: '<div class="popover ' + $(this).data("class") + '"><div class="arrow"><\/div><h3 class="popover-title ' + $(this).data("titleclass") + '">Popover right<\/h3><div class="popover-content"><\/div><\/div>', trigger: "hover" }) }); $("[data-toggle=tooltip]").tooltip({ html: !0 });  InitiateSettings(); InitiateWidgets();
 
    </script>
</asp:Content>

