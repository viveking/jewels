<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<STYLE>

	.ui-state-highlight{
	     border:none!important;
	     background:none!important;
	}
	.selected-row{
	     border:none!important;
	     background:none!important;
	}

</STYLE>

<div class="page-header">
	<h1>
		Completed Order Update
		<small>
			<i class="icon-double-angle-right"></i>
			Update the order weight and price.
		</small>
	</h1>
</div><!-- /.page-header -->

<div class="form-group">

	<div class="row">
		<div class="col-xs-2">
		
			<label for="idSelectOption">Select Option</label>
			
			<select class="form-control" id="idSelectOption">
				<option value="">Select</option>
				<option value="client">Client</option>
				<option value="platform">Platform</option>
			</select>
			
		</div>
		
		<div class="col-xs-4">
		
			<label for="idSelect" style="color:transparent">Select option</label>
					
			<select class="width-80 chosen-select" id="idSelect" data-placeholder="Please choose">
			</select>
			
		</div>
	</div>
	
	<div class="row" id="gridContainer" style="margin-top: 10px;">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->

			<table id="grid-table" style="margin:0 0 10px 0;"></table>
			<button class="btn btn-md btn-success" id="idSaveParts">
				<i class="icon-ok"></i>
				Save
			</button>
			
		<div id="alertContainer" style="position: fixed; bottom:10px; right:10px; z-index:9999">
			
		</div>
		
			<script type="text/javascript">
				var $path_base = "/";//this will be used in gritter alerts containing images
			</script>

			<!-- PAGE CONTENT ENDS -->
		</div><!-- /.col -->
	</div><!-- /.row -->
	<div class="col-md-offset-1 row" id="noGridContainer">
		<h1>Update order</h1>
		<p class="lead"> Select options to update the order. </p>
	</div><!-- /.row -->
	
</div>

<script>
var rowCAMUpdateMethod = function (id){
	var p =  jQuery("#txt_cam_"+ id ).val();
	p = Number(p).toFixed(2);
	jQuery("#grid-table").jqGrid('setCell', id, 'cam.weight', p);
};

var rowRMUpdateMethod = function (id){
	var p =  jQuery("#txt_rm_"+ id ).val();
	p = Number(p).toFixed(2);
	jQuery("#grid-table").jqGrid('setCell', id, 'rm.weight', p);
	
	console.log(p);
};
var rowCADUpdateMethod = function (id){
	var p =  jQuery("#txt_cad_"+ id ).val();
	p = Number(p).toFixed(2);
	jQuery("#grid-table").jqGrid('setCell', id, 'cad.amount', p);
	
	console.log(p);
};

	$(document).ready(function(){
		$(".chosen-select").chosen();
		
		var clientNameJson={};
		var platformList = {};

		$.ajax({
		  	url: '${pageContext.request.contextPath}/platform.action?op=ALL_PLATFORM_ID&status=COMPLETED',
		  	type: 'GET',
		  	async: false
		  })
		  .done(function(data) {
		  	console.log("success "+data);
		  	platformList = JSON.parse(data);
		  })
		  .fail(function() {
		  	console.log("error");
		  })
		  .always(function() {
		  	console.log("complete");
		  });
		
		$.ajax({
		  	url: '${pageContext.request.contextPath}/clientmaster.action?op=ALL_CLIENT_ID',
		  	type: 'GET',
		  	async: false
		  })
		  .done(function(data) {
		  	console.log("success "+data);
		  	clientNameJson = JSON.parse(data);
		    
		  })
		  .fail(function() {
		  	console.log("error");
		  })
		  .always(function() {
		  	console.log("complete");
		  });

		function changedOption(evt) {
		    var f = evt.target.value; 
		  	var dataPopulate = {};

	    	$("#idSelect").empty();
		  	$("#grid-table").jqGrid("clearGridData");

		  	if (f == "platform") {
		    	dataPopulate=platformList;
		    } else if (f == "client") { 
		    	dataPopulate=clientNameJson;
		    }
		    
		    $.each(dataPopulate ,function(ind,val){
		  		$("#idSelect").append("<option value="+val+">"+val+"<option>");
		  	});

		  	$('.chosen-select').chosen().trigger("chosen:updated");
		  	populateGrid();
		  };

		  document.getElementById('idSelectOption').addEventListener('change', changedOption, false);

		  function populateGrid(){
			  $('#noGridContainer').hide();
		      $('#gridContainer').show();
		      $("#grid-table").jqGrid("clearGridData");

		      var param = {"sBy":$("#idSelectOption").val(),"value":$("#idSelect").val()};
			  $.ajax({
				  	url: '${pageContext.request.contextPath}/order.action?op=VIEW_COMPLETED_ORDER',
				  	type: 'POST',
				  	data: param
				  })
				  .done(function(dat) {
				  	
				  	if(dat!=""){
			  			dat = JSON.parse(dat);
				  	}
				  	
		  			$(passed_grid_selector).jqGrid('setGridParam', {data: dat }).trigger('reloadGrid');
				    
				  })
				  .fail(function() {
				  	console.log("error");
				  })
				  .always(function() {
				  	console.log("complete");
				  });
		  };
		  $("#idSelect").on('change', function(){
			  populateGrid();
		  });
		  
		var grid_data = [];	
		
		var passed_grid_selector = "#grid-table";
		
		jQuery(passed_grid_selector).jqGrid({
			data: grid_data,
			datatype: "local",
			height: "auto",
			colNames:['Client ID','Platform','id','Order No','Order Date','Order Name','cm','r','c','CAM (Grams)','RM (Grams)','CAD Amount','CAST Amount','rmRequired','cadRequired'],
			colModel:[
				{index:'client',name:'client.clientId', width:140,editable: false},
				{index:'platform',name:'partList.0.platformNumber', width:90, editable: false},
				{name:'_id',index:'_id', width:90,editable: false,hidden:true},
				{name:'displayOrderNumber',index:'displayOrderNumber', width:90,editable: false},
				{name:'orderDateStr',index:'orderDateStr', width:100,editable: false},
				{index:'orderName',name:'orderName', width:165, editable: false},
				{index:'cam.weight',name:'cam.weight',hidden: true},
				{index:'rm.weight',name:'rm.weight',hidden: true},
				{index:'cad.amount',name:'cad.amount',hidden: true},
				{
				    name: 'cam.weight',
				    index: 'cam.weight',
				    width: 100,
				    formatter: function (cellValue, option, rawObject) {
				    		
			    		return '<input type="text" name="txtBox" id="txt_cam_' + option.rowId + '" value="' + cellValue +
					        	'"onchange="rowCAMUpdateMethod('+ option.rowId +')" />';
				    },
				    cellattr: function (rowid, cellvalue, rawObject, cm, rdata) {
					    return rawObject.cam.required  == true ? 'class="editCls"' : '';
					}
				},
				{
				    name: 'rm.weight',
				    index: 'rm.weight',
				    width: 100,
				    formatter: function (cellValue, option, rawObject) {
				    		if(rawObject.rm.required){
				    			return '<input type="text" name="txtBox" id="txt_rm_' + option.rowId + '" value="' + cellValue +
					        	'"onchange="rowRMUpdateMethod('+ option.rowId +')" />';
				    		} else {
				    			return cellValue;
				    		}
				        	
				    },
				    cellattr: function (rowid, cellvalue, rawObject, cm, rdata) {
					    return rawObject.rm.required  == true ? 'class="editCls"' : '';
				}
				},
				
				{index:'cad.amount',name:'cad.amount',formatter:'number',formatoptions:{decimalPlaces: 2},
					width:100, editable: true,
					formatter: function (cellValue, option, rawObject) {
			    		if(rawObject.cad.required){
			    			return '<input type="text" name="txtBox" id="txt_cad_' + option.rowId + '" value="' + cellValue +
				        	'"onchange="rowCADUpdateMethod('+ option.rowId +')" />';
			    		} else {
			    			return cellValue;
			    		}
			    },
					cellattr: function (rowid, cellvalue, rawObject, cm, rdata) {
					    return rawObject.cad.required  == true ? 'class="editCls"' : '';
				}},
				{index:'cast.amount',name:'cast.amount',hidden:true, formatter:'number',formatoptions:{decimalPlaces: 2},
					width:100, editable: true,
					cellattr: function (rowid, cellvalue, rawObject, cm, rdata) {
					    return rawObject.cast.required  == true ? 'class="editCls"' : '';
				}},
				
				{index:'rm.required',name:'rm.required',hidden: true},
				{index:'cad.required',name:'cad.required',hidden: true}
			],
			beforeSelectRow: function(rowid, e){
				var data = jQuery(passed_grid_selector).jqGrid('getRowData', rowid);
				var $td = $(e.target).closest("td"), iCol = $.jgrid.getCellIndex($td[0]);
				var flag = true;
				if(iCol === 7)
				{
					if(data["rm.required"]  === "true"){
						flag = true;
					}
					else{
						flag = false;
					}
				}
				if(iCol === 8)
				{
					if(data["cad.required"]  === "true"){
						flag = true;
					}
					else{
						flag = false;
					}
				}
				return flag;
			},
			hiddengrid: false,
			viewrecords : true,
			cmTemplate: {
				sortable:false
			},
			sortable: false,
			rowNum:100000,
			cellEdit:true,
			cellsubmit:"clientArray",
			altRows: true,
			rownumbers: true,  
			multiselect: false,
			caption: "Order Update",
			autowidth: true
	
		});
		
		$('#idSaveParts').click(function(){
			var passedGrid = $("#grid-table");
			var selData = passedGrid.jqGrid('getGridParam','data');
			$.each(selData,function(i,val){
				if(val.hasOwnProperty("cam.weight"))
					val.cam.weight = val["cam.weight"];
				if(val.hasOwnProperty("cad.amount"))
					val.cad.amount = val["cad.amount"];
				if(val.hasOwnProperty("rm.weight"))
					val.rm.weight = val["rm.weight"];
				if(val.hasOwnProperty("cast.amount"))
					val.cast.amount = val["cast.amount"];
				
			});
			async.loadingDialog.showPleaseWait();
			
			var param ={'order':JSON.stringify(selData)};
			
			$.ajax({
			  	url: '${pageContext.request.contextPath}/platform.action?op=SAVE_ORDER_UPDATE',
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
				  async.loadingDialog.hidePleaseWait();
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