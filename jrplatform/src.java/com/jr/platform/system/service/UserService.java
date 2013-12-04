package com.jr.platform.system.service;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.jr.util.SHAHelper;

@Service("userService")
public class UserService {

	protected static Log logger = LogFactory.getLog(UserService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Map<String, Object> login(String username, String password) {

		final String sql = "SELECT u.username, u.user_type, u.status FROM users u WHERE u.username=? and u.password=?";

		Object[] params = new Object[] { username, SHAHelper.convert(password) };
		return jdbcTemplate.queryForMap(sql, params);
	}
}
