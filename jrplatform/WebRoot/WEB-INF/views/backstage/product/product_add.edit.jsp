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
    <script src="<%=JS %>/popwin_scrollbar.js" type="text/javascript"></script> 
    
    <link href="<%=CSS %>/shared.css" rel="stylesheet" type="text/css" />
    
    <script src="<%=JS %>/ajaxfileupload.min.js" type="text/javascript"></script>
    
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/ueditor.all.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/lang/zh-cn/zh-cn.js"></script>
    
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
   
	    <table cellpadding="0" cellspacing="0" border="0"  width="800" class="base_title_table">
	    	<tr>
	        	<td width="110" align="right">库存：</td>
	            <td width="72" align="left"><input id="stock" name="stock" value="${p.stock }" type="text"  class="txt" style="width:50px"/></td>
	            <td width="76" align="right">淘宝链接：</td>
	            <td width="582" align="left"><input id="taobao_links" value="${p.taobao_links }" name="taobao_links" type="text"  class="txt" style="width:87.5%"/></td>
	        </tr>
	    </table>
	    
		<div class="g_light_green_line" style="margin-top:10px; margin-bottom:10px;"></div>
	    
	    <table cellpadding="0" cellspacing="0" border="0" width="800" class="add_edit_table">
	    	<tr>
	        	<td width="98" align="right">设备名称：</td>
	            <td align="left"><input id="product_name" value="${p.product_name }" name="product_name" type="text" class="txt" /></td>
	            <td width="171" align="right">设备类别：</td>
	            <td width="269" align="left"><select id="device_type_id" name="device_type_id" class="txt" style="width:212px"></select>
	            </td>
	        </tr>
	        <tr>
	        	<td align="right">产品分类：</td>
	            <td width="262" align="left"><input id="product_category" value="${p.product_category }" name="product_category" type="text" class="txt" /></td>
	            <td width="171" align="right">品牌：</td>
	            <td width="269" align="left"><input id="brand" value="${p.brand }" type="text" class="txt" /></td>
	        </tr>
	        <tr>
	        	<td align="right">产地：</td>
	            <td width="262" align="left"><input id="place_origin" value="${p.place_origin }" type="text" class="txt" /></td>
	            <td width="171" align="right">型号：</td>
	            <td width="269" align="left"><input id="model" value="${p.model }" type="text" class="txt" /></td>
	        </tr>
	        <tr>
	        	<td align="right">材质：</td>
	            <td width="262" align="left"><input id="material" value="${p.material }" type="text" class="txt" /></td>
	            <td width="171" align="right">外观尺寸：</td>
	            <td width="269" align="left"><input id="exterior_size" value="${p.exterior_size }" type="text" class="txt" /></td>
	        </tr>
	        <tr>
	        	<td align="right">有效容积：</td>
	            <td width="262" align="left"><input id="effective_volume" value="${p.effective_volume }" type="text" class="txt" /></td>
	            <td width="171" align="right">产品重量：</td>
	            <td width="269" align="left"><input id="product_weight" value="${p.product_weight }" type="text" class="txt" /></td>
	        </tr>
	         <tr>
	        	<td align="right">电压：</td>
	            <td width="262" align="left"><input id="voltage" value="${p.voltage }" type="text" class="txt" /></td>
	            <td width="171" align="right">电流：</td>
	            <td width="269" align="left"><input id="electric_current" value="${p.electric_current }" type="text" class="txt" /></td>
	        </tr>
	        <tr>
	        	<td align="right">功率：</td>
	            <td width="262" align="left"><input id="power" value="${p.power }" type="text" class="txt" /></td>
	            <td width="171" align="right">能耗：</td>
	            <td width="269" align="left"><input id="energy" value="${p.energy }" type="text" class="txt" /></td>
	        </tr>
	        <tr>
	        	<td align="right">温度范围：</td>
	            <td width="262" align="left"><input id="temperature_range" value="${p.temperature_range }" type="text" class="txt" /></td>
	            <td width="171" align="right">冷却剂：</td>
	            <td width="269" align="left"><input id="coolant" value="${p.coolant }" type="text" class="txt" /></td>
	        </tr>
	        <tr>
	        	<td align="right">工作方式：</td>
	            <td width="262" align="left"><input id="work_mode" value="${p.work_mode }" type="text" class="txt" /></td>
	            <td width="171" align="right">产能：</td>
	            <td width="269" align="left"><input id="capacity" value="${p.capacity }" type="text" class="txt" /></td>
	        </tr>
	        <tr>
	        	<td align="right">产品图片：</td>
	            <td align="left">
	            	<input id="select_document" name="select_document" type="file" required="true" class="txt"/>
	            	<span id="image_url" style="display:none"></span>
	            	<br />
                    <span style="font-size:12px; color:#F00">上传图片尺寸为400*400、类型为：jpg、png、gif</span>
	            </td>
	            <td align="left" colspan="2" id="img_td"></td>
	        </tr>
	        <tr>
	        	<td align="right" valign="top">产品特性：</td>
	            <td align="left" colspan="3" >
	            	<script id="features" type="text/plain" style="width:700px;height:400px;">${p.features }</script>
	            </td>
	        </tr>
	        <tr>
	        	<td align="right" valign="top">服务承诺：</td>
	            <td align="left" colspan="3" valign="top">
	            	<script id="service_range" type="text/plain" style="width:700px;height:400px;">${p.service_range }</script>
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
    
</body>
<script type="text/javascript">
	$(function(){		
	
		UE.getEditor('features');
		UE.getEditor('service_range');

		var $win  = $(window);

		var $features = $("#features");
			$features.css("width",$win.width()-150);
			$features.css("height",200);
			
		var $service_range = $("#service_range");
			$service_range.css("width",$win.width()-150);
			$service_range.css("height",200);

		queryProductCategoryList();
		
		PopupWindowScrollbar("productAdd_Edit_JUMP",".scrollbar");
		
	})
	
	function saveAllHandler(){
		
		showLoading({wintype:true,text:"正在保存，请稍后！"});
		
		if($("#select_document").attr("value") == ""){
			saveHandler("${p.image_url }");
			return;
		}
		
		$.ajaxFileUpload({ 
		    url:"${pageContext.servletContext.contextPath}/file/uploadImage?image=select_document",  
		    secureuri:false,  
		    fileElementId:'select_document',  
		    dataType: 'json', 
		    success: function (data, status)
		    {
		    	var j = eval('(' + data.replace(/<[^>]+>/g,"")+ ')');
             	if((j.success+"") == "true"){
             		saveHandler(j.message,"${p.image_url}");
             	}else{
             		hideLoading();
             		window.parent.alert(j.message);
             	}
		    },
		    error: function (data, status, e)
            {
            	window.parent.alert(eval('(' + data.replace(/<[^>]+>/g,"")+ ')').message);
            }
		});  
	}

	function queryProductCategoryList(){
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/productCategory/list",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if(msg && (msg.success+"") == "true"){
					var _option = '<option value="-1">--请选择--</option>';
					$.each(msg.object,function(idx,item){
						var _id  = item.id;var _product_use = item.product_use || '&nbsp';
						if(_id == "${p.device_type_id}"){
							_option += '<option value="'+_id+'" selected="true">'+_product_use+'</option>';
						}else{
							_option += '<option value="'+_id+'">'+_product_use+'</option>';
						}
					});
					$("#device_type_id").html(_option);
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

	function hideLoading(){
		$("#loading").fadeOut();
	}

	function saveHandler(image_url,historyimage){
	
		var _id               = "${p.id }";
		
		var _stock         = $("#stock").attr("value");//库存
		if(_stock.length <=0){alert("库存不能为空！");hideLoading();return;}
		if(isNaN(_stock)){alert("库存只能为数字！");hideLoading();return;}
		var _taobao_links  = $("#taobao_links").attr("value");//淘宝链接
		
		var _product_name       = $("#product_name").attr("value");//设备名称
		if(_product_name.length > 50){alert("设备名称字符长度应小于50字符！");hideLoading();return false;}
		if(_product_name.length <= 0){alert("设备名称不能为空");hideLoading();return false;}
		
		var _brand = $("#brand").attr("value");
		if(_brand.length > 50){alert("品牌字符长度应小于50字符！");hideLoading();return false;}
		
		var _device_type_id      = $("#device_type_id").val();//设备用途ID
		if(_device_type_id == null || _device_type_id == "-1" || _device_type_id.length < 0){alert("设备自定义类别不能为空！");hideLoading();return false;}
		var _product_category      = $("#product_category").attr("value");//类别
		if(_product_category.length > 50){alert("类别字符长度应小于50字符！");hideLoading();return false;}
		
		var _place_origin      = $("#place_origin").attr("value");//产地
		if(_place_origin.length > 50){alert("产地字符长度应小于50字符！");hideLoading();return false;}
		
		var _model      = $("#model").attr("value");//型号
		if(_model.length > 50){alert("型号字符长度应小于50字符！");hideLoading();return false;}
		
		var _material      = $("#material").attr("value");//材质
		if(_material.length > 50){alert("材质字符长度应小于50字符！");hideLoading();return false;}
		
		var _exterior_size      = $("#exterior_size").attr("value");//外观尺寸
		if(_exterior_size.length > 50){alert("外观尺寸字符长度应小于50字符！");hideLoading();return false;}
		
		var _effective_volume      = $("#effective_volume").attr("value");//有效容积
		if(_effective_volume.length > 50){alert("有效容积字符长度应小于50字符！");hideLoading();return false;}
		
		var _product_weight      = $("#product_weight").attr("value");//产品重量
		if(_product_weight.length > 50){alert("产品重量字符长度应小于50字符！");hideLoading();return false;}
		
		var _voltage      = $("#voltage").attr("value");//电压
		if(_voltage.length > 50){alert("电压字符长度应小于50字符！");hideLoading();return false;}
		
		var _electric_current      = $("#electric_current").attr("value");//电流
		if(_electric_current.length > 50){alert("电流字符长度应小于50字符！");hideLoading();return false;}
		
		var _power      = $("#power").attr("value");//功率
		if(_power.length > 50){alert("功率字符长度应小于50字符！");hideLoading();return false;}
		
		var _energy      = $("#energy").attr("value");//能耗
		if(_energy.length > 50){alert("能耗字符长度应小于50字符！");hideLoading();return false;}
		
		var _temperature_range      = $("#temperature_range").attr("value");//温度范围
		if(_temperature_range.length > 50){alert("温度范围字符长度应小于50字符！");hideLoading();return false;}
		
		var _coolant      = $("#coolant").attr("value");//冷却剂
		if(_coolant.length > 50){alert("冷却剂字符长度应小于50字符！");hideLoading();return false;}
		
		var _work_mode      = $("#work_mode").attr("value");//工作方式
		if(_work_mode.length > 50){alert("工作方式字符长度应小于50字符！");hideLoading();return false;}
		
		var _capacity      = $("#capacity").attr("value");//产能
		if(_capacity.length > 50){alert("产能字符长度应小于50字符！");hideLoading();return false;}
		
		var _features = encodeURIComponent(UE.getEditor('features').getContent());
		if(_features.length > 65535){alert("产品特性长度应小于65535字符！");hideLoading();return false;}
		
		var _range = encodeURIComponent(UE.getEditor('service_range').getContent());
		if(_range.length > 65535){alert("售后保障字符长度应小于65535字符！");hideLoading();return false;}
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/product/save",
			dataType:"json",
			data:"id="+_id+"&product_name="+_product_name+"&device_type_id="+_device_type_id+"&product_category="+_product_category+"&place_origin="+_place_origin+"&model="+_model+"&material="+_material+"&exterior_size="+_exterior_size+"&effective_volume="+_effective_volume+"&product_weight="+_product_weight+"&voltage="+_voltage+"&electric_current="+_electric_current+"&power="+_power+"&energy="+_energy+"&temperature_range="+_temperature_range+"&coolant="+_coolant+"&work_mode="+_work_mode+"&capacity="+_capacity+"&stock="+_stock+"&taobao_links="+_taobao_links+"&features="+_features+"&range="+_range+"&brand="+_brand+"&image_url="+image_url+"&historyimage="+historyimage,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					showLoading({wintype:true,text:"保存成功！"});
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/product/productJump");
				}else{
					showLoading({wintype:true,text:msg.message,type:'error',timeout:5000});
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
		window.parent.remove("productAdd_Edit_JUMP");
	}
</script>
</html>
