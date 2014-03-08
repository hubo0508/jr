<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	
	String allurl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	
	String JS = path + "/resources/client/js";
	String CSS = path + "/resources/client/css";
	String IMG = path + "/resources/client/img";
	String CLIENT = path + "/client";
%>

<!DOCTYPE HTML>
<html>
<head>
  	<%@ include file="/common/common_client.jsp" %>
  	
  	<title>金嵘厨房 学习中心</title>
  	
    <script src="<%=JS %>/index.js" type="text/javascript"></script>
    <script src="<%=JS %>/mulu.js" type="text/javascript"></script>
    
    <link href="<%=CSS %>/repair.css" rel="stylesheet" type="text/css" />
    <link href="<%=CSS %>/style.css" rel="stylesheet" type="text/css" />
    
    <script src="<%=JS %>/jquery.pagination.js" type="text/javascript"></script>
    <link href="<%=CSS%>/jquery.pagination.css" rel="stylesheet" type="text/css" /> 
    
</head>
<body>
	<center>
		
        <!-- 头部 -->
		<c:import url="/client/menu/learn"/>
		<!-- 头部 --> 
        
        <br />
        <br />
        <div class="container" style="background-image:url(<%=IMG%>/xuxi_b.png); background-repeat:no-repeat; background-position:left; height:81px;"></div>
        <br />
        <table class="container support" cellpadding="0" cellspacing="0" border="0">
   	       <tr height="30"><td></td></tr>
             <tr>
            	<td width="250" rowspan="6" valign="top" align="left">
                  	<div class="danghang">
                        <ul class="mulu _mulu">
                        	<c:forEach var="mc" items="${listAllToIndex}" varStatus="status">
                        		<c:choose>
									<c:when test="${mc.mark == true && mc.notSelected == null}">
										<li class="selected">
											<span class="mu_num">0${status.index+1}</span>
											<span class="mc mc_font" id="${mc.id }">${mc.major_category }</span>
										</li>
									</c:when>
									<c:otherwise>
										 <li>
											<span class="mu_num">0${status.index+1}</span>
											<span class="mc mc_font" id="${mc.id }">${mc.major_category }</span>
						 				</li>
									</c:otherwise>
								</c:choose>
                            </c:forEach>
                        </ul>
                        
                        <br />
                        <div class="phone" align="left" style="width:190px;" id="phone"></div>
                    </div>
                </td>
            	<td align="left">
                	 <div class="_search s" style="position:relative; z-index:0;">
                    	<div class="_title" style="z-index:1; position:absolute; top:-10px;">设置查询条件</div>
                        <div class="round" style="z-index:0">
                          <table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size:12px;">
                            <tr><td width="75%" align="left">
                              	<table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size:12px;">
                                <tr>
                                  <td width="11%" align="right">关键字:</td>
                                  <td width="75%" align="left"><input id="keyword" type="text" class="txt" style="width:100%" value="${keyword}"/></td>
                                  <td width="14%" align="right" ><div class="search_btn" align="right" onclick="doKeyword()"><a>查询</a></div></td>
                                </tr>
                                </table>
                            </td></tr>
                          </table>
                       </div>
                  </div>
                  <br/><br/>
               </td>
            </tr>
          	
          	<c:choose>
          		<c:when test="${listKeyword == null}">
          			<c:forEach var="mc" items="${listAllToIndex}" varStatus="status"> 
		              <c:if test="${mc.mark == true}">
		              <tr>
		   	            <td align="left" valign="top">
		   	            
		   	              <div class="tag">
		                    <span class="t selected" onclick="doMajorCategory(this,'${mc.id }')">${mc.major_category }</span>
		                    <c:forEach var="sc" items="${mc.listSmallCategoryBy}" varStatus="status"> 
		                    	<span class="t" onclick="doSmallCategory(this,'${sc.dtsid }','${sc.dtmid}')">${sc.small_category }</span>
		                    </c:forEach>
		                    <div class="_line"></div><span class="_more2" onclick="window.location='<%=allurl%><%=CLIENT %>/learn/more?start=1&pageSize=30&dtmid=${mc.id }'"></span>
		                  </div>
		                  
		                  <table cellpadding="0" cellspacing="0" width="100%" style="font-size:12px; font-family:'宋体'">
		                  	<c:forEach var="doc" items="${mc.listDocumentByMC.object}" varStatus="status"> 
		                  		<c:if test="${status.index % 2 == 0}">
				                  	<tr>
				                    	<td width="48%">
				                        	<div class="content">
				                               
				                                <div class="num snum">
				                                	<c:if test="${(status.index+1)<10}">0${status.index+1}</c:if>
                                    				<c:if test="${(status.index+1)>=10}">${status.index+1}</c:if>
                                    			</div>
                                    		
				                                <div class="file" style="padding-top:2px;">
				                                	<nobr><div class="i_ellipsis" style="width:253px;">
				                                		<c:choose>
															<c:when test="${doc.file_name != null and doc.file_name != ''}">
																<a href="javascript:void(0);" onclick="viewfile(this,'${doc.file_url}','${doc.dtsid}')" title="${doc.file_name}">${doc.file_name}</a>
															</c:when>
															<c:otherwise>
																<a href="javascript:void(0);" title="${doc.video_name}">${doc.video_name}</a>
															</c:otherwise>
														</c:choose>
				                                	</div></nobr>
				                                	<c:if test="${doc.video_url != null and doc.video_url != ''}">
				                                		<span class="_ds" onclick="viewvido('${doc.video_url}')" title="点击播放视频"></span>
				                                	</c:if>
				                               	</div>
				                            </div>
				                  		</td>
				                        <td width="4%"></td>
				                        <td width="48%">
				                        	<c:if test="${mc.listDocumentByMC.object[status.index+1].file_name != null}">
					                        		<div class="content">
					                                	 <div class="num snum">
					                                	<c:if test="${(status.index+2)<10}">0${status.index+2}</c:if>
	                                    				<c:if test="${(status.index+2)>=10}">${status.index+2}</c:if>
	                                    			</div>
				                                	<div class="file" style="padding-top:2px;">
					                                	<nobr><div class="i_ellipsis" style="width:253px;">
					                                		<c:choose>
																<c:when test="${mc.listDocumentByMC.object[status.index+1].file_name != null and mc.listDocumentByMC.object[status.index+1].file_name != ''}">
					                                				<a href="javascript:void(0);" onclick="viewfile(this,'${mc.listDocumentByMC.object[status.index+1].file_url }','${mc.listDocumentByMC.object[status.index+1].dtsid }')" title="${mc.listDocumentByMC.object[status.index+1].file_name}">${mc.listDocumentByMC.object[status.index+1].file_name}</a>
																</c:when>
																<c:otherwise>
					                                				<a href="javascript:void(0);" title="${mc.listDocumentByMC.object[status.index+1].video_name}">${mc.listDocumentByMC.object[status.index+1].video_name}</a>
																</c:otherwise>
															</c:choose>
					                                	</div></nobr>
					                                	<c:if test="${mc.listDocumentByMC.object[status.index+1].video_url != null and mc.listDocumentByMC.object[status.index+1].video_url != ''}">
					                                		<span class="_ds" onclick="viewvido('${mc.listDocumentByMC.object[status.index+1].video_url}')" title="点击播放视频"></span>
					                                	</c:if>
					                               	</div>
				                            	</div>
				                        	</c:if>
				                  		</td>
				                    </tr>
			                    </c:if>
		                    </c:forEach>
		                  </table>
		                  <br /><br />
		                  
		                  <c:if test="${thisPage != null}"><div class="page"><div class="pagination"></div></div></c:if>
		               		
		                </td>
		              </tr>
		              </c:if>
		       		</c:forEach>
          		</c:when>
          		<c:otherwise>
		          <tr>
		   	        <td align="left" valign="top">
		   	          
		   	          <div class="tag">
		   	          	<div>检索到<span style="color:#FF4400">&nbsp;${totalSize}&nbsp;</span>个文档匹配<span style="color:#FF4400">&nbsp;"${keyword}"&nbsp;</span>关键字<div>
		   	          	<div class="_line"></div>
		   	          </div>
		              
		              <table cellpadding="0" cellspacing="0" width="100%" style="font-size:12px;">
		                  <c:forEach var="doc" items="${listKeyword.object}" varStatus="status"> 
		                    <c:if test="${status.index % 2 == 0}">
				              <tr>
				                <td width="48%">
				                  <div class="content">
				                  
				                    <div class="num snum">0${status.index+1 }</div>
				                    <div class="file" style="padding-top:2px;">
                                	  <nobr><div class="i_ellipsis" style="width:253px;">
                                	  	<c:choose>
											<c:when test="${doc.file_name != null and doc.file_name != ''}">
                                				<a href="javascript:void(0);" onclick="viewfile(this,'${doc.file_url}','${doc.dtsid}')" title="${doc.file_name}">${doc.file_name}</a>
											</c:when>
											<c:otherwise>
                                				<a href="javascript:void(0);" title="${doc.video_name}">${doc.video_name}</a>
											</c:otherwise>
										</c:choose>
                                	  </div></nobr>
                                	  <c:if test="${doc.video_url != null and doc.video_url != ''}">
                                	  	<span class="_ds" onclick="viewvido('${doc.video_url}')" title="点击播放视频"></span>
                                	  </c:if>
				                    </div>
				                    
				                  </div>
				                </td>
				                <td width="4%"></td>
				                <td width="48%">
				                  <c:if test="${listKeyword.object[status.index+1].file_name != null}">
				                    <div class="content">
				                      <div class="num snum">0${status.index+2 }</div>
				                      <div class="file" style="padding-top:2px;">
                                	  <nobr><div class="i_ellipsis" style="width:253px;">
                                	  	<c:choose>
											<c:when test="${listKeyword.object[status.index+1].file_name != null and listKeyword.object[status.index+1].file_name != ''}">
                                				<a href="javascript:void(0);" onclick="viewfile(this,'${listKeyword.object[status.index+1].file_url }','${listKeyword.object[status.index+1].dtsid }')" title="${listKeyword.object[status.index+1].file_name}">${listKeyword.object[status.index+1].file_name}</a>
											</c:when>
											<c:otherwise>
                                				<a href="javascript:void(0);" title="${doc.video_name}">${doc.video_name}</a>
											</c:otherwise>
										</c:choose>
                                	  </div></nobr>
                                	  <c:if test="${listKeyword.object[status.index+1].video_url != null and listKeyword.object[status.index+1].video_url != ''}">
                                		<span class="_ds" onclick="viewvido('${listKeyword.object[status.index+1].video_url}')" title="点击播放视频"></span>
                                	  </c:if>
					                </div>
				                  </c:if>
				                </td>
				              </tr>
			                </c:if>
		                    </c:forEach>
		                  </table>
		                  
		                  <br /><br />
		                  
		                  <c:if test="${thisPage != null}"><div class="page"><div class="pagination"></div></div></c:if>
		               		
		                </td>
		              </tr>
          		</c:otherwise>
          	</c:choose>
          	
      </table>

	</center>
   
    <iframe src="<%=CLIENT %>/bottomNavigation" frameborder="0" scrolling="no" class="boiframe"></iframe>
   
</body>
</html>
<script type="text/javascript">
		
	var _dtsid=_dtmid=0;
	$(document).ready(function(){
		
		if("${thisPage}".length > 0)
		{
			var _thisPage = Number("${thisPage}")-1;
			var _pageSize = Number("${pageSize}");
			var _totalSize = Number("${totalSize}");
			if("${listKeyword}".length >0 ){
				$(".pagination").pagination(_totalSize, {callback: pageselectCallbackToKeyword,current_page:_thisPage,items_per_page:_pageSize});
			}else{
				$(".pagination").pagination(_totalSize, {callback: pageselectCallbackToMC,current_page:_thisPage,items_per_page:_pageSize});
			}
		}
		
		$.searchList();
		$.searchTxt();
		$.menu();
		$.tootip({IMG:"<%=allurl%><%=IMG%>",type:true,about:"<%=request.getContextPath()%>/client/about"});
		$.onlineCustomers({url:"<%=request.getContextPath()%>"});
		$.cloneNavigation({clone:".danghang",clone_right:0,top_range:255,pagetype:"repair"});
		$.clickNavigation({pagetype:"learn",match:".tag .t",callback:function(id){
			window.location = '<%=CLIENT%>/learn/more?start=1&pageSize=30&dtmid='+id;
		}});	
		
		$.onlineService({url:"<%=request.getContextPath()%>",target:"#phone",img:'<%=allurl%><%=IMG%>/support_phone.png'});	
		
		$(".tag .t").click(function(){
			$(this).parent().find(".t").each(function(){
				$(this).removeClass("selected");
			})
			$(this).addClass("selected");
		})
	})	
	
	function doKeyword(){
		window.location = '<%=CLIENT%>/learn/keyword?start=1&pageSize=30&keyword='+$("#keyword").attr("value");
	}
	
	function pageselectCallbackToKeyword(page_index, msg){
		if(msg != undefined){
			alert(msg);
		}else{
			window.location = '<%=CLIENT%>/learn/keyword?start='+(page_index+1)+'&pageSize=30&keyword='+$("#keyword").attr("value");
		}
		
		return false;
	}
		
	function pageselectCallbackToMC(page_index, msg){
		
		if(msg != undefined){
			alert(msg);
		}else{
			window.location = '<%=CLIENT%>/learn/more?start='+(page_index+1)+'&pageSize=30&dtmid=${dtmid}';
		}
		
		return false;
	}
	
	function doMajorCategory(links,dtmid){
		var cTable = $(links).parent().next();
		
		_dtmid = dtmid;
		_dtsid = -1;
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/client/learn/listDocumentByMC",
			dataType:"json",
			data:"pageSize=30&start=1&id="+dtmid,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					showResult(cTable,msg);
				}else{
					alert(msg.message);
				}
			}
		});
	}

	var _links = null;  
	function doSmallCategory(links,dtsid,dtmid,start){
		var cTable = $(links || _links).parent().next();
		
		_dtsid = dtsid || _dtsid;
		_dtmid = dtmid || _dtmid;
		_links = links || _links;
		start = start || 1;
		
		$.ajax({
			type : "post",
			url : "${pageContext.servletContext.contextPath}/client/learn/listDocumentBySC",
			dataType:"json",
			data:"pageSize=30&start="+start+"&dtsid="+_dtsid+"&dtmid="+_dtmid,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(msg) {
				if((msg.success+"") == "true"){
					showResult(cTable,msg);
				}else{
					alert(msg.message);
				}
			}
		});
	}
	
	function showResult(cTable,msg){
		var _html = "";
		var obj = msg.object;
		for(var i=0; i<obj.length; i++)
		{
			var doc = obj[i] || "";
			if(i%2 == 0)
			{
				_html += 
				'<tr>'+
                '	<td width="48%">'+
                '    	<div class="content">'+
                '            <div class="num snum">0'+(i+1)+'</div>'+
                '            <div class="file" style="padding-top:2px;">'+
                '            	<nobr><div class="i_ellipsis" style="width:253px;">'+
                '            		<a href="javascript:void(0);" onclick="viewfile(this,&quot;'+doc.file_url+'&quot;,&quot;'+doc.dtsid+'&quot;)" title="'+doc.file_name+'">'+doc.file_name+'</a>'+
                '            	</div></nobr>';
                if(doc.video_url != null && doc.video_url.length > 0){
                	_html += '<span class="_ds" onclick="viewvido(&quot;'+doc.video_url+'&quot;)" title="点击播放视频"></span>';
                }
                
                var doc2 = obj[i+1] || "";
                _html += 
                '</div></div>'+
              	'	</td>'+
                '    <td width="4%"></td>'+
                '    <td width="48%">';
                if(doc2.file_name != null && doc2.file_name.length > 0){
                	_html +=
	                '<div class="content">'+
	                '	<div class="num snum">0'+(i+2)+'</div>'+
	                '   <div class="file" style="padding-top:2px;">'+
	                '   <nobr><div class="i_ellipsis" style="width:253px;">'+
	                '   	<a href="javascript:void(0);" onclick="viewfile(this,&quot;'+doc2.file_url+'&quot;,&quot;'+doc2.dtsid+'&quot;)" title="'+doc2.file_name+'">'+doc2.file_name+'</a>'+
	                '   </div></nobr>';
	                if(doc2.video_url != null && doc2.video_url.length > 0){
	                	_html += '<span class="_ds" onclick="viewvido(&quot;'+doc2.video_url+'&quot;)" title="点击播放视频"></span>';
	                }
	                _html += '</div></div>';
                }
                _html +='</td></tr>';
			}
		}
		cTable.html(_html);
		
		var _thisPage = Number(msg.thisPage)-1;
		var _pageSize = Number(msg.pageSize);
		var _totalSize = Number(msg.totalSize);
		$(".pagination").pagination(_totalSize, {callback: pageselectCallbackToSC_MC,current_page:_thisPage,items_per_page:_pageSize});
	}
	
	function pageselectCallbackToSC_MC(page_index, msg){
		if(msg != undefined){
			alert(msg);
		}else{
			//window.location = '${pageContext.servletContext.contextPath}/client/learn/listDocumentBySC?pageSize=30&start='+(page_index+1)+'&dtsid='+_dtsid+'&dtmid='+_dtmid;
			doSmallCategory(null,null,null,page_index+1);
		}
		
		return false;
	}
	
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
	
	function viewvido(url){
		if("${cust_user.username}" == ""){
			alert("未登录，会员请现登录！");
		}else{
			if("${cust_user.user_type}" == "0"){
				openwin("<%=allurl%>${pageContext.servletContext.contextPath}/client/view/video?file="+url);
			}else{
				if("${cust_user_pre.videoPre}" == "0"){
					openwin("<%=allurl%>${pageContext.servletContext.contextPath}/client/view/video?file="+url);
				}else{
					alert("您的会员权限级别无法在线播放视频！");
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
 