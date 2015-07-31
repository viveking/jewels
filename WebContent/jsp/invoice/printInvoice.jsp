
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
	<div class="row invoiceContainer" style="margin-top: 10px;">
		
		<div class="col-xs-12 text-center" style="border: 1px solid black">
			<b>TAX INVOICE</b>
		</div>
		
		<div class="col-xs-12" style="border: 1px solid black; border-top:0px;">
		
			<div class="col-xs-4" style="border-right: 1px solid black;">
				<span id="idaddress"></span>
			</div>
			<div class="col-xs-4" style="border-right: 1px solid black; height: 124px">
				<p>
					Inv No: <span id="idinvoiceNumber"></span><br/>
					Inv Date: <span id="idinvoiceCreationDateStr"></span>
				</p>
			</div>
			<div class="col-xs-4 text-center" >
				<p><big><span id="idclientname"></span></big><br/>
				<span id="idclientaddress"></span></p>
			</div>
		</div>
		
		<div class="col-xs-12" style="border: 1px solid black; border-top:0px;">
			<div class="col-xs-1" style="border-right: 1px solid black;">
				Sr.No.
			</div>
			<div class="col-xs-3" style="border-right: 1px solid black;">
				Order No
			</div>
			<div class="col-xs-1" style="border-right: 1px solid black;">
				CAM
			</div>
			<div class="col-xs-1" style="border-right: 1px solid black;">
				RM
			</div>
			<div class="col-xs-1" style="border-right: 1px solid black;">
				CAD
			</div>
			<div class="col-xs-1" style="border-right: 1px solid black;">
				CAST
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
		<div id="idorders">
			
		</div>
		<!--TODO: For loop ENDS to populate orders... -->
		
		<div class="col-xs-12" style="border: 1px solid black; border-top:0px;"><small>
			<div class="col-xs-8">
				<big>Amt (in words): One thousand and Forty-Two</big><br/>
				
				VAT TIN: <span id="idvattin"></span><br/>
				CST No: <span id="idcstno"></span><br/><br class="hidden-print"/>
				<span id="iddisclaimer" style="font-size: 85%"></span>
				
			</div>
			<div class="col-xs-3" style="outline: 1px solid black;">
				Gross:<br/>
				Discount:<br/>
				<span id="idinvoiceTaxOption"></span>:<br/>
				StampCharges:<br/>
				Courier Charges:<br/>
				Gate Pass Charges:<br/>
				Other Charges:<br/>
				Total Amount:<br/>
			</div>
			<div class="col-xs-1" style="text-align: right;">
				<span id="idgross">1032.00</span><br/>
				<span id="iddiscount">0.00</span><br/>
				<span id="idtaxAmount">0.00</span><br/>
				0.00<br/>
				<span id="idcourierCharges">0.00</span><br/>
				<span id="idgatePass">0.00</span><br/>
				<span id="idotherCharges">0.00</span><br/>
				<span id="idgrandTotal1">0.00</span><br/>
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
				<span id="idgrandTotal">1042.00</span>
			</div>
			</small>
		</div>
		
		<div class="col-xs-12" style="border: 1px solid black; border-top:0px;"><small>
			<div class="col-xs-8" style="border-right: 1px solid black;">
				If you have any query in the bill kindly intimate us within 24 hrs.<br/>
				Created By: <b>Vivek Singh</b> 
			</div>
			<div class="col-xs-4">
				For <span id="idswName"></span>
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
	
	<div class="col-md-offset-1 row noInvoiceContainer">
		<h1>Invoice to Print</h1>
		<p class="lead"> Please choose the invoice to print using the given filters. </p>
	</div><!-- /.row -->
	
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
			  		
			  		$("#idswName").html(dataFromServer["swName"]);
			  		$("#idvattin").html(dataFromServer["vattin"]);
			  		$("#idcstno").html(dataFromServer["cstno"]);
			  		$("#idaddress").html(dataFromServer["address"]);
			  		$("#iddisclaimer").html(dataFromServer["disclaimer"]);
			  		$("#idgross").html(dataFromServer["gross"]);
			  		$("#idinvoiceTaxOption").html(dataFromServer["invoice"]["invoiceTaxOption"]);
			  		$("#idtaxAmount").html(dataFromServer["taxAmount"]);
			  		$("#idgrandTotal").html(dataFromServer["grandTotal"]);
			  		$("#idclientname").html(dataFromServer["invoice"]["client"]["name"]);
			  		$("#idclientaddress").html(dataFromServer["invoice"]["client"]["address"]);
			  		
			  		$("#idinvoiceNumber").html(dataFromServer["invoice"]["invoiceNumber"]);
			  		$("#idinvoiceCreationDateStr").html(dataFromServer["invoice"]["invoiceCreationDateStr"]);
			  		
			  		$("#idgatePass").html(dataFromServer["invoice"]["gatePass"]);
			  		$("#iddiscount").html(dataFromServer["invoice"]["discount"]);
			  		$("#idcourierCharges").html(dataFromServer["invoice"]["courierCharges"]);
			  		$("#idotherCharges").html(dataFromServer["invoice"]["otherCharges"]);
			  		
			  		var ordHtml='';
			  		$.each(dataFromServer["invoice"]["orderList"],function(ind,valOrd){
			  			ordHtml+="<div class='col-xs-12' style='border: 1px solid black; border-top:0px;'><small> \
							<div class='col-xs-1' style='border-right: 1px solid black;'> "+ (ind+1) +" </div> \
							<div class='col-xs-3' style='border-right: 1px solid black;'> "+ valOrd['_id'] +" </div> \
							<div class='col-xs-1' style='border-right: 1px solid black;'> "+ valOrd['cam']['amount'] + " </div> \
							<div class='col-xs-1' style='border-right: 1px solid black;'> "+ valOrd['rm']['amount'] +" </div> \
							<div class='col-xs-1' style='border-right: 1px solid black;'> "+ valOrd['cad']['amount'] +" </div> \
							<div class='col-xs-1' style='border-right: 1px solid black;'> "+ valOrd['cast']['amount'] +" </div> \
							<div class='col-xs-2' style='border-right: 1px solid black;'> "+ valOrd['camGrams'] +" </div> \
							<div class='col-xs-1' style='border-right: 1px solid black; text-align: right;'> "+ valOrd['_id'] +" </div> \
							<div class='col-xs-1' style='text-align: right;'> "+ valOrd['_id'] +" </div> </small> </div> ";
			  		});

			  		$("#idorders").html(ordHtml);
					
			  		$(".noInvoiceContainer").hide();
			  		$(".invoiceContainer").show();
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
		    
	    $(".noInvoiceContainer").show();
  		$(".invoiceContainer").hide();
	</script>