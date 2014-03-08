package com.jr.client.lease.service;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.jr.core.IService;
import com.jr.core.Results;

@Service("leaseCliService")
public class LeaseCliService extends IService {

	protected static Log logger = LogFactory.getLog(LeaseCliService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	/**
	 * 查询租赁详情信息
	 */
	public Map<String, Object> queryLeaseInfo() {
		String sql = "select id,description,contract_name,contract_url,image_url from lease_page";
		return jdbcTemplate.queryForList(sql).get(0);
	}

	/**
	 * 租赁滚动产品查询
	 */
	public Results queryScrollProductToLease() {
		String sql = "select id,product_name,image_url from product where rental_scroll_mark = 1";
		return new Results(jdbcTemplate.queryForList(sql));
	}
}
