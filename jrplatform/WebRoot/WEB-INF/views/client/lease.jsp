<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	
	String allurl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	
	String JS = path + "/resources/client/js";
	String CSS = path + "/resources/client/css";
	String IMG = path + "/resources/client/img";
	String CLIENT = path + "/client";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  	<%@ include file="/common/common_client.jsp" %>
  	
  	<title>金嵘厨房 租凭服务</title>
	
    <script src="<%=JS %>/index.js" type="text/javascript"></script>
    <script src="<%=JS %>/marquee.js" type="text/javascript"></script>
    <link href="<%=CSS %>/style.css" rel="stylesheet" type="text/css" />
    
</head>
<style>
	#cp {position:relative;width: 920px;overflow:hidden; padding-top:5px}
#cp  a{ position:relative}
#cp img {border:1px solid #FFF;}
#cp img:hover { border:1px solid #FF4400;}
#cp dl, #cp dt,#cp dd,#cp a {float:left;margin:0;padding:0;}
#cp dl{width:1000%;height:202px;}
.bar{width:200px;  display:block; position:absolute; bottom:0px; left:0px; border:1px solid; color:#FF4400;
			font-size:16px; padding-top:5px; padding-bottom:5px;}
	.pro_desc_p a{ color:#000; text-decoration:none}
			.pro_desc_p a:hover{ color:#09F; text-decoration:underline}
</style>
</style>
<body>
	<center>
	
    	<!-- 头部 -->
		<c:import url="/client/menu/lease"/>
		<!-- 头部 --> 
    	  
    	  
    	<br /><br />
        <img src="<%=IMG %>/zhuing_1.png" />
        <br /><br />
       	
       	<c:if test="${queryScrollProductToLease.success == true}"></c:if>
		 <div id="cp">
	          <dl>
	            <dt>
	              <c:forEach var="sctl" items="${queryScrollProductToLease.object}" > 
	               <a href="<%=CLIENT %>/product/getProductByProductId/${sctl.id }" target="_blank">
	               		<div class="bar" align="center">
	                    	<span>${sctl.product_name }</span>
	                    </div>
	                    <div style="min-width:200px;height:202px;">
	                    	<img src="${sctl.image_url }" width="200" height="200"/>
	                    </div>
	               </a>
	              </c:forEach>
	            </dt>
	            <dd></dd>
	          </dl>
	        </div>
        </if>
        
        <style>
			.pro_desc_p{line-height:25px; color:#666; font-size:16PX;}
			.pro_desc_p span{ padding:3px 8px 3px 5px; cursor:pointer; color:#005AA0}
			.pro_desc_p span:hover{color:#FF4400}
		</style>
        <div class="container" align="left">
           
            
           <br /><br />
           <img src="<%=IMG %>/zhuping_.png" />
           
           <br /><br /><br />
           <div>
             <img src="<%=IMG %>/zhuping_2.png" />
            <p class="pro_desc_p" style="color:#005AA0; float:right">
           		附：
           		<a href="${queryLeaseInfo.contract_url }">${queryLeaseInfo.contract_name }</a>
           </p>
            </div>
           
           <div style="border-bottom:1px dotted #CCC"></div>
           	
            <pre style=" margin-bottom"><div class="new-content format" style="margin-top:-50px;" align="left">
            	${queryLeaseInfo.description }
            </div></pre>
           
       </div>
        
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
		
		Marquee("cp");
	})
	
</script>