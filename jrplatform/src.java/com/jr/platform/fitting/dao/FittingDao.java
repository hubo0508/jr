/**
 * 
 */
package com.jr.platform.fitting.dao;

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
 * FittingDao.java<br/>
 * 所属类别:获取时间相关方法类 <br/>
 * 用途: 通过此工具类减少获取时间相关代码量提高提高代码重用<br/>
 * author:<a href="mailto:llnyxxzj@163.com">lilong</a> <br/>
 * Date:2013-12-17 下午1:45:14<br/>
 * Version:1.0 <br/>
 */
@Repository("fittingDao")
public class FittingDao extends IService{
	protected static Log logger = LogFactory.getLog(FittingDao.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public boolean batchToSave(final List<List<Object>>  lists) {
		if(lists==null){
			return false;
		}

		String sql = "INSERT INTO fitting" +
				"(image_url, stock,taobao_links, " +
				"device_type_use_id, device_type_sort_id,fitting_name, " +
				"brand, fitting_number,specification_desc, models," +
				" fitting_desc, sale_protection" +
				") VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
		int[] count=jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
			public void setValues(PreparedStatement statement, int i)
					throws SQLException {
						statement.setString(1, lists.get(i).get(0).toString());//image_url
						double stock=	Double.parseDouble(lists.get(i).get(1).toString());
						statement.setInt(2,    (int)stock);//stock
						statement.setString(3, lists.get(i).get(2).toString());//taobao_links
						statement.setInt(4,    Integer.parseInt(lists.get(i).get(3).toString()));//device_type_use_id
						statement.setString(5, lists.get(i).get(4).toString());//device_type_sort_id
						statement.setString(6, lists.get(i).get(5).toString());//fitting_name 
						statement.setString(7, lists.get(i).get(6).toString());//brand
						statement.setString(8, lists.get(i).get(7).toString());//fitting_number
						statement.setString(9, lists.get(i).get(8).toString());//specification_desc
						statement.setString(10, lists.get(i).get(9).toString());//models
						statement.setString(11, lists.get(i).get(10).toString());//fitting_desc
						statement.setString(12, lists.get(i).get(11).toString());//sale_protection
			}
			public int getBatchSize() {
				return lists.size();
			}
		});
		return  true;
	}
}
