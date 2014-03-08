package com.jr.platform.lease.controller;

import java.io.File;

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
import com.jr.platform.lease.service.LeaseService;
import com.jr.util.Json;
import com.jr.util.Util;

@Controller
@RequestMapping("/lease")
public class LeaseController extends BaseController {

	private Log log = LogFactory.getLog(LeaseController.class);

	@Autowired
	private LeaseService leaseService;

	@Autowired
	private String fileDir;

	@RequestMapping(value = "/leaseDescJump", method = RequestMethod.GET)
	public String leaseDescJump(HttpServletRequest request) {
		try {
			request.setAttribute("p", leaseService.find());
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/lease/leaseDesc";
	}

	@RequestMapping(value = "/scrollListJump", method = RequestMethod.GET)
	public String scrollListJump(HttpServletRequest request) {
		return "backstage/lease/productScroll";
	}

	@RequestMapping(value = "/selectProductJump", method = RequestMethod.GET)
	public String selectProductJump(HttpServletRequest request) {
		return "backstage/lease/selectProduct";
	}

	@RequestMapping(value = "/descSave", method = RequestMethod.POST)
	public void descSave(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String id, @RequestParam
			String contract_name, @RequestParam
			String description, @RequestParam
			String contract_url, @RequestParam
			String historydoc) {

		try {
			Results r = leaseService.descSave(id, description, contract_url,
					contract_name);

			// 保存成功删除历史文件
			if (r.isSuccess() && StringUtils.isNotEmpty(historydoc)) {
				try {
					File fileTemp = new File(fileDir + historydoc);
					if (fileTemp.exists()) {
						fileTemp.delete();
					}
				} catch (RuntimeException e) {
					log.error(e);
				}
			}
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	@RequestMapping(value = "/cancelScroll", method = RequestMethod.POST)
	public void cancelScroll(HttpServletResponse response, @RequestParam
	String ids) {
		try {
			String r = leaseService.scroll(Util.idsToArray(ids), 0);
			outJsonString(response, r);
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson("设置失败，请稍后再试！", false));
		}
	}

	@RequestMapping(value = "/confirmScroll", method = RequestMethod.POST)
	public void confirmScroll(HttpServletResponse response, @RequestParam
	String ids) {
		try {
			String r = leaseService.scroll(Util.idsToArray(ids), 1);
			outJsonString(response, r);
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson("设置失败，请稍后再试！", false));
		}
	}

	@RequestMapping(value = "/scrollList", method = RequestMethod.POST)
	public void scrollList(HttpServletResponse response) {
		try {
			Results r = leaseService.scrollList(1);
			outJsonString(response, Json.toJson(r));
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}
}
