<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>购物商城-物品明细</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="fkjava.ico" rel="shortcut icon" type="image/x-icon" />
		<!-- main.css是购物商城主样式 -->
		<link rel=stylesheet type=text/css href="../css/main.css"/>
		<!-- header.js输出头部信息 -->
		<script type="text/javascript" src="js/header.js"></script>
		<script type="text/javascript">
		//购买数量，失去焦点
		function  blurFn(){
			var domByNum = document.getElementById("buyNum");
			var num = domByNum.value;
			//isNaN不是数字，包含小数
			if(isNaN(num)){
				domByNum.value = 1;
				return;
			}
			domByNum.value = Math.ceil(num) <1 ? 1: (Math.ceil(num) > "${article.storage}" ? "${article.storage}" : Math.ceil(num))
			
		}
		
		//1:减     2：加
		function  numFun(level){
			
			var domByNum = document.getElementById("buyNum");
			var num = domByNum.value;
			num = parseInt(num);
			switch (level) {
			case 1:
				domByNum.value = num <= 1 ? 1 :(num-1);
				break;

			case 2:
				domByNum.value = num +1 > "${article.storage}" ? "${article.storage}" : num+1;
				break;
			}
			
			
		}
			
			var buy = function(){
				document.getElementById("buyform").submit();
			};
		</script>
	</head>
<body>
	<!-- header部分 -->
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
	
	<!-- middle part -->
	<div style="positon: relative; width: 960px;margin: 0px auto;">
		<!-- 左边物品类型列表 -->
		<div  id="booksort" style="float:left;width:210px;">
			<div class="mt" style="height:25px;font-size:14px;">
				<h2>物品分类</h2>
			</div>
			<div class="mc">
				<c:forEach items="${firstArticleTypes}" var="firstArticleType" >
						<div class="item"><h3><b>&gt;</b><a title="护肤" href="${ctx}/index.action?typecode=${firstArticleType.code}">${firstArticleType.name}</a></h3></div>
					</c:forEach>
			</div>
		</div>
		
		<!-- 右边物品明细显示 -->
		<div class="w main">
			<div class="right-extra">
				<div id="name">
					<h1>${article.title}<font style="color: #ff0000"id="advertiseWord"></font></h1>
				</div>
				<div id="preview">
					<div id="spec-n1" class="jqzoom">
						<img src="images/article/${article.image}" title="${article.title}" height="280" width="280" />
					</div>
					<ul class="extra">
						<li>
							<span>评分：</span>
							<div class="con" id="star10918727">
								<div style="float: left; margin: 2px 0 0 5px; width: 64px; height: 12px; background-image: url(images/icon_clubs.gif); background-repeat: no-repeat; overflow: hidden;"></div>
								<a href="javascript:void(0);" class="num-comment">(已有151人评价)</a>
							</div>
						</li>
						<li class="tuangou"><a href="javascript:void(0);">该商品支持全国购买</a></li>
					</ul>
				</div>
				<!--preview end-->
				<ul id="summary">
					<li>供应商：<strong> ${article.supplier}</strong></li>
					<li>出产地：<strong> ${article.locality}</strong></li>
				</ul>
				<ul id="book-price">
					<li>定&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价：<del>￥${article.price}</del></li>
					
					<li><font color="red">疯&nbsp;&nbsp;狂&nbsp;&nbsp;价：</font><span id="priceinfo"
						class="price">￥<fmt:formatNumber  pattern="0.00"  value="${article.price*article.discount}"></fmt:formatNumber>  </span><span class="rate" id="pricediscount">（${article.discount}折）</span></li>
					<li class="sub">
						<span class="fl">库&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;存：${article.storage}</span>
						<span>&nbsp;&nbsp;下单后立即发货</span>
					</li>
					<!--促销-->
					<li style="display: list-item;" id="mfms" class="hide">
						<table border="0" cellpadding="0" cellspacing="0">
							<tbody>
								<tr>
									<td valign="top">促销信息：</td>
									<td><font color="#ef0000">该商品参加满减活动，购买活动商品每满300元，可减100元现金</font></td>
								</tr>
							</tbody>
						</table>
					</li>
				</ul>
				
				
				<!-- 加入购物车表单 -->
				<form action="buy.action" method="post" id="buyform">
					<!-- 隐藏表单传递要购买的书籍id -->
					<input type="hidden" name="id" value="${article.id}"/>
					<div class="m" id="choose">
						<dl class="amount">
							<dt>我要买：</dt>
							<dd>
								<a class="reduce" onclick="numFun(1);" href="javascript:void(0);">-</a> 
								<!-- 购买书的数量 -->
								<input value="1" id="buyNum" name="buyNum" onblur="blurFn();" type="text" /> 
								<a class="add" onclick="numFun(2);" href="javascript:void(0);">+</a>
							</dd>
							
						</dl>
						<div class="btns">
							<a id="InitCartUrl" href="javascript:void(0);" onclick="buy();" class="btn-append"
								style="background-image: url(images/btn_new.jpg)">添加到购物车</a> 
							<input	value="关&nbsp;注"
								style="width: 68px; height: 30px; padding: 4px 0 4px 18px; margin-top: 7px; background: url(images/btn_attention.jpg) no-repeat 0 0; border: 0; line-height: 0; color: transparent; font-size: 0; *padding-bottom: 0px;"
								id="coll10918727" 
								type="button" />
							<div class="clr"></div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!---- middle end----->
	
	<!--bottom part-->
	<div style="width: 1060px;margin: 0px auto;">
  		<img src="images/step.jpg"/>
  	</div>
</body> 
</html>