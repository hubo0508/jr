package com.jr.client.customer.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.mail.EmailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.client.about.service.CompanyCliService;
import com.jr.client.customer.dao.CustomerCliDao;
import com.jr.common.service.CommonUsersService;
import com.jr.common.service.UserService;
import com.jr.core.Constants;
import com.jr.core.Results;
import com.jr.core.email.MailSender;
import com.jr.core.email.MailBasicsInformation;
import com.jr.util.DateConverter;
import com.jr.util.Util;

@Service("customerCliService")
public class CustomerCliService {

	protected Log logger = LogFactory.getLog(CustomerCliService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private UserService userService;

	@Autowired
	private CustomerCliDao customerDao;

	@Autowired
	private CommonUsersService commonUsersService;

	@Autowired
	private CompanyCliService companyCliService;

	@Autowired
	private MailSender mailSender;

	/**
	 * 根据用户ID查询文档库权限
	 * 
	 * @param userid
	 */
	public Map<String, String> queryDocumentPermissionsToUsers(int userid) {

		String docPre = "";
		String videoPre = "";

		try {
			List<Map<String, Object>> pre = customerDao
					.queryDocumentPermissionsToUsers(userid);
			for (int i = 0; i < pre.size(); i++) {
				Map<String, Object> premap = pre.get(i);
				docPre += premap.get("doctypeid") + ",";
				if (i == 0) {
					videoPre += premap.get("video_play");
				}
			}
		} catch (RuntimeException e) {
			logger.error(e.getMessage(), e);
		}

		Map<String, String> rMap = new HashMap<String, String>();
		rMap.put("docPre", docPre);
		rMap.put("videoPre", videoPre);

		return rMap;
	}

	public Results login(String username, String password) {

		Map<String, Object> cResust = customerDao.login(username, password);

		// 判断是何原因导致用户失败
		if (cResust == null) {

			// 判断用户名是否存在
			if (customerDao.verifyUsername(username) == 0) {
				return new Results(false, "用户'" + username + "'未注册，请现注册！");
			}

			// 判断密码是否错误
			if (customerDao.verifyPassword(username, password) == 0) {
				return new Results(false, "密码错误！");
			}

			// 判断用户状态
			if (customerDao.verifyAccountStatus(username, password) == 1) {
				return new Results(false, "用户'" + username + "'已禁止登录，请联系金嵘客服!");
			}
		} else {

			// 写日志
			commonUsersService.updateUserLog(username);
			return new Results(cResust);
		}

		return null;
	}

	/**
	 * 第三方用户注册，注册成功发送邮件。
	 * 
	 * @throws EmailException
	 */
	@Transactional(isolation = Isolation.REPEATABLE_READ, rollbackFor = Exception.class)
	public Results save(String username, String password, String kaptcha,
			String company_name, String company_address, String contact,
			String where_department, String fixed_telephone, String phone,
			String contact_email, String company_nature, String business_areas)
			throws EmailException {

		int userid = this.userService.insert(username, password,
				Constants.THIRD_PARTY, Constants.PENDING, 0);

		String sql = "INSERT INTO third_part_users(users_id,company_name,company_address,contact,where_department,"
				+ "fixed_telephone,phone,contact_email,company_nature,business_areas) VALUES (?,?,?,?,?,?,?,?,?,?)";
		int i = jdbcTemplate.update(sql, new Object[] { userid, company_name,
				company_address, contact, where_department, fixed_telephone,
				phone, contact_email, company_nature, business_areas });

		if (i == 1) {

			String companyName = companyCliService.queryCompanyName();

			MailBasicsInformation basics = new MailBasicsInformation();
			basics.setMailSubject("成都金嵘厨房会员注册");

			StringBuffer sb = new StringBuffer();
			sb.append("<h3 style='font-family:'宋体''>" + username
					+ "您已是成都金嵘厨房准会员，我们将对您提供的注册信息进行审核，请及时留意邮箱邮件！</h3>");

			sb.append("<p style='font-size:12px;font-family:'宋体'>"
					+ companyName + "</p>");
			sb.append("<p style='font-size:12px;font-family:'宋体''>"
					+ DateConverter.convert(new Date(), "yyyy-MM-dd HH:mm:ss")
					+ "</p>");

			basics.setMailContent(sb.toString());
			mailSender.sendHtmlEmail(basics, contact_email);

			return new Results("用户'" + username
					+ "'注册成功，我们将对您提供的注册信息进行审核，请及时留意邮箱邮件！");
		}

		throw new RuntimeException();
	}

	public Map<String, Object> queryAccount(String username) {
		String sql = "select u.username, tpu.* from users u left join third_part_users tpu on u.id = tpu.users_id "
				+ "where u.username = ?";
		return jdbcTemplate.queryForMap(sql, new Object[] { username });
	}

	public Map<String, Object> getCustomer(int id) {
		String sql = "select * from customer where id=? ";
		return jdbcTemplate.queryForMap(sql, id);
	}

	/**
	 * 忘记密码
	 * 
	 * @param username
	 *            用户名
	 * @param contactEmail
	 *            注册邮箱
	 * @return Results
	 * @throws EmailException
	 *             发送邮件异常
	 */
	public Results forgotpassword(String username, String contactEmail)
			throws EmailException {

		Map<String, Object> user = customerDao.getUsersIdWidthOther(username,
				contactEmail);
		if (user == null) {

			// 检查用户名是否存在
			if (customerDao.verifyUsername(username) == 0) {
				return new Results(false, "用户'" + username + "'未注册，请现注册！");
			}

			// 检查用户名与email是否匹配
			if (customerDao.verifyUsernameAndEmailWidthOther(username,
					contactEmail) == 0) {
				return new Results(false, "注册邮箱与用户'" + username + "'不匹配！");
			}

			// 检查用户状态
			int status = customerDao.verifyStatusByUsernameAndEmail(username,
					contactEmail);
			if (status == 1) {
				return new Results(false, "用户'" + username + "'已被冻结!");
			}
			if (status == 2) {
				return new Results(false, "用户'" + username + "'正在审核中！");
			}
		}

		return userService.resetDefaultPassword((Integer) user.get("users_id"),
				Util.randomPassword(), username, contactEmail);
	}
}