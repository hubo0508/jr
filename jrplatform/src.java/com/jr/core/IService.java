package com.jr.core;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import org.db.jdbcutils.JdbcUtils;
import org.db.jdbcutils.sql.SqlStatement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;

public class IService {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public Results delete(String tablename, final int id) {
		String sql = "DELETE FROM " + tablename + " WHERE id = ?";
		jdbcTemplate.update(sql, new Object[]{id});
		return Results.SUCCESS;
	}

	public Results delete(String tablename, final int[] ids) {

		String sql = "DELETE FROM " + tablename + " WHERE id = ?";

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

	public Results list(Page page, List<Object> setparams, String sql) {

		SqlStatement stat = new SqlStatement();
		String countSql = stat.count(sql);
		sql = stat.paging(sql, JdbcUtils.MYSQL);

		int s = page.getStartToDatabase(JdbcUtils.MYSQL);
		int e = page.getPageSize();

		long totalCount = 0;
		List<?> result = null;
		if (setparams != null && setparams.size() > 0) {
			totalCount = jdbcTemplate.queryForLong(countSql, setparams
					.toArray());

			setparams.add(s);
			setparams.add(e);
			result = jdbcTemplate.queryForList(sql, setparams.toArray());
		} else {
			totalCount = jdbcTemplate.queryForLong(countSql);
			result = jdbcTemplate.queryForList(sql, new Object[] { s, e });
		}

		return new Results(result, totalCount, page.getStartPage(), page
				.getPageSize());
	}
	
	public Results list(Page page, List<Object> setparams, String sql, String countSql) {

		SqlStatement stat = new SqlStatement();
		sql = stat.paging(sql, JdbcUtils.MYSQL);

		int s = page.getStartToDatabase(JdbcUtils.MYSQL);
		int e = page.getPageSize();

		long totalCount = 0;
		List<?> result = null;
		if (setparams != null && setparams.size() > 0) {
			totalCount = jdbcTemplate.queryForLong(countSql, setparams
					.toArray());

			setparams.add(s);
			setparams.add(e);
			result = jdbcTemplate.queryForList(sql, setparams.toArray());
		} else {
			totalCount = jdbcTemplate.queryForLong(countSql);
			result = jdbcTemplate.queryForList(sql, new Object[] { s, e });
		}

		return new Results(result, totalCount, page.getStartPage(), page
				.getPageSize());
	}

}
