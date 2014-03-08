package com.jr.platform.product.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.core.IService;
import com.jr.core.Results;

@Service("productCategoryService")
public class ProductCategoryService extends IService {

	protected static Log logger = LogFactory
			.getLog(ProductCategoryService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Results list() {
		String sql = "SELECT id,product_use, product_use_desc FROM device_type WHERE product_use IS NOT null ORDER BY id DESC";
		return new Results(jdbcTemplate.queryForList(sql));
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results delete(final int[] ids) {
		return super.delete("device_type", ids);
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public int save(final String product_use, final String product_use_desc) {

		final String sql = "INSERT INTO device_type(product_use,product_use_desc) VALUES (?,?)";
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection conn)
					throws SQLException {
				PreparedStatement statement = conn.prepareStatement(sql,
						Statement.RETURN_GENERATED_KEYS);
				statement.setString(1, product_use);
				statement.setString(2, product_use_desc);
				return statement;
			}
		}, keyHolder);
		return keyHolder.getKey().intValue();
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(final String product_use,
			final String product_use_desc, final String id)
			throws DuplicateKeyException {

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

	public Map<String, Object> findByProductUse(String productUse) {
		try {
			String sql = "SELECT id,product_use,product_use_desc FROM device_type WHERE product_use= ?";
			return jdbcTemplate.queryForMap(sql, new Object[] { productUse });
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
}
