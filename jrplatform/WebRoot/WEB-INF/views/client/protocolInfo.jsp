<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	
	String allurl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String filedir = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + "/";
	
	String JS = path + "/resources/client/js";
	String CSS = path + "/resources/client/css";
	String IMG = path + "/resources/client/img";
	String IMAGE = path + "/resources/client/image";
	String CLIENT = path + "/client";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  	<%@ include file="/common/common_client.jsp" %>
  	
  	<title>金嵘厨房 用户协议</title>
    
    <script src="<%=JS %>/index.js" type="text/javascript"></script>
    <link href="<%=CSS %>/style.css" rel="stylesheet" type="text/css" />
    
</head>

<style>
	.daohang{padding:0px 0px 15px0px; font-size:14px;}
	.daohang a{text-decoration:none; color:#005AA0}
	.daohang a:hover{text-decoration:none; color:#FF4400}
	.content-div-info{background-color:#FFFFFF;  min-height:600px; margin-top:0px; margin-top:0px\9;}
	.content-div-info .pub_title{color: #000;font-family: "微软雅黑", "黑体";font-size: 22px;font-weight: normal;height: 35px;line-height: 35px;
								 text-align: center;padding-top:20px; }
	.content-div-info .pub_date{ font-size:13px; font-family:"宋体";text-align: center; color:#666}
	.content-div-info .pub_workUnit{font-size:13px; color:#666; font-family:"宋体";text-align: center;}
	.content-div-info .new-content{padding-top:10px; padding-left:10px; padding-right:10px; padding-bottom:10px;}
	.content-div-info .error{padding:10px 10px 10px 10px; text-align:center; color:#F00}
	.red_e{color:#F00; font-size:12px;}
	.nan{color:#6D6D6D}
	.i_line{border-top:none; border-left:none; border-right:none; border-bottom:1px solid #D1D1D1; margin-left:12px; margin-right:12px; margin-top:8px; margin-bottom:5px;}

</style>

<body>
	<center>
		
		<c:import url="/client/menu/protocolInfo"/>
        
        <div class="container">
	        <pre><div class="new-content format" style="margin-top:-50px;" align="left">
	      	${queryProtocol.protocold }
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
		$.tootip({IMG:"<%=allurl%><%=IMG%>"});
		$.onlineCustomers({url:"<%=request.getContextPath()%>"});
	})	
</script>
 