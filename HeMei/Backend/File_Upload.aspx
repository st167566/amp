<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="File_Upload.aspx.cs" Inherits="File_Upload" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

      <link rel="stylesheet" type="text/css" href="webuploader/style.css" />
    <link rel="stylesheet" type="text/css" href="webuploader/webuploader.css" />
    <script type="text/javascript" src="webuploader/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="webuploader/webuploader.js"></script>
    <script type="text/javascript" src="webuploader/ImagUpload2.js"></script>
    <script type="text/javascript">
        $().ready(function () {
        });
    </script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">                    
        <div id="CurrentPosition">
            当前位置：<a href="File_Man.aspx">资源管理</a> >> <a href="#">上传资源</a>
        </div>
        <p>&nbsp;</p>
        <div class="row">

            <div class="col-lg-8 col-sm-8 col-xs-12">
                <div class="well with-header  with-footer">
                    <div class="header bordered-blue">上传资源</div>
                    <div class="form-group">
                        <div>

                                    <p>
                                        1、选择要上传的文件。合法的文件包括：音频、视频、图片、文档、压缩、Flash等。
                                    </p>
                                        <div id="wrapper">
                                            <div id="container">
                                                <!--头部，相册选择和格式选择-->

                                                <div id="uploader">
                                                    <div class="queueList">
                                                        <div id="dndArea" class="placeholder">
                                                            <div id="filePicker"></div>
                                                            <p>或将文件拖到这里，单次最多可选50个文件</p >
                                                        </div>
                                                    </div>
                                                    <div class="statusBar" style="display: none;">
                                                        <div class="progress">
                                                            <span class="text">0%</span>
                                                            <span class="percentage"></span>
                                                        </div>
                                                        <div class="info"></div>
                                                        <div class="btns">
                                                            <div id="filePicker2"></div>
                                                            <div class="uploadBtn">开始上传</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                    <div>
                                        &nbsp;&nbsp;&nbsp;
                                        <asp:Label ID="FET" runat="server" Text="Label" Visible="false"></asp:Label>
                                        <asp:Label ID="FS" runat="server" Text="Label" Visible="false"></asp:Label>
                                        <asp:Label ID="FN" runat="server" Text="Label" Visible="false"></asp:Label>
                                        <asp:Label ID="FP" runat="server" Text="Label" Visible="false"></asp:Label>
                                        <asp:Label ID="ResourceTypeLabel" runat="server" Text="" Visible="false"></asp:Label>
                                    </div>

                                    <%--<p>2、对资源重命名</p>
                                    <p><small>&nbsp;&nbsp;&nbsp;输入有意义的名字，方便日后对资源的查找和管理</small></p>--%>
                                    <%--<p id="IMG">
        <asp:Image ID="Image1" runat="server" />
    </p> --%>
                                    <%--<div>
                                        &nbsp;&nbsp;&nbsp;--%>
        <asp:TextBox ID="TextBox1" runat="server" Width="280px" Visible="false" ></asp:TextBox>
                                    <%--&nbsp; 
                                    </div>--%>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <p>2、选择保存的目录</p>
                                    <div>
                                        &nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="FolderDDL" runat="server" AutoPostBack="True" OnSelectedIndexChanged="FolderDDL_SelectedIndexChanged">
        </asp:DropDownList>
                                        &nbsp;&nbsp;&nbsp;
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                                    <%--<p>3、选择资源的类型</p>
    <p><small>对于图片和视频资源，请选择他们对应的版本</small></p>
    <div>
        <asp:RadioButtonList ID="RadioButtonList1" runat="server" 
            RepeatDirection="Horizontal" RepeatLayout="Flow">
            <asp:ListItem Selected="True">电脑</asp:ListItem>
            <asp:ListItem>手机</asp:ListItem>
        </asp:RadioButtonList>
    </div>--%>

                                    <p>
                                        &nbsp;
                                    </p>
                                    <div>
                                        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" Text="确定保存" class="btn btn-info" OnClick="Button1_Click" />
                                        &nbsp;&nbsp;<asp:Button ID="Abolish" runat="server" Text="取消" class="btn btn-default" Visible="false" />
                                    </div>

                                                
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
