
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
		Print DC
		<small>
			<i class="icon-double-angle-right"></i>
			Print Order DC.
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
		
			<label for="idSelectDC">Select DC</label>
					
			<select class="width-80 chosen-select" id="idSelectDC" data-placeholder="Choose a DC...">
			</select>
		</div>
		<div id="alertContainer" style="position: fixed; bottom:10px; right:10px; z-index:1000">
		</div>
	</div>
	<div class="row DCContainer" style="margin-top: 10px; font-family:'segoe ui'">
		
		<div class="col-xs-12 text-center" id="DCName">
			<b>Delivery Challan</b>
		</div>
		
		<div class="col-xs-12" style="border: 1px solid black;">
			<div>
				<span id="idaddress"></span>
			</div>
		</div>
		<div class="col-xs-12"  style="border: 1px solid black; border-top:none;">
			<div class="col-xs-6" style="border-right: 1px solid black; height: 100px; max-height:124px; padding-top: 10px;">
				<p>
					DC No: <span id="idDCNumber"></span><br/>
					DC Date: <span id="idDCCreationDateStr"></span>
				</p>
			</div>
			<div class="col-xs-6" style="padding-top:10px;">
				<p><strong><span id="idclientname"></span></strong><br/>
				<span id="idclientaddress"></span></p>
			</div>
		</div>
		
		<div class="col-xs-12" style="border: 1px solid black; border-top:0px;">
			<div class="col-xs-1" style="border-right: 1px solid black;">
				<b>Sr.No.</b>
			</div>
			<div class="col-xs-3" style="border-right: 1px solid black; ">
				<b>Order No</b>
			</div>
			<div class="col-xs-1" style="border-right: 1px solid black;text-align: right;">
				<b>Quantity</b>
			</div>
			<div class="col-xs-1" style="border-right: 1px solid black;text-align: right;">
				<b>Weight</b>
			</div>
			<div id="idHeaderLblRMWeight" class="col-xs-1" style="border-right: 1px solid black;text-align: right;">
				<b>RM</b>
			</div>
			<div class="col-xs-1" style="border-right: 1px solid black; text-align: right;">
				<b>CAM</b>
			</div>
			<div id="idHeaderLblRMAmount" class="col-xs-1" style="border-right: 1px solid black; text-align: right;">
				<b>RM</b>
			</div>
			<div id="idHeaderLblCADAmount" class="col-xs-1" style="border-right: 1px solid black; text-align: right;">
				<b>CAD</b>
			</div>
			<div id="idHeaderLblCASTAmount" class="col-xs-1" style="border-right: 1px solid black; text-align: right;">
				<b>CAST</b>
			</div>
			<div class="col-xs-1" style="text-align: right;">
				<b>Total</b>
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
			<div class="col-xs-3" style=" outline: 1px solid black;">
				<br/>
				Total Amount:<br/>
				<div style="visibility: hidden;">Gross:<br/>
				Discount:<br/>
				<span id="idDCTaxOption"></span>:<br/>
				Courier Charges:<br/>
				Stamp Charges:<br/>
				Other Charges:<br/>
				</div>
				<br/>
			</div>
			<div class="col-xs-1" style="left:10px; top:2px; text-align: right;">
				<br/>
				<!-- <span id="idgross">0.00</span><br/>
				<span id="iddiscount">0.00</span><br/>
				<span id="idtaxAmount">0.00</span><br/>
				<span id="idcourierCharges">0.00</span><br/>
				<span id="idgatePass">0.00</span><br/>
				<span id="idotherCharges">0.00</span><br/> -->
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
		<div class="col-xs-12" style="border: 1px solid black; border-top:0px; text-align:right;">
			<small style="text-align:left; float: right; padding: 5px;">
				<span>1. Claim of any material whatsoever lapse unless raised in writing 8 days of this Bill.</span><br/>
				<span>2. Payment should be cross-checked and Made payable to the Company only.</span><br/>
				<span>3. Interest will be charged at 18% on unpaid accounts 15 days after delivery.</span><br/>
				<span>4. Subject to Mumbai Jurisdiction only.</span>
			</small>
		</div>
		<div class="col-xs-12" style="border: 1px solid black; border-top:0px;"><small>
			<div class="col-xs-8" style="border-right: 1px solid black; padding: 5px;">
				I/We hereby certify that my/our registration certificate  under the Maharashtra Value Added Tax Act, 
				2002 is in force on the date on which the sale of the goods specified in this tax 
				invoice is made by me/us and that the transaction of sale covered by this tax invoice 
				has been effected by me/us and it shall be accounted for in the turnover of sales while 
				filing of return  and the due tax, if any, payable on the sale has been paid or shall be paid.  
			</div>
			<div class="col-xs-4" style="padding: 5px;">
				For, <span id="idswName"></span>
			</div>
			</small>
		</div>
		<div class="col-xs-12" style="border: 1px solid black; border-top:0px;"><small>
			<div class="col-xs-8" style="border-right: 1px solid black; padding: 5px;">
				Receivers Signature
			</div>
			<div class="col-xs-4" style="padding: 5px;">
				Authorised Signatory
			</div>
			</small>
		</div>
	</div>	
	
	<div class="col-md-offset-1 row noDCContainer">
		<h1>DC to Print</h1>
		<p class="lead"> Please choose the DC to print using the given filters. </p>
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
			  	url: '${pageContext.request.contextPath}/dc.action?op=LIST_OF_DCS_BY_CLIENT_NAME',
			  	type: 'POST',
			  	data: param
			  })
			  .done(function(data) {
			  	console.log("success "+data);
			  	dataFromServer = [];
			  	dataFromServer = JSON.parse(data);
			  	
			  	if(dataFromServer){
			  		
				  	$("#idSelectDC").empty();
				  	
				  	//$.each(dataFromServer ,function(val){
				  		$("#idSelectDC").append("<option value=''></option>");
				  		
				  		for(var key in dataFromServer) {
				  			$("#idSelectDC").append("<option value="+key+">"+dataFromServer[key]+"<option>");
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
	    
	    $("#idSelectDC").chosen().change(function() {
	    	
			param = {"_id":$('#idSelectDC').val()};
			console.log(param);
			$.ajax({
			  	url: '${pageContext.request.contextPath}/dc.action?op=GET',
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
			  			$("#idHeaderLblRMAmount").css("visibility","hidden");
			  		} else{
			  			$("#idHeaderLblRMWeight").css("visibility","visible");
			  			$("#idHeaderLblRMAmount").css("visibility","visible");
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
			  		
			  		//$("#idgross").html(Number(dataFromServer["gross"]).toFixed(2));
			  		
			  		//$("#idtaxAmount").html(Number(dataFromServer["taxAmount"]).toFixed(2));
			  		$("#idgrandTotal").html(Number(dataFromServer["grandTotal"]).toFixed(2));
			  		$("#idgrandTotal1").html(Number(dataFromServer["grandTotal"]).toFixed(2));
			  		$("#idclientname").html(dataFromServer["dc"]["client"]["name"]);
			  		
			  		var clientAddress =  "";
			  		if(dataFromServer["dc"]["client"]["address"] !== undefined){
			  			clientAddress = dataFromServer["dc"]["client"]["address"] +", " + dataFromServer["dc"]["client"]["city"];
			  		}
			  		$("#idclientaddress").html(clientAddress);
			  		
			  		//$("#DCName").html(DCName);
			  		//$("#idDCTaxOption").html(DCTaxOption);
			  		$("#idDCNumber").html(dataFromServer["dc"]["dcNumber"]);
			  		$("#idDCCreationDateStr").html(dataFromServer["dc"]["dcCreationDateStr"]);
			  		
			  		//$("#idgatePass").html(Number(dataFromServer["dc"]["gatePass"]).toFixed(2));
			  		//$("#iddiscount").html(Number(dataFromServer["dc"]["discount"]).toFixed(2));
			  		//$("#idcourierCharges").html(Number(dataFromServer["dc"]["courierCharges"]).toFixed(2));
			  		//$("#idotherCharges").html(Number(dataFromServer["dc"]["otherCharges"]).toFixed(2));
			  		$("#idamtwords").html(dataFromServer["amountInWords"]);
			  		
			  		if(dataFromServer["dc"].hasOwnProperty("rmCount")){
			  			$("#idRMCount").html(dataFromServer["dc"]["rmCount"]);
			  		} else{
			  			$("#idRMCount").html("0");
			  		}
			  		
		  			var rmVisiblity = processArr.indexOf("rm") === -1?"hidden;":"visible;";
		  			var camVisiblity = processArr.indexOf("cam") === -1?"hidden;":"visible;";
		  			var cadVisiblity = processArr.indexOf("cad") === -1?"hidden;":"visible;";
		  			var castVisiblity = processArr.indexOf("cast") === -1?"hidden;":"visible;";
			  				
			  		var ordHtml='';
			  		$.each(dataFromServer["dc"]["orderList"],function(ind,valOrd){
			  			var camWeight = (valOrd['cam']['weight'] !== "" && valOrd['cam']['weight'] !== undefined && valOrd['cam']['weight'] !== 0) ? Number(valOrd['cam']['weight']).toFixed(2) : "&nbsp;";
			  			var rmWeight  = (valOrd['rm']['weight'] !== "" && valOrd['rm']['weight'] !== undefined && valOrd['rm']['weight'] !== 0) ? Number(valOrd['rm']['weight']).toFixed(2) : "&nbsp;" ;
			  			var camAmount  = (valOrd['cam']['amount'] !== "" && valOrd['cam']['amount'] !== undefined && valOrd['cam']['amount'] !== 0) ? Number(valOrd['cam']['amount']).toFixed(0) : "&nbsp;" ;
			  			var rmAmount  = (valOrd['rm']['amount'] !== "" && valOrd['rm']['amount'] !== undefined && valOrd['rm']['amount'] !== 0) ? Number(valOrd['rm']['amount']).toFixed(0) : "&nbsp;" ;
			  			var cadAmount  = (valOrd['cad']['amount'] !== "" && valOrd['cad']['amount'] !== undefined && valOrd['cad']['amount'] !== 0) ? Number(valOrd['cad']['amount']).toFixed(0) : "&nbsp;" ;
			  			var castAmount  = (valOrd['cast']['amount'] !== "" && valOrd['cast']['amount'] !== undefined&& valOrd['cast']['amount'] !== 0) ? Number(valOrd['cast']['amount']).toFixed(0) : "&nbsp;" ;
			  			
			  			ordHtml+="<div class='col-xs-12' style='border: 1px solid black; border-top:0px;'><small> \
							<div class='col-xs-1' style='border-right: 1px solid black;'> "+ (ind+1) +" </div> \
							<div class='col-xs-3' style='border-right: 1px solid black;'> "+ valOrd['orderName'] +" </div> \
							<div class='col-xs-1' style='border-right: 1px solid black; text-align: right;'> 1 </div> \
							<div class='col-xs-1' style='visibility:"+camVisiblity+" border-right: 1px solid black; text-align: right;'> "+ camWeight +" </div> \
							<div class='col-xs-1' style='visibility:"+rmVisiblity+" border-right: 1px solid black; text-align: right;'> "+ rmWeight +" </div> \
							<div class='col-xs-1' style='visibility:"+camVisiblity+" border-right: 1px solid black; text-align: right;'> "+ camAmount + " </div> \
							<div class='col-xs-1' style='visibility:"+rmVisiblity+" border-right: 1px solid black; text-align: right;'> "+ rmAmount +" </div> \
							<div class='col-xs-1' style='visibility:"+cadVisiblity+" border-right: 1px solid black; text-align: right;'> "+ cadAmount +" </div> \
							<div class='col-xs-1' style='visibility:"+castVisiblity+" border-right: 1px solid black; text-align: right;'> "+ castAmount +" </div> \
							<div class='col-xs-1' style='text-align: right; left:10px;'> "+ 
							Number(eval(valOrd['rm']['amount']+valOrd['cam']['amount']+valOrd['cad']['amount']+valOrd['cast']['amount'])).toFixed(2) +" </div> </small> </div> ";
			  		});

			  		$("#idorders").html(ordHtml);
					
			  		$(".noDCContainer").hide();
			  		$(".DCContainer").show();
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
			  	url: '${pageContext.request.contextPath}/dc.action?op=GET_CLIENTS',
			  	type: 'POST',
			  	data: param
			  })
			  .done(function(data) {
			  	console.log("success "+data);
			  	dataFromServer = [];
			  	dataFromServer = JSON.parse(data);
			  	
			  	if(dataFromServer){
			  		
				  	$("#idSelectClient").empty();
				  	$("#idSelectDC").empty();
				  	
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
		    
	    $(".noDCContainer").show();
  		$(".DCContainer").hide();
	</script>