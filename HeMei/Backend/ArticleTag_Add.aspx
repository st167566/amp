<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="ArticleTag_Add.aspx.cs" Inherits="ArticleTag_Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="TagIDLabel" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Label ID="LabelUserID" runat="server" Visible="false" Text=""></asp:Label>
    <div id="CurrentPosition">当前位置：<a href="Article_Man.aspx">文章管理 </a>>><a href="ArticleTag_Man.aspx">文章标签</a> >> <a href="#">添加标签</a></div>
    <p>&nbsp;</p>
    <div class="row">
        <div class="col-lg-6 col-sm-6 col-xs-12">
            <div class="well with-header">
                <div class="header bordered-blue">添加标签</div>
                <h6>标签名  
                    <asp:Label ID="ErrorLabel" runat="server" Text="" ForeColor="Red"></asp:Label></h6>
                <div>
                    <asp:TextBox ID="TagName" class="form-control" TextMode="MultiLine" Columns="20" Rows="1" placeholder="此字段不能为空" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="/*标签名必填*/" ControlToValidate="TagName"></asp:RequiredFieldValidator>
                </div>
                <hr class="wide" />
                <h6>标签描述</h6>
                <asp:TextBox ID="TagDescription" class="form-control" TextMode="MultiLine" Columns="40" Rows="4" placeholder="关于标签的描述" runat="server"></asp:TextBox>
                <p>
                    <asp:Button ID="Button1" runat="server" class="btn btn-info" Text="添加" Style="margin-left: 5px; margin-top: 2px;" OnClick="Button1_Click" />
                </p>
            </div>
        </div>
    </div>
</asp:Content>

