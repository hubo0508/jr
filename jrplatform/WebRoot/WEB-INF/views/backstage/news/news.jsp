<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>新闻动态_List</title>
	
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
    <script src="<%=request.getContextPath()%>/resources/backstage/js/jquery.bgiframe.min.js" type="text/javascript"></script>
	<link href="<%=request.getContextPath()%>/resources/backstage/css/loading.css" type="text/css" rel="stylesheet"/>
	
	<script src="<%=request.getContextPath()%>/resources/backstage/js/jquery-ui.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resources/backstage/js/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/resources/backstage/js/jquery.ui.datepicker-zh-CN.js" type="text/javascript"></script>  
    <link href="<%=request.getContextPath()%>/resources/backstage/css/jquery-ui.css" rel="stylesheet" type="text/css" />
	
</head>

<style>body{height:100%}</style>

<body sroll="no">

    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="title_t">
    	<tr>
        	<td>
            	<div class="labelDiv">    	
                    <div class="labelTitle">新闻动态</div>
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
                    			<td align="right">标题：</td>
                                <td align="left"><input class="txt" id="title"/></td>
                    			<td align="right">发布时间：</td>
                                <td align="left"><input id="sTime" type="text" class="txt"/>至<input id="eTime" type="text" class="txt"/></td>
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
            	<th width="30">序号</th>
                <th width="30" height="30" class="c">选择</th>
                <th width="65" class="c">编辑</th>
                <th width="300" class="c">标题</th>
                <th width="100" class="c">发布时间</th>
                <th class="c">内容</th>
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
		
		$('#sTime').datepicker({dateFormat: "yy-mm-dd",showHour: false,showMinute:false,showTime:false});
		$('#eTime').datepicker({dateFormat: "yy-mm-dd",showHour: false,showMinute:false,showTime:false});
	});
	
	var loading;
	function getList(pageSize,start)
	{
		if(loading == undefined){loading=new ol.loading({id:"scrollbar"})}
		loading.show();
		
		var _title = $("#title").attr("value");
		var sTime = $("#sTime").attr("value");
		var eTime = $("#eTime").attr("value");
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/news/list",
			dataType:"json",
			data:"pageSize="+pageSize+"&start="+start+"&title="+_title+"&sTime="+sTime+"&eTime="+eTime,
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
		
		if(maxentries == 0){
			$(".pagination").pagination(msg.totalSize, null);
		}
		
		var seq = 1;
		var _table = "";
		
		$.each(msg.object,function(idx,item){ 
			var _id = item.id || "&nbsp;";
			var _title = item.title || "&nbsp;";
			var _content = item.content || "&nbsp;";
			var _publish_time = item.publish_time || "&publish_time";
			
			_content = _content.replace(/<[^>]+>/g,"");
			
			_table += '<tr>'+
					'   <td class="c">'+seq+'</td>'+
					'	<td class="c"><input type="checkbox" name="tdcb" value="'+_id+'"/></td>'+
	           		'   <td class="c"><span class="tablebtn" onclick="edit('+_id+')">编辑</span>&nbsp;<span class="tablebtn" onclick="deletes('+_id+')">删除</span></th>'+
					'	<td class="c" title="'+_title+'">'+_title+'</td>'+
					'	<td class="c" title="'+_publish_time+'">'+_publish_time+'</td>'+
					'	<td class="c" title="'+_content+'">'+_content+'</td>'+
					'</tr>';
			seq++;
		}); 
		
		var _head ='<tr><th width="30">序号</th><th width="30" height="30" class="c">选择</th><th width="65" class="c">编辑</th>'+
		           '<th width="300" class="c">标题</th><th width="100" class="c">发布时间</th><th class="c">内容</th></tr>';
		
		$("#tbody").html(_head + _table);
		
		$.installTable({checkboxIndex:2});
		$.cloneTableHead();		
		$.tableAutoScroll({fixed_target:[".title_t:height",15]});
	}
	
	function clickButtonCallback(text){
		if(text == "刷新/查询"){getList(page_size,_page_index);return;}
		
		if(text == "新增"){
			window.parent.popup({ 
				message: 'popup_links', 
				content: "${pageContext.servletContext.contextPath}/news/addJump",
				title:"新增新闻动态",
				css: {width: '840px',height:'80%'},
				pw_id :"news_add_edit",
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
			url : "${pageContext.servletContext.contextPath}/news/delete",
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
				content: "${pageContext.servletContext.contextPath}/news/editJump?id="+id,
				title:"编辑新闻动态",
				css: {width: '840px',height:'80%'},
				pw_id :"news_add_edit",
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
