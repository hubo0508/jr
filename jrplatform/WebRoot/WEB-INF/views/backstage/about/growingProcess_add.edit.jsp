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
        	<td width="98" align="right">年份</td>
            <td align="left"><input id="year_date" type="text" class="txt" style="width:100%" value="${p.year_date }"/></td>
        </tr>
        <tr>
        	<td width="98" align="right">月份</td>
            <td align="left"><input id="month_date" type="text" class="txt" style="width:100%" value="${p.month_date }"/></td>
        </tr>
        <tr>
        	<td width="98" align="right">描述</td>
            <td align="left"><textarea id="stage_desc" class="txt" style="width:100%; height:80px;">${p.stage_desc }</textarea></td>
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
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;">${p.error }</div>
    
</body>
<script type="text/javascript">
	$(function(){
	
		PopupWindowScrollbar("growingProcess_add_edit",".scrollbar");
		
		var $loading = $("#loading");
		if($loading.text() != ""){
			$loading.css("background-color","#F30").fadeIn();
		}
	})
	
	
	function saveHandler(){
		var _year_date      = $("#year_date").attr("value");
		if(_year_date.length == null || _year_date.length <= 0){alert("年份不能为空");return false;}
		if(isNaN(_year_date)){alert("请输入数字，例如：2013");return false;}
		
		var _month_date      = $("#month_date").attr("value");
		if(_month_date.length == null || _month_date.length <= 0){alert("月份不能为空");return false;}
		if(isNaN(_month_date)){alert("请输入数字，例如：11");return false;}
		
		var _stage_desc = $("#stage_desc").val();
		if(_stage_desc.length > 255){alert("描述字符长度应小于255字符！");return false;}
		
		$("#loading").css("display","block").css("background-color","#090").html("正在保存，请稍后！");
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/growingProcess/save",
			dataType:"json",
			data:"year_date="+_year_date+"&month_date="+_month_date+"&stage_desc="+_stage_desc+"&id=${p.id }",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("保存成功！");
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/growingProcess/growingProcessJump");
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
	
	function closeHandler(){window.parent.remove("growingProcess_add_edit");}
</script>
</html>
