<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="Focus_Man.aspx.cs" Inherits="Focus_Man" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
       [v-cloak] {
            display: none
        }
        </style>
     <input type="file" id="fileElem" runat="server" style="display: none;" />
    <input id="web_id" type="hidden" runat="server" />
     <input id="role_id" type="hidden" runat="server" />
    <div id="CurrentPosition">当前位置：<a href="#">焦点图管理</a></div>
    <div class="page-body" id="box" v-cloak>
        <div class="row">
            <div class="col-xs-12 col-md-12">
                <div class="widget">
                    <div class="widget-header ">
                        <span class="widget-caption">焦点图管理</span>
                    </div>
                    <div class="widget-body">
                        <div style="margin-top: 20px;"></div>
                        <div>
                             <button  id="OrdersBtn" type="button" class="btn btn-success">更改排序</button>&nbsp;&nbsp;&nbsp;&nbsp;
                            <button  id="upload" type="button" class="btn btn-info">上传焦点图</button>

                          <%--   <div align="right" style="margin-top:-30px;">
                              <select v-model="webselected" id="webselect" >
                               <option v-for="item in webs" v-bind:value="item.ID">{{item.WebName}}</option>
                               </select>
                        </div>--%>
                        </div>
                        <div>
                            <p>&nbsp;</p>
                            <asp:Label ID="ID_Label" runat="server" Visible="false" Text="" />

                            <table class="table table-bordered table-hover">
                             <thead>
                            <tr class="text-danger">
                                <th class="text-center" v-show="batch">
                                    <input id="Checkbox1" type="checkbox" /></th>
                                <th class="text-center" v-show="!batch">序</th>
                                <th class="text-center">焦点图</th>
                                <th class="text-center">排序</th>
                                 <th class="text-center">显示</th>
                                <th class="text-center">操作</th>
                            </tr>
                                 </thead>
                             <tbody id="tb">
                                 <template v-for="(item,index) of items" v-model="items">
                        <tr class="text-center" > 
                             <td v-show="batch">
                                 <input type="checkbox" />
                             </td>
                            <td v-show="!batch"  ><input type="hidden" v-model="item.ID"  :val="item.ID" id="idval">{{index+1}}</td>
                                 <td>  <img class="img-responsive" :src="item.Thumbnail" alt="缩略图" /></td>
                                <td><input type="text"  v-model="item.Orders" :val="item.Orders" style="width:20px"></td>
                              <td><input type="checkbox"  v-model="item.Valid" ></td>
                                <td>
                                   <a href="javascript:;" data-toggle="modal" data-target="#layer" class="btn btn-info btn-xs" @click="showOverlay(index)" >
                                        <i class="fa fa-edit"></i>编辑</a>&nbsp;&nbsp;
                                    <a href="#" data-toggle="modal" data-target="#del" @click="nowIndex=item.ID" class="btn btn-danger btn-xs delete">
                                         <i class="fa fa-trash-o"></i>删除</a>
                                </td>
                        </tr>
                             </template>
                           
                                 </tbody>
                        </table>
  <model :list='selectedlist' :isactive="isActive" v-cloak @change="changeOverlay" @modify="modify"></model>

                        </div>
                    </div>
                </div>
            </div>
        </div>

          <%--删除焦点图的Modal--%>
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

           <%--上传焦点图的Modal--%>
        <div class="modal fade" id="FocuPhotoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">焦点图设置</h4>
                    </div>
                    <div class="modal-body" style="padding: 15px 25px;">
                         <p>
                        最佳图片的大小为1000*300像素，允许上传的图片格式为：.jpg,.png,.gif。
                    </p>
                        <center><img id="FocusPhoto" runat="server" style="width: 600px; height: 180px; margin-right: 15px;" src="assets/img/img1.jpeg" /></center>
                        <button type="button" id="fileSelect" class="btn btn-info col-lg-12" style="padding: 10px 0px; margin-top: 20px;">上传焦点图片</button>
                        <div style="clear: both;"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <p>&nbsp;</p>

    <script src="assets/js/Focuses.js"></script>
    <script>


    </script>
    <script src="assets/js/ajaxfileupload.js"></script>
    <script>
        $("#upload").click(function () {
            $("#FocuPhotoModal").modal("show");
        });
          /*上传焦点图的Script*/
        function link() {
            document.getElementById("<%=fileElem.ClientID %>").click();
            var fileElem = document.getElementById("<%=fileElem.ClientID %>");
            fileElem.addEventListener("change", uploadfunction, false);
        };
          function uploadfunction() {
            $.ajaxFileUpload({
                url: 'UpLoadFile.ashx',
                secureuri: false,
                fileElementId: '<%=fileElem.ClientID %>',
                dataType: 'text',
                data: { "project_id": "", "UploadType": "FocuPhoto" },
                success: function (data) {
                    $('#coverphotourl_input').val(data);
                    document.getElementById("<%=FocusPhoto.ClientID %>").src = window.URL.createObjectURL(document.getElementById("<%=fileElem.ClientID %>").files[0]);
                }
            });
          };
        (function ($) {
            var fileSelect = document.getElementById("fileSelect");
            fileSelect.addEventListener("click", link, false);
            $('#overphotourl_input').val("~/Backend/assets/images/29J58PICf2x_1024.jpg");
        })(jQuery);
    </script>

</asp:Content>

