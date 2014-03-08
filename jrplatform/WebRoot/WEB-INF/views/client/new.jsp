<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache"%>

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
  	
  	<title>金嵘厨房 新闻资讯</title>
  	
    <script src="<%=JS %>/index.js" type="text/javascript"></script>
    
    <link href="<%=CSS %>/information.css" rel="stylesheet" type="text/css" />
    <link href="<%=CSS %>/style.css" rel="stylesheet" type="text/css" />
    
    <script src="<%=JS %>/jquery.pagination.js" type="text/javascript"></script>
    <link href="<%=CSS%>/jquery.pagination.css" rel="stylesheet" type="text/css" /> 
    
</head>


<body>
	<center>
        
        <!-- 头部 -->
		<c:import url="/client/menu/news"/>
		<!-- 头部 --> 
        
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
        	<tr>
            	<td align="center">
                        <div style="width:100%; float:left;">
                        <div class="container newscontent" align="left">
                        	<c:forEach var="nl" items="${newsList.object}" > 
                        		<div class="row" style="border-bottom:1px dotted #FF4400; padding-bottom:25px;">
	                                <div class="img">
	                                	<c:choose>
											<c:when test="${nl.image_url != ''}">
												<img style="width:300px; height:200px;" src="<c:out value="${nl.image_url}"/>" />
											</c:when>
											<c:otherwise>
												<img style="width:300px; height:200px;" src="<%=IMAGE %>/notImage.png"/>
											</c:otherwise>
										</c:choose>
	                                </div>
	                                <div class="text">
	                                    <p class="n_title"><a href="<%=CLIENT %>/newsinfo?id=${nl.id}" target="_blank"><c:out value="${nl.title}"/></a></p>
	                                    
	                                   	<nobr>
	                                   		<div class="i_ellipsis" style="height:110px; margin-left:-22px;vertical-align:top">
	                                   			<pre><div class="new-content format" 
	                                   					  style="margin-top:-20px;vertical-align:top; font-size:12px;" 
	                                   					  align="left">${nl.content}</div></pre>
	                                   		</div>
	                                   	</nobr>
	                                   	
	                                    <span class="time"><c:out value="${nl.publish_time}"/></span>
	                                </div>
	                            </div>
                        	</c:forEach>
                        	
                        	<div class="page" style="font-size:16px; margin-right:-15px; font-family:'宋体'"><div class="pagination"></div></div>
                        	
                        </div>
                    </div>
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
		
		var _thisPage = Number("${newsList.thisPage}")-1;
		var _pageSize = Number("${newsList.pageSize}");
		var _totalSize = Number("${newsList.totalSize}");
		var opt = {callback: pageselectCallback};
				opt.current_page        = _thisPage;
				opt.items_per_page      = _pageSize;
		$(".pagination").pagination(_totalSize, opt);
	})
	
	function pageselectCallback(page_index, msg){
		if(msg != undefined){
			alert(msg);
		}else{
			window.location = "<%=CLIENT%>/newsList?start="+(page_index+1)+"&pageSize=20";
		}
		
		return false;
	}
</script>
 