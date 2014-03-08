<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String JS  = path + "/resources/backstage/js";
String CSS = path + "/resources/backstage/css";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
	
     <script src="<%=JS%>/jquery-1.7.js" type="text/javascript"></script> 
    
    <script src="<%=JS%>/popwin_scrollbar.js" type="text/javascript"></script> 
    
    <link href="<%=CSS%>/shared.css" rel="stylesheet" type="text/css" />
    
    <script src="<%=JS%>/popwin_scrollbar.js" type="text/javascript"></script> 
    
    <link href="<%=CSS%>/shared.css" rel="stylesheet" type="text/css" />
    
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

   </style>
   
</head>

<body sroll="no">
	
    <div class="scrollbar">
   		<br />
	     <table cellpadding="0" cellspacing="0" border="0" width="800" class="add_edit_table">
	    	<tr>
	        	<td width="98" align="right">维护类别：</td>
	            <td align="left"><select id="major_category_id"  class="txt" style="width:212px"></select></td>
	            <td width="171" align="right">文档类别：</td>
	            <td width="269" align="left"><select id="small_category_id"  class="txt" style="width:212px"></select></td>
	        </tr>
	        <tr>
	        	<td align="right">文件名称：</td>
	            <td colspan="3" align="left">
	            	<input id="file_name" value="${p.file_name }" type="text" class="txt" style="width:90.1%"/>
	           	</td>
            </tr>
	        <tr>
	        	<td align="right">&nbsp;</td>
	            <td colspan="3" align="left">
	            	<input style="width:80px; height:27px;" class="uploadify-button" id="file_url" url="${p.file_url}"/>
	           		<p class="rtip">1、上传前请使用工具<a class="zp" target="_blank" href="<%=path %>/resources/pdf2swf.rar">pdf2swf.exe</a>进行转换成SWF文件!<br />2、只支持swf文件</p>
	           	</td>
            </tr>
	        <tr>
	        	<td align="right">视频名称：</td>
	            <td colspan="3" align="left"><input id="video_name" value="${p.video_name }" type="text" class="txt"  style="width:90.1%"/></td>
            </tr>
	        <tr>
	        	<td align="right">&nbsp;</td>
	            <td colspan="3" align="left">
	            	<input style="width:80px; height:27px;" class="uploadify-button" id="video_url" url="${p.video_url}"/>
                    <p class="rtip">1、视屏大小请控制在500MB以内!<br />2、只支持flv视频文件</p>
	           </td>
            </tr>
            <tr>
	        	<td align="right">视频描述：</td>
	            <td colspan="3" align="left">
	            	<input id="video_desc" value="${p.video_desc }" type="text" class="txt"  style="width:90.1%"/></td>
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
    
</body>
<script type="text/javascript">

	$(function(){		
	
		queryMajorCategory();
		querySmallCategory();

		PopupWindowScrollbar("learn_add_edit",".scrollbar");
		
		$("#file_url").change(function(){		
			var fn = $(this).attr("value");fn = fn.substring(0,fn.length-4);			
			$("#file_name").attr("value",fn);
		});
		$("#video_url").change(function(){
			var fl = $(this).attr("value");fl = fl.substring(0,fl.length-4);			
			$("#video_name").attr("value",fl);
		})
		
		uploadFile();
	 	uploadFlv();
	})
	
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
				alert("FLV上传失败！");
			 }
          },
          'onError' : function(e,q,f,errorObj){
          	uploadFile_mark = false;
          	alert(errorObj.type + "Error" + errorObj.info);
          }
	   })
	}
	
	/*
	 * 上传flv
	 */
	var uploadFlv_data = null;
	var uploadFlv_mark = false;
	function uploadFlv(){
       $("#video_url").uploadify({
          'uploader'       : '<%=path%>/resources/uploadify2/uploadify.swf',
          'cancelImg'      : '<%=path%>/resources/uploadify2/cancel.png',
          'buttonImg'      : '<%=path%>/resources/uploadify2/selected.png',
          'script'         : '${cloudflv_u}',
          'height'         : 27,
          'width'          : 210,
          'auto'           : false,
          'multi'          : false,
          'fileDataName'   : 'fileName',
          'fileTypeExts'   :'*.flv',
          'wmode'          : 'transparent',
          'onSelect': function(e, queueId, fileObj){
          	
          	if(fileObj.name.indexOf('.flv') < 0){
          		alert("请选择FLV格式视频文件！");
          		return;
          	}
          	
          	if(fileObj.size > 500 * 1024 *1024){
          		alert("视屏文件大小已超过500MB！");
          		return;
          	}
          	
          	uploadFlv_mark = true;
          	
          	$('#video_name').attr("value",fileObj.name.substring(0,fileObj.name.indexOf(".flv")));
          	
          	$('#video_url').uploadifyUpload();
          },
          'onComplete':function(e,q,f,r,d){
            uploadFlv_mark = false;
          	uploadFlv_data = eval("("+r+")");
          	if((uploadFile_data.success+"") == "false"){
				alert("SWF上传失败！");
			 }     
          },
          'onError' : function(e,q,f,errorObj){
          	uploadFlv_mark = false;
          	alert(errorObj.type + "Error" + errorObj.info);
          }
	  })
	}
	
	function saveAllHandler(){
		
		var $filevalue = $("#file_url").attr("url");
		var $videovalue = $("#video_url").attr("url");
		
		if((uploadFile_data == null && ($filevalue == undefined || $filevalue == "")) && 
		   (uploadFlv_data == null && ($videovalue == undefined || $videovalue == "")))
		{
			alert("SWF和FLV文件至少上传一个！");
			return;
		}
	
		var _n_file_url = "${p.file_url}";
		var _n_video_url = "${p.video_url}";
		
		if(uploadFile_data != null && (uploadFile_data.success+"") == "true"){
			_n_file_url = convert(uploadFile_data.fileName);
		}
		
		if(uploadFile_data != null && (uploadFile_data.success+"") == "false"){
			alert("SWF上传失败！");
			return;
		}
		
		if(uploadFlv_data != null && (uploadFlv_data.success+"") == "true"){
			_n_video_url = uploadFlv_data.fileName;
		}
		
		if(uploadFlv_data != null && (uploadFlv_data.success+"") == "false"){
			alert("FLV上传失败！");
			return;
		}
		
		if(uploadFile_mark == true){
			window.parent.alert("正在上传SWF文件，请等待上传完成！");
			return;
		}
		if(uploadFlv_mark == true){
			window.parent.alert("正在上传视频文件，请等待上传完成！");
			return;
		}
		saveHandler(_n_file_url,"",_n_video_url,"");
	}

	function saveHandler(file_url,historyfile,video_url,historyvideo){
	
		var _major_category_id      = $("#major_category_id").val();
		if(_major_category_id == null || _major_category_id == "-1" || _major_category_id.length < 0){alert("维护类别不能为空！");hide();return false;}
		
		var _small_category_id      = $("#small_category_id").val();
		if(_small_category_id == null || _small_category_id == "-1" || _small_category_id.length < 0){alert("文档类别不能为空！");hide();return false;}
	
		var _file_name = $("#file_name").attr("value");
		if(file_name.length <= 0){alert("文档名称不能为空");hide();return false;}
		//if(file_name.length > 50){alert("文档名称字符长度应小于255字符！");hide();return false;}
		
		var _video_name = $("#video_name").attr("value");
		
		var _video_desc = $("#video_desc").attr("value");
		if(_video_desc.length > 50){alert("视屏描述字符长度应小于255字符！");hide();return false;}
		
		showLoading({wintype:true,text:"正在保存，请稍后！"});
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/learn/save",
			dataType:"json",
			data:"id=${p.id}&major_category_id="+_major_category_id+"&small_category_id="+_small_category_id+"&file_name="+_file_name+"&video_name="+_video_name+"&file_url="+file_url+"&historyfile="+historyfile+"&video_url="+video_url+"&historyvideo="+historyvideo+"&video_desc="+_video_desc,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					showLoading({wintype:true,text:"保存成功！"});
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/learn/learnJump");
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
	
	function queryMajorCategory(){
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/majorCategory/list",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if(msg && (msg.success+"") == "true"){
					var _option = '<option value="-1">--全部--</option>';
					$.each(msg.object,function(idx,item){
						var _id  = item.id;var _major_category = item.major_category || '&nbsp';
						if(_id == "${p.major_category_id}"){
							_option += '<option value="'+_id+'" selected="true">'+_major_category+'</option>';
						}else{
							_option += '<option value="'+_id+'">'+_major_category+'</option>';
						}
					});
					$("#major_category_id").html(_option);
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
	
	
	function querySmallCategory(){
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/smallCategory/list",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if(msg && (msg.success+"") == "true"){
					var _option = '<option value="-1">--全部--</option>';
					$.each(msg.object,function(idx,item){
						var _id  = item.id;var _small_category = item.small_category || '&nbsp';
						if(_id == "${p.small_category_id}"){
							_option += '<option value="'+_id+'" selected="true">'+_small_category+'</option>';
						}else{
							_option += '<option value="'+_id+'">'+_small_category+'</option>';
						}
					});
					$("#small_category_id").html(_option);
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
		window.parent.remove("learn_add_edit");
	}
	
	function show(msg, color){
		color = color || "#090";
		msg = msg || "正在保存，请稍后！";
		
		$("#loading").css("display","block").css("background-color",color).html(msg);
	}
	
	function hide(){
		$("#loading").fadeOut();
	}
</script>
</html>