<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	
	String JS = path + "/resources/client/js";
	String IMAGE = path + "/resources/client/image";
	String IMG = path + "/resources/client/img";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=8" />

	<script src="<%=JS %>/jquery-1.7.js" type="text/javascript"></script>
    <script src="<%=JS %>/jquery.foucs.js" type="text/javascript"></script>

</head>

<style type="text/css">
	*{margin:0;padding:0;list-style-type:none;}
	a,img{border:0;}
	
	/* focusbox */
	.focusbox{position:relative;overflow:hidden;zoom:1;}
	#fullbanner{width:920px;height:330px;margin:auto;position:relative;}
	#fullbanner li a{display:block;width:913px;height:324px;overflow:hidden;}
	#fullbanner img{width:913px;height:324px;}
	#fullbanner ul{width:920px;height:330px;}
	#fullbanner .wrappic{overflow:visible;position:absolute;}
	#fullbanner .next, #fullbanner .prev{filter:alpha(Opacity=70);opacity:.7;position:absolute;top:50%;margin-top:-25px;margin-left:5px;background-color:#303030;z-index:3;}
	#fullbanner .next:hover, #fullbanner .prev:hover{background-color:orangered;}
	#fullbanner .next{margin:-25px 5px 0 0;right:0;}
	#fullbanner .mask-left, #fullbanner .mask-right, #fullbanner .plan{background:#fff;padding:5px;z-index:1;position:absolute;top:0;left:0;width:913px;height:324px;overflow:hidden;left:1920px;}
	#fullbanner .mask-right, #fullbanner .mask-left{z-index:4;left:-920px;filter:alpha(Opacity=50);opacity:.5;background:#fff;overflow:hidden;}
	#fullbanner .mask-right{left:920px;}
	
	.arrow-left,.arrow-right{background:url(<%=IMG%>/icon-sd26986d847.png) no-repeat;}
	.arrow-left{background-position:15px 12px;height:50px;width:50px;}
	.arrow-left:hover{background-position:-45px 12px;}
	.arrow-right{background-position:-103px 12px;height:50px;width:50px;}
	.arrow-right:hover{background;-position:-163px 12px;}
</style>

<body>

<div class="focusbox">
	<div id="fullbanner">
		<div class="wrappic">
			<ul>
				<li class="plan"><a href="<%=path%>/client/product" target="_blank"><img width="920" height="330" src="<%=IMAGE %>/b_1.jpg" /></a></li>
				<li class="plan"><a href="<%=path%>/client/fitting" target="_blank"><img width="920" height="330" src="<%=IMAGE %>/b_2.jpg" /></a></li>
				<li class="plan"><a href="javascript:void(0)"><img width="920" height="330" src="<%=IMAGE %>/b_3.jpg" /></a></li>
                <li class="plan"><a href="<%=path%>/client/service" target="_blank"><img width="920" height="330" src="<%=IMAGE %>/b_4.jpg" /></a></li>
                <li class="plan"><a href="javascript:void(0)"><img width="920" height="330" src="<%=IMAGE %>/b_5.jpg" /></a></li>
                <li class="plan"><a href="<%=path%>/client/learn" target="_blank"><img width="920" height="330" src="<%=IMAGE %>/b_6.jpg" /></a></li>
                <li class="plan"><a href="<%=path%>/client/lease" target="_blank"><img width="920" height="330" src="<%=IMAGE %>/b_7.jpg" /></a></li>
			</ul>
		</div>
		
		<div class="helper">
			<div class="mask-left"></div>
			<div class="mask-right"></div>
			<a href="javascript:void();" class="prev arrow-left"></a>
			<a href="javascript:void();" class="next arrow-right"></a>
		</div>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function(){
	$.foucs({
		direction: 'right'
	});
});
</script>

</body></html>