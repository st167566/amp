<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="Articles_Add.aspx.cs" Inherits="Articles_Add2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        body {
            padding-right: 0 !important;
        }

        #publishing_location_check {
            font-size: 12px;
        }

        .smallbtn {
            width: 30px;
            height: 30px;
            text-align: center;
            padding: 6px 0;
            font-size: 12px;
            line-height: 18px;
            border-radius: 15px;
            margin-right: 10px;
        }

        .btn-new {
            width: 100%;
            border-radius: 5px;
            padding: 10px 0;
        }

        button.list-group-item:hover {
            background-color: rgba(187, 186, 186, 0.60);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="stylesheet" type="text/css" href="webuploader/style.css" />
    <link rel="stylesheet" type="text/css" href="webuploader/webuploader.css" />
    <script type="text/javascript" src="ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="assets/js/vue.js"></script>
   <script type="text/javascript">
       var fileUrl = "<%= RandomIDCD %>";
       CKEDITOR.plugins.add('timestamp', {
           icons: 'timestamp',
           init: function (editor) {
               //Plugin logic goes here.
               editor.addCommand('insertTimestamp', {
                   exec: function showMyDialog(e) {
                       var str = 'width=980,height=650,left=' + ((screen.width - 900) / 2) + ',top=' + ((screen.height - 650) / 2) + ',scrollbars=no,scrolling=no,location=no,toolbar=no'
                       var w = window.open('File_Browse2.aspx?ID=' + fileUrl + '', 'MyWindow', str);
                   }
               });
               editor.ui.addButton('Timestamp', {
                   label: '插入资源',
                   command: 'insertTimestamp',
                   toolbar: 'insert'
               });
           }
       });
    </script>
    <%--隐藏的控件--%>
    <input type="file" id="fileElem" runat="server" style="display: none;" />
    <input id="article_id" type="hidden" runat="server" />
    <input id="Cat_check" type="hidden" />
    <input id="Sub_check" type="hidden" />
    <input id="tagstext" type="hidden" runat="server" />
    <input id="coverphotourl_input" value="assets/img/29J58PICf2x_1024.jpg" type="hidden" />
    <input id="randomid" type="hidden" value="<%= RandomIDCD%>" />
    <%--内容页开始--%>
    <div style="padding-right: 150px;">
        <%--面包屑导航--%>
        <div class="container" style="margin-left: 15px; margin-bottom: 15px;">
            <div class="row">
                <div class="span6">
                    当前位置：
                <ul class="breadcrumb">
                    <li>
                        <a href="#">Home</a> <span class="divider">></span>
                    </li>
                    <li>
                        <a href="#">文章管理</a> <span class="divider">></span>
                    </li>
                    <li class="active" ><a href="#">添加文章</a></li>
                </ul>
                </div>
            </div>
        </div>
        <%--主面板--%>
        <div class="panel panel-primary" style="padding-top: 10px;">
            <div class="panel-body">
                <%--左侧主体--%>
                <div class="col-lg-10" style="padding-right: 0;">
                    <div class="form-group">
                        <div class="col-lg-2" style="line-height: 2.8; text-align: right;">
                            <span>文章标题：</span>
                        </div>
                        <div class="col-lg-10" style="padding-right: 3%;">
                            <input type="text" id="article_title" class="form-control" style="color: #999999; resize: none;" value="在此输入文章标题" onfocus="if(value=='在此输入文章标题'){value='';this.style.color='#000'}" onblur="if(!value){value='在此输入文章标题';this.style.color='#999'}" />
                        </div>
                    </div>
                    <div style="clear: both; height: 5px;"></div>
                    <div class="form-group">
                        <label class="control-label col-lg-2" style="line-height: 2.8; text-align: right;">文章分类：</label>
                        <div id="Select" class="col-lg-9" style="line-height: 2.8;">
                            <select id="cat" v-model="selected">
                                <option v-for="item in items" v-bind:value="item.ID">{{item.CatName}}</option>
                            </select>
                            <select id="sub" v-if="has" v-model="sub_selected">
                                <option v-for="sub_item in sub_items" v-bind:value="sub_item.ID">{{sub_item.SubName}}</option>
                            </select>
                        </div>
                    </div>
                    <div style="clear: both; height: 5px;"></div>
                    <div class="form-group">
                        <div class="col-lg-2" style="text-align: right; line-height: 2.5;">
                            <span>文章附件：</span>
                        </div>
                        <div class="col-lg-10">
                            <input type="button" id="Link_Button" value="+ 添加附件" style="line-height: 2.8; background-color: rgba(255, 255, 255, 0.00); color: #0f85dd" />
                            <div id="Enclosure" style="font-size: 12px;">
                                 <input id="enclosures_id" v-model="message" type="hidden" class="form-control" />
                                <div v-for="item in items" style="background-color: rgba(250, 226, 226, 0.75); width: 98%;"><input type="hidden" v-bind:value="item.fileurl" /><i class="glyphicon glyphicon-paperclip"></i><span><a>{{item.filename}}</a>(15.2K)</span><a v-on:click="del_file(item)">删除</a></div>
                            </div>
                        </div>
                    </div>
                    <div style="clear: both; height: 5px;"></div>
                    <style>
                        #Enclosure span {
                            margin: 0 12px 0 12px;
                        }

                        #Enclosure a:hover {
                            cursor: pointer;
                        }
                    </style>
                    <div class="form-group" style="padding: 0 3%;">
                        <textarea id="Editor1" runat="server" style="resize: none;"></textarea>
                        <script type="text/javascript">
                            var editor = CKEDITOR.replace('<%=Editor1.ClientID%>', { height: "200px" });
                        </script>
                    </div>
                </div>
                <%--右侧属性--%>
                <div class="col-lg-2" style="padding: 0 5px 0 0;">
                    <div>
                        <h1 style="font-size: 20px; margin: 10px 0 10px 0; padding-left: 10px; font-weight: bolder;">更多属性</h1>
                    </div>
                    <div class="list-group">
                        <button id="summarysetting_btn" type="button" class="list-group-item">文章摘要</button>
                        <button id="publishsetting_btn" type="button" class="list-group-item">发布设置</button>
                        <button id="keywordsetting_btn" type="button" class="list-group-item">标签设置</button>
                        <button id="coverphotosetting_btn" type="button" class="list-group-item">封面图设置</button>
                        <%--<button type="button" class="list-group-item">其他设置</button>--%>
                    </div>

                    <div style="clear: both; height: 35px;"></div>
                    <div>
                        <input id="preview_btn" type="button" class="btn btn-sky btn-new" value="预览" />
                    </div>
                    <div style="clear: both; height: 10px;"></div>
                    <div>
                        <button id="draft_btn" class="btn btn-warning btn-new" type="button">保存为草稿</button>
                    </div>
                    <div style="clear: both; height: 10px;"></div>
                    <div>
                        <button id="publish_btn" class="btn btn-success btn-new" type="button">保存并发布</button>
                    </div>
                    <div style="clear: both; height: 10px;"></div>
                    <div>
                        <button id="publishandnew_btn" class="btn btn-danger btn-new" type="button">发布并新建</button>
                    </div>
                </div>
            </div>
        </div>
        <%--模态框部分--%>
        <%--添加附件的Modal--%>
        <div class="modal fade" id="AddAttachments_Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">添加附件</h4>
                    </div>
                    <div class="modal-body">
                        <div id="wrapper">
                            <div id="container">
                                <div id="uploader">
                                    <div class="queueList">
                                        <div id="dndArea" class="placeholder">
                                            <div id="filePicker"></div>
                                            <p>或将文件拖到这里，单次最多可选50个文件</p>
                                        </div>
                                    </div>
                                    <div class="statusBar" style="display: none;">
                                        <div class="progress">
                                            <span class="text">0%</span>
                                            <span class="percentage"></span>
                                        </div>
                                        <div class="info"></div>
                                        <div class="btns">
                                            <div id="filePicker2"></div>
                                            <div class="uploadBtn">开始上传</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>
        <%--文章摘要的Modal--%>
        <div class="modal fade" id="SummaryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">文章摘要</h4>
                    </div>
                    <div class="modal-body" style="padding: 25px 25px 0 25px;">
                        <p style="font-size: 12px; color: #808080;">请编辑该文章摘要或介绍，如为空则默认取前50个字符作为摘要</p>
                        <textarea id="ArticleSummary" class="form-control" rows="5" style="resize: none;"></textarea>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>
        <%--发布设置的Modal--%>
        <div class="modal fade" id="PublishModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">发布设置</h4>
                    </div>
                    <div class="modal-body" style="padding-left: 25px;">
                        <%--<div style="clear: both; height: 10px;"></div>
                        <div class="form-group" style="display: none">
                            <label for="ItemText" class="control-label col-lg-3" style="line-height: 2.6;">发布位置：</label>
                            <div id="publishing_location_check" class="checkbox col-lg-9">
                                <label>
                                    <input type="checkbox" value="" />电脑网站</label>
                                <label>
                                    <input type="checkbox" value="" />手机网站</label>
                                <label>
                                    <input type="checkbox" value="" />微信平台</label>
                                <label>
                                    <input type="checkbox" value="" />平板电脑</label>
                                <label>
                                    <input type="checkbox" value="" />手机APP</label>
                                <label>
                                    <input type="checkbox" value="" />大屏幕电视</label>
                            </div>
                        </div>--%>
                        <div class="form-group">
                            <label for="ItemText" class="control-label col-lg-3" style="line-height: 2.6;">发布日期：</label>
                            <div class="col-lg-9">
                                <div class="input-group date form_date col-md-5" data-date="" data-date-format="yyyy MM dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                                    <input class="form-control" id="CDT_chose" size="16" type="text" value="" readonly />
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                </div>
                                <input type="hidden" id="dtp_input2" value="" />
                            </div>
                        </div>
                        <div style="clear: both; height: 10px;"></div>
                        <div class="form-group">
                            <label for="ItemText" class="control-label col-lg-3" style="line-height: 2.6;">用户标签：</label>
                            <div id="UserTag_Select" class="col-lg-9">
                                <select id="usertag">
                                    <option v-for="item in items" v-bind:value="item.UserTagID">{{item.TagName}}</option>
                                </select>
                            </div>
                        </div>
                        <div style="clear: both; height: 10px;"></div>
                        <div class="form-group">
                            <label for="ItemText" class="control-label col-lg-3" style="line-height: 2.6;">是否在列表页显示：</label>
                            <div class="col-lg-9">
                                <select id="is_list">
                                    <option value="1">是</option>
                                    <option value="0">否</option>
                                </select>
                            </div>
                        </div>
                        <div style="clear: both; height: 10px;"></div>
                        <div class="form-group">
                            <label for="ItemText" class="control-label col-lg-3" style="line-height: 2.6;">是否允许评论：</label>
                            <div class="col-lg-9">
                                <select id="is_comment">
                                    <option value="1">是</option>
                                    <option value="0">否</option>
                                </select>
                            </div>
                        </div>
                        <div style="clear: both; height: 0px;"></div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>
        <%--关键字（标签）的Modal--%>
        <div class="modal fade" id="KeywordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">标签</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="control-label col-lg-2" style="padding-right: 0; line-height: 2.6;">标签：</label>
                            <div class="col-lg-8">
                                <div class="panel panel-default">
                                    <div class="panel-body" style="padding: 5px; font-size: 12px; height: 100%;">
                                        <div class="container" style="width: 100%;">
                                            <input type="text" class="form-control input-tags" id="article_tag" />
                                            <p style="display: none;">value: <span id="value"></span></p>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div style="clear: both;"></div>
                        <div class="form-group">
                            <label class="control-label col-lg-2" style="padding-right: 0; line-height: 2;">常用标签：</label>
                            <div class="col-lg-8">
                                <input type="button" class="btn btn-primary tagadd" style="padding: 3px 10px;" value="标签1" />
                                <input type="button" class="btn btn-primary tagadd" style="padding: 3px 10px;" value="标签2" />
                                <input type="button" class="btn btn-primary tagadd" style="padding: 3px 10px;" value="HistoryTag" />
                            </div>
                        </div>
                        <div style="clear: both; height: 10px;"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>
        <%--封面图设置的Modal--%>
        <div class="modal fade" id="CoverPhotoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document">
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">封面图设置</h4>
                    </div>
                    <div class="modal-body" style="padding: 15px 25px;">
                        <center><img id="CoverPhoto" runat="server" style="width: 200px; height: 200px; margin-right: 15px;" src="assets/images/29J58PICf2x_1024.jpg" /></center>
                        <button type="button" id="fileSelect" class="btn btn-info col-lg-12" style="padding: 10px 0px; margin-top: 20px;">上传封面图片</button>
                        <div style="clear: both;"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>
        <%--模态框结束--%>
    </div>


    <%--内容页结束--%>
    <script src="webuploader/webuploader.js"></script>
    <script src="assets/js/Articles_Add_yzt.js"></script>
    <script src="assets/js/jquery.tags.js"></script>
    <script src="assets/js/ajaxfileupload.js"></script>
    <script type="text/javascript">
        /*上传封面图的Script*/
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
                data: { "project_id": "", "UploadType": "ProjectCoverPhoto" },
                success: function (data) {
                    $('#coverphotourl_input').val(data);
                    document.getElementById("<%=CoverPhoto.ClientID %>").src = window.URL.createObjectURL(document.getElementById("<%=fileElem.ClientID %>").files[0]);
                }
            });
        };
        (function ($) {
            var fileSelect = document.getElementById("fileSelect");
            fileSelect.addEventListener("click", link, false);
            $('#overphotourl_input').val("~/Backend/assets/images/29J58PICf2x_1024.jpg");
        })(jQuery);
       

        
        /*日期选择器的语言的Script*/
        $('.form_date').datetimepicker({
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0
        });

    </script>
</asp:Content>

