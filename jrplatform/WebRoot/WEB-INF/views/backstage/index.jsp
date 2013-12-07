<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>金嵘厨房后台管理系统</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/jquery-1.7.js"></script>
	
	<link href="<%=request.getContextPath()%>/resources/backstage/css/shared.css" rel="stylesheet" type="text/css" />
    
    <script src="<%=request.getContextPath()%>/resources/backstage/js/jquery.blockUI.js" type="text/javascript"></script>
     
    <script src="<%=request.getContextPath()%>/resources/backstage/js/navigation.menu.js" type="text/javascript"></script>

	<link href="<%=request.getContextPath()%>/resources/backstage/css/linksButton.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath()%>/resources/backstage/css/popup.css" rel="stylesheet" type="text/css" />
	
  </head>

	<style>
		/*一级菜单*/
		.g_menu{height:40px; font-size:14px; background-color:#F3F3F3;}
		.g_menu div{float:left; height:27px; background-color:#F3F3F3; padding-left:10px; padding-right:10px; padding-top:13px; cursor:pointer;
			*+padding-top:14px;/*IE7*/
			*+height:26px; /*IE7*/
		}
		
		/*子菜单*/
		#child_menu{width:100%; height:100%; font-size:13px; border:1px solid #FFFFFF; overflow:hidden}
		#child_menu div{background-color:#FFFFFF; padding-left:40px; padding-top:7px; height:22px; cursor:pointer;}
		#child_menu div span{background-repeat:no-repeat; display:block; width:100%; height:20px;}
		
		#dContent{padding-top:5px; position:relative}
			
	</style>

<!--<body oncontextmenu='return false' onselectstart ='return false' onselect='document.selection.empty()' oncopy='document.selection.empty()' onbeforecopy='return false'> -->
<body sroll="no" style="overflow:hidden"> 
    <table width="100%" cellpadding="0" cellspacing="0" class="g_content">
        <tr>
            <td align="left"><a href="javascript:void(0)"><span class="log_c"></span></a></td>
            <td align="right">
            	<a href="javascript:void(0)" class="a" style="color:#000">欢迎您，${c_user.username}</a> | 
                <a href="javascript:void(0)" onclick="logsOff(this)" class="a">安全退出</a>&nbsp;&nbsp;
           </td>
        </tr>
    </table>
    
	<div class="g_gray_line"></div>
    
    <div class="g_menu"></div>
    	
    <table cellpadding="0" cellspacing="0" width="100%" border="0" id="dContent" >
          <tr>
        	<td width="200" height="100%" valign="top" align="left" style="padding-right:35px; "><div id="child_menu"></div></td>			
            <td valign="top" height="100%">
                <iframe width="100%" height="100%" id="child_iframe" frameborder="0" scrolling="no"></iframe>
                <div id="loading_box" style="top:0px; height:100%; width:86.6%">
                	<span><img src="${pageContext.servletContext.contextPath }/resources/backstage/image/loading/24.gif" style="margin-bottom:-12px;"/>&nbsp;正在加载，请稍后</span>
                </div>
            </td>
        </tr>
    </table>

</body>

</html>

<script type="text/javascript">

	/*
	 * 注销操作
	 */
	function logsOff(o)
	{
		if(window.confirm('您确定要进行注销操作？')){
			o.href = "${pageContext.servletContext.contextPath}/logsOff";
            return true;
        }
	}
	
	$(document).ready(function(){				   
							   
		doResize();	
		
		shrinkHandler();
		
		var opt = {callback: menuSelectedCallback};
		opt.childmenu    = "#child_menu";
		opt.childcontent = "#child_iframe";
		opt.loading      = $("#loading_box");
		opt.menu = [
					{"text":"产品管理","href":"./construction.html","child":
						[
							{"text":"产品中心","href":"${pageContext.servletContext.contextPath}/product/productJump"},
							{"text":"自定义类别","href":"${pageContext.servletContext.contextPath}/productCategory/productCategoryJump"},
							{"text":"/"},
							{"text":"产品主页简介","href":"${pageContext.servletContext.contextPath}/productPage/productDescJump"},
							{"text":"产品滚动管理","href":"${pageContext.servletContext.contextPath}/product/productScrollListJump"},
							{"text":"/"}
						]
					},
					{"text":"配件管理","href":"./construction.html","child":
						[
							{"text":"配件中心","href":"${pageContext.servletContext.contextPath}/fitting/fittingJump"},
							{"text":"自定义类别","href":"${pageContext.servletContext.contextPath}/productCategory/productCategoryJump"},
							{"text":"配件专业类别","href":"${pageContext.servletContext.contextPath}/fittingSpecialtyCate/fittingSpecialtyJump"},
							{"text":"/"}
						]
					},
					{"text":"租赁服务","href":"./construction.html","child":
						[
							{"text":"项目立项","href":"./project_start/establish.html"},
							{"text":"项目组成员表","href":"./project_start/project_team.html"},
							{"text":"/"},
							{"text":"项目策划","href":"./construction.html"}	,
							{"text":"/"}
						]
					},
					{"text":"维修服务","href":"./construction.html","child":
						[
							{"text":"工作分解结构","href":"./construction.html"},
							{"text":"/"},
							{"text":"活动排序","href":"./construction.html"},
							{"text":"资源工期成本估算","href":"./construction.html"},
							{"text":"/"},
							{"text":"进度计划","href":"./construction.html"},
							{"text":"项目计划","href":"./construction.html"},
							{"text":"/"},
							{"text":"风险计划","href":"./construction.html"},
							{"text":"沟通计划","href":"./construction.html"},
							{"text":"/"}
						]
					},
					{"text":"维修服务","href":"./construction.html","child":
						[
							{"text":"系统测试","href":"./construction.html"},
							{"text":"/"}
					    ]
					},
					{"text":"新闻资讯","child":"","href":"./construction.html"},
					{"text":"知识库","href":"./construction.html","child":
						[
							{"text":"评估与验收","href":"./construction.html"},
							{"text":"项目总结","href":"./construction.html"},
							{"text":"文件归档","href":"./construction.html"},
							{"text":"/"} 
						]
					},
					{"text":"学习中心","href":"./construction.html","child":
						[
							{"text":"成员管理","href":"./organization_config/members_management.html","icon":"people-y"},
							{"text":"/"},
							{"text":"角色管理","href":"./construction.html"},
							{"text":"权限管理","href":"./construction.html"},
							{"text":"/"},
							{"text":"审批流程管理","href":"./construction.html"},
							{"text":"/"}
						]
					},
					{"text":"系统管理","href":"./construction.html","child":
						[
							{"text":"修改密码","href":"./person_config/change_password.html"},
							{"text":"/"}
						]
					}
				   ];		

		$(".g_menu").navigationmenu("产品管理", opt);
		
	}); 
	
	function shrinkHandler()
	{		
		var dTable  = $("#dContent");
		var firstTd = dTable.find("tr td");
		var menuDiv = firstTd[0].children;
		
		var _top    = dTable.offset().top + 150;
		var _left   = clearUnit($(dTable.find("tr td")[0]).css("width")) + 10;
		var _style  = 'position:absolute; cursor:pointer; display:none;top:'+_top+'px; left:'+_left+'px" src="resources/backstage/image/skin/shrink.png'
		var _img    = $('<img class="shrinkHandler" style="'+_style+'" title="点击收缩菜单" />')
				   .bind("click",function(event){
										  
						if($(this).attr("src") == "resources/backstage/image/skin/shrink.png")
						{
							$(menuDiv).css("display","none");
							$(firstTd[0]).attr("width",0);		
							_img.attr("src","resources/backstage/image/skin/unfold.png").css("left",10).css("display","block");
							_img.attr("title","点击收缩菜单");
							
							$(firstTd[1]).attr("width",(dTable.width()));							
							
							return;
						}	
						
						if($(this).attr("src") == "resources/backstage/image/skin/unfold.png")
						{
							$(menuDiv).css("display","block");
							$(firstTd[0]).attr("width",200);		
							_img.attr("src","resources/backstage/image/skin/shrink.png").css("left",_left);
							_img.attr("title","点击展开菜单");
							
							$(firstTd[1]).attr("width",(dTable.width()-200));
							
							return;
						}
					});
				   
		$("body").append(_img);	
		
		/////////////////////////////////////////////////////////////////////////////////////////
				   
		var firstTdMouseOutTimer;
		
		_img.mouseover(function(){
			clearTimeout(firstTdMouseOutTimer);						
		})
		
		$(firstTd[0]).hover(
			function(event){				
				if($(".shrinkHandler").attr("src") == "resources/backstage/image/skin/shrink.png"){
					_img.fadeIn();
				}				
			},
			function(event){
				firstTdMouseOutTimer = setTimeout(function(){
					if($(".shrinkHandler").attr("src") == "resources/backstage/image/skin/shrink.png"){
						_img.fadeOut();
					}									   
				},300)				
			}
		);
		
	}
	
	function menuSelectedCallback(opts)
	{
		//alert(opts.text);
	}
	
	/*
	 * 监听浏览器窗口大小改变事件
	 */
	function doResize()
	{
		setDContentHeignth(); 
		$(window).resize(function() {
			setDContentHeignth();  
		})	
	}
	
	/**
	 * 设置高度
	 */
	function setDContentHeignth()
	{
		var incremental = $.browser.msie ? 15 : ($.browser.webkit ? 10 : ($.browser.mozilla ? 10 : 0));
		var nHeight = ($(window).height()-($(".g_menu").height() + $(".g_content").height() + incremental));
		$("#dContent").css("height",nHeight);				
		$("#loading_box").css("height",nHeight);
	}
	
	/**
	 * 弹出窗口
	 *
	 * @param params 弹出窗口参数
	 */
	function popup(params)
	{
		 $.blockUI(params); 
	}
	
	/**
	 * 移出张弹出窗口
	 *
	 * @param id 移出窗口ID
	 */
	function remove(id){
		$.unblockUI({pw_id:id}); 	
	}
	
	/**
	 * 弹出窗口参数传递回调
	 *
	 * @param pw_id 弹出窗口ID
	 * @oValue 值对象
	 */
	function callbackUI(pw_id,oValue){
		$.callbackUI(pw_id,oValue);	
	}
	
	/**
	 * 取得指定对象的width与height
	 */
	function targetWH(fObj){
		return {"h":$(fObj).height(),"w":$(fObj).width()};
	}
	
	function getParentData(pw_id){
		return $(window).data(pw_id+"_parent_data");
	}
	
	function loading(url){
		$("#child_iframe").attr("src",url);
	}
	
	function alert(msg){
		popup({ 
			message: 'popup_alert', 
			pw_confirm_display:false,
			content: msg,
			callback:function(type){
				return true;
			},
			css: {width: '250'} 
		});	
	}
	
	function confirms(msg,callback){
		popup({ 
			message: 'popup_alert', 
			pw_confirm_display:true,
			content: msg,
			callback:callback,
			css: {width: '250'} 
		});	
	}
		
</script>
