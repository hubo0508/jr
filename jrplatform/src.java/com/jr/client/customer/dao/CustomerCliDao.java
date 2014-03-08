package com.jr.client.customer.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.jr.util.SHAHelper;

@Repository("customerDao")
public class CustomerCliDao {

	protected Log logger = LogFactory.getLog(CustomerCliDao.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	/**
	 * 公司内部员工登录
	 * 
	 * <ul>
	 * <li>user_type：0公司内部员工，1第三方用户</li>
	 * <li>status：0帐号可用，1帐号不可用</li>
	 * </ul>
	 */
	public Map<String, Object> login(String username, String password) {
		try {
			final String sql = "SELECT u.username, u.user_type, u.status,u.id,r.rolename,r.video_play "
					+ "FROM users u LEFT JOIN role r ON r.id = u.role_id "
					+ "WHERE u.username=? and u.password=? and status = 0";

			return jdbcTemplate.queryForMap(sql, new Object[] { username,
					SHAHelper.convert(password) });
		} catch (org.springframework.dao.EmptyResultDataAccessException e) {
			logger.error(e.getMessage(), e);
			return null;
		}
	}

	/**
	 * 查询第三方用户文档浏览与视频权限
	 */
	public List<Map<String, Object>> queryDocumentPermissionsToUsers(int uid) {
		String sql = "select u.id as uid, r.video_play, dt.id as doctypeid, dt.small_category "
				+ "from users u left join role r on u.role_id = r.id "
				+ " left join role_documenttype rd on rd.role_id = r.id "
				+ " left join document_type dt on dt.id = rd.document_type_id "
				+ "WHERE u.id=? and u.user_type=1 and u.status = 0";
		return jdbcTemplate.queryForList(sql, new Object[] { uid });
	}

	public int verifyUsername(String username) {
		final String sql = "select count(id) from users where username=?";
		return jdbcTemplate.queryForInt(sql, new Object[] { username });
	}

	public int verifyPassword(String username, String password) {
		final String sql = "select count(id) from users where username=? and password=?";
		return jdbcTemplate.queryForInt(sql, new Object[] { username,
				SHAHelper.convert(password) });
	}

	public int verifyStatusByUsernameAndEmail(String username,
			String contactEmail) {
		String sql = "select u.status from third_part_users tpu left join users u on u.id = tpu.users_id "
				+ "WHERE u.username=? AND tpu.contact_email=?";
		return jdbcTemplate.queryForInt(sql, new Object[] { username,
				contactEmail });
	}

	public int verifyAccountStatus(String username, String password) {
		final String sql = "select count(id) from users where username=? and password=?";
		return jdbcTemplate.queryForInt(sql, new Object[] { username,
				SHAHelper.convert(password) });
	}

	public int verifyUsernameAndEmailWidthOther(String username,
			String contactEmail) {
		String sql = "select count(tpu.id) from third_part_users tpu left join users u on u.id = tpu.users_id "
				+ "WHERE u.username=? AND tpu.contact_email=?";
		return jdbcTemplate.queryForInt(sql, new Object[] { username,
				contactEmail });
	}

	/**
	 * 取得第三方用户ID
	 * 
	 * @param username
	 * @param contactEmail
	 * @return
	 */
	public Map<String, Object> getUsersIdWidthOther(String username, String contactEmail) {
		try {
			String sql = "select tpu.users_id from third_part_users tpu  left join users u on u.id = tpu.users_id "
					+ "WHERE u.username=? AND tpu.contact_email=? AND u.status = 0";
			return jdbcTemplate.queryForMap(sql, new Object[] { username,
					contactEmail });
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
}
