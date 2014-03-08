package com.jr.platform.about.service;

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
import com.jr.core.Results;

@Service("companyService")
public class CompanyService extends IService {

	protected static Log logger = LogFactory.getLog(CompanyService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Results list() {
		String sql = "SELECT email,area_name,id,cname,cimage_url,caddress_image_url,leasing_qq,complaints_qq,ctype,caddress,cphone,cfax,customer_qq,sales_qq FROM company ORDER BY ctype";
		return new Results(jdbcTemplate.queryForList(sql));
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results delete(final int[] ids) {
		return super.delete("company", ids);
	}

	public Map<String, Object> findById(int id) {
		String sql = "SELECT email,id,area_name,cname,cimage_url,caddress_image_url,leasing_qq,complaints_qq,ctype,caddress,cphone,cfax,customer_qq,sales_qq FROM company WHERE id=?";
		return jdbcTemplate.queryForMap(sql, new Object[] { id });
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(String email,String cname, String cimage_url,
			String caddress_image_url, String leasing_qq, String complaints_qq,
			String ctype, String caddress, String cphone, String cfax,
			String customer_qq, String sales_qq, String id, String area_name) {

		if (StringUtils.isEmpty(id)) {
			if (StringUtils.isEmpty(leasing_qq)) {
				leasing_qq = "0";
			}
			if (StringUtils.isEmpty(complaints_qq)) {
				complaints_qq = "0";
			}
			if (StringUtils.isEmpty(customer_qq)) {
				customer_qq = "0";
			}
			if (StringUtils.isEmpty(sales_qq)) {
				sales_qq = "0";
			}
			String sql = "INSERT INTO company(email,area_name,cname,cimage_url,caddress_image_url,leasing_qq,complaints_qq,ctype,caddress,cphone,cfax,customer_qq,sales_qq) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
			int i = jdbcTemplate.update(sql, new Object[] { email,area_name, cname,
					cimage_url, caddress_image_url,
					Integer.parseInt(leasing_qq),
					Integer.parseInt(complaints_qq), ctype, caddress, cphone,
					cfax, Integer.parseInt(customer_qq),
					Integer.parseInt(sales_qq) });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			String sql = "UPDATE company SET email=?,area_name=?,cname=?,cimage_url=?,caddress_image_url=?,leasing_qq=?,complaints_qq=?,ctype=?,caddress=?,cphone=?,cfax=?,customer_qq=?,sales_qq=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] { email,area_name,cname, cimage_url,
					caddress_image_url, Integer.parseInt(leasing_qq),
					Integer.parseInt(complaints_qq), ctype, caddress, cphone,
					cfax, Integer.parseInt(customer_qq),
					Integer.parseInt(sales_qq), Integer.parseInt(id) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}
}
