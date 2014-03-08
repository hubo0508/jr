package com.jr.platform.system.service;

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

import com.jr.core.IService;
import com.jr.core.Results;

@Service("roleService")
public class RoleService extends IService {

	protected static Log logger = LogFactory.getLog(RoleService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Results authorizeRoleList() {
		String sql = "  select r.rolename,r.id as rid from role r left join role_menu rm on r.id = rm.role_id "
				+ "left join sys_menu sm on sm.id = rm.menu_id  where sm.name is not null and sm.parent_id is not null group by r.rolename";
		return new Results(jdbcTemplate.queryForList(sql));
	}

	public Results listBy(final int type) {
		String sql = "SELECT id,rolename, roleremark, roletype,video_play FROM role WHERE roletype =? ORDER BY roletype DESC";
		return new Results(jdbcTemplate
				.queryForList(sql, new Object[] { type }));
	}

	public Results list() {
		String sql = "SELECT id,rolename, roleremark, roletype FROM role ORDER BY roletype DESC";
		return new Results(jdbcTemplate.queryForList(sql));
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(final String rolename, final String roleremark,
			final String roletype, final String id) {

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO role(rolename,roleremark,roletype) VALUES (?,?,?)";
			int i = jdbcTemplate.update(sql, new Object[] { rolename,
					roleremark, Integer.parseInt(roletype) });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE role SET rolename=?, roleremark=?, roletype=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] { rolename,
					roleremark, Integer.parseInt(roletype),
					Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

	public Results updateByVideoplay(int video_play, int role_id) {
		String sql = "UPDATE role SET video_play=? WHERE id=?";
		int i = jdbcTemplate.update(sql, new Object[] { video_play, role_id });

		if (i == 1) {
			return Results.SUCCESS;
		}

		throw new RuntimeException();
	}

	public Map<String, Object> findById(int id) {
		String sql = "SELECT id,rolename,roleremark,roletype FROM role WHERE id=?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}

	/**
	 * role_admin = 0 超级管理员，不能进行删除。
	 */
	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results delete(final int[] ids) {
		String sql = "DELETE FROM role WHERE id = ? AND role_admin != 0";

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
}
