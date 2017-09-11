<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CatMenu_Man1.ascx.cs" Inherits="CatMenu_Man1" %>
<style type="text/css">
    .margin {
        padding-right: 5px;
    }
</style>
<table class="table table-bordered table-hover">
                             <thead>
                            <tr class="text-danger">
                                <th class="text-center">序</th>
                                <th class="text-center">二级菜单</th>
                                 <th class="text-center">有效性</th>
                                <th class="text-center"></th>
                            </tr>
                                 </thead>
    <asp:Repeater ID="SubRepeater" runat="server" >
                                <ItemTemplate>
                             <tbody>
                        <tr class="text-center" > 
                            <td><%# Container.ItemIndex+1 %></td>
                             <td><%# Eval("SubMenuName") %></td>
                                 <td><%# Eval("Valid") %></td>
                                <td style="width:250px">
                                     <a href="#"  data-toggle="modal"  data-target="#editSubMenuModal" class="btn btn-info btn-xs"><i class="fa fa-edit"></i>编辑</a>&nbsp;&nbsp;
                                    <input type="hidden" data-id='<%#Eval("ID") %>'>
                                    <a href="#"  data-toggle="modal" data-target="#delSubMenuModal" class="btn btn-danger btn-xs delete">
                                        <i class="fa fa-trash-o"></i>删除
                                     </a>
                                </td>
                        </tr>
                       
                                 </tbody>
       </ItemTemplate>
     </asp:Repeater>
                        </table>


<%--修改二级栏目的Modal--%>
<div class="modal fade" id="editSubMenuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">二级菜单修改</h4>
                    </div>
                    <div class="modal-body" style="padding: 25px 25px 0 25px;">

                  <div class="form-group">
                    <span class="text-primary">二级菜单名：</span>
                    <span></span>
                    <span class="input-icon icon-right">
                        <input type="text" class="form-control" id="subinfoName" placeholder="此字段不能为空">
                    </span>
                </div>

                  <div class="form-group">
                    <span class="text-primary">链接：</span>
                    <span></span>
                    <span class="input-icon icon-right">
                        <input type="text" class="form-control" id="subinfohref" placeholder="Article_List3.aspx?ID=**">
                    </span>
                </div>


                    <div class="form-group">
                    <span class="text-primary">排序：</span>

                   <input class="form-control"  placeholder="数字越小，排列越前" id="subinfoOrders" />
                </div>

                   <div class="form-group">
                    <span class="text-primary">有效性：</span>
<label class="radio-inline">
  <input type="radio" name="subinfoValid" id="subtrue" value="1"> True
</label>
<label class="radio-inline">
  <input type="radio" name="subinfoValid" id="subfalse" value="0"> False
</label>
                </div>

            <div class="form-group">
                   <span class="text-primary">所属菜单：</span>
                     <select id="submenu4">
                                    <option v-for="item in items4" v-bind:value="item.ID">{{item.CatMenuName}}</option>
                      </select>
            </div>

                    </div>
                    <div class="modal-footer" >
                     <input id="editSubMenu" type="submit" class="btn btn-azure" value="确认修改"/>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>


  <%--删除二级栏目Modal--%>
    <div class="modal fade bs-example-modal-sm" id="delSubMenuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog  modal-sm " role="document" >
            <div class="modal-content" style="margin-top: 15%;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">操作</h4>
                </div>
                <div class="modal-body" style="padding: 25px 25px 0 25px;">
                    <div class="text-center">
                    <span ><strong>您确定要删除此二级菜单吗？一旦删除，操作不可撤销！</strong></span>
                        <p></p>
                   <input type="button" value="删除" id="delSubMenu" class="btn btn-danger btn-sm" style="margin: 0 5px" data-dismiss="modal"/>
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



