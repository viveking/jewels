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
		Parts Update
		<small>
			<i class="icon-double-angle-right"></i>
			Update the parts status and price.
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
	
	<div class="row" id="gridContainer">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->

			<table id="grid-table"></table>
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
		<h1>Update order parts</h1>
		<p class="lead"> Select options to update the parts. </p>
	</div><!-- /.row -->
	
</div>

<script>

	$(document).ready(function(){
		$(".chosen-select").chosen();
		
		var clientNameJson={};
		var platformList = {};

		$.ajax({
		  	url: '${pageContext.request.contextPath}/platform.action?op=ALL_PLATFORM_ID',
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
				  	url: '${pageContext.request.contextPath}/order.action?op=VIEW_PENDING_PARTS',
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
			height: 320,
			colNames:['Order Date','Client ID','Platform','Order Name','Part','Weight (KG)','Reference Weight (KG)'],
			colModel:[
				{name:'orderDateStr',index:'orderDateStr', width:150,editable: false},
				{index:'client',name:'client.clientId', width:150,editable: false},
				{index:'platform',name:'partList.platformNumber', width:150, editable: false},
				{index:'orderName',name:'orderName', width:150, editable: false},
				{index:'part',name:'partList.name', width:300, editable: false},
				{index:'partWeight',name:'partList.weight',formatter:'number',formatoptions:{decimalPlaces: 4}, width:300, editable: true, classes: 'editCls'},
				{index:'supportWeight',name:'partList.refWeight',formatter:'number',formatoptions:{decimalPlaces: 4}, width:300, editable: true, classes: 'editCls'}
			], 
			hiddengrid: false,
			viewrecords : true,
			rowNum:100000,
			cellEdit:true,
			cellsubmit:"clientArray",
			altRows: true,
			rownumbers: true,  
			multiselect: false,
			caption: "Parts Update",
			autowidth: true
	
		});
		
		$('#idSaveParts').click(function(){
			var passedGrid = $("#grid-table");
			var selData = passedGrid.jqGrid('getGridParam','data');
			$.each(selData,function(i,val){
				if(val.hasOwnProperty("partList.weight"))
					val.partList.weight = val["partList.weight"];
				if(val.hasOwnProperty("partList.refWeight"))
					val.partList.refWeight = val["partList.refWeight"];
			});
			
			var param ={'order':JSON.stringify(selData)};
			
			$.ajax({
			  	url: '${pageContext.request.contextPath}/platform.action?op=SAVE_PARTS_UPDATE',
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
