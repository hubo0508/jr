<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String filedir = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
	
    <script src="<%=request.getContextPath()%>/resources/backstage/js/jquery-1.7.js" type="text/javascript"></script> 
    <script src="<%=request.getContextPath()%>/resources/backstage/js/popwin_scrollbar.js" type="text/javascript"></script> 
    <link href="<%=request.getContextPath()%>/resources/backstage/css/shared.css" rel="stylesheet" type="text/css" />
    
   <style>
   	
	*{font-size:12px; font-family:"宋体"}
	
	.base_title_table{margin-top:15px; margin-left:15px;}
	.base_title_table  tr td{padding:0.7em 0.4em}
	
	.add_edit_table { margin-left:15px; margin-bottom:15px;}
	.add_edit_table tr td{padding:0.5em 0.4em}
	.add_edit_table select{ width:200px;}
	.add_edit_table .txt{width:200px;}
	
	.text_line{ width:150px; text-align:left}
	

   </style>
   
</head>

<body sroll="no">
	
    <div class="scrollbar">
   
	    <table cellpadding="0" cellspacing="0" border="0"  width="800" class="base_title_table">
	    	<tr>
	        	<td width="105" align="right">会员权限：</td>
	            <td width="256" align="left"><select id="rolename" class="txt"></select></td>
	            <td width="168" align="right">账户状态：</td>
	            <td width="271" align="left">
	            	<label><input type="radio" name="status" value="0"/>正常</label>
	            	<label><input type="radio" name="status" value="1"/>冻结</label>
                	<label><input type="radio" name="status" value="2"/>待审核</label>
                </td>
	        </tr>
	    </table>
	    
		<div class="g_light_green_line" style="margin-top:10px; margin-bottom:10px;"></div>
	    
	    <table cellpadding="0" cellspacing="0" border="0" width="800" class="add_edit_table">
	    	<tr>
	        	<td align="right">视频权限：</td>
	            <td width="262" align="left" id="video_play"></td>
	            <td width="171" align="right"></td>
	            <td width="269" align="left">&nbsp;</td>
	        </tr>
	    	<tr>
	        	<td width="98" align="right">用户名：</td>
	            <td align="left">${p.username }</td>
	            <td width="171" align="right">注册时间：</td>
	            <td width="269" align="left">${p.registration_time }</td>
	        </tr>
	        <tr>
	        	<td width="98" align="right">登录次数：</td>
	            <td align="left">${p.login_count }</td>
	            <td width="171" align="right">最后登录时间：</td>
	            <td width="269" align="left">${p.last_login_time }</td>
	        </tr>
	        <tr>
	        	<td align="right">公司名称：</td>
	            <td width="262" align="left">${p.company_name }</td>
	            <td width="171" align="right">公司地址：</td>
	            <td width="269" align="left">${p.company_address }</td>
	        </tr>
	        <tr>
	        	<td align="right">联系人：</td>
	            <td width="262" align="left">${p.contact }</td>
	            <td width="171" align="right">所在部门：</td>
	            <td width="269" align="left">${p.where_department }</td>
	        </tr>
	        <tr>
	        	<td align="right">固定电话：</td>
	            <td width="262" align="left">${p.fixed_telephone }</td>
	            <td width="171" align="right">手机：</td>
	            <td width="269" align="left">${p.phone }</td>
	        </tr>
	        <tr>
	        	<td align="right">联系人邮箱：</td>
	            <td width="262" align="left">${p.contact_email }</td>
	            <td width="171" align="right"></td>
	            <td width="269" align="left">&nbsp;</td>
	        </tr>
	         <tr>
	        	<td align="right">公司性质：</td>
	            <td colspan="3" align="left">${p.company_nature }</td>
            </tr>
	        <tr>
	        	<td align="right">经营领域：</td>
	            <td colspan="3" align="left">${p.business_areas }</td>
            </tr>
	    </table>
	</div>
    
    <div class="pc_win_nav">
        <div class="g_green_line"></div>
        <div class="bottom_navigation">
            <div id="close" onclick="closeHandler()">关闭</div>
            <div id="save" onclick="saveHandler()">保存</div>
        </div>
        <div class="g_green_line"></div>
    </div>
    
    <div id="loading" style="padding:5px; color:#FFF; position:fixed; top:5px; left:5px; display:none;"></div>
    
</body>
<script type="text/javascript">
	$(function(){		

		queryRoles();
		
		PopupWindowScrollbar("menber_edit",".scrollbar");
		
		var _status = "${p.status}"+"";
		if(_status == "0"){
			$('input:radio[name=status]:nth(0)').attr('checked',true);
		}
		if(_status == "1"){
			$('input:radio[name=status]:nth(1)').attr('checked',true);
		}
		if(_status == "2"){
			$('input:radio[name=status]:nth(2)').attr('checked',true);
		}
		
		/*
		var _video_play = "${p.video_play}"+"";
		if(_video_play == "0"){
			$('input:radio[name=video_play]:nth(1)').attr('checked',true);
		}else{
			$('input:radio[name=video_play]:nth(0)').attr('checked',true);
		}*/
	})
	
	function queryRoles()
	{
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/role/listBy?type=1",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true")
				{
					var _html = "";
					var _rolename = "${p.rolename}"
					$.each(msg.object,function(idx,item){
						if(_rolename == item.rolename){
							_html += '<option value="'+item.id+'" selected="true">'+item.rolename+'</option>'
							
							if((item.video_play+"") == "0"){
								$("#video_play").html("有权限播放视频");
							}else{
								$("#video_play").html("无权限播放视频");
							}
							
						}else{
							_html += '<option value="'+item.id+'">'+item.rolename+'</option>'
						}
					;});
					$("#rolename").html('<option vluae="-1">--请选择--</option>'+_html);
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

	function hideLoading(){
		$("#loading").fadeOut();
	}

	function saveHandler(){
		
		//var _video_play = $('input:radio[name=video_play]:checked').val();
		var _status = $('input:radio[name=status]:checked').val();
		var _rolename = $("#rolename").val();
		if(_rolename == null || _rolename == "-1" || _rolename.length < 0){alert("请设置会员权限级别！");return false;}
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/member/save",
			dataType:"json",
			data:"role_id=${p.role_id}&rolenameid="+_rolename+"&uid=${p.uid}&status="+_status,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("保存成功！");
					closeHandler();
					window.parent.loading("${pageContext.servletContext.contextPath}/member/memberJump");
				}else{
					$("#loading").css("display","block").css("background-color","#F30").html(msg.message);
					setTimeout(function(){
						$("#loading").fadeOut();
					},5000)
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
	
	function closeHandler(){
		window.parent.remove("menber_edit");
	}
</script>
</html>
