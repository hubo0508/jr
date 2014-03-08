package com.jr.client.news.service;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.core.IService;
import com.jr.core.Page;
import com.jr.core.Results;

@Service("newsCliService")
public class NewsCliService extends IService {

	protected static Log logger = LogFactory.getLog(NewsCliService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 列表查询新闻
	 */
	public Results list(Page page) {
		String sql = "select id,title,date_format(publish_time,'%Y-%m-%d') as publish_time,image_url,content from news order by publish_time desc";
		return super.list(page, null, sql);
	}
	
	/**
	 * 查询新闻详情
	 */
	public Map<String, Object> queryNewsInfo(Integer id) {
		String sql = "select id,count,title,date_format(publish_time,'%Y-%m-%d') as publish_time,image_url,content from news where id = ?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}
	
	/**
	 * 更新点击次数
	 */
	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results updateCount(int id) {
		String sql = "UPDATE news SET count=? WHERE id=?";
		int i = jdbcTemplate.update(sql, new Object[] { queryCount(id) + 1,id });
		if (i == 1) {
			return Results.SUCCESS;
		}
		return Results.FAILURE;
	}
	
	/**
	 * 查询点击次数
	 */
	public int queryCount(int id) {
		String sql = "select count from news where id=?";
		return jdbcTemplate.queryForInt(sql, new Object[] { id });
	}
}
