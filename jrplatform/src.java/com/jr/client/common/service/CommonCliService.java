package com.jr.client.common.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.jr.client.fitting.service.FittingCliService;
import com.jr.client.product.service.ProductCliService;
import com.jr.core.Page;
import com.jr.core.Results;

/**
 * 通用组件
 */
@Service("commonCliService")
public class CommonCliService {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private FittingCliService fittingCliService; 
	@Autowired
	private ProductCliService productCliService;
	/**
	 * 查询在线客服
	 */
	public List<Map<String, Object>> onlineService() {
		String sql = "select caddress,area_name,cphone from company";
		return jdbcTemplate.queryForList(sql);
	}

	/**
	 * 在线客户查询
	 * 
	 * ctype=0 查询总公司
	 */
	public Map<String, Object> onlineCustomers() {
		String sql = "select sales_qq,customer_qq,leasing_qq,complaints_qq,cphone from company where ctype=0";
		return jdbcTemplate.queryForList(sql).get(0);
	}

	/**
	 * 客户名录查询
	 * 
	 * @param desc
	 *            参数不为空时，查询结果中包含字段description值
	 */
	public List<Map<String, Object>> customerList(String desc) {
		String sql = "select id, customer_name,image_url from customer";
		if (StringUtils.isNotEmpty(desc)) {
			sql = "select id, customer_name,image_url,description from customer";
		}
		return jdbcTemplate.queryForList(sql);
	}

	/**
	 * 用户协议查询
	 */
	public Map<String, Object> queryProtocol() {
		String sql = "SELECT protocold FROM about";
		return jdbcTemplate.queryForMap(sql);
	}

	/**
	 * 用户协议查询
	 */
	public Results  selectProductOrFitting(Page page, String  selectedCondition,String  condition) {
		
		if(selectedCondition.equals("设备名称")){
			
			return productCliService.findProduct(page, condition, null, null);
		}
		if(selectedCondition.equals("设备品牌")){
			return productCliService.findProduct(page, null, condition, null);
		}
		if(selectedCondition.equals("设备型号")){
			return productCliService.findProduct(page, null, null, condition);
		}
		if(selectedCondition.equals("配件名称")){
			return  fittingCliService.findFitting(page, condition, null, null);
		}
		if(selectedCondition.equals("配件型号")){
			return  fittingCliService.findFitting(page, null, null, condition);
		}
		if(selectedCondition.equals("配件编号")){
			return  fittingCliService.findFitting(page, null, condition, null);
		}
		return  null;
	}
}
