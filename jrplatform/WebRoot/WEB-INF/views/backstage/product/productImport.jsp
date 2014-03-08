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
    <%@ include file="/common/common.jsp" %>
    
    <script src="<%=JS%>/popwin_scrollbar.js" type="text/javascript"></script> 
    
    <link href="<%=CSS%>/shared.css" rel="stylesheet" type="text/css" />
    
    <script src="<%=JS%>/popwin_scrollbar.js" type="text/javascript"></script> 
    
    <link href="<%=CSS%>/shared.css" rel="stylesheet" type="text/css" />
     
    <script src="<%=JS%>/ajaxfileupload.min.js" type="text/javascript"></script>
    
    <script src="<%=path%>/resources/uploadify/jquery.uploadify.js" type="text/javascript"></script> 
    <link href="<%=path%>/resources/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
    
    
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
	     <table cellpadding="0" cellspacing="0" border="0" width="400" class="add_edit_table">
	        <tr>
	        	<td align="right">产品详细列表:</td>
	            <td colspan="3" align="left">
	            	<input id="excel_file_url" name="excel_file_url" value="${p.file_url}" type="file" class="txt" style="width:100%"/>
					<p style=" color:#F00; font-size:12px; margin-top:0px; line-height:20px;">请将产品数据以EXCEL形式保存，图片名称请以字母或数字命名！</p>
	            </td>
            </tr>
	        <tr>
	        	<td align="right">产品图片:</td>
	            <td colspan="3" align="left">
	            	<!--
	            	<input id="zip_file_url" name="zip_file_url" value="${p.video_url }" type="file" class="txt" style="width:100%"/>
	           		<br />
                    <p style=" color:#F00; font-size:12px; margin-top:0px; line-height:20px;">图片压缩文件，请将所有图片压缩成一个zip文件，并上传！</p>
	           		-->
	           		
	           		<table>
	            		<tr>
	            			<td valign="top"><input style="width:80px; height:27px;" class="uploadify-button" id="img_url"/></td>
	            			<td valign="top"><input style="width:80px; height:32px;cursor:pointer" class="uploadify-button" value="上传" onclick="$('#img_url').uploadify('upload','*')"/></td>
	            			<td valign="top"><input style="width:80px; height:32px;cursor:pointer" class="uploadify-button" value="取消" onclick="$('#img_url').uploadify('cancel','*')"/></td>
	            		</tr>
	            	</table>
	           		<p class="rtip">1、图片大小为400*400像素!<br />2、只支持gif、jpg、png图片格式</p>
	           		
	           </td>
            </tr>
	    </table>
	</div>
    
    <div class="pc_win_nav">
        <div class="g_green_line"></div>
        <div class="bottom_navigation" >
            <div id="close" onclick="closeHandler()">关闭</div>
            <div id="save" onclick="saveAllHandler()">保存</div>
        </div>
        <div class="g_green_line"></div>
    </div>
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;"></div>
    
</body>
<script type="text/javascript">
	$(function(){
		PopupWindowScrollbar("productImport_JUMP",".scrollbar");
		
		uploadFile();
	});
	
	/*
	 * 上传附件
	 */
	function uploadFile(){
       $("#file_url").uploadify({
       	 'swf'            : '<%=path%>/resources/uploadify/uploadify.swf',
         'uploader'       : '${cloudattachment_u}',
         'cancelImg'      : '<%=path%>/resources/uploadify/uploadify-cancel.png',
         'height'         : 27,
         'width'          : 80,
         'buttonText'     : "选择文件",
         'auto'           : false,
         'multi'          : true,
         'fileTypeExts'   : '*.gif;*.png;*.jpg',
         'queueSizeLimit' : 999,
         'simUploadLimit' : 10,
         'fileSizeLimit'  : (20*1024*1024),
         'onSelect': function(file){
			//$("#file_name").attr("value",file.name.substring(0,file.name.length-4));
		 },
		 'onUploadSuccess' : function(file,data,response) {
		 	uploadFile_data = eval("("+data+")");
		 	alert(data);
		 },
		 onUploadError : function(file, errorCode, errorMsg, errorString) {
		 	if(errorCode == -280){return;}
		 	alert("文件"+file.name+"上传失败！");
		 }
	   })
	}
	
	function saveAllHandler(){
		show();
		var excelvalue = $("#excel_file_url").attr("value");
		var zipvalue = $("#zip_file_url").attr("value");
		if(excelvalue.length<=0){
			$("#loading").fadeOut();
			alert("'产品详细列表',请选择文档文件！");
			hide();
			return;
		}
		if(zipvalue.length<=0){
			$("#loading").fadeOut();
			alert("'产品图片',请选择文档文件！");
			hide();
			return;
		}
		
		if(excelvalue.indexOf("xls")<0||excelvalue.indexOf("xlsx")<0){
			alert("'产品详细列表',选择文件格式不正确,只支持excel文件");
			hide();
			return;
		}
		if(zipvalue.indexOf("zip")<0){
			alert("'产品图片',选择文件格式不正确,只支持zip文件");
			hide();
			return;
		}
		
		if(excelvalue.length>0 &&zipvalue.length>0)
		{
			$.ajaxFileUpload({
			    url:"${pageContext.servletContext.contextPath}/file/uploadFile?file=excel_file_url",  
			    secureuri:false,  
			    fileElementId:'excel_file_url',  
			    dataType: 'json', 
			    success: function (data, status)
			    {
			    	var j = eval('(' + data.replace(/<[^>]+>/g,"")+ ')');
	             	if((j.success+"") == "true"){
	             	var	_excel_file_url = j.message;
	             		/*------------------SWF START-------------------------------*/
	             		$.ajaxFileUpload({
						    url:"${pageContext.servletContext.contextPath}/file/uploadFile?file=zip_file_url",  
						    secureuri:false,  
						    fileElementId:'zip_file_url',  
						    dataType: 'json', 
						    success: function (data, status)
						    {
						    	var j = eval('(' + data.replace(/<[^>]+>/g,"")+ ')');
				             	if((j.success+"") == "true"){
				             	var	_zip_file_url = j.message;
				             		saveHandler(_excel_file_url,_zip_file_url,zipvalue);
				             	}else{
				             		$("#loading").fadeOut();
				             		window.parent.alert(j.message);
				             		savemark = false;
				             	}
						    },error: function (data, status, e){window.parent.alert(eval('(' + data.replace(/<[^>]+>/g,"")+ ')').message);savemark = false;}
						});
						/*------------------SWF END-------------------------------*/
	             	}else{
	             		$("#loading").fadeOut();
	             		window.parent.alert(j.message);
	             		savemark = false;
	             	}
			    },error: function (data, status, e){window.parent.alert(eval('(' + data.replace(/<[^>]+>/g,"")+ ')').message);savemark = false;}
			});
			return;
		}
	}

	function saveHandler(_excel_file_url,_zip_file_url,zipvalue){
	
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/product/productImportSave",
			dataType:"json",
			data:"excel_file_url="+_excel_file_url+"&zip_file_url="+_zip_file_url+"&zipvalue="+zipvalue,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				alert(msg.message);
				if((msg.success+"") == "true"){
					show("保存成功！");
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/product/productJump");
				}else{
					//$("#loading").css("display","block").css("background-color","#F30").html(msg.message);
					//setTimeout(function(){$("#loading").fadeOut();},5000);
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
		window.parent.remove("productImport_JUMP");
	}
	
	function show(msg, color){
		color = color || "#090";
		msg = msg || "正在保存，请稍后...";
		
		$("#loading").css("display","block").css("background-color",color).html(msg);
	}
	
	function hide(){
		$("#loading").fadeOut();
	}
</script>
</html>