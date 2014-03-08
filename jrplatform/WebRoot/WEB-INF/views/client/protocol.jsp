<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String CSS = path + "/resources/client/css";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  	<%@ include file="/common/common_client.jsp" %>
  	
    <link href="<%=CSS %>/style.css" rel="stylesheet" type="text/css" />
    
</head>

<style>
</style>

<body>
	 <pre><div class="new-content format" style="margin-top:-50px;" align="left">
      	${queryProtocol.protocold }
      </div></pre>
</body>
</html>
 