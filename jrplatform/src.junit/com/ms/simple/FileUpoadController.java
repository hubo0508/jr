package com.ms.simple;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileUpoadController {

	@RequestMapping(value = "/flexuploadfile", method = RequestMethod.POST)
	public void flexuploadfile(@RequestParam("data") String data,
			HttpServletResponse response, HttpServletRequest request) {

		System.out.println(data);

	}

	//CKEDITOR.instances.editor1.getData();
	//CKEDITOR.instances.editor1.setData("Hello World!");
	//http://localhost:8080/MS/resources/ckeditor/samples/replacebycode.html
	@RequestMapping(value = "/handleFormUpload", method = RequestMethod.POST)
	public void handleFormUpload(@RequestParam("CKEditor") String CKEditor,
			@RequestParam("CKEditorFuncNum") String CKEditorFuncNum,
			@RequestParam("langCode") String langCode,
			@RequestParam("upload") MultipartFile file,
			HttpServletResponse response, HttpServletRequest request) {

		StringBuilder builder = new StringBuilder();

		// 判断上传图像类型
		String cType = file.getContentType();
		if (cType != null
				&& ("image/jpeg".equals(cType) || "image/gif".equals(cType))
				|| "image/tiff".equals(cType) || "image/gif".equals(cType)) {

			// 存储文件
			if (!file.isEmpty()) {

				ServletContext sc = request.getSession().getServletContext();
				String sPath = sc.getRealPath("/") + "resources"
						+ File.separator;
				String fName = UUID.randomUUID().toString() + "_"
						+ file.getOriginalFilename();

				OutputStream os = null;
				try {
					os = new FileOutputStream(sPath + fName);
					os.write(file.getBytes());
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					if (os != null) {
						try {
							os.close();
						} catch (IOException e) {
						}
					}
				}

				builder.append("<script type=\"text/javascript\">");
				builder.append("window.parent.CKEDITOR.tools.callFunction("
						+ CKEditorFuncNum + ",'" + request.getContextPath()
						+ "/resources/" + fName + "','')");
				builder.append("</script>");

				outScript(response, builder.toString());
			}

		} else {

			// 上传图像类型不满足条件
			builder.append("<script type=\"text/javascript\">");
			builder.append("window.parent.CKEDITOR.tools.callFunction("
					+ CKEditorFuncNum + ",'',"
					+ "'文件格式不正确（必须为.jpg/.gif/.bmp/.png文件）');");
			builder.append("</script>");

			outScript(response, builder.toString());

		}
	}

	private void outScript(HttpServletResponse response, String script) {
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.print(script);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}
}