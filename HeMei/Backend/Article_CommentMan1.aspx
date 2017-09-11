<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="Article_CommentMan1.aspx.cs" Inherits="Article_CommentMan1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="IDSLabel" runat="server" Text="" Visible="false"></asp:Label>
    <div id="CurrentPosition">
        当前位置：<a href="Article_Add.aspx">文章模块</a> >> <a href="#">评论管理</a>
    </div>
   
            <p>&nbsp;</p>    <asp:Label ID="Count" runat="server" Visible="false" ></asp:Label><asp:Label ID="ArticleIDS" runat="server" Visible="false" ></asp:Label>
            <h4 style="color: red">请慎重操作删除评论，一旦删除，将不可恢复！</h4>
            <p>&nbsp;</p>
            <div class="col-lg-11 col-sm-15 col-xs-15">
                <asp:Button ID="Button1" runat="server" Text="删除留言"  class="btn btn-danger" OnClick="Button1_Click1" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button2" runat="server" Text="返回"  class="btn btn-info" OnClick="Button2_Click" />

                  <div align="right" style="margin-top:-30px;">
                              <asp:DropDownList ID="OrderByWeb" runat="server" AutoPostBack="True" OnSelectedIndexChanged="OrderByWeb_SelectedIndexChanged">
                             </asp:DropDownList>
                        </div>
            </div>
            <p>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="ResultLabel" runat="server" Font-Bold="True" ForeColor="#00CC00"></asp:Label>
            </p>
     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="col-lg-11 col-sm-15 col-xs-15">
                <div class="row">
                    <div class="col-lg-15">
                        <div class="widget">
                            <div class="widget-header ">
                                <span class="widget-caption">删除留言</span>
                            </div>
                            <!--Widget Header-->
                            <div class="widget-body">
                                <div class="widget-main no-padding">
                                    <div id="RightContent">
                                        <asp:GridView ID="GridView1" runat="server" DataKeyNames="ID" AutoGenerateColumns="False" HeaderStyle-Height="24px" class="table table-striped table-bordered table-hover"
                                            GridLines="Horizontal" Style="text-align: center;" ForeColor="#333333" HeaderStyle-HorizontalAlign="Center" Width="99%">
                                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" Height="30px" HorizontalAlign="Center" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="序" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblNo" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="30px" HorizontalAlign="center" />
                                                </asp:TemplateField>
                                                 <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="ChechBox1" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle Width="15px" HorizontalAlign="center" />
                                            </asp:TemplateField>
                                                <asp:BoundField DataField="Comment" HeaderText="留言内容" ItemStyle-Width="200" ItemStyle-HorizontalAlign="left" ></asp:BoundField>
                                                <asp:BoundField DataField="PublisherName" HeaderText="留言者" ItemStyle-Width="60" ItemStyle-HorizontalAlign="left" />
                                                <asp:BoundField DataField="PublishTime" HeaderText="时间" ItemStyle-Width="60" ItemStyle-HorizontalAlign="left"/>
                                                <asp:BoundField DataField="ArticleTitle" HeaderText="文章标题" ItemStyle-Width="60" ItemStyle-HorizontalAlign="left"/>
                                                <asp:BoundField DataField="SubName" HeaderText="二级分类" ItemStyle-Width="60" ItemStyle-HorizontalAlign="left"/>
                                                <asp:BoundField DataField="Visible" HeaderText="可见" ItemStyle-Width="30" ItemStyle-HorizontalAlign="left"/>
                                            </Columns>
                                        </asp:GridView>
                                        <br />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

