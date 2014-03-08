package com.jr.platform.system.service;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.core.Constants;
import com.jr.core.IService;
import com.jr.core.Page;
import com.jr.core.Results;

@Service("roleMenuService")
public class RoleMenuService extends IService {

	protected static Log logger = LogFactory.getLog(RoleService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Results rolerwList(Page page, String role_id, String rw) {
		StringBuffer sb = new StringBuffer(10);
		sb
				.append("select rr.id,rr.rid, rr.rolename,rr.roletype,rr.roleremark,rr.rw,rr.name,sp.name as topm from( ");
		sb
				.append("select rm.id, r.rolename,r.id as rid,r.roletype,r.roleremark,rm.rw,sm.name,sm.parent_id from role r left join role_menu rm on r.id = rm.role_id ");
		sb
				.append("left join sys_menu sm on sm.id = rm.menu_id  where sm.name is not null and sm.parent_id is not null and sm.parent_id != \"\"");
		sb
				.append(") rr left join sys_menu sp on rr.parent_id = sp.id Where 1=1 ");

		StringBuffer countsql = new StringBuffer(10);
		countsql.append("select count(rr.id) from( ");
		countsql
				.append("select rm.id, r.rolename,r.id as rid,r.roletype,r.roleremark,rm.rw,sm.name,sm.parent_id from role r left join role_menu rm on r.id = rm.role_id ");
		countsql
				.append("left join sys_menu sm on sm.id = rm.menu_id  where sm.name is not null and sm.parent_id is not null and sm.parent_id != \"\"");
		countsql
				.append(") rr left join sys_menu sp on rr.parent_id = sp.id Where 1=1 ");
		
		List<Object> setparams = new ArrayList<Object>();
		if (!"null".equals(role_id) && !"-1".equals(role_id)
				&& StringUtils.isNotEmpty(role_id)) {
			countsql.append(" AND rr.rid = ?");
			sb.append(" AND rr.rid = ?");
			setparams.add(Integer.parseInt(role_id));
		}
		if (!"null".equals(role_id) && !"-1".equals(rw)
				&& StringUtils.isNotEmpty(rw)) {
			countsql.append(" AND rr.rw = ?");
			sb.append(" AND rr.rw = ?");
			setparams.add(rw);
		}

		return super.list(page, setparams, sb.toString(), countsql.toString());
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results saverw(final int ids[], final String rw) {

		String sql = "UPDATE role_menu SET rw=? WHERE id=?";

		jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
			public void setValues(PreparedStatement ps, int i)
					throws SQLException {
				ps.setString(1, rw);
				ps.setInt(2, ids[i]);
			}

			public int getBatchSize() {
				return ids.length;
			}
		});

		return Results.SUCCESS;
	}

	public Results rolemenuIdList(String id) {
		String sql = "select menu_id From role_menu where role_id = ?";
		return new Results(jdbcTemplate.queryForList(sql, Integer.parseInt(id)));
	}

	public Results menuList() {
		String sql = "select id,if(parent_id is null,0,parent_id) as pId, name From sys_menu where name != '/'";
		return new Results(jdbcTemplate.queryForList(sql));
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(final String role_id, final int[] menu_ids) {

		this.deleteByRoleid(Integer.parseInt(role_id));

		if (menu_ids != null) {
			String insertSql = "INSERT INTO role_menu(role_id, menu_id,rw) VALUES (?,?,?)";

			jdbcTemplate.batchUpdate(insertSql,
					new BatchPreparedStatementSetter() {
						public void setValues(PreparedStatement ps, int i)
								throws SQLException {
							ps.setInt(1, Integer.parseInt(role_id));
							ps.setInt(2, menu_ids[i]);
							ps.setString(3, Constants.R);
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
		String deleteSql = "DELETE FROM role_menu WHERE role_id = ?";
		jdbcTemplate.update(deleteSql, new Object[] { role_id });
		return Results.SUCCESS;
	}
}
