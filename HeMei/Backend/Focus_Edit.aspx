<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="Focus_Edit.aspx.cs" Inherits="Focus_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="CurrentPosition">当前位置：<a href="Focus_Man.aspx">焦点图管理</a>>><a href="#">编辑焦点图</a></div>
    <center>
        <h1>编辑焦点图</h1>
    </center>
    <p>&nbsp;</p>
    <p style="text-align: center;">
        <asp:Image ID="Image1" Width="800" Height="240" runat="server" AlternateText="" />
    </p>
    <p>&nbsp;</p>
    <p style="text-align: center;">
        链接：<asp:TextBox ID="LinkURLTextBox" runat="server" Width="500"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;
排序：<asp:TextBox ID="OrdersTextBox" runat="server" Width="30"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;
显示：<asp:CheckBox ID="ValidCheckBox" runat="server" Text="显示" />&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="ID_Label" runat="server" Visible="false" Text="" />
        <asp:Button ID="Button2" runat="server" Text="确定" class="btn btn-success" OnClick="Button2_Click" />
    </p>
</asp:Content>