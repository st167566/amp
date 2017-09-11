<%@ Page Title="" Language="C#" MasterPageFile="~/Front.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section class="hero-unit-slider slider-responsive no-margin">
        <div id="carousel-hero" class="slick-carousel">
            <div class="carousel-inner"  style="height: 430px;" role="listbox">
                <div class="item active">
                    <img src="images/banner.jpg" class="img-responsive" alt="Slider Image" />
                    <div class="carousel-caption">
                        <h2 class="hero-heading">全媒体平台的创行者</h2>
                        <p class="lead">The creator of All Media Platform</p>
                        <a href="#" class="btn btn-lg hero-button">观看视频</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
  <!-- header-section-ends-here -->
 <%--   <div class="header-slider">
		<div class="slider">
			<div class="callbacks_container">
			  <ul class="rslides" id="slider">
				<li>
				  <img src="images/banner.png" />
				  <div class="caption">
					<h3>全媒体平台的创行者</h3>
					<%--<a class="morebtn hvr-sweep-to-right" href="#">观看视频</a>	
                    <div class="btn btn-3 "><a href="javascript:;" >观看视频</a></div>			  
				  </div>
				</li>
				<%--<li>
				<img src="images/banner1.jpg" alt="">
					<div class="caption">
					<h4>禾美</h4>
					<h3>全媒体平台的创行者</h3>
					<a class="morebtn hvr-sweep-to-right" href="#">观看视频 >> </a>
				</div>
				</li>
				<li>
				  <img src="images/banner2.jpg" />
					<div class="caption">
					<h4>禾美</h4>
					<h3>全媒体平台的创行者</h3>
					<a class="morebtn hvr-sweep-to-right" href="#">观看视频 >> </a>
				</div>
				</li>
				<li>
				  <img src="images/banner3.jpg" />
					<div class="caption">
					<h4>禾美</h4>
					<h3>全媒体平台的创行者</h3>
					<a class="morebtn hvr-sweep-to-right" href="#">观看视频 >> </a>
				</div>
				</li>
			</ul>
		  </div>
	  </div>
	</div> --%> 
    <!-- header-section-ends-here -->
     
    <div class="section">
        <div class="wrap2">
            <h3>全媒体平台支持以下终端</h3>
            <div class="row">
                <div class="col-md-3 col-sm-4 col-xs-6">
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i style="font-size: 60px;" class="fa fa-mobile-phone"></i>
                        <p>手机</p>
                    </div>                    
                </div>
                <div class="col-md-3 col-sm-4 col-xs-6">
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i style="font-size: 55px;" class="fa fa-tablet"></i>
                        <p>平板</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 col-xs-6">
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i style="line-height: 54px;" class="fa fa-desktop"></i>
                        <p>电脑</p> 
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 col-xs-6">
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i style="font-size: 55px;" class="fa fa-laptop"></i>
                        <p>展示屏</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 col-xs-6">
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i class="fa fa-wechat"></i>
                        <p>微信</p>                      
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 col-xs-6">
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i style="font-size: 50px;" class="fa fa-apple"></i>
                        <p>iOS</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 col-xs-6">
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i style="font-size: 50px;" class="fa fa-android"></i>
                        <p>Android</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 col-xs-6">
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i class="fa fa-windows"></i>
                        <p>Windows</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="functions">
        <div class="wrap2">
		  	<h3>全媒体平台的功能</h3>
            <div class="row">               
                <div class="col-md-3 col-sm-4 col-xs-6"  onclick="window.open('Product_Function.aspx');" >
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i class="fa fa-send"></i>
                        <p>一键发布</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 col-xs-6"  onclick="window.open('Product_Function.aspx');" >
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i class="fa fa-cog"></i>
                        <p>高端定制</p>   
                    </div>           
                </div>  
                <div class="col-md-3 col-sm-4 col-xs-6"  onclick="window.open('Product_Function.aspx');" >
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i class="fa fa-file"></i>
                        <p>内容管理</p>  
                    </div>            
                </div>          
                <div class="col-md-3 col-sm-4 col-xs-6"  onclick="window.open('Product_Function.aspx');" >
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i class="fa fa-globe"></i>
                        <p>资源库</p>              
                    </div>
                </div>
                <div class="col-md-3 col-sm-4 col-xs-6"  onclick="window.open('Product_Function.aspx');" >
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i class="fa fa-comments"></i>
                        <p>微信预约</p> 
                    </div>             
                </div>
                <div class="col-md-3 col-sm-4 col-xs-6"  onclick="window.open('Product_Function.aspx');" >
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i class="fa fa-search"></i>
                        <p>智能检索</p> 
                    </div>             
                </div>
                <div class="col-md-3 col-sm-4 col-xs-6"  onclick="window.open('Product_Function.aspx');" >
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i class="fa fa-share-alt"></i>
                        <p>分享</p> 
                    </div>             
                </div>
                <div class="col-md-3 col-sm-4 col-xs-6"  onclick="window.open('Product_Function.aspx');" >
                    <div class="boxed-content left-aligned left-boxed-icon">
                        <i class="fa fa-tag"></i> 
                        <p>标签</p> 
                    </div>             
                </div>   
                <div class="clearfix"></div>
                <div class="btn btn-2 "><a href="Product_View.aspx" >更多功能</a></div>
            </div>         
        </div>
    </div>
    <div class="cases" id="cases">
		<div class="wrap3">
		  	<h3>成功案例</h3>
		  	<p>禾美已经为众多客户提供了卓越的设计和解决方案</p>              						  						
              			
            <div id="myCarousel" class="carousel slide">
                <!-- 轮播（Carousel）指标 -->
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                    <li data-target="#myCarousel" data-slide-to="3"></li>
                </ol>   
                <!-- 轮播（Carousel）项目 -->
                <div class="carousel-inner">
                    <div class="item active">
                        <img src="images/setc.jpg" alt="First slide" />
                    </div>
                    <div class="item">
                        <img src="images/kangfu.png" alt="Second slide" />
                    </div>
                    <div class="item">
                        <img src="images/shunde.png" alt="Third slide" />
                    </div>
                    <div class="item">
                        <img src="images/resys.png" alt="Thirth slide" />
                    </div>
                </div>
                <!-- 轮播（Carousel）导航 -->
                <a class="carousel-control left" href="#myCarousel" 
	                data-slide="prev">&lsaquo;</a>
	            <a class="carousel-control right" href="#myCarousel" 
	                data-slide="next">&rsaquo;</a>
            </div>
        </div>               		 
   	</div>
</asp:Content>

