<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>修改密码</title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/jquery-1.7.js"></script>
          
    <script src="<%=request.getContextPath()%>/resources/backstage/js/navigation.button.js" type="text/javascript"></script>
        
    <link href="<%=request.getContextPath()%>/resources/backstage/css/shared.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath()%>/resources/backstage/css/linksButton.css" rel="stylesheet" type="text/css" />
    
</head>

<style>
	body{height:100%}
	.role_table{ font-size:12px;}
   	.role{ width:200px; font-size:12px;list-style:none; cursor:pointer; margin-left:-30px;}
	.role li{  background-image:url(<%=request.getContextPath()%>/resources/backstage/image/texing_li.png); padding-left:25px; 
		background-repeat:no-repeat; background-position:left; padding-top:8px; padding-bottom:8px}
	.role li:hover{ background-color:#BDC323}
	.role .selected{ background-color:#84C323}
</style>

<body sroll="no">

    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="title_t">
    	<tr>
        	<td>
            	<div class="labelDiv">    	
                    <div class="labelTitle">修改密码</div>
                    <div class="g_gray_line workTitleLine"></div>
                </div>
            </td>
        </tr>
   
    </table>
    
    <DIV class="scrollbar" id="scrollbar"> 
	    <table border="0">
	    		<tr>
                    <td>旧密码：</td>
                    <td><input class="txt" id="oldPass" type="password" value=""/></td>
                </tr>
                <tr>
                    <td>新密码：</td>
                    <td><input class="txt" id="nPassFist" type="password" value=""/></td>
                </tr>
                <tr>
                    <td>确认密码：</td>
                    <td><input class="txt" id="nPassLast" type=password value=""/></td>
                </tr>
                <tr>
                	<td colspan="2"  align="right">
                		<center><input type="button" value="确认" onclick="commit()" align="middle"/></center>
                	</td>
                </tr>            
            </table>
     </DIV>
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:10px; left:285px; display:none; font-size:14px"></div>
    
</body>
<script type="text/javascript">
	
	function commit()
	{
		var _oldPass   = $("#oldPass").attr("value");
		var _nPassFist = $("#nPassFist").attr("value");
		var _nPassLast = $("#nPassLast").attr("value");
		
		if(_oldPass == null || _oldPass.length <=0){
			alert("旧密码不能为空");
			return;
		}
		
		if(_nPassFist == null || _nPassFist == null){
			alert("新密码不能为空");
			return;
		}
		
		if(_nPassFist != _nPassLast){
			alert("两次密码不相同");
			return;
		}
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/user/updatepassword",
			dataType:"json",
			data:"username=${c_user.username}&oldPass="+_oldPass+"&nPassFist="+_nPassFist+"&nPassLast="+_nPassLast,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if(msg == null){return;}
				
				if((msg.success+"") == "true"){
					alert("修改成功，请重新登录系统！");
					window.top.location.href="${pageContext.servletContext.contextPath}/login";
				}else{
					alert(msg.message);
				}
			},
			complete: function(XMLHttpRequest, textStatus){
				if(XMLHttpRequest.getResponseHeader("sessionstatus")=="timeout"){
					window.top.location.href="${pageContext.servletContext.contextPath}/login";
				}
				if(XMLHttpRequest.getResponseHeader("sessionstatus")=="no_w"){
					alert("您的权限级别无法进行保存或修改数据操作！");
				}
			}
		});
	}
</script>

</html>
