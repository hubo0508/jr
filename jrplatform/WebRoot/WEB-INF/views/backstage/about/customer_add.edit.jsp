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
    
    <title>客户目录_添加_修改</title>
    
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    
    <script src="<%=JQ %>/jquery-1.7.js" type="text/javascript"></script>
    
    <script src="<%=JS%>/popwin_scrollbar.js" type="text/javascript"></script> 
    <link href="<%=CSS%>/shared.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/resources/backstage/ckeditor.js" type="text/javascript"></script>
    <script src="<%=JS%>/ajaxfileupload.min.js" type="text/javascript"></script>
    
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/lang/zh-cn/zh-cn.js"></script>
    
   <style>
	*{font-size:12px; font-family:"宋体"}
	
	.base_title_table{margin-top:15px; margin-left:15px;}
	.base_title_table  tr td{padding:0.7em 0.4em}
	
	.add_edit_table { margin-left:15px; margin-bottom:15px;}
	.add_edit_table tr td{padding:0.5em 0.4em}
	.add_edit_table select{ width:200px;}
	.add_edit_table .txt{width:200px;}
   </style>
   
</head>

<body sroll="no">
	<br />
	
	<div id="scrollbar" class="scrollbar">
	    <table cellpadding="0" cellspacing="0" border="0" width="750" class="add_edit_table" id="table">
	        <tr>
	        	<td width="150" align="right">客户名称</td>
	            <td align="left"><input id="customer_name" type="text" class="txt" style="width:100%" value="${p.customer_name }"/></td>
	        </tr>
	        <tr>
	        	<td align="right">LOG图片</td>
	            <td align="left">
	            	<input id="image_url" name="image_url" value="${p.image_url }" type="file" class="txt" style="width:100%"/>
	            	<br />
	                <p style="color:#F00; font-size:12px; margin-top:0px; line-height:20px;">照片尺寸：150*100像素</p>
	            </td>
	        </tr>
	        <tr>
	        	<td align="right" valign="top">描述</td>
	            <td align="left">
	            	<!-- <textarea class="ckeditor" name="description">${p.description }</textarea> -->
	            	<script id="editor" type="text/plain" style="width:100%;height:100%;">${p.description }</script>
	           	</td>
	        </tr>
	    </table>
    </div>
    
    <div class="pc_win_nav">
        <div class="g_green_line"></div>
        <div class="bottom_navigation">
            <div id="close" onclick="closeHandler()">关闭</div>
            <div id="save" onclick="saveAllHandler()">保存</div>
        </div>
        <div class="g_green_line"></div>
    </div>
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;">${p.error }</div>
    
</body>
<script type="text/javascript">
	
	UE.getEditor('editor');

	$(function(){
	
		PopupWindowScrollbar("customer_add_edit",".scrollbar");
		
		var $loading = $("#loading");
		if($loading.text() != ""){
			$loading.css("background-color","#F30").fadeIn();
		}
		
		var $edit = $("#editor");var $win  = $(window);
		$edit.css("width",$win.width()-150);
		$edit.css("height",$win.height()-350);
	})
	
	function hide(){
		$("#loading").fadeOut();
	}
	
	function saveAllHandler(){
	
		$("#loading").css("display","block").css("background-color","#090").html("正在保存，请稍后！");
		
		if($("#image_url").attr("value") == ""){
			saveHandler("${p.image_url }");
			return;
		}
		
		$.ajaxFileUpload({ 
		    url:"${pageContext.servletContext.contextPath}/file/uploadImage?image=image_url",  
		    secureuri:false,  
		    fileElementId:'image_url',  
		    dataType: 'json', 
		    success: function (data, status)
		    {
		    	var j = eval('(' + data.replace(/<[^>]+>/g,"")+ ')');
             	if((j.success+"") == "true"){
             		saveHandler(j.message,"${p.image_url}");
             	}else{
             		$("#loading").fadeOut();
             		window.parent.alert(j.message);
             	}
		    },
		    error: function (data, status, e)
            {
            	window.parent.alert(eval('(' + data.replace(/<[^>]+>/g,"")+ ')').message);
            }
		});  
	}
	
	function saveHandler(url,historyurl){
	
		var _customer_name      = $("#customer_name").attr("value");
		if(_customer_name.length == null || _customer_name.length <= 0){alert("客户名称不能为空");hide();return false;}
		if(_customer_name.length > 100){alert("客户名称字符长度应小于100字符！");hide();return false;}
		
		var _description = encodeURIComponent(UE.getEditor('editor').getContent());
		if(_description.length > 65535){alert("描述字符长度应小于65535字符！");hide();return false;}
		
		$("#loading").css("display","block").css("background-color","#090").html("正在保存，请稍后！");
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/customerController/save",
			dataType:"json",
			data:"customer_name="+_customer_name+"&description="+_description+"&image_url="+url+"&historyimage="+historyurl+"&id=${p.id }",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("保存成功！");
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/customerController/customerJump");
				}else{
					$("#loading").css("display","block").css("background-color","#F30").html(msg.message);
					setTimeout(function(){$("#loading").fadeOut();},5000)
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
	
	function closeHandler(){window.parent.remove("customer_add_edit");}
</script>
</html>