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
    
    <title>内部员工管理</title>
	
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
	
	<script src="<%=JS%>/jquery-ui.min.js" type="text/javascript"></script>
    <script src="<%=JS%>/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
    <script src="<%=JS%>/jquery.ui.datepicker-zh-CN.js" type="text/javascript"></script>  
    <link href="<%=CSS%>/jquery-ui.css" rel="stylesheet" type="text/css" />
</head>

<style>
	body{height:100%}
</style>

<body sroll="no">

    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="title_t">
    	<tr>
        	<td>
            	<div class="labelDiv">    	
                    <div class="labelTitle">员工管理</div>
                    <div class="g_gray_line workTitleLine"></div>
                    
                    <div class="linksButton">
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
                    			<td align="right">状态：</td>
                                <td align="left">
									<select class="txt" id="status">
                                		<option value="-1">--全部--</option>
                                		<option value="0">正常</option>
                                		<option value="1">冻结</option>
                                	</select>
								</td>
                    			<td align="right">员工权限：</td>
                                <td align="left"><select class="txt" id="rolename"></select></td>
                    			<td align="right"></td>
                                <td align="left">
                                </td>
                    		</tr>
                    		<tr>
                    			<td align="right">注册时间：</td>
                                <td colspan="5" align="left">
                                	<input id="sTime" type="text" class="txt"/>至<input id="eTime" type="text" class="txt"/>
                                </td>
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
		            <th width="100" class="c">状态</th>
		            <th width="100" class="c">用户名</th>
		            <th width="200" class="c">员工权限</th>
		            <th width="80" class="c">登录次数</th>
		            <th width="150" class="c">最后登录时间</th>
		            <th width="200" class="c">注册时间</th>
		            <th width="200" class="c">员工姓名</th>
		            <th width="200" class="c">员工电话</th>
		            <th width="200" class="c">员工职位</th>
		            <th width="200" class="c">所属公司</th>
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
		
		queryRoles();
			
		$(".linksButton").navigationbutton("#FF002B", "#339E35",{callback: clickButtonCallback});
		$(".search").search({callback: function(){$.tableAutoScroll();$.changeTableHead();}});
		
		$('#sTime').datepicker({dateFormat: "yy-mm-dd",showHour: false,showMinute:false,showTime:false});
		$('#eTime').datepicker({dateFormat: "yy-mm-dd",showHour: false,showMinute:false,showTime:false});
	});
	
			
	var loading;
	function getList(pageSize,start)
	{
		loading = null;
		if(loading == undefined){loading=new ol.loading({id:"scrollbar"})}
		loading.show();
		
		var _status = $("#status").val();
		var _rolename = $("#rolename").val();
		var _sTime = $("#sTime").attr("value");
		var _eTime = $("#eTime").attr("value");
		
		$.ajax( {
			type : "post",
			url : "${pageContext.servletContext.contextPath}/employee/list",
			dataType:"json",
			data:"pageSize="+pageSize+"&start="+start+"&status="+_status+"&rolenameid="+_rolename+"&sTime="+_sTime+"&eTime="+_eTime,
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
			
			var _id                 = item.eid + "_"+item.uid;
			var _rolename  = item.rolename || "未定义";
			
			var _status = "";
			var _s_color = "";
			if((item.status+"") == "0"){
				_status = "正常";
				_s_color = "#0A8700";
			}
			if((item.status+"") == "1"){
				_status = "冻结";
				_s_color = "#ED0000";
			}
			if((item.status+"") == "2"){
				_status = "待审核";
				_s_color = "#F29A00";
			}
			
			var __id = "'"+_id+"'";
			
			var _login_count = item.login_count || "&nbsp;";
			var _last_login_time = item.last_login_time || "&nbsp;";
			
			_table += 
				'<tr>'+
				'    <td class="c">'+count+'</td>'+
	            '    <td class="c"><input type="checkbox" name="tdcb" value="'+_id+'"/></td>'+
	            '	 <td class="c"><span class="tablebtn" onclick="deletes('+__id+')">删除</span>&nbsp;<span class="tablebtn" onclick="edit('+item.eid+')">编辑</span></td>'+
	       		'    <td class="c" style="color:'+_s_color+'">'+_status+'</td>'+
	            '    <td class="c">'+item.username+'</td>'+
	            '    <td class="c">'+_rolename+'</td>'+
	            '    <td class="c" title="'+_login_count+'">'+_login_count+'</td>'+
	            '    <td class="c" title="'+_last_login_time+'">'+_last_login_time+'</td>'+
	            '    <td class="c">'+(item.registration_time || "&nbsp;")+'</td>'+
	            '    <td class="c">'+(item.ename || "&nbsp;")+'</td>'+
	            '    <td class="c">'+(item.ephone || "&nbsp;")+'</td>'+
	            '    <td class="c">'+(item.ejob || "&nbsp;")+'</td>'+
	            /*'    <td class="c">'+(item.cname || "&nbsp;")+'</td>'+*/
	            '</tr>';
	            
	            count++;
		});
		var _head = '<tr>'+
					'<th width="30">序号</th>'+
		            '<th width="30" height="30" class="c">选择</th>'+
		            '<th width="65" class="c">编辑</th>'+
		            '<th width="70" class="c">状态</th>'+
		            '<th width="100" class="c">系统帐号</th>'+
		            '<th width="150" class="c">员工权限</th>'+
		            '<th width="80" class="c">登录次数</th>'+
		            '<th width="150" class="c">最后登录时间</th>'+
		            '<th width="100" class="c">注册时间</th>'+
		            '<th width="70" class="c">员工姓名</th>'+
		            '<th width="120" class="c">员工电话</th>'+
		            '<th width="150" class="c">员工职位</th>'+
		            /*'<th width="200" class="c">所属公司</th>'+*/
		            '</tr>';
		$("#tbody").html(_head + _table);
		
		$.installTable({checkboxIndex:2});
		$.cloneTableHead();		
		$.tableAutoScroll({fixed_target:[".title_t:height",15]});
	}

	function clickButtonCallback(text){
		if(text == "刷新/查询")
		{
			getList(page_size,_page_index);return;
		}
		
		if(text == "新增"){
			window.parent.popup({ 
				message: 'popup_links', 
				content: "${pageContext.servletContext.contextPath}/employee/addJump",
				title:"新增员工帐号",
				css: {width: '840px',height:'80%'},
				pw_id :"employee_add_edit",
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
			url : "${pageContext.servletContext.contextPath}/employee/delete",
			dataType:"json",
			data:"ids="+ids,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("删除成功！");
					setTimeout(function(){$("#loading").fadeOut();},5000)
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
	
	function edit(eid){
		window.parent.popup({
			message: 'popup_links', 
			content: "${pageContext.servletContext.contextPath}/employee/editJump?id="+eid,
			title:"编辑员工信息",
			css: {width: '840px',height:'80%'},
			pw_id :"employee_add_edit",
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
	
	function queryRoles()
	{
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/role/listBy?type=0",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				$("#loading").fadeOut();
				if((msg.success+"") == "true")
				{
					var _html = "";
					$.each(msg.object,function(idx,item){_html += '<option value="'+item.id+'">'+item.rolename+'</option>';});
					
					$("#rolename").html('<option value="-1">--全部--</option><option value="-2">未定义</option>'+_html);
					
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
</script>

</html>
