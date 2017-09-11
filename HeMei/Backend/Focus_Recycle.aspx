<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="Focus_Recycle.aspx.cs" Inherits="Focus_Recycle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="CurrentPosition">当前位置：<a href="Focus_Man.aspx">焦点图管理</a> >> <a href="#">候选焦点图</a></div>
    <div class="page-body">
        <div class="row">
            <div class="col-xs-12 col-md-12">
                <div class="widget">
                    <div class="widget-header ">
                        <span class="widget-caption">焦点图管理</span>
                    </div>
                    <div class="widget-body">
                        <div style="margin-top: 10px;"></div>
                        <div>
                            <asp:Label ID="ID_Label" runat="server" Visible="false" Text="" />
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="ID" AutoGenerateColumns="False" HeaderStyle-Height="24px" class="table table-striped table-bordered table-hover"
                                GridLines="Horizontal" Style="text-align: center;" ForeColor="#333333" HeaderStyle-HorizontalAlign="Center" Width="99%"
                                OnRowCommand="GridView1_RowCommand">
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" Height="30px" HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                                <Columns>
                                    <asp:BoundField DataField="Orders" HeaderText="排序" ItemStyle-Width="30"
                                        Visible="false">
                                        <ItemStyle Width="30px"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="序" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNo" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="30px" HorizontalAlign="center" />
                                        <HeaderStyle Width="30px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="焦点图" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <img src='<%# Eval("PhotoSrc") %>' alt='<%# Eval("LinkURL") %>' width="500" height="150" />
                                        </ItemTemplate>

                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="排序" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:TextBox ID="OrdersTB" runat="server" Text='<%# Eval("Orders") %>' Width="30" BorderWidth="1"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="60px" HorizontalAlign="center" />
                                        <HeaderStyle Width="60px" />
                                    </asp:TemplateField>

                                    <asp:CheckBoxField DataField="Valid" HeaderText="显示" />
                                    <asp:ButtonField ButtonType="Button" CommandName="Edit2" HeaderText="编辑" ShowHeader="True" Text="编辑" ControlStyle-CssClass="btn btn-info" />

                                    <asp:ButtonField ButtonType="Button" CommandName="Del2" HeaderText="删除"
                                        ShowHeader="True" Text="删除" ControlStyle-CssClass="btn btn-danger" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <p>&nbsp;</p>
</asp:Content>

