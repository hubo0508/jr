<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String JS  = path + "/resources/backstage/js";
String CSS = path + "/resources/backstage/css";
String JQ  = path + "/resources";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>内部员工管理_add.edit</title>
    
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
	
    <script src="<%=JQ %>/jquery-1.7.js" type="text/javascript"></script>
     
    <script src="<%=JS%>/popwin_scrollbar.js" type="text/javascript"></script> 
    <link href="<%=CSS%>/shared.css" rel="stylesheet" type="text/css" />
    
   <style>
   	
	*{font-size:12px; font-family:"宋体"}
	
	.base_title_table{margin-top:15px; margin-left:15px;}
	.base_title_table  tr td{padding:0.7em 0.4em}
	
	.add_edit_table { margin-left:15px; margin-bottom:15px;}
	.add_edit_table tr td{padding:0.5em 0.4em}
	.add_edit_table select{ width:200px;}
	.add_edit_table .txt{width:200px;}
	
	.text_line{ width:150px; text-align:left}
	

   </style>
   
</head>

<body sroll="no">
	
    <div class="scrollbar">
   
	    <table cellpadding="0" cellspacing="0" border="0"  width="800" class="base_title_table">
	    	<tr>
	        	<td width="105" align="right">员工权限：</td>
	            <td width="256" align="left"><select id="rolename" class="txt"></select></td>
	            <td width="168" align="right">账户状态：</td>
	            <td width="271" align="left">
	            	<label><input type="radio" name="status" value="0" checked="true"/>正常</label>
	            	<label><input type="radio" name="status" value="1"/>冻结</label>
                </td>
	        </tr>
	    </table>
	    
		<div class="g_light_green_line" style="margin-top:10px; margin-bottom:10px;"></div>
	    
	    <table cellpadding="0" cellspacing="0" border="0" width="800" class="add_edit_table">
       		<tr>
	        	<td width="98" align="right">系统帐号：</td>
	            <td align="left"><input id="username" type="text" class="txt" value="${p.username}"/></td>
	            <td width="171" align="right">员工姓名：</td>
	            <td width="269" align="left"><input id="ename" type="text" class="txt" value="${p.ename}"/></td>
	        </tr>
	    	<tr>
	        	<td width="98" align="right">员工手机：</td>
	            <td align="left"><input id="ephone" type="text" class="txt" value="${p.ephone}"/></td>
	            <td width="171" align="right">员工职位：</td>
	            <td width="269" align="left"><input id="ejob" type="text" class="txt" value="${p.ejob}"/></td>
	        </tr>
	        <tr>
	        	<td width="98" align="right">初始密码：</td>
	            <td colspan="3" align="left">
	            	<input id="password" type="text" class="txt"/>
	            	<p class="rtip">1、当前文本框有值时，将会替换原有密码，请慎重修改密码。<br/>
	            	2、初始密码默认为用户名。</p>
	           	</td>
            </tr>
	    </table>
   
	</div>
    
    <div class="pc_win_nav">
        <div class="g_green_line"></div>
        <div class="bottom_navigation">
            <div id="close" onclick="closeHandler()">关闭</div>
            <div id="save" onclick="saveHandler()">保存</div>
        </div>
        <div class="g_green_line"></div>
    </div>
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;"></div>
    
</body>
<script type="text/javascript">
	$(function(){		

		queryRoles();
		
		PopupWindowScrollbar("employee_add_edit",".scrollbar");
		
		var _status = "${p.status}"+"";
		if(_status == "0"){
			$('input:radio[name=status]:nth(0)').attr('checked',true);
		}
		if(_status == "1"){
			$('input:radio[name=status]:nth(1)').attr('checked',true);
		}
		if(_status == "2"){
			$('input:radio[name=status]:nth(2)').attr('checked',true);
		}
	})
	
	function hideLoading(){
		$("#loading").fadeOut();
	}

	function saveHandler(){
		
		var _status = $('input:radio[name=status]:checked').val();
		var _rolename = $("#rolename").val();
		if(_rolename == "--请选择--" || _rolename == null || _rolename == "-1" || _rolename.length < 0){alert("请设置员工权限级别！");return false;}
		
		var _username = $("#username").attr("value");
		if(_username.length > 20){alert("系统帐号字符长度应小于20字符！");return false;}
		if(_username.length <= 0){alert("系统帐号不能为空");return false;}
		
		var _ename = $("#ename").attr("value");
		if(_ename.length > 20){alert("员工姓名字符长度应小于20字符！");return false;}
		if(_ename.length <= 0){alert("员工姓名不能为空");return false;}
		
		//var _company_id = $("#company_id").val();
		//if(_ename.length > 20){alert("员工姓名字符长度应小于20字符！");return false;}
		
		var _ephone = $("#ephone").attr("value");
		if(_ephone.length > 50){alert("员工手机字符长度应小于50字符！");return false;}
		
		var _ejob = $("#ejob").attr("value");
		if(_ejob.length > 50){alert("员工职位字符长度应小于50字符！");return false;}
				
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/employee/save",
			dataType:"json",
			data:"role_id=${p.role_id}&eid=${p.eid}&uid=${p.uid}&rolenameid="+_rolename+"&status="+_status+"&username="+_username+"&ename="+_ename+"&ephone="+_ephone+"&ejob="+_ejob+"&password="+$("#password").attr("value"),
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("保存成功！");
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/employee/employeeJump");
				}else{
					$("#loading").css("display","block").css("background-color","#F30").html(msg.message);
					setTimeout(function(){
						$("#loading").fadeOut();
					},5000)
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
	
	function queryRoles()
	{
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/role/listBy?type=0",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true")
				{
					var _html = "";
					var _rolename = "${p.rolename}"
					$.each(msg.object,function(idx,item){
						if(_rolename == item.rolename){
							_html += '<option value="'+item.id+'" selected="true">'+item.rolename+'</option>'
						}else{
							_html += '<option value="'+item.id+'">'+item.rolename+'</option>'
						}
					;});
					$("#rolename").html('<option vluae="-1" >--请选择--</option>'+_html);
				}else
				{
					window.parent.alert(msg.message);
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
	
	function closeHandler(){
		window.parent.remove("employee_add_edit");
	}
</script>
</html>
