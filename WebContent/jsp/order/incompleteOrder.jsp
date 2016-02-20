<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="page-header">
	<h1>
		Incomplete Order Tracking
		<small>
			<i class="icon-double-angle-right"></i>
			Track incomplete orders.
		</small>
	</h1>
</div><!-- /.page-header -->
<div class="col-xs-12">
	<!-- PAGE CONTENT BEGINS -->

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
						Get Clients
				</button>
			</div>
		</div>
		<div class="col-xs-4">
		
			<label for="idSelectClient">Select Order</label>
					
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

			<button class="btn btn-md btn-success" id="idSaveOrder">
				<i class="icon-ok"></i>
				Save
			</button>

			<script type="text/javascript">
				var $path_base = "/";//this will be used in gritter alerts containing images
			</script>

			<!-- PAGE CONTENT ENDS -->
		</div><!-- /.col -->
	</div><!-- /.row -->
	<div class="col-md-offset-1 row" id="noGridContainer">
		<h1>Select Date and Client</h1>
		<p class="lead"> You can track incomplete order. </p>
	</div><!-- /.row -->
	
</div>
</div>
<!-- 	<button class="btn btn-md btn-success" id="idSaveOrder">
		<i class="icon-ok"></i>
		Save
	</button> -->
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
			height: "auto",
			colNames:['Client ID','id','Order ID','Order Name','Platform','Part','Weight (KG)','Status'],
			colModel:[
				{name:'client.clientId',index:'client.clientId', width:150,editable: false},
				{name:'_id',index:'_id', width:125,editable: false,hidden:true},
				{name:'displayOrderNumber',index:'displayOrderNumber', width:125,editable: false},
				{name:'orderName',index:'orderName', width:160,editable: false},
				{name:'partList.platformNumber',index:'platform', width:150, editable: false},
				{name:'partList.name',index:'part', width:300, editable: false},
				{name:'partList.weight',index:'partWeight',formatter:'number',formatoptions:{decimalPlaces: 2}, width:200, editable: true, classes: 'editCls'},
				{name:'partList.status',index:'partStatus', width:200, editable: true, edittype:"select", editrules:{required:true, edithidden:true},editoptions:{ value:{"INPROGRESS":"INPROGRESS","COMPLETED":"COMPLETED"}},formatter:'select', classes: 'editCls'}
				/* {name:'supportWeight',index:'supportWeight',formatter:'number',formatoptions:{decimalPlaces: 4}, width:300, editable: true, classes: 'editCls'} */
			], 
			hiddengrid: false,
			viewrecords : true,
			rowNum:100000,
			cellEdit:true,
			cellsubmit:"clientArray",
			altRows: true,
			rownumbers: true,  
			multiselect: false,
			caption: "Incomplete Order Details",
			autowidth: true
	
		});
		
		$('#btnGenerateOrderGetCLient').click(function(){
			var dateRange = $('#idFromToDate').val();
			var date = dateRange.split(" to ");
			clientMap = {};
			param = {"fromDate":date[0],"toDate":date[1]};
			console.log(param);
			$.ajax({
			  	url: '${pageContext.request.contextPath}/order.action?op=VIEW_INCOMPLETE_ORDER',
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
				  	
				  	$("#idSelectClient").append("<option value='all'>All<option>");
				  	
				  	$.each(dataFromServer ,function(ind,val){
				  		var clientId = val.client.clientId;
				  		//dataFromServer[ind].partList.weight = dataFromServer[ind].partList.weight*1000;	
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
			  	console.log("error");
			  })
			  .always(function() {
			  	console.log("complete");
			  });
		});
		
		$('#idSaveOrder').click(function(){
			var passedGrid = $("#order-grid-table");
			var selData = passedGrid.jqGrid('getRowData');
			
			var param ={'order':JSON.stringify(selData)};
			
			console.log(param);
			$.ajax({
			  	url: '${pageContext.request.contextPath}/order.action?op=SAVE_PARTS_UPDATE',
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