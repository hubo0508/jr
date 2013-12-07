package com.jr.platform.product.service;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.core.Results;

@Service("productCategoryService")
public class ProductCategoryService {

	protected static Log logger = LogFactory
			.getLog(ProductCategoryService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Results list() {

		String sql = "SELECT id,product_use, product_use_desc FROM device_type WHERE product_use IS NOT null ORDER BY id DESC";
		return new Results(jdbcTemplate.queryForList(sql));
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results deleteByIds(final int[] ids) {

		String sql = "DELETE FROM device_type WHERE id = ?";

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
	public Results save(final String product_use,
			final String product_use_desc, final String id) {

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO device_type(product_use,product_use_desc) VALUES (?,?)";
			int i = jdbcTemplate.update(sql, new PreparedStatementSetter() {
				public void setValues(PreparedStatement ps) throws SQLException {
					ps.setString(1, product_use);
					ps.setString(2, product_use_desc);
				}
			});

			if (i == 1) {
				return Results.SUCCESS;
			}
			
			throw new RuntimeException();
			
		} else {
			String sql = "UPDATE device_type SET product_use=?, product_use_desc=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new PreparedStatementSetter() {
				public void setValues(PreparedStatement ps) throws SQLException {
					ps.setString(1, product_use);
					ps.setString(2, product_use_desc);
					ps.setInt(3, Integer.parseInt(id));
				}
			});

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

	public Map<String, Object> findById(int id) {
		String sql = "SELECT id,product_use,product_use_desc FROM device_type WHERE id=?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}
}
