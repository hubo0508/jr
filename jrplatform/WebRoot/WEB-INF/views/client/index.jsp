<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache"%>
<%
	String path = request.getContextPath();
	
	String allurl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String filedir = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + "/";
	
	String JS = path + "/resources/client/js";
	String CSS = path + "/resources/client/css";
	String IMG = path + "/resources/client/img";
	String CLIENT = path + "/client";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	
	<%@ include file="/common/common_client.jsp" %>

	<title>金嵘厨房</title>
    
    <script src="<%=JS%>/index.js" type="text/javascript"></script>
    
    <link href="<%=CSS%>/index.css" rel="stylesheet" type="text/css" />
    <link href="<%=CSS%>/style.css" rel="stylesheet" type="text/css" />
    
    <script src="<%=JS%>/marquee.js" type="text/javascript"></script>
        
</head>

<body>
	<center>
		
        <!-- 头部 -->
		<c:import url="/client/menu/index"/>
		<!-- 头部 --> 
        
        <div style="height:330px; width:100%; float:left">
      	  <iframe src="<%=CLIENT%>/index/indexBanner" frameborder="0" width="920" scrolling="no" height="330" id="xx"></iframe>
        </div>
        
      	<table border="0" cellpadding="0" cellspacing="0" class="container">
        
        	<tr>
            	<td style="background-image:url(<%=IMG%>/i_b_1.png); width:920px; height:81px; background-repeat:no-repeat;"></td>
            </tr>
            <tr height="15"><td></td></tr>
            <tr>
            	<td style="background-image:url(<%=IMG%>/i_b_2.png); width:920px; height:81px; background-repeat:no-repeat; position:relative">
                	<div id="marquee" style=" margin-left:135px; margin-top:5px;">
                      <dl>
                        <dt>
						  <a href="#"><img src="<%=IMG%>/pp1.png" /></a>
                          <a href="#"><img src="<%=IMG%>/pp2.png" /></a>
                          <a href="#"><img src="<%=IMG%>/pp3.png" /></a>
                          <a href="#"><img src="<%=IMG%>/pp4.png" /></a>
                          <a href="#"><img src="<%=IMG%>/pp5.png" /></a>
                          <a href="#"><img src="<%=IMG%>/pp6.png" /></a>
                        </dt>
                        <dd></dd>
                      </dl>
                    </div>
                 </td>
            </tr>
            <tr>
            	<td>
                	 <img src="<%=IMG%>/5step.png" style="margin-top:25px;"/>
                </td>
            </tr>
            <tr height="30"><td></td></tr>
            <tr>
            	<td>
                	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="index_b_table">
                    	<tr>
                        	<td width="54%" valign="top">
                                <span class="new_title"><img src="<%=IMG%>/index_new_title.png" /></span>
                                <div style="border-bottom:1px dotted #999; margin-top:5px; margin-bottom:10px;"></div>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="n_item" style="font-size:12px">
                                	<c:forEach var="nl" items="${newsList.object}" > 
	                                    <tr>
	                                        <td><div class="i_ellipsis"><nobr>
	                                            <a href="<%=CLIENT %>/newsinfo?id=${nl.id}" target="_blank" class="_t"><c:out value="${nl.title}"/></a></nobr></div></td>
	                                        <td><c:out value="${nl.publish_time}"/></td>
	                                    </tr>
                                    </c:forEach>
                                </table>
                            	<img src="<%=IMG%>/more_font.png" onclick="window.location='<%=CLIENT %>/news'" style="float:right; margin-top:8px; cursor:pointer"/>
                            </td>
                            <td width="6%">&nbsp;</td>
                            <td width="40%" valign="top">
                                <span class="new_title"><img src="<%=IMG%>/read.png" /></span>
                                <div style="border-bottom:1px dotted #999; margin-top:5px; margin-bottom:10px;"></div>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="n_item" style="font-size:12px">
                                	<c:forEach var="mc" items="${listDocumentByMC.object}" > 
	                                    <tr>
	                                        <td><div class="i_ellipsis" style="width:280px;"><nobr>
	                                            <a style="font-family:'宋体'" href="javascript:void(0);" onclick="viewfile(this,'${mc.file_url}','${mc.dtsid}')" class="_t"><c:out value="${mc.file_name}"/></a></nobr></div></td>
	                                        <td><c:out value="${mc.save_date}"/></td>
	                                    </tr>
                                    </c:forEach>
                                </table>
                                <img src="<%=IMG%>/more_font.png" onclick="window.location='<%=CLIENT %>/learn'" style="float:right; margin-top:8px; cursor:pointer"/>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr height="30"><td></td></tr>
             <tr>
            	<td style="background-image:url(<%=IMG%>/i_b_3.png); width:920px; height:100px; background-repeat:no-repeat; position:relative">
                	<div id="marqueeCur" style=" margin-left:135px; margin-top:5px;">
                      <dl>
                        <dt>
                          <c:forEach var="cl" items="${customerList}" > 
                          	 <a style="font-family:'宋体'" href="javascript:void(0)"><img style="width:150px;height:100px;" src="<c:out value="${cl.image_url}"/>" curname="<c:out value="${cl.customer_name}"/>"/></a>
                          </c:forEach>
                        </dt>
                        <dd></dd>
                      </dl>
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
		$.tootip({IMG:"<%=allurl%><%=IMG%>"});
		$.onlineCustomers({url:"<%=request.getContextPath()%>"});
		
		Marquee("marquee");
		Marquee("marqueeCur");
	})
	
	function viewfile(links,url,dtsid){
		var docpre = "${cust_user_pre.docPre}";
		if("${cust_user.username}" == ""){
			alert("未登录，会员请现登录！");
		}else{
			if("${cust_user.user_type}" == "0"){
				openwin("<%=allurl%>${pageContext.servletContext.contextPath}/client/view/pdf?dtsid="+dtsid+"&file="+url);
			}else{
				var mark = false;
				var docpreArr = docpre.split(",");
				for(var i=0; i<docpreArr.length; i++){
					if(dtsid == docpreArr[i]){ mark = true; break; }
				}
				
				if(mark == true){
					openwin("<%=allurl%>${pageContext.servletContext.contextPath}/client/view/pdf?dtsid="+dtsid+"&file="+url);
				}else{
					alert("您的会员权限级别无法在线预览当前文件内容！");
				}
			}
			
		}
	}
	
	function openwin(owurl){
		var iWidth  = screen.width-300;
		var iHeight = screen.height;
		var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
		var iLeft = (window.screen.availWidth-iWidth)/2 + 20; //获得窗口的水平位置;
		window.open(owurl,'','height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
	}
	
</script>
 