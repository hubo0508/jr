package com.jr.common.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.mail.EmailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.client.about.service.CompanyCliService;
import com.jr.core.IService;
import com.jr.core.Results;
import com.jr.core.email.MailBasicsInformation;
import com.jr.core.email.MailSender;
import com.jr.util.DateConverter;
import com.jr.util.SHAHelper;

@Service("userService")
public class UserService extends IService {

	final Log log = LogFactory.getLog(UserService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private CompanyCliService companyCliService;

	@Autowired
	private MailSender mailSender;

	/**
	 * 公司内部员工登录
	 * 
	 * @param username
	 * @param password
	 */
	public Map<String, Object> login(String username, String password) {
		try {
			final String sql = "SELECT u.username, u.user_type, u.status, u.id, r.role_admin FROM users u left join role r on u.role_id = r.id " +
					"WHERE u.username=? and u.password=? and u.user_type=0";
			Object[] params = new Object[] { username,
					SHAHelper.convert(password) };
			return jdbcTemplate.queryForMap(sql, params);
		} catch (org.springframework.dao.EmptyResultDataAccessException e) {
			log.error(e.getMessage(), e);
			return null;
		}
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public int insert(final String username, final String password,
			final int user_type, final int status, final int rolenameid) {

		final String sql = "INSERT INTO users(username, password,user_type, status, registration_time,role_id) VALUES (?,?,?,?,?,?)";

		KeyHolder keyHolder = new GeneratedKeyHolder();
		int i = jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection conn)
					throws SQLException {
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, username);
				ps.setString(2, SHAHelper.convert(password));
				ps.setInt(3, user_type);
				ps.setInt(4, status);
				ps.setDate(5, new java.sql.Date(new Date().getTime()));
				ps.setInt(6, rolenameid);
				return ps;
			}
		}, keyHolder);

		if (i == 1) {
			return keyHolder.getKey().intValue();
		}

		throw new RuntimeException();
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results save(String id, final String username,
			final String password, final int user_type, final int status) {

		if (StringUtils.isEmpty(id)) {

			final String sql = "INSERT INTO users(username, password,user_type, status, registration_time) VALUES (?,?,?,?,?)";

			KeyHolder keyHolder = new GeneratedKeyHolder();
			jdbcTemplate.update(new PreparedStatementCreator() {
				@Override
				public PreparedStatement createPreparedStatement(Connection conn)
						throws SQLException {
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1, username);
					ps.setString(2, SHAHelper.convert(password));
					ps.setInt(3, user_type);
					ps.setInt(4, status);
					ps.setDate(5, new java.sql.Date(new Date().getTime()));
					return ps;
				}
			}, keyHolder);

			int i = jdbcTemplate.update(sql,
					new Object[] { username, SHAHelper.convert(password),
							user_type, status, new Date() });

			if (i == 1) {
				return Results.SUCCESS;
			}

			throw new RuntimeException();

		} else {

		}

		throw new RuntimeException();
	}

	public Results updateByStatusAndRole(int status, int uid, int role_id,
			String password) {

		Object[] params = new Object[] { role_id, status, uid };
		String sql = "UPDATE users SET role_id=?,status=? WHERE id=?";
		if (StringUtils.isNotEmpty(password)) {
			sql = "UPDATE users SET role_id=?,status=?,password=? WHERE id=?";
			params = new Object[] { role_id, status,
					SHAHelper.convert(password), uid };
		}

		int i = jdbcTemplate.update(sql, params);

		if (i == 1) {
			return Results.SUCCESS;
		}

		throw new RuntimeException();
	}

	/**
	 * 查询第三方用户信息
	 * 
	 * @param userid
	 * @return
	 */
	public Map<String, Object> queryUsersWithOther(int userid) {
		String sql = "select u.username,tpu.contact_email from third_part_users tpu  left join users u on u.id = tpu.users_id WHERE u.id=?";
		return jdbcTemplate.queryForMap(sql, new Object[] { userid });
	}

	public Results updateByStatusAndRole(int status, int uid, int role_id) {
		String sql = "UPDATE users SET role_id=?,status=? WHERE id=?";
		int i = jdbcTemplate.update(sql, new Object[] { role_id, status, uid });

		if (i == 1) {
			return Results.SUCCESS;
		}

		throw new RuntimeException();
	}

	/**
	 * 修改密码
	 */
	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results updatepassword(String username, String oldPassword,
			String newPassword) {

		String sql = "UPDATE users SET password=? WHERE username=? AND password=?";
		int i = jdbcTemplate.update(sql, new Object[] {
				SHAHelper.convert(newPassword), username,
				SHAHelper.convert(oldPassword) });
		if (i == 1) {
			return Results.SUCCESS;
		} else {
			return new Results(false, "旧密码不匹配，请确认！");
		}
	}

	/**
	 * 根据id删除数据
	 * 
	 * @param id
	 * @return
	 */
	@Transactional(isolation = Isolation.REPEATABLE_READ)
	public Results delete(int id) {
		return super.delete("users", id);
	}

	/**
	 * 修改密码
	 */
	public boolean updatepassword(int usersId, String password) {

		String sql = "UPDATE users SET password=? WHERE id=? ";
		int i = jdbcTemplate.update(sql, new Object[] {
				SHAHelper.convert(password), usersId });
		if (i == 1) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 重置密码
	 * 
	 * @param usersId
	 *            用户ID
	 * @param password
	 *            新密码
	 * @param username
	 *            用户名
	 * @param contactEmail
	 *            注册email
	 * 
	 * @throws EmailException
	 */
	@Transactional(isolation = Isolation.REPEATABLE_READ, rollbackFor = Exception.class)
	public Results resetDefaultPassword(int usersId, String password,
			String username, String contactEmail) throws EmailException {

		String sql = "UPDATE users SET password=? WHERE id=? ";
		int i = jdbcTemplate.update(sql, new Object[] {
				SHAHelper.convert(password), usersId });

		if (i == 1) {

			MailBasicsInformation basicsInformation = new MailBasicsInformation();
			basicsInformation.setMailSubject("成都金嵘厨房会员密码找回");

			StringBuffer stringBuffer = new StringBuffer();
			stringBuffer.append("<h3 style='font-size:12px; font-family:'宋体''>"
					+ username + "您的账户注册信息已修改，以下为修改信息：</h3>");
			stringBuffer
					.append("<p style='font-size:12px; font-family:'宋体'; color:#06F'>用户名:"
							+ username + "</p>");
			stringBuffer
					.append("<p style='font-size:12px; font-family:'宋体'; color:#06F'>密码:"
							+ password + "</p>");

			String companyName = companyCliService.queryCompanyName();
			stringBuffer.append("<p style='font-size:12px;font-family:'宋体'>"
					+ companyName + "</p>");

			stringBuffer.append("<p style='font-size:12px;font-family:'宋体''>"
					+ DateConverter.convert(new Date(), "yyyy-MM-dd HH:mm:ss")
					+ "</p>");

			basicsInformation.setMailContent(stringBuffer.toString());
			mailSender.sendHtmlEmail(basicsInformation, contactEmail);

			return new Results("已将密码发送至您邮箱，请注意查收！");

		} else {
			return new Results("重置密码失败，请稍后再试！");
		}
	}

}
