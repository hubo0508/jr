<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	
	String IMG = path + "/resources/client/img";
	String CLIENT = path + "/client";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	
   <%@ include file="/common/common_client.jsp" %>
   
   <title>金嵘用户注册</title>
   
</head>
<style>
	.login_content{-webkit-border-radius: 3px;-moz-border-radius: 3px;border-radius: 3px; border:5px solid #E8E8E8; width:100%;  background-color:#FFF;}
	
	
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
	
	.ul{ font-size:13px; list-style:none; margin-left:-40px; margin-top:-7px;}
	.ul li{ width:200px; padding-top:5px; padding-bottom:5px; float:left}
	
	.xiyi{ font-size:13px;}
	.xiyi a{ color:#005AA0; text-decoration:none}
	.xiyiinfo{position:fixed; -webkit-border-radius: 3px;-moz-border-radius: 3px;border-radius: 3px; top:85px;
		border:5px solid #E8E8E8; background-color:#FFF; width:920px; height:500px; display:none}
	.xiyiinfo .dtitle{ height:28px; text-align:center; background-image:url(<%=IMG%>/title.png); background-repeat:repeat-x; width:100%; font-weight:bold}
	.btn{ display:block;background-color:#E43E42; padding-top:8px; padding-bottom:8px; margin-top:25px; width:220px; text-align:center; font-weight:bold; color:#FFF; cursor:pointer}
	.btn:hover{background-color:#EA5154;}
	
	.search_list_mask{top:0px; left:0px; background-color:#000; position:absolute}
</style>

<body>
	<center>
    	<div class="login">
            您好！欢迎来到金嵘厨房！<a href="<%=CLIENT %>/login">[登录]</a>&nbsp;<a href="<%=CLIENT %>/registered">[免费注册]</a>
        </div>
        <div style="width:920px; text-align:left">
            <img src="<%=IMG %>/reg_lt.png" style="margin-top:20px;cursor:pointer" 
            onclick="window.location='<%=CLIENT %>/'" title="点击跳转直首页"/>
            
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
                            <td width="23%" valign="middle" align="right"><span class="sp">用户名：</span><span class="red">*</span></td>
                            <td width="35%" valign="middle" align="left"><input id="username" type="text" class="login_text"/></td>
                            <td width="41%" valign="middle" align="left"><div class="msg">邮箱/用户名/手机号</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">密码：</span><span class="red">*</span></td>
                            <td width="35%" valign="middle" align="left"><input id="firstPassword" type="password" class="login_text"/></td>
                            <td valign="middle" align="left"><div class="msg">长度应大于6个字字符</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">确认密码：</span><span class="red">*</span></td>
                            <td width="35%" valign="middle" align="left"><input id="confirmPassword" type="password" class="login_text"/></td>
                            <td valign="middle" align="left"><div class="msg">长度应大于6个字字符</div></td>
                        </tr>
                        <tr>
                        	<td colspan="4" height="30"><div class="login_title">公司注册信息</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">公司名称：</span><span class="red">*</span></td>
                            <td width="35%" valign="middle" align="left"><input id="company_name" type="text" class="login_text"/></td>
                            <td valign="middle" align="left"><div class="msg">输入公司名称</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">公司地址：</span><span class="red">*</span></td>
                            <td width="35%" valign="middle" align="left"><input id="company_address" type="text" class="login_text"/></td>
                            <td valign="middle" align="left"><div class="msg">输入公司地址</div></td>
                        </tr>
                        <tr>
                        	<td colspan="4" height="30"><div class="login_title">联系信息</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">联系人：</span><span class="red">*</span></td>
                            <td width="35%" valign="middle" align="left"><input id="contact" type="text" class="login_text"/></td>
                            <td valign="middle" align="left"><div class="msg">输入公司联系人</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">所在部门：</span></td>
                            <td width="35%" valign="middle" align="left"><input id="where_department" type="text" class="login_text"/></td>
                            <td valign="middle" align="left"><div class="msg">输入公司联系人所在部门</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">座机号：</span><span class="red">*</span></td>
                            <td width="35%" valign="middle" align="left"><input id="fixed_telephone" type="text" class="login_text"/></td>
                            <td valign="middle" align="left"><div class="msg">输入公司座机号</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">手机号：</span><span class="red">*</span></td>
                            <td width="35%" valign="middle" align="left"><input id="phone" type="text" class="login_text"/></td>
                            <td valign="middle" align="left"><div class="msg">输入联系人手机号</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right"><span class="sp">联系人邮箱：</span><span class="red">*</span></td>
                            <td width="35%" valign="middle" align="left"><input id="contact_email" type="text" class="login_text"/></td>
                            <td valign="middle" align="left"><div class="msg" style="color:#F00">联系人邮箱用于接收注册审核是否通过，请仔细填写</div></td>
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
                        	<td colspan="4" height="30"><div class="login_title">公司性质</div></td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right">&nbsp;</td>
                            <td colspan="2" align="left" valign="middle"><div class="msg"></div>
                              <ul class="ul">
                                <li><input name="company_nature" type="checkbox" value="维修公司/工程师" />维修公司/工程师</li>
                                <li><input name="company_nature" type="checkbox" value="设备制造商" />设备制造商</li>
                                <li><input name="company_nature" type="checkbox" value="设备经销商" />设备经销商</li>
                                <li><input name="company_nature" type="checkbox" value="咖啡公司" />咖啡公司</li>
                                <li><input name="company_nature" type="checkbox" value="工程公司" />工程公司</li>
                                <li><input name="company_nature" type="checkbox" value="烘焙商" />烘焙商</li>
                                <li><input name="company_nature" type="checkbox" value="连锁机构" />连锁机构</li>
                                <li><input name="company_nature" type="checkbox" value="个体户" />个体户</li>
                                <li><input name="company_nature" type="checkbox" value="授权维修商" />授权维修商</li>
                                <li><input name="company_nature" type="checkbox" value="其它" />其它</li>
                            </ul></td>
                        </tr>
                        <tr>
                        	<td colspan="4" height="30"><div class="login_title">经营领域</div></td>
                        </tr>
                         <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right">&nbsp;</td>
                            <td colspan="2" align="left" valign="middle"><ul class="ul">
                              <li><input name="business_areas" type="checkbox"  value="西餐炉具" />西餐炉具</li>
                              <li><input name="business_areas" type="checkbox" value="烤箱" />烤箱</li>
                              <li><input name="business_areas" type="checkbox" value="洗碗机" />洗碗机</li>
                              <li><input name="business_areas" type="checkbox" value="制冰机" />制冰机</li>
                              <li><input name="business_areas" type="checkbox" value="专业意式咖啡机" />专业意式咖啡机</li>
                              <li><input name="business_areas" type="checkbox" value="全自动咖啡机" />全自动咖啡机</li>
                              <li><input name="business_areas" type="checkbox" value="酒吧设备" />酒吧设备</li>
                              <li><input name="business_areas" type="checkbox" value="食品加工设备" />食品加工设备</li>
                              <li><input name="business_areas" type="checkbox" value="烘焙设备" />烘焙设备</li>
                              <li><input name="business_areas" type="checkbox" value="快餐设备" />快餐设备</li>
                              <li><input name="business_areas" type="checkbox" value="保温设备" />保温设备</li>
                              <li><input name="business_areas" type="checkbox" value="其他" />其他</li>
                            </ul>                             
                           </td>
                        </tr>
                        <tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right">&nbsp;</td>
                            <td colspan="2" align="left" valign="middle" class="xiyi">
                              	<input type="checkbox" checked="true" id="readme" />
                        	    <label for="protocol">我已阅读并同意<a href="javascript:void(0)" id="protocol">《金嵘厨房用户注册协议》</a></label>
                           </td>
                        </tr>
                       	<tr>
                        	<td width="1%" align="center">&nbsp;</td>
                            <td width="23%" valign="middle" align="right">&nbsp;</td>
                            <td colspan="2" align="left" valign="middle" class="xiyi">
                              	<span class="btn" id="applyNow">立即申请</span>
                           </td>
                        </tr>                              
                    </table>
                </div>
            </div>
        </div>
    </center>
    
    <div class="xiyiinfo" align="center">
    	<div class="dtitle"><span style="padding-top:5px; display:block">金嵘用户协议</span></div>
        <iframe height="380" width="100%" src="<%=CLIENT %>/protocol" frameborder="0"></iframe>
        <span class="btn">同意并继续</span>
    </div>
    
    <div id="loading" style="display:none; position:fixed; background-color:#090; color:#FFF; padding:0.5em 0.5em; left:200px; top:10px; font-size:12px;">正在提交，请稍后！</div>
</body>
</html>
<script>
	$(document).ready(function(){
					
		$("#applyNow").click(function(){
			
			if($("#readme").attr("checked") == undefined){
				return;
			}
									  
			var _username = $("#username").attr("value");	
			if(_username == null || _username.length <=0){alert("用户名不能为空！"); return;}
			if(_username.length<4 || _username.length>20){alert("用户名字符长度应>=4，并且小于20!"); return;}
			
			var _firstPassword = $("#firstPassword").attr("value");
			var _confirmPassword = $("#confirmPassword").attr("value");
			if(_firstPassword == null || _firstPassword.length <=0){alert("密码不能为空!");return;}
			if(_confirmPassword == null || _confirmPassword.length <=0){alert("确认密码不能为空!");return;}
			if(_firstPassword != _confirmPassword){alert("两次密码不相同");return;}
			
			var _company_name = $("#company_name").attr("value");	
			if(_company_name == null || _company_name.length <=0){alert("公司名称不能为空！"); return;}
			if(_company_name.length<4 || _company_name.length>100){alert("公司名称字符长度应>=4，并且小于100!"); return;}
			
			var _company_address = $("#company_address").attr("value");	
			if(_company_address == null || _company_address.length <=0){alert("公司地址不能为空！"); return;}
			if(_company_address.length<4 || _company_address.length>100){alert("公司地址字符长度应>=4，并且小于100!"); return;}
			
			var _contact = $("#contact").attr("value");	
			if(_contact == null || _contact.length <=0){alert("联系人不能为空！"); return;}
			if(_contact.length<2 || _contact.length>50){alert("联系人字符长度应>=2，并且小于50!"); return;}
			
			var _where_department = $("#where_department").attr("value");	
			//if(_where_department.length<2 || _where_department.length>20){alert("所在部门字符长度应>=2，并且小于50!"); return;}
			
			var _fixed_telephone = $("#fixed_telephone").attr("value");	
			if(_fixed_telephone == null || _fixed_telephone.length <=0){alert("座机号不能为空！"); return;}
			if(_fixed_telephone.length<2 || _fixed_telephone.length>20){alert("座机号字符长度应>=2，并且小于20!"); return;}
			
			var _phone = $("#phone").attr("value");	
			if(_phone == null || _phone.length <=0){alert("手机号不能为空！"); return;}
			if(_phone.length<2 || _phone.length>20){alert("手机号字符长度应>=2，并且小于20!"); return;}
			
			var _contact_email = $("#contact_email").attr("value");	
			if(_contact_email == null || _contact_email.length <=0){alert("联系邮箱不能为空！"); return;}
			if(_contact_email.length<2 || _contact_email.length>50){alert("联系邮箱字符长度应>=2，并且小于50!"); return;}
			
			var _kaptcha = $("#kaptcha").attr("value");
			if(_kaptcha == null || _kaptcha.length <=0){alert("验证码不能为空！"); return;}
			
			var _company_nature = "";
			 $('input[name="company_nature"]:checked').each(function(){    
		   		_company_nature += $(this).attr("value")+",";
		  	 });   
			 
			 var _business_areas = "";
			 $('input[name="business_areas"]:checked').each(function(){    
		   		_business_areas += $(this).attr("value")+",";
		  	 });  
			
			$("#loading").fadeIn();
			$.ajax({
				type:"post",
				url : "${pageContext.servletContext.contextPath}/client/registered",
				dataType:"json",
				data:"username="+_username+"&password="+_firstPassword+"&kaptcha="+_kaptcha+"&company_name="+_company_name+"&company_address="+_company_address+"&contact="+_contact+"&where_department="+_where_department+"&fixed_telephone="+_fixed_telephone+"&phone="+_phone+"&contact_email="+_contact_email+"&company_nature="+_company_nature+"&business_areas="+_business_areas,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				success : function(msg) {
				
					document.getElementById('kaptchaImage').src='${pageContext.servletContext.contextPath}/captcha?'+Math.random();
					
					$("#loading").fadeOut();
					
					alert(msg.object || msg.message);
					
					if((msg.success+"") == "true"){
						window.location = "${pageContext.servletContext.contextPath}/client/index";
					}
				}
			});
		})
		
		$(".xiyiinfo .btn").click(function(){
			$(".search_list_mask").remove();
			$(".xiyiinfo").fadeOut();						   
		})
				   
		$("#protocol").click(function(){
									  
			var html = $.browser.webkit ? $("body")[0] : $("html")[0];
			
			var _w = $(".xiyiinfo").css("width");_w = Number(_w.substring(0,_w.length-2));
			var _h = $(".xiyiinfo").css("height");_h = Number(_h.substring(0,_h.length-2));
			
			var jWin = $(window); 
			
			var _l = 0;
			if(_w < jWin.width()){_l = (Number(jWin.width()) - _w) * 0.5 }
			
			var _t = 0;
			if(_h < Number(jWin.height())){
				_t = (Number(jWin.height()) - _h) * 0.5
			}
			
			$(".xiyiinfo").css("left",_l+"px").css("top",_t+"px");
			$(".xiyiinfo").fadeIn();
			
			var mask = $('<div class="search_list_mask" style="width:100%; height:'+html.scrollHeight+'px"></div>');
				mask.bind("click",function(){
					$(".search_list_mask").remove();
					$(".xiyiinfo").fadeOut();
				});
				mask.css("opacity",0.3);
			
			$("body").before(mask);						  
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
   