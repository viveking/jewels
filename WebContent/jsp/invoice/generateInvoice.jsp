
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="page-header">
	<h1>
		Invoice Generation
		<small>
			<i class="icon-double-angle-right"></i>
			Order Invoice Generation.
		</small>
	</h1>
</div><!-- /.page-header -->

<div class="form-group">

	<div class="row">
		<div class="col-xs-4">
		
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
				<button id="btnGenerateOrderGetCLient" class="btn btn-md btn-primary">
						<i class="icon-spinner"></i>
						Get Order
				</button>
			</div>
		</div>
		<div class="col-xs-4">
		
			<label for="idSelectClient">Select Client</label>
					
			<select class="width-80 chosen-select" id="idSelectClient" data-placeholder="Choose a Client...">
			</select>
		</div>
		<div id="alertContainer" style="position: fixed; bottom:10px; right:10px; z-index:1000">
			
		</div>
	</div>
	
	<div class="row" id="gridContainer">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->

			<table id="order-grid-table"></table>

			
			<script type="text/javascript">
				var $path_base = "/";//this will be used in gritter alerts containing images
			</script>

			<!-- PAGE CONTENT ENDS -->
		</div><!-- /.col -->
		<div  class="col-xs-12">
			<div class="col-xs-2">
				<label for="taxInvoiceOptionList">Invoice Tax</label>
	
				<select class="form-control" id="taxInvoiceOptionList">
					<!-- Get this from client Info -->
					<option value="TI0%">Tax Invoice @ 0%</option>
					<option value="TI1%">Tax Invoice @ 1%</option>
					<option value="TI12.5%">Tax Invoice @ 12.5%</option>
					<option value="TI14%">Tax Invoice @ 14%</option>
				</select>
			</div>
			<div class="col-xs-2">
				<label for="idDiscount">Discount (Rs)</label>
				<input type="number" id="idDiscount" value="0">
			</div>	
			<div class="col-xs-2">
				<label for="idCourier">Courier Charger</label>
				<input type="number" id="idCourier" value="0">
			</div>
			<div class="col-xs-2">
				<label for="idGatePassCharges">Stamp Charges</label>
				<input type="number" id="idGatePassCharges" value="0">
			</div>	
			<div class="col-xs-2">
				<label for="idOtherCharges">Other Charges</label>
				<input type="number" id="idOtherCharges" value="0">
			</div>
			<div class="col-xs-2" style="padding:0px">
				<label> </label>
				<button class="btn btn-md btn-success" id="idSaveOrder">
					<i class="icon-ok"></i>
					Generate Invoice
				</button>
			</div>
		</div>
	</div><!-- /.row -->
	<div class="col-md-offset-1 row" id="noGridContainer">
		<h1>Select Date and Client</h1>
		<p class="lead"> You can generate the Invoice for orders. </p>
	</div><!-- /.row -->
	
</div>

<script>

	$(document).ready(function(){
		
		$('.date-picker').datepicker({autoclose:true}).next().on(ace.click_event, function(){
			$(this).prev().focus();
		});
		$('.date-picker').datepicker('setDate',new Date());
		
        $('input[name=date-range-picker]').daterangepicker({
        	format: 'DD-MM-YYYY',
        	separator: ' to '
        	}).prev().on(ace.click_event, function(){
			$(this).next().focus();
		});
        
        $(".chosen-select").chosen();
        
        $(".chosen-select").chosen().change(function() {
        	var clientGridData = clientMap[$(this).val()];
        	if(!clientGridData){
			  	$('#order-grid-table').jqGrid('setGridParam', {data: dataFromServer }).trigger('reloadGrid');
        	}else{
	        	console.log(clientGridData);
	        	$("#order-grid-table").jqGrid("clearGridData");
	        	$('#order-grid-table').jqGrid('setGridParam', {data: clientGridData}).trigger('reloadGrid');        		
        	}
        });
        
	});

	var grid_data = [];//[{orderDateStr:"asas",_id:11,orderName:"asas",cam:{required:true},cad:{required:true},rm:{required:true}}];
	
	jQuery(function($) {
		var order_grid_selector = "#order-grid-table";
		
		jQuery(order_grid_selector).jqGrid({
			data: grid_data,
			datatype: "local",
			gridview: true,
			height: 320,
			colNames:['Order Name','Order No','Client Id','CAM (KG)','CAM Charges','CAD Charges','RM Charges','Cast Charges'],
			colModel:[
				{name:'orderName',index:'orderName', width:150,editable: false},
				{name:'_id',index:'_id', width:150,editable: false},
				{name:'client.clientId',index:'client.clientId', width:150,editable: false},
				{name:'cam.weight',index:'cam.weight',formatter:'number',formatoptions:{decimalPlaces: 4}, width:70,editable: false},
				{name:'cam.amount',index:'cam.amount',formatter:'number',formatoptions:{decimalPlaces: 4}, width:70,editable: false},
				{name:'cad.amount',index:'cad.amount',formatter:'number',formatoptions:{decimalPlaces: 4}, width: 70,editable: false},
				{name:'rm.amount',index:'rm.amount',formatter:'number',formatoptions:{decimalPlaces: 4}, width: 70,editable: false },
				{name:'cast.amount',index:'cast.amount',formatter:'number',formatoptions:{decimalPlaces: 4}, width: 70,editable: false }
			],
			hiddengrid: false,
			viewrecords : true,
			rowNum:100000,
			altRows: true,
			rownumbers: true,  
			multiselect: false,
			caption: "Order List",
			autowidth: true,
			sortname: '_id', 
			sortorder: 'asc'
		});
		
		
		$('#btnGenerateOrderGetCLient').click(function(){
			var dateRange = $('#idFromToDate').val();
			var date = dateRange.split(" to ");
			clientMap = {};
			param = {"fromDate":date[0],"toDate":date[1]};
			console.log(param);
			$.ajax({
			  	url: '${pageContext.request.contextPath}/invoice.action?op=GET_ALL_INFO',
			  	type: 'POST',
			  	data: param
			  })
			  .done(function(data) {
			  	console.log("success "+data);
			  	dataFromServer = [];
			  	dataFromServer = JSON.parse(data);
			  	
			  	if(dataFromServer){
			  		
				  	$("#idSelectClient").empty();
				  	$("#order-grid-table").jqGrid("clearGridData");
				  	
				  	//$("#idSelectClient").append("<option value='all'>All<option>");
				  	
				  	$.each(dataFromServer ,function(ind,val){
				  		var clientId = val.client.clientId;
				  			
				  		if(!clientMap.hasOwnProperty(clientId)){
							clientMap[clientId] = [];
					  		$("#idSelectClient").append("<option value="+val.client.clientId+">"+val.client.clientId+"<option>");
				  		}
						clientMap[clientId].push(val);
				  	});
				  	
				  	$('.chosen-select').chosen().trigger("chosen:updated");
				  	
				  	$('#order-grid-table').jqGrid('setGridParam', {data: dataFromServer }).trigger('reloadGrid');
				  	
			  	}
			  	
			  	$('#noGridContainer').hide();
		        $('#gridContainer').show(); 
			  })
			  .fail(function() {
			  	console.log("error]");
			  })
			  .always(function() {
			  	console.log("complete");
			  });
		});
		
		$('#idSaveOrder').click(function(){
			var passedGrid = $("#order-grid-table");
			var selData = passedGrid.jqGrid('getRowData');
			
			var param ={
						'order':JSON.stringify(selData),
						'clientName': $("#idSelectClient").val(),
						'discount': $("#idDiscount").val(),
						'courierCharges': $("#idCourier").val(),
						'otherCharges':$("#idOtherCharges").val(),
						'gatePassCharges': $("#idGatePassCharges").val(),
						'invoiceTaxOption': $("#taxInvoiceOptionList").val()
					};
			
			console.log(param);
			$.ajax({
			  	url: '${pageContext.request.contextPath}/invoice.action?op=GENERATE',
			  	type: 'POST',
			  	data: param
			  })
			  .done(function(data) {
			  	console.log("success "+data);
			  	$("#alertContainer").html(' \
			  			<div class="alert alert-block alert-success" id="alertSaved">\
						<button type="button" class="close" data-dismiss="alert"> \
							<i class="icon-remove"></i> \
						</button> \
						<p>	<strong> \
								<i class="icon-ok"></i>\
								Save Successful... \
							</strong></p> \
					</div>');
			  	
			  	$("#alertSaved").addClass("animated bounceInRight");
			  	
			  })
			  .fail(function() {
			  	console.log("error");
			  })
			  .always(function() {
			  	console.log("complete");
			  });
		});
		
		//hidding the grid Initially.....

        $('#noGridContainer').show();
        $('#gridContainer').hide(); 
        
	});
</script>

<!-- page specific plugin scripts -->

<script src="assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="assets/js/jqGrid/jquery.jqGrid.min.js"></script>
<script src="assets/js/jqGrid/i18n/grid.locale-en.js"></script>

