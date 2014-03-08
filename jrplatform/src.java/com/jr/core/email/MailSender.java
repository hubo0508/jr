package com.jr.core.email;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 类名:EMailUtils.java<br/> 所属类别: 发送邮件工具类<br/> 用途:
 * 基于commons-email-1.2.jar封装成相关工具方法<br/> author:<a
 * href="mailto:llnyxxzj@163.com">lilong</a> <br/> Date:2013-12-30 下午12:42:39<br/>
 * version:1.0 <br/>
 * 
 * @see commons-email-1.2.jar
 */
@Service("mailSender")
public class MailSender {

	@Autowired
	private String mailSmtp;

	@Autowired
	private String mailAddress;

	@Autowired
	private String mailAccount;

	@Autowired
	private String mailPassword;

	/**
	 * 发送简易邮件(文本邮件)
	 * 
	 * @author lilong
	 * @Date 2013-1-29
	 * @Time 上午9:23:25
	 * @param mailBasicsInformation
	 *            邮件基础信息 必须包含1、subject 2、mailContent
	 * @param toEmail
	 *            接收人邮箱地址
	 * @return
	 * 
	 */
	public boolean sendSimpleEmail(MailBasicsInformation mailBasicsInformation,
			String toEmail) {

		try {
			SimpleEmail email = new SimpleEmail();
			email.setCharset("GBK"); // 字符编码方式
			email.setHostName(this.mailSmtp);
			email.setAuthentication(this.mailAccount, this.mailPassword);
			email.setFrom(this.mailAddress);
			email.addTo(toEmail);
			// 标题
			email.setSubject(mailBasicsInformation.getMailSubject());
			// 邮件内容
			email.setMsg(mailBasicsInformation.getMailContent());
			// 发送
			email.send();

			return true;
		} catch (EmailException e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 
	 * <p>
	 * 发送html格式邮件(文本邮件)
	 * </P>
	 * 
	 * @author lilong
	 * @Date 2013-1-29
	 * @Time 下午1:52:19
	 * @param mailBasicsInformation
	 *            邮件基础信息 必须包含1、subject 2、mailContent
	 * @param toEmail
	 *            接收人邮箱地址
	 * 
	 * @return
	 * @throws EmailException
	 */
	public void sendHtmlEmail(MailBasicsInformation mailBasicsInformation,
			String toEmail) throws EmailException {

		HtmlEmail email = new HtmlEmail();
		email.setCharset("GBK"); // 字符编码方式

		email.setHostName(this.mailSmtp);
		email.setAuthentication(this.mailAccount, this.mailPassword);
		email.setFrom(this.mailAddress);
		email.addTo(toEmail);
		// 标题
		email.setSubject(mailBasicsInformation.getMailSubject());
		// 邮件内容
		email.setMsg(mailBasicsInformation.getMailContent());
		// 发送
		email.send();
	}

	public static void main(String[] args) {
		// MailBasicsInformation basicsInformation = new
		// MailBasicsInformation();
		// basicsInformation.setMailSubject("这个是一份测试邮件");
		// basicsInformation.setMailContent("这个是一份测试邮件");
		// sendHtmlEmail(basicsInformation, "llnyxxzj@163.com");
	}
}
