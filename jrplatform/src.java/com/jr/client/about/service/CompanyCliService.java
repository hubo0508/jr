/**
 * 
 */
package com.jr.client.about.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.jr.core.IService;

@Service("companyCliService")
public class CompanyCliService extends IService {
	protected static Log logger = LogFactory.getLog(CompanyCliService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	/**
	 * 公司规模/联系金嵘
	 */
	public List<Map<String, Object>> queryCompany(int type) {
		String sql = "select email,cname,cfax,cphone,caddress  from company where ctype=?";
		return jdbcTemplate.queryForList(sql,new Object[]{type});
	}

	/**
	 * 查询公司名称
	 */
	public String queryCompanyName() {
		String sql = "select cname from company where ctype = 0 ";
		List<Map<String, Object>> jr = jdbcTemplate.queryForList(sql);
		if (jr == null) {
			return "成都金嵘厨房设备维修服务有限公司";
		} else {
			return (String) jr.get(0).get("cname");
		}
	}
}
