package com.jr.platform.member.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.mail.EmailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.jr.client.about.service.CompanyCliService;
import com.jr.common.service.UserService;
import com.jr.core.IService;
import com.jr.core.Page;
import com.jr.core.Results;
import com.jr.core.email.MailBasicsInformation;
import com.jr.core.email.MailSender;
import com.jr.util.DateConverter;

@Service("memberService")
public class MemberService extends IService {

	protected Log log = LogFactory.getLog(MemberService.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private UserService userService;

	@Autowired
	private CompanyCliService companyCliService;

	@Autowired
	private MailSender mailSender;

	/**
	 * user_type => 0：公司员工，1：第三方用户
	 */
	public Results list(Page page, String status, String rolenameid,
			String vido_play, String sTime, String eTime, String company_name,
			String contact, String phone, String company_nature,
			String business_areas) {

		String sql = "SELECT tpu.id as tpuid, u.id as uid, u.status, u.username, "
				+ "u.login_count, date_format(u.last_login_time,'%Y-%m-%d %h:%i') as last_login_time, "
				+ "r.rolename,r.video_play,tpu.company_name, "
				+ "tpu.company_address,tpu.contact,tpu.where_department,tpu.fixed_telephone, "
				+ "tpu.phone,tpu.contact_email,tpu.company_nature,tpu.business_areas, "
				+ "tpu.contact_email,tpu.company_nature,tpu.business_areas, "
				+ "date_format(u.registration_time,'%Y-%m-%d') as registration_time "
				+ "FROM users u "
				+ "LEFT JOIN third_part_users tpu ON u.id = tpu.users_id LEFT JOIN role r ON u.role_id = r.id "
				+ "WHERE u.user_type = 1";

		StringBuffer sb = new StringBuffer();
		sb.append(sql);

		List<Object> setparams = new ArrayList<Object>();
		if (!"null".equals(status) && !"-1".equals(status)
				&& StringUtils.isNotEmpty(status)) {
			sb.append(" AND u.status = ?");
			setparams.add(Integer.parseInt(status));
		}
		if (!"null".equals(rolenameid) && !"-1".equals(rolenameid)
				&& StringUtils.isNotEmpty(rolenameid)) {
			sb.append(" AND r.id = ?");
			setparams.add(Integer.parseInt(rolenameid));
		}
		if (!"null".equals(vido_play) && !"-1".equals(vido_play)
				&& StringUtils.isNotEmpty(vido_play)) {
			sb.append(" AND r.video_play = ?");
			setparams.add(Integer.parseInt(vido_play));
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
		if (StringUtils.isNotEmpty(company_name)) {
			sb.append(" AND tpu.company_name like ?");
			setparams.add("%" + company_name + "%");
		}
		if (StringUtils.isNotEmpty(contact)) {
			sb.append(" AND tpu.contact like ?");
			setparams.add("%" + contact + "%");
		}
		if (StringUtils.isNotEmpty(phone)) {
			sb.append(" AND tpu.phone like ?");
			setparams.add("%" + phone + "%");
		}
		if (StringUtils.isNotEmpty(company_nature)) {
			sb.append(" AND tpu.company_nature like ?");
			setparams.add("%" + company_nature + "%");
		}
		if (StringUtils.isNotEmpty(business_areas)) {
			sb.append(" AND tpu.business_areas like ?");
			setparams.add("%" + business_areas + "%");
		}
		sb.append(" ORDER BY u.status DESC, u.user_type");

		return super.list(page, setparams, sb.toString());
	}

	/**
	 * 第三方用户审核。审核状态为冻结与通过时，发送邮件
	 * 
	 * @param role_id
	 * @param rolenameid
	 * @param uid
	 *            用户id
	 * @param status
	 *            0:正常，1：冻结，2：待审批
	 * @return
	 */
	@Transactional(isolation = Isolation.REPEATABLE_READ, rollbackFor = Exception.class)
	public Results save(String rolenameid, String uid, String status) {

		Results r = userService.updateByStatusAndRole(Integer.parseInt(status),
				Integer.parseInt(uid), Integer.parseInt(rolenameid));

		if (r.isSuccess() && ("0".equals(status) || "1".equals(status))) {
			String companyName = companyCliService.queryCompanyName();
			Map<String, Object> users = userService.queryUsersWithOther(Integer
					.parseInt(uid));

			MailBasicsInformation basics = new MailBasicsInformation();
			basics.setMailSubject("成都金嵘厨房会员注册");

			StringBuffer sb = new StringBuffer();
			if ("0".equals(status)) {
				sb.append("<h3 style='font-family:'宋体''>"
						+ users.get("username") + "您好！您的帐号已激活！</h3>");
			}
			if ("1".equals(status)) {
				sb.append("<h3 style='font-family:'宋体''>"
						+ users.get("username") + "您好！您的帐号存在异常已被冻结！</h3>");
			}

			sb.append("<p style='font-size:12px;font-family:'宋体'>"
					+ companyName + "</p>");
			sb.append("<p style='font-size:12px;font-family:'宋体''>"
					+ DateConverter.convert(new Date(), "yyyy-MM-dd HH:mm:ss")
					+ "</p>");

			basics.setMailContent(sb.toString());
			try {
				mailSender.sendHtmlEmail(basics, (String) users
						.get("contact_email"));
			} catch (EmailException e) {
				log.error(e.getMessage(), e);
			}
		}

		return r;
	}

	public Map<String, Object> findById(int id) {
		StringBuffer sb = new StringBuffer(10);
		sb
				.append("select tpu.id as tpuid, u.id as uid, u.status, u.username,u.login_count, date_format(u.last_login_time,'%Y-%m-%d %h:%i') as last_login_time, ");
		sb
				.append("  r.rolename,r.video_play,r.id as role_id,tpu.company_name,");
		sb.append("  tpu.company_address,tpu.contact,tpu.where_department,");
		sb.append("  tpu.fixed_telephone,tpu.phone,tpu.contact_email,");
		sb.append("  tpu.company_nature,tpu.business_areas,");
		sb.append("  tpu.contact_email,tpu.company_nature,tpu.business_areas,");
		sb
				.append("date_format(u.registration_time,'%Y-%m-%d') as registration_time ");

		sb
				.append("from users u left join third_part_users tpu on u.id = tpu.users_id left join role r  on u.role_id = r.id ");
		sb.append(" where u.user_type = 1 AND u.id = ?");
		return jdbcTemplate.queryForMap(sb.toString(), new Object[] { id });
	}

	@Transactional(isolation = Isolation.REPEATABLE_READ, rollbackFor = Exception.class)
	public Results delete(String id) {

		String[] ids = id.split(",");
		for (int i = 0; i < ids.length; i++) {
			String[] tpuidAndUid = ids[i].split("_");

			String tpuid = tpuidAndUid[0];
			String uid = tpuidAndUid[1];

			try {
				this.userService.delete(Integer.parseInt(uid));
				super.delete("third_part_users", Integer.parseInt(tpuid));
			} catch (Throwable e) {
				log.debug("删除数据失败『tpuid=" + tpuid + ",uid=" + uid + "』", e);
				return Results.FAILURE;
			}
		}

		return Results.SUCCESS;
	}
}
