package com.jr.platform.domain;

import java.util.Date;

public class Users {

	private Integer id;

	private String username;

	private String password;

	private Date registrationTime;
	
	private int userType;//0：公司员工，1：第三方用户
	
	private int status;//0帐号不可用，1帐号可用
	
	// -------------第三方------------------------

	private String companyName;//

	private String companyAddress;// 公司地址

	private String contact;// 联系人

	private String whereDepartment;// 所在部门

	private String fixedTelephone;// 固定电话

	private String phone;// 手机

	private String contactEmail;// 联系人邮箱

	private String companyNature;// 公司性质

	private String businessAreas;// 经营领域

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getRegistrationTime() {
		return registrationTime;
	}

	public void setRegistrationTime(Date registrationTime) {
		this.registrationTime = registrationTime;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCompanyAddress() {
		return companyAddress;
	}

	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getWhereDepartment() {
		return whereDepartment;
	}

	public void setWhereDepartment(String whereDepartment) {
		this.whereDepartment = whereDepartment;
	}

	public String getFixedTelephone() {
		return fixedTelephone;
	}

	public void setFixedTelephone(String fixedTelephone) {
		this.fixedTelephone = fixedTelephone;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getContactEmail() {
		return contactEmail;
	}

	public void setContactEmail(String contactEmail) {
		this.contactEmail = contactEmail;
	}

	public String getCompanyNature() {
		return companyNature;
	}

	public void setCompanyNature(String companyNature) {
		this.companyNature = companyNature;
	}

	public String getBusinessAreas() {
		return businessAreas;
	}

	public void setBusinessAreas(String businessAreas) {
		this.businessAreas = businessAreas;
	}

	public int getUserType() {
		return userType;
	}

	public void setUserType(int userType) {
		this.userType = userType;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

}
