<%@ Page Title="" Language="C#" MasterPageFile="~/Front.master" AutoEventWireup="true" CodeFile="Article_List.aspx.cs" Inherits="Article_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="article-list">
        <div class="wrap2">
            <div class="row">
                <div class="col-md-3">
                    <div class="my-box" style="margin-top: 40px">
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
                        <img src="images/img7.jpeg" />
                    </div>
                    <div class="my-box">
                        <a class="article-left" href="#">
                            <h4><i class="fa fa-link"></i>&nbsp;&nbsp;成功案例</h4>
                        </a>
                        <div class="my-box-content">
                            <p><i class="fa fa-caret-right"></i>&nbsp;<a href="#">教育科学与技术学院</a></p>
                            <p><i class="fa fa-caret-right"></i>&nbsp;<a href="#">多维度精神康复评估系统</a></p>
                            <p><i class="fa fa-caret-right"></i>&nbsp;<a href="#">Resys</a></p>
                            <p><i class="fa fa-caret-right"></i>&nbsp;<a href="#">广东顺德现代职业教育研究院</a></p>
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
                    <div class="body-head" id="box">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="CurrentPosition text-left" id="CurrentPosition">
                                    当前位置：<a href="../index.aspx">网站首页</a> > <a href="../WebSite/Research.aspx">新闻资讯</a>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="searchTextBox text-right">
                                    <input type="text" style="width: 175px;" />
                                    <input class="submit" value="搜索" type="submit" />
                                </div>
                            </div>
                        </div>
                        <div class="part-header" style="margin-top: 10px;">
                            <h3><a style="color: #FF5240;" href="#">行业资讯</a></h3>
                            <div style="float: right; height: 30px; line-height: 0px;"><a href="#">更多 >> </a></div>
                        </div>
                        <div class="part-content">
                            <div class="row" v-for="item in items">
                                <div>
                                    <div class="col-md-3">
                                        <a href="#">
                                            <img class="img-responsive" v-bind:src="item.CoverImageURL" /></a>
                                    </div>
                                    <div class="col-md-9">
                                        <div class="article-headline">
                                            <h3><a v-on:click="url(item.ID)">{{item.Title}}</a></h3>
                                            <p>{{item.Summary}}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="container body-content">
                            <div id="test" class="form-group">
                                <div class="form-group">
                                    <div class="pager" id="pager">
                                        <span class="form-inline">
                                            <select class="form-control" style="display:none;" v-model="pagesize" v-on:change="showPage(curPage,$event,true)" number>
                                                <option value="5">5</option>
                                                <option value="10">10</option>
                                                <option value="30">30</option>
                                                <option value="40">40</option>
                                            </select>
                                        </span>
                                        <template v-for="item in pageCount+1">
                        <span v-if="item==1" class="btn btn-default" v-on:click="showPage(1,$event)">
                            首页
                        </span>
                        <span v-if="item==1" class="btn btn-default" v-on:click="showPage(curPage-1,$event)">
                            上一页
                        </span>
                        <span v-if="item==1" class="btn btn-default" v-on:click="showPage(item,$event)">
                            {{item}}
                        </span>
                        <span v-if="item==1&&item<=showPagesStart-2" class="btn btn-default disabled">
                            ...
                        </span>
                        <span v-if="item>1&&item<=pageCount-1&&item>=showPagesStart&&item<=showPageEnd&&item<=pageCount" class="btn btn-default" v-on:click="showPage(item,$event)">
                            {{item}}
                        </span>
                        <span v-if="item==pageCount&&item>showPageEnd+1" class="btn btn-default disabled">
                            ...
                        </span>
                        <span v-if="item==pageCount" class="btn btn-default" v-on:click="showPage(item,$event)">
                            {{item}}
                        </span>
                        <span v-if="item==pageCount" class="btn btn-default" v-on:click="showPage(curPage+1,$event)">
                            下一页
                        </span>
                        <span v-if="item==pageCount" class="btn btn-default" v-on:click="showPage(pageCount,$event)">
                            尾页
                        </span>
                    </template>
                                      
                                        <span>{{curPage}}/{{pageCount}}</span>
                                    </div>
                                </div>
                            </div>
                            <hr />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/vue.js"></script>
    <script>
        var nv1 = new Vue({
            el: "#box",
            data: {
                //总项目数
                totalCount: 200,
                //分页数
                pageCount: 20,
                //当前页面
                curPage: 1,
                //分页大小
                pagesize: 5,
                //显示分页按钮数
                showPages: 11,
                //开始显示的分页按钮
                showPagesStart: 1,
                //结束显示的分页按钮
                showPageEnd: 100,
                //分页数据
                items: [],
                datas: []
            },
            created: function () {
                //加载数据items
                var a = "";
                $.ajax({
                    type: "get",
                    url: "Article_List_WebService.asmx/InitArticleList",
                    async: false,  //同步，既做完才往下
                    success: function (str) { a = $(str).find("string").text(); }
                });
                var json = eval('(' + a + ')');
                this.datas = json;
                this.items = json;
                var jlengtjh = 0;
                for (var i in json) { jlengtjh++; }
                this.totalCount = jlengtjh//总项目数
                this.pageCount = parseInt(this.totalCount / this.pagesize) + 1; //分页数
            },
            methods: {
                //分页方法
                showPage: function (pageIndex, $event, forceRefresh) {
                    if (pageIndex > 0) {


                        if (pageIndex > this.pageCount) {
                            pageIndex = this.pageCount;
                        }

                        //判断数据是否需要更新
                        var currentPageCount = Math.ceil(this.totalCount / this.pagesize);
                        if (currentPageCount != this.pageCount) {
                            pageIndex = 1;
                            this.pageCount = currentPageCount;
                        }
                        else if (this.curPage == pageIndex && currentPageCount == this.pageCount && typeof (forceRefresh) == "undefined") {
                            console.log("not refresh");
                            return;
                        }

                        //处理分页点中样式
                        var buttons = $("#pager").find("span");
                        for (var i = 0; i < buttons.length; i++) {
                            if (buttons.eq(i).html() != pageIndex) {
                                buttons.eq(i).removeClass("active");
                            }
                            else {
                                buttons.eq(i).addClass("active");
                            }
                        }
                        this.curPage = pageIndex;
                        //测试数据 随机生成的
                        var newPageInfo = [];
                        for (var i = 0; i < this.pagesize; i++) {
                            var j = (this.curPage - 1) * this.pagesize + i;
                            if (this.datas[j]) {
                                newPageInfo.push(this.datas[j]);
                            }
                        }
                        this.items = newPageInfo;

                        //计算分页按钮数据
                        if (this.pageCount > this.showPages) {
                            if (pageIndex <= (this.showPages - 1) / 2) {
                                this.showPagesStart = 1;
                                this.showPageEnd = this.showPages - 1;
                                console.log("showPage1")
                            }
                            else if (pageIndex >= this.pageCount - (this.showPages - 3) / 2) {
                                this.showPagesStart = this.pageCount - this.showPages + 2;
                                this.showPageEnd = this.pageCount;
                                console.log("showPage2")
                            }
                            else {
                                console.log("showPage3")
                                this.showPagesStart = pageIndex - (this.showPages - 3) / 2;
                                this.showPageEnd = pageIndex + (this.showPages - 3) / 2;
                            }
                        }
                        console.log("showPagesStart:" + this.showPagesStart + ",showPageEnd:" + this.showPageEnd + ",pageIndex:" + pageIndex);
                    }

                },
                url: function (ID) {
                    window.location.href = "Article_View.aspx?ID=" + ID;
                }
            }
        })
        nv1.showPage(nv1.curPage, null, true);
       
    </script>



</asp:Content>

