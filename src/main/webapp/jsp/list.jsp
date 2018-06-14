<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>购物商城-首页</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="fkjava.ico" rel="shortcut icon" type="image/x-icon" />
<!-- main.css是购物商城主样式 -->

<link rel=stylesheet type="text/css" href="../css/main.css" />
<!-- 使用jQuery-UI的样式来设置tab页 -->
<link type="text/css"
	href="../css/ui-lightness/jquery-ui-1.8.20.custom.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="../js/jquery-ui.js"></script>
<script type="text/javascript" src="../js/pager.js"></script>
<!-- header.js输出头部信息 -->
<script type="text/javascript" src="../js/header.js"></script>
<script type="text/javascript">
	if (window.location != parent.window.location) {
		parent.window.location = window.location;
	}
	window.onload = function() {
		/** tabs标签页 */
		$('#tabs').tabs();

		/** 分页标签 */
		/* 	fkjava.pager("pager", { pageIndex : "1",
					pageSize : "8",
					pageCount : "32",
					submitUrl : '/fk_ec/index.action?pageIndex={0}&typecode=0001&keyword='});	 */

		/** 获取所有的li为特定的li绑定事件 */
		var arrays = document.getElementsByTagName("li");
		for ( var i = 0; i < arrays.length; i++) {
			if (arrays[i].id != "" && arrays[i].id.indexOf('selbgc1') == 0) {
				arrays[i].onmouseover = function() {
					this.className = "selbgc1";
				};
				arrays[i].onmouseout = function() {
					this.className = "";
				};
			}
		}
		/** 设置选的下拉列表选项 */
		alert(${typecode});
		var select = document.getElementById("typecode");
		for ( var i = 0; i < select.options.length; i++) {
			var typecode = "${typecode}";
			if (select.options[i].value == typecode) {
				select.options[i].selected = true;
			}
		}

	};

	//下拉框中数据发生改变时触发该函数
	function reloadIndex(val) {
		var keyword = $("#keyword").val();

		window.location = "${pageContext.request.contextPath}/login/index.do?typecode="
				+ val + "&keyword=" + keyword;
	}
</script>
</head>
<body>
	<!-- header部分 -->
	<div id="shortcut">
		<script type="text/javascript">
			header("${session_user.name}");
		</script>
		﻿
		<div class="nav">
			<div class="w960 center">
				<ul>
					<li><a title="首页" href="index.do">首页</a></li>
					<c:forEach items="${firstArticleTypes}" var="firstArticleType">
						<li><a title="${firstArticleType.name}"
							href="${ctx}/index.do?typecode=${firstArticleType.code}">${firstArticleType.name}</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	<!--header end-->
	<!-- middle part -->
	<div style="positon: relative; width: 960px;margin: 0px auto;">
		<!-- 左边物品类型列表 -->
		<div id="booksort" style="float:left;width:210px;">
			<div class="mt" style="height:25px;font-size:14px;">
				<h2>
					<strong>物品分类</strong>
				</h2>
			</div>
			<div class="mc">
				<c:forEach items="${firstArticleTypes}" var="firstArticleType">
					<div class="item">
						<h3>
							<b>&gt;</b><a href="/list/start.do?typecode=${firstArticleType.code}">·${firstArticleType.name}</a>
						</h3>
					</div>
				</c:forEach>
			</div>
		</div>
		<!-- 右边对应物品列表 -->
		<div style="float:left;width:750px;text-align:center;">
			<div>
				<form action="index.do" method="post" name="search">
					物品类型： <select name="typecode" id="typecode"
						onchange="reloadIndex(this.value)">
						<option value="${firstArticleType.code}">${firstArticleType.name}</option>
						<c:forEach items="${allSecondArticleTypes}"
							var="secondArticleType">
							<option value="${secondArticleType.code}">----${secondArticleType.name}</option>
						</c:forEach>
					</select> <input name="keyword" id="keyword" type="text" value="${keyword}"
						size="50" />
					<button>搜索</button>
				</form>
			</div>
			<!-- 显示所有书籍 -->
			<div id="tabs" style="Width:750px;background-color:white;">
				<ul>
					<li><a href="tabs-1">${firstArticleType.name }</a></li>
				</ul>
				<div class="sales-queue" id="tabs-1"
					style="background-color:white;margin-top:-25px;">
					<ul class="goods-queue3">
						<c:forEach items="${articles}" var="article">
							<li id="selbgc11">
								<dl class="item-des">
									<dt>
										<a href="item.do?id=${article.id}" title="${article.title}"
											target="_self"> <img
											src="images/article/${article.image}" width="132" height="96" />
										</a>
									</dt>
									<dd>
										<s>¥:<fmt:formatNumber value="${article.price}"
												pattern="0.00"></fmt:formatNumber> </s> <strong>¥:<fmt:formatNumber
												value="${article.price* article.discount}" pattern="0.00"></fmt:formatNumber>
										</strong>
									</dd>
									<dd>
										<h2>
											<a href="item.do?id=${article.id}" title="${article.title}"
												target="_self">${article.title}</a>
										</h2>
									</dd>
								</dl>
							</li>
						</c:forEach>
					</ul>
					<!-- 分页标签 -->
					<div class="pagebottom" id="pager" style="clear:both;"></div>
				</div>
			</div>
		</div>
	</div>
	<!---- middle end----->

	<!--bottom part-->
	<div style="width: 1060px;margin: 0px auto;">
		<img src="../images/step.jpg" />
	</div>
	<div>${requestScope.name}</>
</body>
</html>