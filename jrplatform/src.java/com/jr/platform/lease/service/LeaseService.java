package com.jr.platform.lease.service;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.core.IService;
import com.jr.core.Results;
import com.jr.util.Json;

@Service("leaseService")
public class LeaseService  extends IService {

	protected static Log logger = LogFactory.getLog(LeaseService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public String scroll(final int[] ids, final int mark) {
		String sql = "UPDATE product SET rental_scroll_mark = ? WHERE id = ?";

		jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
			public void setValues(PreparedStatement ps, int i)
					throws SQLException {
				ps.setInt(1, mark);
				ps.setInt(2, ids[i]);
			}

			public int getBatchSize() {
				return ids.length;
			}
		});

		return Json.oJson(true);
	}

	public Results scrollList(int mark) {
		String sql = "SELECT p.image_url,d.product_use,p.id,rental_scroll_mark,device_type_id,stock,product_category,product_name,brand,place_origin,model,material,exterior_size,effective_volume,product_weight,voltage,electric_current,power,energy,temperature_range,coolant,work_mode,capacity,stock FROM product p LEFT JOIN device_type d on p.device_type_id = d.id WHERE p.rental_scroll_mark=?";
		return new Results(jdbcTemplate
				.queryForList(sql, new Object[] { mark }));
	}

	public Map<String, Object> find() {
		String sql = "SELECT id,description,contract_url,contract_name FROM lease_page";
		return jdbcTemplate.queryForMap(sql);
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results descSave(String id, String description, String contract_url,
			String contract_name) {
		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO lease_page(description,contract_url,contract_name) VALUES (?,?,?)";
			int i = jdbcTemplate.update(sql, new Object[] { description,
					contract_url, contract_name });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE lease_page SET description=?,contract_url=?,contract_name=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] { description,
					contract_url, contract_name, Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

}
