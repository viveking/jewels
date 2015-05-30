
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
		
			<label for="form-field-select-2">Select Operation</label>
			
			<select class="form-control" id="form-field-select-2">
				<option value="CAD">CAD</option>
				<option value="CAST">CAST</option>
				<option value="RM">RM</option>
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
				<option value="">&nbsp;</option>
				<option value="Chaudhary">Chaudhary</option>
				<option value="Hardik">Hardik</option>
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
	<div class="row">
		<div class="col-xs-1">
	
			<label for="cmbPartStatus">Part Status</label>
		</div>
		<div class="col-xs-3">
		
			<select class="form-control" id="cmbPartStatus">
				<option value="Completed">Completed</option>
				<option value="Failure">Failure</option>
			</select>
		</div>
		<div class="col-xs-1">
			<button id="btnSubmitUpdateOrder" class="btn btn-sm btn-success">
				<i class="icon-save"></i>
				Save
			</button>	
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
			autowidth: true,
			cellEdit : true,
			cellsubmit :"clientArray"
	
		});
		//jQuery(update_order_grid).jqGrid('filterToolbar', { defaultSearch: 'cn', stringResult: true });
		jQuery(update_order_grid).jqGrid('setGridParam', {data: grid_data}).trigger('reloadGrid');
		
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

<script src="assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="assets/js/jqGrid/jquery.jqGrid.min.js"></script>
<script src="assets/js/jqGrid/i18n/grid.locale-en.js"></script>

