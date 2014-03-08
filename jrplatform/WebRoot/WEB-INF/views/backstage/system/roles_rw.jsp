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
    
    <title>角色_读写权限列表页面</title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
	
    <script src="<%=JQ %>/jquery-1.7.js" type="text/javascript"></script>
    <script src="<%=JS %>/common.js" type="text/javascript"></script>
          
    <script src="<%=JS %>/navigation.button.js" type="text/javascript"></script>
     
    <script src="<%=JS %>/table.tools.js" type="text/javascript"></script>
    <link href="<%=CSS%>/table.css" rel="stylesheet" type="text/css" />
        
    <link href="<%=CSS%>/shared.css" rel="stylesheet" type="text/css" />
    <link href="<%=CSS%>/linksButton.css" rel="stylesheet" type="text/css" />
    
    <script src="<%=JS %>/search.js" type="text/javascript"></script> 
    <link href="<%=CSS%>/search.css" rel="stylesheet" type="text/css" />
    
    <script src="<%=JS %>/jquery.pagination.js" type="text/javascript"></script>
    <link href="<%=CSS%>/jquery.pagination.css" rel="stylesheet" type="text/css" /> 
    
</head>

<style>
	body{height:100%}
</style>

<body sroll="no">

    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="title_t">
    	<tr>
        	<td>
            	<div class="labelDiv">    	
                    <div class="labelTitle">系统权限管理</div>
                    <div class="g_gray_line workTitleLine"></div>
                    
                    <div class="linksButton">
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon delete">&nbsp;</span><span class="text">只读</span>
                       </div></div> 
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon add">&nbsp;</span><span class="text">读写</span>
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
                    			<td align="right">角色名称：</td>
                                <td align="left"><select class="txt" id="rolename"></select></td>
                    			<td align="right">角色读写权限：</td>
                                <td align="left">
									<select class="txt" id=rw><option value="-1"  selected="true">--全部--</option><option value="r">只读</option><option value="w">读写</option></select>
								</td>
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
					<th width="30">序号</th>
		            <th width="30" height="30" class="c">选择</th>
		            <th width="65" class="c">编辑</th>
		            <th width="100" class="c">权限级别</th>
		            <th width="200" class="c">权限名称</th>
		            <th class="l">权限描述</th>
	            </tr>
           </tbody>            
        </table>
    </DIV>
   
	<div class="g_green_line"></div>   
     <div class="page" id="log_r_page" ><div class="pagination"></div></div>
     
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:10px; left:285px; display:none; font-size:14px"></div>
    
</body>
<script type="text/javascript">
	var page_size = 30;
	$(function(){	
	
		getList(page_size,1);
		
		$(".linksButton").navigationbutton("#FF002B", "#339E35",{callback: clickButtonCallback});
		$(".search").search({callback: function(){$.tableAutoScroll();$.changeTableHead();}});
		
		queryAuthorizeRoleList();
	});
			
	function queryAuthorizeRoleList(){
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/role/authorizeRoleList",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if(msg && (msg.success+"") == "true"){
					var _option = '<option value="-1">--全部--</option>';
					$.each(msg.object,function(idx,item){
						_option += '<option value="'+item.rid+'">'+item.rolename+'</option>';
					});
					$("#rolename").html(_option);
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
	
	function getList(pageSize,start)
	{
		showLoading({text:"正在加载数据，请稍后！"});
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/rolemenu/rolerwList",
			dataType:"json",
			data:"pageSize="+pageSize+"&start="+start+"&role_id="+$("#rolename").val()+"&rw="+$("#rw").val(),
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
	function setSearchresult(msg){
		
		if(maxentries != msg.totalSize){
			var opt = {callback: pageselectCallback};
				opt.current_page        = (msg.thisPage-1);
				opt.items_per_page      = msg.pageSize;
			maxentries = msg.totalSize;
			$(".pagination").pagination(msg.totalSize, opt);
		}
		
		var _table = "";
	
		var count = 1;
		$.each(msg.object,function(idx,item){
			var _id               = item.id;
			var _roletype = item.rw;
			_roletype = _roletype == "w" ? "读写" : "只读";
			
			_table += 
				'<tr>'+
				'    <td class="c">'+count+'</td>'+
	            '    <td class="c"><input type="checkbox" name="tdcb" value="'+_id+'"/></td>';
	            
	            if(_roletype == "读写"){
	            	_table += '<td class="c"><span class="tablebtn" onclick="setr('+_id+')">只读</span></th>';
	            }else{
	            	_table += '<td class="c"><span class="tablebtn" onclick="setw('+_id+')">读写</span></th>';
	            }
	            
	       _table += 
	       		'    <td class="c">'+item.rolename+'</td>'+
	            '    <td class="c">'+_roletype+'</td>'+
	            '    <td class="c">'+item.topm+'</td>'+
	            '    <td class="c">'+item.name+'</td>'+
	            '    <td class="l">'+(item.roleremark || '&nbsp;')+'</td>'+
	            '</tr>';
	            
	            count++;
		});
		var _head = '<tr>'+
					'<th width="30">序号</th>'+
		            '<th width="30" height="30" class="c">选择</th>'+
		            '<th width="60" class="c">编辑</th>'+
		            '<th width="200" class="c">角色名称</th>'+
		            '<th width="60" class="c">角色权限</th>'+
		            '<th width="150" class="c">顶级菜单</th>'+
		            '<th width="150" class="c">菜单名称</th>'+
		            '<th class="l">角色描述</th>'+
		            '</tr>';
		$("#tbody").html(_head + _table);
		
		$.installTable({checkboxIndex:2});
		$.cloneTableHead();		
		$.tableAutoScroll({fixed_target:[".title_t:height",15]});
	}
	
	function setr(id){
		set(id,"r");
	}
	
	function setw(id){
		set(id,"w");
	}
	
	function set(ids,type){
		showLoading({text:"正在更新权限级别，请稍后！"});
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/rolemenu/saverw",
			dataType:"json",
			data:"rw="+type+"&ids="+ids,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					showLoading({text:"权限级别更新成功！",timeout:5000});
					getList(page_size,_page_index);
				}else{
					hideLoading();
					window.parent.alert(msg.message);	
				}
			}
		});
	}

	function clickButtonCallback(text){
		if(text == "刷新/查询"){getList(page_size,_page_index);return;}
		
		var ids = "";
		 $('input[name="tdcb"]:checked').each(function(){    
	   		ids += $(this).attr("value")+",";
	  	 });    
	  	 if(ids.length == 0){
	  	 	window.parent.alert("请选择数据！");	
	  	 	return;
	  	 }	
		
		if(text == "只读"){
			 window.parent.popup({ 
				message: 'popup_alert', 
				pw_confirm_display:true,
				content: "确认权限设置为‘只读’？",
				callback:function(type){
					if(type == "confirm"){set(ids,"r")}
					return true;
				},
				css: {width: '250'} 
			 });
		}	
		
		if(text == "读写")
		{
			window.parent.popup({ 
				message: 'popup_alert', 
				pw_confirm_display:true,
				content: "确认权限设置为‘读写’？",
				callback:function(type){
					if(type == "confirm"){set(ids,"w")}
					return true;
				},
				css: {width: '250'} 
			 });
		}
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
