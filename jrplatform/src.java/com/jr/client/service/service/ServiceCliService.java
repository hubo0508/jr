package com.jr.client.service.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.jr.core.IService;
import com.jr.core.Results;

@Service("serviceCliService")
public class ServiceCliService extends IService {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Results queryDescription() {
		String sql = "select pledge,ranges,mode,nav_image_url from repair_service";
		return new Results(jdbcTemplate.queryForList(sql).get(0));
	}

	/**
	 * 查询维修设备种类
	 */
	public Results queryMaintenanceCategory() {
		String sql = "select title,content from maintenance_category";
		return new Results(jdbcTemplate.queryForList(sql));
	}
	
	/**
	 * 查询维修单
	 */
	public Results queryMaintenanceReportCard() {
		String sql = "select file_name,file_url,file_desc from maintenance_report_card";
		return new Results(jdbcTemplate.queryForList(sql));
	}
}
