package com.jr.util;

import java.io.UnsupportedEncodingException;

public class Charset {

	public Charset() {
	}

	public static String toUTF(String keyword) {
		try {
			return new String(keyword.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			return keyword;
		}
	}

	public static String TranEncodeTOGB(String str) {
		try {
			System.out.println(new String(str.getBytes("GBK"), "UTF-8"));

			System.out.println(new String(str.getBytes("UTF-8"), "GBK"));
			System.out.println(new String(str.getBytes("ISO-8859-1"), "UTF-8"));
			System.out.println(new String(str.getBytes("ISO-8859-1"), "GBK"));
			System.out
					.println(new String(str.getBytes("ISO-8859-1"), "GB2312"));
			// String strEncode = Charset.getEncoding(str);
			String temp = new String(str.getBytes("ISO-8859-1"), "GB2312");
			return temp;
		} catch (java.io.IOException ex) {

			return null;
		}
	}

	public static boolean isGB2312(char c) {
		Character ch = new Character(c);
		String sCh = ch.toString();
		try {
			byte[] bb = sCh.getBytes("gb2312");
			if (bb.length > 1) {
				return true;
			}
		} catch (java.io.UnsupportedEncodingException ex) {
			return false;
		}
		return false;
	}

	public static String getEncoding(String str) {
		String encode = "GB2312";
		try {
			if (str.equals(new String(str.getBytes(encode), encode))) {
				String s = encode;
				return s;
			}
		} catch (Exception exception) {
		}
		encode = "ISO-8859-1";
		try {
			if (str.equals(new String(str.getBytes(encode), encode))) {
				String s1 = encode;
				return s1;
			}
		} catch (Exception exception1) {
		}
		encode = "UTF-8";
		try {
			if (str.equals(new String(str.getBytes(encode), encode))) {
				String s2 = encode;
				return s2;
			}
		} catch (Exception exception2) {
		}
		encode = "GBK";
		try {
			if (str.equals(new String(str.getBytes(encode), encode))) {
				String s3 = encode;
				return s3;
			}
		} catch (Exception exception3) {
		}
		return "";
	}

	public static void main(String[] args) {
		String str = "徐希";

		System.out.println(Charset.getEncoding(str));
	}
}
