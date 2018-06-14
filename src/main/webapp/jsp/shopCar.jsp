<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>购物商城-购物车</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="fkjava.ico" rel="shortcut icon" type="image/x-icon" />
		<!-- main.css是购物商城主样式 -->
		<link rel=stylesheet type=text/css href="css/main.css"/>
		<!-- header.js输出头部信息 -->
		<script type="text/javascript" src="js/header.js"></script>
		<script type="text/javascript">
			// 从购物车中删除物品
			var deleteFn = function(id){
				window.location.href = "deleteCar.action?id=" + id;
			};
			/** id: 物品的ID, num: 购买的数量 , type : 是加一还是减一*/
			var addFun = function(id, num, type,storage){
				// 购买的数量
				var buyNum = parseInt(num);
				if (buyNum == 1 && type == 2){
					return;
				}
				if (buyNum >= storage && type == 1){
					return;
				}
				switch (type){
					case 1: // 增加一个
						window.location.href = "updateCar.action?id=" + id + "&buyNum=" + (buyNum+1);
						break;
					case 2: // 减少一个
						window.location.href = "updateCar.action?id=" + id + "&buyNum=" + (buyNum-1);
						break;
				}
			};
			
			//obj当前标签dom对象   id:商品id  num：原数据量数量  storage:商品库存
			var blurFn = function(obj, id, num,storage){
				if (isNaN(obj.value)){
					obj.value = num;
				}else if ((obj.value < 1)  || (obj.value >storage)){
					obj.value = num;
				}else if (obj.value != num){
					window.location.href = "updateCar.action?id=" + id + "&buyNum=" + Math.ceil(obj.value);
				}
			};
			
			//为全选绑定单击事件
			function checkAll(obj){
				var boxs = document.getElementsByName("box");
				
				for (var i = 0; i < boxs.length; i++) {
					//全选事件点击，其他复选框和全选框状态相同
					var box = boxs[i];
					box.checked = obj.checked ;
				}
			}
			
			
			//复选框绑定事件
			function  checkboxFun(val){
				var boxs = document.getElementsByName("box");
				var num = 0;
				
				//在Js中foreach并不会遍历每个元素,而是遍历Key,即所有属性
				for (var i = 0; i < boxs.length; i++) {
					//全选事件点击，其他复选框和全选框状态相同
					var box = boxs[i];
					if(box.checked){
						num++;
					}
				}
				
				document.getElementById("checkAll").checked = (num == boxs.length);
			}
			
			function submitOrder(){
				var boxs = document.getElementsByName("box");
				//保存传递到后台的数据
				var orderInfo = document.getElementById("orderInfo");
				
				var num = 0;
				//在Js中foreach并不会遍历每个元素,而是遍历Key,即所有属性
				for (var i = 0; i < boxs.length; i++) {
					//全选事件点击，其他复选框和全选框状态相同
					var box = boxs[i];
					if(box.checked){
						num++;
						if(orderInfo.value == null ||  orderInfo.value == ""){
							orderInfo.value =box.value;
						}else{
							//判断是否已经存在
							orderInfo.value = orderInfo.value + ","+box.value;
						}
					}
				}
				
				if(num == 0){
					alert("请选择需要购买的商品");
				}else{
					document.getElementById("form").submit();
				}
				
			}
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
		<div class="shoppingcart_wrapper" id="shoppingcart">
	        <p style="text-align:left;"><span id="shoppingcart_dd" style="font-size:13px;line-height:28px;">当前位置&nbsp;&gt;&gt;&nbsp;我的购物车 </span></p>
	        <ul class="shoppingcart_subject" id="ui_shoppingcart_title">
	        	 <li class="row0">
					<input type="checkbox" id="checkAll" onclick="checkAll(this)"/>全选 
				</li>
	            <li class="row1">商品名称</li>
	            <li class="row2">积分</li>
	            <li class="row3">疯狂价</li>
	            <li class="row4"><span title="在疯狂价基础上再优惠">&nbsp;&nbsp;&nbsp;小计&nbsp;&nbsp;&nbsp;</span></li>
	            <li class="row5">数量</li>
	            <li class="row6">操作</li>
	        </ul>
	        
	        <!-- 购物车不为空 <input  type="checkbox"  name="${shopCar.article.id}">-->
	        	<c:choose>
	        		<c:when test="${not empty shopCars}">
	        			<c:forEach items="${shopCars}"  var="shopCar">
							<div class="shoppingcart_promotions_01">
								<ul class="shoppingcart_list">
									<li class="row01">
										<input type="checkbox" name="box"  value="${shopCar.id}"  
									 			onclick="checkboxFun(this.value)"/> 
									</li>
									<li class="row00">
										<a name="productpic" href="item.action?id=${shopCar.article.id}" title="${shopCar.article.title}">
											<img src="images/article/${shopCar.article.image}" width="60xp" height="60xp">
										</a>
									</li>
									<li class="row11">
										<p>
											<span class="name">
												<a name="product"  href="item.do?id=${shopCar.article.id}" title="${shopCar.article.title}">${shopCar.article.title}</a>
											</span>
										</p>
									</li>
									<li class="row22">0</li>
									<li class="row33"><span>￥${shopCar.article.price}</span>&nbsp;&nbsp;(${shopCar.article.discount}折)</li>
									<li class="row44"><span>￥<fmt:formatNumber value="${shopCar.article.price*shopCar.article.discount}"  pattern="0.00"></fmt:formatNumber></span></li>
									<li class="row55">
										<input type="text" name="number"  value="${shopCar.buyNum}" onblur="blurFn(this, ${shopCar.article.id}, ${shopCar.buyNum},${shopCar.article.storage});">
										<a href="javascript:void(0);" onclick="addFun(${shopCar.article.id},${shopCar.buyNum},1,${shopCar.article.storage});" title="数量加一" class="add">+</a>
										<a href="javascript:void(0);" onclick="addFun(${shopCar.article.id},${shopCar.buyNum},2,${shopCar.article.storage});" title="数量减一" class="cut">-</a>
									</li>
									<li class="row66">
										<a name="movetofavorite" href="javascript:void(0);" 
										title="此商品将移至“我的收藏”并从购物车中删除" id="move_20376113">移入收藏</a>
										<a name="delete" href="javascript:void(0);" onclick="deleteFn(${shopCar.article.id});">删除</a>
									</li>
								</ul>
							</div>
						</c:forEach>
	        		</c:when>
	        		<c:otherwise>
	        			<table align="center">
			        		<tr>
			        			<td><img alt="" src="images/cart_icon.gif"/></td>
			        			<td>
			        				<span style="font-size:14px;font-weight:bold;">
			        					购物车为空，<a href="index.do">我要去看看&gt;&gt;</a>
			        				</span>
			        			</td>
			        		</tr>
			        	</table>
	        		</c:otherwise>
	        	</c:choose>
					
		        <div align="right" id="div_total" style="display: block;clear:both;">
		        	<p style="font-size:14px;font-weight:bold;line-height:31px;">
		        		数量总计：
		            	<span style="color:red;font-size:16px;font-weight:bold;">${num}</span>&nbsp;&nbsp;(件)
		        	</p>
		            <p style="font-size:14px;font-weight:bold;line-height:31px;">
		            	金额总计：
		                <span>￥</span>
		                <span style="color:red;font-size:16px;font-weight:bold;"><fmt:formatNumber pattern="0.00"  value="${totalMoney}"></fmt:formatNumber>  </span>&nbsp;&nbsp;(折后价)
		            </p>
		            <p>
		            	
		                <form action="${ctx}/order.action?step=1" method="post" id="form">
				            <td><a href="${ctx}/index.do" name="goon" class="goon"><img alt="" src="images/shop.jpg"/></a></td>
				            <!-- 通过隐藏输入框 将订单相关信息传递至后台 -->
				            <input type="hidden" name="orderInfo" id="orderInfo"/>
				            <td>
								<button id="commitOrder" style="background-image: url(images/balance.jpg);width: 140px;height: 35px" 
								type="button" onclick="submitOrder()"></button>
							</td>
				        </form>
		            </p>
		        </div>
	        
	        <!-- 购物车为空的话 -->
      	</div>
	</div>
	<!---- middle end----->
	
	<!--bottom part-->
	<div style="width: 1060px;margin: 0px auto;">
  		<img src="images/step.jpg"/>
  	</div>
</body> 
</html>