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
	<title>金嵘厨房_产品中心</title>
	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    
    <script src="${basePath}/resources/client/js/jquery-1.7.js" type="text/javascript"></script>
    <script src="${basePath}/resources/client/js/index.js" type="text/javascript"></script>
    
    <link href="${basePath}/resources/client/css/style.css" rel="stylesheet" type="text/css" />
    
    <link href="${basePath}/resources/client/css/product.css" rel="stylesheet" type="text/css" />
    
    <link href="${basePath}/resources/client/css/table.css" rel="stylesheet" type="text/css" />
    
    <script src="${basePath}/resources/client/js/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>
    <link href="${basePath}/resources/client/css/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css" />
    
</head>
<body>
	<center>
    	<!-- 头部 -->
		<c:import url="/client/menu/product"/>
		<!-- 头部 -->
        <table class="container product_base" cellpadding="0" cellspacing="0" width="100%">
        	<tr>
            	<td colspan="3" align="left" height="50" valign="top">
                   <div class="daohang" style="color:#000; font-weight:bold; font-size:13px;">
                    	 <a href="${basePath}/client/product">产品中心</a>> 
                    	 <a href="${basePath}/client/product">品牌分类</a>>
                    	 <a href="${basePath}/client/product/findProduct?brand=${product.brand }&start=1&pageSize=4">${product.brand}</a> > <a href="#">${product.product_name}</a>
                        <br /><br />
                    </div>
                </td>
            </tr>
        	<tr>
            	<td width="402" valign="top"><img src="${product.image_url}" style="max-width:400px; max-height:400px;"/></td>
                <td width="18"></td>
                <td width="498" valign="top">                    
           		  <span class="pt f">${product.product_name}</span>
                    <div class="line"></div>
                   
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="_chicun" style="color:#000;font-size:12px">
                    	<tr>
                            <td width="20%" bgcolor="#AEE657"><div class="_justify">产 品 分 类：</div></td>
                            <td width="30%" bgcolor="#DEDEDC">制冷</td>
                             <td width="20%" bgcolor="#AEE657"><div class="_justify">电 压：</div></td>
                            <td width="30%" bgcolor="#DEDEDC">${product.voltage}</td>
                        </tr>
                        <tr>
                            <td><div class="_justify">品 牌：</div></td>
                            <td>${product.brand}</td>
                              <td><div class="_justify">电 流：</div></td>
                            <td>${product.electric_current}</td>
                        </tr>
                        <tr>
                            <td bgcolor="#AEE657"><div class="_justify">产 地：</div></td>
                            <td bgcolor="#DEDEDC">${product.place_origin}</td>
                              <td bgcolor="#AEE657"><div class="_justify">功 率：</div></td>
                            <td bgcolor="#DEDEDC">${product.power}</td>
                        </tr>
                        <tr>
                            <td><div class="_justify">型 号：</div></td>
                            <td>${product.model}</td>
                               <td><div class="_justify">能 耗：</div></td>
                            <td>${product.energy }</td>
                        </tr>
                        <tr>
                            <td  bgcolor="#AEE657"><div class="_justify">材 质：</div></td>
                            <td  bgcolor="#DEDEDC">${ product.material}</td>
                            <td  bgcolor="#AEE657"><div class="_justify">温 度 范 围：</div></td>
                            <td  bgcolor="#DEDEDC">${product.temperature_range }</td>
                        </tr>
                        <tr>
                            <td><div class="_justify">外 观 尺 寸：</div></td>
                            <td>${ product.exterior_size}</td>
                              <td><div class="_justify">冷 却 剂：</div></td>
                            <td>${product.coolant }</td>
                        </tr>
                        <tr>
                            <td bgcolor="#AEE657"><div class="_justify">有  效 容 积：</div></td>
                            <td bgcolor="#DEDEDC">${product.effective_volume }</td>
                              <td bgcolor="#AEE657"><div class="_justify">工 作 方 式：</div></td>
                            <td bgcolor="#DEDEDC">${product.work_mode }</td>
                        </tr>
                        <tr>
                            <td><div class="_justify">产 品 重 量：</div></td>
                            <td>${product.product_weight }</td>
                               <td><div class="_justify">产 能：</div></td>
                            <td>${product.capacity }</td>
                        </tr>
                        <tr>
                            <td  bgcolor="#AEE657"></td>
                            <td  bgcolor="#DEDEDC"></td>
                             <td  bgcolor="#AEE657"></td>
                            <td  bgcolor="#DEDEDC"></td>
                        </tr>

                    </table>
                    
                    <div class="search_btn" style="margin-top:10px;">
                     	<c:if test="${product.taobao_links!=null&&product.taobao_links!=''}"><a style="color:#FFF" href="${product.taobao_links}" target="_blank">购买</a> </c:if>
                    </div>              
                </td>
            </tr>
            <tr>
            	<tr>
                	<td colspan="3">
                    	<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                          <td>
                          	<div class="category">
                          		
                               <div class="_title f" style="text-align: left">产品特性</div>
                               <div class="_line"></div>
                               
                               <div class="text desc" style="color:#000">${product.features }</div>
                               
                               <div class="_title f" style="text-align: left">售后保障</div>
                               <div class="_line"></div>
                               
                               <div class="text desc"  style="color:#000">${product.service_range }</div>
                               
                            </div>
                          </td>
                          </tr>
                        </table>
                    </td>
                </tr>
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

		$(".texin_div").mCustomScrollbar();
		
		$(".product_list ul li").click(function(){
			$(".product_list ul li").each(function(){
				$(this).removeClass("selected");
			})
			$(this).addClass("selected");;
		})
		
		$(".category .content").hover(
			function(){
				$($(this).find(".line")).css("background-color","#FF4400");
			},
			function(){
				$($(this).find(".line")).css("background-color","#CCC");
			})
	})	
</script>
 