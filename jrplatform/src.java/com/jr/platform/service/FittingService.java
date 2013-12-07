package com.jr.platform.fitting.service;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.db.jdbcutils.JdbcUtils;
import org.db.jdbcutils.sql.SqlStatement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.core.Page;
import com.jr.core.Results;
import com.jr.util.Json;

@Service("fittingService")
public class FittingService {

	protected static Log logger = LogFactory.getLog(FittingService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Results list(Page page, String stock, String device_type_use_id,
			String device_type_sort_id, String fitting_name, String brand,
			String fitting_number, String models) {

		StringBuffer sb = new StringBuffer(10);
		sb
				.append("SELECT f.id,stock,fitting_name,brand,fitting_number,models,specification_desc,dt1.product_use as device_type_use,dt2.fitting_category as device_type_sort  FROM fitting f LEFT JOIN device_type dt1 on f.device_type_use_id = dt1.id LEFT JOIN device_type dt2 on f.device_type_sort_id = dt2.id");
		sb.append(" WHERE 1=1 ");

		List<Object> setparams = new ArrayList<Object>();
		if (StringUtils.isNotEmpty(stock)) {
			sb.append(" AND stock = ?");
			setparams.add(Integer.parseInt(stock));
		}
		if (!"null".equals(device_type_use_id)
				&& !"-1".equals(device_type_use_id)
				&& StringUtils.isNotEmpty(device_type_use_id)) {
			sb.append(" AND device_type_use_id = ?");
			setparams.add(Integer.parseInt(device_type_use_id));
		}
		if (!"null".equals(device_type_sort_id)
				&& !"-1".equals(device_type_sort_id)
				&& StringUtils.isNotEmpty(device_type_sort_id)) {
			sb.append(" AND device_type_sort_id = ?");
			setparams.add(Integer.parseInt(device_type_sort_id));
		}
		if (StringUtils.isNotEmpty(fitting_name)) {
			sb.append(" AND fitting_name like ?");
			setparams.add("%" + fitting_name + "%");
		}
		if (StringUtils.isNotEmpty(brand)) {
			sb.append(" AND brand like ?");
			setparams.add("%" + brand + "%");
		}
		if (StringUtils.isNotEmpty(fitting_number)) {
			sb.append(" AND fitting_number like ?");
			setparams.add("%" + fitting_number + "%");
		}
		if (StringUtils.isNotEmpty(models)) {
			sb.append(" AND models like ?");
			setparams.add("%" + models + "%");
		}

		sb.append(" ORDER BY f.id DESC");

		String sql = sb.toString();
		SqlStatement stat = new SqlStatement();
		String countSql = stat.count(sql);
		sql = stat.paging(sql, JdbcUtils.MYSQL);

		int s = page.getStartToDatabase(JdbcUtils.MYSQL);
		int e = page.getPageSize();

		long totalCount = 0;
		List<?> result = null;
		if (setparams.size() > 0) {
			totalCount = jdbcTemplate.queryForLong(countSql, setparams
					.toArray());

			setparams.add(s);
			setparams.add(e);
			result = jdbcTemplate.queryForList(sql, setparams.toArray());
		} else {
			totalCount = jdbcTemplate.queryForLong(countSql);
			result = jdbcTemplate.queryForList(sql, new Object[] { s, e });
		}

		return new Results(result, totalCount, page.getStartPage(), page
				.getPageSize());
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(String id, String fitting_name, String stock,
			String taobao_links, String brand, String device_type_use_id,
			String device_type_sort_id, String fitting_number,
			String specification_desc, String models, String fitting_desc,
			String sale_protection, String image_url) {

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO fitting(fitting_name, stock, taobao_links, brand, device_type_use_id, device_type_sort_id, fitting_number, specification_desc, models, fitting_desc, sale_protection, image_url) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
			int i = jdbcTemplate.update(sql, new Object[] { fitting_name,
					stock, taobao_links, brand,
					Integer.parseInt(device_type_use_id),
					Integer.parseInt(device_type_sort_id), fitting_number,
					specification_desc, models, fitting_desc, sale_protection,
					image_url });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE fitting SET fitting_name=?, stock=?, taobao_links=?, brand=?, device_type_use_id=?, device_type_sort_id=?, fitting_number=?, specification_desc=?, models=?, fitting_desc=?, sale_protection=?, image_url=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] { fitting_name,
					stock, taobao_links, brand,
					Integer.parseInt(device_type_use_id),
					Integer.parseInt(device_type_sort_id), fitting_number,
					specification_desc, models, fitting_desc, sale_protection,
					image_url, Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public String deleteByIds(final int[] ids) {

		String sql = "DELETE FROM fitting WHERE id = ?";

		jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
			public void setValues(PreparedStatement ps, int i)
					throws SQLException {
				ps.setInt(1, ids[i]);
			}

			public int getBatchSize() {
				return ids.length;
			}
		});

		return Json.oJson(true);
	}

	public Map<String, Object> findById(int id) {
		String sql = "SELECT id,fitting_name, stock, taobao_links, brand, device_type_use_id, device_type_sort_id, fitting_number, specification_desc, models, fitting_desc, sale_protection, image_url FROM fitting WHERE id=?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}

}
