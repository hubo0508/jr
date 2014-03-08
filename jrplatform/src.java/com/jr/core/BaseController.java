package com.jr.core;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 
 * @ClassName: BaseController
 * @Description: 基本的Controller类，提供一些通用的HttpClient的方法
 * @author ZhuBin
 * @date Jul 18, 2013 2:28:39 PM
 * 
 */
public class BaseController {

	private static final Log logger = LogFactory.getLog(BaseController.class);
	protected static final int GET = 1;

	private HttpServletResponse response;

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	/*------------------------------------------AJAX--------------------------------------------------------------------------------*/

	/**
	 * 把单个对象的属性与值按json的数据格式输出
	 * 
	 * @param obj
	 *            pojo对象
	 */
	public void outJson(Object obj) {
		outJsonString(JSONObject.fromObject(obj).toString());
	}

	/**
	 * 把多个对象的集合按照json数据格式打印
	 * 
	 * @param array
	 */
	public void outJsonArray(Object array) {
		outJsonString(JSONArray.fromObject(array).toString());
	}

	/**
	 * 输出对象数组的json数据,如[{"code":"","descn":"","id":0,"cname":"name1"},{"code":"",
	 * "descn":"","id":0,"cname":"name2"}]
	 * 
	 * @param array
	 *            对象数组
	 * @param excludesProperties
	 *            不需要转换到json数据中的属性名称构成的数组 如String[]
	 *            {"roleses","departments","department"}
	 */
	public void outJsonArray(Object array, String[] excludesProperties) {
		JsonConfig jsonConfig = new JsonConfig();
		if (excludesProperties != null)
			jsonConfig.setExcludes(excludesProperties);
		outJsonString(JSONArray.fromObject(array, jsonConfig).toString());
	}

	/**
	 * 可以设置不需转换成json数据格式的属性
	 * 
	 * @param obj
	 *            单个对象或者多个对象的集合
	 * @param excludesProperties
	 *            不需要转换到json数据中的属性名称构成的数组 如String[]
	 *            {"roleses","departments","department"}
	 */
	public void outJsonWithoutProperty(Object obj, String[] excludesProperties) {
		JsonConfig jsonConfig = new JsonConfig();
		if (excludesProperties != null)
			jsonConfig.setExcludes(excludesProperties);
		outJsonString(JSONObject.fromObject(obj, jsonConfig).toString());
	}

	public void outString(String str) {
		try {
			System.err.println(str);
			PrintWriter out = getResponse().getWriter();
			out.write(str);
		} catch (IOException e) {
			logger.error(e);
		}
	}

	public void outJsonString(HttpServletResponse response,String str) {
		this.setResponse(response);
		getResponse().setContentType("application/json;charset=UTF-8");
		outString(str);
	}
	
	public void outJsonString(String str) {
		getResponse().setContentType("application/json;charset=UTF-8");
		outString(str);
	}

	public void outXMLString(String xmlStr) {
		getResponse().setContentType("application/xml;charset=UTF-8");
		outJsonString(xmlStr);
	}

	public static void main(String[] args) {

	}
}
