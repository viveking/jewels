
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.col-xs-1{
		padding-left:2px;
	}
</style>
<div class="page-header">
	<h1>
		Print Invoice
		<small>
			<i class="icon-double-angle-right"></i>
			Print Order Invoice.
		</small>
	</h1>
</div><!-- /.page-header -->
<div>
	<div class="col-xs-12 text-center" style="border: 1px solid black">
		<b>TAX INVOICE</b>
	</div>
	
	<div class="col-xs-12" style="border: 1px solid black; border-top:0px;">
	
		<div class="col-xs-4" style="border-right: 1px solid black;">
			<p><small>
				Jyoti Solutions,<br/>
				Plot No 43, Road No. 14, MIDC,<br/>
				Andheri(E),<br/>
				MUMBAI - 93<br/>
				Ph. 022-12345665/66<br/>
				Email. <a href="mailto:info@jyotisolutions.in">info@jyotisolutions.in</a>
				</small>
			</p>
		</div>
		<div class="col-xs-4" style="border-right: 1px solid black; height: 124px">
			<p>
				Inv No:<br/>
				Inv Date:
			</p>
		</div>
		<div class="col-xs-4 text-center" >
			<p><big>Vivek Singh</big><br/>
			Kharghar</p>
		</div>
	</div>
	
	<div class="col-xs-12" style="border: 1px solid black; border-top:0px;">
		<div class="col-xs-1" style="border-right: 1px solid black;">
			Sr.No.
		</div>
		<div class="col-xs-2" style="border-right: 1px solid black;">
			Order No
		</div>
		<div class="col-xs-2" style="border-right: 1px solid black;">
			DC No
		</div>
		<div class="col-xs-3" style="border-right: 1px solid black;">
			Process
		</div>
		<div class="col-xs-2" style="border-right: 1px solid black;">
			Weight(Kg)
		</div>
		<div class="col-xs-1" style="border-right: 1px solid black;">
			Amount
		</div>
		<div class="col-xs-1">
			Total
		</div>
	</div>
	
	<!--TODO: For loop to populate orders... -->

	<div class="col-xs-12" style="border: 1px solid black; border-top:0px;"><small>
		<div class="col-xs-1" style="border-right: 1px solid black;">
			1
		</div>
		<div class="col-xs-2" style="border-right: 1px solid black;">
			OR1234
		</div>
		<div class="col-xs-2" style="border-right: 1px solid black;">
			DC1234
		</div>
		<div class="col-xs-3" style="border-right: 1px solid black;">
			CASTING
		</div>
		<div class="col-xs-2" style="border-right: 1px solid black;">
			0.62
		</div>
		<div class="col-xs-1" style="border-right: 1px solid black;">
			186.00
		</div>
		<div class="col-xs-1">
			480.00
		</div></small>
	</div>
	
	<!--TODO: For loop ENDS to populate orders... -->
	
	<div class="col-xs-12" style="border: 1px solid black; border-top:0px;"><small>
		<div class="col-xs-8">
			<big>Amt (in words): One thousand and Forty-Two</big><br/>
			<br/>
			VAT TIN: 2123123123123123<br/>
			CST No: 23423423123123<br/>
			
		</div>
		<div class="col-xs-3" style="outline: 1px solid black;">
			Gross:<br/>
			Discount:<br/>
			Amount:<br/>
			Tax @ 1%:<br/>
			Amount:<br/>
			StampCharges:<br/>
			CourierCharges:<br/>
			TotalAmount:<br/>
		</div>
		<div class="col-xs-1">
			1032.00<br/>
			0.00<br/>
			1032.00<br/>
			10.32<br/>
			1042.32<br/>
			0.00<br/>
			0.00<br/>
			1042.00<br/>
		</div>
		</small>
	</div>
	
	<div class="col-xs-12" style="border: 1px solid black; border-top:0px;"><small>
		<div class="col-xs-8">
			
		</div>
		<div class="col-xs-3" style="outline: 1px solid black;">
			Grand Total:
		</div>
		<div class="col-xs-1">
			1042.00
		</div>
		</small>
	</div>
	
	<div class="col-xs-12" style="border: 1px solid black; border-top:0px;"><small>
		<div class="col-xs-8" style="border-right: 1px solid black;">
			If you have any query in the bill kindly intimate us within 24 hrs.<br/>
			Created By: <b>Vivek Singh</b> 
		</div>
		<div class="col-xs-4">
			For Jyoti Solutions
		</div>
		</small>
	</div>
	<div class="col-xs-12" style="border: 1px solid black; border-top:0px;"><small>
		<div class="col-xs-8" style="border-right: 1px solid black;">
			Receivers Signature
		</div>
		<div class="col-xs-4">
			Authorised Signatory
		</div>
		</small>
	</div>
</div>