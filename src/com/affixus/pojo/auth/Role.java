package com.affixus.pojo.auth;

import com.affixus.pojo.BasePojo;

public class Role extends BasePojo {

	private static final long serialVersionUID = 1L;

	private String _id;
	private String name;
	private String a;
	private boolean clientMaster;
	private boolean rateMaster;
	private boolean userMaster;
	private boolean roleMaster;
	private boolean newOrder;
	private boolean generateOrder;
	private boolean updateOrder;
	private boolean incompleteOrder;
	private boolean platformOptCalc;
	private boolean orderUpdate;
	private boolean generateInvoice;
	private boolean printInvoice;
	private boolean generateDC;
	private boolean printDC;
	private boolean platformStatusReport;
	
	public String get_id() {
		return _id;
	}

	public void set_id(String _id) {
		this._id = _id;
	}

	public String getName() {
		return name;
	}

	public void setName(String roleName) {
		this.name = roleName;
	}

	
	public boolean isNewOrder() {
		return newOrder;
	}

	public void setNewOrder(boolean newOrder) {
		this.newOrder = newOrder;
	}

	public boolean isGenerateOrder() {
		return generateOrder;
	}

	public void setGenerateOrder(boolean generateOrder) {
		this.generateOrder = generateOrder;
	}

	public boolean isUpdateOrder() {
		return updateOrder;
	}

	public void setUpdateOrder(boolean updateOrder) {
		this.updateOrder = updateOrder;
	}

	public boolean isIncompleteOrder() {
		return incompleteOrder;
	}

	public void setIncompleteOrder(boolean incompleteOrder) {
		this.incompleteOrder = incompleteOrder;
	}

	public boolean isPlatformOptCalc() {
		return platformOptCalc;
	}

	public void setPlatformOptCalc(boolean platformOptCalc) {
		this.platformOptCalc = platformOptCalc;
	}

	public boolean isOrderUpdate() {
		return orderUpdate;
	}

	public void setOrderUpdate(boolean orderUpdate) {
		this.orderUpdate = orderUpdate;
	}

	public boolean isGenerateInvoice() {
		return generateInvoice;
	}

	public void setGenerateInvoice(boolean generateInvoice) {
		this.generateInvoice = generateInvoice;
	}

	public boolean isPrintInvoice() {
		return printInvoice;
	}

	public void setPrintInvoice(boolean printInvoice) {
		this.printInvoice = printInvoice;
	}

	public boolean isGenerateDC() {
		return generateDC;
	}

	public void setGenerateDC(boolean generateDC) {
		this.generateDC = generateDC;
	}

	public boolean isPrintDC() {
		return printDC;
	}

	public void setPrintDC(boolean printDC) {
		this.printDC = printDC;
	}

	public boolean isClientMaster() {
		return clientMaster;
	}

	public void setClientMaster(boolean clientMaster) {
		this.clientMaster = clientMaster;
	}

	public boolean isRateMaster() {
		return rateMaster;
	}

	public void setRateMaster(boolean rateMaster) {
		this.rateMaster = rateMaster;
	}

	public boolean isUserMaster() {
		return userMaster;
	}

	public void setUserMaster(boolean userMaster) {
		this.userMaster = userMaster;
	}

	public boolean isRoleMaster() {
		return roleMaster;
	}

	public void setRoleMaster(boolean roleMaster) {
		this.roleMaster = roleMaster;
	}

	public boolean isPlatformStatusReport() {
		return platformStatusReport;
	}

	public void setPlatformStatusReport(boolean platformStatusReport) {
		this.platformStatusReport = platformStatusReport;
	}

}
