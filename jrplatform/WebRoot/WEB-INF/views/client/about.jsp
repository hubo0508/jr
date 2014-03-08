<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	String path = request.getContextPath();
	
	String filedir = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + "/";

	String allurl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();

	String JS = path + "/resources/client/js";
	String CSS = path + "/resources/client/css";
	String IMG = path + "/resources/client/img";
	String CLIENT = path + "/client";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<title>金嵘厨房_关于金嵘</title>
	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    
    <script src="<%=JS %>/jquery-1.7.js" type="text/javascript"></script>
    <script src="<%=JS %>/index.js" type="text/javascript"></script>
    <script src="<%=JS %>/mulu.js" type="text/javascript"></script>
    
    <link href="<%=CSS %>/about.css" rel="stylesheet" type="text/css" />
    <link href="<%=CSS %>/style.css" rel="stylesheet" type="text/css" />
    
</head>

<style>
	html,body{font-size:12px; }
</style>

<body>
	<center>
	
        <!-- 头部 -->
		<c:import url="/client/menu/about"/>
		<!-- 头部 --> 
        
        <table class="container about_table" cellpadding="0" cellspacing="0" border="0">
        	<tr><td colspan="2"><img class="guanyu" src="<%=IMG %>/guanyu.png" /></td></tr>
            <tr>
            	  <td width="280" rowspan="5" valign="top" align="left">
                    <ul class="mulu">
                    	<li class="selected" style="padding-top:14px; padding-bottom:14px;">关于金嵘</li>
                    	<li style="padding-top:14px; padding-bottom:14px;">发展历程</li>
                        <li style="padding-top:14px; padding-bottom:14px;">金嵘团队</li>
                        <li style="padding-top:14px; padding-bottom:14px;">公司规模</li>
                        <li style="padding-top:14px; padding-bottom:14px;">联系金嵘</li>
                    </ul>
                 	
                 </td>
            	<td width="640" align="left" valign="top">
                  <div class="_title guanyujinrong">关于金嵘</div>
                  <div class="_line"></div>
                  <p class="s">${queryAboutDesc.company_description }</p>					
                </td>
            </tr>
            <tr>
            	<td width="640" align="left" valign="top">
                  <br />
                  <div class="_title">发展历程</div>
                  <div class="_line"></div>
                    <c:forEach var="gp" items="${queryGrowingProcess}" > 
	                  	<div class="licheng">
	                    	<div class="vCont" align="center"><img src="<%=IMG %>/cr.png" /><div class="vLine"></div></div>
	                        <div class="vText s" style="font-size:13px; line-height:22px;">
	                        	<div class="time"><c:out value="${gp.year_date}"/>年<c:out value="${gp.month_date}"/>月：</div>
	                            <div class="info"><c:out value="${gp.stage_desc}"/></div>
	                        </div>
	                    </div>
                    </c:forEach>
                </td>
            </tr>
            <tr>
            	<td width="640" align="left" valign="top">
                  <br /><br />
                  <div class="_title">金嵘团队</div>
                  <div class="_line"></div>
                  <table width="100%" border="0" cellpadding="0" cellspacing="0">
                  	<tr height="15"><td></td></tr>
                  	<c:forEach var="ct" items="${queryCompanyTeam}" > 
	                  	<tr>
	                    	<td class="team">
	                            <div class="img"><img src="<c:out value="${ct.url}"/>" /></div>
	                            <div class="des">
	                                <p class="name"><c:out value="${ct.name}"/></p>
	                                <p class="s"><c:out value="${ct.job_desc}"/></p>
	                                <p class="person_des s">
	                                    <c:out value="${ct.job_info}"/>
	                                </p>
	                            </div>  
	                        </td>
	                    </tr>
	                    <tr height="80"><td><div class="line"></div></td></tr>
                    </c:forEach>
                  </table>
                </td>
            </tr>
            <tr>
            	<td width="640" align="left" valign="top">
                  <br /><br />
                  <div class="_title">公司规模</div>
                  <div class="_line"></div>
                  	<c:forEach var="c" items="${queryCompany}" > 
                  		<p class="cgm s" style="font-size:14px;"><c:out value="${c.cname}"/></p>
	                    <img style="width:640px; height:436px;" src="<c:out value="${c.cimage_url}"/>" />
	                    <br /><br />
                  	</c:forEach>
                </td>
            </tr>
            
             <tr>
            	<td width="640" align="left" valign="top">
                  <br /><br />
                  <div class="_title">联系金嵘</div>
                  <div class="_line"></div>
                  
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="contact_table">
                  	<c:forEach var="c" items="${queryCompany}" > 
	                  	<tr>
	                    	<td>
	                        	<div class="contact">
	                                <div class="br s">
	                                    <p class="cname"><c:out value="${c.cname}"/></p>
	                                    <p class="black">电话：<c:out value="${c.cphone}"/></p>
	                                    <p class="black">传真：<c:out value="${c.cfax}"/></p>
	                                    <p class="black">地址：<c:out value="${c.caddress}"/></p>
	                                    <p>
	                                    	<span class="black">销售服务QQ：</span>
	                                    	<c:if test="${c.sales_qq != 0}">
	                                    		<c:out value="${c.sales_qq}"/>
	                                    	</c:if>
	                                    </p>
	                                    <p>
	                                    	<span class="black">客户服务QQ：</span>
	                                    	<c:if test="${c.customer_qq != 0}">
	                                    		<c:out value="${c.customer_qq}"/>
	                                    	</c:if>
	                                    </p>
	                                    <p>
	                                    	<span class="black">租赁服务QQ：</span>
	                                    	<c:if test="${c.leasing_qq != 0}">
	                                    		<c:out value="${c.leasing_qq}"/>
	                                    	</c:if>
	                                    </p>
	                                    <p>
	                                    	<span class="black">投诉服务QQ：</span>
	                                    	<c:if test="${c.complaints_qq != 0}">
	                                    		<c:out value="${c.complaints_qq}"/>
	                                    	</c:if>
	                                    </p>
	                                </div>
	                                <div class="address" align="right">
	                                	<img style="width:308px; height:213px;" src="<c:out value="${c.caddress_image_url}"/>" />
	                                </div>         
	                            </div>   
	                        </td>
	                    </tr>
                    </c:forEach>
                  </table>
                </td>
            </tr>
        </table>
    </center>
   
    <iframe src="<%=CLIENT %>/bottomNavigation" frameborder="0" scrolling="no" class="boiframe"></iframe>

</body>
</html>
<script>
	$(document).ready(function(){	
		
		$.searchList();
		$.searchTxt();
		$.menu();
		$.tootip({IMG:"<%=allurl%><%=IMG%>",about:"<%=request.getContextPath()%>/client/about"});
		$.onlineCustomers({url:"<%=request.getContextPath()%>"});
		
		$.cloneNavigation();
		$.clickNavigation();	
		
	})	
</script>
 