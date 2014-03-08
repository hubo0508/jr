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

	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/flexPaper2/flexpaper_flash.js"></script>
	
</head>
<body>
<!-- 
	http://58.215.47.98/resource/uploadfile/48c4589c898d99693ea015c85492efdd.swf
	http://localhost:8980/jrdir/a.swf
	http://58.215.47.98/resource/uploadfile/a.swf
	 -->
 <a id="viewerPlaceHolder" style="width:720px;height:480px;display:block"></a>
 <script type="text/javascript">
     var fp = new FlexPaperViewer(   
         '<%=request.getContextPath()%>/resources/flexPaper2/FlexPaperViewer',
         'viewerPlaceHolder', { config : {
         SwfFile : 'http://58.215.47.98/resource/uploadfile/src/a.swf',
         Scale : 1.0,
         ZoomTransition : 'easeOut',
         ZoomTime : 0.6,
         ZoomInterval : 0.2,
         FitPageOnLoad : true,
         FitWidthOnLoad : true,
         FullScreenAsMaxWindow : true,
         ProgressiveLoading : true,
         PrintPaperAsBitmap:false,
         MinZoomSize : 0.2,
         MaxZoomSize : 5,
         SearchMatchAll : false,
         InitViewMode : 'Portrait',
         ViewModeToolsVisible : false,
         ZoomToolsVisible : true,
         NavToolsVisible : true,
         CursorToolsVisible : false,
         SearchToolsVisible : true,
         localeChain: 'zh_CN'
     }});
</script>

</body>
</html>