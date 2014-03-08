package com.jr.platform.fitting.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jr.core.BaseController;
import com.jr.core.Page;
import com.jr.core.Results;
import com.jr.platform.fitting.service.FittingService;
import com.jr.util.Json;
import com.jr.util.Util;

@Controller
@RequestMapping("/fitting")
public class FittingController extends BaseController {

	private Log log = LogFactory.getLog(FittingController.class);

	@Autowired
	private FittingService fittingService;

	@Autowired
	private String fileDir;

	@RequestMapping(value = "/fittingJump", method = RequestMethod.GET)
	public String productJump() {
		return "backstage/fitting/fitting";
	}

	@RequestMapping(value = "/fittingImport", method = RequestMethod.GET)
	public String fittingImport() {
		return "backstage/fitting/fittingImport";
	}

	@RequestMapping(value = "/addJump", method = RequestMethod.GET)
	public String addJump(HttpServletRequest request) {
		return "backstage/fitting/fitting_add.edit";
	}

	/**
	 * 产品批量导入数据_jump
	 */
	@RequestMapping(value = "/fittingImportSave", method = RequestMethod.POST)
	public void fittingImportSave(HttpServletRequest request,HttpServletResponse response) {
		try {
			String excelFileUrl = request.getParameter("excel_file_url");
			String zipFileUrl = request.getParameter("zip_file_url");
			String zipvalue = request.getParameter("zipvalue");

			if(excelFileUrl!=null&&!excelFileUrl.equals("")&&zipFileUrl!=null&&!zipFileUrl.equals("")){

				String 	buffer=fittingService.batchToSave(excelFileUrl, zipFileUrl, zipvalue);
				outJsonString(response,Json.oJson(buffer, false));
			}
		} catch (IOException e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	

	@RequestMapping(value = "/editJump", method = RequestMethod.GET)
	public String editJump(HttpServletRequest request, @RequestParam
	String id) {
		try {
			if (StringUtils.isNotEmpty(id)) {
				Map<String, Object> c = fittingService.findById(Integer
						.parseInt(id));
				request.setAttribute("p", c);
			} else {
				request.setAttribute("error", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}

		return "backstage/fitting/fitting_add.edit";
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public void list(HttpServletResponse response, @RequestParam
	int start, @RequestParam
	int pageSize, @RequestParam
	String stock, @RequestParam
	String device_type_use_id, @RequestParam
	String device_type_sort_id, @RequestParam
	String fitting_name, @RequestParam
	String brand, @RequestParam
	String fitting_number, @RequestParam
	String models) {

		try {
			Results r = fittingService.list(new Page(start, pageSize), stock,
					device_type_use_id, device_type_sort_id, fitting_name,
					brand, fitting_number, models);
			outJsonString(response, Json.toJson(r));
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}

	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletResponse response, @RequestParam
	String id, @RequestParam
	String fitting_name, @RequestParam
	String stock, @RequestParam
	String taobao_links, @RequestParam
	String brand, @RequestParam
	String device_type_use_id, @RequestParam
	String device_type_sort_id, @RequestParam
	String fitting_number, @RequestParam
	String specification_desc, @RequestParam
	String models, @RequestParam
	String fitting_desc, @RequestParam
	String sale_protection, @RequestParam
	String image_url, @RequestParam
	String historyimage) {

		try {
			Results r = fittingService.save(id, fitting_name, stock,
					taobao_links, brand, device_type_use_id,
					device_type_sort_id, fitting_number, specification_desc,
					models, fitting_desc, sale_protection, image_url);

			// 保存成功删除历史文件
			if (r.isSuccess() && StringUtils.isNotEmpty(historyimage)) {
				try {
					File fileTemp = new File(fileDir + historyimage);
					if (fileTemp.exists()) {
						fileTemp.delete();
					}
				} catch (RuntimeException e) {
					log.error(e);
				}
			}

			outJsonString(response, Json.toJson(r));
		} catch (DuplicateKeyException e) {
			String msg = "配件：'" + fitting_name + "'已存库，请检查确认！";
			log.error(msg);
			outJsonString(response, Json.oJson(msg, false));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	@RequestMapping(value = "/deleteByIds", method = RequestMethod.POST)
	public void deleteByIds(HttpServletResponse response, @RequestParam
	String ids) {
		try {
			String r = fittingService.deleteByIds(Util.idsToArray(ids));
			outJsonString(response, r);
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.DELETEERROR, false));
		}
	}
}
