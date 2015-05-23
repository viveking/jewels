
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
		
			<label for="id-date-picker-1">From Date</label>
					
			<div class="input-group">
				<input class="form-control date-picker" id="id-date-picker-1" type="text" data-date-format="dd-mm-yyyy" />
				<span class="input-group-addon">
					<i class="icon-calendar bigger-110"></i>
				</span>
			</div>
		</div>
		<div class="col-xs-4">
		
			<label for="id-date-picker-2">To Date</label>
					
			<div class="input-group">
				<input class="form-control date-picker" id="id-date-picker-2" type="text" data-date-format="dd-mm-yyyy" />
				<span class="input-group-addon">
					<i class="icon-calendar bigger-110"></i>
				</span>
			</div>
		</div>
		
		<div class="col-xs-3">
		
			<label for="form-field-select-2">Select Operation</label>
			
			<select class="form-control" id="form-field-select-2">
				<option value="CAD">CAD</option>
				<option value="CAST">CAST</option>
				<option value="RM">RM</option>
			</select>
		</div>
		<div class="col-xs-1">
			<label ></label>
	
			<button class="btn btn-md btn-primary">
					<i class="icon-spinner"></i>
					Get
			</button>
		</div>
			
	</div>
	
	
</div>

	<div class="row">
		<div class="col-xs-12">
			<table id="update_order_grid_table"></table>
		</div>
	</div>
<script>

	$(document).ready(function(){
		
		$('.date-picker').datepicker({autoclose:true}).next().on(ace.click_event, function(){
			$(this).prev().focus();
		});
			
		var grid_data =[{"orderNo":1,"orderName":12,"clientName":2,"units":3,"part":4,"weight":5,"createdBy":6,"dateOfCreation":7,"partStatus":8,"charges":9},{"orderNo":3,"orderName":35,"clientName":2,"units":3,"part":4,"weight":5,"createdBy":6,"dateOfCreation":7,"partStatus":8,"charges":9},{"orderNo":0,"orderName":1,"clientName":2,"units":3,"part":4,"weight":5,"createdBy":6,"dateOfCreation":7,"partStatus":8,"charges":9},{"orderNo":0,"orderName":1,"clientName":2,"units":3,"part":4,"weight":5,"createdBy":6,"dateOfCreation":7,"partStatus":8,"charges":9},{"orderNo":0,"orderName":1,"clientName":2,"units":3,"part":4,"weight":5,"createdBy":6,"dateOfCreation":7,"partStatus":8,"charges":9},{"orderNo":0,"orderName":1,"clientName":2,"units":3,"part":4,"weight":5,"createdBy":6,"dateOfCreation":7,"partStatus":8,"charges":9},{"orderNo":0,"orderName":1,"clientName":2,"units":3,"part":4,"weight":5,"createdBy":6,"dateOfCreation":7,"partStatus":8,"charges":9},{"orderNo":0,"orderName":1,"clientName":2,"units":3,"part":4,"weight":5,"createdBy":6,"dateOfCreation":7,"partStatus":8,"charges":9},{"orderNo":0,"orderName":1,"clientName":2,"units":3,"part":4,"weight":5,"createdBy":6,"dateOfCreation":7,"partStatus":8,"charges":9},{"orderNo":0,"orderName":1,"clientName":2,"units":3,"part":4,"weight":5,"createdBy":6,"dateOfCreation":7,"partStatus":8,"charges":9}];
			
		var update_order_grid = "#update_order_grid_table";
		jQuery(update_order_grid).jqGrid({
			datastr: grid_data,
			datatype: "local",
			height: 280,
			colNames:['Order No','Order Name','Client Name','Units', 'Part','Weight','Created By','Date of Creation', 'Part Status','Charges'],
			colModel:[
				{name:'orderNo',index:'orderNo', width:125,editable: false},
				{name:'orderName',index:'orderName', width:125, editable: false},
				{name:'clientName',index:'clientName', width:275, editable: false},
				{name:'units',index:'units', width:80, editable: false},
				{name:'part',index:'part', width:80, editable: false},
				{name:'weight',index:'weight', width:80, editable: false},
				{name:'createdBy',index:'createdBy', width:100, editable: false},
				{name:'dateOfCreation',index:'dateOfCreation', width:135, editable: false},
				{name:'partStatus',index:'partStatus', width:100, editable: false},
				{name:'charges',index:'charges', width:150, editable: true}
			], 
			viewrecords : true,
			altRows: true,
			rownumbers: true,  
			multiselect: true,
			caption: "Order Details",
			autowidth: true
	
		});
		jQuery(update_order_grid).jqGrid('filterToolbar', { defaultSearch: 'cn', stringResult: true });
		jQuery(update_order_grid).jqGrid('setGridParam', {data: grid_data}).trigger('reloadGrid');

	});
</script>

<!-- page specific plugin scripts -->

<script src="assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="assets/js/jqGrid/jquery.jqGrid.min.js"></script>
<script src="assets/js/jqGrid/i18n/grid.locale-en.js"></script>

