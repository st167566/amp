<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WebCatMan.ascx.cs" Inherits="Backend_WebCatMan" %>
<%@ Register TagPrefix="UserControl" TagName="Cat_Man1" Src="~/Backend/Cat_Man1.ascx" %>
    <div class="Cat">
          <asp:Repeater ID="Repeater1" runat="server">
                                <ItemTemplate>
                                        <h3><a href='Cat_Edit.aspx?ID=<%# Eval("ID") %>'><%# Eval("CatName") %></a></h3>
                                        <div style="float: right; margin-top: -30px;margin-bottom:8px; margin-right:29px;">
                                            <a href='Cat_Edit.aspx?ID=<%# Eval("ID") %>' class="btn btn-default"><%# Eval("Valid") %></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <a href='Cat_Edit.aspx?ID=<%# Eval("ID") %>' class="btn btn-info">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <a href='Cat_Del.aspx?ID=<%# Eval("ID") %>' class="btn btn-danger">删除</a>
                                        </div>
                                        <div>
                                            <UserControl:Cat_Man1 ID="UC_Article_List1" runat="server" CatID='<%# Eval("ID") %>' />
                                        </div>
                                  
                                </ItemTemplate>
                            </asp:Repeater>
    </div>
