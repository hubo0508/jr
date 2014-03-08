<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();

String JS  = path + "/resources/backstage/js";
String CSS = path + "/resources/backstage/css";
String JQ  = path + "/resources";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    
    <script src="<%=JQ %>/jquery-1.7.js" type="text/javascript"></script>
    
    <script src="<%=JS%>/navigation.button.js" type="text/javascript"></script>
     
    <script src="<%=JS%>/table.tools.js" type="text/javascript"></script>
    <link href="<%=CSS%>/table.css" rel="stylesheet" type="text/css" />
        
    <link href="<%=CSS%>/shared.css" rel="stylesheet" type="text/css" />
    <link href="<%=CSS%>/linksButton.css" rel="stylesheet" type="text/css" />
       
    <script src="<%=JS%>/search.js" type="text/javascript"></script> 
    <link href="<%=CSS%>/search.css" rel="stylesheet" type="text/css" />
     
    <script src="<%=JS%>/jquery.pagination.js" type="text/javascript"></script>
    <link href="<%=CSS%>/jquery.pagination.css" rel="stylesheet" type="text/css" /> 
 	
	<script src="<%=JS%>/loading-min.js" type="text/javascript"></script>
    <script src="<%=JS%>/jquery.bgiframe.min.js" type="text/javascript"></script>
	<link href="<%=CSS%>/loading.css" type="text/css" rel="stylesheet"/>
	
</head>

<style>body{height:100%}</style>

<body sroll="no">

    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="title_t">
    	<tr>
        	<td>
            	<div class="labelDiv">    	
                    <div class="labelTitle">配件中心</div>
                    <div class="g_gray_line workTitleLine"></div>
                    
                    <div class="linksButton">
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon excel">&nbsp;</span><span class="text">批量导入</span>
                       </div></div>
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon delete">&nbsp;</span><span class="text">删除</span>
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
        <tr >
        	<td>
            	<div class="search">    	
                    <span class="title">查询条件</span> 
                    <span class="t_i"></span>  
                    <div class="t_line"></div>  
                    <div class="round">
                    	<table width="100%" style="font-size:12px;">
                    		<tr>
                    			<td align="right">自定义分类：</td>
                                <td align="left"><select class="txt" id="device_type_use_id"></select></td>
                    			<td align="right">库存：</td>
                                <td align="left"><input id="stock" type="text" class="txt"/></td>
                    			<td align="right">专业分类：</td>
                                <td align="left"><select class="txt" id="device_type_sort_id"></select></td>
                    		</tr>
                    		<tr>
                    			<td align="right">配件名称：</td>
                                <td align="left"><input id="fitting_name" type="text" class="txt"/></td>
                    			<td align="right">品牌：</td>
                                <td align="left"><input id="brand" type="text" class="txt"/></td>
                    			<td align="right">配件编号：</td>
                                <td align="left"><input id="fitting_number" type="text" class="txt"/></td>
                    		</tr>
                    		<tr>
                    			<td align="right">适用型号：</td>
                                <td align="left"><input id="models" type="text" class="txt"/></td>
                    			<td align="right">&nbsp;</td>
                                <td align="left">&nbsp;</td>
                    			<td align="right">&nbsp;</td>
                                <td align="left">&nbsp;</td>
                    		</tr>
                    	</table>
                    </div>                   
                </div>
            </td>
        </tr>
    </table>
    
    <DIV class="scrollbar" id="scrollbar">    
        <table class="table table-bordered" width="100%" style="padding-right:20px; table-layout: fixed; z-index:0">
           <tbody id="tbody">
           	<tr>
                <th width="30" height="30" class="c">选择</th>
                <th width="65" class="c">编辑</th>
                <th width="55" class="c">库存</th>
                <th width="75" class="c">自定义分类</th>
                <th width="150" class="c">专业分类</th>
                <th width="80" class="c">配件名称</th>
                <th width="80" class="c">品牌</th>
                <th width="80" class="c">配件编号</th>
                <th width="80" class="c">规格描述</th>
                <th width="250" class="c">适用型号</th>
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
		
		queryCategoryList();
		querySpecialtyCategoryList();
	});
	
	var loading;
	function getList(pageSize,start)
	{
		if(loading == undefined){loading=new ol.loading({id:"scrollbar"})}
		loading.show();
		
		var _stock         = $("#stock").attr("value");//库存
		var _device_type_use_id = $("#device_type_use_id").val();
		var _device_type_sort_id = $("#device_type_sort_id").val();
		var _fitting_name = $("#fitting_name").attr("value");
		var _brand = $("#brand").attr("value");
		var _fitting_number = $("#fitting_number").attr("value");
		var _models = $("#models").attr("value");
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/fitting/list",
			dataType:"json",
			data:"pageSize="+pageSize+"&start="+start+"&stock="+_stock+"&device_type_use_id="+_device_type_use_id+"&device_type_sort_id="+_device_type_sort_id+"&fitting_name="+_fitting_name+"&brand="+_brand+"&fitting_number="+_fitting_number+"&models="+_models,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				loading.hide();
				if((msg.success+"") == "true"){
					setSearchresult(msg);
				}else{
					window.parent.alert(msg.message);
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
		
		if(maxentries == 0){
			$(".pagination").pagination("", null);
		}
		
		var seq = 1;
		var _table = "";
		
		$.each(msg.object,function(idx,item){ 
			var _id = item.id || "&nbsp;";
			var _stock = item.stock || "&nbsp;";
			var _fitting_name = item.fitting_name || "&nbsp;";
			var _device_type_use = item.device_type_use || "&nbsp;";
			var _device_type_sort = item.device_type_sort || "&nbsp;";
			var _brand = item.brand || "&nbsp;";
			var _fitting_number = item.fitting_number || "&nbsp;";
			var _specification_desc = item.specification_desc || "&nbsp;";
			var _models = item.models || "&nbsp;";
			
			_table += '<tr>'+
					'   <td class="c">'+seq+'</td>'+
					'	<td class="c"><input type="checkbox" name="tdcb" value="'+_id+'"/></td>'+
	           		'   <td class="c"><span class="tablebtn" onclick="edit('+_id+')">编辑</span>&nbsp;<span class="tablebtn" onclick="deletes('+_id+')">删除</span></th>'+
					'	<td class="c">'+_fitting_name+'</td>'+
					'	<td class="c">'+_stock+'</td>'+
					'	<td class="c">'+_device_type_use+'</td>'+
					'	<td class="c">'+_device_type_sort+'</td>'+
					'	<td class="c">'+_brand+'</td>'+
					'	<td class="c">'+_fitting_number+'</td>'+
					'	<td class="c">'+_specification_desc+'</td>'+
					'	<td class="c">'+_models+'</td>'+
					'</tr>';
			seq++;
		}); 
		
		var _head ='<tr>'+
			       '	<th width="30">序号</th>'+
			       '	<th width="30" height="30" class="c">选择</th>'+
	               '	<th width="65" class="c">编辑</th>'+
	               '	<th width="150" class="c">配件名称</th>'+
	               '	<th width="55" class="c">库存</th>'+
	               '	<th width="150" class="c">自定义分类</th>'+
	               '	<th width="150" class="c">专业分类</th>'+
	               '	<th width="80" class="c">品牌</th>'+
	               '	<th width="150" class="c">配件编号</th>'+
	               '	<th width="150" class="c">规格描述</th>'+
	               '	<th width="250" class="c">适用型号</th>'+
			       '</tr>';
		
		$("#tbody").html(_head + _table);
		
		$.installTable({checkboxIndex:2});
		$.cloneTableHead();		
		$.tableAutoScroll({fixed_target:[".title_t:height",15]});
	}
	
	function clickButtonCallback(text){
		if(text == "刷新/查询"){getList(page_size,1);return;}
		
		if(text == "新增"){
			window.parent.popup({ 
				message: 'popup_links', 
				content: "${pageContext.servletContext.contextPath}/fitting/addJump",
				title:"新增配件",
				css: {width: '840px',height:'80%'},
				pw_id :"fittingAdd_Edit_JUMP",
				callback:function(type){
					return true;
				}
			});	
		}
		if(text == "批量导入"){
			window.parent.popup({ 
				message: 'popup_links', 
				content: "${pageContext.servletContext.contextPath}/fitting/fittingImport",
				title:"批量导入",
				css: {width: '640px',height:'50%'},
				pw_id :"fittingImport_JUMP",
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
			url : "${pageContext.servletContext.contextPath}/fitting/deleteByIds",
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
				content: "${pageContext.servletContext.contextPath}/fitting/editJump?id="+id,
				title:"编辑设备信息",
				css: {width: '840px',height:'80%'},
				pw_id :"fittingAdd_Edit_JUMP",
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
	
	function querySpecialtyCategoryList(){
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/fittingSpecialtyCate/list",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if(msg && (msg.success+"") == "true"){
					var _option = '<option value="-1">--全部--</option>';
					$.each(msg.object,function(idx,item){
						var _id  = item.id;var _fitting_category = item.fitting_category || '&nbsp';
						_option += '<option value="'+_id+'">'+_fitting_category+'</option>';
					});
					$("#device_type_sort_id").html(_option);
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
	
	function queryCategoryList(){
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/productCategory/list",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if(msg && (msg.success+"") == "true"){
					var _option = '<option value="-1">--全部--</option>';
					$.each(msg.object,function(idx,item){
						var _id  = item.id;var _product_use = item.product_use || '&nbsp';
						_option += '<option value="'+_id+'">'+_product_use+'</option>';
					});
					$("#device_type_use_id").html(_option);
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
