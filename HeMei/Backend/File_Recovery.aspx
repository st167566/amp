<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="File_Recovery.aspx.cs" Inherits="File_Recovery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="IDSLabel" runat="server" Text="" Visible="false"></asp:Label>
    <div id="CurrentPosition">
        当前位置：<a href="File_Recycle.aspx">回收站</a> >> <a href="#">恢复资源</a>
<asp:Label ID="Count" runat="server" Visible="false" ></asp:Label>
<asp:Label ID="ResourceIDS" runat="server"  Visible="false"></asp:Label>
    </div>
    <p>&nbsp;</p>
    <h3>您确定要恢复以下资源吗？</h3>
    <p>&nbsp;</p>
    <div>
        <asp:Button ID="Button3" runat="server" Text="确定恢复"
            class="btn btn-success" OnClick="Button1_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <asp:Button ID="Button4" runat="server" Text="取消返回" class="btn btn-default" OnClick="Button2_Click" />
    </div>
    <p>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="ResultLabel" runat="server" Font-Bold="True" ForeColor="#00CC00"></asp:Label>
    </p>
    <div class="col-lg-11 col-sm-15 col-xs-15">
        <div class="row">
            <div class="col-lg-15">
                <div class="widget">
                    <div class="widget-header ">
                        <span class="widget-caption">恢复资源</span>
                    </div>
                    <!--Widget Header-->
                    <div class="widget-body">
                        <div class="widget-main no-padding">
                            <div id="GridViewDiv">
                                <asp:GridView ID="GridView1" DataKeyNames="FolderID" runat="server" AutoGenerateColumns="False" HeaderStyle-Height="24px" class="table table-striped table-bordered table-hover"
                                    GridLines="Horizontal" Style="text-align: center;" ForeColor="#333333" HeaderStyle-HorizontalAlign="Center" Width="99%">
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" Height="30px" HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="序" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNo" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="30px" HorizontalAlign="center" />
                                            <HeaderStyle Width="30px" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ResourceName" HeaderText="资源名称" ItemStyle-Width="160px" ItemStyle-HorizontalAlign="Left" />
                                        <asp:BoundField DataField="FileType" HeaderText="类型" SortExpression="FileType" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="FileSizeInKB" HeaderText="大小(KB)" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="FolderID" HeaderText="文件夹ID" Visible="false" />
                                        <asp:BoundField DataField="FolderName" HeaderText="原文件夹" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Center" />
                                        <%--<asp:BoundField DataField="FileName" HeaderText="文件名" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Center"   />--%>
                                        <asp:BoundField DataField="UserName" HeaderText="上传用户" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="CDT" HeaderText="上传日期" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Center" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

