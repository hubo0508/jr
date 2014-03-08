package com.jr.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * <p>
 * 生成MD5加密
 * </p>
 * 
 * @User: HUBO
 * @Date 2011-10-16
 * @Time 下午8:37:07
 * 
 *       <p>
 *       Write a detailed description
 *       </p>
 */
public class SHAHelper {

	private static final Log log = LogFactory.getLog(SHAHelper.class);

	public static String convert(String password) {
		MessageDigest messageDigest;
		try {
			messageDigest = MessageDigest.getInstance("SHA-1");
			messageDigest.update(password.getBytes("UTF-8"));
			password = SHAHelper.byte2hex(messageDigest.digest());
		} catch (NoSuchAlgorithmException e) {
			log.error(e.getMessage(), e);
		} catch (UnsupportedEncodingException e) {
			log.error(e.getMessage(), e);
		}
		return password;
	}

	public static String byte2hex(byte[] b) {
		String hs = "";
		String stmp = "";
		for (int n = 0; n < b.length; n++) {
			stmp = (java.lang.Integer.toHexString(b[n] & 0xFF));
			if (stmp.length() == 1)
				hs = hs + "0" + stmp;
			else
				hs = hs + stmp;
		}
		return hs;
	}
	
	public static void main(String[] args) {
		System.out.println(SHAHelper.convert("hubo"));
		System.out.println(SHAHelper.convert("hubo"));
	}
}
