package com.jr.interceptor.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.jr.core.Constants;

public class WebCommunicateInterceptor extends HandlerInterceptorAdapter {

	protected static Log logger = LogFactory
			.getLog(WebCommunicateInterceptor.class);

	private static Map<String, String> RW = new HashMap<String, String>();

	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp,
			Object handler) throws IOException {

		// Map<String,Object> users = (Map<String, Object>)
		// req.getSession().getAttribute(Constants.CUSER);

		// /////////////////////////////////////////////////////////////////////////
		// 客户端拦截
		// /////////////////////////////////////////////////////////////////////////

		HttpSession s = req.getSession();

		String url = req.getRequestURL().toString();
		if (url.indexOf("/client/view/") >= 0) {

			String msg = null;

			Map<String, Object> user = (Map<String, Object>) s
					.getAttribute(Constants.CUST_USER);

			if (user == null) {
				msg = "未登录，会员请现登录！";
			} else {
				if ((Integer) user.get("user_type") == 1) {
					if ((Integer) user.get("video_play") == 1
							&& url.indexOf("/client/view/video") >= 0) {
						msg = "您的会员权限级别无法在线播放视频！";
					}
					if (url.indexOf("/client/view/pdf") >= 0) {
						Map<String, String> pre = (Map<String, String>) req
								.getSession().getAttribute(
										Constants.CUST_USER_PRE);
						String pdfpre = pre.get("docPre");
						if (StringUtils.isEmpty(pdfpre)) {
							msg = "您的会员权限级别无法在线预览当前文件内容！";
						} else {
							boolean mark = false;
							String[] prearr = pdfpre.split(",");
							String dtsid = req.getParameter("dtsid");
							for (int i = 0; i < prearr.length; i++) {
								if (prearr[i].equals(dtsid)) {
									mark = true;
									break;
								}
							}
							if (mark == false) {
								msg = "您的会员权限级别无法在线预览当前文件内容！";
							}
						}
					}

					if (user != null && msg == null) {
						return true;
					}
				} else {
					return true;
				}
			}

			// 同步请求
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");

			PrintWriter out = resp.getWriter();
			StringBuilder builder = new StringBuilder();
			builder
					.append("<script type=\"text/javascript\" charset=\"UTF-8\">");
			builder.append("alert(\"" + msg + "\");");
			builder.append("</script>");
			out.print(builder.toString());
			out.close();

			return true;
		}

		// /////////////////////////////////////////////////////////////////////////
		// 后台拦截
		// /////////////////////////////////////////////////////////////////////////

		Map<String, Object> user = (Map<String, Object>) s
				.getAttribute(Constants.CUSER);
		if (user == null || (Integer) user.get("role_admin") != 0) {
			// 后台用户权限控制
			List<Map<String, Object>> lUser = (List<Map<String, Object>>) s
					.getAttribute("rw");

			String pName = req.getContextPath();
			String rw_url = url.substring(url.indexOf(pName) + pName.length(),
					url.length());

			String rwFlag = null;
			String topUrl = RW.get(rw_url);
			if (StringUtils.isNotEmpty(topUrl)) {

				for (int i = 0; i < lUser.size(); i++) {
					List<Map<String, Object>> child = (List<Map<String, Object>>) lUser
							.get(i).get("child");
					for (int j = 0; j < child.size(); j++) {
						Map<String, Object> tmenu = child.get(j);
						if (topUrl.equals((String) tmenu.get("href"))) {
							rwFlag = (String) tmenu.get("rw");
							break;
						}
					}
				}
			}

			if ("r".equals(rwFlag)) {
				resp.setHeader("sessionstatus", "no_w");

				req.setCharacterEncoding("UTF-8");
				resp.setContentType("text/html;charset=UTF-8");

				PrintWriter out = resp.getWriter();
				out.print("no_w");
				out.close();

				return false;
			}
		}

		if (s.getAttribute(Constants.CUSER) != null) {
			return true;
		}

		// 异步请求
		if (req.getHeader("x-requested-with") != null
				&& req.getHeader("x-requested-with").equalsIgnoreCase(
						"XMLHttpRequest")) {
			resp.setHeader("sessionstatus", "timeout");

			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");

			PrintWriter out = resp.getWriter();
			out.print("timeout");
			out.close();

			return false;
		}

		// 同步请求
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=UTF-8");

		PrintWriter out = resp.getWriter();
		StringBuilder builder = new StringBuilder();
		builder.append("<script type=\"text/javascript\" charset=\"UTF-8\">");
		// builder.append("alert(\"页面过期，请重新登录\");");
		builder.append("window.top.location.href=\"");
		builder.append(req.getContextPath());
		builder.append("/login\";</script>");
		out.print(builder.toString());
		out.close();

		return true;
	}

	static {

		// 产品
		RW.put("/product/save", "/product/productJump");
		RW.put("/product/deleteByIds", "/product/productJump");
		RW.put("/product/productImportSave", "/product/productJump");

		// 产品类别
		RW.put("/productCategory/save", "/productCategory/productCategoryJump");
		RW.put("/productCategory/deleteByIds",
				"/productCategory/productCategoryJump");

		// 产品描述
		RW.put("/productPage/save", "/productPage/productDescJump");

		// 产品滚动
		RW.put("/product/cancelScroll", "/product/productScrollListJump");
		RW.put("/product/confirmScroll", "/product/productScrollListJump");

		// --------------------------------------------------------------------------------------

		// 配件
		RW.put("/fitting/save", "/fitting/fittingJump");
		RW.put("/fitting/deleteByIds", "/fitting/fittingJump");
		RW.put("/fitting/fittingImportSave", "/fitting/fittingJump");

		// 配件专业类别
		RW.put("/fittingSpecialtyCate/save",
				"/fittingSpecialtyCate/fittingSpecialtyJump");
		RW.put("/fittingSpecialtyCate/deleteByIds",
				"/fittingSpecialtyCate/fittingSpecialtyJump");

		// 配件描述
		RW.put("/fittingPage/save", "/fittingPage/fittingPageDescJump");

		// --------------------------------------------------------------------------------------

		// 关于
		RW.put("/aboutdesc/save", "/aboutdesc/aboutdescJump");

		// 公司信息
		RW.put("/company/delete", "/company/companyJump");
		RW.put("/company/save", "/company/companyJump");

		// 客户目录
		RW
				.put("/customerController/delete",
						"/customerController/customerJump");
		RW.put("/customerController/save", "/customerController/customerJump");

		// 公司员工
		RW.put("/employee/delete", "/employee/employeeJump");
		RW.put("/employee/save", "/employee/employeeJump");

		// 发展历程
		RW.put("/growingProcess/delete", "/growingProcess/growingProcessJump");
		RW.put("/growingProcess/save", "/growingProcess/growingProcessJump");

		// 法律协议
		RW.put("/aboutdesc/saveToProtocold", "/aboutdesc/protocoldescJump");

		// 公司团队
		RW.put("/team/delete", "/team/teamJump");
		RW.put("/team/save", "/team/teamJump");

		// --------------------------------------------------------------------------------------

		// 学习文档库
		RW.put("/learn/delete", "/learn/learnJump");
		RW.put("/learn/save", "/learn/learnJump");

		// 大类别
		RW.put("/majorCategory/delete", "/majorCategory/majorJump");
		RW.put("/majorCategory/save", "/majorCategory/majorJump");

		// 小类别
		RW.put("/smallCategory/delete", "/smallCategory/smallJump");
		RW.put("/smallCategory/save", "/smallCategory/smallJump");

		// --------------------------------------------------------------------------------------

		// 租凭描述
		RW.put("/lease/descSave", "/lease/leaseDescJump");

		// 租凭滚动
		RW.put("/lease/cancelScroll", "/lease/scrollListJump");
		RW.put("/lease/confirmScroll", "/lease/scrollListJump");

		// --------------------------------------------------------------------------------------

		// 会员管理
		RW.put("/member/delete", "/member/memberJump");
		RW.put("/member/save", "/member/memberJump");

		// 租凭描述
		RW.put("/roleDocument/save", "/roleDocument/roledocJump");

		// --------------------------------------------------------------------------------------

		// 新闻中心
		RW.put("/news/delete", "/news/newsJump");
		RW.put("/news/save", "/news/newsJump");

		// --------------------------------------------------------------------------------------

		// 维修服务_维修种类
		RW.put("/service/categoryDeleteByIds", "/service/categoryJump");
		RW.put("/service/categorySave", "/service/categoryJump");

		// 维修服务_服务方式
		RW.put("/service/saveMode", "/service/modeJump");

		// 维修服务_服务承诺
		RW.put("/service/savePledge", "/service/pledgeJump");

		// 维修服务_服务范围
		RW.put("/service/saveRange", "/service/rangeJump");

		// 维修服务_维修报告单
		RW.put("/service/reportDeleteByIds", "/service/reportJump");
		RW.put("/service/reportSave", "/service/reportJump");

		// --------------------------------------------------------------------------------------

		// 角色管理
		RW.put("/role/delete", "role/roleJump");
		RW.put("/role/save", "role/roleJump");

		// 角色读写
		// RW.put("/rolemenu/saverw", "/rolemenu/rolerwJump");

		// 角色菜单
		RW.put("/rolemenu/save", "/rolemenu/rolemenuJump");
	}

}
