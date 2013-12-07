package com.jr.platform.product.service;

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

@Service("productService")
public class ProductService {

	protected static Log logger = LogFactory.getLog(ProductService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Results queryProductList(Page page, String product_name,
			String device_type_id, String product_category,
			String place_origin, String model, String material,
			String exterior_size, String effective_volume,
			String product_weight, String voltage, String electric_current,
			String power, String energy, String temperature_range,
			String coolant, String work_mode, String capacity, String stock,
			String brand) {

		StringBuffer sb = new StringBuffer(10);
		sb
				.append("SELECT d.product_use,p.id,rental_scroll_mark,device_type_id,stock,product_category,product_name,brand,place_origin,model,material,exterior_size,effective_volume,product_weight,voltage,electric_current,power,energy,temperature_range,coolant,work_mode,capacity,image_url,scroll_mark,stock ");
		sb
				.append("FROM product p LEFT JOIN device_type d on p.device_type_id = d.id ");
		sb.append(" WHERE 1=1 ");

		List<Object> setparams = new ArrayList<Object>();
		if (StringUtils.isNotEmpty(product_name)) {
			sb.append(" AND product_name like ?");
			setparams.add("%" + product_name + "%");
		}
		if (!"null".equals(device_type_id) && !"-1".equals(device_type_id)
				&& StringUtils.isNotEmpty(device_type_id)) {
			sb.append(" AND device_type_id = ?");
			setparams.add(Integer.parseInt(device_type_id));
		}
		if (StringUtils.isNotEmpty(product_category)) {
			sb.append(" AND product_category = ?");
			setparams.add(product_category);
		}
		if (StringUtils.isNotEmpty(place_origin)) {
			sb.append(" AND place_origin = ?");
			setparams.add(place_origin);
		}
		if (StringUtils.isNotEmpty(model)) {
			sb.append(" AND model like ?");
			setparams.add("%" + model + "%");
		}
		if (StringUtils.isNotEmpty(material)) {
			sb.append(" AND material like ?");
			setparams.add("%" + material + "%");
		}
		if (StringUtils.isNotEmpty(exterior_size)) {
			sb.append(" AND exterior_size like ?");
			setparams.add("%" + exterior_size + "%");
		}
		if (StringUtils.isNotEmpty(effective_volume)) {
			sb.append(" AND effective_volume like ?");
			setparams.add("%" + effective_volume + "%");
		}
		if (StringUtils.isNotEmpty(product_weight)) {
			sb.append(" AND product_weight like ?");
			setparams.add("%" + product_weight + "%");
		}
		if (StringUtils.isNotEmpty(product_weight)) {
			sb.append(" AND product_weight like ?");
			setparams.add("%" + product_weight + "%");
		}
		if (StringUtils.isNotEmpty(voltage)) {
			sb.append(" AND voltage like ?");
			setparams.add("%" + voltage + "%");
		}
		if (StringUtils.isNotEmpty(electric_current)) {
			sb.append(" AND electric_current like ?");
			setparams.add("%" + electric_current + "%");
		}
		if (StringUtils.isNotEmpty(power)) {
			sb.append(" AND power like ?");
			setparams.add("%" + power + "%");
		}
		if (StringUtils.isNotEmpty(energy)) {
			sb.append(" AND energy like ?");
			setparams.add("%" + energy + "%");
		}
		if (StringUtils.isNotEmpty(temperature_range)) {
			sb.append(" AND temperature_range like ?");
			setparams.add("%" + temperature_range + "%");
		}
		if (StringUtils.isNotEmpty(coolant)) {
			sb.append(" AND coolant like ?");
			setparams.add("%" + coolant + "%");
		}
		if (StringUtils.isNotEmpty(work_mode)) {
			sb.append(" AND work_mode like ?");
			setparams.add("%" + work_mode + "%");
		}
		if (StringUtils.isNotEmpty(capacity)) {
			sb.append(" AND capacity like ?");
			setparams.add("%" + capacity + "%");
		}
		if (StringUtils.isNotEmpty(stock)) {
			sb.append(" AND stock = ?");
			setparams.add(Integer.parseInt(stock));
		}
		sb.append(" ORDER BY p.id DESC");

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
	public Results save(String id, String product_name, String device_type_id,
			String product_category, String place_origin, String model,
			String material, String exterior_size, String effective_volume,
			String product_weight, String voltage, String electric_current,
			String power, String energy, String temperature_range,
			String coolant, String work_mode, String capacity, String stock,
			String taobao_links, String features, String service_range,
			String brand, String image_url) {

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO product(product_name, device_type_id,product_category, place_origin, model,material, exterior_size, effective_volume,product_weight, voltage,electric_current, power, energy,temperature_range, coolant, work_mode,capacity, stock, taobao_links, features,service_range,brand,image_url) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			int i = jdbcTemplate.update(sql, new Object[] { product_name,
					device_type_id, product_category, place_origin, model,
					material, exterior_size, effective_volume, product_weight,
					voltage, electric_current, power, energy,
					temperature_range, coolant, work_mode, capacity,
					Integer.parseInt(stock), taobao_links, features,
					service_range, brand, image_url });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE product SET product_name=?, device_type_id=?,product_category=?, place_origin=?, model=?,material=?, exterior_size=?, effective_volume=?,product_weight=?, voltage=?,electric_current=?, power=?, energy=?,temperature_range=?, coolant=?, work_mode=?,capacity=?, stock=?, taobao_links=?, features=?,service_range=?,brand=?,image_url=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] { product_name,
					device_type_id, product_category, place_origin, model,
					material, exterior_size, effective_volume, product_weight,
					voltage, electric_current, power, energy,
					temperature_range, coolant, work_mode, capacity,
					Integer.parseInt(stock), taobao_links, features,
					service_range, brand, image_url, Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
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
		String sql = "SELECT id,product_name, device_type_id,product_category, place_origin, model,material, exterior_size, effective_volume,product_weight, voltage,electric_current, power, energy,temperature_range, coolant, work_mode,capacity, stock, taobao_links, features,service_range,brand,image_url FROM product WHERE id=?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public String scroll(final int[] ids, final int mark) {
		String sql = "UPDATE product SET scroll_mark = ? WHERE id = ?";

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

	public Results scrollList(int scrollMark) {
		String sql = "SELECT d.product_use,p.id,device_type_id,stock,product_category,product_name,brand,place_origin,model,material,exterior_size,effective_volume,product_weight,voltage,electric_current,power,energy,temperature_range,coolant,work_mode,capacity,stock FROM product p LEFT JOIN device_type d on p.device_type_id = d.id WHERE p.scroll_mark=?";
		return new Results(jdbcTemplate.queryForList(sql,
				new Object[] { scrollMark }));
	}


}
