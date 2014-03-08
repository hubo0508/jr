package com.jr.platform.service.service;

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
import com.jr.util.Util;

@Service("serviceService")
public class ServiceService extends IService {

	final Log logger = LogFactory.getLog(ServiceService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Map<String, Object> queryPledge() {
		String sql = "SELECT pledge,id FROM repair_service";
		return jdbcTemplate.queryForMap(sql);
	}

	public Map<String, Object> queryMode() {
		String sql = "SELECT mode,id FROM repair_service";
		return jdbcTemplate.queryForMap(sql);
	}

	public Map<String, Object> queryRange() {
		String sql = "SELECT ranges,id FROM repair_service";
		return jdbcTemplate.queryForMap(sql);
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(final String id, final String field, final String value) {

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO repair_service(" + field + ") VALUES (?)";
			int i = jdbcTemplate.update(sql, new Object[] { value });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE repair_service SET " + field + "=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] { value,
					Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

	public Map<String, Object> queryCateoryById(int id) {
		String sql = "SELECT id,title,content FROM maintenance_category WHERE id=?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}

	public Results categoryList() {
		String sql = "SELECT id,title, content FROM maintenance_category ORDER BY id DESC";
		return new Results(jdbcTemplate.queryForList(sql));
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results categorySave(String id, String title, String content) {
		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO maintenance_category(title,content) VALUES (?,?)";
			int i = jdbcTemplate.update(sql, new Object[] { title, content });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE maintenance_category SET title=?, content=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] { title, content,
					Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results categoryDeleteByIds(final int[] ids) {
		return super.delete("maintenance_category", ids);
	}

	public Map<String, Object> queryReportById(int id) {
		String sql = "SELECT id,file_name,file_url,file_desc FROM maintenance_report_card WHERE id=?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}

	public Results reportList() {
		String sql = "SELECT id,file_name,file_url,file_desc FROM maintenance_report_card ORDER BY id DESC";
		return new Results(jdbcTemplate.queryForList(sql));
	}

	/**
	 * 保存维修报告单
	 * 
	 * @param id
	 *            数据ID
	 * @param file_name
	 *            文件名称
	 * @param file_url
	 *            文件URL
	 * @param file_desc
	 *            文件描述
	 */
	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results reportSave(String id, String file_name, String file_url,
			String file_desc) {

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO maintenance_report_card(file_name,file_url,file_desc,file_type) VALUES (?,?,?,?)";
			int i = jdbcTemplate.update(sql, new Object[] { file_name,
					file_url, file_desc, Util.toFileType(file_url) });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE maintenance_report_card SET file_name=?, file_url=?,file_desc=?,file_type=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] { file_name,
					file_url, file_desc, Util.toFileType(file_url),
					Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

	/**
	 * 删除维修报告单
	 * 
	 * @param ids
	 *            多ID数据，如：1,2,31
	 */
	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results deleteToReportCard(final int[] ids) {
		return super.delete("maintenance_report_card", ids);
	}
}
