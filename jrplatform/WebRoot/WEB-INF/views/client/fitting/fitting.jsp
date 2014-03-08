<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	
	String allurl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String filedir = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + "/";
	
	String JS = path + "/resources/client/js";
	String CSS = path + "/resources/client/css";
	String IMG = path + "/resources/client/img";
	String CLIENT = path + "/client";
	String IMAGE = path + "/resources/client/image";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<%@ include file="/common/common_client.jsp" %>
    <script src="${basePath}/resources/client/js/jquery-1.7.js" type="text/javascript"></script>
    <script src="${basePath}/resources/client/js/index.js" type="text/javascript"></script>
    <script src="${basePath}/resources/client/js/marquee.js" type="text/javascript"></script>
    <link href="${basePath}/resources/client/css/product.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}/resources/client/css/style.css" rel="stylesheet" type="text/css" />
    
</head>

<style>
	.pro_desc_p{line-height:25px; color:#666}
	.pro_desc_p span{ padding:3px 8px 3px 5px; cursor:pointer; color:#000}
	.pro_desc_p span:hover{color:#FF4400}
</style>
                
<body>
<center>
	
  <!-- 头部 S-->
  <c:import url="/client/menu/fitting"/>
  <!-- 头部 E-->
		 
  <br/><br/>
  <table class="container product_t" border="0" cellpadding="0" cellspacing="0" height="100%"> 
    <tr>
      <td valign="top" align="left">
      	
        <img src="<%=IMAGE %>/peijian_nav.png" onclick="doChangpingNav()" title="点击查看产品清单"/>
        <br/><br/>
                    
        <!-- 配件查询 -->
        <%--<c:import url="/client/fitting/fittingSelect"/>--%>
        
		<div class="_search">
				<div class="_title"  style="position:relative">配件筛选</div>
				<div class="round" style="z-index:0">
				<form action="${basePath}/client/fitting/findFitting?start=1&pageSize=4" method="get" name="findFitting">
				<input type="hidden" name="start" value="1"/>
				<input type="hidden" name="pageSize" value="4"/>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size:12px; color:#000; font-family:'宋体'">
						<tr>
							<td width="13%" align="right">配件品牌:</td>
							<td width="36%" align="left">
							<select name="brand" id="DropDownList1" class="kk2">
									<option value="">请选择</option>
									
									<c:forEach var="fittingBrand" items="${fittingBrand}">
										<option value="${fittingBrand.brand }">${fittingBrand.brand }</option>
									</c:forEach>
									
							</select></td>
							<td width="4%"></td>
							<td width="13%" align="right">配件名称:</td>
							<td width="34%" align="left"><input type="text" class="txt" name="fittingName"
								style="width:188px;" />
							</td>
						</tr>
						<tr>
							<td width="13%" align="right">配件编号:</td>
							<td width="36%" align="left"><input type="text" class="txt" name="fittingNO"
								style="width:188px;" />
							</td>
							<td width="4%"></td>
							<td width="13%" align="right">适用机型:</td>
							<td width="34%" align="left"><input type="text" class="txt" name="fittingDevice"
								style="width:188px;" />
							</td>
						</tr>
						<tr>
							<td colspan="5" height="10">
								<div style="border-bottom:1px dotted #999; width:100%;"></div></td>
						</tr>
						<tr>
							<td width="13%" align="right" valign="top" style="padding-top:12px;">配件用途:</td>
							<td width="36%" align="left" colspan="4" class="zidingyi"
								valign="top">
								<table width="100%">

									<c:forEach var="value" items="${deviceTypeList}" varStatus="status" >
										<c:if test="${status.index%4==0}"><tr></c:if>
										<td align="left"><a style="font-size:12px;" href="${basePath}/client/fitting/getFittingByFittingCategory?deviceTypeUseId=${value.id}&start=1&pageSize=4">${value.product_use}</a></td>
										<c:if test="${status.index%4==0}"></td></c:if>
									</c:forEach>
								
								</table></td>
						</tr>
						<tr>
							<td colspan="5" height="10">
								<div style="border-bottom:1px dotted #999; width:100%;"></div>
							</td>
						</tr>
						<tr>
							<td width="13%" align="right" valign="top" style="padding-top:12px;">配件归类:</td>
							<td width="36%" align="left" colspan="4" class="zidingyi"
								valign="top">
								<table width="100%">
									
									 <c:forEach var="value" items="${fittingCategory}" varStatus="status" >
										<c:if test="${status.index%4==0}"><tr></c:if>
										<td align="left"><a style="font-size:12px" href="${basePath}/client/fitting/getFittingByFittingCategory?deviceTypeSortId=${value.id}&start=1&pageSize=4">${value.fitting_category}</a></td>
										<c:if test="${status.index%4==0}"><td></td></c:if>
									</c:forEach>
									
								</table></td>
						</tr>
						<tr>
							<td colspan="5" align="right" class="search_btn"><a onclick="javascript:document.findFitting.submit();">查询</a> <a onclick="javascript:document.findFitting.reset();">清除</a>
							</td>
						</tr>
					</table>
					</form>
				</div>
			</div>
        
        <!-- 配件查询 -->
        
        <div class="zhonglei">
          <table width="100%">
            <c:forEach var="fittingUseAndBrand" items="${fittingUseAndBrand}" varStatus="product">
              <tr>
                <td>
                  <div class="category">
                    <div class="_title">
                    
                      <span class="num">
                        <c:if test="${(product.index+1)<10}">0${product.index+1}</c:if>
                        <c:if test="${(product.index+1)>=10}">${product.index+1}</c:if> 
                      </span>
                      <span class="t">${fittingUseAndBrand.fittingUse}</span>
                      <span class="_more">
                        <a style="font-size:12px;font-family:'宋体'" href="${basePath}/client/fitting/getFittingByFittingCategory?deviceTypeUseId=${value.id}&start=1&pageSize=4">
                          <img src="${basePath}/resources/client/img/more_font.png" />
                        </a>
	                  </span>
	                </div>
	                
	                <div class="_line"></div>
	                
	                <c:forEach var="deviceTypeBrandList" items="${fittingUseAndBrand.deviceTypeBrandList}" varStatus="deviceType">
	                  <c:if test="${deviceType.index%3!=0 }"><div class="content spa"></div></c:if>
			            <div class="content">
	                      <div class="title" style="font-size:12px;font-family:'宋体'">
	                      	<c:if test="${(product.index+1)<10}">0${product.index+1}</c:if>
	                      	<c:if test="${(product.index+1)>=10}">${product.index+1}</c:if>
	                      	<c:if test="${(deviceType.index+1)<10}">0${deviceType.index+1}</c:if>
	                      	<c:if test="${(deviceType.index+1)>=10}">${deviceType.index+1}</c:if>  
	                      </div>
	                      <div class="name"><a style="font-size:12px;font-family:'宋体'" href="${basePath}/client/fitting/getFittingByFittingCategory?brand=${deviceTypeBrandList.brand}&deviceTypeUseId=${value.id}&start=1&pageSize=4">${deviceTypeBrandList.brand}</a></div><div class="line l_g"></div>
	                    </div>
					</c:forEach>
	              </td>
                </tr>
              </c:forEach> 
              
              <c:forEach var="fittingCategoryAndBrand" items="${fittingCategoryAndBrand}" varStatus="product">
              	<tr>
	              <td>
	                <div class="category">
	                  <div class="_title">
	                    <span class="num">
						  <c:if test="${(product.index+1)<10}">0${product.index+1}</c:if>
	                      <c:if test="${(product.index+1)>=10}">${product.index+1}</c:if> 
						</span>
	                    
	                    <span class="t">${fittingCategoryAndBrand.fittingUse}</span>
	                    <span class="_more">
	                      <a href="${basePath}/client/fitting/getFittingByFittingCategory?deviceTypeSortId=${value.id}&start=1&pageSize=4">
                            <img src="${basePath}/resources/client/img/more_font.png" />
                          </a>
						</span>
					  </div>
	                                    
	                  <div class="_line"></div>
	                                  
	                  <c:forEach var="deviceTypeBrandList" items="${fittingCategoryAndBrand.deviceTypeBrandList}" varStatus="deviceType">
	                    <c:if test="${deviceType.index%3!=0 }"><div class="content spa"></div></c:if>
			              <div class="content">
	                        <div class="title" style="font-size:12px;font-family:'宋体'">
	                        	<c:if test="${(product.index+1)<10}">0${product.index+1}</c:if>
	                        	<c:if test="${(product.index+1)>=10}">${product.index+1}</c:if>
	                        	<c:if test="${(deviceType.index+1)<10}">0${deviceType.index+1}</c:if>
	                        	<c:if test="${(deviceType.index+1)>=10}">${deviceType.index+1}</c:if>  
	                        </div>
	                        <div class="name"><a style="font-size:12px;font-family:'宋体'" href="${basePath}/client/fitting/getFittingByFittingCategory?brand=${deviceTypeBrandList.brand}&deviceTypeSortId=${value.id}&start=1&pageSize=4">${deviceTypeBrandList.brand} </a></div><div class="line l_g"></div>
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
</body>
</html>
<script>
	$(document).ready(function(){								   
		$.searchList();
		$.searchTxt();
		$.menu();		
		$.tootip({IMG:"<%=allurl%><%=IMG%>",type:true,about:"<%=request.getContextPath()%>/client/about"});
		$.onlineCustomers({url:"<%=request.getContextPath()%>"});
		
		$(".category .content").hover(
			function(){$($(this).find(".line")).css("background-color","#FF4400");},
			function(){$($(this).find(".line")).css("background-color","#CCC");})
	    })
	    
		function doChangpingNav(){
			var body = $.browser.webkit ? $("body")[0] : $("html")[0];
			$(body).animate({scrollTop:700},400);
		}
</script>
  