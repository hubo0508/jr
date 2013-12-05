package com.jr.platform.product.service;

import java.sql.PreparedStatement;
import java.sql.SQLException;
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

@Service("productService")
public class ProductService {

	protected static Log logger = LogFactory.getLog(ProductService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Results queryProductList(Page page) {

		String sql = "SELECT d.product_use,p.id,rental_service_id,device_type_id,stock,product_category,product_name,brand,place_origin,model,material,exterior_size,effective_volume,product_weight,voltage,electric_current,power,energy,temperature_range,coolant,work_mode,capacity,image_url,scroll_mark,stock FROM product p LEFT JOIN device_type d on p.device_type_id = d.id ORDER BY p.id DESC";

		SqlStatement stat = new SqlStatement();
		String countSql = stat.count(sql);
		sql = stat.paging(sql, JdbcUtils.MYSQL);
		List<?> result = jdbcTemplate.queryForList(sql, new Object[] {
				page.getStartToDatabase(JdbcUtils.MYSQL), page.getPageSize() });

		Long totalCount = jdbcTemplate.queryForLong(countSql);

		return new Results(result, totalCount, page.getStartPage(), page
				.getPageSize());
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(String id, String product_name, String device_type_id,
			String product_category, String place_origin, String model,
			String material, String exterior_size, String effective_volume,
			String product_weight, String voltage, String electric_current,
			String power, String energy, String temperature_range,
			String coolant, String work_mode, String capacity, String stock,
			String taobao_links, String features, String service_range,
			String brand) {

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO product(product_name, device_type_id,product_category, place_origin, model,material, exterior_size, effective_volume,product_weight, voltage,electric_current, power, energy,temperature_range, coolant, work_mode,capacity, stock, taobao_links, features,service_range,brand) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			int i = jdbcTemplate.update(sql, new Object[] { product_name,
					device_type_id, product_category, place_origin, model,
					material, exterior_size, effective_volume, product_weight,
					voltage, electric_current, power, energy,
					temperature_range, coolant, work_mode, capacity,
					Integer.parseInt(stock), taobao_links, features,
					service_range, brand });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			// String sql = "UPDATE device_type SET product_use=?,
			// product_use_desc=? WHERE id=?";
			// int i = jdbcTemplate.update(sql, new PreparedStatementSetter() {
			// public void setValues(PreparedStatement ps) throws SQLException {
			// ps.setString(1, product_use);
			// ps.setString(2, product_use_desc);
			// ps.setInt(3, Integer.parseInt(id));
			// }
			// });
			//
			// if (i == 1) {
			// return Results.SUCCESS;
			// }
		}

		throw new RuntimeException();
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public String deleteByIds(final int[] ids) {

		String sql = "DELETE FROM product WHERE id = ?";

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
		String sql = "SELECT id,product_use,product_use_desc FROM device_type WHERE id=?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}

}
