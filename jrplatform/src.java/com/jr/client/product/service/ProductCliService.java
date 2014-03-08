/**
 * 
 */
package com.jr.client.product.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.jr.core.IService;
import com.jr.core.Page;
import com.jr.core.Results;

@Service("productCliService")
public class ProductCliService extends IService {
	protected static Log logger = LogFactory.getLog(ProductCliService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Map<String, Object> getProductByProductId(int id) {
		//		String sql = "SELECT d.product_use,p.id,device_type_id,stock,product_category,product_name,brand,place_origin,model,material,exterior_size,effective_volume,product_weight,voltage,electric_current,power,energy,temperature_range,coolant,work_mode,capacity,stock FROM product p LEFT JOIN device_type d on p.device_type_id = d.id WHERE p.id=?";
		String sql = "SELECT p.* FROM product p  WHERE p.id=?";
		return jdbcTemplate.queryForMap(sql, id);
	}


	public Results scrollList(int scrollMark) {
		String sql = "SELECT d.product_use,p.id,p.image_url,device_type_id,stock,product_category,product_name,brand,place_origin,model,material,exterior_size,effective_volume,product_weight,voltage,electric_current,power,energy,temperature_range,coolant,work_mode,capacity,stock FROM product p LEFT JOIN device_type d on p.device_type_id = d.id WHERE p.scroll_mark=?";
		return new Results(jdbcTemplate.queryForList(sql,
				new Object[] { scrollMark }));
	}

	/**
	 *<p>获取设备类型以及相应品牌</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return
	 */
	public List<Map<String, Object>> getProductBrand() {
		String deviceTypeBrand = "SELECT  p.brand from product p  where p.brand<>'' or p.brand<>null GROUP BY p.brand;";
		List<Map<String, Object>> deviceTypeBrandList=	jdbcTemplate.queryForList(deviceTypeBrand);
		return deviceTypeBrandList;
	}

	/**
	 *<p>获取设备类型以及相应品牌</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return
	 */
	public List<Map<String, Object>> getProductUseAndBrand() {
		String deviceType="SELECT d.id, d.product_use  from  device_type d where (d.product_use <>'' or d.product_use <>null);";
		String deviceTypeBrand = "SELECT  p.brand from product p  where device_type_id=? and (p.brand<>'' or p.brand<>null) GROUP BY p.brand;";
		List<Map<String, Object>> deviceTypeList=jdbcTemplate.queryForList(deviceType);

		List<Map<String, Object>>  list=new ArrayList<Map<String,Object>>();

		for (int i = 0; i <deviceTypeList.size(); i++) {

			Map<String, Object> map=new HashMap<String, Object>();

			int device_type_id=	Integer.valueOf(deviceTypeList.get(i).get("id").toString());
			List<Map<String, Object>> deviceTypeBrandList=	jdbcTemplate.queryForList(deviceTypeBrand,device_type_id);

			String deviceTypeStr=deviceTypeList.get(i).get("product_use").toString();
			map.put("deviceTypeId", device_type_id);
			map.put("productUse", deviceTypeStr);
			if (deviceTypeBrandList.size() != 0) {
				map.put("deviceTypeBrandList", deviceTypeBrandList);
			}
			list.add(map);
		}
		return list;
	}

	/**
	 *<p>获取设备类型</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return
	 */
	public List<Map<String, Object>> getDeviceType() {
		String deviceType="SELECT d.id, d.product_use  from  device_type d where (d.product_use <>'' or d.product_use <>null);";
		return jdbcTemplate.queryForList(deviceType);
	}

	/**
	 *<p>获取设备类型</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return  productService.findProduct(new Page(start, pageSize),deviceTypeId,brand);
	 */
	public Results findProduct(Page page, String deviceTypeId,String brand) {
		String sql = "SELECT p.id, p.brand ,p.product_name,p.image_url from product p where 1=1 and p.brand like ?";
		List<Object> params = new ArrayList<Object>();
		if(brand==null||brand.equals("")){
			params.add("%%");
		}else{
			params.add("%" + brand + "%");
		}
		if(deviceTypeId!=null&&!deviceTypeId.equals("")){
			sql+=" and p.device_type_id=?";
			params.add(Integer.valueOf(deviceTypeId));
		}

		return super.list(page, params, sql);
	}
	/**
	 *<p>获取设备类型</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return  productService.findProduct(new Page(start, pageSize),deviceTypeId,brand);
	 */
	public Map<String, Object> getProduct(String id) {
		String sql = "SELECT p.id, p.brand ,p.product_name,p.image_url from product p where p.device_type_id=? and p.brand like ?";
		return	jdbcTemplate.queryForMap(sql, id);

	}
	/**
	 *<p>获取设备类型</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return  productService.findProduct(new Page(start, pageSize),deviceTypeId,brand);
	 */
	public Results findProductByBrandAndProductName(Page page, String productName,String brand) {
		String sql = "SELECT p.id, p.brand ,p.product_name,p.image_url from product p where p.product_name like ? and p.brand like ?";
		List<Object> params = new ArrayList<Object>();
		
		if (productName == null || productName.equals("")) {
			params.add("%%");
		} else {
			params.add("%" + productName + "%");
		}
		params.add("%" + brand + "%");
		
		return super.list(page, params, sql);
	}


	/**
	 *<p>获取产品</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return 
	 */
	public Results findProduct(Page page, String productName,String brand,String model) {
		//		String deviceTypeSql="SELECT d.id, d.product_use  from  device_type d where (d.product_use <>'' or d.product_use <>null);";
		StringBuffer sql = new StringBuffer("SELECT p.id, p.brand ,p.product_name,p.image_url from product p left join device_type d on p.device_type_id=d.id   where 1=1");
		List<Object> params = new ArrayList<Object>();
		if(productName!=null&&!productName.equals("")){
			sql.append(" and  UPPER(p.product_name)   like ?");
			params.add("%"+productName.toUpperCase()+"%");

		}
		if(brand!=null&&!brand.equals("")){
			sql.append(" and  UPPER(p.brand) like?");
			params.add("%"+brand.toUpperCase()+"%");
		}
		if(model!=null&&!model.equals("")){
			sql.append(" and UPPER(p.model) like?");
			params.add("%"+model.toUpperCase()+"%");
		}
		return super.list(page, params, sql.toString());
	}
}
