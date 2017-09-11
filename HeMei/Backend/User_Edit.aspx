<%@ Page Title="" Language="C#" MasterPageFile="~/Backend/User.master" AutoEventWireup="true" CodeFile="User_Edit.aspx.cs" Inherits="Backend_User_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style type="text/css">
        .tips_false {
            color: red;
        }

        .tips {
            color: rgba(0, 0, 0, 0.5);
            padding-left: 35px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <link href="assets/css/cropper.min.css" rel="stylesheet"/>
    <link href="assets/css/sitelogo.css" rel="stylesheet"/>
    <script src="assets/js/cropper.js"></script>
	<script src="assets/js/sitelogo.js"></script>
   <input id="web_id" type="hidden" runat="server" />
   <input id="otheruserid" type="hidden" runat="server" />
     <div class="container">
    <div class="row">
        <div class="col-lg-3 col-sm-3 col-xs-12">
    <div class="panel panel-default">
  <div class="panel-body">
  <div class="media">
  <div class="media-left">
      
    <a href="#">
        <asp:Image ID="Avatar_SImg" class="img-circle" runat="server" width="60"/>
    </a>
  </div>
  <div class="media-body">
      <h4><asp:Label ID="UserName" runat="server" class="media-heading"></asp:Label></h4>
      <small><asp:Label ID="Email" runat="server"  ></asp:Label></small>
  </div>
</div>
  </div>
       </div>

      <div class="panel panel-default">
  <div class="panel-body">
   <nav class="bs-docs-sidebar hidden-print hidden-xs hidden-sm">
            <ul class="nav bs-docs-sidenav">
                <li>
                    <a id="a1" href="#">个人信息</a>

                </li>
                 <li>
                    <a id="a2" href="#">账号密码</a>

                </li>
                <li >
                  <a id="a3" href="#">密保设置</a>
                </li>
                 <li >
                  <a id="a4" href="#">权限设置</a>
                </li>
                </ul>
              </nav>
  </div>
       </div>
       </div>


<div class="col-lg-9 col-sm-9 col-xs-12">
    
     <div class="panel panel-default  questioninfo">
        <div class="panel-body" >
  <div class="panel-heading">密保设置</div>
           <div class="row">
                <div class="col-sm-2  text-muted">
                 </div>
                <div class="col-sm-6" id="qus">
                   
                     <div class="form-group"   >
                        <label for="exampleInputEmail1"  v-model="num">  问题{{num}}：</label>
                        <select  class="form-control" id="ques">
                          <option v-for="item in json" >
                              {{item}}
                          </option>
                      </select>
                   </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">  答案：</label>
                         <input id="ans" runat="server" type="text" class="form-control"/>
                   </div>

                    <p>
                        <span id="error"  style="font-weight:bold;color:red" />
                        <button type="button" id="pre" class="btn btn-info"  v-on:click="minus" style="float:left;display:none" >上一题</button>
                        <button type="button" id="next" class="btn btn-info" v-on:click="add" style="float:right;">下一题</button>
                        <button type="button" id="final" class="btn btn-info" v-on:click="postdata" style="float:right;display:none">确认</button>
                    </p>
                  
                </div>
           </div>
            </div>
          </div>


    <div class="panel panel-default  roleinfo">
        <div class="panel-body" >
  <div class="panel-heading">权限设置</div>
           <div class="row">
                  <div class="col-sm-2  text-muted">
                 </div>
                <div class="col-sm-6" id="role">

                     <div class="form-group" >
                          <label>  网站：</label>
                           <select v-model="selected" id="webselect" >
                           
                                <option v-for="item in items" v-bind:value="item.ID">{{item.WebName}}</option>
                                 
                            </select>
                   </div>
                     
                     <div class="form-group">
                          <label>  角色：</label>
                          <asp:RadioButtonList ID="Role" runat="server" RepeatDirection="Horizontal" 
                          RepeatLayout="Flow">
                        </asp:RadioButtonList>
                    </div>
                

                    <%-- <div class="form-group">
                         <label>  用户有效性：</label>
                        <asp:RadioButton ID="true1" runat="server" GroupName="Valid" Checked="true" Text="True" />
                    <asp:RadioButton ID="false1" runat="server" GroupName="Valid" Text="False" />
                    </div>--%>

                    <p>
                        <button type="button" id="confirmRole" class="btn btn-info" @click="updateWebsUsers" style="float:right;">确认</button>
                    </p>
                </div>
           </div>
            </div>
          </div>


     
    
    <div class="panel panel-default userinfo">
              
  <div class="panel-body">
  <div class="panel-heading">个人信息</div>
    <div class="row">
  <div class="col-sm-2  text-muted">
     头像
  </div>

      <div class="col-sm-6">
          <asp:Image ID="Avatar_Image" class="img-circle" runat="server" width="90"/>
          
    <button type="button" class="btn btn-primary"  data-toggle="modal" data-target="#avatar-modal" style="margin-left:20px">上传新头像</button>
<div class="user_pic" style="margin: 10px;">
			
		</div>
          <div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<!--<form class="avatar-form" action="upload-logo.php" enctype="multipart/form-data" method="post">-->
					<div class="avatar-form">
						<div class="modal-header">
							<button class="close" data-dismiss="modal" type="button">&times;</button>
							<h4 class="modal-title" id="avatar-modal-label">上传图片</h4>
						</div>
						<div class="modal-body">
							<div class="avatar-body">
								<div class="avatar-upload">
									<input class="avatar-src" name="avatar_src" type="hidden"/>
									<input class="avatar-data" name="avatar_data" type="hidden"/>
									<label for="avatarInput" style="line-height: 35px;">图片上传</label>
									<button class="btn btn-danger"  type="button" style="height: 35px;" onclick="$('input[id=avatarInput]').click();">请选择图片</button>
									<span id="avatar-name"></span>
									<input class="avatar-input hide" id="avatarInput" name="avatar_file" type="file"/></div>
								<div class="row">
									<div class="col-md-9">
										<div class="avatar-wrapper"></div>
									</div>
									<div class="col-md-3">
										<div class="avatar-preview preview-lg" id="imageHead"></div>
										<!--<div class="avatar-preview preview-md"></div>
								<div class="avatar-preview preview-sm"></div>-->
									</div>
								</div>
								<div class="row avatar-btns">
									<div class="col-md-4">
										<div class="btn-group">
											<button class="btn btn-danger fa fa-undo" data-method="rotate" data-option="-90" type="button" title="Rotate -90 degrees"> 向左旋转</button>
										</div>
										<div class="btn-group">
											<button class="btn  btn-danger fa fa-repeat" data-method="rotate" data-option="90" type="button" title="Rotate 90 degrees"> 向右旋转</button>
										</div>
									</div>
									<div class="col-md-5" style="text-align: right;">								
										<button class="btn btn-danger fa fa-arrows" data-method="setDragMode" data-option="move" type="button" title="移动">
							            <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper(&quot;setDragMode&quot;, &quot;move&quot;)">
							            </span>
							          </button>
							          <button type="button" class="btn btn-danger fa fa-search-plus" data-method="zoom" data-option="0.1" title="放大图片">
							            <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper(&quot;zoom&quot;, 0.1)">
							              <!--<span class="fa fa-search-plus"></span>-->
							            </span>
							          </button>
							          <button type="button" class="btn btn-danger fa fa-search-minus" data-method="zoom" data-option="-0.1" title="缩小图片">
							            <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper(&quot;zoom&quot;, -0.1)">
							              <!--<span class="fa fa-search-minus"></span>-->
							            </span>
							          </button>
							          <button type="button" class="btn btn-danger fa fa-refresh" data-method="reset" title="重置图片">
								            <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper(&quot;reset&quot;)" aria-describedby="tooltip866214"/>
								       </button>
							        </div>
									<div class="col-md-3">
										
                                        <asp:Button ID="Save_Image" runat="server" class="btn btn-danger btn-block avatar-save fa fa-save" type="button" data-dismiss="modal" Text="保存修改"  />
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
      </div>
    </div>   
<br />
       <div class="row">
       <div class="col-sm-2  text-muted">
     用户名
  </div>
            <div class="col-sm-6">
          <span class="input-icon icon-right">
                          <asp:Label  ID="User_Name" runat="server" class="form-control"></asp:Label>
                        <i class="fa fa-user success circular"></i>
          </span>
       
                </div>
          
   </div>
      <br />
       <div class="row">
       <div class="col-sm-2  text-muted">
     联系电话
  </div>
            <div class="col-sm-6">
               <span class="input-icon icon-right">
                       <asp:TextBox ID="Tel" type="text" class="form-control" runat="server"></asp:TextBox>
                        <i class="glyphicon glyphicon-earphone darkpink circular"></i>
                    </span>
                </div>
           </div>
         <br />
       <div class="row">
       <div class="col-sm-2  text-muted">
     备注
  </div>
            <div class="col-sm-6">
                    <span class="input-icon icon-right">
           <asp:TextBox ID="Signature" type="text" class="form-control" runat="server"></asp:TextBox>
               <i class="glyphicon glyphicon-briefcase darkorange"></i>
                    </span>
                </div>
           </div>
        <br />
       <div class="row">
       <div class="col-sm-2  text-muted">
     生日
  </div>
          <div class='col-sm-6'>
            <div class="form-group">
                 <div class="input-group date form_date" data-date="" data-date-format="yyyy-MM-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
           
                      <asp:TextBox ID="Birth_Date" type='text' size="16" class="form-control" runat="server" value="" readonly ></asp:TextBox>
              
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                  </div>
                 <input type="hidden" id="dtp_input2" value="" />
                
            </div>
        </div>
            <script type="text/javascript">
                /*日期选择器的语言的Script*/
                $('.form_date').datetimepicker({
                    weekStart: 1,
                    todayBtn: 1,
                    autoclose: 1,
                    todayHighlight: 1,
                    startView: 2,
                    minView: 2,
                    forceParse: 0
                });
        </script>
           </div>

       <div class="row">
            <div class='col-sm-6' style="float:right">
    <asp:Label ID="LabelError" runat="server" Text="" Font-Bold="true" ForeColor="Red" />
      <button id="Save_Info" class="btn btn-info" type="button">保存信息</button>
                   
                </div>

        </div>

     

  </div>
         
     
</div>
  <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                            <ContentTemplate>
    <div class="panel panel-default  passwordinfo">
        <div class="panel-body" >
  <div class="panel-heading">修改密码</div>
           <div class="row">
            <div class="col-sm-6">
                <asp:TextBox ID="Password1"  TextMode="Password" class="form-control"  required="required" runat="server" placeholder="旧密码"></asp:TextBox>
             
             </div>
                  </div>
            <br />
             <div class="row">
             <div class="col-sm-6">
                  <asp:TextBox ID="Password2"  TextMode="Password" onblur="checkpsd1()" class="form-control" runat="server" required="required" placeholder="新密码"></asp:TextBox>
                  <span class="text-center tips" id="divpassword1"></span>
             </div>
                 </div>
    
       <br />
             <div class="row">
             <div class="col-sm-6">
                 <asp:TextBox ID="Password3"  TextMode="Password" onblur="checkpsd2()" class="form-control" runat="server"  required="required" placeholder="确认新密码"></asp:TextBox>
                 <span  id="divpassword2"></span>
             </div>
          </div>

            <div class="row">
               <asp:Label ID="ErrorLabel" runat="server" Text="" Font-Bold="true" ForeColor="Red"></asp:Label>
                      <br />
                 <div class="col-sm-6">
               <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="true"
             Text="查看密码" Visible="true"   oncheckedchanged="CheckBox1_CheckedChanged"/>  
                 <input id="Hidden2" type="hidden" runat="server" />
              <asp:Button ID="Psd_Upd" runat="server" class="btn btn-info pull-right" Text="确认修改" OnClick="Psd_Upd_Click" />
                 </div>
            </div>
        
            </div>
      </div>
       </div>

                                          

                                               </ContentTemplate>
     </asp:UpdatePanel>


     
    </div>

         
   
         <script src="assets/js/html2canvas.min.js" type="text/javascript" charset="utf-8"></script>
         <script src="assets/js/User.js"></script>
         <script src="assets/js/VerifyPsd.js"></script>
        </div>
         </div>


		
</asp:Content>

