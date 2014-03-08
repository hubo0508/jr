/**
 * 
 */
package com.jr.platform.product.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.core.IService;

/** 
 * ProductDao.java<br/>
 * 所属类别:获取时间相关方法类 <br/>
 * 用途: 通过此工具类减少获取时间相关代码量提高提高代码重用<br/>
 * author:<a href="mailto:llnyxxzj@163.com">lilong</a> <br/>
 * Date:2013-12-16 下午10:31:02<br/>
 * Version:1.0 <br/>
 */
@Repository("productDao")
public class ProductDao extends IService{
	protected static Log logger = LogFactory.getLog(ProductDao.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public boolean batchToSave(final List<List<Object>>  lists) {
		if(lists==null){
			return false;
		}

		String sql = "INSERT INTO product" +
				"(image_url, stock,taobao_links, " +
				"device_type_id, product_category,product_name, " +
				"brand, place_origin,model, material," +
				"exterior_size, effective_volume, product_weight," +
				"voltage, electric_current, power,energy, temperature_range," +
				" coolant, work_mode,capacity,service_range,features) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		int[] count=jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
			public void setValues(PreparedStatement statement, int i)
					throws SQLException {
				statement.setString(1, lists.get(i).get(0).toString());//image_url
				double stock=	Double.parseDouble(lists.get(i).get(1).toString());
				statement.setInt(2,    (int)stock);//stock
				statement.setString(3, lists.get(i).get(2).toString());//taobao_links
				statement.setInt(4,    Integer.parseInt(lists.get(i).get(3).toString()));//device_type_id
				statement.setString(5, lists.get(i).get(4).toString());//product_category
				statement.setString(6, lists.get(i).get(5).toString());//product_name
				statement.setString(7, lists.get(i).get(6).toString());//brand
				statement.setString(8, lists.get(i).get(7).toString());//place_origin
				statement.setString(9, lists.get(i).get(8).toString());//model
				statement.setString(10, lists.get(i).get(9).toString());//material
				statement.setString(11, lists.get(i).get(10).toString());//exterior_size
				statement.setString(12, lists.get(i).get(11).toString());//effective_volume
				statement.setString(13, lists.get(i).get(12).toString());//product_weight
				statement.setString(14, lists.get(i).get(13).toString());//voltage
				statement.setString(15, lists.get(i).get(14).toString());//electric_current
				statement.setString(16, lists.get(i).get(15).toString());//power
				statement.setString(17, lists.get(i).get(16).toString());//energy
				statement.setString(18, lists.get(i).get(17).toString());//temperature_range
				statement.setString(19, lists.get(i).get(18).toString());//coolant
				statement.setString(20, lists.get(i).get(19).toString());//work_mode
				statement.setString(21, lists.get(i).get(20).toString());//capacity
				statement.setString(22, lists.get(i).get(21).toString());//service_range
				statement.setString(23, lists.get(i).get(22).toString());//features
			}
			public int getBatchSize() {
				return lists.size();
			}
		});
		return  true;
	}
}
