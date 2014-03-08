package com.jr.platform.fitting.service;

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
import com.jr.platform.fitting.dao.FittingDao;
import com.jr.platform.product.service.ProductCategoryService;
import com.jr.util.DateConverter;
import com.jr.util.FileCompressUtils;
import com.jr.util.Json;
import com.jr.util.OfficeExcelUtils;

@Service("fittingService")
public class FittingService extends IService {

	protected static Log logger = LogFactory.getLog(FittingService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private FittingDao fittingDao;
	@Autowired
	private String fileDir;
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private FittingSpecialtyCategoryService  categoryService;
	
	
	
	public Results list(Page page, String stock, String device_type_use_id,
			String device_type_sort_id, String fitting_name, String brand,
			String fitting_number, String models) {

		StringBuffer sb = new StringBuffer(10);
		sb.append("SELECT f.id,stock,fitting_name,brand,fitting_number,models,specification_desc,dt1.product_use as device_type_use,dt2.fitting_category as device_type_sort  FROM fitting f LEFT JOIN device_type dt1 on f.device_type_use_id = dt1.id LEFT JOIN device_type dt2 on f.device_type_sort_id = dt2.id");
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

		return super.list(page, setparams, sb.toString());
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(String id, String fitting_name, String stock,
			String taobao_links, String brand, String device_type_use_id,
			String device_type_sort_id, String fitting_number,
			String specification_desc, String models, String fitting_desc,
			String sale_protection, String image_url)throws DuplicateKeyException {

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO fitting(fitting_name, stock, taobao_links, brand, device_type_use_id, device_type_sort_id, fitting_number, specification_desc, models, fitting_desc, sale_protection, image_url) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
			int i = jdbcTemplate.update(
					sql,
					new Object[] { fitting_name, stock, taobao_links, brand,
							Integer.parseInt(device_type_use_id),
							Integer.parseInt(device_type_sort_id),
							fitting_number, specification_desc, models,
							fitting_desc, sale_protection, image_url });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE fitting SET fitting_name=?, stock=?, taobao_links=?, brand=?, device_type_use_id=?, device_type_sort_id=?, fitting_number=?, specification_desc=?, models=?, fitting_desc=?, sale_protection=?, image_url=? WHERE id=?";
			int i = jdbcTemplate.update(
					sql,
					new Object[] { fitting_name, stock, taobao_links, brand,
							Integer.parseInt(device_type_use_id),
							Integer.parseInt(device_type_sort_id),
							fitting_number, specification_desc, models,
							fitting_desc, sale_protection, image_url,
							Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

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
	public Map<String, Object> findByFittingName(String fittingName) {
		String sql = "SELECT id,fitting_name, stock, taobao_links, brand, device_type_use_id, device_type_sort_id, fitting_number, specification_desc, models, fitting_desc, sale_protection, image_url FROM fitting WHERE fitting_name=?";
		try {
			return jdbcTemplate.queryForMap(sql, new Object[] { fittingName });
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	public String batchToSave(String excelFileUrl,String zipFileUrl,String zipvalue) throws IOException{
		List<List<Object>> excelData=OfficeExcelUtils.readExcel(fileDir + excelFileUrl);
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
				//产品用途(自定义)分类
				Map<String, Object> map=categoryService.findByFittingCategory(productList.get(j).get(3).toString());
				int id=0;
				if(map!=null){
					id=Integer.parseInt(map.get("id").toString());
				}else{
					id=	categoryService.save(productList.get(j).get(3).toString(), "");
				}
				productList.get(j).set(3, id);
			}

			if(StringUtils.isNotBlank((productList.get(j).get(4).toString()))){
				//专业分类
				Map<String, Object> productMap=productCategoryService.findByProductUse(productList.get(j).get(4).toString());
				int productId=0;
				if(productMap!=null){
					productId=Integer.parseInt(productMap.get("id").toString());
				}else{
					productId=	productCategoryService.save(productList.get(j).get(4).toString(), "");
				}
				productList.get(j).set(4, productId);
			}
			
		}
		
		List<List<Object>> product=new ArrayList<List<Object>>();
		
		for (int j = 0; j < productList.size(); j++) {
			//查询数据是否为已经存在,存在则删除相关数据不录入数据库
			if(StringUtils.isNotBlank((productList.get(j).get(5).toString()))){
				Map<String, Object> map=findByFittingName(productList.get(j).get(5).toString());
				if(map!=null){
					errorList.add("设备'"+productList.get(j).get(5).toString()+"'已存储至服务器中，请检查确认");
					//errorList.add(productList.get(j));
				}else{
					product.add(productList.get(j));
				}
			}
			
		}
		
		for (int j = 0; j < product.size(); j++) {
			product.get(j).set(0,"/"+date+"/"+zipvalue.replaceAll(".zip", "")+"/"+product.get(j).get(0));
		}

		fittingDao.batchToSave(product);
		StringBuffer  buffer=new StringBuffer();
		for(int i =0;i<errorList.size();i++){
			buffer.append(errorList.get(i)+"\\n");
		}
		buffer.append("成功入库"+productList.size()+"个设备,未入库"+errorList.size()+"个设备");
		System.out.println("+:::"+buffer.toString());
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
			//判断是否为12条数据，如不等则数据格式不正确
			//			if (excelData.get(i).size()!=12) {
			//				errorList.add(excelData.get(i));
			//				continue;
			//			}
			// 判断文件是否存在
			int fileIsNot = Arrays.binarySearch(fileList,excelData.get(i).get(0));
			if (fileIsNot < 0) {
				//errorList.add(excelData.get(i));
				if(excelData.get(i).size()>5){
				errorList.add("设备'"+excelData.get(i).get(5)+"'的'图片',在Excel文件和ZIP压缩文件中未能匹配，请检查确认");
				}else{errorList.add("设备'"+excelData.get(i).get(0)+"'的'图片',在Excel文件和ZIP压缩文件中未能匹配，请检查确认");}
				continue;
			}
			// 将正确数据存入集合
			productList.add(excelData.get(i));
		}
		if (flag) {
			return productList;
		} else {
			return errorList;
		}
	} 

	
}
