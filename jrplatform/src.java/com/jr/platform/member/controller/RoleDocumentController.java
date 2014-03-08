package com.jr.platform.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jr.core.BaseController;
import com.jr.core.Constants;
import com.jr.core.Results;
import com.jr.platform.member.service.RoleDocumentService;
import com.jr.util.Json;
import com.jr.util.Util;

@Controller
@RequestMapping("/roleDocument")
public class RoleDocumentController extends BaseController {

	private Log log = LogFactory.getLog(RoleDocumentController.class);

	@Autowired
	private RoleDocumentService roleDocumentService;

	@RequestMapping(value = "/roledocJump", method = RequestMethod.GET)
	public String roledocJump() {
		return "backstage/member/role_document";
	}

	@RequestMapping(value = "/roleDocumentIdList", method = RequestMethod.POST)
	public void roleDocumentIdList(HttpServletResponse response, @RequestParam
	String id) {
		try {
			outJsonString(response, Json.toJson(roleDocumentService
					.roleDocumentIdList(id)));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletRequest request, HttpServletResponse response,
			@RequestParam
			String role_id, @RequestParam
			String document_type_id, @RequestParam
			String video_play) {

		try {

			if ((Constants.INTERNAL + "").equals(video_play)
					|| (Constants.THIRD_PARTY + "").equals(video_play)) {
			} else {
				video_play = Constants.THIRD_PARTY + "";
			}

			Results r = roleDocumentService.save(video_play,role_id,
					document_type_id == "" ? null : Util
							.idsToArray(document_type_id));
			if (r.isSuccess() == true) {
				r.setMessage("授权成功！");
			} else {
				r.setMessage("授权失败，请稍后再试！");
			}
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson("授权失败，请稍后再试！", false));
		}
	}

}
