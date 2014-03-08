package com.jr.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jr.common.service.CommonUsersService;
import com.jr.common.service.UserService;
import com.jr.core.BaseController;
import com.jr.core.Constants;
import com.jr.core.Results;
import com.jr.platform.system.service.SystemService;
import com.jr.util.Json;

/**
 * 后台用户登录
 */
@Controller
@RequestMapping("/")
public class UserController extends BaseController {

	private Log log = LogFactory.getLog(UserController.class);
	
	@Autowired
	private UserService userService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private String cloudflv;

	@Autowired
	private String cloudattachment;
	
	@Autowired
	private String cloudview;

	@Autowired
	private CommonUsersService commonUsersService;
	
	/**
	 * 用户注销
	 */
	@RequestMapping(value = "/logsOff", method = RequestMethod.GET)
	public String logsOff(HttpServletRequest request) {
		request.removeAttribute(com.jr.core.Constants.CUSER);
		return "backstage/login";
	}
	
	/**
	 * 用户登录跳转
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginJump(HttpServletRequest request) {
		request.removeAttribute(com.jr.core.Constants.CUSER);
		return "backstage/login";
	}
	
	/**
	 * 修改密码跳转
	 */
	@RequestMapping(value = "user/updatepasswordJump", method = RequestMethod.GET)
	public String updatepasswordJump(HttpServletRequest request) {
		request.removeAttribute(com.jr.core.Constants.CUSER);
		return "backstage/updatepassword";
	}

	/**
	 * 修改密码
	 */
	@RequestMapping(value = "user/updatepassword", method = RequestMethod.POST)
	public void updatepassword(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String username, @RequestParam
			String oldPass, @RequestParam
			String nPassFist, @RequestParam
			String nPassLast) {

		try {
			Results r = userService
					.updatepassword(username, oldPass, nPassFist);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	/**
	 * 用户登录。
	 */
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
				com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		if (StringUtils.isEmpty(authCode)) {
			msg = "请重新输入验证码";
		} else if (!authCode.equalsIgnoreCase(kaptcha)) {
			msg = "验证码错误";
		} else {

			try {
				Map<String, Object> user = userService
						.login(username, password);
				if (user == null) {
					outJsonString(response, Json.oJson("用户名或密码错误！", false));
					return;
				}

				Object uid = user.get("id");
				if (user != null) {
					success = true;

					List<Map<String, Object>> lUser = systemService
							.queryFirstMenu(uid);

					for (int i = 0; i < lUser.size(); i++) {
						Map<String, Object> lMap = lUser.get(i);

						List<Map<String, Object>> child = systemService
								.querySubMenu(uid, lMap.get("id"));

						Map<String, Object> sp = new HashMap<String, Object>();
						sp.put("text", "/");
						child.add(sp);

						lMap.put("child", child);
					}

					HttpSession session = request.getSession();
					
					//当前用户
					session.setAttribute(Constants.CUSER, user);
					
					//权限菜单
					session.setAttribute("menu", Json.toJson(lUser));
					
					//读写权限
					session.setAttribute("rw", lUser);

					// 云服务接口存储
					session.setAttribute("cloudflv_u", cloudflv);
					session.setAttribute("cloudattachment_u", cloudattachment);
					session.setAttribute("cloudview", cloudview);
					
					//记录登录日志
					commonUsersService.updateUserLog(username);

				} else {
					msg = "用户名或密码错误！";
				}
			} catch (Exception e) {
				msg = "服务器繁忙，请稍后再试！";
				log.error(msg, e);
				success = false;
			}
		}

		this.outJsonString(response, Json.oJson(msg, success));
	}
}
