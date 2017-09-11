<%@ Page Title="" Language="C#" MasterPageFile="~/Front.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
         <link href="css/drag.css" rel="stylesheet" />
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
      <asp:Label ID="U_Label" runat="server" Visible="false" Text="" />
    <div class="login-page">
        <div class="container">
		    <div class="row">
			    <div class="col-md-4 col-md-offset-4">
				    <!-- Start Sign In Form -->
				    <div class="fh5co-form animate-box" data-animate-effect="fadeIn">
					    <h2 class="text-center">用户登录</h2>
					    <div class="form-group login-info">
						    <label for="username" class="sr-only">Username</label>
						  <asp:TextBox ID="UserName" type="text" class="form-control" placeholder="请输入用户名" required="required" autofocus="autofocus" runat="server"></asp:TextBox>
					    </div>
					    <div class="form-group login-info">
						    <label for="password" class="sr-only">Password</label>
						    <asp:TextBox ID="Password" type="password"  onkeypress="searchPress();"  class="form-control aa" placeholder="密码" required="required" runat="server" ></asp:TextBox>
					    </div>
                           <div id="drag"></div>
                <asp:Label ID="ErrorLable" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label>
                <input id="Hidden1" type="hidden" runat="server" />
                <br />
					    <div class="form-group login-info">
						    <label for="remember"><input type="checkbox" id="remember" /> 记住我</label>
					    </div>
					    <div class="form-group login-info">
						    <p>还没注册? <a href="Register.aspx">立即注册</a> | <a href="forgot.html">忘记密码?</a></p>
					    </div>
					    <div class="form-group login-info text-center" id="user-login">
						    <asp:Button class="btn btn-primary login" runat="server" OnClick="SureRegisting_Click" Text="登录" />
					    </div>

                          
				    </div>
				    <!-- END Sign In Form -->
			    </div>
		    </div>
	    </div>
    </div>

   <script>window.jQuery || document.write('<script src="js/jquery-2.1.4.min.js"><\/script>')</script>
   <script src="js/drag.js"></script>
     <script type="text/javascript">
         $('#drag').drag();

         $(".login").click(function () {//点击事件    
      
             //if (ContentPlaceHolder1_Hidden1.value != 1) {
             //    ContentPlaceHolder1_ErrorLable.innerHTML = "滑块验证失败";
             //}
             //else
             //{
            <%--    document.getElementById('<%=aBt.ClientID %>').click();--%>
            // }
           
       

         });

     <%--    function searchPress(){
      
             var theEvent = window.event || arguments.callee.caller.arguments[0]; //谷歌能识别event，火狐识别不了，所以增加了这一句，chrome浏览器可以直接支持event.keyCode
             var code = theEvent.keyCode;
             if (code == 13) {
                 $('#ContentPlaceHolder1_Loging').click();
                 var isChrome = navigator.userAgent.toLowerCase().match(/chrome/) != null;//判断是否是谷歌浏览器
                 if(isChrome){
                     event.keyCode=9;
                     event.returnValue = false;//屏蔽其默认的返回值
                     var txtpwd=<%=aBt.ClientID%>;
                     document.getElementById(txtpwd).click();
                 }
             }
         }--%>
    </script>
</asp:Content>

