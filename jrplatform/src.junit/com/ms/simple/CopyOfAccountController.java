package com.ms.simple;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CopyOfAccountController {

	@RequestMapping(value = "/welcome", method = RequestMethod.GET)
	public String login(Model model, HttpServletRequest request) {
		return "welcome";
	}
}
