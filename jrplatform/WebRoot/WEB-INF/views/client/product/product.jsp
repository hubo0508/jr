<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	
	String allurl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	
	String JS = path + "/resources/client/js";
	String CSS = path + "/resources/client/css";
	String IMG = path + "/resources/client/img";
	String CLIENT = path + "/client";
	String IMAGE = path + "/resources/client/image";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<%@ include file="/common/common_client.jsp" %>
	
    <script src="${basePath}/resources/client/js/index.js" type="text/javascript"></script>
    <script src="${basePath}/resources/client/js/marquee.js" type="text/javascript"></script>
    <link href="${basePath}/resources/client/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}/resources/client/css/product.css" rel="stylesheet" type="text/css" />
</head>
<style type="text/css">
	.pro_desc_p{line-height:25px; color:#666}
	.pro_desc_p span{ padding:3px 8px 3px 5px; cursor:pointer; color:#005AA0}
	.pro_desc_p span:hover{color:#FF4400}
	
	.xiyiinfo{position:fixed; -webkit-border-radius: 3px;-moz-border-radius: 3px;border-radius: 3px; top:85px;
		border:5px solid #E8E8E8; background-color:#FFF; width:920px; height:500px; display:none}
	.xiyiinfo .dtitle{ height:28px; font-size:14px; text-align:center; background-image:url(${basePath}/resources/client/img/title.png); background-repeat:repeat-x; width:100%; font-weight:bold}
	.btn{ display:block;background-color:#E43E42; padding-top:8px; 
			padding-bottom:8px; margin-top:25px; width:220px; text-align:center; font-weight:bold; color:#FFF; cursor:pointer}
	.btn:hover{background-color:#EA5154;}	
	.search_list_mask{top:0px; left:0px; position:absolute}
	.bar{width:200px;  display:block; position:absolute; bottom:0px; left:0px; border:1px solid; color:#FF4400;
			font-size:16px; padding-top:5px; padding-bottom:5px;}
</style>

<body>
	<center>
		
		<!-- 头部 S-->
		<c:import url="/client/menu/product"/>
		<!-- 头部 E-->
		
		<br/><br/>
		<div onclick="doChangpingNav()" class="container" style="background-image:url(<%=IMAGE%>/chanpin-nav.png); background-repeat:no-repeat; 
			background-position:left; height:256px; cursor:pointer;" title="点击查看产品清单"></div>
		
		<!-- 产品滚动 -->
			<div id="cp">
				  <dl>
				       <dt>
				            <c:forEach var="value" items="${scrollList.object}">
								  <a style="text-decoration:none" href="${basePath}/client/product/getProductByProductId/${value.id}" target="_blank">
					               		<div class="bar" align="center">
					                    	<span>${value.product_use}</span>
					                    </div>
					                    <img src="${value.image_url}" width="200" height="200"/>
				              	 </a>
							</c:forEach>
				        </dt>
				    	<dd></dd>
				   </dl>
			</div>
			<br/>
		<!-- 产品滚动 -->
		<table class="container product_t" border="0" cellpadding="0" cellspacing="0" height="100%"> 
        	<tr>
            	<td valign="top" align="left">
                <div class="projieshao">
                    	<!-- 介绍  <c:import url="/client/product/productDescJump"/>	-->
                        <!-- 客户滚动 -->
		                        <p><img src="${basePath}/resources/client/img/sy.png" /></p>
								<div id="marquee">
									<dl>
										<dt>
									       	<c:forEach var="value" items="${customerList}">
													<a href="#">
														<img style="width:150px;height:100px;" src="${value.image_url}" curname="${value.customer_name}"  description="${value.id}" class="${value.image_url}" />
													</a> 
											</c:forEach>	
										</dt>
										<dd></dd>
									</dl>
								</div>
                   	     <!-- 客户滚动 -->
                    </div>
                   <!-- 产品筛选 S-->
                   
                  		<%--<c:import url="/client/product/productSelect"/>--%>
	               
	               <div class="_search">
							<div class="_title" style="position:relative">产品筛选</div>
							<div class="round" style="z-index:0">
								<form action="${basePath}/client/product/findProductByBrandAndProductName?start=1&pageSize=4" method="get" name="findProductByBrandAndProductName">
								<input type="hidden" name="start" value="1"/>
								<input type="hidden" name="pageSize" value="4"/>
								<table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size:12px; color:#000; font-family:'宋体'">
									<tr>
									
										<td width="13%" align="right">设备品牌:</td>
										<td width="36%" align="left">
											<select name="brand" id="DropDownList1" class="kk2">
												<option value="">请选择</option>
												<c:forEach var="productBrand" items="${productBrand}">
													<option value="${productBrand.brand }">${productBrand.brand }</option>
												</c:forEach>
											</select>
										</td>
										<td width="4%"></td>
										<td width="13%" align="right">设备名称:</td>
										<td width="34%" align="left">
											<input type="text" class="txt" name="productName" style="width:188px;" />
										</td>
									</tr>
									<tr>
										<td colspan="5" height="10">
											<div style="border-bottom:1px dotted #999; width:100%;"></div></td>
									</tr>
									<tr>
										<td width="13%" align="right" valign="top" style="padding-top:12px;">设备类别:</td>
										<td width="36%" align="left" colspan="4" class="zidingyi"
											valign="top">
											<table
												border="0" cellpadding="0"
												cellspacing="0" width="100%">
													<c:forEach var="value" items="${deviceTypeList}" varStatus="status" >
														<c:if test="${status.index%4==0}"><tr></c:if>
															<td align="left"><a style="font-size:12px;" href="${basePath}/client/product/findProduct?deviceTypeId=${value.id}&start=1&pageSize=4">${value.product_use}</a></td>
														<c:if test="${status.index%4==0}"><td></td></c:if>
													</c:forEach>
												</tr>
											</table></td>
									</tr>
									<tr>
										<td colspan="5" align="right" class="search_btn">
											<a onclick="javascript:document.findProductByBrandAndProductName.submit();">查询</a> <a onclick="javascript:document.findProductByBrandAndProductName.reset();">清除</a>
										</td>
									</tr>
								</table>
								</form>
							</div>
						</div>
	               
	               
	               
	               
	               
	               
	               <!-- 产品筛选  E-->
						<div class="zhonglei">
	                    
	                    <table width="100%" style="font-size:12px;font-family:'宋体'">
	                    	<c:forEach var="productUseAndBrand" items="${productUseAndBrand}" varStatus="product">
                            <tr>
                            <td>
                                  <div class="category">
                                    <div class="_title">
                                    	<span class="num">
                                    		<c:if test="${(product.index+1)<10}">0${product.index+1}</c:if>
                                    		<c:if test="${(product.index+1)>=10}">${product.index+1}</c:if>  
                                    	</span><!-- 序列号 -->
                                        <span class="t">${productUseAndBrand.productUse}</span>
                                        <span class="_more">
                                        	<a href="${basePath}/client/product/findProduct?deviceTypeId=${productUseAndBrand.deviceTypeId}&start=1&pageSize=4">
                                        		<img src="${basePath}/resources/client/img/more_font.png" />
                                        	</a>
                                        </span></div>
                                    <div class="_line"></div>
                                   
                                   <c:forEach var="deviceTypeBrandList" items="${productUseAndBrand.deviceTypeBrandList}" varStatus="deviceType">
                                     
                                     <c:if test="${deviceType.index%3!=0 }">
                                       <div class="content spa"></div>
                                     </c:if>
                                     
		                    		 <div class="content">
                                   		<div class="title">
	                                   		<c:if test="${(product.index+1)<10}">0${product.index+1}</c:if>
	                                   		<c:if test="${(product.index+1)>=10}">${product.index+1}</c:if>
	                                   		<c:if test="${(deviceType.index+1)<10}">0${deviceType.index+1}</c:if>
	                                   		<c:if test="${(deviceType.index+1)>=10}">${deviceType.index+1}</c:if>  
                                   		</div>
                                   		<div class="name"><a style="font-size:12px;font-family:'宋体'" href="${basePath}/client/product/findProduct?deviceTypeId=${productUseAndBrand.deviceTypeId}&brand=${deviceTypeBrandList.brand}&start=1&pageSize=4">${deviceTypeBrandList.brand}</a></div><div class="line l_g"></div>
                                     </div>
                                     
								   </c:forEach>
                             </td>
                            </tr>
                          </c:forEach>
                        </table>
	                    </div>
              </td>
            </tr>
        </table>
    </center>
    <iframe src="<%=CLIENT %>/bottomNavigation" frameborder="0" scrolling="no" class="boiframe"></iframe>
    <div class="xiyiinfo" align="center">
    	<div class="dtitle"><span style="padding-top:5px; display:block" id="xtitle">相关产品</span></div>
        <div style=" width:100%; height:380px;" id="xcontent"></div>
        <span class="btn">关闭</span>
    </div>
</body>
</html>
<script>
	$(document).ready(function(){	
		$.searchList();
		$.searchTxt();
		$.menu();		
		$.tootip({IMG:"<%=allurl%><%=IMG%>",type:true,about:"<%=request.getContextPath()%>/client/about"});
		$.onlineCustomers({url:"<%=request.getContextPath()%>"});
		Marquee("cp");
		Marquee("marquee");
		
		$(".xiyiinfo .btn").click(function(){
			$(".search_list_mask").remove();
			$(".xiyiinfo").fadeOut();		
			$("._search ._title").css("display","block");
		});
		
		$("#marquee img").click(function(){
			var html = $.browser.webkit ? $("body")[0] : $("html")[0];
			
			var _w = $(".xiyiinfo").css("width");_w = Number(_w.substring(0,_w.length-2));
			var _h = $(".xiyiinfo").css("height");_h = Number(_h.substring(0,_h.length-2));
			
			var jWin = $(window); 
			
			var _l = 0;
			if(_w < jWin.width()){_l = (Number(jWin.width()) - _w) * 0.5 ;}
			
			var _t = 0;
			if(_h < Number(jWin.height())){
				_t = (Number(jWin.height()) - _h) * 0.5;
			}
			
			$(".xiyiinfo").css("left",_l+"px").css("top",_t+"px");
			$(".xiyiinfo").fadeIn();
			$("._search ._title").css("display","none");
			
			$("#xtitle").html($(this).attr("curname"));
			$.get("${basePath}/client/getCustomer/"+$(this).attr("description"),function(data,status){
			    $("#xcontent").html("<pre style='float:left;'>"+data.description+"</pre>");
			  });
			
			var mask = $('<div class="search_list_mask" style="z-index:99;width:100%; height:'+html.scrollHeight+'px"></div>');
				mask.bind("click",function(){
					$(".search_list_mask").remove();
					$(".xiyiinfo").fadeOut();
					$("._search ._title").css("display","block");
				});
				//mask.css("opacity",0.3);
			
			$("body").before(mask);									 
		});
		
		$(".product_list ul li").click(function(){
			$(".product_list ul li").each(function(){
				$(this).removeClass("selected");
			});
			$(this).addClass("selected");
			
			window.location = "./productInfo.html";
		});
		
		$(".category .content").hover(
			function(){
				$($(this).find(".line")).css("background-color","#FF4400");
			},
			function(){
				$($(this).find(".line")).css("background-color","#CCC");
			});
	});	
	
	function doChangpingNav(){
		var body = $.browser.webkit ? $("body")[0] : $("html")[0];
		if($.browser.mozilla == true){
			body = document.body;
		}
		//var $match = $(this);
		$(body).animate({scrollTop:700},400);
	}
</script>