<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="File_Man.aspx.cs" Inherits="Backend_File_Man" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <script type="text/javascript" src="assets/js/vue.js"></script>
    <%--内容页开始--%>
    <div style="padding-right: 50px;" id="box">
        <%--隐藏区域--%>
        <%--面包屑导航--%>
        <div id="CurrentPosition">当前位置：<a href="#">资源模块</a> >>  <a href="File_Man.aspx">资源管理</a></div>
        <%--主面板开始--%>
        <div class="page-body">
            <div class="row">
                <div class="widget">
                    <div class="widget-header">
                        <span class="widget-caption">资源管理</span>
                    </div>
                    <div class="widget-body">
                        <div id="Man_Nav" class="col-lg-12">
                            <div class="col-lg-12" style="margin-bottom: 10px; padding: 0;">
                                <span class="form-inline">
                                    <select id="cat" class="form-control" v-model="catfold">
                                        <option value="-1">全部</option>
                                        <option v-for="citem in catitems" v-bind:value="citem.ID">{{citem.FolderName}}</option>
                                    </select>
                                </span>
                                <span class="form-inline">
                                    <select id="sub" v-model="subfold" class="form-control">
                                        <option value="-1">全部</option>
                                        <option v-for="sitem in subitems" v-bind:value="sitem.ID">{{sitem.FolderName}}</option>
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
                                        <input id="SearchTB" placeholder="查询资源" class="form-control input-sm" style="height: 36px; font-size: 14px;" />
                                        <i class="glyphicon glyphicon-search danger circular" style="font-size: 18px; line-height: 1.5"></i>
                                    </span>
                                </div>
                                <input type="button" class="btn btn-info" value="搜索" /> 
                            <input type="button" id="czBtn" value="批量操作" class="btn btn-warning" v-show="!batch" v-on:click="batch=true" />
                            <input type="button" id="xzBtn" value="选择操作" data-toggle="modal" data-target="#layer" class="btn btn-warning" v-show="batch" v-on:click="batch=false" />
                            <input type="button" class="btn btn-success" value="上传资源" />
                            </div>
                           
                            
                        </div>
                        <div class=" col-lg-12">
                            <div class="col-lg-12">
                                <table id="tb" class="table table-bordered table-hover">
                                    <tr class="text-danger">
                                        <th class="text-center" v-show="batch">
                                            <input id="Checkbox1" value="0" type="checkbox" /></th>
                                        <th class="text-center" v-show="!batch">序</th>
                                        <th class="text-center">资源名称</th>
                                        <th class="text-center">资源路径</th>
                                        <th class="text-center">作者</th>
                                        <th class="text-center">所属文件夹</th>
                                        <th class="text-center">时间</th>
                                        <th class="text-center">大小</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    <tr  class="text-center" v-for="(item,index) in items">
                                        <td v-show="batch">
                                            <input type="checkbox" v-bind:value="item.ID" /></td>
                                        <td v-show="!batch">{{index+1}}</td>
                                        <td>{{item.ResourceName}}</td>
                                        <td>{{item.FilePath}}</td>
                                        <td>{{item.UserName}}</td>
                                        <td>{{item.FolderName}}</td>
                                        <td>{{item.CDT}}</td>
                                        <td>{{item.FileSizeInKB}}</td>
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

                       

                    </div>
                    <div class="modal-footer">
                        <input type="button" value="移动" class="btn btn-warning"  data-dismiss="modal" data-toggle="modal" data-target="#movemodel" style="margin: 0 5px" />
                        <input type="button" value="移至回收站" onclick="deleteArticles()" class="btn btn-danger" style="margin: 0 5px" />
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
                        <h4 class="modal-title">移动</h4>
                    </div>
                    <div class="modal-body" style="padding: 25px 25px 0 25px;">
                       
                    </div>
                    <div class="modal-footer">
                        <input type="button" value="确定移动" class="btn btn-success" style="margin: 0 5px" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="assets/js/File_Man_yzt.js" type="text/javascript"></script>
</asp:Content>


