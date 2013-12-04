package com.jr.util;

public class Json {
	/**
	 * 将JSON中数字值增加引号，使用转换成字符串。
	 * 
	 * </br></br>
	 * 
	 * 解决JSON转换成对象时，因值为数字而自动增加小数点。
	 * 
	 * @param josn
	 *            消息
	 * @return JSON
	 */
	public static String numberIntoString(String value) {
		return value.replaceAll("(\":)((\\d{1,}([.]\\d{1,}){1,})|(\\d){1,})",
				"$1\"$2\"");
	}

	public static String oJson(boolean success) {
		return oJson("", success);
	}

	/**
	 * 返回统一格式
	 * 
	 * @param msg
	 *            消息
	 * @return JSON
	 */
	public static String oJson(String msg, boolean success) {
		return "{\"message\":\"" + msg + "\",\"success\":\"" + success + "\"}";
	}
	
	public static String toJson(Object value){
		return GsonFactory.getGson().toJson(value);
	}
}
