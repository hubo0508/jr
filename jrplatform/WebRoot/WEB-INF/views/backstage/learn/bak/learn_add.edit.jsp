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
	            	<input id="file_url" name="file_url" value="${p.file_url }" type="file" class="txt" style="width:90.1%"/>
	           		<p class="rtip">上传前请使用工具<a class="zp"  target="_blank" href="${pageContext.servletContext.contextPath}/resources/pdf2swf.rar">pdf2swf.exe</a>进行转换成SWF文件!</p>
	           	</td>
            </tr>
	        <tr>
	        	<td align="right">视频名称：</td>
	            <td colspan="3" align="left"><input id="video_name" value="${p.video_name }" type="text" class="txt"  style="width:90.1%"/></td>
            </tr>
	        <tr>
	        	<td align="right">&nbsp;</td>
	            <td colspan="3" align="left">
	            	<input id="video_url" name="video_url" value="${p.video_url }" type="file" class="txt" style="width:90.1%"/>
	           		 <br />
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
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;"></div>
    
</body>
<script type="text/javascript">
	$(function(){		
	
		queryMajorCategory();
		querySmallCategory();

		PopupWindowScrollbar("learn_add_edit",".scrollbar");
		
		$("#file_url").change(function(){
		
			var fn = $(this).attr("value");
			fn = fn.substring(0,fn.length-4);
			
			$("#file_name").attr("value",fn);
		});
		$("#video_url").change(function(){
		
			var fl = $(this).attr("value");
			fl = fl.substring(0,fl.length-4);
			
			$("#video_name").attr("value",fl);
		})
	})
	
	function saveAllHandler(){
	
		show();
		
		var $filevalue = $("#file_url").attr("value");
		var $videovalue = $("#video_url").attr("value");
		
		if("${p.id}" == "" && $filevalue.length<=0){
			$("#loading").fadeOut();
			alert("请选择文档文件！");
			return;
		}
		if("${p.id}" != "" && $videovalue.length<=0 && $filevalue.length<=0){
			saveHandler("${p.file_url }","","${p.video_url }","");
			return;
		}
	
		var _n_file_url = "${p.file_url}";
		var _n_history_file_url = "";
		
		var _n_video_url = "${p.video_url}";
		var _n_history_video_url = "";
		
		if($filevalue.length>0 && $videovalue.length>0)
		{
			$.ajaxFileUpload({
			    url:"${pageContext.servletContext.contextPath}/file/uploadSwf?file=file_url",  
			    secureuri:false,  
			    fileElementId:'file_url',  
			    dataType: 'json', 
			    success: function (data, status)
			    {
			    	var j = eval('(' + data.replace(/<[^>]+>/g,"")+ ')');
	             	if((j.success+"") == "true"){
	             		_n_file_url = j.message;
	             		_n_history_file_url = "${p.file_url}";
	             		
	             		/*------------------SWF START-------------------------------*/
	             		$.ajaxFileUpload({
						    url:"${pageContext.servletContext.contextPath}/file/uploadFlv?file=video_url",  
						    secureuri:false,  
						    fileElementId:'video_url',  
						    dataType: 'json', 
						    success: function (data, status)
						    {
						    	var j = eval('(' + data.replace(/<[^>]+>/g,"")+ ')');
				             	if((j.success+"") == "true"){
				             		_n_video_url = j.message;
				             		_n_history_video_url = "${p.video_url}";
				             		
				             		saveHandler(_n_file_url,_n_history_file_url,_n_video_url,_n_history_video_url);
				             		
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
		
		
		if($videovalue.length>0)
		{
			$.ajaxFileUpload({
			    url:"${pageContext.servletContext.contextPath}/file/uploadFlv?file=video_url",  
			    secureuri:false,  
			    fileElementId:'video_url',  
			    dataType: 'json', 
			    success: function (data, status)
			    {
			    	var j = eval('(' + data.replace(/<[^>]+>/g,"")+ ')');
	             	if((j.success+"") == "true"){
	             		_n_video_url = j.message;
	             		_n_history_video_url = "${p.video_url}";
	             		
	             		saveHandler(_n_file_url,_n_history_file_url,_n_video_url,_n_history_video_url);
	             		
	             	}else{
	             		$("#loading").fadeOut();
	             		window.parent.alert(j.message);
	             		savemark = false;
	             	}
			    },error: function (data, status, e){window.parent.alert(eval('(' + data.replace(/<[^>]+>/g,"")+ ')').message);savemark = false;}
			});
			
			return;
		}
		
		if($filevalue.length>0)
		{
			$.ajaxFileUpload({
			    url:"${pageContext.servletContext.contextPath}/file/uploadSwf?file=file_url",  
			    secureuri:false,  
			    fileElementId:'file_url',  
			    dataType: 'json', 
			    success: function (data, status)
			    {
			    	var j = eval('(' + data.replace(/<[^>]+>/g,"")+ ')');
	             	if((j.success+"") == "true"){
	             		_n_file_url = j.message;
	             		_n_history_file_url = "${p.file_url}";
	             		
	             		saveHandler(_n_file_url,_n_history_file_url,_n_video_url,_n_history_video_url);
	             		
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

	function saveHandler(file_url,historyfile,video_url,historyvideo){
	
		var _major_category_id      = $("#major_category_id").val();
		if(_major_category_id == null || _major_category_id == "-1" || _major_category_id.length < 0){alert("维护类别不能为空！");hide();return false;}
		
		var _small_category_id      = $("#small_category_id").val();
		if(_small_category_id == null || _small_category_id == "-1" || _small_category_id.length < 0){alert("文档类别不能为空！");hide();return false;}
	
		var _file_name = $("#file_name").attr("value");
		//if(file_name.length <= 0){alert("文档名称不能为空");hide();return false;}
		//if(file_name.length > 50){alert("文档名称字符长度应小于255字符！");hide();return false;}
		
		var _video_name = $("#video_name").attr("value");
		
		var _video_desc = $("#video_desc").attr("value");
		if(_video_desc.length > 50){alert("视屏描述字符长度应小于255字符！");hide();return false;}
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/learn/save",
			dataType:"json",
			data:"id=${p.id}&major_category_id="+_major_category_id+"&small_category_id="+_small_category_id+"&file_name="+_file_name+"&video_name="+_video_name+"&file_url="+file_url+"&historyfile="+historyfile+"&video_url="+video_url+"&historyvideo="+historyvideo+"&video_desc="+_video_desc,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					show("保存成功！");
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/learn/learnJump");
				}else{
					$("#loading").css("display","block").css("background-color","#F30").html(msg.message);
					
					setTimeout(function(){$("#loading").fadeOut();},5000)
				}
			},
			complete: function(XMLHttpRequest, textStatus){
				if(XMLHttpRequest.getResponseHeader("sessionstatus")=="timeout"){
					window.top.location.href="${pageContext.servletContext.contextPath}/login";
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