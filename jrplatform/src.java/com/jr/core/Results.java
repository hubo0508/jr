package com.jr.core;

import java.util.List;

/**
 * @User: HUBO
 * @Date Sep 24, 2013
 * @Time 1:57:12 PM
 */
public class Results {

	public final static String BUSY = "服务器繁忙，请稍后再试！";
	
	public final static String SAVEERROR = "保存失败，请稍后再试！";
	
	public final static String DELETEERROR = "删除失败，请稍后再试！";
	
	public static Results SUCCESS = new Results(true);
	public static Results FAILURE = new Results(false);
	public final static String SUCCESSSTR = "SUCCESS";
	public final static String FAILURESTR = "FAILURE";

	/**
	 * 通信数据Object对象 对应Flex <code>Object</code>
	 */
	private Object object;

	/**
	 * 通信数据状态
	 */
	private boolean success;

	/**
	 * 消息提示
	 */
	private String message;

	/**
	 * 分页对象：共多少页面
	 */
	private long totalSize;

	/**
	 * 分页对象：当前为第几页
	 */
	private int thisPage;
	
	private int pageSize;

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public Results(Object object) {
		super();
		this.object = object;
		this.success = true;
	}

	public Results(boolean success) {
		super();
		this.success = success;
	}

	public Results(boolean success, String message) {
		super();
		this.success = success;
		this.message = message;
	}


	public Results(List<?> result, Long totalCount, int startPage, int pageSize) {
		this.success = true;
		this.object = result;
		this.totalSize = totalCount;
		this.thisPage = startPage;
		this.pageSize = pageSize;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public long getTotalSize() {
		return totalSize;
	}

	public void setTotalSize(long totalSize) {
		this.totalSize = totalSize;
	}

	public int getThisPage() {
		return thisPage;
	}

	public void setThisPage(int thisPage) {
		this.thisPage = thisPage;
	}

	public Object getObject() {
		return object;
	}

	public void setObject(Object object) {
		this.object = object;
	}

}
