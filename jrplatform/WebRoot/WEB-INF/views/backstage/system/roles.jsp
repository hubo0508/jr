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
    
    <title>角色表表页面</title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
	
    <script src="<%=JQ %>/jquery-1.7.js" type="text/javascript"></script>
    <script src="<%=JS %>/common.min.js" type="text/javascript"></script>
          
    <script src="<%=JS%>/navigation.button.js" type="text/javascript"></script>
     
    <script src="<%=JS%>/table.tools.js" type="text/javascript"></script>
    <link href="<%=CSS%>/table.css" rel="stylesheet" type="text/css" />
        
    <link href="<%=CSS%>/shared.css" rel="stylesheet" type="text/css" />
    <link href="<%=CSS%>/linksButton.css" rel="stylesheet" type="text/css" />
       
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
    
</body>
<script type="text/javascript">
	
	$(function(){	
		getList();
		$(".linksButton").navigationbutton("#FF002B", "#339E35",{callback: clickButtonCallback});
	});
	
	function getList(pageSize,start)
	{
		showLoading({text:"正在加载数据，请稍后！"});
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/role/list",
			dataType:"json",
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
	
	function setSearchresult(msg){
		
		var _table = "";
	
		var count = 1;
		$.each(msg.object,function(idx,item){
			var _id               = item.id;
			var _roletype = item.roletype;
			_roletype = (_roletype+"") == "0" ? "内部帐号角色" : "第三方帐号角色";
			_table += 
				'<tr>'+
				'    <td class="c">'+count+'</td>'+
	            '    <td class="c"><input type="checkbox" name="tdcb" value="'+_id+'"/></td>'+
	            '    <td class="c"><span class="tablebtn" onclick="edit('+_id+')">编辑</span>&nbsp;<span class="tablebtn" onclick="deletes('+_id+')">删除</span></th>'+
	            '    <td class="c">'+_roletype+'</td>'+
	            '    <td class="c">'+item.rolename+'</td>'+
	            '    <td class="l">'+(item.roleremark || '&nbsp;')+'</td>'+
	            '</tr>';
	            
	            count++;
		});
		var _head = '<tr>'+
					'<th width="30">序号</th>'+
		            '<th width="30" height="30" class="c">选择</th>'+
		            '<th width="65" class="c">编辑</th>'+
		            '<th width="100" class="c">角色类型</th>'+
		            '<th width="200" class="c">角色名称</th>'+
		            '<th class="l">角色描述</th>'+
		            '</tr>';
		$("#tbody").html(_head + _table);
		
		$.installTable({checkboxIndex:2});
		$.cloneTableHead();
		$.tableAutoScroll({fixed_target:[".title_t:height",-25]});	
	}

	function clickButtonCallback(text){
		if(text == "刷新"){getList();return;}
		
		if(text == "新增"){
			window.parent.popup({ 
				message: 'popup_links', 
				content: "${pageContext.servletContext.contextPath}/role/addJump",
				title:"新增数据",
				css: {width: '500px',height:'300px'},
				pw_id :"role_add_edit"
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
		
		showLoading({text:"正在删除数据，请稍后！"});
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/role/delete",
			dataType:"json",
			data:"ids="+ids,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					showLoading({text:"删除成功！",timeout:5000});
					getList();
				}else{
					hideLoading();
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
			content: "${pageContext.servletContext.contextPath}/role/editJump?id="+id,
			title:"编辑数据",
			css: {width: '500px',height:'300px'},
			pw_id :"role_add_edit",
		});	
	}
	
</script>

</html>
