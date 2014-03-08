package com.jr.platform.news.service;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.core.IService;
import com.jr.core.Page;
import com.jr.core.Results;
import com.jr.util.Json;

@Service("newsService")
public class NewsService extends IService {

	protected static Log logger = LogFactory.getLog(NewsService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public String delete(final int[] ids) {

		String sql = "DELETE FROM news WHERE id = ?";

		jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
			public void setValues(PreparedStatement ps, int i)
					throws SQLException {
				ps.setInt(1, ids[i]);
			}

			public int getBatchSize() {
				return ids.length;
			}
		});

		return Json.oJson(true);
	}

	public Map<String, Object> findById(int id) {
		String sql = "SELECT id,title, content,publish_time, image_url FROM news WHERE id=?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}

	public Results list(Page page, String title, String sTime, String eTime) {
		StringBuffer sb = new StringBuffer(10);
		sb
				.append("SELECT id,title,content,date_format(publish_time,'%Y-%m-%d') as publish_time  FROM news ");
		sb.append("WHERE 1=1 ");

		List<Object> setparams = new ArrayList<Object>();
		if (StringUtils.isNotEmpty(title)) {
			sb.append(" AND title like ?");
			setparams.add("%" + title + "%");
		}
		if (StringUtils.isNotEmpty(sTime) && StringUtils.isNotEmpty(eTime)) {
			sb.append(" AND publish_time >= ? AND publish_time <= ?");
			setparams.add(sTime);
			setparams.add(eTime);
		} else {
			if (StringUtils.isNotEmpty(sTime)) {
				sb.append(" AND publish_time >= ?");
				setparams.add(sTime);
			}
			if (StringUtils.isNotEmpty(eTime)) {
				sb.append(" AND publish_time <= ?");
				setparams.add(eTime);
			}
		}
		sb.append(" ORDER BY publish_time DESC");

		return super.list(page, setparams, sb.toString());
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(String id, String title, String content,
			String image_url) {
		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO news(title, content,image_url,publish_time,count) VALUES (?,?,?,?,?)";
			int i = jdbcTemplate.update(sql, new Object[] { title, content,
					image_url, new Date(),0 });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE news SET title=?, content=?,image_url=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] { title, content,
					image_url, Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

}
