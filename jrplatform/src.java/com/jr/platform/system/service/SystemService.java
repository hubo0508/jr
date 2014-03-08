package com.jr.platform.system.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service("systemService")
public class SystemService {

	final Log log = LogFactory.getLog(SystemService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<Map<String, Object>> queryFirstMenu(Object userid) {
		String sql = "select u.username,r.rolename, sm.name as text,  sm.id "
				+ "from users  u left join role r on u.role_id = r.id left join role_menu rm on r.id = rm.role_id left join sys_menu sm on rm.menu_id = sm.id "
				+ "where (sm.parent_id is null or sm.parent_id = \"\") and u.id=? and u.user_type=0 and sm.show_mark=0 "
				+ "order by sm.menu_sort";

		return this.jdbcTemplate.queryForList(sql, new Object[] { userid });
	}

	public List<Map<String, Object>> querySubMenu(Object userid,
			Object parent_id) {
		String sql = "select rm.rw,u.username,r.rolename, sm.name as text,sm.id, sm.url as href "
				+ "from users  u left join role r on u.role_id = r.id left join role_menu rm on r.id = rm.role_id left join sys_menu sm on rm.menu_id = sm.id "
				+ "where u.id=? and sm.parent_id = ? and u.user_type=0 and sm.show_mark=0 order by sm.menu_sort";
		return this.jdbcTemplate.queryForList(sql, new Object[] { userid,
				parent_id });
	}
}
