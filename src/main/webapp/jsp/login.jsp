<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>购物商城-登录页面</title>
		<!-- main.css是网站前台主要的CSS -->
		<link rel=stylesheet type="text/css" href="../css/main.css"/>
		<!-- login.css作用于登录的CSS -->
		<link rel="stylesheet" type="text/css" href="../css/login.css"/>
		<!-- header部分 -->
		<script type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
		<script type="text/javascript" src="../js/header.js"></script>
		<script type="text/javascript">
			if (parent.window.location != window.location){
				parent.window.location = window.location;
			}
			
			//在页面完成加载时调用
			window.onload = function(){
				 document.getElementById("loginName").focus();
				document.onkeydown = function(){
					// firefox没有window.event对象
					var event = arguments[0] ? arguments[0] : window.event;
					if (event.keyCode === 13){
						onLogin();
					}
				};
			};
			var onLogin = function(){
				//验证用户名和密码是否输入
				var loginname = document.getElementById("loginName").value;
				if(loginname == null || loginname == "" || loginname.length == 0){
					alert("请输入用户名!");
					document.getElementById("loginName").focus;
					return false;
				}
				var password = document.getElementById("password").value;
				if(password == null || password == "" || password.length == 0){
					alert("请输入密码!");
					document.getElementById("password").focus;
					return false;
				}
				$.ajax({type:"POST",
				         url:"/login/check.do",
				         data:{"username":loginname,"password":password},
					     datatype:"json",
					     success:function (data) {

                             //$(window).attr("href","/login/index");
							location.href="/login/index.do";
                         },error:function (data) {

                    }

				});
			};
		</script>
	</head>

<body>
	<!--header begin-->
	<div id="shortcut">
		<script type="text/javascript">header("${session_user.name}");</script>
	﻿	<div class="nav">
			<div class="w960 center">
				<ul>
					<li><a title="首页" href="index.do">首页</a></li>
					<c:forEach items="${firstArticleTypes}" var="firstArticleType" >
						<li><a title="${firstArticleType.name}" href="${ctx}/index.do?typecode=${firstArticleType.code}">${firstArticleType.name}</a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	<!--header end-->
	
	<form name="loginform" method="post" action="/login/check" id="loginform">
		<br />
		<input type="hidden" name="method" value="submitTable"/>
		<div class="login_main" style="background: url(/images/login_bg.jpg) no-repeat center 0;">
			<div class="login_panel">
				<!--登录框开始-->
				<div class="right_panel">
					<div class="login_frame_border">
						<div class="login_frame">
							<div class="login_title">
								<font color="red">${message}</font>还不是商城用户？&nbsp;&nbsp;<a href="register.action">立即注册</a>
							</div>
							<div class="login_frist clearfix" id="user_div_name">
								<label>登录名</label> 
								<span class="login_input"> 
									<input name="loginName" type="text" maxlength="40" id="loginName" class="tip"/>
								</span> 
								<span class="hint" id="login_loginname_error" style="display: none"></span> 
								<span class="hint" id="usernameMessage" style="display:block">请输入邮箱地址</span>
							</div>
							<p class="clearfix" id="password_div">
								<label>密&nbsp;&nbsp;码</label> 
								<span class="login_input">
									<input name="password" type="password" maxlength="20" id="password"/>
								</span> 
								<span class="hint" id="login_password_error" style="display: none"></span> 
								<span class="hint" id="passwordMessage" style="display:block">请输入6-16位密码</span>
							</p>

							<div class="login_btn" id="submit_signin_div">
								<input id="btnSignCheck" type="button" value="登 录"
									onclick="onLogin();" style="width: 94px; height: 27px; float: left; 
									background: url(../images/login_btn.png) no-repeat -237px -46px;"/>
									&nbsp;&nbsp;
							</div>

							<div class="co_login">
								<span>疯狂源自梦想,技术成就辉煌</span><a class="icon_sina"
									id="open_sina_sign" href="" title="新浪微博">广州粤嵌</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<!--登录框结束-->
</body>
</html>