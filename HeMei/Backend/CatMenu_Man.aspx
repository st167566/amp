<%@ Page Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="CatMenu_Man.aspx.cs" Inherits="CatMenu_Man" %>

<%@ Register TagPrefix="UserControl" TagName="CatMenu_Man1" Src="~/Backend/CatMenu_Man1.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .Cat {
            padding-left: 0px;
            padding-bottom: 15px;
            margin-bottom: 20px;
            margin-top: 5px;
            border-bottom: 2px solid #2dc3e8;
        }
        .Cat H3 {
            height: 24px;
            line-height: 24px;
            color: #04377c;
            text-indent: 20px;
            background-image: url(images/vbar_blue.png);
            background-repeat: no-repeat;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- 当前位置 -->
    <asp:Label ID="CategoryIDLabel" runat="server" Text="Label" Visible="false"></asp:Label>
    <asp:Label ID="IDSLabel" runat="server" Text="" Visible="false"></asp:Label>
    <div id="CurrentPosition">当前位置：<a href="CatMenu_Man.aspx">菜单管理</a></div>
    <div class="page-body">
        <div class="row">
            <div class="col-xs-12 col-md-12">
                <div class="widget">
                    <div class="widget-header ">
                        <span class="widget-caption">菜单管理</span>
                    </div>
                    <div class="widget-body">
                        <div style="margin-top: 20px;"></div>
                        <div align="left">
                            <button id="catmenuAdd" type="button" class="btn btn-info">新增一级菜单</button>&nbsp;&nbsp;&nbsp;
                            <button id="submenuAdd" type="button" class="btn btn-info">新增二级菜单</button>&nbsp;&nbsp;&nbsp;
                        </div>

                        <div align="right" style="margin-top:-30px;">
                            <%--  <asp:DropDownList ID="OrderByWeb" runat="server" AutoPostBack="True" OnSelectedIndexChanged="OrderByWeb_SelectedIndexChanged">
                             </asp:DropDownList>--%>
                        </div>
                       
                        <br />
                        <!-- 显示主栏目列表 -->
                        <asp:Panel ID="Panel2" runat="server">
                            <asp:Repeater ID="Repeater1" runat="server">
                                <ItemTemplate>
                                    <div class="Cat">
                                        <h3><a href='CatMenu_Edit.aspx?ID=<%# Eval("ID") %>'><%# Eval("CatMenuName") %></a></h3>
                                        <div style="float: right; margin-top: -30px;margin-bottom:8px; margin-right:29px;" data-id='<%#Eval("ID") %>'>
                                            <a href='CatMenu_Edit.aspx?ID=<%# Eval("ID") %>' class="btn btn-default"><%# Eval("Valid") %></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <a href="#" class="btn btn-info" data-toggle="modal"  data-target="#editCatMenuModal">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <a href="#" class="btn btn-danger" data-toggle="modal" data-target="#delCatMenuModal">删除</a>
                                        </div>
                                        <div>
                                            <UserControl:CatMenu_Man1 ID="UC_Article_List1" runat="server" CatMenuID='<%# Eval("ID") %>' />
                                        </div>
                                        <%--<div style="float: right; height: 30px; line-height: 30px;">
                                            <a href='Cat_Edit.aspx?ID=<%# Eval("ID") %>'></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </div>--%>
                                        <!-- <img src="images/random/H1.jpg" /> -->
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </div>

          <%--添加一级菜单的Modal--%>
        <div class="modal fade" id="addCatMenuModal"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">一级菜单添加</h4>
                    </div>
                    <div class="modal-body" style="padding: 25px 25px 0 25px;">

                  <div class="form-group">
                    <span class="text-primary">菜单名:</span>
                    <span></span>
                    <span class="input-icon icon-right">
                        <input type="text" class="form-control" id="CatMenuName" placeholder="此字段不能为空">
                    </span>
                </div>

                  <div class="form-group">
                    <span class="text-primary">链接：</span>
                    <span></span>
                    <span class="input-icon icon-right">
                        <input type="text" class="form-control" id="href" placeholder="Article_List3.aspx?ID=**">
                    </span>
                </div>


                    <div class="form-group">
                    <span class="text-primary">排序：</span>

                    <input type="text" class="form-control" id="orders" placeholder="数字越小排列越前">
                </div>

                   <div class="form-group">
                    <span class="text-primary">有效性：</span>
<label class="radio-inline">
  <input type="radio" name="Valid" id="true" value="1"> True
</label>
<label class="radio-inline">
  <input type="radio" name="Valid" id="false" value="0"> False
</label>
                </div>

                    </div>
                    <div class="modal-footer" >
                      <input type="button" id="AddCatMenu" class="btn btn-azure" value="确认添加">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>

   <%--修改一级菜单的Modal--%>
        <div class="modal fade" id="editCatMenuModal"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">一级菜单修改</h4>
                    </div>
                    <div class="modal-body" style="padding: 25px 25px 0 25px;">

                  <div class="form-group">
                    <span class="text-primary">菜单名:</span>
                    <span></span>
                    <span class="input-icon icon-right">
                        <input type="text" class="form-control" id="infoCatMenuName" placeholder="此字段不能为空">
                    </span>
                </div>

                  <div class="form-group">
                    <span class="text-primary">链接：</span>
                    <span></span>
                    <span class="input-icon icon-right">
                        <input type="text" class="form-control" id="infohref" placeholder="Article_List3.aspx?ID=**">
                    </span>
                </div>


                    <div class="form-group">
                    <span class="text-primary">排序：</span>

                    <input type="text" class="form-control" id="infoorders" placeholder="数字越小排列越前">
                </div>

                   <div class="form-group">
                    <span class="text-primary">有效性：</span>
<label class="radio-inline">
  <input type="radio" name="infoValid" id="infotrue" value="1"> True
</label>
<label class="radio-inline">
  <input type="radio" name="infoValid" id="infofalse" value="0"> False
</label>
                </div>

                    </div>
                    <div class="modal-footer" >
                      <input type="button" id="editCatMenu" class="btn btn-azure" value="确认修改">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>


        
               <%--删除一级栏目Modal--%>
    <div class="modal fade bs-example-modal-sm" id="delCatMenuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog  modal-sm " role="document" >
            <div class="modal-content" style="margin-top: 15%;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">操作</h4>
                </div>
                <div class="modal-body" style="padding: 25px 25px 0 25px;">
                    <div class="text-center">
                    <span ><strong>您确定要删除此一级菜单吗？一旦删除，它相对应的二级菜单也会被删除哦！</strong></span>
                        <p></p>
                   <input type="button" value="删除" id="delCatMenu" class="btn btn-danger btn-sm" style="margin: 0 5px" data-dismiss="modal"/>
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

         <%--添加二级菜单的Modal--%>
    <div class="modal fade" id="addSubMenuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">二级菜单添加</h4>
                    </div>
                    <div class="modal-body" style="padding: 25px 25px 0 25px;">

                  <div class="form-group">
                    <span class="text-primary">二级菜单名：</span>
                    <span></span>
                    <span class="input-icon icon-right">
                        <input type="text" class="form-control" id="subMenuName" placeholder="此字段不能为空">
                    </span>
                </div>

                  <div class="form-group">
                    <span class="text-primary">链接(URL)：</span>
                    <span></span>
                    <span class="input-icon icon-right">
                        <input type="text" class="form-control" id="subhref" placeholder="Article_List3.aspx?ID=**">
                    </span>
                </div>


                    <div class="form-group">
                    <span class="text-primary">排序：</span>

                   <input class="form-control" placeholder="数字越小越前" id="subOrders" />
                </div>

                   <div class="form-group">
                    <span class="text-primary">有效性：</span>
<label class="radio-inline">
  <input type="radio" name="subValid" id="subtrue" value="1"> True
</label>
<label class="radio-inline">
  <input type="radio" name="subValid" id="subfalse" value="0"> False
</label>
                </div>

            <div class="form-group">
                   <span class="text-primary">所属一级菜单：</span>
                     <select id="submenu">
                                    <option v-for="item in items6" v-bind:value="item.ID">{{item.CatMenuName}}</option>
                      </select>
            </div>

           

                    </div>
                    <div class="modal-footer" >
                       <input type="button" id="AddSubMenu" class="btn btn-azure" value="确认添加" />
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>

    </div>


    
        <script src="assets/js/Menu.js"></script>
</asp:Content>
