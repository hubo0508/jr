<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common_include.jsp"%>
<div class="_search">
	<div class="_title"  style="position:relative">配件筛选</div>
	<div class="round" style="z-index:0">
	<form action="${basePath}/client/fitting/findFitting?start=1&pageSize=4" method="get" name="findFitting">
	<input type="hidden" name="start" value="1"/>
	<input type="hidden" name="pageSize" value="4"/>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td width="13%" align="right">配件品牌:</td>
				<td width="36%" align="left">
				<select name="brand" id="DropDownList1" class="kk2">
						<option value="">请选择</option>
						<c:forEach var="fittingBrand" items="${fittingBrand}">
							<option value="${fittingBrand.brand }">${fittingBrand.brand }</option>
						</c:forEach>
				</select></td>
				<td width="4%"></td>
				<td width="13%" align="right">配件名称:</td>
				<td width="34%" align="left"><input type="text" class="txt" name="fittingName"
					style="width:188px;" />
				</td>
			</tr>
			<tr>
				<td width="13%" align="right">配件编号:</td>
				<td width="36%" align="left"><input type="text" class="txt" name="fittingNO"
					style="width:188px;" />
				</td>
				<td width="4%"></td>
				<td width="13%" align="right">适用机型:</td>
				<td width="34%" align="left"><input type="text" class="txt" name="fittingDevice"
					style="width:188px;" />
				</td>
			</tr>
			<tr>
				<td colspan="5" height="10">
					<div style="border-bottom:1px dotted #999; width:100%;"></div></td>
			</tr>
			<tr>
				<td width="13%" align="right" valign="top">配件用途:</td>
				<td width="36%" align="left" colspan="4" class="zidingyi"
					valign="top">
					<table width="100%" style="margin-top:-8px;">
						<%--<c:forEach var="value" items="${fittingUse}" varStatus="status" >
							<c:if test="${status.index%4==0}"><tr></c:if>
							<td align="left"><a href="${basePath}/client/fitting/getFittingByFittingCategory?deviceTypeUseId=${value.id}&start=1&pageSize=4">${value.fitting_use}</a></td>
							<c:if test="${status.index%4==0}"></td></c:if>
						</c:forEach>
					--%>
					
					<c:forEach var="value" items="${deviceTypeList}" varStatus="status" >
							<c:if test="${status.index%4==0}"><tr></c:if>
							<td align="left"><a href="${basePath}/client/fitting/getFittingByFittingCategory?deviceTypeUseId=${value.id}&start=1&pageSize=4">${value.product_use}</a></td>
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
				<td width="13%" align="right" valign="top">配件归类:</td>
				<td width="36%" align="left" colspan="4" class="zidingyi"
					valign="top">
					<table width="100%" style="margin-top:-8px;">
						
						 <c:forEach var="value" items="${fittingCategory}" varStatus="status" >
							<c:if test="${status.index%4==0}"><tr></c:if>
							<td align="left"><a href="${basePath}/client/fitting/getFittingByFittingCategory?deviceTypeSortId=${value.id}&start=1&pageSize=4">${value.fitting_category}</a></td>
							<c:if test="${status.index%4==0}"></td></c:if>
						</c:forEach>
						<%--<tr>
							<td align="left" width="165"><a href="#">压缩机及其附件</a>
							</td>
							<td align="left" width="165"><a href="#">门中柱</a>
							</td>
							<td align="left" width="165"><a href="#">门封条</a>
							</td>
						</tr>
						<tr>
							<td align="left"><a href="#">控制器及其附件</a>
							</td>
							<td align="left"><a href="#">加热管（丝）</a>
							</td>
							<td align="left"><a href="#">电机及其附件</a>
							</td>
						</tr>
						<tr>
							<td align="left"><a href="#">管路类零件</a>
							</td>
							<td align="left"><a href="#">其他零件</a>
							</td>
							<td align="left">&nbsp;</td>
						</tr>
					--%>
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