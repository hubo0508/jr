package com.jr.client.customer.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.mail.EmailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jr.client.customer.service.CustomerCliService;
import com.jr.common.service.UserService;
import com.jr.core.BaseController;
import com.jr.core.Constants;
import com.jr.core.Results;
import com.jr.util.Json;

/**
 * 用户组件
 */
@Controller
@RequestMapping("/client")
public class CustomerCliController extends BaseController {

	private Log log = LogFactory.getLog(CustomerCliController.class);

	@Autowired
	private CustomerCliService customerCliService;

	@Autowired
	private UserService userService;

	/**
	 * <p>
	 * 获取客户/P>
	 * 
	 * @param id
	 * @param response
	 */
	@RequestMapping(value = "/getCustomer/{id}", method = RequestMethod.GET)
	public void getCustomer(@PathVariable
	int id, HttpServletResponse response) {
		Map<String, Object> map = customerCliService.getCustomer(id);
		outJsonString(response, Json.toJson(map));
	}

	/**
	 * 注册页面跳转
	 */
	@RequestMapping(value = "/registered", method = RequestMethod.GET)
	public String registered() {
		return "/client/registered";
	}

	/**
	 * 注册页面跳转
	 */
	@RequestMapping(value = "/forgotPassword", method = RequestMethod.GET)
	public String forgotPassword() {
		return "/client/forgotPassword";
	}

	/**
	 * 登录页面跳转
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "/client/login";
	}

	@RequestMapping(value = "/usersOff", method = RequestMethod.GET)
	public String logsOff(HttpServletRequest request) {
		request.getSession().removeAttribute(Constants.CUST_USER);
		return "redirect:/client/index";
	}

	/**
	 * 修改密码页面跳转
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/updatepassword", method = RequestMethod.GET)
	public String updatepassword(HttpServletRequest request) {

		try {
			Map<String, Object> user = (Map<String, Object>) request
					.getSession().getAttribute(Constants.CUST_USER);

			request.setAttribute("p", customerCliService
					.queryAccount((String) user.get("username")));
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}

		return "/client/updatePassword";
	}

	/**
	 * 用户登录
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public void login(HttpServletRequest request, HttpServletResponse response,
			@RequestParam
			String username, @RequestParam
			String password, @RequestParam
			String kaptcha) {

		if (StringUtils.isEmpty(kaptcha)) {
			this.outJsonString(response, Json.oJson("验证码不能为空", false));
			return;
		}

		String authCode = (String) request.getSession().getAttribute(
				com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		if (StringUtils.isEmpty(authCode)) {
			this.outJsonString(response, Json.oJson("请重新输入验证码", false));
			return;
		} else if (!authCode.equalsIgnoreCase(kaptcha)) {
			this.outJsonString(response, Json.oJson("验证码错误", false));
			return;
		} else {
			try {
				Results r = customerCliService.login(username, password);
				if (r != null && r.isSuccess()) {
					Map<String, Object> usermap = (Map<String, Object>) r
							.getObject();
					Map<String, String> userpre = customerCliService
							.queryDocumentPermissionsToUsers((Integer) usermap
									.get("id"));

					request.getSession().setAttribute(Constants.CUST_USER,
							usermap);
					request.getSession().setAttribute(Constants.CUST_USER_PRE,
							userpre);

					this.outJsonString(response, Json.toJson(r));
					
//					response.setHeader("pragma", "no-cache");
//					response.setHeader("cache-control", "no-cache");
//					response.setHeader("expires", "0");
				} else {
					if (r.isSuccess() == false) {
						outJsonString(response, Json.toJson(r));
					} else {
						outJsonString(response, Json.oJson("服务器繁忙，请稍后再试！",
								false));
					}
				}

			} catch (Exception e) {
				log.error(e.getMessage(), e);
				outJsonString(response, Json.oJson("服务器繁忙，请稍后再试！", false));
			}
		}
	}

	/**
	 * 用户注册
	 */
	@RequestMapping(value = "/registered", method = RequestMethod.POST)
	public void registered(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String username, @RequestParam
			String password, @RequestParam
			String kaptcha, @RequestParam
			String company_name, @RequestParam
			String company_address, @RequestParam
			String contact, @RequestParam
			String where_department, @RequestParam
			String fixed_telephone, @RequestParam
			String phone, @RequestParam
			String contact_email, @RequestParam
			String company_nature, @RequestParam
			String business_areas) {

		if (StringUtils.isEmpty(kaptcha)) {
			outJsonString(response, Json.oJson("验证码不能为空", false));
			return;
		}

		String authCode = (String) request.getSession().getAttribute(
				com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		if (StringUtils.isEmpty(authCode)) {
			outJsonString(response, Json.oJson("请重新输入验证码", false));
			return;
		} else if (!authCode.equalsIgnoreCase(kaptcha)) {
			outJsonString(response, Json.oJson("验证码错误", false));
			return;
		} else {
			try {
				Results r = customerCliService.save(username, password,
						kaptcha, company_name, company_address, contact,
						where_department, fixed_telephone, phone,
						contact_email, company_nature, business_areas);
				outJsonString(response, Json.toJson(r));

			} catch (EmailException e) {
				log.info("用户注册邮箱格式错误！");
				outJsonString(response, Json.oJson("注册邮箱'" + contact_email
						+ "'格式错误！", false));
			} catch (org.springframework.dao.DuplicateKeyException e) {
				log.info("用户名'" + username + "'已被注册！");
				outJsonString(response, Json.oJson(
						"用户名'" + username + "'已被注册！", false));
			} catch (Throwable e) {
				log.error(e.getMessage(), e);
				outJsonString(response, Json.oJson("注册失败，请稍后再试！", false));
			}
		}
	}

	/**
	 * 修改密码
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/updatepassword", method = RequestMethod.POST)
	public void updatepassword(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String password, @RequestParam
			String kaptcha, @RequestParam
			String oldPassword) {

		if (StringUtils.isEmpty(kaptcha)) {
			outJsonString(response, Json.oJson("验证码不能为空", false));
			return;
		}

		String authCode = (String) request.getSession().getAttribute(
				com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		if (StringUtils.isEmpty(authCode)) {
			outJsonString(response, Json.oJson("请重新输入验证码", false));
			return;
		} else if (!authCode.equalsIgnoreCase(kaptcha)) {
			outJsonString(response, Json.oJson("验证码错误", false));
			return;
		} else {
			try {

				Map<String, Object> user = (Map<String, Object>) request
						.getSession().getAttribute(Constants.CUST_USER);

				if (user == null) {
					outJsonString(response, Json.toJson(new Results(false,
							"未登录，不能进行修改密码操作！")));
					return;
				}

				String username = (String) user.get("username");

				Results r = userService.updatepassword(username, oldPassword,
						password);
				outJsonString(response, Json.toJson(r));
			} catch (Throwable e) {
				log.error(e.getMessage(), e);
				outJsonString(response, Json.toJson(new Results(false,
						"密码修改失败，请稍后再试！")));
			}
		}
	}

	/**
	 * 找回密码，并且将新密码发送至新邮箱
	 */
	@RequestMapping(value = "/forgotpassword", method = RequestMethod.POST)
	public void forgotpassword(HttpServletRequest request,
			HttpServletResponse response) {

		String contactEmail = request.getParameter("contact_email");
		String username = request.getParameter("username");

		try {

			Results r = customerCliService.forgotpassword(username,
					contactEmail);
			outJsonString(response, Json.toJson(r));

		} catch (EmailException e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.toJson(new Results("注册邮箱格式错误！")));
		}
	}

}
