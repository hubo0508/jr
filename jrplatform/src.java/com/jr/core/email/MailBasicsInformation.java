package com.jr.core.email;


/**
 * 
 * <p>
 * 邮件基础信息实体类字段
 * <p>
 * 
 * @Author:<a href="mailto:llnyxxzj@163.com">lilong</a> <br/>
 * @Date:2013-1-29<br/>
 * @Time:上午9:30:06 <br/>
 * @Version:1.0 <br/>
 */
public class MailBasicsInformation {
	/** 主键 */
	private int id;
	/** 邮件标题 */
	private String mailSubject;
	/** 邮件内容 */
	private String mailContent;
	/** 模块代码 */
	private String modulecode;
	/** 创建时间 */
	private String createDate;
	/** 备注 */
	private String remark;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMailSubject() {
		return mailSubject;
	}

	public void setMailSubject(String mailSubject) {
		this.mailSubject = mailSubject;
	}

	public String getMailContent() {
		return mailContent;
	}

	public void setMailContent(String mailContent) {
		this.mailContent = mailContent;
	}

	public String getModulecode() {
		return modulecode;
	}

	public void setModulecode(String modulecode) {
		this.modulecode = modulecode;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
