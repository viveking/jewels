
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style>
	.ui-state-highlight{
	     border:none!important;
	     background:none!important;
	}
	.selected-row{
	     border:none!important;
	     background:none!important;
	}
</style>

<div class="page-header">
	<h1>
		Update Order
		<small>
			<i class="icon-double-angle-right"></i>
			Upload Order.
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
		
			<label for="idProcessType">Select Operation</label>
			
			<select class="form-control" id="idProcessType">
				<option value="cad">CAD</option>
				<option value="cast">CAST</option>
				<option value="rm">RM</option>
			</select>
		</div>
		<div class="col-xs-2">
			<label></label>
			<div class="row">
				<button id="btnGetUpdateOrder" class="btn btn-md btn-primary">
						<i class="icon-spinner"></i>
						Get Client
				</button>
			</div>
			
		</div>
		<div class="col-xs-4">
			<div>
			<label for="cmbClientInfo">Client</label>
			<br/>
			<select class="width-80 chosen-select" id="cmbClientInfo" data-placeholder="Choose a CLient...">
			</select>
			</div>
		</div>
	</div>
	
	
</div>

	<div class="row">
		<div class="col-xs-12">
			<table id="update_order_grid_table"></table>
		</div>
	</div>
	<br/>
	<div class="row"><!-- 
		<div class="col-xs-1">
	
			<label for="cmbPartStatus">Part Status</label>
		</div>
		<div class="col-xs-3">
		
			<select class="form-control" id="cmbPartStatus">
				<option value="Completed">Completed</option>
				<option value="Failure">Failure</option>
			</select>
		</div> -->
		<div class="col-xs-1">
			<button id="btnSubmitUpdateOrder" class="btn btn-sm btn-success">
				<i class="icon-save"></i>
				Save
			</button>	
		</div>
		<div id="alertContainer" style="position: fixed; bottom:10px; right:10px; z-index:9999">
			
		</div>
	</div>
<script>

	$(document).ready(function(){
		
		$('.date-picker').datepicker({autoclose:true}).next().on(ace.click_event, function(){
			$(this).prev().focus();
		});
			
		var grid_data =[];
		
		var update_order_grid = "#update_order_grid_table";
		
		jQuery(update_order_grid).jqGrid({
			datastr: grid_data,
			datatype: "local",
			height: 280,
			colNames:['Order No','Order Name','Client Name','Created By','Date of Creation', 'Charges'],
			colModel:[
				{name:'_id',index:'_id', width:125,editable: false},
				{name:'orderName',index:'orderName', width:125, editable: false},
				{name:'client.name',index:'client.name', width:275, editable: false},
				{name:'createdBy',index:'createdBy', width:100, editable: false},
				{name:'orderDateStr',index:'orderDateStr', width:135, editable: false},
				{name:'t_charges',index:'t_charges', width:150, editable: true, classes: 'editCls'}
			],
			viewrecords : true,
			altRows: true,
			rownumbers: true,
			multiselect: true,
			caption: "Order Details",
			autowidth: true,
			cellEdit : true,
			cellsubmit :"clientArray"
		});
		

		$('#btnSubmitUpdateOrder').click(function(){
			var selData = jQuery(update_order_grid).jqGrid('getRowData');
			
			var param ={'order':JSON.stringify(selData),'process':$("#idProcessType").val()};
			
			console.log(param);
			$.ajax({
			  	url: '${pageContext.request.contextPath}/updateOrder.action?op=EDIT',
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

		
		$('#btnGetUpdateOrder').click(function(){
			var dateRange = $('#idFromToDate').val();
			var date = dateRange.split(" to ");
			var operation = $("#idProcessType").val();
			clientMap = {};
			param = {"fromDate":date[0],"toDate":date[1], "operation": operation};
			console.log(param);
			$.ajax({
			  	url: '${pageContext.request.contextPath}/updateOrder.action?op=VIEW_ALL',
			  	type: 'POST',
			  	data: param
			  })
			  .done(function(data) {
			  	console.log("success "+data);
			  	dataFromServer = [];
			  	dataFromServer = JSON.parse(data);
			  	
			  	if(dataFromServer){
			  		
				  	$("#cmbClientInfo").empty();
				  	$(update_order_grid).jqGrid("clearGridData");
				  	
				  	$("#cmbClientInfo").append("<option value='all'>All<option>");
				  	
				  	$.each(dataFromServer ,function(ind,val){
				  		var clientId = val.client.clientId;
				  			
				  		if(!clientMap.hasOwnProperty(clientId)){
							clientMap[clientId] = [];
					  		$("#cmbClientInfo").append("<option value="+val.client.clientId+">"+val.client.clientId+"<option>");
				  		}
						clientMap[clientId].push(val);
				  	});
				  	
				  	$('.chosen-select').chosen().trigger("chosen:updated");
				  	
				  	$(update_order_grid).jqGrid('setGridParam', {data: dataFromServer }).trigger('reloadGrid');
				  	
			  	}
			  	
			  	//$('#noGridContainer').hide();
		        //$('#gridContainer').show(); 
			  })
			  .fail(function() {
			  	console.log("error");
			  })
			  .always(function() {
			  	console.log("complete");
			  });
		});
		
		//jQuery(update_order_grid).jqGrid('filterToolbar', { defaultSearch: 'cn', stringResult: true });
		//jQuery(update_order_grid).jqGrid('setGridParam', {data: grid_data}).trigger('reloadGrid');
		
		$('.date-picker').datepicker({autoclose:true}).next().on(ace.click_event, function(){
			$(this).prev().focus();
		});
		$('.date-picker').datepicker('setDate',new Date());
		
        $('input[name=date-range-picker]').daterangepicker({
        	format: 'DD/MM/YYYY',
        	separator: ' to '
        	}).prev().on(ace.click_event, function(){
			$(this).next().focus();
		});
        
		$(".chosen-select").chosen();	 
	});
	
</script>

<!-- page specific plugin scripts -->
<script src="${pageContext.request.contextPath}/assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jqGrid/jquery.jqGrid.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jqGrid/i18n/grid.locale-en.js"></script>

