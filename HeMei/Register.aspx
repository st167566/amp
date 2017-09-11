<%@ Page Title="" Language="C#" MasterPageFile="~/Front.master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
		    <div class="row">
			    <div class="col-md-4 col-md-offset-4">
				    <!-- Start Sign In Form -->
				    <div class="fh5co-form animate-box" data-animate-effect="fadeIn">
					    <h2 class="text-center">用户注册</h2>
					    <div class="form-group login-info">
						    <label for="username" class="sr-only">Username</label>
						    <input type="text" class="form-control" id="username" placeholder="请输入用户名" autocomplete="off" />
					    </div>
					    <div class="form-group login-info">
						    <label for="password" class="sr-only">Password</label>
						    <input type="password" class="form-control" id="password" placeholder="请输入密码" autocomplete="off" />
					    </div>
                        <div class="form-group login-info">
						    <label for="password" class="sr-only">Password</label>
						    <input type="password" class="form-control" id="password-again" placeholder="请再次输入密码" autocomplete="off" />
					    </div>
                        <div class="form-group login-info">
						    <label for="e-mail" class="sr-only">Password</label>
						    <input type="text" class="form-control" id="e-mail" placeholder="请输入邮箱" autocomplete="off" />
					    </div>
					    <div class="form-group login-info text-center">
						    <input type="submit" value="注册" class="btn btn-primary" />
					    </div>
				    </div>
				    <!-- END Sign In Form -->

			    </div>
		    </div>
	    </div>
</asp:Content>

