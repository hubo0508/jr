package com.jr.platform.product.service;

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

@Service("productPageService")
public class ProductPageService {

	protected static Log logger = LogFactory.getLog(ProductPageService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(final String id, final String description) {

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO product_page(description) VALUES (?)";
			int i = jdbcTemplate.update(sql, new Object[] { description });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE product_page SET description=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] { description,
					Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

	public Map<String, Object> find() {
		String sql = "SELECT id,description FROM product_page";
		return jdbcTemplate.queryForMap(sql);
	}
}
