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

import com.jr.core.IService;
import com.jr.core.Results;

@Service("customerService")
public class CustomerService extends IService{

	protected static Log logger = LogFactory.getLog(CustomerService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Results list() {
		String sql = "SELECT id,customer_name,description,image_url FROM customer ORDER BY id desc";
		return new Results(jdbcTemplate.queryForList(sql));
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results delete(final int[] ids) {
		return super.delete("customer", ids);
	}

	public Map<String, Object> findById(int id) {
		String sql = "SELECT id,customer_name,description,image_url FROM customer WHERE id=?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(String customer_name, String description,
			String image_url, String id) {
		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO customer(customer_name,description,image_url) VALUES (?,?,?)";
			int i = jdbcTemplate.update(sql, new Object[] { customer_name,
					description, image_url });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE customer SET customer_name=?,description=?,image_url=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] { customer_name,
					description, image_url, Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}
}
