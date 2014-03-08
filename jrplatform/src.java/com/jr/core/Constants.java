package com.jr.core;

public class Constants {

	public static final String CUSER = "c_user";
	
	public static final String CUST_USER = "cust_user";

	public static final String CUST_USER_PRE = "cust_user_pre";
	
	/** 
	 * 1、内部员工
	 * <br/>
	 * 2、有权限播放视频
	 * 
	 * */
	public static final int INTERNAL = 0;

	/** 
	 * 
	 * 1、第三方 
	 * <br/>
	 * 2、无权限播放视频
	 * */
	public static final int THIRD_PARTY = 1;
	
	public static final int PENDING = 2;

	public static final String R = "r";

	public static final String W = "w";

	/**
	 * 用户状态：启用
	 */
	public static final int USER_ENABLE = 0;

	/**
	 * 用户状态：启用
	 */
	public static final int USER_FREEZE = 1;

	public static final String SESSION_EFFECTIVENESS_MESSAGE = "会话失效，请重新登录！";
	
	/**
	 * 文件上传失败，请稍后再试！
	 */
	public static final String FILEE_ERROR = "文件上传失败，请稍后再试！";
}
