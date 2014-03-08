package com.jr.client.learn.service;

import java.util.ArrayList;
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

@Service("learnCliService")
public class LearnCliService extends IService {

	protected static Log logger = LogFactory.getLog(LearnCliService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Results listToHome(Page page) {
		String sql = "select file_name,date_format(save_date,'%Y-%m-%d') as save_date from document_library order by save_date desc";
		return super.list(page, null, sql);
	}

	/**
	 * 根据客户端主页查询所有显示数据
	 */
	public List<Map<String, Object>> listAllToIndex() {

		List<Map<String, Object>> listMajorCategory = listMajorCategory();
		for (int i = 0; i < listMajorCategory.size(); i++) {
			Map<String, Object> majorCategory = listMajorCategory.get(i);
			int id = (Integer) majorCategory.get("id");

			majorCategory.put("listSmallCategoryBy", listSmallCategoryBy(id));
			majorCategory.put("listDocumentByMC", listDocumentByMC(new Page(1,
					10), id));

			majorCategory.put("mark", true);
			majorCategory.put("notSelected", true);
		}

		return listMajorCategory;
	}

	/**
	 * 根据关键字查询
	 * 
	 * @param keyword
	 *            关键字
	 */
	public Results listKeyword(Page page, String keyword) {
		String sql = "select doc.file_name,doc.file_url,doc.video_url,doc.video_name "
				+ "from document_library doc 	 where doc.file_name like ? OR doc.video_name like ? order by doc.save_date";

		List<Object> params = new ArrayList<Object>();
		params.add("%" + keyword + "%");
		params.add("%" + keyword + "%");

		return super.list(page, params, sql);
	}

	/**
	 * 文档类型查询（如：煎炸设备、烘焙设备、制冷设备）
	 */
	public List<Map<String, Object>> listMajorCategory() {
		String sql = "SELECT dtm.id,dtm.major_category FROM document_type dtm "
				+ "LEFT JOIN document_library doc ON doc.major_category_id = dtm.id "
				+ "WHERE dtm.major_category IS NOT NULL AND doc.id IS NOT NULL "
				+ "GROUP BY dtm.id";
		return jdbcTemplate.queryForList(sql);
	}

	/**
	 * 文档属性类型查询（如：维护保养手册、产品说明书）
	 * 
	 * @param ategormajorCategoryIdyId
	 *            文档类型ID
	 */
	public List<Map<String, Object>> listSmallCategoryBy(int majorCategoryIdyId) {
		String sql = "select dts.small_category,dts.id as dtsid, dtm.id as dtmid  from document_library doc "
				+ "left join document_type dtm on doc.major_category_id = dtm.id "
				+ "left join document_type dts on doc.small_category_id = dts.id "
				+ "where dtm.id = ? group by dts.id order by doc.save_date";
		return jdbcTemplate.queryForList(sql,
				new Object[] { majorCategoryIdyId });
	}

	/**
	 * 文档查询
	 * 
	 * @param majorCategoryId
	 *            文档类型ID
	 */
	@SuppressWarnings("unchecked")
	public Results listDocumentByMC(Page page, int majorCategoryId) {

		String sql = "select "
				+ "doc.file_name,doc.file_url,doc.major_category_id,doc.video_url,doc.video_name,dts.id as dtsid "
				+ "from document_library doc "
				+ "	left join document_type dtm on doc.major_category_id = dtm.id "
				+ "	left join document_type dts on doc.small_category_id = dts.id ";
		List<Object> params = new ArrayList<Object>();
		if (majorCategoryId != 0) {
			params.add(majorCategoryId);
			sql += "where doc.major_category_id = ? ";
		}

		sql += "order by doc.save_date";

		return super.list(page, params, sql);
	}

	/**
	 * 文档查询
	 * 
	 * @param smallCategoryId
	 *            文档属性类型ID
	 * @param majorCategoryId
	 *            文档类型ID
	 */
	@SuppressWarnings("unchecked")
	public Results listDocumentBy(Page page, int smallCategoryId,
			int majorCategoryId) {
		String sql = "select "
				+ "doc.file_name, doc.file_url,doc.major_category_id,doc.video_url,doc.video_name,dts.id as dtsid "
				+ "from document_library doc "
				+ "	left join document_type dtm on doc.major_category_id = dtm.id "
				+ "	left join document_type dts on doc.small_category_id = dts.id "
				+ "where doc.major_category_id = ? and doc.small_category_id = ? "
				+ "order by doc.save_date";

		List<Object> params = new ArrayList<Object>();
		params.add(majorCategoryId);
		params.add(smallCategoryId);

		return super.list(page, params, sql);
	}
}
