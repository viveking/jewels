
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.col-xs-1{
		padding-left:2px;
	}
	
</style>
<div class="page-header">
	<button class="btn btn-app btn-yellow btn-xs pull-right" onclick="window.print();">
		<i class="icon-print bigger-160"></i>
		Print
	</button>
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
		
		<div class="col-xs-12 text-center" id="invoiceName" style="border: 1px solid black">
			<b>TAX INVOICE</b>
		</div>
		
		<div class="col-xs-12" style="border: 1px solid black; border-top:0px;">
		
			<div class="col-xs-4" style="border-right: 1px solid black;">
				<span id="idaddress"></span>
			</div>
			<div class="col-xs-3" style="border-right: 1px solid black; height: 124px">
				<p>
					Inv No: <span id="idinvoiceNumber"></span><br/>
					Inv Date: <span id="idinvoiceCreationDateStr"></span>
				</p>
			</div>
			<div class="col-xs-5" >
				<p><strong><span id="idclientname"></span></strong><br/>
				<span id="idclientaddress"></span></p>
			</div>
		</div>
		
		<div class="col-xs-12" style="border: 1px solid black; border-top:0px;">
			<div class="col-xs-1" style="border-right: 1px solid black;">
				Sr.No.
			</div>
			<div class="col-xs-4" style="border-right: 1px solid black; ">
				Order No
			</div>
			<div class="col-xs-1" style="border-right: 1px solid black;">
				Weight
			</div>
			<div class="col-xs-1" style="border-right: 1px solid black;">
				RM
			</div>
			<div class="col-xs-1" style="border-right: 1px solid black; color:white; background-color: gray;">
				CAM
			</div>
			<div class="col-xs-1" style="border-right: 1px solid black; color:white; background-color: gray;">
				RM
			</div>
			<div class="col-xs-1" style="border-right: 1px solid black; color:white; background-color: gray;">
				CAD
			</div>
			<div class="col-xs-1" style="border-right: 1px solid black; color:white; background-color: gray;">
				CAST
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
				<big>Amt (in words): <span id="idamtwords"></span></big><br/>
				
				VAT TIN: <span id="idvattin"></span><br/>
				CST No: <span id="idcstno"></span><br/><br class="hidden-print"/>
				<span id="iddisclaimer" style="font-size: 85%"></span>
				
			</div>
			<div class="col-xs-3" style=" outline: 1px solid black;">
				Gross:<br/>
				Discount:<br/>
				<span id="idinvoiceTaxOption"></span>:<br/>
				Courier Charges:<br/>
				Stamp Charges:<br/>
				Other Charges:<br/>
				RM Count:<br/>
				Total Amount:<br/><br/>
			</div>
			<div class="col-xs-1" style="left:10px; top:2px; text-align: right;">
				<span id="idgross">0.00</span><br/>
				<span id="iddiscount">0.00</span><br/>
				<span id="idtaxAmount">0.00</span><br/>
				<span id="idcourierCharges">0.00</span><br/>
				<span id="idgatePass">0.00</span><br/>
				<span id="idotherCharges">0.00</span><br/>
				<span id="idRMCount">0.00</span><br/>
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
			<div class="col-xs-1" style="left:10px; text-align: right;">
				<span id="idgrandTotal"></span>
			</div>
			</small>
		</div>
		
		<div class="col-xs-12" style="border: 1px solid black; border-top:0px;"><small>
			<div class="col-xs-8" style="border-right: 1px solid black; height:80px;">
				If you have any query in the bill kindly intimate us within 24 hrs.<br/>
				Created By:  
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
			  		$("#idgross").html(Number(dataFromServer["gross"]).toFixed(2));
			  		
			  		$("#idtaxAmount").html(Number(dataFromServer["taxAmount"]).toFixed(2));
			  		$("#idgrandTotal").html(Number(dataFromServer["grandTotal"]).toFixed(2));
			  		$("#idgrandTotal1").html(Number(dataFromServer["grandTotal"]).toFixed(2));
			  		$("#idclientname").html(dataFromServer["invoice"]["client"]["name"]);
			  		$("#idclientaddress").html(dataFromServer["invoice"]["client"]["address"]);

			  		var invoiceNumber = "";
			  		var invoiceName = "";
			  		
			  		if(dataFromServer["invoice"]["invoiceNumber"].indexOf("TI") !== -1){
			  			invoiceNumber = dataFromServer["invoice"]["invoiceNumber"].replace("TI","Tax @ ");
			  			invoiceName = "<b>TAX INVOICE</b>";
			  		} else if(dataFromServer["invoice"]["invoiceNumber"].indexOf("CST") !== -1 ){
			  			invoiceNumber = dataFromServer["invoice"]["invoiceNumber"].replace("CST","Sales @ ");
			  			invoiceName = "<b>CST INVOICE</b>";
			  		} else if(dataFromServer["invoice"]["invoiceNumber"].indexOf("ES") !== -1 ){
			  			invoiceNumber = dataFromServer["invoice"]["invoiceNumber"].replace("ES","EST @ ");
			  			nvoiceName = "<b>ES INVOICE</b>";
			  		}
			  		
			  		$("#invoiceName").html(invoiceName);
			  		$("#idinvoiceTaxOption").html(invoiceNumber);
			  		$("#idinvoiceNumber").html(dataFromServer["invoice"]["invoiceNumber"]);
			  		$("#idinvoiceCreationDateStr").html(dataFromServer["invoice"]["invoiceCreationDateStr"]);
			  		
			  		$("#idgatePass").html(Number(dataFromServer["invoice"]["gatePass"]).toFixed(2));
			  		$("#iddiscount").html(Number(dataFromServer["invoice"]["discount"]).toFixed(2));
			  		$("#idcourierCharges").html(Number(dataFromServer["invoice"]["courierCharges"]).toFixed(2));
			  		$("#idotherCharges").html(Number(dataFromServer["invoice"]["otherCharges"]).toFixed(2));
			  		$("#idamtwords").html(dataFromServer["amountInWords"]);
			  		
			  		if(dataFromServer["invoice"].hasOwnProperty("rmCount")){
			  			$("#idRMCount").html(dataFromServer["invoice"]["rmCount"]);
			  		} else{
			  			$("#idRMCount").html("0");
			  		}
			  		
			  		
			  		var ordHtml='';
			  		$.each(dataFromServer["invoice"]["orderList"],function(ind,valOrd){
			  			var camWeight = (valOrd['cam']['weight'] !== "" && valOrd['cam']['weight'] !== undefined) ? (Number(valOrd['cam']['weight']*1000).toFixed(2)) : "";
			  			var rmWeight  = (valOrd['rm']['weight'] !== "" && valOrd['rm']['weight'] !== undefined) ? (Number(valOrd['rm']['weight'])*1000).toFixed(0) : "" ;
			  			var camAmount  = (valOrd['cam']['amount'] !== "" && valOrd['cam']['amount'] !== undefined) ? Number(valOrd['cam']['amount']).toFixed(0) : "" ;
			  			var rmAmount  = (valOrd['rm']['amount'] !== "" && valOrd['rm']['amount'] !== undefined) ? Number(valOrd['rm']['amount']).toFixed(0) : "" ;
			  			var cadAmount  = (valOrd['cad']['amount'] !== "" && valOrd['cad']['amount'] !== undefined) ? Number(valOrd['cad']['amount']).toFixed(0) : "" ;
			  			var castAmount  = (valOrd['cast']['amount'] !== "" && valOrd['cast']['amount'] !== undefined) ? Number(valOrd['cast']['amount']).toFixed(0) : "" ;
			  			
			  			ordHtml+="<div class='col-xs-12' style='border: 1px solid black; border-top:0px;'><small> \
							<div class='col-xs-1' style='border-right: 1px solid black;'> "+ (ind+1) +" </div> \
							<div class='col-xs-4' style='border-right: 1px solid black;'> "+ valOrd['orderName']+"_"+valOrd['_id'] +" </div> \
							<div class='col-xs-1' style='border-right: 1px solid black; text-align: right;'> "+ camWeight +" </div> \
							<div class='col-xs-1' style='border-right: 1px solid black; text-align: right;'> "+ rmWeight +" </div> \
							<div class='col-xs-1' style='border-right: 1px solid black; text-align: right;'> "+ camAmount + " </div> \
							<div class='col-xs-1' style='border-right: 1px solid black; text-align: right;'> "+ rmAmount +" </div> \
							<div class='col-xs-1' style='border-right: 1px solid black; text-align: right;'> "+ cadAmount +" </div> \
							<div class='col-xs-1' style='border-right: 1px solid black; text-align: right;'> "+ castAmount +" </div> \
							<div class='col-xs-1' style='text-align: right; left:10px;'> "+ 
							Number(eval(valOrd['rm']['amount']+valOrd['cam']['amount']+valOrd['cad']['amount']+valOrd['cast']['amount'])).toFixed(2) +" </div> </small> </div> ";
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