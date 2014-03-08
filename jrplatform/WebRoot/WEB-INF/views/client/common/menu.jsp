<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<core:set var="basePath" value="${pageContext.request.contextPath}"/>

<div class="container index">
	<span class="log"></span>
	<form action="${basePath}/client/selectProductOrFitting" name="selectProductOrFitting" method="get">
		<div class="search">
			<input name="selectedCondition"  class="txt" type="hidden" value="<core:if test="${selectedCondition!=''&&selectedCondition!=null}">${selectedCondition}</core:if>" /> 
			<input name="start"  class="txt" type="hidden" value="1" />
			<input name="pageSize"  class="txt" type="hidden" value="4" />
			<input class="txt" type="text" name="condition" placeholder="输入您所关心的内容！" value="${condition}"/><span class="s_btn" title="搜索" onclick="javascript:document.selectProductOrFitting.submit();"></span>
		</div>
	</form>
	
	<div class="login">
		<c:choose>
			<c:when test="${cust_user.username != null }">
				${cust_user.username },您好！欢迎来到金嵘厨房学习中心！
				<a href="${basePath}/client/usersOff">[退出]</a>&nbsp;
				<a href="${basePath}/client/updatepassword">[修改密码]</a>&nbsp;
				<a href="${basePath}/client/registered">[免费注册]</a>
			</c:when>
			<c:otherwise>
				游客，您好！欢迎来到金嵘厨房学习中心！
				<a href="${basePath}/client/login">[登录]</a>
				&nbsp;
				<a href="${basePath}/client/registered">[免费注册]</a>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="menu">
		<div src="${basePath}/client/index" onclick="javascript:window.location.href='${basePath}/client/index'" <core:if test="${current=='index'}"> class="selected"</core:if>> 首页</div>
		<div src="${basePath}/client/product" onclick="javascript:window.location.href='${basePath}/client/product'" <core:if test="${current=='product'}"> class="selected"</core:if>>产品中心</div>
		<div src="${basePath}/client/fitting" onclick="javascript:window.location.href='${basePath}/client/fitting'" <core:if test="${current=='fitting'}"> class="selected"</core:if>>配件中心</div>
		<div src="${basePath}/client/lease" onclick="javascript:window.location.href='${basePath}/client/lease'"  <core:if test="${current=='lease'}"> class="selected"</core:if>>租凭服务</div>
		<div src="${basePath}/client/service" onclick="javascript:window.location.href='${basePath}/client/service'" <core:if test="${current=='service'}"> class="selected"</core:if>>维修服务</div>
		<div src="${basePath}/client/news" onclick="javascript:window.location.href='${basePath}/client/news'" <core:if test="${current=='news'}"> class="selected"</core:if>>新闻资讯</div>
		<div src="${basePath}/client/learn"  onclick="javascript:window.location.href='${basePath}/client/learn'" <core:if test="${current=='learn'}"> class="selected"</core:if>>学习中心</div>
		<div src="${basePath}/client/about" onclick="javascript:window.location.href='${basePath}/client/about'" <core:if test="${current=='about'}"> class="selected"</core:if> class="rn">关于金嵘</div>
	</div>
</div>
<div class="nav_bg"></div>