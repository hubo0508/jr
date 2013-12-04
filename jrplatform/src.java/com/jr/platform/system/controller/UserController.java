package com.jr.platform.system.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.code.kaptcha.Constants;
import com.jr.core.BaseController;
import com.jr.platform.system.service.UserService;
import com.jr.util.Json;

@Controller
@RequestMapping("/")
public class UserController extends BaseController {

	@Autowired
	private UserService userService;

	private Log log = LogFactory.getLog(UserController.class);

	@RequestMapping(value = "/logsOff", method = RequestMethod.GET)
	public String logsOff() {
		return "login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginJump(HttpServletRequest request) {
		request.removeAttribute(com.jr.platform.Constants.CUSER);
		return "login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public void login(HttpServletRequest request, HttpServletResponse response,
			@RequestParam
			String username, @RequestParam
			String password, @RequestParam
			String kaptcha) {

		String msg = "";
		boolean success = false;

		if (StringUtils.isEmpty(kaptcha)) {
			msg = "验证码不能为空";
		}

		String authCode = (String) request.getSession().getAttribute(
				Constants.KAPTCHA_SESSION_KEY);
		if (StringUtils.isEmpty(authCode)) {
			msg = "请重新输入验证码";
		} else if (!authCode.equalsIgnoreCase(kaptcha)) {
			msg = "验证码错误";
		} else {

			try {
				Map<String, Object> user = userService
						.login(username, password);

				if (user != null) {
					success = true;
					request.getSession().setAttribute(
							com.jr.platform.Constants.CUSER, user);
				} else {
					msg = "用户名或密码错误！";
				}
			} catch (Exception e) {
				msg = "服务器繁忙，请稍后再试！";
				log.error(msg, e);
			}
		}

		this.setResponse(response);
		this.outJsonString(Json.oJson(msg, success));
	}
}
