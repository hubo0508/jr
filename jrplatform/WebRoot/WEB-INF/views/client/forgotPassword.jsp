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
  	
  	<title>金嵘厨房 找回密码</title>
    
    <script src="<%=JS %>/index.js" type="text/javascript"></script>
    <link href="<%=CSS %>/style.css" rel="stylesheet" type="text/css" />
    
</head>

<body>
	<center>
		
		<c:import url="/client/menu/protocolInfo"/>
        
        <div class="container">
	       	<style>
		    	.fp tr td{ padding-top:2px; padding-bottom:2px;}
		    	.text{width:300px; height:28px; margin-top:3px; line-height:28px; border:1px solid #CCC}
				.text:hover{ border:1px solid #7ABD54;}
				.text:focus{outline: 0;}	
		    </style>
		    
		    <table class="fp" style="font-size:12px; margin-left:30px; margin-top:50px;">
		    	<tr>
		            <td><h2>找回密码：</h2></td>
		        </tr>
		        <tr>
		            <td>填写帐号</td>
		        </tr>
		        <tr>
		            <td><input name="username" type="text" class="text"/></td>
		        </tr>
		        <tr>
		            <td>填写注册邮箱</td>
		        </tr>
		        <tr>
		            <td><input name="contact_email" type="text" class="text"/></td>
		        </tr>
		        <tr>
		            <td><input type="button" value="提交"  onclick="findPassword()"/></td>
		        </tr>
		    </table>
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
	});
	function findPassword(){
	
		var username=$("input[name='username']").val();
		if(username == null && username.length <=0 ){
			alert("请填写用户名！");
			return;
		}
		
		var contact_email=$("input[name='contact_email']").val();
		if(contact_email == null && contact_email.length <=0 ){
			alert("请填写注册邮箱！");
			return;
		}
		
	    $.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/client/forgotpassword",
			dataType:"json",
			data:"username="+username+"&contact_email="+contact_email,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				alert(msg.object || msg.message);
				if((msg.success+"") == "true"){
					window.location = "${basePath}/client";
				}
			}
		});
	}

</script>
 