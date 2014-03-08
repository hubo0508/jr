<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String filedir = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + "/";

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
    
    <script src="<%=JS %>/navigation.button.js" type="text/javascript"></script>
     
    <script src="<%=JS %>/table.tools.js" type="text/javascript"></script>
     <link href="<%=CSS%>/table.css" rel="stylesheet" type="text/css" />
        
    <link href="<%=CSS%>/shared.css" rel="stylesheet" type="text/css" />
    <link href="<%=CSS%>/linksButton.css" rel="stylesheet" type="text/css" />
       
	<script src="<%=JS %>/loading-min.js" type="text/javascript"></script>
    <script src="<%=JS %>/jquery.bgiframe.min.js" type="text/javascript"></script>
	<link href="<%=CSS%>/loading.css" type="text/css" rel="stylesheet"/>
	
</head>

<style>body{height:100%}</style>

<body sroll="no">

    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="title_t">
    	<tr>
        	<td>
            	<div class="labelDiv">    	
                    <div class="labelTitle">产品滚动管理</div>
                    <div class="g_gray_line workTitleLine"></div>
                    
                    <div class="linksButton">
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon delete">&nbsp;</span><span class="text">取消</span>
                       </div></div> 
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon add">&nbsp;</span><span class="text">新增</span>
                       </div></div> 
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon refresh">&nbsp;</span><span class="text">刷新/查询</span>
                       </div></div>     
                    </div> 
                </div>
            </td>
        </tr>
    </table>
    
    <DIV class="scrollbar" id="scrollbar">    
        <table class="table table-bordered" width="100%" style="padding-right:20px; table-layout: fixed; z-index:0">
           <tbody id="tbody">
            <tr>
            	<th width="30">序号</th>
                <th width="30" height="30" class="c">选择</th>
                <th width="65" class="c">操作</th>
                <th width="65">图片预览</th>
                <th width="150" class="c">用途分类</th>
                <th width="55" class="c">库存</th>
                <th width="75" class="c">产品分类</th>
                <th width="150" class="c">产品名称</th>
                <th width="80" class="c">品牌</th>
                <th width="80" class="c">产地</th>
                <th width="80" class="c">型号</th>
                <th width="80" class="c">材质</th>
                <th width="150" class="c">外观尺寸</th>
                <th width="80" class="c">有效容积</th>
                <th width="80" class="c">产品重量</th>
                <th width="150" class="c">电压</th>
                <th width="150" class="c">电流</th>
                <th width="150" class="c">功率</th>
                <th width="150" class="c">能耗</th>
                <th width="150" class="c">温度范围</th>
                <th width="150" class="c">冷却剂</th>
                <th width="150" class="c">工作方式</th>
                <th width="150" class="c">产能</th>
            </tr>
            </tbody>
        </table>
    </DIV>
   
	<div class="g_green_line"></div>   
   
</body>
<script type="text/javascript">
	
	
	$(function(){	
		getList();			   
		$(".linksButton").navigationbutton("#FF002B", "#339E35",{callback: clickButtonCallback});
	});
	
	
	var loading;
	function getList()
	{
		if(loading == undefined){loading=new ol.loading({id:"scrollbar"})}
		loading.show();
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/lease/scrollList",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				loading.hide();
				if((msg.success+"") == "true"){
					setSearchresult(msg);
				}else{
					window.parent.alert(msg.message);
				}
			}
		});
	}
	
	function setSearchresult(msg)
	{
		
		var seq = 1;
		var _table = "";
		
		$.each(msg.object,function(idx,item){ 
			var _id = item.id || "&nbsp;";
			var _product_use = item.product_use || "&nbsp;";
			var _stock = item.stock || "&nbsp;";
			var _product_category = item.product_category || "&nbsp;";
			var _product_name = item.product_name || "&nbsp;";
			var _brand = item.brand || "&nbsp;";
			var _place_origin = item.place_origin || "&nbsp;";
			var _model = item.model || "&nbsp;";
			var _material = item.material || "&nbsp;";
			var _exterior_size = item.exterior_size || "&nbsp;";
			var _effective_volume = item.effective_volume || "&nbsp;";
			var _product_weight = item.product_weight || "&nbsp;";
			var _voltage = item.voltage || "&nbsp;";
			var _electric_current = item.electric_current || "&nbsp;";
			var _power = item.power || "&nbsp;";
			var _energy = item.energy || "&nbsp;";
			var _temperature_range = item.temperature_range || "&nbsp;";
			var _coolant = item.coolant || "&nbsp;";
			var _work_mode = item.work_mode || "&nbsp;";
			var _capacity = item.capacity || "&nbsp;";
			
			var _url = item.image_url || ""
			
			_table += '<tr>'+
					'   <td class="c">'+seq+'</td>'+
					'	<td class="c"><input type="checkbox" name="tdcb" value="'+_id+'"/></td>'+
	           		'   <td class="c"><span class="tablebtn" onclick="deletes('+_id+')">取消</span></th>';
	           		 
	           		 if(_url == ""){
		            	_table +=  '<td class="c">未上传图片</td>';
		             }else{
		            	_table +=  '<td class="c"><a class="zp"  target="_blank" href="'+_url+'">预览</a></td>';
		             }
		            
		    _table += 
					'	<td class="c" title="'+_product_use+'">'+_product_use+'</td>'+
					'	<td class="c" title="'+_stock+'">'+_stock+'</td>'+
					'	<td class="c" title="'+_product_category+'">'+_product_category+'</td>'+
					'	<td class="c" title="'+_product_name+'">'+_product_name+'</td>'+
					'	<td class="c" title="'+_brand+'">'+_brand+'</td>'+
					'	<td class="c" title="'+_place_origin+'">'+_place_origin+'</td>'+
					'	<td class="c" title="'+_model+'">'+_model+'</td>'+
					'	<td class="c" title="'+_material+'">'+_material+'</td>'+
					'	<td class="c" title="'+_exterior_size+'">'+_exterior_size+'</td>'+
					'	<td class="c" title="'+_effective_volume+'">'+_effective_volume+'</td>'+
					'	<td class="c" title="'+_product_weight+'">'+_product_weight+'</td>'+
					'	<td class="c" title="'+_voltage+'">'+_voltage+'</td>'+
					'	<td class="c" title="'+_electric_current+'">'+_electric_current+'</td>'+
					'	<td class="c" title="'+_power+'">'+_power+'</td>'+
					'	<td class="c" title="'+_energy+'">'+_energy+'</td>'+
					'	<td class="c" title="'+_temperature_range+'">'+_temperature_range+'</td>'+
					'	<td class="c" title="'+_coolant+'">'+_coolant+'</td>'+
					'	<td class="c" title="'+_work_mode+'">'+_work_mode+'</td>'+
					'	<td class="c" title="'+_capacity+'">'+_capacity+'</td>'+
					'</tr>';
					   
			seq++;
		}); 
		
		var _head ='<tr>'+
			            '	<th width="30">序号</th>'+
			            '    <th width="30" height="30" class="c">选择</th>'+
			            '    <th width="65" class="c">操作</th>'+
			            '	 <th width="90">图片预览</th>'+
			            '    <th width="150" class="c">用途分类</th>'+
			            '    <th width="55" class="c">库存</th>'+
			            '    <th width="75" class="c">产品分类</th>'+
			            '    <th width="150" class="c">产品名称</th>'+
			            '    <th width="80" class="c">品牌</th>'+
			            '    <th width="80" class="c">产地</th>'+
			            '    <th width="80" class="c">型号</th>'+
			            '    <th width="80" class="c">材质</th>'+
			            '    <th width="150" class="c">外观尺寸</th>'+
			            '    <th width="80" class="c">有效容积</th>'+
			            '    <th width="80" class="c">产品重量</th>'+
			            '    <th width="150" class="c">电压</th>'+
			            '    <th width="150" class="c">电流</th>'+
			            '    <th width="150" class="c">功率</th>'+
			            '    <th width="150" class="c">能耗</th>'+
			            '    <th width="150" class="c">温度范围</th>'+
			            '    <th width="150" class="c">冷却剂</th>'+
			            '    <th width="150" class="c">工作方式</th>'+
			            '    <th width="150" class="c">产能</th>'+
			            '</tr>';
		
		$("#tbody").html(_head + _table);
		
		$.installTable({checkboxIndex:2});
		$.cloneTableHead();		
		$.tableAutoScroll({fixed_target:[".title_t:height",-25]});
	}
	
	function logInit(){
		$("body").append('<div id="outlog" style="height:100%; width:200px; position:absolute; background-color:#999;"></div>');	
	}
	
	function clickButtonCallback(text){
		if(text == "刷新/查询"){getList();return;}
		
		if(text == "新增"){
			window.parent.popup({ 
				message: 'popup_links', 
				content: "${pageContext.servletContext.contextPath}/lease/selectProductJump",
				title:"选择滚动设备",
				css: {width: '80%',height:'80%'},
				pw_id :"selectProductJump",
				callback:function(type){
					return true;
				}
			});	
		}	
		
		if(text == "删除")
		{
			var ids = "";
			 $('input[name="tdcb"]:checked').each(function(){    
		   		ids += $(this).attr("value")+",";
		  	 });    
		  	 if(ids.length == 0){
		  	 	window.parent.alert("请选择数据！");	
		  	 	return;
		  	 }	
			  
			 window.parent.popup({ 
				message: 'popup_alert', 
				pw_confirm_display:true,
				content: "确认取消选择的产品数据？",
				callback:function(type){
					if(type == "confirm"){deleteByIds(ids)}
					return true;
				},
				css: {width: '250'} 
			 });
		}
	}
	
	function deleteByIds(ids){
		ids = ids.substring(0,ids.length-1);
		
		$("#loading").css("display","block").css("background-color","#090").html("正在取消数据，请稍后！");
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/lease/cancelScroll",
			dataType:"json",
			data:"ids="+ids,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("取消成功！");
					getList();
				}else{
					$("#loading").fadeOut();
					window.parent.alert(msg.message);	
				}
			}
		});
	}
	
	function deletes(id){
		window.parent.popup({ 
			message: 'popup_alert', 
			pw_confirm_display:true,
			content: "确认取消数据？",
			callback:function(type){
				if(type == "confirm"){deleteByIds(id+",")} return true;
			},
			css: {width: '250'} 
		 });
		
	}
	
</script>

</html>
