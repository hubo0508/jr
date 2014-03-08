package com.jr.platform.about.service;

import java.sql.PreparedStatement;
import java.sql.SQLException;
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

import com.jr.core.Results;

@Service("growingProcessService")
public class GrowingProcessService {

	protected static Log logger = LogFactory
			.getLog(GrowingProcessService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Results list() {
		String sql = "SELECT id,year_date,month_date, stage_desc FROM growing_process ORDER BY year_date,month_date";
		return new Results(jdbcTemplate.queryForList(sql));
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results delete(final int[] ids) {

		String sql = "DELETE FROM growing_process WHERE id = ?";

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
	public Results save(final String year_date, final String month_date,
			final String stage_date_desc, final String id) {

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO growing_process(year_date,month_date,stage_desc) VALUES (?,?,?)";
			int i = jdbcTemplate.update(sql, new Object[] {
					Integer.parseInt(year_date), Integer.parseInt(month_date),
					stage_date_desc });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE growing_process SET year_date=?,month_date=?, stage_desc=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] {
					Integer.parseInt(year_date), Integer.parseInt(month_date),
					stage_date_desc, Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

	public Map<String, Object> findById(int id) {
		String sql = "SELECT id,year_date,month_date, stage_desc FROM growing_process WHERE id=?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}
}
