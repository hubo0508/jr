package com.jr.platform.service.controller;

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

import com.jr.core.BaseController;
import com.jr.core.Results;
import com.jr.platform.service.service.ServiceService;
import com.jr.util.Json;
import com.jr.util.Util;

@Controller
@RequestMapping("/service")
public class ServiceController extends BaseController {

	private Log log = LogFactory.getLog(ServiceController.class);

	@Autowired
	private ServiceService serviceService;

	/**
	 * 服务承诺_JUMP
	 */
	@RequestMapping(value = "/pledgeJump", method = RequestMethod.GET)
	public String pledgeJump(HttpServletRequest request) {
		try {
			request.setAttribute("p", serviceService.queryPledge());
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/service/pledgeDesc";
	}

	/**
	 * 服务方式_JUMP
	 */
	@RequestMapping(value = "/modeJump", method = RequestMethod.GET)
	public String modeJump(HttpServletRequest request) {
		try {
			request.setAttribute("p", serviceService.queryMode());
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/service/modeDesc";
	}

	/**
	 * 服务范围_JUMP
	 */
	@RequestMapping(value = "/rangeJump", method = RequestMethod.GET)
	public String rangeJump(HttpServletRequest request) {
		try {
			request.setAttribute("p", serviceService.queryRange());
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/service/rangeDesc";
	}

	/**
	 * 维修设备种类_JUMP
	 */
	@RequestMapping(value = "/categoryJump", method = RequestMethod.GET)
	public String categoryJump() {
		return "backstage/service/category";
	}

	/**
	 * 维修设备种类_新增_JUMP
	 */
	@RequestMapping(value = "/categoryAddJump", method = RequestMethod.GET)
	public String categoryAddJump() {
		return "backstage/service/category_add.edit";
	}

	/**
	 * 维修设备种类_编辑_JUMP
	 */
	@RequestMapping(value = "/categoryEditJump", method = RequestMethod.GET)
	public String editJump(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String id) {

		try {
			if (StringUtils.isNotEmpty(id)) {
				Map<String, Object> c = serviceService.queryCateoryById(Integer
						.parseInt(id));
				request.setAttribute("c", c);
			} else {
				request.setAttribute("c", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/service/category_add.edit";
	}

	/**
	 * 维修报告单_JUMP
	 */
	@RequestMapping(value = "/reportJump", method = RequestMethod.GET)
	public String reportJump(HttpServletRequest request) {
		return "backstage/service/report";
	}

	/**
	 * 维修报告单_新增_JUMP
	 */
	@RequestMapping(value = "/reportAddJump", method = RequestMethod.GET)
	public String reportAddJump() {
		return "backstage/service/report_add.edit";
	}

	/**
	 * 维修报告单_编辑_JUMP
	 */
	@RequestMapping(value = "/reportEditJump", method = RequestMethod.GET)
	public String reportEditJump(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String id) {

		try {
			if (StringUtils.isNotEmpty(id)) {
				request.setAttribute("p", serviceService
						.queryReportById(Integer.parseInt(id)));
			} else {
				request.setAttribute("p", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/service/report_add.edit";
	}

	/*-------------------------------------------------------------------------------------------*/
	/* JUMP END */
	/*-------------------------------------------------------------------------------------------*/

	/**
	 * 维修报告单_LIST
	 */
	@RequestMapping(value = "/reportList", method = RequestMethod.POST)
	public void reportList(HttpServletResponse response) {
		try {
			Results r = serviceService.reportList();
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	/**
	 * 维修报告单_SAVE_UPDATE
	 */
	@RequestMapping(value = "/reportSave", method = RequestMethod.POST)
	public void reportSave(HttpServletResponse response, @RequestParam
	String id, @RequestParam
	String file_name, @RequestParam
	String file_url, @RequestParam
	String file_desc) {
		try {
			Results r = serviceService.reportSave(id, Util.toFile(file_name),
					file_url, file_desc);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	/**
	 * 维修报告单_DELETE
	 */
	@RequestMapping(value = "/reportDeleteByIds", method = RequestMethod.POST)
	public void reportDeleteByIds(HttpServletResponse response, @RequestParam
	String ids) {

		try {
			Results r = serviceService.deleteToReportCard(Util.idsToArray(ids));
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.DELETEERROR, false));
		}
	}

	/**
	 * 维修种类_LIST
	 */
	@RequestMapping(value = "/categoryList", method = RequestMethod.POST)
	public void categoryList(HttpServletResponse response) {

		try {
			Results r = serviceService.categoryList();
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	/**
	 * 维修种类_SAVE_UPDATE
	 */
	@RequestMapping(value = "/categorySave", method = RequestMethod.POST)
	public void categorySave(HttpServletResponse response, @RequestParam
	String title, @RequestParam
	String content, @RequestParam
	String id) {
		try {
			Results r = serviceService.categorySave(id, title, content);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	/**
	 * 维修种类_DELETE
	 */
	@RequestMapping(value = "/categoryDeleteByIds", method = RequestMethod.POST)
	public void categoryDeleteByIds(HttpServletResponse response, @RequestParam
	String ids) {

		try {
			Results r = serviceService
					.categoryDeleteByIds(Util.idsToArray(ids));
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.DELETEERROR, false));
		}
	}

	/**
	 * 服务承诺_SAVE_OR_UPDATE
	 */
	@RequestMapping(value = "/savePledge", method = RequestMethod.POST)
	public void savePledge(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String id, @RequestParam
			String pledge) {
		try {
			Results r = serviceService.save(id, "pledge", pledge);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	/**
	 * 服务方式_SAVE_OR_UPDATE
	 */
	@RequestMapping(value = "/saveMode", method = RequestMethod.POST)
	public void saveMode(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String id, @RequestParam
			String mode) {
		try {
			Results r = serviceService.save(id, "mode", mode);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	/**
	 * 服务范围_SAVE_OR_UPDATE
	 */
	@RequestMapping(value = "/saveRange", method = RequestMethod.POST)
	public void saveRange(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String id, @RequestParam
			String range) {
		try {
			Results r = serviceService.save(id, "ranges", range);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

}
