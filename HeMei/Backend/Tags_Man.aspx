<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="Tags_Man.aspx.cs" Inherits="Tags_Man" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
          [v-cloak] {
            display: none
        }
    </style>
     <input id="web_id" type="hidden" runat="server" />
       <input id="role_id" type="hidden" runat="server" />
    <div id="CurrentPosition">当前位置：<a href="Tags_Man.aspx">标签管理</a></div>
    <div class="page-body" id="box" v-cloak>
        <div class="row">
            <div class="col-xs-12 col-md-12">
                <div class="widget">
                    <div class="widget-header ">
                        <span class="widget-caption">标签管理</span>

                    </div>
                    <div class="widget-body">


                        <div class="form-group col-xs-9 col-md-9">
                            <span class="input-icon">
                                <input type="text" id="SearchTB" placeholder="查询标签名" class="form-control input-sm" @input="search" list="words" />
                                <i class="glyphicon glyphicon-search danger circular"></i>
                           </span>
                              <datalist id="words">
                                   <option v-for="item in searchlist" :value="item"></option>
                               </datalist>
                      </div>
  <button id="addTag" type="button" class="btn btn-info login" @click="add" data-toggle="modal" data-target="#addTagModal">添加标签</button>&nbsp;&nbsp;&nbsp;&nbsp;

                        <div>
     <div class="col-lg-12" style="margin-bottom: 10px;">
            <div class="col-lg-6">
                      <%--  <select v-model="webselected" id="webselect" >
                               <option v-for="item in webs" v-bind:value="item.ID">{{item.WebName}}</option>
                               </select>     --%>       
                                </div>
         <div class="col-lg-6" style="text-align: right;">
                                    总共：<span id="Label1" style="color: #5D7B9D; font-weight: bold">{{totalCount}}</span>
                                    条记录，每页显示：<select id="PageSizeDDL" style="font-weight: bold; color: #5D7B9D" v-model="pagesize"  v-on:change="showPage(curPage,$event,true)" number>
                                        <option value="5">5</option>
                                        <option value="10">10</option>
                                        <option value="20">20</option>
                                        <option value="50">50</option>
                                    </select>
                                    条记录，共<span id="Label2" style="font-weight: bold; color: #5D7B9D">{{pageCount}}</span>页
                                </div>
      </div>                                
     
        
                            <br />

                            <div id="margin">

                                <table class="table table-bordered table-hover">
                             <thead>
                            <tr class="text-danger">
                                <th class="text-center" v-show="batch">
                                    <input id="Checkbox1" type="checkbox" /></th>
                                <th class="text-center" v-show="!batch">序</th>
                                <th class="text-center">标签名<i class="glyphicon glyphicon-sort" v-on:click="order('Web',web_order)"></i></th>
                                 <th class="text-center">标签描述</th>
                                <th class="text-center">标签用户数<i class="glyphicon glyphicon-sort" v-on:click="order('IsMainSite',ismainsite_order)"></i></th>
                                <th class="text-center">操作</th>
                            </tr>
                                 </thead>
                             <tbody>
                                 <template v-for="(item,index) of items" v-model="items">
                        <tr class="text-center"> 
                             <td v-show="batch">
                                 <input type="checkbox" />
                             </td>
                            <td v-show="!batch">{{index+1}}</td>
                             <td>
                                 <a href="#" data-toggle="modal" data-target="#TagUserModal"  @click="showTagUser(item.ID,index)">{{item.TagName}}</a>

                             </td>
                                 <td>{{item.Description}}</td>
                                <td >{{item.Users}}</td>
                                <td>
                                   <a href="javascript:;" data-toggle="modal" data-target="#addTagModal"  @click="showOverlay(index)" class="btn btn-info btn-xs">
                                        <i class="fa fa-edit"></i>编辑</a>&nbsp;&nbsp;
                                    <a href="#" data-toggle="modal" data-target="#del" @click="nowIndex=item.ID" class="btn btn-danger btn-xs delete">
                                        <i class="fa fa-trash-o"></i>删除</a>
                                </td>
                        </tr>
                             </template>
                       
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

                <model :list='selectedlist' :isactive="isActive" v-cloak @change="changeOverlay" @modify="modify"></model>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>


          <%--查看标签用户的Modal--%>
        <div class="modal fade" id="TagUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">标签用户</h4>
                    </div>
                    <div class="modal-body"  style="max-height: 250px; overflow-y: scroll; padding-left:5%; padding-top:10px;">
                          <ul>
                     <li style="padding-left:16px;display:inline-block" v-for="(item,index) of tagUsers" >
                        <%-- :src="item.Avatar" --%>
                          <img alt='' src="assets/img/timg.jpg" style="border-radius: 50%; width: 60px; height: 40px; vertical-align: middle;" />
                         <br />
                          <span class="text-center" style="margin-left:6px">{{item.UserName}}</span>
                         <input type="checkbox" :value="item.ID"  name="tagUsers"/>
                          </li>
                              </ul>
                    </div>
                    <div class="modal-footer">
                         <button type="button" class="btn btn-info" data-toggle="modal" data-target="#AddUserModal" @click="filterData"/ >增加</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal" @click="delTagUser(selected)"/ >删除</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>

        
          <%--增加标签用户的Modal--%>
        <div class="modal fade" id="AddUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">网站用户</h4>
                    </div>
                    <div class="modal-body"  style="max-height: 250px; overflow-y: scroll; padding-left:5%; padding-top:10px;">
                            <div class="row"> <div class="col-lg-6">
    <div class="input-group">
      <input type="text" class="form-control" placeholder="Search for..." @input="searchUser" list="words"/>
      <span class="input-group-btn">
        <button class="btn btn-default" type="button">Go!</button>
      </span>
         <datalist id="words">
           <option v-for="item in searchlist" :value="item"></option>
           </datalist>
    </div>
  </div>
                                </div>
                        <br />
                        <div class="row">
                          <ul>
                                <template v-for="(item,index) of webUsers" v-model="webUsers">
                     <li style="padding-left:16px;display:inline-block"  >
                        <%-- :src="item.Avatar" --%>
                          <img alt='' src="assets/img/timg.jpg" style="border-radius: 50%; width: 60px; height: 40px; vertical-align: middle;" />
                         <br />
                          <span class="text-center" style="margin-left:6px">{{item.UserName}}</span>
                         <input type="checkbox" :value="item.ID"  name="webUsers"/>
                          </li>
                              </template>
                              </ul>
                            </div>
                    </div>
                    <div class="modal-footer">
                         <button type="button" class="btn btn-info" data-toggle="modal" data-target="#AddUserModal" @click="addTagUser(selected)"/ >增加</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>
        <%--单个删除标签的Modal--%>
        <div class="modal fade bs-example-modal-sm" id="del" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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



    </div>
       <script src="assets/js/TagMan.js"></script>
    <script>
     
    </script>
</asp:Content>

