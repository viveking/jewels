
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
				<option value="WV">West Virginia</option>
				<option value="WI">Wisconsin</option>
				<option value="WY">Wyoming</option>
			</select>
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
		<h1>Upload Order List</h1>
		<p class="lead"> Upload the file which is auto-generated from the exe. </p>
	</div><!-- /.row -->
	
</div>

<script>

	$(document).ready(function(){
		/* clientNameJson={};
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
		  
		 */
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

	/*var grid_data = 
	[ {orderDate:"25-02-2015",clientId:"Monil",orderNo:"123",orderName:"NewOrder Bali",selectCAM:true,selectRM:false,selectCAD:true,selectCAST:false},
	  {orderDate:"25-02-2015",clientId:"Monil",orderNo:"122",orderName:"NewOrder Bali",selectCAM:true,selectRM:true,selectCAD:true,selectCAST:true},
	  {orderDate:"25-02-2015",clientId:"Monil",orderNo:"121",orderName:"NewOrder Bali",selectCAM:false,selectRM:false,selectCAD:false,selectCAST:false},
	  {orderDate:"25-02-2015",clientId:"Monil",orderNo:"120",orderName:"NewOrder Bali",selectCAM:true,selectRM:true,selectCAD:true,selectCAST:true},
	  {orderDate:"25-02-2015",clientId:"Monil",orderNo:"121",orderName:"NewOrder Bali",selectCAM:false,selectRM:false,selectCAD:false,selectCAST:false},
	  {orderDate:"25-02-2015",clientId:"Monil",orderNo:"120",orderName:"NewOrder Bali",selectCAM:true,selectRM:true,selectCAD:true,selectCAST:true},
	  {orderDate:"26-02-2015a",clientId:"Monil",orderNo:"1234",orderName:"NewOrder Balia",selectCAM:true,selectRM:false,selectCAD:true,selectCAST:false},{}
	];*/
	var grid_data = [];
	
	jQuery(function($) {
		var order_grid_selector = "#order-grid-table";
		
		jQuery(order_grid_selector).jqGrid({
			data: grid_data,
			datatype: "local",
			gridview: true,
			height: 320,
			colNames:['Order Date','Client ID','Order No','Order Name','Select CAM','Select RM','Select CAD','Select CAST'],
			colModel:[
				{name:'orderDate',index:'orderDate', width:150,editable: false},
				{name:'clientId',index:'clientId', width:150,editable: false},
				{name:'orderNo',index:'orderNo', width:150,editable: false},
				{name:'orderName',index:'orderName', width:150,editable: false},
				{name:'selectCAM',index:'selectCAM', width: 70, align: "center",
                    formatter: "checkbox", formatoptions: { disabled: false},
                    edittype: "checkbox", editoptions: {value: "Yes:No", defaultValue: "Yes"}},
				{name:'selectRM',index:'selectRM', width: 70, align: "center",
                        formatter: "checkbox", formatoptions: { disabled: false},
                        edittype: "checkbox", editoptions: {value: "Yes:No", defaultValue: "Yes"} },
				{name:'selectCAD',index:'selectCAD', width: 70, align: "center",
                            formatter: "checkbox", formatoptions: { disabled: false},
                            edittype: "checkbox", editoptions: {value: "Yes:No", defaultValue: "Yes"}},
				{name:'selectCAST',index:'selectCAST', width: 70, align: "center",
                                formatter: "checkbox", formatoptions: { disabled: false},
                                edittype: "checkbox", editoptions: {value: "Yes:No", defaultValue: "Yes"} }
			],
			hiddengrid: false,
			viewrecords : true,
			rowNum:100000,
			altRows: true,
			rownumbers: true,  
			multiselect: false,
			caption: "Order Details",
			autowidth: true
		});

		$('#idSaveOrder').click(function(){
			var passedGrid = $("#order-grid-table");
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

       /*  $('#noGridContainer').show();
        $('#gridContainer').hide(); */
        
	});
</script>

<!-- page specific plugin scripts -->

<script src="assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="assets/js/jqGrid/jquery.jqGrid.min.js"></script>
<script src="assets/js/jqGrid/i18n/grid.locale-en.js"></script>

