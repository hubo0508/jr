package com.jr.platform.learn.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.core.IService;
import com.jr.core.Page;
import com.jr.core.Results;
import com.jr.util.Util;

@Service("learnService")
public class LearnService extends IService {

	protected static Log logger = LogFactory.getLog(LearnService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Map<String, Object> find() {
		String sql = "SELECT id,file_name,file_url,video_name,video_url,video_desc FROM document_library";
		return jdbcTemplate.queryForMap(sql);
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(String id, String major_category_id,
			String small_category_id, String file_name, String video_name,
			String file_url, String video_url, String video_desc) {

		if (StringUtils.isEmpty(id)) {
			String sql = "INSERT INTO document_library(file_type,video_type,major_category_id, small_category_id, file_name, video_name, file_url, video_url,video_desc,save_date) "
					+ "VALUES (?,?,?,?,?,?,?,?,?,?)";
			int i = jdbcTemplate.update(sql, new Object[] {
					Util.toFileType(file_url), Util.toFileType(video_url),
					major_category_id, small_category_id, file_name,
					video_name, file_url, video_url, video_desc, new Date() });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE document_library SET file_type=?,video_type=?,video_desc=?, major_category_id=?,small_category_id=?,file_name=?,video_name=?,file_url=?,video_url=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] {
					Util.toFileType(file_url), Util.toFileType(video_url),
					video_desc, major_category_id, small_category_id,
					file_name, video_name, file_url, video_url,
					Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

	public Results list(Page page, String file_name, String video_name,
			String major_category_id, String small_category_id) {

		StringBuffer sb = new StringBuffer(10);
		sb
				.append("SELECT dl.id,file_name,file_url,video_name,video_url,video_desc, dt1.major_category, dt2.small_category FROM document_library dl ");
		sb
				.append("LEFT JOIN document_type dt1 on dt1.id = dl.major_category_id ");
		sb
				.append("LEFT JOIN document_type dt2 on dt2.id = dl.small_category_id ");
		sb.append("WHERE 1=1 ");

		List<Object> setparams = new ArrayList<Object>();
		if (StringUtils.isNotEmpty(file_name)) {
			sb.append(" AND file_name like ?");
			setparams.add("%" + file_name + "%");
		}
		if (StringUtils.isNotEmpty(video_name)) {
			sb.append(" AND video_name like ?");
			setparams.add("%" + video_name + "%");
		}
		if (!"null".equals(major_category_id)
				&& !"-1".equals(major_category_id)
				&& StringUtils.isNotEmpty(major_category_id)) {
			sb.append(" AND major_category_id = ?");
			setparams.add(Integer.parseInt(major_category_id));
		}
		if (!"null".equals(small_category_id)
				&& !"-1".equals(small_category_id)
				&& StringUtils.isNotEmpty(small_category_id)) {
			sb.append(" AND small_category_id = ?");
			setparams.add(Integer.parseInt(small_category_id));
		}
		sb.append(" ORDER BY dl.id DESC");

		return super.list(page, setparams, sb.toString());
	}

	public Map<String, Object> findById(int id) {
		String sql = "SELECT small_category_id,major_category_id,id,file_name,file_url,video_name,video_url,video_desc FROM document_library dl WHERE dl.id = ?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results delete(final int[] ids) {
		return super.delete("document_library", ids);
	}
	
	public List<Map<String,Object>> queryUrl(int id){
		String sql = "select file_url,video_url form document_library where id = ?";
		return jdbcTemplate.queryForList(sql,new Object[]{id});
	}
 }
