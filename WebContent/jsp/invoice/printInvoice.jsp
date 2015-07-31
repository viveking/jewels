
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
<div class="row hidden-print">
		<div class="col-xs-3">
		
			<label for="idFromToDate">Select Date</label>
			
			<div class="row">
				<div class="col-xs-8 col-sm-11">
					<div class="input-group">
						<span class="input-group-addon">
							<i class="icon-calendar bigger-110"></i>
						</span>
						<input class="form-control" type="text" name="date-range-picker" id="idFromToDate" />
					</div>
				</div>
			</div>
		</div>
		<div class="col-xs-2">
			<label ></label>
			<div class="row">
				<button id="btnGetCLient" class="btn btn-md btn-primary">
						<i class="icon-spinner"></i>
						Get Client
				</button>
			</div>
		</div>
		<div class="col-xs-3">
		
			<label for="idSelectClient">Select Client</label>
					
			<select class="width-80 chosen-select" id="idSelectClient" data-placeholder="Choose a Client...">
			</select>
		</div>
		<div class="col-xs-3">
		
			<label for="idSelectInvoice">Select Invoice</label>
					
			<select class="width-80 chosen-select" id="idSelectInvoice" data-placeholder="Choose a invoice...">
			</select>
		</div>
		<div id="alertContainer" style="position: fixed; bottom:10px; right:10px; z-index:1000">
		</div>
	</div>
	<div class="row" style="margin-top: 10px;">
		
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
			<div class="col-xs-1" style="border-right: 1px solid black; text-align: right;">
				186.00
			</div>
			<div class="col-xs-1" style="text-align: right;">
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
			<div class="col-xs-1" style="text-align: right;">
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
			<div class="col-xs-1" style="text-align: right;">
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
	<script>
	    $('input[name=date-range-picker]').daterangepicker({
	    	format: 'DD-MM-YYYY',
	    	separator: ' to '
	    	}).prev().on(ace.click_event, function(){
			$(this).next().focus();
		});
	
	    $(".chosen-select").chosen();    

	    $("#idSelectClient").chosen().change(function() {
	    	var dateRange = $('#idFromToDate').val();
			var date = dateRange.split(" to ");
			clientMap = {};
			param = {"fromDate":date[0],"toDate":date[1],"clientId":$('#idSelectClient').val()};
			console.log(param);
			$.ajax({
			  	url: '${pageContext.request.contextPath}/invoice.action?op=LIST_OF_INVOICES_BY_CLIENT_NAME',
			  	type: 'POST',
			  	data: param
			  })
			  .done(function(data) {
			  	console.log("success "+data);
			  	dataFromServer = [];
			  	dataFromServer = JSON.parse(data);
			  	
			  	if(dataFromServer){
			  		
				  	$("#idSelectInvoice").empty();
				  	
				  	//$.each(dataFromServer ,function(val){
				  		$("#idSelectInvoice").append("<option value=''></option>");
				  		
				  		for(var key in dataFromServer) {
				  			$("#idSelectInvoice").append("<option value="+key+">"+dataFromServer[key]+"<option>");
				  		}
				 // 	});
				  	
				  	$('.chosen-select').chosen().trigger("chosen:updated");
				  	
			  	}
			  	
			  })
			  .fail(function() {
			  	console.log("error]");
			  })
			  .always(function() {
			  	console.log("complete");
			  });
        });
	    
	    $("#idSelectInvoice").chosen().change(function() {
	    	
			param = {"_id":$('#idSelectInvoice').val()};
			console.log(param);
			$.ajax({
			  	url: '${pageContext.request.contextPath}/invoice.action?op=GET',
			  	type: 'POST',
			  	data: param
			  })
			  .done(function(data) {
			  	console.log("success "+data);
			  	dataFromServer = [];
			  	dataFromServer = JSON.parse(data);
			  	
			  	if(dataFromServer){
			  		
				  
			  	}
			  	
			  })
			  .fail(function() {
			  	console.log("error]");
			  })
			  .always(function() {
			  	console.log("complete");
			  });
        });
	    
	    $('#btnGetCLient').click(function(){
			var dateRange = $('#idFromToDate').val();
			var date = dateRange.split(" to ");
			clientMap = {};
			param = {"fromDate":date[0],"toDate":date[1]};
			console.log(param);
			$.ajax({
			  	url: '${pageContext.request.contextPath}/invoice.action?op=GET_CLIENTS',
			  	type: 'POST',
			  	data: param
			  })
			  .done(function(data) {
			  	console.log("success "+data);
			  	dataFromServer = [];
			  	dataFromServer = JSON.parse(data);
			  	
			  	if(dataFromServer){
			  		
				  	$("#idSelectClient").empty();
				  	$("#idSelectInvoice").empty();
				  	
			  		$("#idSelectClient").append("<option value=''></option>");
				  	$.each(dataFromServer ,function(ind,val){
				  		$("#idSelectClient").append("<option value="+val._id+">"+val.name+"<option>");
				  	});
				  	
				  	$('.chosen-select').chosen().trigger("chosen:updated");
				  	
			  	}
			  	
			  })
			  .fail(function() {
			  	console.log("error]");
			  })
			  .always(function() {
			  	console.log("complete");
			  });
		});
		    
	</script>