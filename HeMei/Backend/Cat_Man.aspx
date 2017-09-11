<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="Cat_Man.aspx.cs" Inherits="Cat_Man" %>
<%@ Register TagPrefix="UserControl" TagName="Cat_Man1" Src="~/Backend/Cat_Man1.ascx" %>

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
         [v-cloak] {
            display: none
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- 当前位置 -->
    <asp:Label ID="CategoryIDLabel" runat="server" Text="Label" Visible="false"></asp:Label>
   <input id="web_id"  runat="server" type="hidden"/>
    <asp:Label ID="IDSLabel" runat="server" Text="" Visible="false"></asp:Label>
    <div id="CurrentPosition">当前位置：<a href="Cat_Man.aspx">分类管理</a></div>
    <div class="page-body">
        <div class="row" >
            <div class="col-xs-12 col-md-12">
                <div class="widget">
                    <div class="widget-header ">
                        <span class="widget-caption">分类管理</span>
                    </div>
                    <div class="widget-body">
                        <div style="margin-top: 20px;"></div>
                        <div align="left">
                            <button id="catAdd" type="button" class="btn btn-info">新增一级分类</button>&nbsp;&nbsp;&nbsp;
                            <button id="subAdd" type="button" class="btn btn-info">新增二级分类</button>&nbsp;&nbsp;&nbsp;
                        </div>

                         <div align="right" style="margin-top:-30px;">
                             <%-- <asp:DropDownList ID="OrderByWeb" runat="server" AutoPostBack="True" OnSelectedIndexChanged="OrderByWeb_SelectedIndexChanged">
                             </asp:DropDownList>--%>
                        </div>
                        <!-- 显示主栏目列表 -->
                        <asp:Panel ID="Panel2" runat="server">

<%--     <template id="child">
        <div>
           <table class="table table-bordered table-hover">
                            <tr class="text-danger">
                                <th class="text-center">
                                    <input id="Checkbox1" type="checkbox" /></th>
                                <th class="text-center" v-show="!batch">序</th>
                                <th class="text-center">二级栏目<i class="glyphicon glyphicon-sort" v-on:click="order('Title',title_order)"></i></th>
                                <th class="text-center"></th>
                                <th class="text-center"></th>
                              
                            </tr>
                            <tr class="text-center" >
                                <td>
                                    <input type="checkbox" /></td>
                                <td>{{name}}</td>
                                <td></td>
                                <td>
                             
            <input type="button" value="按钮" v-on:click="change" >
            <strong>{{msg}}</strong>
                                </td>
                            </tr>
                        </table>
        </div>
    </template>         --%>          
<%--<div id="box" >
    
                               <div class="Cat" v-for="item in datas">
                                        <h3><a :href="['Cat_Edit.aspx?ID='+item.ID]">{{item.CatName}}</a></h3>
                                        <div style="float: right; margin-top: -30px;margin-bottom:8px; margin-right:29px;">
                                            <a :href="['Cat_Edit.aspx?ID='+item.ID]" class="btn btn-default">{{item.Valid}}</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <a :href="['Cat_Edit.aspx?ID='+item.ID]" class="btn btn-info">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <a :href="['Cat_Del.aspx?ID='+item.ID]"  class="btn btn-danger">删除</a>
                                        </div>
                                     
                                    <div>
                                         <child-com :msg="item.ID" :name="item.SubName"></child-com>
                                        </div>
                                    </div>
      
</div>--%>
                            <br />
                            <asp:Repeater ID="Repeater1" runat="server" >
                                <ItemTemplate>
                             <div class="Cat">
                                        <h3><a href='#'><%# Eval("CatName") %></a></h3>
                                        <div style="float: right; margin-top: -30px;margin-bottom:8px; margin-right:29px;" data-id='<%#Eval("ID") %>'>
                                            <a href='#' class="btn btn-default"><%# Eval("Valid") %></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <a href='#' class="btn btn-info" data-toggle="modal"  data-target="#editCatModal">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <a href='#' class="btn btn-danger" data-toggle="modal" data-target="#delCatModal">删除</a>
                                        </div>
                                        <div>
                                         <UserControl:Cat_Man1 ID="UC_Article_List1" runat="server" CatID='<%# Eval("ID") %>' />
                                        </div>
                                   
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </asp:Panel>
                    </div>
                </div>

                
         <%--添加一级栏目的Modal--%>
        <div class="modal fade" id="addCatModal"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">栏目添加</h4>
                    </div>
                    <div class="modal-body" style="padding: 25px 25px 0 25px;">

                  <div class="form-group">
                    <span class="text-primary">分类名:</span>
                    <span></span>
                    <span class="input-icon icon-right">
                        <input type="text" class="form-control" id="CatName" placeholder="此字段不能为空">
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
                    <span class="text-primary">分类描述：</span>

                   <textarea class="form-control" rows="3" placeholder="关于你的分类" id="catDescription"></textarea>
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

               <div class="form-group">
                    <span class="text-primary">显示状态：</span>
<label class="radio-inline">
  <input type="radio" name="IsShow" id="article" value="0"> 文章列表
</label>
<label class="radio-inline">
  <input type="radio" name="IsShow" id="show" value="1">作品列表
</label>
                </div>

<%--         <div class="form-group">
                    <span class="text-primary">菜单：</span>
<label class="radio-inline">
  <input type="radio" name="IsAddCatMenu" id="catMenu" value="0"> 一级菜单
</label>
<label class="radio-inline">
  <input type="radio" name="IsAddCatMenu" id="subMenu" value="1">二级菜单
</label>
                             <select class="catmenu" id="isAddCatMenu">
                                    <option v-for="item in items" v-bind:value="item.ID">{{item.CatName}}</option>
                                </select>
       
                </div>--%>
              <asp:Label ID="ErrorLabel" runat="server" Text="" Font-Bold="true" ForeColor="Red" />
                        <div style="margin-bottom:60px"></div>
                    </div>
                    <div class="modal-footer" >
                      <input type="button" id="AddCat" class="btn btn-azure" value="确认添加">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>

         <%--修改一级栏目的Modal--%>
    <div class="modal fade" id="editCatModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document" style="width: 800px;" >
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">栏目修改</h4>
                    </div>
                    <div class="modal-body" style="padding: 25px 25px 0 25px;">

                  <div class="form-group">
                    <span class="text-primary">分类名:</span>
                    <span></span>
                    <span class="input-icon icon-right">
                        <input type="text" class="form-control" id="infoCatName" placeholder="此字段不能为空">
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
                    <span class="text-primary">分类描述：</span>

                   <textarea class="form-control" rows="3" placeholder="关于你的分类" id="catinfoDescription"></textarea>
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

               <div class="form-group">
                    <span class="text-primary">显示状态：</span>
<label class="radio-inline">
  <input type="radio" name="infoIsShow" id="infoarticle" value="0"> 文章列表
</label>
<label class="radio-inline">
  <input type="radio" name="infoIsShow" id="infoshow" value="1">作品列表
</label>
                </div>

<%--         <div class="form-group">
                    <span class="text-primary">菜单：</span>
<label class="radio-inline">
  <input type="radio" name="IsEditCatMenu" id="infocatMenu" value="0"> 一级菜单
</label>
<label class="radio-inline">
  <input type="radio" name="IsEditCatMenu" id="infosubMenu" value="1">二级菜单
</label>

                                <select class="catmenu" id="submenu3">
                                    <option v-for="item in items3" v-bind:value="item.ID">{{item.CatName}}</option>
                                </select>
       
                </div>--%>
           
                    </div>
                    <div class="modal-footer" >
                      <input id="editCat" type="submit" class="btn btn-azure" value="确认修改"/>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>

               <%--删除一级栏目Modal--%>
    <div class="modal fade bs-example-modal-sm" id="delCatModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog  modal-sm " role="document" >
            <div class="modal-content" style="margin-top: 15%;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">操作</h4>
                </div>
                <div class="modal-body" style="padding: 25px 25px 0 25px;">
                    <div class="text-center">
                    <span ><strong>您确定要删除此一级分类吗？一旦删除，它相对应的二级分类也会被删除哦！</strong></span>
                        <p></p>
                   <input type="button" value="删除" id="delCat" class="btn btn-danger btn-sm" style="margin: 0 5px" data-dismiss="modal"/>
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


     <%--添加二级栏目的Modal--%>
    <div class="modal fade" id="addSubModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">二级栏目添加</h4>
                    </div>
                    <div class="modal-body" style="padding: 25px 25px 0 25px;">

                  <div class="form-group">
                    <span class="text-primary">分类名：</span>
                    <span></span>
                    <span class="input-icon icon-right">
                        <input type="text" class="form-control" id="subName" placeholder="此字段不能为空">
                    </span>
                </div>

                  <div class="form-group">
                    <span class="text-primary">链接：</span>
                    <span></span>
                    <span class="input-icon icon-right">
                        <input type="text" class="form-control" id="subhref" placeholder="Article_List3.aspx?ID=**">
                    </span>
                </div>


                    <div class="form-group">
                    <span class="text-primary">分类描述：</span>

                   <textarea class="form-control" rows="3" placeholder="关于你的分类" id="subDescription"></textarea>
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
                   <span class="text-primary">所属分类：</span>
                     <select id="submenu">
                                    <option v-for="item in items6" v-bind:value="item.ID">{{item.CatName}}</option>
                      </select>
            </div>

       <%--  <div class="form-group">
                    <span class="text-primary">菜单：</span>
<label class="radio-inline">
  <input type="radio" name="IsAddSubMenu" id="catMenu1" value="0"> 一级菜单
</label>
<label class="radio-inline">
  <input type="radio" name="IsAddSubMenu" id="subMenu1" value="1">二级菜单
</label>
                              <select class="catmenu" id="submenu2">
                                    <option v-for="item in items2" v-bind:value="item.ID">{{item.CatName}}</option>
                                </select>
  </div>--%>
           

                    </div>
                    <div class="modal-footer" >
                       <input type="button" id="AddSub" class="btn btn-azure" value="确认添加" />
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>


            </div>
        </div>
    </div>

<script src="assets/js/Cat.js"></script>
</asp:Content>
