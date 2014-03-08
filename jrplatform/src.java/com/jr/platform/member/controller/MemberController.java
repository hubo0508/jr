package com.jr.platform.member.controller;

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

import com.jr.core.BaseController;
import com.jr.core.Page;
import com.jr.core.Results;
import com.jr.platform.member.service.MemberService;
import com.jr.util.Json;

/**
 * 会员管理
 */
@Controller
@RequestMapping("/member")
public class MemberController extends BaseController {

	private Log log = LogFactory.getLog(MemberController.class);

	@Autowired
	private MemberService memberService;

	@RequestMapping(value = "/memberJump", method = RequestMethod.GET)
	public String memberJump() {
		return "backstage/member/member";
	}

	@RequestMapping(value = "/editJump", method = RequestMethod.GET)
	public String editJump(HttpServletRequest request, @RequestParam
	String id) {
		try {
			if (StringUtils.isNotEmpty(id)) {
				request.setAttribute("p", memberService.findById(Integer
						.parseInt(id)));
			} else {
				request.setAttribute("p", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}

		return "backstage/member/member_edit";
	}

	/**
	 * 列表查询
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public void list(HttpServletResponse response, @RequestParam
	int start, @RequestParam
	int pageSize, @RequestParam
	String status, @RequestParam
	String rolenameid, @RequestParam
	String vido_play, @RequestParam
	String sTime, @RequestParam
	String eTime, @RequestParam
	String company_name, @RequestParam
	String contact, @RequestParam
	String phone, @RequestParam
	String company_nature, @RequestParam
	String business_areas) {
		try {
			Results r = memberService.list(new Page(start, pageSize), status,
					rolenameid, vido_play, sTime, eTime, company_name, contact,
					phone, company_nature, business_areas);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletRequest request, HttpServletResponse response,
			@RequestParam
			String role_id, @RequestParam
			String uid, @RequestParam
			String status, @RequestParam
			String rolenameid) {
		try {
			Results r = memberService.save(rolenameid, uid, status);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson("授权失败，请稍后再试！", false));
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public void delete(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String ids) {
		try {
			Results r = memberService.delete(ids);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson("删除数据失败，请稍后再试！", false));
		}
	}

}
