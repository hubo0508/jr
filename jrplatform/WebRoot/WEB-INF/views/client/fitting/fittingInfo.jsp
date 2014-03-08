<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	
	String allurl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String filedir = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + "/";
	
	String JS = path + "/resources/client/js";
	String CSS = path + "/resources/client/css";
	String IMG = path + "/resources/client/img";
	String CLIENT = path + "/client";
	String IMAGE = path + "/resources/client/image";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<%@ include file="/common/common_client.jsp" %>
	
    <script src="${basePath}/resources/client/js/jquery-1.7.js" type="text/javascript"></script>
    
    <script src="${basePath}/resources/client/js/index.js" type="text/javascript"></script>
    
    <script src="${basePath}/resources/client/js/marquee.js" type="text/javascript"></script>
    <link href="${basePath}/resources/client/css/product.css" rel="stylesheet" type="text/css" />
    <link href="${basePath}/resources/client/css/style.css" rel="stylesheet" type="text/css" />
    
    <script src="${basePath}/resources/client/js/jquery.pagination.js" type="text/javascript"></script>
    <link href="${basePath}/resources/client/css/jquery.pagination.css" rel="stylesheet" type="text/css" /> 
    
</head>

<body>
<center>

  <c:import url="/client/menu/fitting"/>
  
  <table class="container product_t" border="0" cellpadding="0" cellspacing="0" height="100%"> 
    <tr>
    	
      <td valign="top" align="left">
      	
        <div class="daohang" style="padding-left:0px; color:#000; font-weight:bold; font-size:13px;">
          <a href="${basePath}/client/fitting">配件中心</a>&gt;
          <a href="${basePath}/client/fitting">品牌分类</a> <c:if test="${brand!=null&&brand!=''}">&gt;</c:if>
          <a href="${basePath}/client/fitting/getFittingByFittingCategory?brand=${brand }&start=1&pageSize=4">${brand}</a> 
        </div>
        
		<div class="_search">
          <div class="_title"  style="position:relative">配件筛选</div>
          <div class="round" style="z-index:0">
            <form action="${basePath}/client/fitting/findFitting?start=1&pageSize=4" method="get" name="findFitting">
            
              <input type="hidden" name="start" value="1"/>
              <input type="hidden" name="pageSize" value="4"/>
              
              <table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size:12px; color:#000; font-family:'宋体'">
                <tr>
                  <td width="13%" align="right">配件品牌:</td>
                  <td width="36%" align="left">
                    <select name="brand" id="DropDownList1" class="kk2">
                      <option value="">请选择</option>
                        <c:forEach var="fittingBrand" items="${fittingBrand}">
                          <option value="${fittingBrand.brand }" <c:if test="${fittingBrand.brand==brand}">   selected="selected" </c:if> >${fittingBrand.brand }</option>
                        </c:forEach>
                    </select>
                  </td>
                  <td width="4%"></td>
                  <td width="13%" align="right">配件名称:</td>
                  <td width="34%" align="left"><input type="text" class="txt" name="fittingName" value="${fittingName}"	style="width:188px;" /></td>
				</tr>
						<tr>
							<td width="13%" align="right">配件编号:</td>
							<td width="36%" align="left"><input type="text" class="txt" name="fittingNO" value="${fittingNO}"
								style="width:188px;" />
							</td>
							<td width="4%"></td>
							<td width="13%" align="right">适用机型:</td>
							<td width="34%" align="left"><input type="text" class="txt" name="fittingDevice" value="${fittingDevice}"
								style="width:188px;" />
							</td>
						</tr>
						<tr>
							<td colspan="5" height="10">
								<div style="border-bottom:1px dotted #999; width:100%;"></div></td>
						</tr>
						<tr>
							<td width="13%" align="right" valign="top" style="padding-top:12px;">配件用途:</td>
							<td width="36%" align="left" colspan="4" class="zidingyi"
								valign="top">
								<table width="100%">

									<c:forEach var="value" items="${deviceTypeList}" varStatus="status" >
										<c:if test="${status.index%4==0}"><tr></c:if>
										<td align="left"><a style="font-size:12px;" href="${basePath}/client/fitting/getFittingByFittingCategory?deviceTypeUseId=${value.id}&start=1&pageSize=4">${value.product_use}</a></td>
										<c:if test="${status.index%4==0}"></td></c:if>
									</c:forEach>
								
								</table></td>
						</tr>
						<tr>
							<td colspan="5" height="10">
								<div style="border-bottom:1px dotted #999; width:100%;"></div>
							</td>
						</tr>
						<tr>
							<td width="13%" align="right" valign="top" style="padding-top:12px;">配件归类:</td>
							<td width="36%" align="left" colspan="4" class="zidingyi"
								valign="top">
								<table width="100%">
									
									 <c:forEach var="value" items="${fittingCategory}" varStatus="status" >
										<c:if test="${status.index%4==0}"><tr></c:if>
										<td align="left"><a style="font-size:12px;" href="${basePath}/client/fitting/getFittingByFittingCategory?deviceTypeSortId=${value.id}&start=1&pageSize=4">${value.fitting_category}</a></td>
										<c:if test="${status.index%4==0}"></td></c:if>
									</c:forEach>
									
								</table></td>
						</tr>
						<tr>
							<td colspan="5" align="right" class="search_btn"><a onclick="javascript:document.findFitting.submit();">查询</a> <a onclick="javascript:document.findFitting.reset();">清除</a>
							</td>
						</tr>
					</table>
					</form>
				</div>
			</div>
        
        <!-- 配件查询 -->
                    <dd style="color:#005AA0; font-size:16px; margin-left:0px;">
                    	<br />
                    	检索出${results.totalSize}个配件
                        <dd class="line" style="margin-left:0px;"></dd>
                    </dd>
					<div class="zhonglei" style="margin-top:15px;">
                     <c:forEach var="value" items="${results.object}" varStatus="result">
                     	<c:if test="${result.index%4!=0 }">	<div class="i_sp"></div> </c:if>   
                    	<div class="info">
                        	<div class="img"><a href="${basePath}/client/fitting/getFittingByFittingId/${value.id}" target="_blank">
	                        	<c:if test="${value.image_url==null||value.image_url==''}"><img src="${basePath}/resources/image/notImageToClient.png"  width="200" height="200"  /></c:if>
			                    <c:if test="${value.image_url!=null&&value.image_url!=''}"><img src="${value.image_url}" style="max-width:200px; max-height:200px;" /></c:if>
                        	</a></div>
                            <div class="text" align="left" style="font-size:12px;font-family:'宋体'">
                                <p class="i_tit">设备品牌：<a href="${basePath}/client/fitting/getFittingByFittingId/${value.id}" target="_blank">${value.brand }</a></p>
                                <p class="i_tit">设备名称：<a href="${basePath}/client/fitting/getFittingByFittingId/${value.id}" target="_blank">${value.fitting_name }</a></p>
                            </div>
                        </div>
                     </c:forEach> 
                    </div>
              </td>
            </tr>
         	<tr>
            	<td align="right"> <div class="page"><div class="pagination"></div></div> </td>
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
		
							   
		var _thisPage = Number("${results.thisPage}")-1;
		var _pageSize = Number("${results.pageSize}");
		var _totalSize = Number("${results.totalSize}");
		var opt = {callback: pageselectCallback};
				opt.current_page        = _thisPage;
				opt.items_per_page      = _pageSize;
		$(".pagination").pagination(_totalSize, opt);
});	

	function pageselectCallback(page_index, msg){
		if(msg != undefined){
			alert(msg);
		}else{
			window.location = "${basePath}/${url}&start="+(page_index+1)+"&pageSize=4";
		}
		return false;
	}
</script>
 