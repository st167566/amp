<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="Web_Man.aspx.cs" Inherits="Backend_Web_Man" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <script src="assets/js/vue.js"></script>
      <style type="text/css">
          .img-circle2 {
            width:50px;
            height:50px;
            margin:0 auto;
            border-radius: 50%;
            background-color:#5bc1ef;
        }
            .img-circle2 p {
			 font-weight:bold;
			 font-size:16px;
			 color:white;
			  margin:0 auto;
			  text-align:center;
			  line-height:3;
			   
            }
                [v-cloak] {
            display: none
        }
    </style>
    <div style="padding-right: 50px;" id="box">
        <%--面包屑导航--%>
        <div id="CurrentPosition">当前位置：<a href="#">网站模块</a> >>  <a href="Web_Man.aspx">网站管理</a></div>
        <%--主面板开始--%>
        <div class="page-body"  >
            <div class="row">
                <div class="widget">

                    <div class="widget-header ">
                        <span class="widget-caption">网站管理</span>
                    </div>

                    <div class="widget-body">
                        <div id="Man_Nav" class="col-lg-12">
                            <div class="col-lg-12">
                                <div class="form-group col-lg-9">
                                    <span class="input-icon">
                                        <input id="SearchTB" type="text" placeholder="查询网站" class="form-control input-sm" @input="search" list="words" />
                                        <i class="glyphicon glyphicon-search danger circular"></i>
                                    </span>
                                    <datalist id="words">
                                   <option v-for="item in searchlist" :value="item"></option>
                                   </datalist>
                                </div>
                                <div class="col-lg-3" style="padding: 0">
                                <input type="button" id="czBtn" value="批量操作" class="btn btn-warning" v-show="!batch" v-on:click="batch=true" />
                                <input type="button" id="xzBtn" value="选择操作" data-toggle="modal" data-target="#batch" class="btn btn-warning" v-show="batch" v-on:click="batchselect" />
                                </div>
                            </div>

                            <div class="col-lg-12" style="margin-bottom: 10px;">

                                <div class="col-lg-6">
                                   
                                </div>
                                <div class="col-lg-6" style="text-align: right;">
                                    总共：<span id="Label1" style="color: #5D7B9D; font-weight: bold">{{totalCount}}</span>
                                    条记录，每页显示：<select id="PageSizeDDL" style="font-weight: bold; color: #5D7B9D" v-model="pagesize"  v-on:change="showPage(curPage,$event,true)" number>
                                        <option value="5">5</option>
                                        <option value="10">10</option>
                                        <option value="20">20</option>
                                        <option value="50">50</option>
                                        <option value="100">100</option>
                                        <option value="200">
                                        200<option>
                                    </select>
                                    条记录，共<span id="Label2" style="font-weight: bold; color: #5D7B9D">{{pageCount}}</span>页
                                </div>
                            </div>

                        </div>
                        <div class=" col-lg-12">
                        </div>
                        <br />
                        <table  id="tb" class="table table-bordered table-hover">
                             <thead>
                            <tr class="text-danger">
                                <th class="text-center" v-show="batch">
                                    <input id="Checkbox1" type="checkbox"  value="0"/></th>
                                <th class="text-center" v-show="!batch">序</th>
                                <th class="text-center">网站<i class="glyphicon glyphicon-sort" v-on:click="order('Web',web_order)"></i></th>
                                 <th class="text-center">网站描述</th>
                                <th class="text-center">是否主站<i class="glyphicon glyphicon-sort" v-on:click="order('IsMainSite',ismainsite_order)"></i></th>
                                <th class="text-center">创建时间<i class="glyphicon glyphicon-sort" v-on:click="order('CDT',cdt_order)"></i></th>
                                <th class="text-center">操作</th>
                            </tr>
                                 </thead>
                             <tbody>
                                 <template v-for="(item,index) of items" v-model="items">
                        <tr class="text-center"> 
                             <td v-show="batch">
                                 <input type="checkbox" v-bind:value="item.ID"/>
                             </td>
                            <td v-show="!batch">{{index+1}}</td>
                             <td>{{item.WebName}}</td>
                                 <td>{{item.Description}}</td>
                                <td>{{item.IsMainSite}}</td>
                                <td>{{item.CDT}}</td>
                                <td>
                                     <a href="#" @click="Edit(item)" class="btn btn-info btn-xs"><i class="fa fa-edit"></i>编辑</a>&nbsp;&nbsp;
                                    <a href="#" data-toggle="modal" data-target="#layer" @click="nowIndex=item.ID" class="btn btn-danger btn-xs delete">
                                        <i class="fa fa-trash-o"></i>删除
                                     </a>
                                </td>
                        </tr>
                             </template>
                           
                                   <tr  class="text-center">
                        <td>{{rowtemplate.ID}}</td>
                        <td><input type="text" class="form-control" v-model="rowtemplate.WebName" /></td>
                        <td><input type="text" class="form-control" v-model="rowtemplate.Description" /></td>
                        <td><select class="form-control" v-model="rowtemplate.IsMainSite" id="mainsite">
   　　　　　　　　　　　　　　　　 <option >False</option>
    　　　　　　　　　　　　　　　　<option >True</option>
　　　　　　　　　　　　　　　　</select></td>
                        <td  v-show="time">{{rowtemplate.CDT}}</td>
                        <td><button type="button" class="btn btn-success btn-sm" @click="Save">保存</button></td>
                    </tr>
                       
                                 </tbody>
                        </table>

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


                    </div>
                </div>
            </div>
        </div>

           <%--删除网站Modal--%>
    <div class="modal fade bs-example-modal-sm" id="layer" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog  modal-sm " role="document" >
            <div class="modal-content" style="margin-top: 15%;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">操作</h4>
                </div>
                <div class="modal-body" style="padding: 25px 25px 0 25px;">
                    <div class="text-center">
                    <span ><strong>是否确认删除？</strong></span>
                        <p></p>
                   <input type="button" value="删除" @click="Delete(nowIndex)" class="btn btn-danger btn-sm" style="margin: 0 5px" data-dismiss="modal"/>
                    <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">关闭</button>
                 
               </div>
<div style="margin-top: 18px">
                    </div>
                </div>
                  <div class="modal-footer">
               
                </div>
            </div>
              
        </div>
    </div>


        <%--批量操作网站的Modal--%>
        <div class="modal fade" id="batch" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog " role="document" style="width: 800px;">
            <div class="modal-content" style="margin-top: 15%;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">操作</h4>
                </div>
                <div class="modal-body" style="padding: 25px 25px 0 25px;">
                   <ul>
                     <li style="padding-left:16px;display:inline-block" v-for="(item,index) of chosedata" >
                 
                        <div class="img-circle2">
                  <p>{{item.WebName}}</p> 
                            </div>
                       <a v-on:click="cancel(item.ID)" style="cursor:default">x</a>
                          </li>
                              </ul>
                 
                    <div style="margin-top: 8px">
                    </div>

                </div>
                <div class="modal-footer">
                    <input type="button" value="删除" class="btn btn-warning" style="margin: 0 5px" @click="delAllWeb()" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>


    </div>

   

    <script src="assets/js/Web.js"></script>
  
</asp:Content>

