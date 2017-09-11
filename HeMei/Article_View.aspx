<%@ Page Title="" Language="C#" MasterPageFile="~/Front.master" AutoEventWireup="true" CodeFile="Article_View.aspx.cs" Inherits="Article_View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section class="article-view">
        <div class="wrap2">       
            <div class="row">
                <div class="col-md-3">
                    <div class="my-box">
                        <a class="article-left" href="#">                                           
                            <h4><i class="fa fa-info-circle"></i>&nbsp;&nbsp;新闻资讯</h4>
                        </a>
                        <div class="my-box-content">
                            <p><i class="fa fa-caret-right"></i>&nbsp;<a href="#">公司新闻</a></p>
                            <p><i class="fa fa-caret-right"></i>&nbsp;<a href="#">行业资讯</a></p>                        
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
                <div class="col-md-9">
                    <div class="list-head1">
                        <div class="list-meta clearfix">
                            <div class="column-path">
                                <span class="path-name">当前位置：</span>
                                <a href="index.aspx" target="_self">网站首页</a>
                                <i class="fa fa-angle-right"></i>
                                <a href="#" target="_self" id="view_cat" runat="server">公司资讯</a>
                            </div>
                            <div class="article-title">
                                <h3 id="view_title" runat="server">全媒体平台将全面升级</h3>
                                <div class="article-detail">
                                    作者：<span id="view_author" runat="server">栗子</span>
                                    <span>|</span>
                                    日期：<span id="view_CDT" runat="server">2017-08-06</span>
                                    <span>|</span>
                                    浏览：<span id="view_read" runat="server">194</span>
                                </div>
                                <div id="view_connent" runat="server">

                                </div>

                                <div class="video-share" style="margin-top: 20px; float: right;">                                                                                  
                                    <%--<span class="zan" id="thumbs-down"><i class="fa fa-comment"></i>&nbsp;2</span>--%>   
                                    <span class="zan" id="thumbs-up"><i class="fa fa-thumbs-up"></i>&nbsp;12</span>                                                            
                                </div>
                            </div>
                        </div>
                        </div>               
                    </div>
                </div>
                
            </div>
        </div>
    </section>
</asp:Content>

