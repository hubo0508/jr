<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common_include.jsp"%>
<div class="_search">
	<div class="_title" style="position:relative">产品筛选</div>
	<div class="round" style="z-index:0">
		<form action="${basePath}/client/product/findProductByBrandAndProductName?start=1&pageSize=4" method="get" name="findProductByBrandAndProductName">
		<input type="hidden" name="start" value="1"/>
		<input type="hidden" name="pageSize" value="4"/>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
			
				<td width="13%" align="right">设备品牌:</td>
				<td width="36%" align="left">
					<select name="brand" id="DropDownList1" class="kk2">
						<option value="">请选择</option>
						<c:forEach var="productBrand" items="${productBrand}">
							<option value="${productBrand.brand }">${productBrand.brand }</option>
						</c:forEach>
					</select>
				</td>
				<td width="4%"></td>
				<td width="13%" align="right">设备名称:</td>
				<td width="34%" align="left">
					<input type="text" class="txt" name="productName" style="width:188px;" />
				</td>
			</tr>
			<tr>
				<td colspan="5" height="10">
					<div style="border-bottom:1px dotted #999; width:100%;"></div></td>
			</tr>
			<tr>
				<td width="13%" align="right" valign="top">设备类别:</td>
				<td width="36%" align="left" colspan="4" class="zidingyi"
					valign="top">
					<table style="margin-top:-8px;" border="0" cellpadding="0"
						cellspacing="0" width="100%">
						<c:forEach var="value" items="${deviceTypeList}" varStatus="status" >
							<c:if test="${status.index%4==0}"><tr></c:if>
							<td align="left"><a href="${basePath}/client/product/findProduct?deviceTypeId=${value.id}&start=1&pageSize=4">${value.product_use}</a></td>
							<c:if test="${status.index%4==0}"></td></c:if>
						</c:forEach>
						</tr>
					</table></td>
			</tr>
			<tr>
				<td colspan="5" align="right" class="search_btn">
					<a onclick="javascript:document.findProductByBrandAndProductName.submit();">查询</a> <a onclick="javascript:document.findProductByBrandAndProductName.reset();">清除</a>
				</td>
			</tr>
		</table>
		</form>
	</div>
</div>