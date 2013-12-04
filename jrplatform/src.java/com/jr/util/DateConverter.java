package com.jr.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.Date;

/**
 * 
 * 日期转换对象s
 */
public class DateConverter {
	/**
	 * 日期格式化对象.
	 */
	private static SimpleDateFormat df = new SimpleDateFormat();

	/**
	 * 日期对象转成字符串
	 * 
	 * @param value
	 * @param format
	 * @return
	 */
	public static String convert(Date value, String format) {
		String strDate = "";
		if (value == null) {
			return null;
		} else if ((value instanceof Date) && format != null
				&& !format.equals("")) {
			df.applyPattern(format);
			strDate = df.format(value);
		}
		return strDate;
	}

	/**
	 * 字符串对象转成时间
	 * 
	 * @param value
	 * @param format
	 * @return
	 */
	public static Date parse(String value, String format) {
		Date date = null;
		if (value == null) {
			return null;
		} else if ((value instanceof String) && format != null
				&& !format.equals("")) {
			df.applyPattern(format);
			try {
				date = df.parse(value);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return date;
	}

	// public static void main(String[] args){
	//		
	// String strDate = "2009-11-15 13:22";
	// Date date = parse(strDate,"yyyy-mm-dd HH:mm");
	// System.out.println(date.toString());
	// }
}