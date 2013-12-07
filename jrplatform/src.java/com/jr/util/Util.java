package com.jr.util;

public class Util {

	public static int[] idsToArray(String ids) {
		String[] idsarr = ids.split(",");
		int[] idsint = new int[idsarr.length];
		for (int i = 0; i < idsarr.length; i++) {
			idsint[i] = Integer.parseInt(idsarr[i]);
		}

		return idsint;
	}
	
}
