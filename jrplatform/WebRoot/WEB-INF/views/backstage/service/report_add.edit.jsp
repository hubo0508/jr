<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String JS  = path + "/resources/backstage/js";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>维修服务_维修报告单_新增_修改</title>
    
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    
    <script src="<%=request.getContextPath()%>/resources/backstage/js/jquery-1.7.js" type="text/javascript"></script> 
    <script src="<%=request.getContextPath()%>/resources/backstage/js/popwin_scrollbar.js" type="text/javascript"></script> 
    <link href="<%=request.getContextPath()%>/resources/backstage/css/shared.css" rel="stylesheet" type="text/css" />
    
    <script src="<%=path%>/resources/uploadify2/uploadify.min.js" type="text/javascript"></script>
    <script src="<%=path%>/resources/uploadify2/swfobject_upload.js" type="text/javascript"></script>  
    
    <script src="<%=JS %>/common.min.js" type="text/javascript"></script>
    
   <style>
   	
	*{font-size:12px; font-family:"宋体"}
	
	.base_title_table{margin-top:15px; margin-left:15px;}
	.base_title_table  tr td{padding:0.7em 0.4em}
	
	.add_edit_table { margin-left:15px; margin-bottom:15px;}
	.add_edit_table tr td{padding:0.5em 0.4em}
	.add_edit_table select{ width:200px;}
	.add_edit_table .txt{width:200px;}
	
	.text_line{ width:150px; text-align:left}
	.zp{ text-decoration:none; color:#09F}
	.zp:hover{ color:#FF4400}

   </style>
   
</head>

<body sroll="no">
	<br />
     <table cellpadding="0" cellspacing="0" border="0" width="450" class="add_edit_table" id="table">
     	<tr>
        	<td width="98" align="right" valign="top">维修报告单</td>
            <td align="left">
        		<input id="file_name" value="${p.file_name }" type="text" class="txt"  style="width:90.1%"/>
            </td>
        </tr>
    	<tr>
        	<td width="98" align="right" valign="top"></td>
            <td align="left">
        		<input style="width:80px; height:27px;" class="uploadify-button" id="file_url" url="${p.file_url}"/>
	           	<p class="rtip">1、上传前请使用工具<a class="zp" target="_blank" href="<%=path %>/resources/pdf2swf.rar">pdf2swf.exe</a>进行转换成SWF文件!<br />2、只支持swf文件</p>
            	
            	<!-- <p i="file_p">已上传：<a class="zp" href="#">${p.file_name }</a></p> -->
            </td>
        </tr>
        <tr>
        	<td width="98" align="right" valign="top">描述</td>
            <td align="left"><textarea id="file_desc" class="txt" style="width:100%; height:80px;">${p.file_desc }</textarea></td>
        </tr>
    </table>
    
    <div class="pc_win_nav">
        <div class="g_green_line"></div>
        <div class="bottom_navigation">
            <div id="close" onclick="closeHandler()">关闭</div>
            <div id="save" onclick="saveAllHandler()">保存</div>
        </div>
        <div class="g_green_line"></div>
    </div>
    
</body>
<script type="text/javascript">
	$(function(){
		PopupWindowScrollbar("reportAdd_Edit",".scrollbar");
		
		uploadFile();
	})
	
	function saveAllHandler(){
	
		var $filevalue = $("#file_url").attr("url");
		
		if(uploadFile_data == null && ($filevalue == undefined || $filevalue == "")){
			alert("请选择swf文件！");
			return;
		}
	
		var _n_file_url = "${p.file_url}";
		
		if(uploadFile_data != null && (uploadFile_data.success+"") == "true"){
			_n_file_url = convert(uploadFile_data.fileName);
		}
		
		if(uploadFile_data!=null && (uploadFile_data.success+"") == "false"){
			alert("SWF上传失败！");
			return;
		}
		
		if(uploadFile_mark == true){
			window.parent.alert("正在上传SWF文件，请等待上传完成！");
			return;
		}
		
		saveHandler(_n_file_url,null);
	}
	
	/*
	 * 上传附件
	 */
	var uploadFile_data = null;
	var uploadFile_mark = false;
	function uploadFile(){
       $("#file_url").uploadify({
       	  'uploader'       : '<%=path%>/resources/uploadify2/uploadify.swf',
          'cancelImg'      : '<%=path%>/resources/uploadify2/cancel.png',
          'buttonImg'      : '<%=path%>/resources/uploadify2/selected.png',
          'script'         : '${cloudattachment_u}',
          'height'         : 27,
          'width'          : 210,
          'auto'           : false,
          'multi'          : false,
          'fileDataName'   : 'fileName',
          'fileTypeExts'   :'*.swf',
          'wmode'          : 'transparent',
          'onSelect': function(e, queueId, fileObj){
          	
          	if(fileObj.name.indexOf('.swf') < 0){
          		alert("请选择SWF格式视屏文件！");
          		return;
          	}
          	
          	if(fileObj.size > 20 * 1024 *1024){
          		alert("SWF文件大小已超过20MB！");
          		return;
          	}
          	
          	$('#file_name').attr("value",fileObj.name.substring(0,fileObj.name.indexOf(".swf")));
          	
          	uploadFile_mark = true;
          	$('#file_url').uploadifyUpload();
          },
          'onComplete':function(e,q,f,r,d){
          	 uploadFile_mark = false;
             uploadFile_data = eval("("+r+")");
             if((uploadFile_data.success+"") == "false"){
				alert("SWF上传失败！");
			 }
          },
          'onError' : function(e,q,f,errorObj){
          	uploadFile_mark = false;
          	alert(errorObj.type + "Error" + errorObj.info);
          }
	   })
	}
	
	function saveHandler(file_url,historyfile){
		
		var file_name = $("#file_name").attr("value");
		if(file_name.length == null || file_name.length < 0){alert("文件不能为空！");$("#loading").fadeOut();return false;}
		
		var _file_desc = $("#file_desc").val();
		if(_file_desc.length > 255){alert("描述字符长度应小于255字符！");$("#loading").fadeOut();return false;}
		
		showLoading({wintype:true,text:"正在保存，请稍后！"});
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/service/reportSave",
			dataType:"json",
			data:"file_name="+file_name+"&file_desc="+_file_desc+"&file_url="+file_url+"&historyfile="+historyfile+"&id=${p.id }",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					showLoading({wintype:true,text:"保存成功！"});
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/service/reportJump");
				}else{
					hideLoading();
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
	
	function closeHandler(){window.parent.remove("reportAdd_Edit");}
</script>
</html>
