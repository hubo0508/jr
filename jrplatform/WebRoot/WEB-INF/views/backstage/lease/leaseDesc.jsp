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
	
    <script src="<%=JS %>/jquery-1.7.js" type="text/javascript"></script> 
    <link href="<%=CSS %>/shared.css" rel="stylesheet" type="text/css" />
    <script src="<%=JS %>/navigation.button.js" type="text/javascript"></script>
    <link href="<%=CSS %>/linksButton.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/lang/zh-cn/zh-cn.js"></script>
    
    <script src="<%=path%>/resources/uploadify2/uploadify.min.js" type="text/javascript"></script>
    <script src="<%=path%>/resources/uploadify2/swfobject_upload.js" type="text/javascript"></script>  
    
    <script src="<%=JS %>/common.min.js" type="text/javascript"></script>
    
</head>

<style>
	body{height:100%}
	.zp{ text-decoration:none; color:#09F}
	.zp:hover{ color:#FF4400}
</style>

<body sroll="no">

    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="title_t" height="100%"  >
    	<tr>
        	<td colspan="5">
            	<div class="labelDiv">    	
                    <div class="labelTitle">租赁服务简介</div>
                    <div class="g_gray_line workTitleLine"></div>
                    
                    <div class="linksButton">
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon check">&nbsp;</span><span class="text">保存</span>
                       </div></div> 
                       <div class="btn"><span class="hline"></span><div class="c">
                       	<span class="icon refresh">&nbsp;</span><span class="text">刷新/查询</span>
                    	</div></div> 
                    </div> 
                </div>
            </td>
        </tr>
        <tr style="font-size:12px">
        	<td align="right" width="150">租赁合同</td>
            <td width="20"></td>
        	<td width="250" align="left" valign="top">
            	<input style="width:80px; height:27px;" class="uploadify-button" id="file_url" url="${p.contract_url}"/>
                <p class="rtip">1、合同大小请控制在20MB以内!<br />2、只支持doc、docx文件</p>
            </td>
            <td width="24" valign="top">&nbsp;</td>
            <td align="left" id="doc_td"></td>
        </tr>
         <tr height="20"><td colspan="5">&nbsp;</td></tr>
         <tr style="font-size:12px">
        	<td align="right"  valign="top">租凭简介</td>
            <td></td>
        	<td align="left" valign="top" colspan="3">
            	<script id="editor" type="text/plain" style="width:100%;height:100%;">${p.description }</script>
            </td>
        </tr>
    </table>
   
</body>
<script type="text/javascript">
	
	UE.getEditor('editor');
	
	$(function(){				   
		$(".linksButton").navigationbutton("#FF002B", "#339E35",{callback: clickButtonCallback});
		
		if("${p.contract_url }".length > 0){
			$("#doc_td").html('已上传：<a class="zp" href="${cloudview}${p.contract_url }" target="_blank" >${p.contract_name }</a>');
		}
		
		$("#editor").css("height",$(window).height()-250);
		$("#editor").css("width",$(window).width()-100);
		
		uploadFile();
	});
	
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
          'fileTypeExts'   :'*.doc,*.docx',
          'wmode'          : 'transparent',
          'onSelect': function(e, queueId, fileObj){
          	
          	if(fileObj.name.indexOf('.doc') < 0 &&  fileObj.name.indexOf('.docx') < 0){
          		alert("请选择.doc、docx格式文件！");
          		return;
          	}
          	
          	if(fileObj.size > 20 * 1024 *1024){
          		alert("文件大小已超过20MB！");
          		return;
          	}
          	
          	//$('#file_name').attr("value",fileObj.name.substring(0,fileObj.name.indexOf(".swf")));
          	
          	uploadFile_mark = true;
          	$('#file_url').uploadifyUpload();
          },
          'onComplete':function(e,q,f,r,d){
          	 uploadFile_mark = false;
             uploadFile_data = eval("("+r+")");
             if((uploadFile_data.success+"") == "false"){
				alert("DOC上传失败！");
			 }
          },
          'onError' : function(e,q,f,errorObj){
          	uploadFile_mark = false;
          	alert(errorObj.type + "Error" + errorObj.info);
          }
	   })
	}
	
	function clickButtonCallback(text){
		if(text == "刷新/查询")
		{
			window.parent.loading("${pageContext.servletContext.contextPath}/lease/leaseDescJump");
			return;
		}
		
		if((text+"") == "保存")
		{
			saveAllHandler();
			return;
		}
	}
	
	function saveAllHandler(){
	
		showLoading({text:"正在保存，请稍后！"});
		
		if(uploadFile_data == null && "${p.contract_url }" == ""){
			showLoading({text:"请选择租赁合同！",type:'error',timeout:10000});
			return;
		}
		
		var c_url = "${p.contract_url }";
		var c_name = "${p.contract_name }";
		
		if(uploadFile_mark == true){
			window.parent.alert("正在上传DOC文件，请等待上传完成！");
			return;
		}
		
		if(uploadFile_data != null && (uploadFile_data.success+"") == "true"){
			c_url = 'uploadfile/src/'+uploadFile_data.sourceFileName;
			c_name = uploadFile_data.oldName;
		}
		
		if(uploadFile_data != null && (uploadFile_data.success+"") == "false"){
			alert("DOC上传失败！");
			return;
		}
		
		saveHandler(c_url,"",c_name);
	}

	function saveHandler(contract_url,historyurl,contract_name){
		//encodeURIComponent(CKEDITOR.instances.description.getData());
		var _description = encodeURIComponent(UE.getEditor('editor').getContent());
		if(_description.length > 65535){alert("描述长度应小于65535字符！");return false;}
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/lease/descSave",
			dataType:"json",
			data:"id=${p.id}&contract_name="+contract_name+"&description="+_description+"&contract_url="+contract_url+"&historydoc="+historyurl,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				
				if(msg == null){hideLoading();return;}
			
				if((msg.success+"") == "true"){
					showLoading({text:"保存成功！！",timeout:5000});
					window.parent.loading("${pageContext.servletContext.contextPath}/lease/leaseDescJump");
				}else{
					showLoading({text:msg.message,timeout:5000,type:'error'});
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