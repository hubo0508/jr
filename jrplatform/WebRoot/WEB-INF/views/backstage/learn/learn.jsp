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
    
    <title>学习文档库_List</title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
	
	<script src="<%=JQ %>/jquery-1.7.js" type="text/javascript"></script>
	<script src="<%=JS %>/common.js" type="text/javascript"></script>
    
    <script src="<%=JS%>/navigation.button.js" type="text/javascript"></script>
     
    <script src="<%=JS%>/table.tools.min.js" type="text/javascript"></script>
     <link href="<%=CSS%>/table.css" rel="stylesheet" type="text/css" />
        
    <link href="<%=CSS%>/shared.css" rel="stylesheet" type="text/css" />
    <link href="<%=CSS%>/linksButton.css" rel="stylesheet" type="text/css" />
       
    <script src="<%=JS%>/search.js" type="text/javascript"></script> 
    <link href="<%=CSS%>/search.css" rel="stylesheet" type="text/css" />
     
    <script src="<%=JS%>/jquery.pagination.js" type="text/javascript"></script>
    <link href="<%=CSS%>/jquery.pagination.css" rel="stylesheet" type="text/css" /> 
	
	<script src="<%=JS%>/jquery-ui.min.js" type="text/javascript"></script>
    <script src="<%=JS%>/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
    <script src="<%=JS%>/jquery.ui.datepicker-zh-CN.js" type="text/javascript"></script>  
    <link href="<%=CSS%>/jquery-ui.css" rel="stylesheet" type="text/css" />
    
</head>

<style>body{height:100%}</style>

<body sroll="no">

    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="title_t">
    	<tr>
        	<td>
            	<div class="labelDiv">    	
                    <div class="labelTitle">学习文档库</div>
                    <div class="g_gray_line workTitleLine"></div>
                    
                    <div class="linksButton">
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon delete">&nbsp;</span><span class="text">删除</span></div></div> 
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon add">&nbsp;</span><span class="text">新增</span></div></div> 
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon refresh">&nbsp;</span><span class="text">刷新/查询</span></div></div>     
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
                    			<td align="right">维护类别：</td>
                                <td align="left"><select class="txt" id="major_category_id"></select></td>
                    			<td align="right">文档类别：</td>
                                <td align="left"><select class="txt" id="small_category_id"></select></td>
                    		</tr>
                    		<tr>
                    			<td align="right">文档名称：</td>
                                <td align="left"><input id="file_name" type="text" class="txt"/></td>
                    			<td align="right">视频名称：</td>
                                <td align="left"><input id="video_name" type="text" class="txt"/></td>
                    		</tr>
                    	</table>
                    </div>                   
                </div>
            </td>
        </tr>
    </table>
    
    <DIV class="scrollbar" id="scrollbar">    
        <table class="table table-bordered" width="100%" style="padding-right:20px; table-layout: fixed; z-index:0">
           <tbody id="tbody"></tbody>
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
		
		queryMajorCategory();
		querySmallCategory();
	});
	
	var loading;
	function getList(pageSize,start)
	{
		showLoading({text:"正在加载数据，请稍后！"});
		
		var _file_name = $("#file_name").attr("value");
		var _video_name = $("#video_name").attr("value");
		var _major_category_id = $("#major_category_id").val();
		var _small_category_id = $("#small_category_id").val();
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/learn/list",
			dataType:"json",
			data:"pageSize="+pageSize+"&start="+start+"&file_name="+_file_name+"&video_name="+_video_name+"&major_category_id="+_major_category_id+"&small_category_id="+_small_category_id,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				hideLoading();
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
			$(".pagination").pagination(msg.totalSize, null);
		}
		
		var seq = 1;
		var _table = "";
		
		$.each(msg.object,function(idx,item){ 
			var _id = item.id || "&nbsp;";
			var _major_category = item.major_category || "&nbsp;";
			var _small_category = item.small_category || "&nbsp;";
			var _file_name = item.file_name || "&nbsp;";
			var _video_name = item.video_name || "&nbsp;";
			
			_table += '<tr>'+
					'   <td class="c">'+seq+'</td>'+
					'	<td class="c"><input type="checkbox" name="tdcb" value="'+_id+'"/></td>'+
	           		'   <td class="c"><span class="tablebtn" onclick="edit('+_id+')">编辑</span>&nbsp;<span class="tablebtn" onclick="deletes('+_id+')">删除</span></td>'+
					'	<td class="c" title="'+_major_category+'">'+_major_category+'</td>'+
					'	<td class="c" title="'+_small_category+'">'+_small_category+'</td>'+
					'	<td class="c" title=""><a class="zp" target="_blank" href="${pageContext.servletContext.contextPath}/system/view?file='+item.file_url+'">'+_file_name+'</a></td>'+
					'	<td class="c" title=""><a class="zp" target="_blank" href="${pageContext.servletContext.contextPath}/system/video?file='+item.video_url+'">'+_video_name+'</a></td>'+
					'</tr>';
			seq++;
		}); 
		
		var _head = '<tr><th width="30">序号</th><th width="30" height="30" class="c">选择</th><th width="65" class="c">编辑</th>'+
					'<th width="80" class="c">维护类别</th><th width="80" class="c">文档类别</th><th width="300" class="c">文件名称</th>'+
					'<th width="300" class="c">视频名称</th></tr>';
		
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
				content: "${pageContext.servletContext.contextPath}/learn/addJump",
				title:"新增文档",
				css: {width: '840px',height:'80%'},
				pw_id :"learn_add_edit",
				callback:function(type){return true;}
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
			url : "${pageContext.servletContext.contextPath}/learn/delete",
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
				content: "${pageContext.servletContext.contextPath}/learn/editJump?id="+id,
				title:"编辑文档",
				css: {width: '840px',height:'80%'},
				pw_id :"learn_add_edit",
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
						_option += '<option value="'+_id+'">'+_major_category+'</option>';
					});
					$("#major_category_id").html(_option);
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
						_option += '<option value="'+_id+'">'+_small_category+'</option>';
					});
					$("#small_category_id").html(_option);
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
