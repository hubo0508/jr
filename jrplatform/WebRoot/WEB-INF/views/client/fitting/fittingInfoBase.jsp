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
		<c:import url="/client/menu/fitting"/>
		<!-- 头部 -->
        <table class="container product_base" cellpadding="0" cellspacing="0" width="100%">
        	<tr>
            	<td colspan="3" align="left" height="50" valign="top">
                   <div class="daohang" style="padding-left:0px; color:#000; font-weight:bold; font-size:13px;">
                    	<a href="${basePath}/client/fitting">配件中心</a>> 
                    	<a href="${basePath}/client/fitting">品牌分类</a>> 
                    	<a href="${basePath}/client/fitting/getFittingByFittingCategory?brand=${fitting.brand }&start=1&pageSize=4">${fitting.brand }</a> > <a href="#">${fitting.fitting_name }</a>
                        <br /><br />
                    </div>
                </td>
            </tr>
        	<tr>
            	<td width="400" valign="top"><img src="${fitting.image_url}" style="max-width:400px; max-height:400px;"/></td>
                <td width="40"></td>
                <td width="480" valign="top">
                    <span class="pt f">${fitting.fitting_name }</span>
                    <div class="line"></div>
                   
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="_chicun" style="font-size:12px; color:#000">
                    	<tr>
                            <td width="27%" bgcolor="#AEE657"><div class="_justify">品     牌：</div></td>
                            <td width="73%" bgcolor="#DEDEDC">${fitting.brand }</td>
                        </tr>
                        <tr>
                            <td><div class="_justify">配 件 编 号：</div></td>
                            <td>${fitting.fitting_number }</td>
                        </tr>
                         <tr>
                            <td bgcolor="#AEE657"><div class="_justify">规 格 描 述：</div></td>
                            <td bgcolor="#DEDEDC">${fitting.specification_desc }</td>
                        </tr>
                        <tr>
                            <td  valign="top"><div class="_justify">适 用 型 号：</div></td>
                            <td>
                            	<table width="100%" cellpadding="0" cellspacing="0" border="0" id="models"></table>
                            </td>
                        </tr>
                        <tr>
                            <td  bgcolor="#AEE657"></td>
                            <td  bgcolor="#DEDEDC"></td>
                        </tr>
                    </table>
                        
                    <div class="search_btn" style="margin-top:10px;">
                    	<c:if test="${fitting.taobao_links!=null&&fitting.taobao_links!=''}"><a style="color:#FFF" href="${fitting.taobao_links}" target="_blank">购买</a> </c:if>
                    </div>               
                </td>
            </tr>
            <tr>
            	<tr>
                	<td colspan="3">
                    	<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr><td>
                            	<div class="category">
                                    <div class="_title f" style="text-align: left">配件特性</div>
                                    <div class="_line"></div>
                                    
                                    <div class="text desc" style="color:#000">${fitting.fitting_desc }</div>  
                                     
                              </div>
                            </td></tr>
                            <tr><td>
                            	<div class="category">
                                    <div class="_title f" style="text-align: left">售后保障</div>
                                    <div class="_line"></div>
                                    
                                    <div class="text desc" style="color:#000">${fitting.sale_protection }</div> 

                                </div>
                            </td></tr>
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
		//适 用 型 号
		var _models='${fitting.models}';
		if(_models!=null&&_models!=""){
			var _modelsArr=_models.split(";");
			var tableHtml="";
			for ( var i = 0; i < _modelsArr.length; i++) {
             	if((i+1)%3==1){
             		tableHtml+="<tr>";
             		//$("#models").append("<tr>");
             	}
					//$("#models").append("<td align='left'>"+_modelsArr[i]+"</td>");
					tableHtml+="<td align='left'>"+_modelsArr[i]+"</td>";
				if((i+1)%3==0){
             		//$("#models").append("</tr>");
					tableHtml+="</tr>";
             	}
			}
			$("#models").append(tableHtml);
			
		}
		
		
		$.searchList();
		$.searchTxt();
		$.menu();		
		$.tootip({IMG:"<%=allurl%><%=IMG%>",type:true,about:"<%=request.getContextPath()%>/client/about"});
		$.onlineCustomers({url:"<%=request.getContextPath()%>"});

		
		$(".texin_div").mCustomScrollbar();
		
		$(".product_list ul li").click(function(){
			$(".product_list ul li").each(function(){
				$(this).removeClass("selected");
			});
			$(this).addClass("selected");;
		});
		
		$(".category .content").hover(
			function(){
				$($(this).find(".line")).css("background-color","#FF4400");
			},
			function(){
				$($(this).find(".line")).css("background-color","#CCC");
			});
	});	
</script>