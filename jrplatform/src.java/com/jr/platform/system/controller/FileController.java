package com.jr.platform.system.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.jr.core.BaseController;
import com.jr.util.Json;

@Controller
@RequestMapping("file")
public class FileController extends BaseController {

	final Log log = LogFactory.getLog(FileController.class);

	@RequestMapping(value = "/uploadImage", method = RequestMethod.POST)
	public String uploadImage(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String image) {

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String fileDir = request.getSession().getServletContext().getRealPath(
				"device")
				+ File.separator;

		CommonsMultipartFile cFile = (CommonsMultipartFile) multipartRequest
				.getFile(image);// 获取上传文件

		if (null != cFile) {
			if (!cFile.isEmpty()) {
				String uuid = new Long(UUID.randomUUID()
						.getMostSignificantBits()).toString();
				String filename = uuid + "_" + cFile.getFileItem().getName();
				File uploadedFile = new File(fileDir + filename);
				try {
					FileCopyUtils.copy(cFile.getBytes(), uploadedFile);
					//outJsonString(response, Json.oJson(filename, true));
					return Json.oJson(filename, true);
				} catch (IOException e) {
					log.error(e.getMessage(), e);
					//outJsonString(response, Json.oJson("图片上传失败！", false));
					return Json.oJson("图片上传失败！", false);
				}
			}
		}
		
		return Json.oJson("未选择上传的图片！", false);
	}

}
