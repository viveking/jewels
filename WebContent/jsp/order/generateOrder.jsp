
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="page-header">
	<h1>
		Order Generation
		<small>
			<i class="icon-double-angle-right"></i>
			CAM,RM,CAD,CAST Order Generation.
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
		<div class="col-xs-4">
		
			<label for="idSelectClient">Select Client</label>
					
			<select class="width-80 chosen-select" id="form-field-select-3" data-placeholder="Choose a Country...">
				<option value="">&nbsp;</option>
				<option value="AL">Alabama</option>
				<option value="AK">Alaska</option>
				<option value="AZ">Arizona</option>
				<option value="AR">Arkansas</option>
				<option value="CA">California</option>
				<option value="CO">Colorado</option>
				<option value="CT">Connecticut</option>
				<option value="DE">Delaware</option>
				<option value="FL">Florida</option>
				<option value="GA">Georgia</option>
				<option value="HI">Hawaii</option>
				<option value="ID">Idaho</option>
				<option value="IL">Illinois</option>
				<option value="IN">Indiana</option>
				<option value="IA">Iowa</option>
				<option value="KS">Kansas</option>
				<option value="KY">Kentucky</option>
				<option value="LA">Louisiana</option>
				<option value="ME">Maine</option>
				<option value="MD">Maryland</option>
				<option value="MA">Massachusetts</option>
				<option value="MI">Michigan</option>
				<option value="MN">Minnesota</option>
				<option value="MS">Mississippi</option>
				<option value="MO">Missouri</option>
				<option value="MT">Montana</option>
				<option value="NE">Nebraska</option>
				<option value="NV">Nevada</option>
				<option value="NH">New Hampshire</option>
				<option value="NJ">New Jersey</option>
				<option value="NM">New Mexico</option>
				<option value="NY">New York</option>
				<option value="NC">North Carolina</option>
				<option value="ND">North Dakota</option>
				<option value="OH">Ohio</option>
				<option value="OK">Oklahoma</option>
				<option value="OR">Oregon</option>
				<option value="PA">Pennsylvania</option>
				<option value="RI">Rhode Island</option>
				<option value="SC">South Carolina</option>
				<option value="SD">South Dakota</option>
				<option value="TN">Tennessee</option>
				<option value="TX">Texas</option>
				<option value="UT">Utah</option>
				<option value="VT">Vermont</option>
				<option value="VA">Virginia</option>
				<option value="WA">Washington</option>
				<option value="WV">West Virginia</option>
				<option value="WI">Wisconsin</option>
				<option value="WY">Wyoming</option>
			</select>
		</div>
	</div>
	
	<div class="row" id="gridContainer">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->

			<table id="passed-grid-table"></table>
			<button class="btn btn-md btn-success" id="idSaveOrder">
				<i class="icon-ok"></i>
				Save
			</button>
			<table id="failed-grid-table"></table>
			
			<script type="text/javascript">
				var $path_base = "/";//this will be used in gritter alerts containing images
			</script>

			<!-- PAGE CONTENT ENDS -->
		</div><!-- /.col -->
	</div><!-- /.row -->
	<div class="col-md-offset-1 row" id="noGridContainer">
		<h1>Upload Order List</h1>
		<p class="lead"> Upload the file which is auto-generated from the exe. </p>
	</div><!-- /.row -->
	
</div>

<script>

	$(document).ready(function(){
		clientNameJson={};
		$.ajax({
		  	url: '${pageContext.request.contextPath}/clientmaster.action?op=ALL_CLIENT_ID',
		  	type: 'GET'
		  })
		  .done(function(data) {
		  	console.log("success "+data);
		  	data = JSON.parse(data);
		  	for(var k in data) {
		  	   console.log(k, data[k]);
		  	 clientNameJson[data[k]] = "";
		  	}
		  	
		  })
		  .fail(function() {
		  	console.log("error");
		  })
		  .always(function() {
		  	console.log("complete");
		  });
		  
		
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

	var grid_data = 
	[
	];	
	
	jQuery(function($) {
		var passed_grid_selector = "#passed-grid-table";
		var failed_grid_selector = "#failed-grid-table";
		
		jQuery(passed_grid_selector).jqGrid({
			data: grid_data,
			datatype: "local",
			height: 320,
			colNames:['Client','Order Name','Part','Status'],
			colModel:[
				{name:'clientName',index:'clientName', width:150,editable: false},
				{name:'clientOrderName',index:'clientOrderName', width:150, editable: false},
				{name:'fileName',index:'fileName', width:300, editable: false},
				{name:'status',index:'status', width:100, editable: false} 
			], 
			hiddengrid: false,
			viewrecords : true,
			rowNum:-1,
			//rowList:[10,20,30],
			altRows: true,
			rownumbers: true,  
			multiselect: true,
	        //multiboxonly: true,
			
			caption: "Passed Order Details",
	
			autowidth: true,
			grouping: true,
		   	groupingView : {
		   		//groupField : ['clientName', 'clientOrderName'],
		   		//groupColumnShow : [false, false],
		   		groupText : ['Client: <span style="color:red">{0}</span>', 'Order Name: <b>{0}</b>'],
		   		groupCollapse : false,
				//groupOrder: ['asc', 'asc'],
				groupSummary : [false, false]
		   	}
	
		});
		
		jQuery(failed_grid_selector).jqGrid({
			data: grid_data,
			datatype: "local",
			height: 320,
			colNames:['Client','Order Name','Part','Status'],
			colModel:[
				{name:'clientName',index:'clientName', width:150,editable: false},
				{name:'clientOrderName',index:'clientOrderName', width:150, editable: false},
				{name:'fileName',index:'fileName', width:300, editable: false},
				{name:'status',index:'status', width:100, editable: false} 
			], 
			hiddengrid: false,
			viewrecords : true,
			rowNum:-1,
			//rowList:[10,20,30],
			altRows: true,
			rownumbers: true,  
			//multiselect: true,
	        //multiboxonly: true,
			
			caption: "Failed Order Details",
	
			autowidth: true,
			grouping: true,
		   	groupingView : {
		   		//groupField : ['clientName', 'clientOrderName'],
		   		//groupColumnShow : [false, false],
		   		groupText : ['Client: <span style="color:red">{0}</span>', 'Order Name: <b>{0}</b>'],
		   		groupCollapse : false,
				//groupOrder: ['asc', 'asc'],
				groupSummary : [false, false]
		   	}
	
		});
		
		$('#idSaveOrder').click(function(){
			var passedGrid = $("#passed-grid-table");
			var selRows = passedGrid.jqGrid('getGridParam','selarrrow');
			
			var selData=[];
			$.each(selRows,function(inx,val){
				selData.push(passedGrid.getRowData(val));
			});
			
			var param ={'order':selData,'printer':$('#form-field-select-1').val(),'date':$('#id-date-picker-1').val()};
			
			param = JSON.stringify(param);
			console.log(param);
			$.ajax({
			  	url: '${pageContext.request.contextPath}/order.action?op=ADD',
			  	type: 'POST',
			  	data: param
			  })
			  .done(function(data) {
			  	console.log("success "+data);
			  	
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

