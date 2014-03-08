<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	
	<title>糟糕……</title>
	
	<link href="<%=request.getContextPath()%>/css/index.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.blockUI.js"></script>
    
</head>

<style>
	.forgotp{width:965px; background-color:#FFF;  min-height:500px; padding-left:25px;}
	.r1{font-size: 45px;font-weight: bold;line-height: 120%;}
	.r2{font-size: 26px;font-weight: bold;line-height: 110%;}
	.r3{margin-bottom: 30px;font-size: 14px;}
	.r3 span{font-weight: bold;color: #2a6cb4;line-height: 100%;}
    .r0{font-size: 68px;font-weight: bold;color: #296db5;line-height: 100%;margin-bottom: 30px;}
	.r0 a:link {color: #296db5; text-decoration:none;}
	.r0 a:visited {color: #296db5; text-decoration:none;}	
	.r0 a:hover {color: #970002; text-decoration:none;}
	.r0 a:active {color: #296db5;text-decoration:none;}
</style>

<body>	
     
    <center>
	   	<div class="forgotp" align="left">
	   	  <div style="height:80px;">&nbsp;</div>
	   	  <p class="r1">糟糕……</p>
	   	  <p class="r2">好像出了些问题，我们深表抱歉。</p>
	   	  <p class="r3"> 遇到技术性错误 <span>我们会尽快处理</span> 并非您的失误。</p>
	      <p class="r0"><a href="${pageContext.servletContext.contextPath}/client/index">接下来您可返回我们的首页</a></p>
	    </div>
    </center> 
    
</body>
</html>
