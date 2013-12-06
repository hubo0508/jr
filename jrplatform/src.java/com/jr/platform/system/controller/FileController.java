package com.jr.platform.system.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.jr.core.BaseController;
import com.jr.util.Json;

@Controller
@RequestMapping("file")
public class FileController extends BaseController {

	final Log log = LogFactory.getLog(FileController.class);

	@Autowired
	private String fileDir;

	@RequestMapping(value = "/uploadImage", method = RequestMethod.POST)
	@ResponseBody
	public String uploadImage(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String image) {

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		CommonsMultipartFile cFile = (CommonsMultipartFile) multipartRequest
				.getFile(image);

		if ("image/jpeg".equals(cFile.getContentType())
				|| "image/gif".equals(cFile.getContentType())
				|| "image/png".equals(cFile.getContentType())) {
			
			if (null != cFile) {
				if (!cFile.isEmpty()) {
					String uuid = new Long(UUID.randomUUID()
							.getMostSignificantBits()).toString();
					String filename = uuid + "_"
							+ cFile.getFileItem().getName();
					File uploadedFile = new File(fileDir + filename);
					try {
						FileCopyUtils.copy(cFile.getBytes(), uploadedFile);
						return Json.oJson(filename, true);
					} catch (IOException e) {
						log.error(e.getMessage(), e);
						return Json.oJson("图片上传失败！", false);
					}
				}
			}
		}else{
			return Json.oJson("请上传png、gif或jpg格式的图片！", false);
		}

		return Json.oJson("未选择上传的图片！", false);
	}

	@RequestMapping(value = "/deleteImage", method = RequestMethod.POST)
	public void deleteImage(HttpServletResponse response, @RequestParam
	String image) {
		try {
			File fileTemp = new File(fileDir + image);
			if (fileTemp.exists()) {
				fileTemp.delete();
			}
		} catch (RuntimeException e) {
			log.error(e);
		}
	}

}
