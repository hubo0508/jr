<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>金嵘厨房后台管理系统</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/jquery-1.7.js"></script>
    
    <script src="<%=request.getContextPath()%>/resources/backstage/js/navigation.button.js" type="text/javascript"></script>
     
    <script src="<%=request.getContextPath()%>/resources/backstage/js/table.tools.js" type="text/javascript"></script>
     <link href="<%=request.getContextPath()%>/resources/backstage/css/table.css" rel="stylesheet" type="text/css" />
        
    <link href="<%=request.getContextPath()%>/resources/backstage/css/shared.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath()%>/resources/backstage/css/linksButton.css" rel="stylesheet" type="text/css" />
       
    <script src="<%=request.getContextPath()%>/resources/backstage/js/search.js" type="text/javascript"></script> 
    <link href="<%=request.getContextPath()%>/resources/backstage/css/search.css" rel="stylesheet" type="text/css" />
     
    <script src="<%=request.getContextPath()%>/resources/backstage/js/jquery.pagination.js" type="text/javascript"></script>
    <link href="<%=request.getContextPath()%>/resources/backstage/css/jquery.pagination.css" rel="stylesheet" type="text/css" /> 
 	
	<script src="<%=request.getContextPath()%>/resources/backstage/js/loading-min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/backstage/js/jquery.bgiframe.min.js" type="text/javascript"></script>
	<link href="${pageContext.request.contextPath}/resources/backstage/css/loading.css" type="text/css" rel="stylesheet"/>
	
</head>

<style>body{height:100%}</style>

<body sroll="no">

    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="title_t">
    	<tr>
        	<td>
            	<div class="labelDiv">    	
                    <div class="labelTitle">产品中心</div>
                    <div class="g_gray_line workTitleLine"></div>
                    
                    <div class="linksButton">
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon excel">&nbsp;</span><span class="text">导出</span>
                       </div></div>
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon check">&nbsp;</span><span class="text">发布</span>
                       </div></div> 
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon delete">&nbsp;</span><span class="text">删除</span>
                       </div></div> 
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon add">&nbsp;</span><span class="text">新增</span>
                       </div></div> 
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon refresh">&nbsp;</span><span class="text">刷新</span>
                       </div></div>     
                    </div> 
                </div>
            </td>
        </tr>
        <tr >
        	<td>
            	<div class="search">    	
                    <span class="title">查询条件</span> 
                    <span class="t_i"></span>  
                    <div class="t_line"></div>  
                    <div class="round">        	
                        <div>用途分类：<input type="text" class="txt"/></div>
                        <div>日志内容：<input type="text" class="txt"/></div>
                        <div>状态：<select class="txt"><option>全部</option><option>未提交</option><option>待审核</option><option>通过</option></select></div>
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
                <th width="65" class="c">编辑</th>
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
    <div class="page" id="log_r_page" ><div class="pagination"></div></div>
   
   
</body>
<script type="text/javascript">
	
	var page_size = 30;
	
	$(function(){	
		getList(page_size,1);			   
		$(".linksButton").navigationbutton("#FF002B", "#339E35",{callback: clickButtonCallback});
		$(".search").search({callback: function(){$.tableAutoScroll();$.changeTableHead()}});
	});
	
	var loading;
	function getList(pageSize,start)
	{
		if(loading == undefined){loading=new ol.loading({id:"scrollbar"})}
		loading.show();
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/product/queryProductList",
			dataType:"json",
			data:"pageSize="+pageSize+"&start="+start,
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
	
	var maxentries = 0;
	function setSearchresult(msg)
	{
		if(maxentries != msg.totalSize){
			var opt = {callback: pageselectCallback};
				opt.current_page        = (msg.thisPage-1);
				opt.items_per_page      = msg.pageSize;
			maxentries = msg.totalSize;
			$(".pagination").pagination(msg.totalSize, opt);
		}
		
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

			
			_table += '<tr>'+
					'   <td class="c">'+seq+'</td>'+
					'	<td class="c"><input type="checkbox" name="tdcb" value="'+_id+'"/></td>'+
	           		'   <td class="c"><span class="tablebtn" onclick="edit('+_id+')">编辑</span>&nbsp;<span class="tablebtn" onclick="deletes('+_id+')">删除</span></th>'+
					'	<td class="c">'+_product_use+'</td>'+
					'	<td class="c">'+_stock+'</td>'+
					'	<td class="c">'+_product_category+'</td>'+
					'	<td class="c">'+_product_name+'</td>'+
					'	<td class="c">'+_brand+'</td>'+
					'	<td class="c">'+_place_origin+'</td>'+
					'	<td class="c">'+_model+'</td>'+
					'	<td class="c">'+_material+'</td>'+
					'	<td class="c">'+_exterior_size+'</td>'+
					'	<td class="c">'+_effective_volume+'</td>'+
					'	<td class="c">'+_product_weight+'</td>'+
					'	<td class="c">'+_voltage+'</td>'+
					'	<td class="c">'+_electric_current+'</td>'+
					'	<td class="c">'+_power+'</td>'+
					'	<td class="c">'+_energy+'</td>'+
					'	<td class="c">'+_temperature_range+'</td>'+
					'	<td class="c">'+_coolant+'</td>'+
					'	<td class="c">'+_work_mode+'</td>'+
					'	<td class="c">'+_capacity+'</td>'+
					'</tr>';
					   
			seq++;
		}); 
		
		var _head ='<tr>'+
			            '	<th width="30">序号</th>'+
			            '    <th width="30" height="30" class="c">选择</th>'+
			            '    <th width="65" class="c">操作</th>'+
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
		$.tableAutoScroll({fixed_target:[".title_t:height",15]});
	}
	
	function logInit(){
		$("body").append('<div id="outlog" style="height:100%; width:200px; position:absolute; background-color:#999;"></div>');	
	}
	
	function clickButtonCallback(text){
		if(text == "刷新"){getList(page_size,1);return;}
		
		if(text == "新增"){
			window.parent.popup({ 
				message: 'popup_links', 
				content: "${pageContext.servletContext.contextPath}/product/productAddJump",
				title:"新增设备",
				css: {width: '840px',height:'80%'},
				pw_id :"productAdd_Edit_JUMP",
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
				content: "确认删除选择数据？",
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
		
		$("#loading").css("display","block").css("background-color","#090").html("正在删除数据，请稍后！");
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/product/deleteByIds",
			dataType:"json",
			data:"ids="+ids,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("删除成功！");
					getList(page_size,_page_index);
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
			content: "确认删除数据？",
			callback:function(type){
				if(type == "confirm"){deleteByIds(id+",")} return true;
			},
			css: {width: '250'} 
		 });
		
	}
	
	function edit(id){
		window.parent.popup({ 
				message: 'popup_links', 
				content: "${pageContext.servletContext.contextPath}/product/productEditJump?id="+id,
				title:"编辑设备信息",
				css: {width: '840px',height:'80%'},
				pw_id :"productAdd_Edit_JUMP",
				callback:function(type){
					return true;
				}
			});	
	}
	var _page_index = 1;
	function pageselectCallback(page_index, msg){
		if(msg != undefined){
			window.parent.alert(msg);
		}else{
			_page_index = page_index+1;
			getList(page_size,page_index+1);
		}
		
		return false;
	}
	
</script>

</html>
