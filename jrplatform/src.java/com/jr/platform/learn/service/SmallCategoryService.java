package com.jr.platform.learn.service;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.core.Results;

@Service("smallCategoryService")
public class SmallCategoryService {

	protected static Log logger = LogFactory.getLog(SmallCategoryService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public Results treeList() {
		String sql = "SELECT id,small_category as name,0 as pId FROM document_type WHERE small_category IS NOT null ORDER BY id DESC";
		return new Results(jdbcTemplate.queryForList(sql));
	}

	public Results list() {
		String sql = "SELECT id,small_category, small_category_desc FROM document_type WHERE small_category IS NOT null ORDER BY id DESC";
		return new Results(jdbcTemplate.queryForList(sql));
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results delete(final int[] ids) {

		String sql = "DELETE FROM document_type WHERE id = ?";

		jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
			public void setValues(PreparedStatement ps, int i)
					throws SQLException {
				ps.setInt(1, ids[i]);
			}

			public int getBatchSize() {
				return ids.length;
			}
		});

		return Results.SUCCESS;
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(final String small_category,
			final String small_category_desc, final String id) throws DuplicateKeyException{

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO document_type(small_category,small_category_desc) VALUES (?,?)";
			int i = jdbcTemplate.update(sql, new Object[] { small_category,
					small_category_desc });
			
			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE document_type SET small_category=?, small_category_desc=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] { small_category,
					small_category_desc,Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

	public Map<String, Object> findById(int id) {
		String sql = "SELECT id,small_category,small_category_desc FROM document_type WHERE id=?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}
}
