<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>角色_文档</title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/jquery-1.7.js"></script>
          
    <script src="<%=request.getContextPath()%>/resources/backstage/js/navigation.button.js" type="text/javascript"></script>
        
    <link href="<%=request.getContextPath()%>/resources/backstage/css/shared.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath()%>/resources/backstage/css/linksButton.css" rel="stylesheet" type="text/css" />
       
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/backstage/js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/backstage/js/jquery.ztree.excheck-3.5.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backstage/css/zTreeStyle.css" type="text/css">
    
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
                    <div class="labelTitle">文档权限管理</div>
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
	   <table width="100%" id="table" border="0">
	    	<tr>
	        	<td width="200" align="left">角色列表</td>
	            <td width="200" align="left">文档类型列表</td>
	            <td width="200" align="left">视频权限</td>
	            <td>&nbsp;</td>
	        </tr>
	    	<tr>
	        	<td valign="top" align="left">
	            	<ul class="role" id="role"></ul>
	            </td>
	            <td valign="top"><ul id="treeDemo" class="ztree"></ul></td>
	            <td valign="top" style="font-size:12px;">
	            	<label><input id="video1" type="radio" name="video" value="1" checked="true"/>无权限播放视频</label>
                	<br/>
                	<label><input id="video0" type="radio" name="video" value="0" />有权限播放视频</label>
	            </td>
	            <td>&nbsp;</td>
	        </tr>
	    </table>
     </DIV>
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:10px; left:285px; display:none; font-size:14px"></div>
    
</body>
<script type="text/javascript">
	
	var _ztree;
	var _znodes;
	$(function(){
		window.onresize = function(event){$("#scrollbar").css("height",$(window).height()-50);}
		$("#scrollbar").css("height",$(window).height()-50);
	
		queryRoles();
		queryDocumentTypeList();
		
		$(".linksButton").navigationbutton("#FF002B", "#339E35",{callback: clickButtonCallback});
	});
	
	function updateSelected(selectedJson){
		var video_play = "0";
		$.each(selectedJson,function(idx,item){
			_ztree.checkNode(_ztree.getNodeByParam("id",item.document_type_id), true);
			video_play = item.video_play+"";
		});
		
		if(video_play == "0"){
			$('input:radio[name=video]:nth(1)').attr('checked',true);
		}else{
			$('input:radio[name=video]:nth(0)').attr('checked',true);
		}
	}
	
	function roleDocumentIdList(roleid){
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/roleDocument/roleDocumentIdList?id="+roleid,
			dataType:"json",
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
		
	function queryDocumentTypeList(){
		$("#loading").css("display","block").html("正在加载配置，请稍后！");
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/smallCategory/treeList",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				$("#loading").fadeOut();
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
		$("#loading").css("display","block").html("正在加载配置，请稍后！");
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/role/listBy?type=1",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				$("#loading").fadeOut();
				if((msg.success+"") == "true")
				{
					var _html = "";
					$.each(msg.object,function(idx,item){_html += '<li id="'+item.id+'">'+item.rolename+'</li>';});
					
					$("#role").html(_html);
					
					$(".role li").click(function(){
						$(".role li").each(function(){$(this).removeClass("selected");})
						$(this).addClass("selected");
						
						roleDocumentIdList($(this).attr("id"));
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
	
	function save(role_id, document_type_id)
	{
		if(role_id == null || role_id == ""){
			alert("请选择角色!");
			return;
		}
						 
		var video_play = $('input:radio[name=video]:checked').val();
		
		$("#loading").css("display","block").html("正在保存数据，请稍后！");
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/roleDocument/save",
			dataType:"json",
			data:"role_id="+role_id+"&document_type_id="+document_type_id+"&video_play="+video_play,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				$("#loading").fadeOut();
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
		
		if(text == "刷新")
		{
			queryRoles();
			queryDocumentTypeList();
		
			return;
		}
	}
	
</script>

</html>
