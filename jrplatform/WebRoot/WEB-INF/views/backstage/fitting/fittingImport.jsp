<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%@ include file="/common/common.jsp" %>
    <script src="<%=request.getContextPath()%>/resources/backstage/js/popwin_scrollbar.js" type="text/javascript"></script> 
    <script src="<%=request.getContextPath()%>/resources/backstage/ckeditor.js" type="text/javascript"></script>
    
    <link href="<%=request.getContextPath()%>/resources/backstage/css/shared.css" rel="stylesheet" type="text/css" />
    
    <script src="<%=request.getContextPath()%>/resources/backstage/js/popwin_scrollbar.js" type="text/javascript"></script> 
    
    <link href="<%=request.getContextPath()%>/resources/backstage/css/shared.css" rel="stylesheet" type="text/css" />
     
    <script src="<%=request.getContextPath()%>/resources/backstage/js/ajaxfileupload.min.js" type="text/javascript"></script>
    
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
	        	<td align="right">配件详细信息:</td>
	            <td colspan="3" align="left">
	            	<input id="excel_file_url" name="excel_file_url" value="${p.file_url}" type="file" class="txt" style="width:90.1%"/>
					<p style=" color:#F00; font-size:12px; margin-top:0px; line-height:20px;">1、文件大小请控制在500MB以内!<br />2、只支持excel文件<br />3、只支持图片文件名为英文、数字</p>
	            </td>
            </tr>
	        <tr>
	        	<td align="right">配件图片:</td>
	            <td colspan="3" align="left">
	            	<input id="zip_file_url" name="zip_file_url" value="${p.video_url }" type="file" class="txt" style="width:90.1%"/>
	           		 <br />
                    <p style=" color:#F00; font-size:12px; margin-top:0px; line-height:20px;">1、文件大小请控制在500MB以内!<br />2、只支持zip文件<br />3、只支持zip文件名为英文、数字</p>
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
		PopupWindowScrollbar("fittingImport_JUMP",".scrollbar");
		/* $("#excel_file_url").change(function(){
			$("#file_name").attr("value",$(this).attr("value"));
		});
		$("#zip_file_url").change(function(){
			$("#video_name").attr("value",$(this).attr("value"));
		}); */
	});
	
	function saveAllHandler(){
		show();
		var excelvalue = $("#excel_file_url").attr("value");
		var zipvalue = $("#zip_file_url").attr("value");
		if(excelvalue.length<=0){
			$("#loading").fadeOut();
			alert("'配件详细信息',请选择文档文件！");
			hide();
			return;
		}
		if(zipvalue.length<=0){
			$("#loading").fadeOut();
			alert("'配件图片',请选择文档文件！");
			hide();
			return;
		}
		
		if(excelvalue.indexOf("xls")<0||excelvalue.indexOf("xlsx")<0){
			alert("'配件详细信息',选择文件格式不正确,只支持excel文件");
			hide();
			return;
		}
		if(zipvalue.indexOf("zip")<0){
			alert("'配件图片',选择文件格式不正确,只支持zip文件");
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
			url : "${pageContext.servletContext.contextPath}/fitting/fittingImportSave",
			dataType:"json",
			data:"excel_file_url="+_excel_file_url+"&zip_file_url="+_zip_file_url+"&zipvalue="+zipvalue,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				alert(msg.message);
				if((msg.success+"") == "true"){
					show("保存成功！");
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/fitting/fittingJump");
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
		window.parent.remove("fittingImport_JUMP");
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