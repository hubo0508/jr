package com.jr.platform.about.service;

import java.util.ArrayList;
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

import com.jr.common.service.UserService;
import com.jr.core.Constants;
import com.jr.core.IService;
import com.jr.core.Page;
import com.jr.core.Results;

@Service("employeeService")
public class EmployeeService extends IService {

	protected static Log logger = LogFactory.getLog(EmployeeService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private UserService userService;

	public Results list(Page page, String status, String rolenameid,
			String sTime, String eTime) {
		StringBuffer sb = new StringBuffer(10);
		sb
				.append("select u.id as uid, u.username, u.status,r.rolename,e.id as eid, u.login_count, date_format(u.last_login_time,'%Y-%m-%d %h:%i') as last_login_time, ");
		sb
				.append("date_format(u.registration_time,'%Y-%m-%d') as registration_time,");
		sb.append("e.id as eid, e.ename,e.ephone,e.ejob ");
		sb
				.append("from users u left join employee e on u.id = e.users_id left join role r on r.id = u.role_id ");
		sb.append("where u.user_type = 0 ");

		List<Object> setparams = new ArrayList<Object>();
		if (!"null".equals(status) && !"-1".equals(status)
				&& StringUtils.isNotEmpty(status)) {
			sb.append(" AND u.status = ?");
			setparams.add(Integer.parseInt(status));
		}
		if (!"null".equals(rolenameid) && !"-1".equals(rolenameid)
				&& StringUtils.isNotEmpty(rolenameid)) {
			if("-2".equals(rolenameid)){
				sb.append(" AND r.id IS NULL");
			}else{
				sb.append(" AND r.id = ?");
				setparams.add(Integer.parseInt(rolenameid));
			}
		}
		if (StringUtils.isNotEmpty(sTime) && StringUtils.isNotEmpty(eTime)) {
			sb
					.append(" AND u.registration_time >= ? AND u.registration_time <= ?");
			setparams.add(sTime);
			setparams.add(eTime);
		} else {
			if (StringUtils.isNotEmpty(sTime)) {
				sb.append(" AND u.registration_time >= ?");
				setparams.add(sTime);
			}
			if (StringUtils.isNotEmpty(eTime)) {
				sb.append(" AND u.registration_time <= ?");
				setparams.add(eTime);
			}
		}

		return super.list(page, setparams, sb.toString());
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(String role_id, String eid, String uid,
			String rolenameid, String status, String username, String ename,
			String ephone, String ejob,String password) {

		if (StringUtils.isEmpty(eid)) {
			
			if(StringUtils.isEmpty(password)){
				password = username;
			}

			int userid = this.userService.insert(username, password,
					Constants.INTERNAL, Integer.parseInt(status), Integer
							.parseInt(rolenameid));

			String sql = "INSERT INTO employee(users_id,ename,ephone,ejob) VALUES (?,?,?,?)";
			int i = jdbcTemplate.update(sql, new Object[] { userid, ename,
					ephone, ejob });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {
			
			userService.updateByStatusAndRole(Integer.parseInt(status), Integer
					.parseInt(uid), Integer.parseInt(rolenameid),password);

			String sql = "UPDATE employee SET ename=?,ephone=?,ejob=? WHERE id=?";
			int i = jdbcTemplate.update(sql, new Object[] { ename, ephone,
					ejob, Integer.parseInt(eid) });

			if (i == 1) {
				return Results.SUCCESS;
			}
		}

		throw new RuntimeException();
	}

	public Map<String, Object> findById(int eid) {
		StringBuffer sb = new StringBuffer(10);
		sb
				.append("select u.id as uid, e.id as eid, u.username, u.status,r.rolename, u.login_count, date_format(u.last_login_time,'%Y-%m-%d %h:%i') as last_login_time, ");
		sb
				.append("date_format(u.registration_time,'%Y-%m-%d') as registration_time,");
		sb.append("e.id as eid, e.ename,e.ephone,e.ejob ");
		sb
				.append("from users u left join employee e on u.id = e.users_id left join role r on r.id = u.role_id ");
		sb.append("where u.user_type = 0 AND e.id = ?");
		return jdbcTemplate.queryForMap(sb.toString(), new Object[] { eid });
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results delete(String ids) {

		String[] idsarr = ids.split(",");
		for (int i = 0; i < idsarr.length; i++) {
			String[] uidAndEid = idsarr[i].split("_");

			int uid = 0;
			try {
				uid = Integer.parseInt(uidAndEid[1]);
			} catch (NumberFormatException e) {
			}
			if (uid != 0) {
				super.delete("users", uid);
			}

			int eid = 0;
			try {
				eid = Integer.parseInt(uidAndEid[0]);
			} catch (NumberFormatException e) {
			}
			if (eid != 0) {
				super.delete("employee", eid);
			}
		}

		return Results.SUCCESS;
	}
}
