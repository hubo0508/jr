package com.jr.common.controller;


import java.io.File;

import javax.servlet.http.HttpServletRequest;



/**
 * UEditor文件上传辅助类
 * 
 */
public class WebImagesUploader extends Uploader{

	
	public WebImagesUploader(HttpServletRequest request) {
		super(request);
	}

	@Override
	public void upload() throws Exception {
		super.upload();
		String set = "/pictures";
		this.url = (set+this.relativePath+File.separator+this.fileName).replace(File.separator, "/");
	}
	
	

}
