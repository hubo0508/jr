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
    
    <script src="<%=request.getContextPath()%>/resources/backstage/js/jquery-ui.min.js" type="text/javascript"></script>
    
     <script src="<%=request.getContextPath()%>/resources/backstage/js/jquery-1.7.js" type="text/javascript"></script> 
    
    <script src="<%=request.getContextPath()%>/resources/backstage/js/popwin_scrollbar.js" type="text/javascript"></script> 
    <script src="<%=request.getContextPath()%>/resources/backstage/ckeditor.js" type="text/javascript"></script>
    
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
	
    <div class="scrollbar">
   
	    <table cellpadding="0" cellspacing="0" border="0"  width="800" class="base_title_table">
	    	<tr>
	        	<td width="110" align="right">库存：</td>
	            <td width="72" align="left"><input id="stock" name="stock" type="text"  class="txt" style="width:50px"/></td>
	            <td width="76" align="right">淘宝链接：</td>
	            <td width="542" align="left"><input id="taobao_links" name="taobao_links" type="text"  class="txt" style="width:79%"/></td>
	        </tr>
	    </table>
	    
		<div class="g_light_green_line" style="margin-top:10px; margin-bottom:10px;"></div>
	    
	    <table cellpadding="0" cellspacing="0" border="0" width="800" class="add_edit_table">
	    	<tr>
	        	<td width="98" align="right">设备名称：</td>
	            <td align="left"><input id="product_name" name="product_name" type="text" class="txt" /></td>
	            <td width="120" align="right">设备类别：</td>
	            <td width="320" align="left"><select id="device_type_id" name="device_type_id" class="txt" style="width:212px"></select>
	                   <div class="_btn" style="float:right; margin-top:2px;">新增类别</div>
	            </td>
	        </tr>
	        <tr>
	        	<td align="right">产品分类：</td>
	            <td width="262" align="left"><input id="product_category" name="product_category" type="text" class="txt" /></td>
	            <td width="120" align="right">品牌：</td>
	            <td width="320" align="left"><input id="brand" type="text" class="txt" /></td>
	        </tr>
	        <tr>
	        	<td align="right">产地：</td>
	            <td width="262" align="left"><input id="place_origin" type="text" class="txt" /></td>
	            <td width="120" align="right">型号：</td>
	            <td width="320" align="left"><input id="model" type="text" class="txt" /></td>
	        </tr>
	        <tr>
	        	<td align="right">材质：</td>
	            <td width="262" align="left"><input id="material" type="text" class="txt" /></td>
	            <td width="120" align="right">外观尺寸：</td>
	            <td width="320" align="left"><input id="exterior_size" type="text" class="txt" /></td>
	        </tr>
	        <tr>
	        	<td align="right">有效容积：</td>
	            <td width="262" align="left"><input id="effective_volume" type="text" class="txt" /></td>
	            <td width="120" align="right">产品重量：</td>
	            <td width="320" align="left"><input id="product_weight" type="text" class="txt" /></td>
	        </tr>
	         <tr>
	        	<td align="right">电压：</td>
	            <td width="262" align="left"><input id="voltage" type="text" class="txt" /></td>
	            <td width="120" align="right">电流：</td>
	            <td width="320" align="left"><input id="electric_current" type="text" class="txt" /></td>
	        </tr>
	        <tr>
	        	<td align="right">功率：</td>
	            <td width="262" align="left"><input id="power" type="text" class="txt" /></td>
	            <td width="120" align="right">能耗：</td>
	            <td width="320" align="left"><input id="energy" type="text" class="txt" /></td>
	        </tr>
	        <tr>
	        	<td align="right">温度范围：</td>
	            <td width="262" align="left"><input id="temperature_range" type="text" class="txt" /></td>
	            <td width="120" align="right">冷却剂：</td>
	            <td width="320" align="left"><input id="coolant" type="text" class="txt" /></td>
	        </tr>
	        <tr>
	        	<td align="right">工作方式：</td>
	            <td width="262" align="left"><input id="work_mode" type="text" class="txt" /></td>
	            <td width="120" align="right">产能：</td>
	            <td width="320" align="left"><input id="capacity" type="text" class="txt" /></td>
	        </tr>
	        <tr>
	        	<td align="right">产品图片：</td>
	            <td align="left" colspan="3"><input id="image_url" class="txt" type="file" name="file" style="width:250px;"/></td>
	        </tr>
	        <tr>
	        	<td align="right" valign="top">产品特性：</td>
	            <td align="left" colspan="3" >
	            	<textarea class="ckeditor" name="features"></textarea>
	            </td>
	        </tr>
	        <tr>
	        	<td align="right" valign="top">服务承诺：</td>
	            <td align="left" colspan="3" valign="top">
	            	<textarea class="ckeditor" name="range"></textarea>
	            </td>
	        </tr>
	    </table>
</div>
    
    <div class="pc_win_nav">
        <div class="g_green_line"></div>
        <div class="bottom_navigation">
            <div id="close" onclick="closeHandler()">关闭</div>
            <div id="save" onclick="saveHandler()">保存</div>
        </div>
        <div class="g_green_line"></div>
    </div>
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;"></div>
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;">${c.error }</div>
    
</body>
<script type="text/javascript">
	$(function(){		

		queryProductCategoryList();
		
		PopupWindowScrollbar("productAdd_Edit_JUMP",".scrollbar");
		
		CKEDITOR.replace( 'range', {
				toolbar: [
					['Preview','-','Templates'],
					['Cut','Copy','Paste','PasteText','PasteFromWord','-','SpellChecker', 'Scayt'],
					['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
					['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select'],
					'/',
					['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
					['NumberedList','BulletedList','-','Outdent','Indent','Blockquote','CreateDiv'],
					['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
					['BidiLtr', 'BidiRtl'],
					['Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
					'/',
					['Styles','Format','Font','FontSize'],
					['TextColor','BGColor'],
					['ShowBlocks']
				]
			});
			CKEDITOR.replace( 'features', {
				toolbar: [
					['Preview','-','Templates'],
					['Cut','Copy','Paste','PasteText','PasteFromWord','-','SpellChecker', 'Scayt'],
					['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
					['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select'],
					'/',
					['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
					['NumberedList','BulletedList','-','Outdent','Indent','Blockquote','CreateDiv'],
					['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
					['BidiLtr', 'BidiRtl'],
					['Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
					'/',
					['Styles','Format','Font','FontSize'],
					['TextColor','BGColor'],
					['ShowBlocks']
				]
			});
	})

	function queryProductCategoryList(){
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/productCategory/queryProductCategoryList",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if(msg && (msg.success+"") == "true"){
					var _option = '<option value="-1">-请选择--</option>';
					$.each(msg.object,function(idx,item){
						var _id  = item.id;var _product_use = item.product_use || '&nbsp';
						_option += '<option value="'+_id+'">'+_product_use+'</option>';
					});
					$("#device_type_id").html(_option);
				}
			}
		});
	}

	function saveHandler(){
		var _id               = "${c.id }";
		
		var _stock         = $("#stock").attr("value");//库存
		if(_stock.length <=0){alert("库存不能为空！");return;}
		if(isNaN(_stock)){alert("库存只能为数字！");return;}
		var _taobao_links  = $("#taobao_links").attr("value");//淘宝链接
		
		var _product_name       = $("#product_name").attr("value");//设备名称
		if(_product_name.length > 50){alert("设备名称字符长度应小于50字符！");return false;}
		if(_product_name.length <= 0){alert("设备名称不能为空");return false;}
		
		var _brand = $("#brand").attr("value");
		if(_brand.length > 50){alert("品牌字符长度应小于50字符！");return false;}
		
		var _device_type_id      = $("#device_type_id").val();//设备用途ID
		var _product_category      = $("#product_category").attr("value");//类别
		if(_product_category.length > 50){alert("类别字符长度应小于50字符！");return false;}
		
		var _place_origin      = $("#place_origin").attr("value");//产地
		if(_place_origin.length > 50){alert("产地字符长度应小于50字符！");return false;}
		
		var _model      = $("#model").attr("value");//型号
		if(_model.length > 50){alert("型号字符长度应小于50字符！");return false;}
		
		var _material      = $("#material").attr("value");//材质
		if(_material.length > 50){alert("材质字符长度应小于50字符！");return false;}
		
		var _exterior_size      = $("#exterior_size").attr("value");//外观尺寸
		if(_exterior_size.length > 50){alert("外观尺寸字符长度应小于50字符！");return false;}
		
		var _effective_volume      = $("#effective_volume").attr("value");//有效容积
		if(_effective_volume.length > 50){alert("有效容积字符长度应小于50字符！");return false;}
		
		var _product_weight      = $("#product_weight").attr("value");//产品重量
		if(_product_weight.length > 50){alert("产品重量字符长度应小于50字符！");return false;}
		
		var _voltage      = $("#voltage").attr("value");//电压
		if(_voltage.length > 50){alert("电压字符长度应小于50字符！");return false;}
		
		var _electric_current      = $("#electric_current").attr("value");//电流
		if(_electric_current.length > 50){alert("电流字符长度应小于50字符！");return false;}
		
		var _power      = $("#power").attr("value");//功率
		if(_power.length > 50){alert("功率字符长度应小于50字符！");return false;}
		
		var _energy      = $("#energy").attr("value");//能耗
		if(_energy.length > 50){alert("能耗字符长度应小于50字符！");return false;}
		
		var _temperature_range      = $("#temperature_range").attr("value");//温度范围
		if(_temperature_range.length > 50){alert("温度范围字符长度应小于50字符！");return false;}
		
		var _coolant      = $("#coolant").attr("value");//冷却剂
		if(_coolant.length > 50){alert("冷却剂字符长度应小于50字符！");return false;}
		
		var _work_mode      = $("#work_mode").attr("value");//工作方式
		if(_work_mode.length > 50){alert("工作方式字符长度应小于50字符！");return false;}
		
		var _capacity      = $("#capacity").attr("value");//产能
		if(_capacity.length > 50){alert("产能字符长度应小于50字符！");return false;}
		
		var _features = CKEDITOR.instances.features.getData();//产品特性
		if(_features.length > 65535){alert("产品特性长度应小于65535字符！");return false;}
		
		var _range = CKEDITOR.instances.range.getData()//
		if(_range.length > 65535){alert("产能字符长度应小于65535字符！");return false;}
		
		$("#loading").css("display","block").css("background-color","#090").html("正在保存，请稍后！");
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/product/save",
			dataType:"json",
			data:"id="+_id+"&product_name="+_product_name+"&device_type_id="+_device_type_id+"&product_category="+_product_category+"&place_origin="+_place_origin+"&model="+_model+"&material="+_material+"&exterior_size="+_exterior_size+"&effective_volume="+_effective_volume+"&product_weight="+_product_weight+"&voltage="+_voltage+"&electric_current="+_electric_current+"&power="+_power+"&energy="+_energy+"&temperature_range="+_temperature_range+"&coolant="+_coolant+"&work_mode="+_work_mode+"&capacity="+_capacity+"&stock="+_stock+"&taobao_links="+_taobao_links+"&features="+_features+"&range="+_range+"&brand="+_brand,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("保存成功！");
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/product/productJump");
				}else{
					$("#loading").css("display","block").css("background-color","#F30").html(msg.message);
					setTimeout(function(){
						$("#loading").fadeOut();
					},5000)
				}
			}
		});
	}
	
	function closeHandler(){
		window.parent.remove("productAdd_Edit_JUMP");
	}
</script>
</html>
