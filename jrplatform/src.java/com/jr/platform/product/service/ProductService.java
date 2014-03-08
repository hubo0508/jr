package com.jr.platform.product.service;

import java.io.File;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.core.IService;
import com.jr.core.Page;
import com.jr.core.Results;
import com.jr.platform.product.dao.ProductDao;
import com.jr.util.DateConverter;
import com.jr.util.FileCompressUtils;
import com.jr.util.Json;
import com.jr.util.OfficeExcelUtils;

@Service("productService")
public class ProductService extends IService {

	protected static Log logger = LogFactory.getLog(ProductService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private ProductDao productDao;
	@Autowired
	ProductCategoryService categoryService;
	@Autowired
	private String fileDir;


	public Results queryProductList(Page page, String product_name,
			String device_type_id, String product_category,
			String place_origin, String model, String material,
			String exterior_size, String effective_volume,
			String product_weight, String voltage, String electric_current,
			String power, String energy, String temperature_range,
			String coolant, String work_mode, String capacity, String stock,
			String brand) {

		StringBuffer sb = new StringBuffer(10);
		sb.append("SELECT p.image_url,d.product_use,p.id,rental_scroll_mark,device_type_id,stock,product_category,product_name,brand,place_origin,model,material,exterior_size,effective_volume,product_weight,voltage,electric_current,power,energy,temperature_range,coolant,work_mode,capacity,image_url,scroll_mark,stock ");
		sb.append("FROM product p LEFT JOIN device_type d on p.device_type_id = d.id ");
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

		return super.list(page, setparams, sb.toString());
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(String id, String product_name, String device_type_id,
			String product_category, String place_origin, String model,
			String material, String exterior_size, String effective_volume,
			String product_weight, String voltage, String electric_current,
			String power, String energy, String temperature_range,
			String coolant, String work_mode, String capacity, String stock,
			String taobao_links, String features, String service_range,
			String brand, String image_url) throws DuplicateKeyException{

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO product(product_name, device_type_id,product_category, place_origin, model,material, exterior_size, effective_volume,product_weight, voltage,electric_current, power, energy,temperature_range, coolant, work_mode,capacity, stock, taobao_links, features,service_range,brand,image_url) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			int i = jdbcTemplate.update(sql,
					new Object[] { product_name, device_type_id,
					product_category, place_origin, model, material,
					exterior_size, effective_volume, product_weight,
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
			int i = jdbcTemplate.update(
					sql,
					new Object[] {product_name, device_type_id,
							product_category, place_origin, model, material,
							exterior_size, effective_volume, product_weight,
							voltage, electric_current, power, energy,
							temperature_range, coolant, work_mode, capacity,
							Integer.parseInt(stock), taobao_links, features,
							service_range, brand, image_url,
							Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}


	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public String delete(final int[] ids) {

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
	public Map<String, Object> findByProductName(String productName) {
		String sql = "SELECT id,product_name, device_type_id,product_category, place_origin, model,material, exterior_size, effective_volume,product_weight, voltage,electric_current, power, energy,temperature_range, coolant, work_mode,capacity, stock, taobao_links, features,service_range,brand,image_url FROM product WHERE product_name = ?";
		try {
			return jdbcTemplate.queryForMap(sql, new Object[] {productName});
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
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
	public String batchToSave(String excelFileUrl, String zipFileUrl,String zipvalue) throws IOException{

		List<List<Object>> excelData=	OfficeExcelUtils.readExcel(fileDir + excelFileUrl);
		String date=DateConverter.convert(new Date(), "yyyyMMdd");
		File dateFile=new File(fileDir+date);
		if(!dateFile.exists()){
			dateFile.mkdirs();
		}
		
		FileCompressUtils.unZip(fileDir + zipFileUrl, fileDir+date);
		File file=new File(fileDir+date+"\\"+zipvalue.replaceAll(".zip", ""));
		if(!file.isDirectory()){
			return Results.SAVEERROR+",图片压缩文件应该为一个文件夹";
		}

		String[] fileList =file.list();
		@SuppressWarnings("unchecked")
		List<List<Object>> productList =(List<List<Object>>) getData(excelData,fileList,true);
		@SuppressWarnings("unchecked")
		List<Object> errorList =(List<Object>) getData(excelData,fileList,false);

		for (int j = 0; j < productList.size(); j++) {
			//产品分类查询、新增,'替换第三列数据，替换为编号'
			if(StringUtils.isNotBlank((productList.get(j).get(3).toString()))){
				Map<String, Object> map=categoryService.findByProductUse(productList.get(j).get(3).toString());
				int id=0;
				if(map!=null){
					id=Integer.parseInt(map.get("id").toString());
				}else{
					id=	categoryService.save(productList.get(j).get(3).toString(), "");
				}
				productList.get(j).set(3, id);
			}
		}
		List<List<Object>> product=new ArrayList<List<Object>>();
		for (int j = 0; j < productList.size(); j++) {
			//查询数据是否为已经存在,存在则删除相关数据不录入数据库
			if(StringUtils.isNotBlank((productList.get(j).get(5).toString()))){
				Map<String, Object> map=findByProductName(productList.get(j).get(5).toString());
				if(map!=null){
					errorList.add("设备'"+productList.get(j).get(5).toString()+"'已存储至服务器中，请检查确认");
					productList.remove(j);
				}else{
					product.add(productList.get(j));
				}
			}
		}
		
		
		for (int j = 0; j < product.size(); j++) {
			product.get(j).set(0,"/"+date+"/"+zipvalue.replaceAll(".zip", "")+"/"+product.get(j).get(0));
		}
		productDao.batchToSave(product);
		StringBuffer  buffer=new StringBuffer();
		for(int i =0;i<errorList.size();i++){
			buffer.append(errorList.get(i)+"\\n");
		}
		buffer.append("成功入库"+productList.size()+"个设备,未入库"+errorList.size()+"个设备");


		return buffer.toString();
	}

	private List<?>  getData(List<List<Object>> excelData ,String[] fileList,boolean flag){


		List<Object> errorList = new ArrayList<Object>();
		//errorList.add(excelData.get(0));

		List<List<Object>> productList = new ArrayList<List<Object>>();
		for (int i = 0; i < excelData.size(); i++) {
			// 第一行为产品名称因此不用存入数据库
			if (i == 0) {
				continue;
			}
			//			//判断是否为23个数据，如不等则数据格式不正确  允许用户填充空值
			//			if (excelData.get(i).size() != 23) {
			//				//errorList.add(excelData.get(i));
			//				errorList.add("'"+excelData.get(i).get(0)+"';这条数据格式不正确;如数据为空‘#’填充");
			//				continue;
			//			}
			// 判断文件是否存在
			int fileIsNot = Arrays.binarySearch(fileList,excelData.get(i).get(0));
			if (fileIsNot < 0) {
				//				buffer.append("设备'"+excelData.get(i).get(5)+"',");
				errorList.add("设备'"+excelData.get(i).get(5)+"'的'图片',在Excel文件和ZIP压缩文件中未能匹配，请检查确认");
				continue;
			}else{
				// 将正确数据存入集合
				productList.add(excelData.get(i));}
		}
		if (flag) {
			return productList;
		} else {
			//			errorList.add("图片:"+buffer.toString()+"在Excel文件和ZIP压缩文件中未能匹配，请检查确认");
			return errorList;
		}
	} 
}
