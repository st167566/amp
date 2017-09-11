<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="Articles_Recyle.aspx.cs" Inherits="Backend_Articles_Recyle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <style>
        .chose {
            background-color:#d73d32;
            color:white!important;
        }
        .chose:focus  {
            background-color:#d73d32;
            color:white!important;
        }
    </style>
    <script type="text/javascript" src="assert/js/vue.js"></script>
    <%--内容页开始--%>
    <div style="padding-right: 50px;" id="box">
        <%--隐藏区域--%>
        <input id="hid_author" type="hidden" />
        <input id="hid_usertag" type="hidden" />
        <input id="hid_starttime" type="hidden" />
        <input id="hid_endtime" type="hidden" />
        <%--面包屑导航--%>
        <div id="CurrentPosition">当前位置：<a href="#">文章模块</a> >>  <a href="Article_Man.aspx">回收站</a></div>
        <%--主面板开始--%>
        <div class="page-body">
            <div class="row">
                <div class="widget">
                    <div class="widget-header">
                        <span class="widget-caption">回收站</span>
                    </div>
                    <div class="widget-body">
                        <div id="Man_Nav" class="col-lg-12">
                            <div class="col-lg-12" style="margin-bottom: 10px; padding: 0;">
                                <span class="form-inline">
                                    <select id="cat" class="form-control" v-model="catselect">
                                        <option value="-1">全部</option>
                                        <option v-for="citem in catitems" v-bind:value="citem.ID">{{citem.CatName}}</option>
                                    </select>
                                </span>
                                <span class="form-inline">
                                    <select id="sub" v-model="subselect" class="form-control" v-if="has">
                                        <option value="-1">全部</option>
                                        <option v-for="sitem in subitems" v-bind:value="sitem.ID">{{sitem.SubName}}</option>
                                    </select>
                                </span>
                                <span class="form-inline">
                                    <select id="pagesize" class="form-control" v-model="pagesize" v-on:change="showPage(curPage,$event,true)" number>
                                        <option value="10">每页显示10条数据</option>
                                        <option value="20">每页显示20条数据</option>
                                        <option value="30">每页显示30条数据</option>
                                        <option value="40">每页显示40条数据</option>
                                    </select>
                                </span>


                                <div class="col-lg-5">
                                    <span class="input-icon">
                                        <input id="SearchTB" placeholder="查询文章" class="form-control input-sm" style="height: 36px; font-size: 14px;" />
                                        <i class="glyphicon glyphicon-search danger circular" style="font-size: 18px; line-height: 1.5"></i>
                                    </span>
                                </div>
                                <input type="button" class="btn btn-info" value="搜索" /> 
                            <input type="button" id="czBtn" value="批量操作" class="btn btn-warning" v-show="!batch" v-on:click="batch=true" />
                            <input type="button" id="xzBtn" value="选择操作" data-toggle="modal" data-target="#layer" class="btn btn-warning" v-show="batch" v-on:click="batch=false" />
                            </div>
                            <div class="col-lg-12">
                                <div class="col-lg-12" style="padding: 5px 20px; border-color: #D1CCC7; border-style: solid dotted; border-width: 1px 1px;">
                                    <strong>文章筛选:</strong>
                                    <div v-for="item in Limiters" v-if="item.Content!=''" class="btn-group" role="group" aria-label="..." style="margin: 0 4px;">
                                        <button type="button" class="btn btn-default"><span>{{item.LimitName}}</span>：<span style="color: red">{{item.Content}}</span></button>
                                    </div>
                                    总共：<span id="Label1" style="color: #5D7B9D; font-weight: bold">{{totalCount}}</span>条记录
                                     <input type="button" onclick="clear_search()" value="清空筛选" />
                                </div>
                            </div>
                            <div class="panel-group col-lg-12" id="accordion" style="padding: 0; margin-bottom: 0;">
                                <div class="panel">

                                    <div id="collapseexample" class="panel-collapse collapse">
                                        <div>
                                            <div class="col-lg-12">
                                                <div id="search_usertag" class="col-lg-12" style="padding: 5px 0; border-color: #D1CCC7; border-style: solid  solid dotted; border-width: 0 1px 1px;">
                                                    <div class="col-lg-1" title="作者标签">
                                                        作者标签
                                                    </div>
                                                    <div class="col-lg-10">
                                                       <button  type="button" class="btn btn-default  chose" style="padding: 5px 15px; margin:0 5px; border:1px solid #d73d32;color:#d73d32;" onclick="chose(this)"><span>全部</span></button>
                                                            <button type="button" class="btn btn-default " v-for="a in usertag" style="padding: 5px 15px;margin:0 5px; border:1px solid #d73d32; color:#d73d32;" onclick="chose(this)"><span>{{a.UserTagName}}</span></button>
                                                        
                                                            
                                                        
                                                    </div>
                                                </div>
                                                <div id="search_author" class="col-lg-12" style="padding: 5px 0; border-color: #D1CCC7; border-style: solid solid dotted; border-width: 0 1px 1px;">
                                                    <div class="col-lg-1" title="作者">
                                                        作者
                                                    </div>
                                                    <div class="col-lg-10">
                                                        <button type="button" class="btn btn-default  chose" style="padding: 5px 15px; margin: 0 5px; border:1px solid #d73d32;color:#d73d32;" onclick="chose(this)"><span>全部</span></button>
                                                        <button type="button"  v-for="a in author" class="btn btn-default" style="padding: 5px 15px; margin: 0 5px;border:1px solid #d73d32;color:#d73d32;" onclick="chose(this)"><span>{{a.Author}}</span></button>
                                                    </div>
                                                </div>
                                                <div  class="col-lg-12" style="padding: 5px 0; border-color: #D1CCC7; border-style: solid solid dotted; border-width: 0 1px 1px;">
                                                    <div class="col-lg-1" title="起始时间">
                                                        起始时间
                                                    </div>
                                                    <div class="col-lg-10">
                                                        <div class="col-lg-3">
                                                            
<div class="input-group date form_date" data-date="" data-date-format="yyyy MM dd" data-link-field="hid_starttime" data-link-format="yyyy-mm-dd" >
                                                            <input class="form-control" id="starttime_chose" size="16" type="text" value="" readonly />
                                                            <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                        </div>
                                                        </div>
                                                        
                                                       <div class="col-lg-1" style="margin:0;padding:0;width:auto;">至</div>
                                                        <div class="col-lg-3">
                                                            
<div class="input-group date form_date" data-date="" data-date-format="yyyy MM dd" data-link-field="hid_endtime" data-link-format="yyyy-mm-dd" >
                                                           <input class="form-control" id="endtime_chose" size="16" type="text" value="" readonly />
                                                           <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                                           <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                       </div>
                                                        </div>
                                                       
                                                    </div>
                                                </div>
                                                <div class="col-lg-12" style="padding: 5px 0; border-color: #D1CCC7; border-style: solid solid dotted; border-width: 0 1px 1px;">
                                                    <button id="True_search" type="button" class="btn btn-default form-control" onclick="true_search()"><span>确认搜索</span></button>
                                                </div>
                                            </div>


                                        </div>
                                    </div>
                                    <center>
<a id="morechose" data-toggle="collapse" data-parent="#accordion" href="#collapseexample"><i class="glyphicon glyphicon-chevron-down"></i><span>展开更多筛选</span><i class="glyphicon glyphicon-chevron-down"></i>
                                    </a>
                                    </center>
                                </div>
                            </div>
                        </div>
                        <div class=" col-lg-12">
                            <div class="col-lg-12">
                                <table id="tb" class="table table-bordered table-hover">
                                    <tr class="text-danger">
                                        <th class="text-center" v-show="batch">
                                            <input id="Checkbox1" value="0" type="checkbox" /></th>
                                        <th class="text-center" v-show="!batch">序</th>
                                        <th class="text-center">标题</th>
                                        <th class="text-center">位置</th>
                                        <th class="text-center">作者</th>
                                        <th class="text-center">有效性</th>
                                        <th class="text-center">最后修改时间</th>
                                        <th class="text-center">点击</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    <tr  class="text-center" v-for="(item,index) in items">
                                        <td v-show="batch">
                                            <input type="checkbox" v-bind:value="item.ID" /></td>
                                        <td v-show="!batch">{{index+1}}</td>
                                        <td><a v-on:click="url(item.ID)">{{item.Title}}</a></td>
                                        <td>{{item.CatName}}/{{item.SubName}}</td>
                                        <td>{{item.Author}}</td>
                                        <td>{{item.Valid}}</td>
                                        <td>{{item.LDT}}</td>
                                        <td>{{item.ViewTimes}}</td>
                                        <td>
                                            <input type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#layer" onclick="operation(this)" value="操作" />
                                        </td>
                                    </tr>
                                </table>
                            </div>

                        </div>


                        <br />
                        <div style="clear: both"></div>
                        <div class="page-header"></div>
                        <div class="pager" id="pager">

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
                        <span v-if="item>=2&&item<=pageCount-1&&item>=showPagesStart&&item<=showPageEnd&&item<=pageCount" class="btn btn-default" v-on:click="showPage(item,$event)">
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
                            <span class="form-inline">
                                <input class="pageIndex form-control" style="width: 60px; text-align: center" type="text" v-model="curPage" v-on:keyup.enter="showPage(curPage,$event,true)" />
                            </span>
                            <span>{{curPage}}/{{pageCount}}</span>
                        </div>

                        <div class="col-lg-6" style="text-align: right;">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--Modal--%>
        <div class="modal fade" id="layer" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">操作</h4>
                    </div>
                    <div class="modal-body" style="padding: 25px 25px 0 25px;">

                        <div class="form-control" style="margin-bottom: 2px;" v-for="c in chosedata">
                            <span>{{c.Title}}</span><a v-on:click="cancel(c.ID)" style="right: 10px; float: right;">x</a>
                        </div>
                        <div v-if="chosedata.length == 0">您暂无选中任何文章</div>
                        <div style="margin-top: 8px">
                        </div>

                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-info" onclick="topArticle()" value="置顶" style="margin: 0 5px" />
                        <input type="button" value="彻底删除" class="btn btn-danger"  data-dismiss="modal" data-toggle="modal" data-target="#movemodel" style="margin: 0 5px" />
                        <input type="button" value="恢复文章" onclick="rescyleArticles()" class="btn btn-success" style="margin: 0 5px" />
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>
         <div class="modal fade" id="movemodel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">彻底删除</h4>
                    </div>
                    <div class="modal-body" style="padding: 25px 25px 0 25px;">
                       <span class="form-inline">
                           <span>您即将彻底删除该文章（不可恢复）请仔细确认</span>
                       </span>
                    </div>
                    <div class="modal-footer">
                        <input type="button" value="确定删除" onclick="deleteArticles()" class="btn btn-danger" style="margin: 0 5px" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="assets/js/Articles_Rescyle_yzt.js" type="text/javascript"></script>
</asp:Content>

