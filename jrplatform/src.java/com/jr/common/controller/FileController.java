package com.jr.common.controller;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.jr.core.BaseController;
import com.jr.core.Constants;
import com.jr.util.Json;

/**
 * 文件上传控制器
 */
@Controller
@RequestMapping("file")
public class FileController extends BaseController {

	final Log log = LogFactory.getLog(FileController.class);

	@Autowired
	private String fileDir;

	@Autowired
	private String jrdir;

	/**
	 * 上传flv文件
	 */
	@RequestMapping(value = "/uploadFlv", method = RequestMethod.POST)
	public void uploadFlv(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String file) {

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		CommonsMultipartFile cFile = (CommonsMultipartFile) multipartRequest
				.getFile(file);

		if (cFile.isEmpty()) {
			outJsonString(response, Json.oJson("请选择上传的文件！", false));
			return;
		}

		if ("application/octet-stream".equals(cFile.getContentType())) {
			String uuid = new Long(UUID.randomUUID().getMostSignificantBits())
					.toString();
			String fType = cFile.getFileItem().getName();
			fType = fType.substring(fType.lastIndexOf("."), fType.length());
			String filename = uuid + "_" + fType;

			File uploadedFile = new File(fileDir + filename);
			try {
				FileCopyUtils.copy(cFile.getBytes(), uploadedFile);
				outJsonString(response, Json.oJson(getSaveUrl(filename), true));
			} catch (IOException e) {
				log.error(e.getMessage(), e);
				outJsonString(response, Json
						.oJson(Constants.FILEE_ERROR, false));
			}
		} else {
			outJsonString(response, Json.oJson("视频文件格式为：FLV！", false));
		}
	}

	/**
	 * 只能上传SWF文件
	 */
	@RequestMapping(value = "/uploadSwf", method = RequestMethod.POST)
	public void uploadSwf(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String file) {

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		CommonsMultipartFile cFile = (CommonsMultipartFile) multipartRequest
				.getFile(file);

		if (cFile.isEmpty()) {
			outJsonString(response, Json.oJson("请选择上传的文件！", false));
			return;
		}
		if ("application/x-shockwave-flash".equals(cFile.getContentType())) {

			String uuid = new Long(UUID.randomUUID().getMostSignificantBits())
					.toString();
			String fType = cFile.getFileItem().getName();
			fType = fType.substring(fType.lastIndexOf("."), fType.length());
			String filename = uuid + "_" + fType;

			File uploadedFile = new File(fileDir + filename);
			try {
				FileCopyUtils.copy(cFile.getBytes(), uploadedFile);
				outJsonString(response, Json.oJson(getSaveUrl(filename), true));
			} catch (IOException e) {
				log.error(e.getMessage(), e);
				outJsonString(response, Json
						.oJson(Constants.FILEE_ERROR, false));
			}
		} else {
			outJsonString(response, Json.oJson("文件格式为：SWF！", false));
		}
	}

	@RequestMapping(value = "/uploadPdf", method = RequestMethod.POST)
	public void uploadPdf(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String file) {

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		CommonsMultipartFile cFile = (CommonsMultipartFile) multipartRequest
				.getFile(file);

		if (cFile.isEmpty()) {
			outJsonString(response, Json.oJson("请选择上传的文件！", false));
			return;
		}

		if ("application/x-shockwave-flash".equals(cFile.getContentType())) {
			String uuid = new Long(UUID.randomUUID().getMostSignificantBits())
					.toString();
			String fType = cFile.getFileItem().getName();
			fType = fType.substring(fType.lastIndexOf("."), fType.length());
			String filename = uuid + "_" + fType;

			File uploadedFile = new File(fileDir + filename);
			try {
				FileCopyUtils.copy(cFile.getBytes(), uploadedFile);
				outJsonString(response, Json.oJson(getSaveUrl(filename), true));
			} catch (IOException e) {
				log.error(e.getMessage(), e);
				outJsonString(response, Json
						.oJson(Constants.FILEE_ERROR, false));
			}
		} else {
			outJsonString(response, Json.oJson("文件格式为：SWF！", false));
		}
	}

	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
	public void uploadFile(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String file) {

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		CommonsMultipartFile cFile = (CommonsMultipartFile) multipartRequest
				.getFile(file);

		if (cFile.isEmpty()) {
			outJsonString(response, Json.oJson("请选择上传的文件！", false));
		} else {
			String uuid = new Long(UUID.randomUUID().getMostSignificantBits())
					.toString();
			String fType = cFile.getFileItem().getName();
			fType = fType.substring(fType.lastIndexOf("."), fType.length());
			String filename = uuid + "_" + fType;

			File uploadedFile = new File(fileDir + filename);
			try {
				FileCopyUtils.copy(cFile.getBytes(), uploadedFile);
				this.outJsonString(response, Json.oJson(getSaveUrl(filename), true));
			} catch (IOException e) {
				log.error(e.getMessage(), e);
				outJsonString(response, Json
						.oJson(Constants.FILEE_ERROR, false));
			}

		}
	}

	@RequestMapping(value = "/uploadImage", method = RequestMethod.POST)
	public void uploadImage(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String image) {

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		CommonsMultipartFile cFile = (CommonsMultipartFile) multipartRequest
				.getFile(image);

		// System.out.println(request.getContextPath());
		// System.out.println(request.getScheme());
		// System.out.println(request.getSession().getServletContext().getRealPath("jrdir"));
		// System.out.println(request.getServerName());

		if (cFile.isEmpty()) {
			outJsonString(response, Json.oJson("请选择上传的文件！", false));
			return;
		}

		if ("image/jpeg".equals(cFile.getContentType())
				|| "image/gif".equals(cFile.getContentType())
				|| "image/png".equals(cFile.getContentType())) {

			System.out.println(cFile.getOriginalFilename());
			if (!cFile.isEmpty()) {
				String uuid = new Long(UUID.randomUUID()
						.getMostSignificantBits()).toString();
				String fType = cFile.getFileItem().getName();
				fType = fType.substring(fType.lastIndexOf("."), fType.length());
				String filename = uuid + "_" + fType;

				File uploadedFile = new File(fileDir + filename);
				try {
					FileCopyUtils.copy(cFile.getBytes(), uploadedFile);
					outJsonString(response, Json.oJson(getSaveUrl(filename),
							true));
				} catch (IOException e) {
					log.error(e.getMessage(), e);
					outJsonString(response, Json.oJson("图片上传失败！", false));
				}
			}
		} else {
			outJsonString(response, Json.oJson("请上传png、gif或jpg格式的图片", false));
		}
	}

	private String getSaveUrl(String filename) {
		if (fileDir.startsWith("http")) {
			return fileDir;
		} else {
			// return request.getContextPath() + "/" + filename;
			return jrdir + "/" + filename;
		}
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
