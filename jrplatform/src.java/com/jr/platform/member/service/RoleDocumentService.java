package com.jr.platform.member.service;

import java.sql.PreparedStatement;
import java.sql.SQLException;

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
import com.jr.platform.system.service.RoleService;

@Service("roleDocumentService")
public class RoleDocumentService extends IService {

	protected static Log logger = LogFactory.getLog(RoleDocumentService.class);

	@Autowired
	private RoleService roleService;

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Results roleDocumentIdList(String id) {
		String sql = "select document_type_id,video_play From role_documenttype rd left join role r on r.id = rd.role_id where role_id = ?";
		return new Results(jdbcTemplate.queryForList(sql, Integer.parseInt(id)));
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(final String video_play, final String role_id,
			final int[] menu_ids) {

		this.deleteByRoleid(Integer.parseInt(role_id));

		this.roleService.updateByVideoplay(Integer.parseInt(video_play),
				Integer.parseInt(role_id));

		if (menu_ids != null) {
			String insertSql = "INSERT INTO role_documenttype(role_id, document_type_id) VALUES (?,?)";

			jdbcTemplate.batchUpdate(insertSql,
					new BatchPreparedStatementSetter() {
						public void setValues(PreparedStatement ps, int i)
								throws SQLException {
							ps.setInt(1, Integer.parseInt(role_id));
							ps.setInt(2, menu_ids[i]);
						}

						public int getBatchSize() {
							return menu_ids.length;
						}
					});
		}

		return Results.SUCCESS;
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results deleteByRoleid(int role_id) {
		String deleteSql = "DELETE FROM role_documenttype WHERE role_id = ?";
		jdbcTemplate.update(deleteSql, new Object[] { role_id });
		return Results.SUCCESS;
	}
}
