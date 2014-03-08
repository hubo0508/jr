<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>
	html,body { margin: 0px; height: auto; width: 100%; font-size: 12px; font-family: "宋体"; font-size: 12px; color: #666}
	
	img { border: 0px }
	.line { height: 1px; background-color: #CCC; margin-top: 8px; margin-bottom: 8px; }
	.container { width: 920px; font-size: 14px; }
	.nav_buttom { text-align: center }
	.nav_buttom a { text-decoration: none; color: #000; font-size: 12px; }
	.nav_buttom a:hover { color: #FF4400 }
	p { font-size: 12px; }
</style>

<div style="background-color:#FF4400; height:8px; width:100%"></div>
<center>
	<br /> <br />
	<div class="container nav_buttom" align="center" style="height:150px;">
		<a href="${pageContext.request.contextPath}/client/index" target="_blank">网站首页</a> | 
		<a href="${pageContext.request.contextPath}/client/about" target="_blank">关于金嵘</a> | 
		<a href="${pageContext.request.contextPath}/client/protocolInfo" target="_blank">法律</a>
		<br />
		<p>地址：${jr.caddress }</p>
		<p>电话：${jr.cphone } 传真：${jr.cfax }
			邮箱：${jr.email }</p>
		<p>版权所有：${jr.cname } 蜀ICP备08106816号</p>
	</div>
</center>
