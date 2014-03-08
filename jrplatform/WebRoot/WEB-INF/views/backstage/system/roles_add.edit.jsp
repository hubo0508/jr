<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    
    <script src="<%=request.getContextPath()%>/resources/backstage/js/jquery-1.7.js" type="text/javascript"></script> 
    <script src="<%=request.getContextPath()%>/resources/backstage/js/popwin_scrollbar.js" type="text/javascript"></script> 
    <link href="<%=request.getContextPath()%>/resources/backstage/css/shared.css" rel="stylesheet" type="text/css" />
    
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
	<br />
    <table cellpadding="0" cellspacing="0" border="0" width="450" class="add_edit_table" id="table">
    	<tr>
        	<td width="98" align="right">角色类型</td>
            <td align="left">
				<select class="txt" id="roletype"><option selected="true" value="0">内部帐号角色</option><option value="1">第三方帐号角色</option></select>
			</td>
        </tr>
        <tr>
        	<td width="98" align="right">角色名称</td>
            <td align="left"><input id="rolename" type="text" class="txt" style="width:100%" value="${p.rolename }"/></td>
        </tr>
        <tr>
        	<td width="98" align="right">角色描述</td>
            <td align="left"><textarea id="roleremark" class="txt" style="width:100%; height:80px;">${p.roleremark }</textarea></td>
        </tr>
    </table>
    
    <div class="pc_win_nav">
        <div class="g_green_line"></div>
        <div class="bottom_navigation">
            <div id="close" onclick="closeHandler()">关闭</div>
            <div id="save" onclick="saveHandler()">保存</div>
        </div>
        <div class="g_green_line"></div>
    </div>
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;">${p.error }</div>
    
</body>
<script type="text/javascript">
	$(function(){
		PopupWindowScrollbar("role_add_edit",".scrollbar");
		
		var $loading = $("#loading");
		if($loading.text() != ""){
			$loading.css("background-color","#F30").fadeIn();
		}
		
		if("${p.roletype}" != "")
		{
			var opt = "";
			if("${p.roletype}" == "0"){
				opt += '<option selected="true" value="0">内部帐号角色</option><option value="1">第三方帐号角色</option>';
			}else{
				opt += '<option value="0">内部帐号角色</option><option selected="true" value="1">第三方帐号角色</option>';
			}
			$("#roletype").html(opt);
		}
	})
	
	function saveHandler(){
		var _roletype      = $("#roletype").val();
		if(_roletype == "" || _roletype == null){alert("角色类型不能为空！");};
		
		var _rolename = $("#rolename").attr("value");
		if(_rolename == null || _rolename.length <=0 ){alert("角色名称不能为空");};
		if(_rolename.length > 50){alert("角色名称字符长度请控制在50字符以内！")};
		
		var _roleremark = $("#roleremark").val();
		if(_roleremark.length > 255){alert("角色描述字符长度请控制在255字符以内！")};
		
		$("#loading").css("display","block").css("background-color","#090").html("正在保存，请稍后！");
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/role/save",
			dataType:"json",
			data:"roletype="+_roletype+"&rolename="+_rolename+"&roleremark="+_roleremark+"&id=${p.id}",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("保存成功！");
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/role/roleJump");
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
	function closeHandler(){window.parent.remove("role_add_edit");}
</script>
</html>
