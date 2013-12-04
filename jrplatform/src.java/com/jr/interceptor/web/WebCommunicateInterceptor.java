package com.jr.interceptor.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.jr.platform.Constants;

public class WebCommunicateInterceptor extends HandlerInterceptorAdapter {

	protected static Log logger = LogFactory
			.getLog(WebCommunicateInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp,
			Object handler) throws IOException {

		// String requestUrl = req.getRequestURL().toString();
		
		//Map<String,Object> users = (Map<String, Object>) req.getSession().getAttribute(Constants.CUSER);

		if (req.getSession().getAttribute(Constants.CUSER) != null) {
			return true;
		}

		// 异步请求
		if (req.getHeader("x-requested-with") != null
				&& req.getHeader("x-requested-with").equalsIgnoreCase(
						"XMLHttpRequest")) {
			resp.setHeader("sessionstatus", "timeout");
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
}
