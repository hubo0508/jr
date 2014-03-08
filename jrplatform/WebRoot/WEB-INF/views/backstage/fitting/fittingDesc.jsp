<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
	
    <script src="<%=request.getContextPath()%>/resources/backstage/js/jquery-1.7.js" type="text/javascript"></script> 
    <!--<script src="<%=request.getContextPath()%>/resources/backstage/ckeditor.js" type="text/javascript"></script>-->
    <link href="<%=request.getContextPath()%>/resources/backstage/css/shared.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/resources/backstage/js/navigation.button.js" type="text/javascript"></script>
    <link href="<%=request.getContextPath()%>/resources/backstage/css/linksButton.css" rel="stylesheet" type="text/css" />

	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/resources/ueditor1_3_5/lang/zh-cn/zh-cn.js"></script>
	
</head>

<style>
	body{height:100%}
	span.cke_wrapper cke_ltr,table.cke_editor, td.cke_contents, span.cke_skin_kama, span.cke_wrapper, span.cke_browser_webkit{
    	height: 100%!important;
	}
</style>

<body sroll="no">

    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="title_t" height="100%">
    	<tr>
        	<td colspan="2">
            	<div class="labelDiv">    	
                    <div class="labelTitle">配件中心简介</div>
                    <div class="g_gray_line workTitleLine"></div>
                    
                    <div class="linksButton">
                       <div class="btn"><span class="hline"></span><div class="c">
                       		<span class="icon check">&nbsp;</span><span class="text">保存</span>
                       </div></div> 
                       <div class="btn"><span class="hline"></span><div class="c">
                       	<span class="icon refresh">&nbsp;</span><span class="text">刷新/查询</span>
                    	</div></div> 
                    </div> 
                </div>
            </td>
        </tr>
        <tr>
        	<td valign="top">
            	<!-- <textarea class="ckeditor" name="description">${p.description }</textarea> -->
            	<script id="editor" type="text/plain" style="width:100%;height:100%;">${p.description }</script>
            </td>
            <td widht="20"></td>
        </tr>
    </table>
   
</body>
<script type="text/javascript">
	
	UE.getEditor('editor');
	
	$(function(){				   
		$(".linksButton").navigationbutton("#FF002B", "#339E35",{callback: clickButtonCallback});
		
		var $edit = $("#editor");var $win  = $(window);
		$edit.css("width",$win.width()-20);
		$edit.css("height",$win.height()-200);
	});
	
	
	function clickButtonCallback(text){
		if(text == "刷新/查询")
		{
			window.parent.loading("${pageContext.servletContext.contextPath}/fittingPage/fittingPageDescJump");
			return;
		}
		
		if((text+"") == "保存")
		{
			saveHandler();
			return;
		}
	}

	function saveHandler(){
		
		var _description = encodeURIComponent(UE.getEditor('editor').getContent());
		if(_description.length > 65535){alert("描述长度应小于65535字符！");return false;}
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/fittingPage/save",
			dataType:"json",
			data:"id=${p.id}&description="+_description,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					$("#loading").css("display","block").css("background-color","#090").html("保存成功！");
					window.parent.loading("${pageContext.servletContext.contextPath}/fittingPage/fittingPageDescJump");
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
	
</script>

</html>
