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

@Service("teamService")
public class TeamService {

	protected static Log logger = LogFactory.getLog(TeamService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Results list() {
		String sql = "SELECT url,id,custom_sort,name, job_desc,job_info FROM company_team ORDER BY custom_sort";
		return new Results(jdbcTemplate.queryForList(sql));
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results delete(final int[] ids) {

		String sql = "DELETE FROM company_team WHERE id = ?";

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
	public Results save(final String name, final String job_desc,
			final String job_info, final String custom_sort,final String url, final String id) {

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO company_team(url,name,job_desc,job_info,custom_sort) VALUES (?,?,?,?,?)";
			int i = jdbcTemplate.update(sql, new Object[] {url, name, job_desc,
					job_info,Integer.parseInt(custom_sort)});

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE company_team SET url=?, name=?,job_desc=?, job_info=?,custom_sort=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] {url, name, job_desc,
					job_info,Integer.parseInt(custom_sort),Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

	public Map<String, Object> findById(int id) {
		String sql = "SELECT id,custom_sort,name,job_desc,job_info FROM company_team WHERE id=?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}
}
