package com.jr.platform.about.service;

import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.core.Results;

@Service("aboutDescService")
public class AboutDescService {

	protected static Log logger = LogFactory.getLog(AboutDescService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 查询用户协议
	 */
	public Map<String, Object> findToProtocold() {
		String sql = "SELECT protocold,id FROM about";
		return jdbcTemplate.queryForMap(sql);
	}
	
	/**
	 * 保存用户协议
	 */
	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results saveToProtocold(final String protocold, final String id) {

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO about(protocold) VALUES (?)";
			int i = jdbcTemplate.update(sql, new Object[] { protocold });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE about SET protocold=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] { protocold,
					Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

	public Map<String, Object> find() {
		String sql = "SELECT company_description,id FROM about";
		return jdbcTemplate.queryForMap(sql);
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(final String company_description, final String id) {

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO about(company_description) VALUES (?)";
			int i = jdbcTemplate.update(sql,
					new Object[] { company_description });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE about SET company_description=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] {
					company_description, Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

}
