<%@ Page Title="" Language="C#" MasterPageFile="~/Front.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- header-section-ends-here -->
    <div class="banner">
		<img src="images/img1.jpeg" alt="" />
		<div class="headline text-center">
		    <h4>全媒体平台的创行者</h4>			  
		</div>
	</div>    
    <!-- header-section-ends-here -->

    <div class="wp-wrapper wp-container list-container">
    <div class="wp-inner clearfix">
        <div class="menu">
            <div class="column-head">关于我们</div>
            <ul class="column-list-wrap" >
                <li class="column-item column-1">
                    <a class="column-item-link" href="About.aspx" title="公司简介">
                    <span class="column-name">公司简介</span>
                    </a>
                </li>
                <li class="column-item column-2 ">
                    <a class="column-item-link " href="Members.aspx" title="团队成员">
                    <span class="column-name">团队成员</span>
                    </a>
                </li>
                <li class="column-item column-3 ">
                    <a class="column-item-link " href="Contact.aspx" title="加入我们">
                    <span class="column-name">加入我们</span>
                    </a>
                </li>
                <li class="column-item column-4 selected">
                    <a class="column-item-link selected" href="#" title="联系我们">
                    <span class="column-name">联系我们</span>
                    </a>
                </li>
            </ul>
        </div>
        <div class="wp-column-news">
            <div class="column-news-box">
                <div class="list-head">
                    <div class="list-meta clearfix">
                        <h2 class="column-title">联系我们</h2>
                    <div class="column-path">
                        <span class="path-name">当前位置：</span>
                        <a href="/main.htm" target="_self">首页</a>
                        <i class="fa fa-angle-right"></i>
                        <a href="#" target="_self">关于我们</a>
                        <span class="possplit">  </span>
                        <i class="fa fa-angle-right"></i>
                        <a href="/3642/list.htm" target="_self">联系我们</a>
                    </div>
                </div>
            </div>
            <div class="contact-us">
                <h3>广州禾美软件有限公司</h3>
                <p>地址：广东省广州市白云区雅苑1街5号</p>
                <p>邮编：510000</p>
                <p>公众号：禾美软件</p>
                <p>Email：164630238@qq.com</p>
                <p>公司网址：www.hemei.in</p>
            </div>
        </div>
        </div>
    </div>
    </div>
</asp:Content>

