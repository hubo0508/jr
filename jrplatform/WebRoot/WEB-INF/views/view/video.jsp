<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String filedir = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />

     <script type="text/javascript" src="<%=request.getContextPath()%>/js/mootools.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/swfobject.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/js/videobox.js"></script>

	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/videobox.css" type="text/css" media="screen" />
	
  </head>
	
	<style>
		a{ background-image:url(<%=request.getContextPath()%>/resources/client/image/videoplay.png); width:300px; height:200px; background-repeat:no-repeat; display:block;}
		html,body{ height:100%; width:100%;}
	</style>
	
	<body onload="onloadfun()">
	
		<div style="display:table; width:100%; height:100%;">
	    	<div style="display:table-cell; vertical-align:middle;  width:100%; height:100%;" align="center">
				<a href="javascript:void(0);" hrefjr="${file}" rel="vidbox" id="vidbox"  title="caption"></a>
	        </div>
	    </div>
	</body>

</html>
<script>
	function onloadfun(){
	
		//var _vidbox = document.getElementById("vidbox");
		//_vidbox.click();
		
		//Videobox.click(document.getElementById("vidbox"));
		//var evt = document.createEvent("HTMLEvents");
		//evt.initEvent("click",false,true);
      	//document.getElementById("vidbox").dispatchEvent(evt);
      	
      	//evt.stop();
      	
      	/*
      	if(document.createEvent){
			var ev = document.createEvent(‘HTMLEvents’);
			ev.initEvent("click", false, true);
			card.dispatchEvent(ev);
		}else{
			 card.click();
		}*/
	}
</script>
