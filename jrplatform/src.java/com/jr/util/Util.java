package com.jr.util;

import java.io.File;
import java.util.Random;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class Util {

	static Log log = LogFactory.getLog(Util.class);
	
	public static String randomPassword(){
		String password = "";
		for (int i = 0; i < 6; i++) {
			String rand = Util.getRandomChar();
			password = password.concat(rand);
		}
		
		return password;
	}
	
	/**
	 * 随机生成字符，含大写、小写、数字 <b>
	 * 
	 * @return
	 */
	public static String getRandomChar() {
		// 生成随机类
		Random random = new Random();
		String codeList = "ABCDEFGHIJKLMNPQRSTUVWXYZ123456789";
		int a = random.nextInt(codeList.length() - 1);
		return codeList.substring(a, a + 1);
	}

	public static String clearHtml(String html) {
		String regEx = "<.+?>"; // 表示标签
		Pattern p = Pattern.compile(regEx);
		return p.matcher(html).replaceAll("");
	}

	public static int[] idsToArray(String ids) {
		String[] idsarr = ids.split(",");
		int[] idsint = new int[idsarr.length];
		for (int i = 0; i < idsarr.length; i++) {
			idsint[i] = Integer.parseInt(idsarr[i]);
		}

		return idsint;
	}

	public static String toFile(String value) {
		if (StringUtils.isNotEmpty(value)
				&& (value.endsWith(".swf") || value.endsWith(".flv")
						|| value.endsWith(".jpg") || value.endsWith(".gif"))) {
			return value.substring(0, value.lastIndexOf("."));
		}
		return value;
	}

	public static void main(String[] args) {
//		System.out.println("0:"+(0%2));
//		System.out.println("1:"+(1%2));
//		System.out.println("2:"+(2%2));
//		System.out.println("3:"+(3%2));
//		System.out.println("4:"+(4%2));
//		System.out.println("5:"+(5%2));
//		System.out.println("6:"+(6%2));
//		System.out.println("7:"+(7%2));
//		System.out.println("8:"+(8%2));
	}

	public static String toFileType(String value) {

		if (StringUtils.isEmpty(value)) {
			return value;
		}

		if (value.endsWith(".swf")) {
			return ".swf";
		}
		if (value.endsWith(".flv")) {
			return ".flv";
		}
		if (value.endsWith(".jpg")) {
			return ".jpg";
		}
		if (value.endsWith(".gif")) {
			return ".gif";
		}

		return value.substring(value.lastIndexOf("."), value.length());
	}

	public static void deleteFile(String fileDir, String historyfile) {
		try {
			File fileTemp = new File(fileDir + historyfile);
			if (fileTemp.exists()) {
				fileTemp.delete();
			}
		} catch (RuntimeException e) {
			log.error(e);
		}
	}
}
