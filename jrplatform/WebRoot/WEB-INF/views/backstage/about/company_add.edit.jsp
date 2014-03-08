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
	<div class="scrollbar">
    <table cellpadding="0" cellspacing="0" border="0" width="746" class="add_edit_table" id="table">
    	<tr>
        	<td width="98" align="right">公司名称</td>
            <td align="left" colspan="3"><input id="cname" type="text" class="txt" style="width:100%" value="${p.cname }"/></td>
        </tr>
        <tr>
        	<td width="98" align="right">公司类型</td>
            <td align="left" colspan="3">
            	<select id="ctype" class="txt" style="width:100%">
            		<option id="ia" selected="selected" value="0">总部</option>
            		<option id="ib" value="1">子公司</option>
            	</select>
            </td>
        </tr>
        <tr>
        	<td width="98" align="right">公司地址</td>
            <td align="left" colspan="3"><input id="caddress" type="text" class="txt" style="width:100%" value="${p.caddress }"/></td>
        </tr>
        <tr>
        	<td width="98" align="right">区域名称</td>
            <td align="left" colspan="3"><input id="area_name" type="text" class="txt" style="width:100%" value="${p.area_name }"/></td>
        </tr>
        <tr>
        	<td width="98" align="right">公司邮箱</td>
            <td align="left" colspan="3"><input id="email" type="text" class="txt" style="width:100%" value="${p.email }"/></td>
        </tr>
        <tr>
        	<td width="98" align="right">公司电话</td>
            <td width="248" align="left"><input id="cphone" type="text" class="txt" style="width:100%" value="${p.cphone }"/></td>
            <td width="132" align="right">公司传真</td>
            <td width="268" align="left"><input id="cfax" type="text" class="txt" style="width:100%" value="${p.cfax }"/></td>
        </tr>
        <tr>
        	<td width="98" align="right">客户服务QQ</td>
            <td align="left"><input id="customer_qq" type="text" class="txt" style="width:100%" value="${p.customer_qq }"/></td>
            <td width="132" align="right">销售服务QQ</td>
            <td align="left"><input id="sales_qq" type="text" class="txt" style="width:100%" value="${p.sales_qq }"/></td>
        </tr>
        <tr>
        	<td width="98" align="right">租赁服务QQ</td>
            <td align="left"><input id="leasing_qq" type="text" class="txt" style="width:100%" value="${p.leasing_qq }"/></td>
            <td width="132" align="right">投诉服务QQ</td>
            <td align="left"><input id="complaints_qq" type="text" class="txt" style="width:100%" value="${p.complaints_qq }"/></td>
        </tr>
        <tr>
        	<td width="98" align="right" valign="top">公司地址图片</td>
            <td align="left" colspan="3">
            	<input id="caddress_image_url" name="caddress_image_url" value="${p.caddress_image_url }" type="file" class="txt" style="width:100%"/>
            	<br />
                <p style=" color:#F00; font-size:12px; margin-top:0px; line-height:20px;">公司地址图片尺寸：308*213像素</p>
            </td>
        </tr>
        <tr>
        	<td width="98" align="right" valign="top">公司照片</td>
            <td align="left" colspan="3">
            	<input id="cimage_url" name="cimage_url" value="${p.cimage_url }" type="file" class="txt" style="width:100%"/>
            	<br />
                <p style=" color:#F00; font-size:12px; margin-top:0px; line-height:20px;">公司地址图片尺寸：640*436像素</p>
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
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;">${p.error }</div>
    
</body>
<script type="text/javascript">
	$(function(){
	
		PopupWindowScrollbar("company_add_edit",".scrollbar");
		
		var $loading = $("#loading");
		if($loading.text() != ""){
			$loading.css("background-color","#F30").fadeIn();
		}
		
		if("${p.ctype}" != "")
		{
			var opt = "";
			if("${p.ctype}" == "0"){
				opt += '<option selected="true" value="0">总部</option><option value="1">子公司</option>';
			}else{
				opt += '<option value="0">总部</option><option selected="true" value="1">子公司</option>';
			}
			$("#ctype").html(opt);
		}
	})
	
	function saveAllHandler(){
	
		$("#loading").css("display","block").css("background-color","#090").html("正在保存，请稍后！");
		
		var $cimage_url = $("#cimage_url").attr("value");
		var $caddress_image_url = $("#caddress_image_url").attr("value");
		
		if($cimage_url == "" && $caddress_image_url == ""){
			saveHandler("${p.cimage_url }","","${p.caddress_image_url}","");
			return;
		}
		
		var _n_cimage_url = "${p.cimage_url}";
		var _n_history_cimage_url = "";
		
		var _n_caddress_image_url = "${p.caddress_image_url}";
		var _n_history_caddress_image_url = "";
		
		if($cimage_url.length>0 && $caddress_image_url.length>0)
		{
			$.ajaxFileUpload({
			    url:"${pageContext.servletContext.contextPath}/file/uploadImage?image=cimage_url",  
			    secureuri:false,  
			    fileElementId:'cimage_url',  
			    dataType: 'json', 
			    success: function (data, status)
			    {
			    	var j = eval('(' + data.replace(/<[^>]+>/g,"")+ ')');
	             	if((j.success+"") == "true"){
	             		_n_cimage_url = j.message;
	             		_n_history_cimage_url = "${p.cimage_url}";
	             		
	             		/*------------------ START-------------------------------*/
	             		$.ajaxFileUpload({
						    url:"${pageContext.servletContext.contextPath}/file/uploadImage?image=caddress_image_url",  
						    secureuri:false,  
						    fileElementId:'caddress_image_url',  
						    dataType: 'json', 
						    success: function (data, status)
						    {
						    	var j = eval('(' + data.replace(/<[^>]+>/g,"")+ ')');
				             	if((j.success+"") == "true"){
				             		_n_caddress_image_url = j.message;
				             		_n_history_caddress_image_url = "${p.caddress_image_url}";
				             		
				             		saveHandler(_n_cimage_url,_n_history_cimage_url,_n_caddress_image_url,_n_history_caddress_image_url);
				             		
				             	}else{
				             		$("#loading").fadeOut();
				             		window.parent.alert(j.message);
				             		savemark = false;
				             	}
						    },error: function (data, status, e){window.parent.alert(eval('(' + data.replace(/<[^>]+>/g,"")+ ')').message);savemark = false;}
						});
						/*------------------ END-------------------------------*/
	             	}else{
	             		$("#loading").fadeOut();
	             		window.parent.alert(j.message);
	             		savemark = false;
	             	}
			    },error: function (data, status, e){window.parent.alert(eval('(' + data.replace(/<[^>]+>/g,"")+ ')').message);savemark = false;}
			});
			
			return;
		}
		
		if($cimage_url.length>0 && $caddress_image_url.length=="")
		{
			$.ajaxFileUpload({
			    url:"${pageContext.servletContext.contextPath}/file/uploadImage?image=cimage_url",  
			    secureuri:false,  
			    fileElementId:'cimage_url',  
			    dataType: 'json', 
			    success: function (data, status)
			    {
			    	var j = eval('(' + data.replace(/<[^>]+>/g,"")+ ')');
	             	if((j.success+"") == "true"){
	             		_n_cimage_url = j.message;
	             		_n_history_cimage_url = "${p.cimage_url}";
				        
				        saveHandler(_n_cimage_url,_n_history_cimage_url,_n_caddress_image_url,_n_history_caddress_image_url);
				        
	             	}else{
	             		$("#loading").fadeOut();
	             		window.parent.alert(j.message);
	             		savemark = false;
	             	}
			    },error: function (data, status, e){window.parent.alert(eval('(' + data.replace(/<[^>]+>/g,"")+ ')').message);savemark = false;}
			});
			
			return;
		}
		
		if($cimage_url.length=="" && $caddress_image_url.length>"")
		{
			$.ajaxFileUpload({
		    url:"${pageContext.servletContext.contextPath}/file/uploadImage?image=caddress_image_url",  
		    secureuri:false,  
		    fileElementId:'caddress_image_url',  
		    dataType: 'json', 
		    success: function (data, status)
		    {
		    	var j = eval('(' + data.replace(/<[^>]+>/g,"")+ ')');
             	if((j.success+"") == "true"){
             		_n_caddress_image_url = j.message;
             		_n_history_caddress_image_url = "${p.caddress_image_url}";
             		
             		saveHandler(_n_cimage_url,_n_history_cimage_url,_n_caddress_image_url,_n_history_caddress_image_url);
             		
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
	
	function saveHandler(cimage_url,history_cimage_url,caddress_image_url,history_caddress_image_url){
		var _cname      = $("#cname").attr("value");
		if(_cname.length == null || _cname.length <= 0){alert("公司名称不能为空");hide();return false;}
		if(_cname.length > 100){alert("公司名称字符长度应小于100字符！");hide();return false;}
		
		var _ctype      = $("#ctype").val();
		
		var _caddress      = $("#caddress").attr("value");
		if(_caddress.length == null || _caddress.length <= 0){alert("公司地址不能为空");hide();return false;}
		if(_caddress.length > 255){alert("公司地址字符长度应小于255字符！");hide();return false;}
		
		var _cphone      = $("#cphone").attr("value");
		if(_cphone.length > 50){alert("公司电话字符长度应小于50字符！");hide();return false;}
		
		var _cfax      = $("#cfax").attr("value");
		if(_cfax.length > 50){alert("公司传真字符长度应小于50字符！");hide();return false;}
		
		var _customer_qq      = $("#customer_qq").attr("value");
		if(isNaN(_customer_qq)){alert("客户服务QQ只能为数字！");hide();return false;}
		
		var _sales_qq      = $("#sales_qq").attr("value");
		if(isNaN(_sales_qq)){alert("销售服务QQ只能为数字！");hide();return false;}
		
		var _leasing_qq      = $("#leasing_qq").attr("value");
		if(isNaN(_leasing_qq)){alert("租赁服务QQ只能为数字！");hide();return false;}
		
		var _complaints_qq      = $("#complaints_qq").attr("value");
		if(isNaN(_complaints_qq)){alert("投诉服务QQ只能为数字！");hide();return false;}
		
		var _area_name = $("#area_name").attr("value");
		if(_area_name.length == null || _area_name.length <= 0){alert("区域名称不能为空");hide();return false;}
		
		var _email = $("#email").attr("value");
		if(_email.length == null || _email.length <= 0){alert("公司邮箱不能为空");hide();return false;}
		
		$("#loading").css("display","block").css("background-color","#090").html("正在保存，请稍后！");
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/company/save",
			dataType:"json",
			data:"cname="+_cname+"&email="+_email+"&cimage_url="+cimage_url+"&history_cimage_url="+history_cimage_url+"&caddress_image_url="+caddress_image_url+"&history_caddress_image_url="+history_caddress_image_url+"&leasing_qq="+_leasing_qq+"&complaints_qq="+_complaints_qq+"&ctype="+_ctype+"&caddress="+_caddress+"&cphone="+_cphone+"&cfax="+_cfax+"&customer_qq="+_customer_qq+"&sales_qq="+_sales_qq+"&id=${p.id }&area_name="+_area_name,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("保存成功！");
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/company/companyJump");
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
	
	function closeHandler(){window.parent.remove("company_add_edit");}
	
	function hide(){
		$("#loading").fadeOut();
	}
</script>
</html>