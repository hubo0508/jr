package com.jr.core;

import org.db.jdbcutils.JdbcUtils;

/**
 * 分页参数类
 * 
 * @User: HUBO
 * @Date Apr 02, 2012
 * @Time 4:39:42 PM
 */
public class Page {

	/**
	 * 每页显示行数
	 */
	private int pageSize = 20;

	/**
	 * 起启页
	 */
	private int startPage;

	/**
	 * 当前页
	 */
	private int thisPage = 0;

	/**
	 * 总页数
	 */
	private long totalPage;

	/**
	 * 总记录数
	 */
	private long totalCount;

	/** ************************************************************************ */

	/**
	 * 首頁
	 */
	private int pageFirst = 1;

	/**
	 * 上一頁
	 */
	private int pagePrev;

	/**
	 * 下一頁
	 */
	private int pageNext;

	/**
	 * 末頁
	 */
	private int pageLast;

	/** ************************************************************************ */

	// 返回结果 //
	private Object result = new Object();

	/**
	 * @param startPage 起启页
	 * @param pageSize
	 *            每页显示行数
	 * 
	 */
	public Page(int startPage, int pageSize) {
		super();
		this.pageSize = pageSize;
		this.startPage = startPage;
	}

	/**
	 * @param startPage 起启页
	 */
	public Page(int startPage) {
		super();
		this.startPage = startPage;
	}
	
	public Page() {
		super();
	}

	/**
	 * @param pageSize
	 *            每显显示记录数
	 * @param totalCount
	 *            总记录数
	 * @param result
	 *            查询结果
	 */
	public Page(long totalCount, int thisPage, int pageSize, Object result) {
		this.totalCount = totalCount;
		this.result = result;
		this.thisPage = thisPage;
		this.pageSize = pageSize;
		this.totalPage = this.getTotalPages();// 共多少页

		this.setPagePrev(thisPage > 1 ? thisPage - 1 : thisPage);
		this.setPageNext(thisPage < totalPage ? thisPage + 1 : thisPage);
		this.setPageLast(Integer.parseInt((totalPage + "")));
	}

	public int getStartToDatabase(String database) {
		if (JdbcUtils.MYSQL.equals(database)) {
			int starts = (startPage - 1) * pageSize;
			return starts == 0 ? 0 : starts;
		} else if (JdbcUtils.SQLSERVER.equals(database)) {

		} else if (JdbcUtils.ORACLE.equals(database)) {
			int starts = (startPage - 1) * pageSize;
			return starts == 0 ? 1 : starts + 1;
		}
		return 0;
	}

	public int getEndToDatabase(String database) {
		if (JdbcUtils.MYSQL.equals(database)) {
			return pageSize;
		} else if (JdbcUtils.SQLSERVER.equals(database)) {

		} else if (JdbcUtils.ORACLE.equals(database)) {
			return startPage * pageSize;
		}
		return 0;
	}

	/**
	 * 根据pageSize与totalCount计算总页数, 默认值为-1.
	 */
	private long getTotalPages() {
		if (totalCount < 0)
			return -1;

		long count = totalCount / pageSize;
		if (totalCount % pageSize > 0) {
			count++;
		}
		return count;
	}

	public long getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(long totalPage) {
		this.totalPage = totalPage;
	}

	public long getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(long totalCount) {
		this.totalCount = totalCount;
	}

	/**
	 * 首頁
	 */
	public int getPageFirst() {
		return pageFirst;
	}

	public void setPageFirst(int pageFirst) {
		this.pageFirst = pageFirst;
	}

	/**
	 * 上一頁
	 */
	public int getPagePrev() {
		return pagePrev;
	}

	public void setPagePrev(int pagePrev) {
		this.pagePrev = pagePrev;
	}

	/**
	 * 下一頁
	 */
	public int getPageNext() {
		return pageNext;
	}

	public void setPageNext(int pageNext) {
		this.pageNext = pageNext;
	}

	/**
	 * 尾頁
	 */
	public int getPageLast() {
		return pageLast;
	}

	public void setPageLast(int pageLast) {
		this.pageLast = pageLast;
	}

	/**
	 * 结果集
	 */
	public Object getResult() {
		return result;
	}

	public void setResult(Object result) {
		this.result = result;
	}

	/**
	 * 当前页
	 */
	public int getThisPage() {
		return thisPage;
	}

	public void setThisPage(int thisPage) {
		this.thisPage = thisPage;
	}

	/**
	 * 每页显示行数
	 */
	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * 开始页
	 */
	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
}