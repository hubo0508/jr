/**
 * 
 */
package com.jr.client.product.service;


import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service("productPageCliService")
public class ProductPageCliService {

	protected static Log logger = LogFactory.getLog(ProductPageCliService.class);
	@Autowired
	private JdbcTemplate jdbcTemplate;
	public Map<String, Object> find() {
		String sql = "SELECT id,description FROM product_page";
		return jdbcTemplate.queryForMap(sql);
	}
}
