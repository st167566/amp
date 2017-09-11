<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="Article_Preview.aspx.cs" Inherits="Article_View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section class="article-view">
        <div class="wrap2">       
            <div class="row">
                <div class="col-md-8">
                    <div class="list-head">
                        <div class="list-meta clearfix">
                            <div class="column-path" style="float:left;">
                                <span class="path-name">当前位置：</span>
                                <a href="index.aspx" target="_self">网站首页</a>
                                <i class="fa fa-angle-right"></i>
                                <a href="#" id="catname" runat="server" target="_self">文章预览</a>
                            </div>
                            <div style="clear:both"></div>
                            <div class="article-title">
                                <h3 runat="server" id="ArticleTitle">文章题目</h3>
                                <div class="article-detail">
                                    作者：<span id="Username1" runat="server">栗子</span>
                                    <span>|</span>
                                    日期：<span id="CDT" runat="server">2017-07-26</span>
                                    <span>|</span>
                                    浏览：<span>0</span>
                                </div>
                               <div runat="server" id="ArticleContent">

                               </div>
                            </div>
                            <div class="video-part" style="padding-bottom: 20px;">
                                <div class="video-info">
                                    <h3 class="video-comment">评论</h3>  
                                    <textarea class="form-control" placeholder="Message" required=""></textarea>  
                                    <button class="btn btn-primary">发送</button>                       
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4" style="margin-top: 40px;">
                    <div class="relate-video">
                        <div class="video-headline">
                            <h4>相关文章</h4>
                        </div>
                        <div class="video-rank">
                            <div>
                                <a href="#"><span><i class="fa fa-caret-right"></i>排行详情排行详情排行详情排行详情</span></a>
                                <span class="pic-author">author</span>
                            </div> 
                            <div>
                                <a href="#"><span><i class="fa fa-caret-right"></i>排行详情排行详情排行详情排行详情</span></a>
                                <span class="pic-author">author</span>
                            </div>
                            <div>
                                <a href="#"><span><i class="fa fa-caret-right"></i>排行详情排行详情排行详情排行详情</span></a>
                                <span class="pic-author">author</span>
                            </div>
                            <div>
                                <a href="#"><span><i class="fa fa-caret-right"></i>排行详情排行详情排行详情排行详情</span></a>
                                <span class="pic-author">author</span>
                            </div>
                            <div>
                                <a href="#"><span><i class="fa fa-caret-right"></i>排行详情排行详情排行详情排行详情</span></a>
                                <span class="pic-author">author</span>
                            </div>
                        <div>
                    </div>
                    </div>
                    </div>
                  
                    <div class="relate-video">
                        <div class="video-headline">
                            <h4>热门点击</h4>
                        </div>
                        <div class="video-rank">
                            <div>
                                <a href="#"><span><i class="fa fa-caret-right"></i>排行详情排行详情排行详情排行详情排行详情</span></a>
                            </div>   
                            <div>
                                <a href="#"><span><i class="fa fa-caret-right"></i>排行详情排行详情排行详情排行详情排行详情</span></a>
                            </div>
                            <div>
                                <a href="#"><span><i class="fa fa-caret-right"></i>排行详情排行详情排行详情排行详情排行详情</span></a>
                            </div>
                            <div>
                                <a href="#"><span><i class="fa fa-caret-right"></i>排行详情排行详情排行详情排行详情排行详情</span></a>
                            </div>
                            <div>
                                <a href="#"><span><i class="fa fa-caret-right"></i>排行详情排行详情排行详情排行详情排行详情</span></a>
                            </div>                                   
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

