/**
 * 
 */
package com.jr.client.about.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.jr.core.IService;

@Service("aboutCliService")
public class AboutCliService extends IService {

	protected static Log logger = LogFactory.getLog(AboutCliService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	/**
	 * 公司简介
	 */
	public Map<String, Object> queryAboutDesc() {
		String sql = "SELECT company_description FROM about";
		return jdbcTemplate.queryForMap(sql);
	}
	
	/**
	 * 发展历程
	 */
	public List<Map<String, Object>> queryGrowingProcess() {
		String sql = "select year_date,month_date,stage_desc from growing_process order by year_date, month_date";
		return jdbcTemplate.queryForList(sql);
	}
	
	/**
	 * 金嵘团队
	 */
	public List<Map<String, Object>> queryCompanyTeam() {
		String sql = "select url,name,job_desc,job_info from company_team";
		return jdbcTemplate.queryForList(sql);
	}
	
	/**
	 * 公司规模/联系金嵘
	 */
	public List<Map<String, Object>> queryCompany() {
		String sql = "select cname,cimage_url,sales_qq,customer_qq,leasing_qq,complaints_qq,cfax,cphone,caddress_image_url,caddress  from company ";
		return jdbcTemplate.queryForList(sql);
	}
	
}
