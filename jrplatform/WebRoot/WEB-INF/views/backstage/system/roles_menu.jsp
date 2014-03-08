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
    
    <title>角色_菜单</title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
	
    <script src="<%=JQ %>/jquery-1.7.js" type="text/javascript"></script>
    <script src="<%=JS %>/common.js" type="text/javascript"></script>
          
    <script src="<%=JS%>/navigation.button.js" type="text/javascript"></script>
        
    <link href="<%=CSS%>/shared.css" rel="stylesheet" type="text/css" />
    <link href="<%=CSS%>/linksButton.css" rel="stylesheet" type="text/css" />
       
    <script type="text/javascript" src="<%=JS%>/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="<%=JS%>/jquery.ztree.excheck-3.5.js"></script>
    <link rel="stylesheet" href="<%=CSS%>/zTreeStyle.css" type="text/css">
    
</head>

<style>
	body{height:100%}
	.role_table{ font-size:12px;}
   	.role{ width:200px; font-size:12px;list-style:none; cursor:pointer; margin-left:-30px;}
	.role li{  background-image:url(<%=request.getContextPath()%>/resources/backstage/image/texing_li.png); padding-left:25px; 
		background-repeat:no-repeat; background-position:left; padding-top:8px; padding-bottom:8px}
	.role li:hover{ background-color:#BDC323}
	.role .selected{ background-color:#84C323}
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
                       		<span class="icon save">&nbsp;</span><span class="text">保存</span>
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
   
    </table>
    
    <DIV class="scrollbar" id="scrollbar"> 
	   <table width="100%" id="table">
	    	<tr>
	        	<td width="242" align="left">角色列表</td>
	            <td width="924" align="left">菜单列表</td>
	        </tr>
	    	<tr>
	        	<td valign="top" align="left">
	            	<ul class="role" id="role"></ul>
	            </td>
	            <td><ul id="treeDemo" class="ztree"></ul></td>
	        </tr>
	    </table>
     </DIV>
    
</body>
<script type="text/javascript">
	
	var _ztree;
	var _znodes;
	$(function(){
		window.onresize = function(event){$("#scrollbar").css("height",$(window).height()-50);}
		$("#scrollbar").css("height",$(window).height()-50);
	
		queryRoles();
		queryMenuList();
		
		$(".linksButton").navigationbutton("#FF002B", "#339E35",{callback: clickButtonCallback});
	});
	
	function updateSelected(selectedJson){
		//"id":1,"pId":"0","name":"产品管理"
		$.each(selectedJson,function(idx,item){
			var node = _ztree.getNodeByParam("id",item.menu_id);
			_ztree.checkNode(node, true);
			_ztree.expandNode(node, true, true, true,true);
		});
	}
	
	function queryRolemenuIdList(roleid){
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/rolemenu/rolemenuIdList",
			dataType:"json",
			data:"id="+roleid,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					showZTree(_znodes);
					updateSelected(msg.object);
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
		
	function queryMenuList(){
	
		showLoading("正在加载配置，请稍后！");
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/rolemenu/menuList",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				hideLoading();
				if((msg.success+"") == "true"){
					showZTree(msg.object);
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
	
	function showZTree(object){
		_znodes = object;
		$("#treeDemo").empty();
		_ztree = $.fn.zTree.init($("#treeDemo"), {check: {enable: true},data: {simpleData: {enable: true}}}, object);	
	}
	
	function queryRoles()
	{
		showLoading("正在加载配置，请稍后！");
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/role/listBy?type=0",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				hideLoading();
				if((msg.success+"") == "true")
				{
					var _html = "";
					$.each(msg.object,function(idx,item){_html += '<li id="'+item.id+'">'+item.rolename+'</li>';});
					
					$("#role").html(_html);
					
					$(".role li").click(function(){
						$(".role li").each(function(){$(this).removeClass("selected");})
						$(this).addClass("selected");
						
						queryRolemenuIdList($(this).attr("id"));
					})
				}else
				{
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
	
	function save(role_id, menu_ids)
	{
		if(role_id == null || role_id == ""){
			alert("请选择角色!");
			return;
		}
		
		showLoading("正在保存数据，请稍后！");
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/rolemenu/save",
			dataType:"json",
			data:"role_id="+role_id+"&menu_ids="+menu_ids,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				hideLoading();
				window.parent.alert(msg.message);
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
	

	function clickButtonCallback(text){
		if(text == "保存"){
			var ids = ""; 
			var checkednodes = _ztree.getCheckedNodes();
			for(var i=0; i<checkednodes.length; i++){
				ids += checkednodes[i].id + ",";
			}
			save($(".role .selected").attr("id"),ids.substring(0,ids.length-1));
			return;
		}
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
	
</script>

</html>
