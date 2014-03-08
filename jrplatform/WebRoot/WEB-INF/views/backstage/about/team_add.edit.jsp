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
    
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    
    <script src="<%=JQ %>/jquery-1.7.js" type="text/javascript"></script>
    
    <script src="<%=JS%>/popwin_scrollbar.js" type="text/javascript"></script> 
    <link href="<%=CSS%>/shared.css" rel="stylesheet" type="text/css" />
    <script src="<%=JS%>/ajaxfileupload.min.js" type="text/javascript"></script>
    
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
        	<td width="98" align="right">排序</td>
            <td align="left"><input id="custom_sort" type="text" class="txt" style="width:100%" value="${p.custom_sort }"/></td>
        </tr>
        <tr>
        	<td width="98" align="right">姓名</td>
            <td align="left"><input id="name" type="text" class="txt" style="width:100%" value="${p.name }"/></td>
        </tr>
        <tr>
        	<td width="98" align="right">照片</td>
            <td align="left">
            	<input id="url" name="url" value="${p.url }" type="file" class="txt" style="width:100%"/>
            	<br />
                <p style=" color:#F00; font-size:12px; margin-top:0px; line-height:20px;">照片尺寸：290*390像素</p>
            </td>
        </tr>
        <tr>
        	<td width="98" align="right">职位描述</td>
            <td align="left"><input id="job_desc" type="text" class="txt" style="width:100%" value="${p.job_desc }"/></td>
        </tr>
        <tr>
        	<td width="98" align="right">详细描述</td>
            <td align="left"><textarea id="job_info" class="txt" style="width:100%; height:80px;">${p.job_info }</textarea></td>
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
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;">${p.error }</div>
    
</body>
<script type="text/javascript">
	$(function(){
	
		PopupWindowScrollbar("team_add_edit",".scrollbar");
		
		var $loading = $("#loading");
		if($loading.text() != ""){
			$loading.css("background-color","#F30").fadeIn();
		}
		
		var $custom_sort = $("#custom_sort");
		if($custom_sort.attr("value") == ""){
			$custom_sort.attr("value","1");
		}
	})
	
	function hide(){
		$("#loading").fadeOut();
	}
	
	function saveAllHandler(){
	
		$("#loading").css("display","block").css("background-color","#090").html("正在保存，请稍后！");
		
		var _img_ = $("#url").attr("value");
		if(_img_ == ""){
			saveHandler("${p.url }");
			return;
		}
		
		$.ajaxFileUpload({ 
		    url:"${pageContext.servletContext.contextPath}/file/uploadFile?file=url",  
		    secureuri:false,  
		    fileElementId:'url',  
		    dataType: 'json', 
		    success: function (data, status)
		    {
		    	var j = eval('(' + data.replace(/<[^>]+>/g,"")+ ')');
             	if((j.success+"") == "true"){
             		saveHandler(j.message,"${p.url}");
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
		var _custom_sort      = $("#custom_sort").attr("value");
		if(_custom_sort.length == null || _custom_sort.length <= 0){alert("序号不能为空");hide();return false;}
		if(isNaN(_custom_sort)){alert("请输入数字，例如：1");hide();return false;}
		
		var _name      = $("#name").attr("value");
		if(_name.length == null || _name.length <= 0){alert("姓名不能为空");hide();return false;}
		if(_name.length > 20){alert("姓名字符长度应小于20字符！");hide();return false;}
		
		var _job_desc      = $("#job_desc").attr("value");
		if(_job_desc.length == null || _job_desc.length <= 0){alert("职位描述不能为空");hide();return false;}
		if(_job_desc.length > 100){alert("职位描述字符长度应小于100字符！");hide();return false;}
		
		var _job_info      = $("#job_info").attr("value");
		if(_job_info.length == null || _job_info.length <= 0){alert("详细描述不能为空");hide();return false;}
		if(_job_info.length > 500){alert("详细描述字符长度应小于500字符！");hide();return false;}
		
		$("#loading").css("display","block").css("background-color","#090").html("正在保存，请稍后！");
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/team/save",
			dataType:"json",
			data:"custom_sort="+_custom_sort+"&name="+_name+"&job_desc="+_job_desc+"&job_info="+_job_info+"&url="+url+"&historyurl="+historyurl+"&id=${p.id }",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("保存成功！");
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/team/teamJump");
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
	
	function closeHandler(){window.parent.remove("team_add_edit");}
</script>
</html>

