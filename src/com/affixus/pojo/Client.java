package com.affixus.pojo;


public class Client extends BasePojo {

	private static final long serialVersionUID = 1L;

	private String _id;
	private String clientId;
	private String name;
	private String address;
	private String city;
	private String state;
	private String country;
	private String limit;
	private String creditPeriod;
	private String vatNo;
	private String cstNo;
	private String panNo;
	private String mobileNo1;
	private String mobileNo2;
	private String email1;
	private String email2;
	private String voucherType;
	private String invoiceType;
	private String invoicePercentage;
	
	private String invisionHR;
	private String viper25;
	private String viper50;
	private String zNONE;
	private String rubberMOULD;
	
	private Boolean sendInvoiceSms = true;
	private Boolean autoApproval = false;
	private Boolean active = true;
	
	public String get_id() {
		return _id;
	}
	public void set_id(String _id) {
		this._id = _id;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getLimit() {
		return limit;
	}
	public void setLimit(String limit) {
		this.limit = limit;
	}
	public String getCreditPeriod() {
		return creditPeriod;
	}
	public void setCreditPeriod(String creditPeriod) {
		this.creditPeriod = creditPeriod;
	}
	public String getVatNo() {
		return vatNo;
	}
	public void setVatNo(String vatNo) {
		this.vatNo = vatNo;
	}
	public String getCstNo() {
		return cstNo;
	}
	public void setCstNo(String cstNo) {
		this.cstNo = cstNo;
	}
	public String getPanNo() {
		return panNo;
	}
	public void setPanNo(String panNo) {
		this.panNo = panNo;
	}
	public String getMobileNo1() {
		return mobileNo1;
	}
	public void setMobileNo1(String mobileNo1) {
		this.mobileNo1 = mobileNo1;
	}
	public String getMobileNo2() {
		return mobileNo2;
	}
	public void setMobileNo2(String mobileNo2) {
		this.mobileNo2 = mobileNo2;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getVoucherType() {
		return voucherType;
	}
	public void setVoucherType(String voucherType) {
		this.voucherType = voucherType;
	}
	public String getInvoiceType() {
		return invoiceType;
	}
	public void setInvoiceType(String invoiceType) {
		this.invoiceType = invoiceType;
	}
	public String getInvisionHR() {
		return invisionHR;
	}
	public void setInvisionHR(String invisionHR) {
		this.invisionHR = invisionHR;
	}
	public String getViper25() {
		return viper25;
	}
	public void setViper25(String viper25) {
		this.viper25 = viper25;
	}
	public String getViper50() {
		return viper50;
	}
	public void setViper50(String viper50) {
		this.viper50 = viper50;
	}
	public String getzNONE() {
		return zNONE;
	}
	public void setzNONE(String zNONE) {
		this.zNONE = zNONE;
	}
	public String getRubberMOULD() {
		return rubberMOULD;
	}
	public void setRubberMOULD(String rubberMOULD) {
		this.rubberMOULD = rubberMOULD;
	}
	public String getInvoicePercentage() {
		return invoicePercentage;
	}
	public void setInvoicePercentage(String invoicePercentage) {
		this.invoicePercentage = invoicePercentage;
	}
	public Boolean isSendInvoiceSms() {
		return sendInvoiceSms;
	}
	public void setSendInvoiceSms(Boolean sendInvoiceSms) {
		this.sendInvoiceSms = sendInvoiceSms;
	}
	public Boolean isAutoApproval() {
		return autoApproval;
	}
	public void setAutoApproval(Boolean autoApproval) {
		this.autoApproval = autoApproval;
	}
	public Boolean isActive() {
		return active;
	}
	public void setActive(Boolean active) {
		this.active = active;
	}
	

	
	

}
