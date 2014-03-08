<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>金嵘厨房后台管理用户登录</title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/jquery-1.7.js"></script>
    
  </head>
	<style>
		html,body{ margin:0px; font-size:12px;}
		.container{background-image:url(${pageContext.servletContext.contextPath}/resources/backstage/image/title_.png); background-repeat:no-repeat; width:852px; height:314px; margin-top:50px; position:relative}
		.container table{ position:absolute; right:0px; bottom:0px; font-size:12px;}
		
		.txt{border:1px solid #47ACDF;padding: 0.3em 0.4em; width:180px;}
		
		.txt:hover {border:1px solid #147DB2; }
		.delu{ width:57px; height:21px; display:block; background-image:url(${pageContext.servletContext.contextPath}/resources/backstage/image/denglu_bg.png); float:right; cursor:pointer; margin-top:15px; margin-right:28px;}
		.delu:hover{ background-position:-57px 0px;}
		.cozi{width:57px; height:21px; display:block; margin-right:15px; margin-top:15px; background-image:url(${pageContext.servletContext.contextPath}/resources/backstage/image/denglu_bg.png); background-position:0px -21px; float:right; cursor:pointer}
		.cozi:hover{background-position:-57px -21px;}
	</style>
<body style="background-image:url(${pageContext.servletContext.contextPath}/resources/backstage/image/bg_.png); background-repeat:repeat-x">
<center>
	<div class="container">
    	<span id="tootip" style=" color:#F00; position:absolute; right:170px; bottom:0px; background-color:#CCC; display:none">正在登录，请稍后... ...</span>
    	<table border="0" cellpadding="0" cellspacing="0">
        	<tr>
            	<td>用户名：</td>
                <td><input type="text" class="txt" id="username"/></td>
                <td width="60" align="right">密码：</td>
                <td><input type="password" class="txt" id="password"/></td>
            </tr>
             <tr height="10"><td colspan="4"></td></tr>
            <tr>
            	<td></td>
                <td></td>
                <td width="60" align="right">验证码：</td>
                <td align="right">
                	<input id="kaptcha" type="text" style="width:50px;" class="txt"/>
                    <img id="kaptchaImage" src="${pageContext.servletContext.contextPath}/captcha" 
                        style="margin-bottom:-10px; margin-left:10px;" width="52" height="27"
                        onclick="document.getElementById('kaptchaImage').src='${pageContext.servletContext.contextPath}/captcha?'+Math.random()"/>
                    <span class="textspan" style="color:#005AA0; cursor:pointer" 
                        onclick="document.getElementById('kaptchaImage').src='${pageContext.servletContext.contextPath}/captcha?'+Math.random()">看不清？换一张</span>
                </td>
            </tr>
            <tr>
            	<td></td>
                <td></td>
                <td width="60" align="right"></td>
                <td align="right">
                	<span class="delu"></span>
                    <span class="cozi"></span>
                </td>
            </tr>
        </table>
    </div>
</center>
</body>
</html>
<script language="javascript" type="text/javascript">
	
	$(function(){   
		enterEventListener();
		
		$(".delu").click(login)
		$(".cozi").click(function(){
			$("#username").attr("value","");		
			$("#password").attr("value","");		
			$("#kaptcha").attr("value","");	
		});
	});
	
	
	/**
	 * 监听enter事件
	 */
	function enterEventListener()
	{
		var $inp = $('.txt');
        $inp.bind('keydown', function (e) {
            if (e.which == 13) 
            {
                e.preventDefault();
                login();
            }
        });
	}
	
	/*
	 * 登录操作
	 */
	function login()
	{
		var _u = $("#username").attr("value");
        if(_u == ""){
       	 	showMessage("请输入用户名！");
        	return;
        }
        
        var _p = $("#password").attr("value");
        if(_p == ""){
        	showMessage("请输入密码！");
        	return;
        }
        
        var _captcha = $("#kaptcha").attr("value");
        if(_captcha == ""){
        	showMessage("请输入验证码！");
        	return;
        }
		
		$("#tootip").fadeIn();	
        $.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/login",
			dataType:"json",
			data:"username="+_u+"&password="+_p+"&kaptcha="+_captcha,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					window.location = "${pageContext.servletContext.contextPath}/system/index";
				}else{
					document.getElementById('kaptchaImage').src='${pageContext.servletContext.contextPath}/captcha?'+Math.random();
					$("#tootip").html(msg.message);
					setTimeout(function(){
						$("#tootip").fadeOut();					
					},5000)
				}
			}
		});
	}
	
	function showMessage(msg) 
	{ 
		$("#tootip").html(msg);
		$("#tootip").fadeIn();
		setTimeout(function(){
			$("#tootip").fadeOut();					
		},5000)
	} 

</script>
