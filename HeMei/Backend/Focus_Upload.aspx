<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="Focus_Upload.aspx.cs" Inherits="Focus_Upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="CurrentPosition">当前位置：<a href="Focus_Man.aspx">焦点图管理</a>>><a href="#">上传焦点图</a></div>
    <p>&nbsp;</p>
    <div class="row">
        <div class="col-lg-6 col-sm-6 col-xs-12">
            <div class="well with-header  with-footer">
                <div class="header bordered-blue">上传焦点图</div>
                <div class="form-group">
                    <p>
                        最佳图片的大小为1000*300像素，允许上传的图片格式为：<asp:Label ID="ExtensionLabel" runat="server" Text="Label"></asp:Label>。
                    </p>
                    <p>&nbsp;</p>
                    <p>
                        <asp:Label ID="ResultLabel" runat="server" Visible="false" Text="Label"></asp:Label>
                    </p>
                    <p style="text-align: center;">

                        <asp:FileUpload ID="FileUpload1" runat="server" Width="600px" />
                        <p>&nbsp;</p>
                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" class="btn btn-info" Text="上传图片" />
                    </p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

