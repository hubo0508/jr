<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String filedir = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + "/";
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
    
    <script src="<%=request.getContextPath()%>/resources/backstage/js/popwin_scrollbar.js" type="text/javascript"></script> 
    <script src="<%=request.getContextPath()%>/resources/backstage/ckeditor.js" type="text/javascript"></script>
    
    <link href="<%=request.getContextPath()%>/resources/backstage/css/shared.css" rel="stylesheet" type="text/css" />
     
    <script src="<%=request.getContextPath()%>/resources/backstage/js/ajaxfileupload.min.js" type="text/javascript"></script>
    
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
	
	.text_line{ width:150px; text-align:left}
	

   </style>
   
</head>

<body sroll="no">
	
    <div class="scrollbar">
   		<br />
	     <table cellpadding="0" cellspacing="0" border="0" width="800" class="add_edit_table">
	    	<tr>
	        	<td width="120" align="right">标题：</td>
	            <td width="680" align="left"><input id="title" value="${p.title }" name="title" type="text" class="txt" style="width:100%"/></td>
	        </tr>
	        <tr>
	        	<td align="right">新闻图片：</td>
	            <td align="left">
                	<input id="image_url" name="image_url" type="file" class="txt"  style="width:100%"/>
                </td>
	        </tr>
	        <tr >
	        	<td align="right">&nbsp;</td>
	            <td width="703" align="left" id="img_td"></td>
	        </tr>
	        <tr>
	        	<td align="right" valign="top">新闻内容：</td>
	            <td align="left"  valign="top">
	            	<!-- <textarea class="ckeditor" name="content" style="width:100%">${p.content }</textarea> -->
	            	<script id="editor" type="text/plain" style="width:680px;height:100%;">${p.content }</script>
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
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;"></div>
    
</body>
<script type="text/javascript">

	var ue = UE.getEditor('editor');

	$(function(){		

		$("#editor").css("height",$(window).height());
		
		PopupWindowScrollbar("news_add_edit",".scrollbar");
		
		if("${p.image_url }".length > 0){
			$("#img_td").html('<img src="${p.image_url }" />');
		}
		
	})
	
	function show(msg, color){
		color = color || "#090";
		msg = msg || "正在保存，请稍后！";
		
		$("#loading").css("display","block").css("background-color",color).html(msg);
	}
	
	function hide(){
		$("#loading").fadeOut();
	}
	
	function saveAllHandler(){
	
		show();
		
		var _img_ = $("#image_url").attr("value");
		if(_img_ == ""){
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

	function saveHandler(image_url,historyimage){
	
		var _title = $("#title").attr("value");
		if(_title.length <= 0){alert("新闻标题不能为空");hide();return false;}
		if(_title.length > 255){alert("新闻标题字符长度应小于255字符！");hide();return false;}
		
		var _content = encodeURIComponent(UE.getEditor('editor').getContent());
		if(_content.length > 65535){alert("新闻内容字符长度应小于65535字符！");hide();return false;}
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/news/save",
			dataType:"json",
			data:"id=${p.id}&title="+_title+"&content="+_content+"&image_url="+image_url+"&historyimage="+historyimage,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					show("保存成功！");
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/news/newsJump");
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
	
	function closeHandler(){
		window.parent.remove("news_add_edit");
	}
</script>
</html>