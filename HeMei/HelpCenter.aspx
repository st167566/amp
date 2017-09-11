<%@ Page Title="" Language="C#" MasterPageFile="~/Front.master" AutoEventWireup="true" CodeFile="HelpCenter.aspx.cs" Inherits="HelpCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section class="help-center">
        <div class="wrap2">       
            <div class="row">
                <div class="col-md-3">
                    <div class="my-box" style="margin-top: 40px;">
                        <a class="article-left" href="#">                                           
                            <h4><i class="fa fa-link"></i>&nbsp;&nbsp;帮助中心</h4>
                        </a>
                        <div class="my-box-content">
                            <p><i class="fa fa-caret-right"></i>&nbsp;<a href="#">反馈通道</a></p>
                            <p><i class="fa fa-caret-right"></i>&nbsp;<a href="#">在线客服</a></p>                        
                        </div>                                              
                    </div> 
                    <div class="my-box box-img">
                        <img src="images/img9.jpeg" />
                    </div>
                    <div class="my-box">
                        <a class="article-left" href="#">                                           
                            <h4><i class="fa fa-desktop"></i>&nbsp;&nbsp;全媒体平台</h4>
                        </a>
                        <div class="my-box-content">
                            <p>全媒体平台是第一个同时提供手机、 平板、电脑、电视、微信、APP六大媒体终端解决方案的管理平台。</p> 
                            <p style="text-align: right;"><a href="Product_View.aspx">更多>></a></p>               
                        </div>                                              
                    </div>
                    <div class="my-box box-img">
                        <img src="images/banner.jpg" />
                    </div>
                    <div class="my-box">
                        <a class="article-left" href="#">                                           
                            <h4><i class="fa fa-windows"></i>&nbsp;&nbsp;网站群系统</h4>
                        </a>
                        <div class="my-box-content">
                            <p>网站群是统一规划建设的若干个能够相互共享信息、按照一定的隶属关系组织在一起，既可以统一管理，也可以独立管理自成体系的网站集合。</p> 
                            <p style="text-align: right;"><a href="WebsiteGroup.aspx">更多>></a></p>               
                        </div>                                              
                    </div>
                    <div class="my-box box-img">
                        <img src="images/img8.jpeg" />
                    </div>               
                    <div class="my-box" style="margin-bottom: 40px;">
                        <a class="article-left" href="#">                                           
                            <h4><i class="fa fa-phone"></i>&nbsp;&nbsp;联系我们</h4>
                        </a>
                        <div class="my-box-content">
                            <p class="strong">广州禾美软件有限公司</p>
                            <p>地址：广东省广州市白云区雅苑1街5号</p>
                            <p>邮编：510000</p>
                            <p>公众号：锐赛思</p>
                            <%--<p>Email：164630238@qq.com</p>--%>
                        </div>                                              
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

