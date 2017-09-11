<%@ Control Language="C#" AutoEventWireup="true" CodeFile="File_DelTrueAR.ascx.cs" Inherits="File_DelTrueAR" %>

<style type="text/css">
    .margin {
        padding-right: 5px;
    }
</style>
<asp:GridView ID="GridView1" runat="server" DataKeyNames="ID" AutoGenerateColumns="false" class="table table-striped table-bordered table-hover"
    GridLines="Horizontal" Style="text-align: center;" ForeColor="#333333" HeaderStyle-HorizontalAlign="Center" Width="99%">
    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" Height="30px" HorizontalAlign="Center" />
    <HeaderStyle HorizontalAlign="Center" />
    <Columns>
        <asp:BoundField DataField="Orders" HeaderText="排序" ItemStyle-Width="30" Visible="false" />
        <asp:HyperLinkField DataNavigateUrlFields="ID"
            DataNavigateUrlFormatString="Article_View.aspx?ID={0}" DataTextField="Title"
            HeaderText="标题" ItemStyle-Width="350" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" Target="_blank"></asp:HyperLinkField>
        <asp:BoundField DataField="SubName" HeaderText="二级分类" ItemStyle-Width="60" />
        <asp:BoundField DataField="Author" HeaderText="作者" ItemStyle-Width="40" />
        <asp:BoundField DataField="LDT" HeaderText=" 日期 " DataFormatString="{0:yy-MM-dd}" ItemStyle-Width="80" />
    </Columns>
</asp:GridView>
