<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>维修服务_维修种类_新增_修改</title>
    
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
        	<td width="98" align="right">类别名称</td>
            <td align="left"><input id="title" type="text" class="txt" style="width:100%" value="${c.title }"/></td>
        </tr>
        <tr>
        	<td width="98" align="right">类别描述</td>
            <td align="left"><textarea id="content" class="txt" style="width:100%; height:80px;">${c.content }</textarea></td>
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
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;">${c.error }</div>
    
</body>
<script type="text/javascript">
	$(function(){
		PopupWindowScrollbar("addCategory_add_edit",".scrollbar");
		
		var $loading = $("#loading");
		if($loading.text() != ""){
			$loading.css("background-color","#F30").fadeIn();
		}
	})
	
	
	function saveHandler(){
		var _title      = $("#title").attr("value");
		var _content = $("#content").val();
		if(!check(_title,_content)){
			return ;
		}
		
		$("#loading").css("display","block").css("background-color","#090").html("正在保存，请稍后！");
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/service/categorySave",
			dataType:"json",
			data:"title="+_title+"&content="+_content+"&id=${c.id }",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("保存成功！");
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/service/categoryJump");
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
	
	function check(_title,_content){
		
		if(_title.length > 50){
			alert("维修种类名称字符长度应小于50字符！");
			return false;
		}
		
		if(_title.length == null || _title.length <= 0){
			alert("维修种类名称不能为空");
			return false;
		}
		
		if(_content.length > 255){
			alert("描述字符长度应小于255字符！");
			return false;
		}
		
		return true;
	}
	
	function closeHandler(){window.parent.remove("addCategory_add_edit");}
</script>
</html>
