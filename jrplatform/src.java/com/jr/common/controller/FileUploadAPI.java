package com.jr.common.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
@RequestMapping("/fileAPI")
public class FileUploadAPI {
	
	
	
	
	
	
	/**上传图片
	 * @param request
	 * @return
	 * @throws JsonFormatedException 
	 */
	@RequestMapping(value="/imagesUpload")
	public void imagesUp(HttpServletRequest request,HttpServletResponse response) throws Exception{
		WebImagesUploader uploader = new WebImagesUploader(request);
	    String[] fileType = {".gif" , ".png" , ".jpg" , ".jpeg" , ".bmp"};
	    uploader.setAllowFiles(fileType);
	    uploader.setMaxSize(10000); //单位KB
	    uploader.setPhysicalPath("D:\\img");
		uploader.upload();
		response.setCharacterEncoding("utf-8");
		response.getWriter().print("{'original':'"+uploader.getOriginalName()+"','url':'"+uploader.getUrl()+"','title':'"+uploader.getTitle()+"','state':'"+uploader.getState()+"'}");
	}
	
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/imageManager") 
	public void imageManager(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		String imgStr ="";
		String realpath = "D:\\img";
		List<File> files = getFiles(realpath,new ArrayList());
		for(File file :files ){
			imgStr+=file.getPath().replace(realpath,"")+"ue_separate_ue";
		}
		if(imgStr!=""){
	        imgStr = imgStr.substring(0,imgStr.lastIndexOf("ue_separate_ue")).replace(File.separator, "/").trim();
	    }
		 response.setCharacterEncoding("utf-8");
		response.getWriter().print(imgStr);
	}
	
	@SuppressWarnings("unchecked")
	public List getFiles(String realpath, List files) {
		
		File realFile = new File(realpath);
		if (realFile.isDirectory()) {
			File[] subfiles = realFile.listFiles();
			for(File file :subfiles ){
				if(file.isDirectory()){
					getFiles(file.getAbsolutePath(),files);
				}else{
					if(!getFileType(file.getName()).equals("")) {
						files.add(file);
					}
				}
			}
		}
		return files;
	}

	public String getRealPath(HttpServletRequest request,String path){
		ServletContext application = request.getSession().getServletContext();
		String str = application.getRealPath(request.getServletPath());
		return new File(str).getParent();
	}

	public String getFileType(String fileName){
		String[] fileType = {".gif" , ".png" , ".jpg" , ".jpeg" , ".bmp"};
		Iterator<String> type = Arrays.asList(fileType).iterator();
		while(type.hasNext()){
			String t = type.next();
			if(fileName.endsWith(t)){
				return t;
			}
		}
		return "";
	}
}
