package com.jr.platform.about.controller;

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
import com.jr.core.Results;
import com.jr.platform.about.service.CompanyService;
import com.jr.util.Json;
import com.jr.util.Util;

@Controller
@RequestMapping("/company")
public class CompanyController extends BaseController {

	private Log log = LogFactory.getLog(CompanyController.class);

	@Autowired
	private CompanyService companyService;

	@Autowired
	private String fileDir;

	@RequestMapping(value = "/companyJump", method = RequestMethod.GET)
	public String companyJump() {
		return "backstage/about/company";
	}

	@RequestMapping(value = "/addJump", method = RequestMethod.GET)
	public String addJump() {
		return "backstage/about/company_add.edit";
	}

	@RequestMapping(value = "/editJump", method = RequestMethod.GET)
	public String editJump(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String id) {

		try {
			if (StringUtils.isNotEmpty(id)) {
				request.setAttribute("p", companyService.findById(Integer
						.parseInt(id)));
			} else {
				request.setAttribute("p", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/about/company_add.edit";
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public void list(HttpServletResponse response) {
		try {
			Results r = companyService.list();
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletResponse response, @RequestParam
	String cname, @RequestParam
	String cimage_url, @RequestParam
	String history_cimage_url, @RequestParam
	String caddress_image_url, @RequestParam
	String history_caddress_image_url, @RequestParam
	String leasing_qq, @RequestParam
	String complaints_qq, @RequestParam
	String ctype, @RequestParam
	String caddress, @RequestParam
	String cphone, @RequestParam
	String cfax, @RequestParam
	String customer_qq, @RequestParam
	String sales_qq, @RequestParam
	String id, @RequestParam
	String area_name,@RequestParam String email) {

		try {
			Results r = companyService.save(email,cname, cimage_url,
					caddress_image_url, leasing_qq, complaints_qq, ctype,
					caddress, cphone, cfax, customer_qq, sales_qq, id,
					area_name);
			if (r.isSuccess()
					&& StringUtils.isNotEmpty(history_caddress_image_url)) {
				Util.deleteFile(fileDir, history_caddress_image_url);
			}
			if (r.isSuccess() && StringUtils.isNotEmpty(history_cimage_url)) {
				Util.deleteFile(fileDir, history_cimage_url);
			}
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public void delete(HttpServletResponse response, @RequestParam
	String ids) {

		try {
			Results r = companyService.delete(Util.idsToArray(ids));
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.DELETEERROR, false));
		}
	}
}
