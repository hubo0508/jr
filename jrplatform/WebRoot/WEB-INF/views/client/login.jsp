<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	
	
	String IMG = path + "/resources/client/img";
	String CLIENT = path + "/client";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  
   	<%@ include file="/common/common.jsp" %>
   	
   	 <title>金嵘用户登录</title>
   	 
  </head>
  
  <style>
	.login_content{-webkit-border-radius: 3px;-moz-border-radius: 3px;border-radius: 3px;border:5px solid #E8E8E8; width:100%; height:300px; background-color:#FFF}
	.textspan{ font-size:12px; color:#999}
	.login_text{width:300px; height:28px; margin-top:3px; line-height:28px; border:1px solid #CCC}
	.login_text:hover{ border:1px solid #7ABD54;}
	.login_text:focus{outline: 0;}	
	
	.a{ font-size:12px; color:#06F}
	.a:hover{ color:#Fc4400}
  </style>
  
  <body>
    <center>
	<div style="width:920px; text-align:left">
		
		<img src="<%=IMG %>/login_lt.png" style="margin-top:20px; cursor:pointer" 
		onclick="window.location='<%=CLIENT %>/'" title="点击跳转直首页"/>
		
		<br /> <br /> <br /> <br />
		
		<div class="login_content">
			<div style="width:100%; height:100%; border:1px solid #D5D5D5">
				<table width="100%">
					<tr>
						<td width="60%" align="center">
							<img src="<%=IMG %>/zhuanzhuyu.png"/>
						</td>
						<td width="40%" align="left">
							<br />
							<span class="textspan">已注册用户名</span><br />
							
							<input id="username" type="text" class="login_text"/>
								<img src="<%=IMG %>/u.png" style="margin-left:-30px; margin-bottom:-6px;"/>
							<br /><br />
							
							<span class="textspan">密码</span><br />
							<input id="password" type="password" class="login_text"/>
							<img src="<%=IMG %>/p.png" style="margin-left:-28px; margin-bottom:-3px;"/>
							
							<br /><br />
							<span class="textspan">验证码</span><br />
                                <input id="kaptcha" type="text" style="width:120px;" class="login_text"/>
                                <img style="margin-bottom:-10px; margin-left:30px;" width="52" height="27"
                                	 src="${pageContext.servletContext.contextPath}/captcha" id="kaptchaImage"
                                	 onclick="document.getElementById('kaptchaImage').src='${pageContext.servletContext.contextPath}/captcha?'+Math.random()"/>
                                <span class="textspan" style="color:#005AA0; cursor:pointer"
                                	 onclick="document.getElementById('kaptchaImage').src='${pageContext.servletContext.contextPath}/captcha?'+Math.random()">看不清？换一张</span>
                                <br /><br />
                                
							
							<input type="image" src="<%=IMG %>/longin_btn.png" class="loginbtn"/> 
							<input type="image" src="<%=IMG %>/regbtn.png" onclick="window.location='<%=CLIENT %>/registered'"/>
							
							 <br />
                              <a href="<%=path %>/client/forgotPassword" class="a">忘记密码？</a>
                              <a href="<%=path %>/login" class="a" target="_blank">管理员登录</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	</center>
    
  </body>
  
  <script language="javascript" type="text/javascript">
	
	$(function(){   
		enterEventListener();
		$(".loginbtn").click(login);
	});
	
	/**
	 * 监听enter事件
	 */
	function enterEventListener()
	{
		var $inp = $('.login_text');
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
        	alert("请输入用户名！");
        	return;
        }
        
        var _p = $("#password").attr("value");
        if(_p == ""){
        	alert("请输入密码！");
        	return;
        }
        
        var _captcha = $("#kaptcha").attr("value");
        if(_captcha == ""){
        	alert("请输入验证码！");
        	return;
        }
		
        $.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/client/login",
			dataType:"json",
			data:"username="+_u+"&password="+_p+"&kaptcha="+_captcha,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					window.location = "${basePath}/client/learn";
				}else{
					document.getElementById('kaptchaImage').src='${pageContext.servletContext.contextPath}/captcha?'+Math.random();
					alert(msg.message);
				}
			}
		});
	}
</script>
</html>

