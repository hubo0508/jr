package com.jr.client.fitting.service;

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

@Service("fittingCliService")
public class FittingCliService extends IService {

	protected static Log logger = LogFactory.getLog(FittingCliService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	/**
	 *<p>获取配件用途</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return
	 */
	public Map<String, Object> getFittingByFittingId(int id) {
		String fittingUse="SELECT f.* from fitting f where f.id=? ";
		return jdbcTemplate.queryForMap(fittingUse, id);
	}

	/**
	 *<p>获取配件用途</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return
	 */
	public List<Map<String, Object>> getFittingUse() {
		String fittingUse="SELECT d.id,d.fitting_use from device_type d  where d.fitting_use<>'' or d.fitting_use<>null";
		List<Map<String, Object>> fittingUseList=jdbcTemplate.queryForList(fittingUse);
		return fittingUseList;
	}
	/**
	 *<p>配件归类分类</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return
	 */
	public List<Map<String, Object>> getFittingCategory() {
		String fittingCategory="SELECT d.id,d.fitting_category from device_type d  where d.fitting_category<>'' or d.fitting_category<>null";
		List<Map<String, Object>> fittingCategoryList=jdbcTemplate.queryForList(fittingCategory);
		return fittingCategoryList;
	}

	/**
	 *<p>获取配件用途以及相应品牌</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return
	 */
	public List<Map<String, Object>> getFittingBrand() {
		String deviceTypeBrand = "SELECT  p.brand from fitting p  where p.brand<>'' or p.brand<>null GROUP BY p.brand;";

		List<Map<String, Object>> deviceTypeBrandList=	jdbcTemplate.queryForList(deviceTypeBrand);

		return deviceTypeBrandList;
	}
	/**
	 *<p>获取设备类型</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return  productService.findProduct(new Page(start, pageSize),deviceTypeId,brand);
	 */
	public Results getFittingByFittingCategory(Page page, String deviceTypeUseId,String deviceTypeSortId,String brand) {
		StringBuffer sql = new StringBuffer(" SELECT f.id,f.brand,f.fitting_name,f.image_url from fitting f  where 1=1");
		List<Object> params = new ArrayList<Object>();
		if(deviceTypeUseId!=null&&!deviceTypeUseId.equals("")){
			sql.append(" and f.device_type_use_id=?");
			params.add(Integer.parseInt(deviceTypeUseId));
		}
		if(deviceTypeSortId!=null&&!deviceTypeSortId.equals("")){
			sql.append(" and f.device_type_sort_id=?");
			params.add(Integer.parseInt(deviceTypeSortId));
		}
		sql.append(" and f.brand like ?");
		if(brand==null||brand.equals("")){
			params.add("%%");
		}else{params.add("%" + brand + "%");}

		return super.list(page, params, sql.toString());
	}

	/**
	 *<p>获取设备类型</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return  productService.findProduct(new Page(start, pageSize),deviceTypeId,brand);
	 */
	public Results findFitting(Page page,String brand,String fittingName,String fittingNO,String fittingDevice) {
		StringBuffer sql = new StringBuffer(" SELECT f.id,f.brand,f.fitting_name,f.image_url from fitting f  where 1=1");
		List<Object> params = new ArrayList<Object>();

		sql.append(" and f.brand like ?");
		if(brand==null||brand.equals("")){
			params.add("%%");
		}else{params.add("%" + brand + "%");}

		if(fittingName!=null&&!fittingName.equals("")){
			sql.append(" and f.fitting_name like ?");
			params.add("%" + fittingName + "%");
		}
		if(fittingNO!=null&&!fittingNO.equals("")){
			sql.append(" and f.fitting_number like ?");
			params.add("%" + fittingNO + "%");
		}
		if(fittingDevice!=null&&!fittingDevice.equals("")){
			sql.append(" and f.models like ?");
			params.add("%" + fittingNO + "%");
		}
		return super.list(page, params, sql.toString());
	}

	/**
	 *<p>获取配件用途以及相应品牌</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return
	 */
	public List<Map<String, Object>> getFittingUseAndBrand() {
		String deviceType="SELECT d.id, d.fitting_use  from  device_type d where (d.fitting_use <>'' or d.fitting_use <>null);";
		String deviceTypeBrand = "SELECT  p.brand from fitting p  where device_type_use_id=? and (p.brand<>'' or p.brand<>null) GROUP BY p.brand;";
		List<Map<String, Object>> deviceTypeList=jdbcTemplate.queryForList(deviceType);

		List<Map<String, Object>>  list=new ArrayList<Map<String,Object>>();

		for (int i = 0; i <deviceTypeList.size(); i++) {

			Map<String, Object> map=new HashMap<String, Object>();

			int device_type_id=	Integer.valueOf(deviceTypeList.get(i).get("id").toString());
			List<Map<String, Object>> deviceTypeBrandList=	jdbcTemplate.queryForList(deviceTypeBrand,device_type_id);

			String deviceTypeStr=deviceTypeList.get(i).get("fitting_use").toString();
			map.put("deviceTypeId", device_type_id);
			map.put("fittingUse", deviceTypeStr);
			if (deviceTypeBrandList.size() != 0) {
				map.put("deviceTypeBrandList", deviceTypeBrandList);
			}
			list.add(map);
		}
		return list;
	}

	/**
	 *<p>获取配件归类以及相应品牌</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return
	 */
	public List<Map<String, Object>> getFittingCategoryAndBrand() {
		String deviceType="SELECT d.id, d.fitting_category  from  device_type d where (d.fitting_category <>'' or d.fitting_category <>null);";
		String deviceTypeBrand = "SELECT  p.brand from fitting p  where device_type_sort_id=? and (p.brand<>'' or p.brand<>null) GROUP BY p.brand;";
		List<Map<String, Object>> deviceTypeList=jdbcTemplate.queryForList(deviceType);

		List<Map<String, Object>>  list=new ArrayList<Map<String,Object>>();

		for (int i = 0; i <deviceTypeList.size(); i++) {

			Map<String, Object> map=new HashMap<String, Object>();

			int device_type_id=	Integer.valueOf(deviceTypeList.get(i).get("id").toString());
			List<Map<String, Object>> deviceTypeBrandList=	jdbcTemplate.queryForList(deviceTypeBrand,device_type_id);

			String deviceTypeStr=deviceTypeList.get(i).get("fitting_category").toString();
			map.put("deviceTypeId", device_type_id);
			map.put("fittingUse", deviceTypeStr);
			if (deviceTypeBrandList.size() != 0) {
				map.put("deviceTypeBrandList", deviceTypeBrandList);
			}
			list.add(map);
		}
		return list;
	}

	/**
	 *<p>获取产品</P>
	 * Date	2013-12-14 下午8:29:36
	 * @param scrollMark
	 * @return 
	 */
	public Results findFitting(Page page, String fittingName,String fittingNumber,String models) {
		StringBuffer sql = new StringBuffer(" SELECT f.id,f.brand,f.fitting_name,f.image_url from fitting f  where 1=1");
		List<Object> params = new ArrayList<Object>();

		
		if(fittingName!=null&&!fittingName.equals("")){
			sql.append(" and UPPER(f.fitting_name) like ?");
			params.add("%" + fittingName.toUpperCase() + "%");
		}
		if(models!=null&&!models.equals("")){
			sql.append(" and UPPER(f.models) like ?");
			params.add("%" + models.toUpperCase() + "%");
		}
		if(fittingNumber!=null&&!fittingNumber.equals("")){
			sql.append(" and UPPER(f.fitting_number) like ?");
			params.add("%" + fittingNumber.toUpperCase() + "%");
		}
		return super.list(page, params, sql.toString());
	}
}
