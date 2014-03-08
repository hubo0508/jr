package com.jr.platform.fitting.service;

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
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.core.Results;

@Service("fittingSpecialtyCategoryService")
public class FittingSpecialtyCategoryService {

	protected static Log logger = LogFactory
			.getLog(FittingSpecialtyCategoryService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Results queryList() {
		String sql = "SELECT id,fitting_category, fitting_category_desc FROM device_type WHERE fitting_category is not null ORDER BY id DESC";
		return new Results(jdbcTemplate.queryForList(sql));
	}

	/**
	 * <p>
	 * 配件归类分类
	 * </P>
	 * Date 2013-12-10 下午10:42:31
	 * 
	 * @param fitting_category
	 * @param fitting_category_desc
	 * @return
	 */
	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public int save(final String fitting_category,
			final String fitting_category_desc) {

		final String sql = "INSERT INTO device_type(fitting_category,fitting_category_desc) VALUES (?,?)";

		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection conn)
					throws SQLException {
				PreparedStatement ps = conn.prepareStatement(sql,
						Statement.RETURN_GENERATED_KEYS);
				ps.setString(1, fitting_category);
				ps.setString(2, fitting_category_desc);
				return ps;
			}
		}, keyHolder);
		return keyHolder.getKey().intValue();
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(final String fitting_category,
			final String fitting_category_desc, final String id)
			throws DuplicateKeyException {

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO device_type(fitting_category,fitting_category_desc) VALUES (?,?)";
			int i = jdbcTemplate.update(sql, new Object[] { fitting_category,
					fitting_category_desc });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE device_type SET fitting_category=?, fitting_category_desc=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] { fitting_category,
					fitting_category_desc, Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

	public Map<String, Object> findById(int id) {
		String sql = "SELECT id,fitting_category,fitting_category_desc FROM device_type WHERE id=?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}

	public Map<String, Object> findByFittingCategory(String fittingCategory) {
		try {
			String sql = "SELECT id,fitting_category,fitting_category_desc FROM device_type WHERE fitting_category=?";
			return jdbcTemplate.queryForMap(sql,
					new Object[] { fittingCategory });
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
}
