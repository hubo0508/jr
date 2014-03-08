<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	
	String allurl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String filedir = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + "/";
	
	String JS = path + "/resources/client/js";
	String CSS = path + "/resources/client/css";
	String IMG = path + "/resources/client/img";
	String IMAGE = path + "/resources/client/image";
	String CLIENT = path + "/client";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
		
	<%@ include file="/common/common_client.jsp" %>
	
	<title>金嵘厨房 服务中心</title>
	
    <script src="<%=JS %>/index.js" type="text/javascript"></script>
    <script src="<%=JS %>/mulu.js" type="text/javascript"></script>
    <link href="<%=CSS %>/repair.css" rel="stylesheet" type="text/css" />
    <link href="<%=CSS %>/style.css" rel="stylesheet" type="text/css" />
    
</head>

<body>
	<center>
        
        <!-- 头部 -->
		<c:import url="/client/menu/service"/>
		<!-- 头部 --> 
        
        <table class="container repair_table" cellpadding="0" cellspacing="0" border="0">
        	<tr height="30"><td></td></tr>
             <tr>
            	  <td width="280" rowspan="10" valign="top" align="left">
                  	<div class="danghang">
                        <ul class="mulu">
                            <li class="selected" style="padding-top:14px; padding-bottom:14px;">服务承诺</li>
                            <li style="padding-top:14px; padding-bottom:14px;">服务方式</li>
                            <li style="padding-top:14px; padding-bottom:14px;">服务范围</li>
                            <li style="padding-top:14px; padding-bottom:14px;">维修设备种类</li>
                            <li style="padding-top:14px; padding-bottom:14px;">维修报告单</li>
                        </ul>
                        
                        <br />
                        
                        <div class="phone" align="left" style="width:170px;" id="phone"></div>
                    </div>
                </td>
            	<td align="left">
                  <div style="background-image:url(<%=IMG %>/banner-service.png); background-repeat:no-repeat; width:638px; height:245px;"></div>
                  <br />
                  <div class="_title">服务承诺</div>
                  <div class="_line" ></div>
                  
                  <pre style="margin-bottom:-20px;"><div class="format ncf" align="left" style="margin-left:0px;">
                  	${queryDescription.object.pledge}
                  </div></pre>
                   
                </td>
            </tr>
            
            <tr>
            	<td align="left">
                  <div class="_title">服务方式</div>
                  <div class="_line" ></div>
                    
                  <pre style="margin-bottom:-20px;"><div class="format"  style="margin-left:0px; margin-top:-30px;"  align="left">
                  	${queryDescription.object.mode}
                  </div></pre>
                  
                </td>
            </tr>
            <tr>
            	<td align="left">
                	<div class="_title">服务范围</div>
                    
                    <div class="_line" ></div>
                    
                    <pre style="margin-bottom:-20px;"><div class="format ncf"  style="margin-left:0px;"  align="left">
                  	${queryDescription.object.ranges}
                    </div></pre>
                </td>
            </tr>
        	<tr>
            	<td width="640" align="left">
                	<div class="_title">维修设备种类</div>
                    <div class="_line" ></div>

                    <div class="type_info">
                        <div class="num">01</div>
                        <div class="text">
                            <p class="c_t"><c:out value="${queryMaintenanceCategory.object[0].title}"/></p>
                            <ul style="width:525px;">
                                <li><pre class="format s">${queryMaintenanceCategory.object[0].content}</pre></li>
                            </ul>
                        </div>
                    </div>
            	</td>
            </tr>
            <c:forEach var="mc" items="${queryMaintenanceCategory.object}" varStatus="status"> 
            	 <c:if test="${(status.index+1) >= 2}">
            	 	 <tr>
		            	<td align="left">                    
		                    <div class="line" style="margin-top:25px; margin-bottom:25px;"></div>
		                    
		                    <div class="type_info">
		                        <div class="num">0${status.index+1 }</div>
		                        <div class="text">
		                            <p class="c_t"><c:out value="${mc.title}"/></p>
		                            <ul style="width:525px;">
		                                 <li><pre class="format s">${mc.content}</pre></li>
		                            </ul>
		                        </div>
		                    </div>
		            	</td>
		            </tr>
            	 </c:if>
            </c:forEach>
            <tr>
            	<td width="640" align="left">
                	<br />
                	<div class="_title">维修报告单</div>
                    
                    <div class="_line" ></div>
                    
                    <table width="100%" height="100%" border="0" class="table baogao s">
                    	<c:forEach var="mrc" items="${queryMaintenanceReportCard.object}" varStatus="status"> 
	                    	<tr>
	                        	<td width="5%" align="center" class="bgtitle b"><div align="center">0${status.index+1 }</div></td>
	                            <td width="82%" class="b"><a href="javascript:void(0)" onclick="viewfile(&quot;${mrc.file_url}&quot;)">${mrc.file_name}</a></td>
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
		$.tootip({IMG:"<%=allurl%><%=IMG%>",type:true,about:"<%=request.getContextPath()%>/client/about"});
		$.onlineCustomers({url:"<%=request.getContextPath()%>"});
		$.cloneNavigation({clone:".danghang",clone_right:0,top_range:260,pagetype:"repair"});
		$.clickNavigation({pagetype:"repair"});
		$.onlineService({url:"<%=request.getContextPath()%>",target:"#phone",img:'<%=allurl%><%=IMG%>/phone.png'});	
	});	
	
	function viewfile(url){
		openwin("<%=allurl%>${pageContext.servletContext.contextPath}/view?file="+url);
	}
	
	function openwin(owurl){
		var iWidth  = screen.width-300;
		var iHeight = screen.height;
		var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
		var iLeft = (window.screen.availWidth-iWidth)/2 + 20; //获得窗口的水平位置;
		window.open(owurl,'','height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
	}
</script>