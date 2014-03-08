package com.jr.common.controller;

import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.ModelAndView;

import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import com.jr.core.BaseController;

/**
 * 验证码控制器
 */
@Controller
@RequestMapping("/")
public class CaptchaController extends BaseController {

	final Log log = LogFactory.getLog(CaptchaController.class);

	@Autowired
	private Producer captchaProducer;

	@RequestMapping("/captcha")
	public ModelAndView getCaptcha(HttpServletRequest request,
			HttpServletResponse response) {

		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control",
				"no-store, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("image/jpeg");
		String capText = captchaProducer.createText();

		request.getSession().setAttribute(Constants.KAPTCHA_SESSION_KEY,
				capText);
		
		log.debug("capText = " + capText+System.currentTimeMillis());

		ServletOutputStream out = null;
		try {
			out = response.getOutputStream();
			ImageIO.write(captchaProducer.createImage(capText), "jpg", out);
			out.flush();
			log.debug("capText = " + capText+System.currentTimeMillis());
		} catch (IOException e) {
			log.error(e);
		} finally {
			try {
				out.close();
			} catch (IOException e) {
				log.error(e);
			}
		}

		return null;
	}
}
