<%@ Page Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="File_Edit.aspx.cs" Inherits="File_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        input[type="radio"] {
            border: none;
        }

        input[type="radio"] + label {
            margin-right: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="LabelResourceID" runat="server" Visible="false" Text=""></asp:Label>
    <div id="CurrentPosition">当前位置：<a href="File_Man.aspx">资源管理</a> >> <a href="#">编辑媒体</a></div>
    <p>&nbsp;</p>
    <div class="row">
        <div class="col-lg-8 col-sm-8 col-xs-12">
            <div class="well with-header  with-footer">
                <div class="header bordered-blue">媒体信息</div>
                <div class="form-group">
                    <div id="RightContent">
                        <center>
                            <table width="760" align="center" class="MyTable" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td colspan="3"></td>
                                </tr>
                                <tr>
                                    <td>预览图：</td>
                                    <td colspan="3"  align="left">
                                        <%--<asp:TextBox ID="TextBox1" runat="server" MaxLength="30" Width="300" CssClass="TextBox"></asp:TextBox>--%>
                                        <asp:Image ID="Image1" Width="300" runat="server" AlternateText=""/>
                                    </td>
                                    <%--<td width="200" align="left">&nbsp;</td>--%>
                                </tr>
                                <tr>
                                    <td width="180">&nbsp;</td>
                                    <td align="left" colspan="2">
                                        <asp:Label ID="ErrorLabel" runat="server" Text="" Font-Bold="true" ForeColor="Red"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>资源名：</td>
                                    <td width="300" align="left">
                                        <asp:TextBox ID="ResourceName" runat="server"
                                            MaxLength="30" Width="300" CssClass="TextBox"></asp:TextBox></td>
                                    <td width="200" align="left">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td align="left" colspan="2">
                                        <div id="div4" style="font-size: 12px; color: #999;">请输入新的资源名</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="140">文件夹：</td>
                                    <td width="300" align="left">
                                        <asp:DropDownList ID="FolderDDL" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td width="200" align="left">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td align="left" colspan="2">
                                        <div id="div3" style="font-size: 12px; color: #999;">请选择目标文件夹</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>类型：</td>
                                    <td width="200" align="left">
                                        <asp:Label ID="FileType" runat="server" Text="Label"></asp:Label></td>
                                    <td width="260" align="left">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>大小(KB)：</td>
                                    <td width="200" align="left">
                                        <asp:Label ID="FileSizeInKB" runat="server" Text="Label"></asp:Label>
                                    </td>
                                    <td width="260" align="left">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>上传用户：</td>
                                    <td width="200" align="left">
                                        <asp:Label ID="UserName" runat="server" Text="Label"></asp:Label>
                                        <asp:Label ID="UserID" runat="server" Text="Label" Visible="false" ></asp:Label>
                                    </td>
                                    <td width="260" align="left">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>上传日期：</td>
                                    <td width="200" align="left">
                                        <asp:Label ID="CreateDateTime" runat="server" Text="Label"></asp:Label>
                                    </td>
                                    <td width="260" align="left">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="3">&nbsp;</td>
                                </tr>

                                <tr>
                                    <td>&nbsp;</td>
                                    <td width="200" align="left">
                                        <br />
                                        <asp:Button ID="Button1" runat="server" Text=" 确定修改 " class="btn btn-success"
                                            OnClick="Button1_Click" /></td>

                                    <td width="260" align="left">
                                        <br />
                                        <asp:Button ID="Button2" runat="server" Text=" 删除资源 " class="btn btn-warning"
                                            OnClick="Button2_Click" OnClientClick="return confirm('确定删除资源吗？');" />
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
