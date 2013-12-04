<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    
    <script src="<%=request.getContextPath()%>/resources/backstage/js/jquery-1.7.js" type="text/javascript"></script> 
    <script src="<%=request.getContextPath()%>/resources/backstage/js/popwin_scrollbar.js" type="text/javascript"></script> 
    <link href="<%=request.getContextPath()%>/resources/backstage/css/shared.css" rel="stylesheet" type="text/css" />
    
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
        	<td width="98" align="right">类别名称</td>
            <td align="left"><input id="product_use" type="text" class="txt" style="width:100%" value="${c.product_use }"/></td>
        </tr>
        <tr>
        	<td width="98" align="right">类别描述</td>
            <td align="left"><textarea id="product_use_desc" class="txt" style="width:100%; height:80px;">${c.product_use_desc }</textarea></td>
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
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;">${c.error }</div>
    
</body>
<script type="text/javascript">
	$(function(){
		PopupWindowScrollbar("productCategoryAdd_Edit",".scrollbar");
		
		var $loading = $("#loading");
		if($loading.text() != ""){
			$loading.css("background-color","#F30").fadeIn();
		}
	})
	
	
	function saveHandler(){
		var _id               = "${c.id }";
		var _product_use      = $("#product_use").attr("value");
		var _product_use_desc = $("#product_use_desc").val();
		if(!check(_product_use,_product_use_desc)){
			return ;
		}
		
		$("#loading").css("display","block").css("background-color","#090").html("正在保存，请稍后！");
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/productCategory/save",
			dataType:"json",
			data:"product_use="+_product_use+"&product_use_desc="+_product_use_desc+"&id="+_id,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("保存成功！");
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/productCategory/productCategoryJump");
				}else{
					$("#loading").css("display","block").css("background-color","#F30").html(msg.message);
					setTimeout(function(){
						$("#loading").fadeOut();
					},5000)
				}
			}
		});
	}
	
	function check(_product_use,_product_use_desc){
		
		if(_product_use.length > 30){
			alert("类别名称字符长度应小于30字符！");
			return false;
		}
		
		if(_product_use.length == null || _product_use.length <= 0){
			alert("类别名称不能为空");
			return false;
		}
		
		if(_product_use_desc.length > 255){
			alert("类别描述字符长度应小于255字符！");
			return false;
		}
		
		return true;
	}
	
	function closeHandler(){window.parent.remove("productCategoryAdd_Edit");}
</script>
</html>
