<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	
	String allurl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String filedir = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + "/";
	
	String JS = path + "/resources/client/js";
	String CSS = path + "/resources/client/css";
	String IMG = path + "/resources/client/img";
	String CLIENT = path + "/client";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	
   <%@ include file="/common/common_client.jsp" %>
   
   <title>金嵘厨房 用户修改密码</title>
   
</head>
<style>
	.login_content{-webkit-border-radius: 3px;-moz-border-radius: 3px;border-radius: 3px; border:5px solid #E8E8E8; width:100%;  background-color:#FFF;}
	
	*{font-size:12px;}
	
	.sp{ font-size:13px;}
	.login_text{width:300px; height:28px; margin-top:3px; line-height:28px; border:1px solid #CCC}
	.login_text:hover{ border:1px solid #7ABD54;}
	.login_text:focus{outline: 0;}	
	
	.login_title{border:1px solid #CDCDCD; border-left:none; border-right:none;background-color:#EEEEEE; padding-top:5px; padding-bottom:5px; font-size:13px; padding-left:20px;}
	
	.red{ color:#F00}
	.textspan{ font-size:12px; color:#999}
	table tr td{ height:40px;}
	
	.msg{ border:1px solid #CDCDCD; background-color:#EEEEEE; width:300px; display:none; font-size:12px; padding:0.7em 0.7em;}
	
	.login{ width:920px; text-align:right; font-size:13px;}
	.login a{ color:#000; text-decoration:none}
	.login a:hover{ color:#005AA0}
	
	.search_list_mask{top:0px; left:0px; background-color:#000; position:absolute}
	
	.xiyi{ font-size:13px;}
	.xiyi a{ color:#005AA0; text-decoration:none}
	.xiyiinfo{position:fixed; -webkit-border-radius: 3px;-moz-border-radius: 3px;border-radius: 3px; top:85px;
		border:5px solid #E8E8E8; background-color:#FFF; width:920px; height:500px; display:none}
	.xiyiinfo .dtitle{ height:28px; text-align:center; background-image:url(<%=IMG%>/title.png); background-repeat:repeat-x; width:100%; font-weight:bold}
	.btn{ display:block;background-color:#E43E42; padding-top:8px; padding-bottom:8px; margin-top:25px; width:220px; text-align:center; font-weight:bold; color:#FFF; cursor:pointer}
	.btn:hover{background-color:#EA5154;}
</style>

<body>
	<center>
    	<div class="login">
			<c:choose>
				<c:when test="${cust_user.username != null }">
					${cust_user.username },您好！欢迎来到金嵘厨房学习中心！<a href="<%=CLIENT %>/usersOff">[退出]</a>&nbsp;<a href="<%=CLIENT %>/registered">[免费注册]</a>
				</c:when>
				<c:otherwise>
					游客，您好！欢迎来到金嵘厨房学习中心！<a href="<%=CLIENT %>/login">[登录]</a>&nbsp;<a href="<%=CLIENT %>/registered">[免费注册]</a>
				</c:otherwise>
			</c:choose>
		</div>
        <div style="width:920px; text-align:left">
            <img src="<%=IMG %>/login_lt.png" style=" margin-top:20px;cursor:pointer" onclick="window.location='<%=CLIENT %>/'"/>
            <br />
            <br />
            <br />
            <br />
            <div class="login_content">
            	<div style="width:100%; height:100%; border:1px solid #D5D5D5;  padding-top:20px; padding-bottom:40px;">
                	<table width="100%" border="0" cellpadding="0" cellspacing="0">
                    	<tr>
                        	<td colspan="4" height="30"><div class="login_title">账户信息</div></td>
                        </tr>
                    	<tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">用户名：</span></td>
                            <td width="35%" valign="middle" align="left">${p.username}</td>
                            <td width="41%" valign="middle" align="left"></td>
                        </tr>
                         <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">旧密码：</span></td>
                            <td width="35%" valign="middle" align="left"><input id="oldPassword" type="password" class="login_text"/></td>
                            <td valign="middle" align="left"><div class="msg">长度应大于6个字字符</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">新密码：</span></td>
                            <td width="35%" valign="middle" align="left"><input id="firstPassword" type="password" class="login_text"/></td>
                            <td valign="middle" align="left"><div class="msg">长度应大于6个字字符</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">确认新密码：</span></td>
                            <td width="35%" valign="middle" align="left"><input id="confirmPassword" type="password" class="login_text"/></td>
                            <td valign="middle" align="left"><div class="msg">长度应大于6个字字符</div></td>
                        </tr>
                         <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">验证码：</span><span class="red">*</span></td>
                            <td width="35%" valign="middle" align="left">
                            	<input id="kaptcha" type="text" style="width:120px;" class="login_text"/>
                                <img id="kaptchaImage" src="${basePath}/captcha" 
								style="margin-bottom:-10px; margin-left:30px;" width="52" height="27"
								onclick="document.getElementById('kaptchaImage').src='${basePath}/captcha?'+Math.random()"/>
							<span class="textspan" style="color:#005AA0; cursor:pointer" 
								onclick="document.getElementById('kaptchaImage').src='${basePath}/captcha?'+Math.random()">看不清？换一张</span>
                            </td>
                            <td valign="middle" align="left"><div class="msg">输入验证码</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right">&nbsp;</td>
                            <td colspan="2" align="left" valign="middle" class="xiyi">
                              	<span class="btn" id="applyNow">保存</span>
                           </td>
                        </tr>     
                        <tr>
                        	<td colspan="4" height="30"><div class="login_title">公司注册信息</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">公司名称：</span></td>
                            <td width="35%" valign="middle" align="left">${p.company_name}</td>
                            <td valign="middle" align="left"></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">公司地址：</span></td>
                            <td width="35%" valign="middle" align="left">${p.company_address}</td>
                            <td valign="middle" align="left"></td>
                        </tr>
                        <tr>
                        	<td colspan="4" height="30"><div class="login_title">联系信息</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">联系人：</span></td>
                            <td width="35%" valign="middle" align="left">${p.contact}</td>
                            <td valign="middle" align="left"></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">所在部门：</span></td>
                            <td width="35%" valign="middle" align="left">${p.where_department}</td>
                            <td valign="middle" align="left"></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">座机号：</span></td>
                            <td width="35%" valign="middle" align="left">${p.fixed_telephone}</td>
                            <td valign="middle" align="left"></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">手机号：</span></td>
                            <td width="35%" valign="middle" align="left">${p.phone}</td>
                            <td valign="middle" align="left"></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">联系人邮箱：</span></td>
                            <td width="35%" valign="middle" align="left">${p.contact_email}</td>
                            <td valign="middle" align="left"></td>
                        </tr>
                        <tr>
                        	<td colspan="4" height="30"><div class="login_title">公司性质</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right">&nbsp;</td>
                            <td colspan="2" align="left" valign="middle">
                              ${p.company_nature}</td>
                        </tr>
                        <tr>
                        	<td colspan="4" height="30"><div class="login_title">经营领域</div></td>
                        </tr>
                         <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right">&nbsp;</td>
                            <td colspan="2" align="left" valign="middle">${p.business_areas}                            
                           </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </center>

    <div id="loading" style="display:none; position:fixed; background-color:#090; color:#FFF; padding:0.5em 0.5em; left:200px; top:10px; font-size:12px;">正在提交，请稍后！</div>
</body>
</html>
<script>
	$(document).ready(function(){
					
		$("#applyNow").click(function(){
									  
			var _oldPassword = $("#oldPassword").attr("value");
			if(_oldPassword == null || _oldPassword.length <=0){alert("旧密码不能为空!");return;}
			
			var _firstPassword = $("#firstPassword").attr("value");
			var _confirmPassword = $("#confirmPassword").attr("value");
			if(_firstPassword == null || _firstPassword.length <=0){alert("密码不能为空!");return;}
			if(_confirmPassword == null || _confirmPassword.length <=0){alert("确认密码不能为空!");return;}
			if(_firstPassword != _confirmPassword){alert("两次密码不相同");return;}
			
			var _kaptcha = $("#kaptcha").attr("value");
			if(_kaptcha == null || _kaptcha.length <=0){alert("验证码不能为空！"); return;}
			
			$("#loading").fadeIn();
			$.ajax({
				type:"post",
				url : "${pageContext.servletContext.contextPath}/client/updatepassword",
				dataType:"json",
				data:"password="+_firstPassword+"&kaptcha="+_kaptcha+"&oldPassword="+_oldPassword,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				success : function(msg) {
				
					document.getElementById('kaptchaImage').src='${pageContext.servletContext.contextPath}/captcha?'+Math.random();
					
					$("#loading").fadeOut();
					
					if((msg.success+"") == "true"){
						alert("修改成功，请重新登录！");
						window.location = "${pageContext.servletContext.contextPath}/client/login";
					}else{
						alert(msg.message);
					}
				}
			});
		})
						   
		var change = function(event)
		{			
			var msg = $(this).parent().parent().find("td:last").children()[0];
			
			if(event.type == "blur")
			{
				$(msg).css("display","none");
				return;
			}
			
			if(event.type == "click")
			{
				$(msg).css("display","block");
				return;
			}
			
			if(event.type == "focus")
			{
				$(msg).css("display","block");
				return;
			}
			
			if(event.type == "keyup")
			{
				$(msg).css("display","block");
				return;
			}
		}
		
		var jSTxt = $(".login_text");
			jSTxt.focus(change);
			jSTxt.blur(change);
			jSTxt.keyup(change);
			jSTxt.click(change);
		
});
</script>
   