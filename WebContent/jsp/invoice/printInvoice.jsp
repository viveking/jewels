
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
		
			<div class="col-xs-5" style="border-right: 1px solid black;">
				<span id="idaddress"></span>
			</div>
			<div class="col-xs-2" style="border-right: 1px solid black; height: 124px">
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
			<div class="col-xs-3" id="idOrderNoLabel" style="border-right: 1px solid black; ">
				Order No
			</div>
			<div class="col-xs-1" id="idDcNoLabel" style="border-right: 1px solid black; ">
				DC No
			</div>
			<div class="col-xs-1" style="border-right: 1px solid black;text-align: right;">
				Weight
			</div>
			<div id="idHeaderLblRMWeight" class="col-xs-1" style="border-right: 1px solid black;text-align: right;">
				RM
			</div>
			<div class="col-xs-1" style="border-right: 1px solid black; color:white; background-color: gray;text-align: right;">
				CAM
			</div>
			<div id="idHeaderLblRMAmount" class="col-xs-1" style="border-right: 1px solid black; color:white; background-color: gray;text-align: right;">
				RM
			</div>
			<div id="idHeaderLblCADAmount" class="col-xs-1" style="border-right: 1px solid black; color:white; background-color: gray;text-align: right;">
				CAD
			</div>
			<div id="idHeaderLblCASTAmount" class="col-xs-1" style="border-right: 1px solid black; color:white; background-color: gray;text-align: right;">
				CAST
			</div>
			<div class="col-xs-1" style="text-align: right;">
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
				<br/>
				<div style="margin-top: 4px;">RM Count: <b><span id="idRMCount">0</span></b>  <b>|</b><span> Process: </span><b><span id="idProcessString"></span></b></div>
			</div>
			<div class="col-xs-2" style=" outline: 1px solid black;">
				<br/>
				Gross:<br/>
				Discount:<br/>
				<span id="idinvoiceTaxOption"></span>:<br/>
				Courier Charges:<br/>
				Stamp Charges:<br/>
				Other Charges:<br/>
				Total Amount:<br/>
				<br/>
			</div>
			<div class="col-xs-2" style="left:10px; top:2px; text-align: right;">
				<br/>
				<span id="idgross">0.00</span><br/>
				<span id="iddiscount">0.00</span><br/>
				<span id="idtaxAmount">0.00</span><br/>
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
			<div class="col-xs-2" style="outline: 1px solid black;">
				Grand Total:
			</div>
			<div class="col-xs-2" style="left:10px; text-align: right;">
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
			  		
			  		var processArr = dataFromServer["totalProcessesAvail"];
			  		var processString = processArr.join(", ").toUpperCase();
			  		$("#idProcessString").html(processString);
			  		
			  		if(processArr.indexOf("rm") === -1){
			  			$("#idHeaderLblRMWeight").css("visibility","hidden");
			  			$("idHeaderLblRMAmount").css("visibility","hidden");
			  		} else{
			  			$("#idHeaderLblRMWeight").css("visibility","visible");
			  			$("idHeaderLblRMAmount").css("visibility","visible");
			  		}
			  		if(processArr.indexOf("cad") === -1){
			  			$("#idHeaderLblCADAmount").css("visibility","hidden");
			  		} else{
			  			$("#idHeaderLblCADAmount").css("visibility","visible");
			  		}
			  		if(processArr.indexOf("cast") === -1){
			  			$("#idHeaderLblCASTAmount").css("visibility","hidden");
			  		} else{
			  			$("#idHeaderLblCASTAmount").css("visibility","visible");
			  		}
			  		
			  		$("#idgross").html(Number(dataFromServer["gross"]).toFixed(2));
			  		
			  		$("#idtaxAmount").html(Number(dataFromServer["taxAmount"]).toFixed(2));
			  		$("#idgrandTotal").html(Number(dataFromServer["grandTotal"]).toFixed(2));
			  		$("#idgrandTotal1").html(Number(dataFromServer["grandTotal"]).toFixed(2));
			  		$("#idclientname").html(dataFromServer["invoice"]["client"]["name"]);
			  		$("#idclientaddress").html(dataFromServer["invoice"]["client"]["address"] +", " + dataFromServer["invoice"]["client"]["city"]);

			  		var invoiceTaxOption = "";
			  		var invoiceName = "";
			  		
			  		if(dataFromServer["invoice"]["invoiceTaxOption"].indexOf("TI") !== -1){
			  			invoiceTaxOption = dataFromServer["invoice"]["invoiceTaxOption"].replace("TI","Tax @ ");
			  			invoiceName = "<b>TAX INVOICE</b>";
			  		} else if(dataFromServer["invoice"]["invoiceTaxOption"].indexOf("CST") !== -1 ){
			  			invoiceTaxOption = dataFromServer["invoice"]["invoiceTaxOption"].replace("CST","Sales @ ");
			  			invoiceName = "<b>CST INVOICE</b>";
			  		} else if(dataFromServer["invoice"]["invoiceTaxOption"].indexOf("ES") !== -1 ){
			  			invoiceTaxOption = dataFromServer["invoice"]["invoiceTaxOption"].replace("ES","EST @ ");
			  			nvoiceName = "<b>ES INVOICE</b>";
			  		}
			  		
			  		$("#invoiceName").html(invoiceName);
			  		$("#idinvoiceTaxOption").html(invoiceTaxOption);
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
			  		
		  			var rmVisiblity = processArr.indexOf("rm") === -1?"hidden;":"visible;";
		  			var camVisiblity = processArr.indexOf("cam") === -1?"hidden;":"visible;";
		  			var cadVisiblity = processArr.indexOf("cad") === -1?"hidden;":"visible;";
		  			var castVisiblity = processArr.indexOf("cast") === -1?"hidden;":"visible;";
			  				
			  		var ordHtml='';
			  		$.each(dataFromServer["invoice"]["orderList"],function(ind,valOrd){
			  			var camWeight = (valOrd['cam']['weight'] !== "" && valOrd['cam']['weight'] !== undefined && valOrd['cam']['weight'] !== 0) ? Number(valOrd['cam']['weight']).toFixed(2) : "&nbsp;";
			  			var rmWeight  = (valOrd['rm']['weight'] !== "" && valOrd['rm']['weight'] !== undefined && valOrd['rm']['weight'] !== 0) ? Number(valOrd['rm']['weight']).toFixed(2) : "&nbsp;" ;
			  			var camAmount  = (valOrd['cam']['amount'] !== "" && valOrd['cam']['amount'] !== undefined && valOrd['cam']['amount'] !== 0) ? Number(valOrd['cam']['amount']).toFixed(0) : "&nbsp;" ;
			  			var rmAmount  = (valOrd['rm']['amount'] !== "" && valOrd['rm']['amount'] !== undefined && valOrd['rm']['amount'] !== 0) ? Number(valOrd['rm']['amount']).toFixed(0) : "&nbsp;" ;
			  			var cadAmount  = (valOrd['cad']['amount'] !== "" && valOrd['cad']['amount'] !== undefined && valOrd['cad']['amount'] !== 0) ? Number(valOrd['cad']['amount']).toFixed(0) : "&nbsp;" ;
			  			var castAmount  = (valOrd['cast']['amount'] !== "" && valOrd['cast']['amount'] !== undefined&& valOrd['cast']['amount'] !== 0) ? Number(valOrd['cast']['amount']).toFixed(0) : "&nbsp;" ;
			  			var dcNumber = valOrd['dcNumber'];
			  			ordHtml+="<div class='col-xs-12' style='border: 1px solid black; border-top:0px;'><small> \
							<div class='col-xs-1' style='border-right: 1px solid black;'> "+ (ind+1) +" </div>";
							if(dcNumber){
								ordHtml+="<div class='col-xs-3' style='border-right: 1px solid black;'> "+ valOrd['orderName']+"_"+valOrd['_id'] +" </div>\
								<div class='col-xs-1' style='border-right: 1px solid black;'> "+ dcNumber +" </div>";
								$("#idOrderNoLabel").removeClass("col-xs-4");
								$("#idOrderNoLabel").addClass("col-xs-3");
								$("#idDcNoLabel").css("display","block");
							}else{
								ordHtml+="<div class='col-xs-4' style='border-right: 1px solid black;'> "+ valOrd['orderName']+"_"+valOrd['_id'] +" </div>";
								$("#idOrderNoLabel").removeClass("col-xs-3");
								$("#idOrderNoLabel").addClass("col-xs-4");
								$("#idDcNoLabel").css("display","none");
							}
							
							ordHtml+="<div class='col-xs-1' style='visibility:"+camVisiblity+" border-right: 1px solid black; text-align: right;'> "+ camWeight +" </div> \
							<div class='col-xs-1' style='visibility:"+rmVisiblity+" border-right: 1px solid black; text-align: right;'> "+ rmWeight +" </div> \
							<div class='col-xs-1' style='visibility:"+camVisiblity+" border-right: 1px solid black; text-align: right;'> "+ camAmount + " </div> \
							<div class='col-xs-1' style='visibility:"+rmVisiblity+" border-right: 1px solid black; text-align: right;'> "+ rmAmount +" </div> \
							<div class='col-xs-1' style='visibility:"+cadVisiblity+" border-right: 1px solid black; text-align: right;'> "+ cadAmount +" </div> \
							<div class='col-xs-1' style='visibility:"+castVisiblity+" border-right: 1px solid black; text-align: right;'> "+ castAmount +" </div> \
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
			  		var clientArr = [];
				  	$.each(dataFromServer ,function(ind,val){
				  		if(clientArr.indexOf(val._id) === -1){
				  			$("#idSelectClient").append("<option value="+val._id+">"+val.name+"<option>");
				  			clientArr.push(val._id);
				  		}
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