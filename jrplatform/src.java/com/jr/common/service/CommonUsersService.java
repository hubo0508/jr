package com.jr.common.service;

import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.client.news.service.NewsCliService;

/**
 * 通用用户服务
 */
@Service("commonUsersService")
public class CommonUsersService {

	protected Log log = LogFactory.getLog(NewsCliService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	/**
	 * 存储用户登录日志
	 */
	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public void updateUserLog(String username) {
		try {

			if (StringUtils.isEmpty(username)) {
				log.error("用户名为空，无法更新用户登录日志！");
				return;
			}

			int count = queryLoginCount(username);
			String sql = "UPDATE users SET login_count=?, last_login_time=? WHERE username=?";
			jdbcTemplate.update(sql, new Object[] { (count + 1), new Date(),
					username });
		} catch (Throwable e) {
			log.error("用户『" + username + "』登录日志更新失败！", e);
		}
	}

	/**
	 * 查询登录次数
	 */
	public int queryLoginCount(String username) {
		String sql = "select login_count from users where username=?";
		return jdbcTemplate.queryForInt(sql, new Object[] { username });
	}
}
