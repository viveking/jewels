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
		Platform Output Calculation
		<small>
			<i class="icon-double-angle-right"></i>
			Platform Output Calculation.
		</small>
	</h1>
</div><!-- /.page-header -->

<div class="form-group">

	<div class="row">
		<div class="col-xs-4">
		
			<label for="idPrinterSelect">Select Printer</label>
			
			<select class="form-control" id="idPrinterSelect">
				<option value="INVISIONHR">INVISIONHR</option>
				<option value="VIPER25">VIPER25</option>
				<option value="VIPER50">VIPER50</option>
				<option value="ZNone">ZNone</option>
			</select>
		</div>
		
		<div class="col-xs-4">
		
			<label for="idOutputCalculation">Upload File</label>
					
			<input type="file" id="idOutputCalculation" />
		</div>
	</div>
	
	<div class="row" id="gridContainer">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->

			<table id="grid-table"></table>
			<button class="btn btn-md btn-success" id="idSaveOrder">
				<i class="icon-ok"></i>
				Save
			</button>
			
			<script type="text/javascript">
				var $path_base = "/";//this will be used in gritter alerts containing images
			</script>
	
		<div id="alertContainer" style="position: fixed; bottom:10px; right:10px; z-index:9999">
			
		</div>
			<!-- PAGE CONTENT ENDS -->
		</div><!-- /.col -->
	</div><!-- /.row -->
	<div class="col-md-offset-1 row" id="noGridContainer">
		<h1>Upload Platform Output File</h1>
		<p class="lead"> Upload the output file. </p>
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
		
		$('#idOutputCalculation').ace_file_input({
			no_file:'No File ...',
			btn_choose:'Choose',
			btn_change:'Change',
			droppable:false,
			onchange:null,
			thumbnail:false
		});
		
		function readSingleFile(evt) {
		    //Retrieve the first (and only!) File from the FileList object
		    var f = evt.target.files[0]; 

		    if (f) {
		      var r = new FileReader();
		      r.onload = function(e) { 
			      var contents = e.target.result;
			      var arrFiles = contents.split("\r\n	File: ");
		          var lenArrFiles = arrFiles.length;
		          var arrGridData = [];
		          for(var i=0;i<lenArrFiles;i++){
		        	  var jsonObj = {};
			          
		        	  var arrEachPart = arrFiles[i].split("\r\n");
		        	  if(arrEachPart[0].toLowerCase().trim().indexOf(".stl") != -1){
		        		  
		        		  var arrPathSplit = arrEachPart[0].split("\\");
		        		  var lenPathSplit = arrPathSplit.length;
		        		  
		        		  jsonObj.part = arrPathSplit[lenPathSplit - 1];
		        		  jsonObj.client = arrPathSplit[lenPathSplit - 2];
		        		  jsonObj.platform = arrPathSplit[lenPathSplit - 3];
		        		  jsonObj.partWeight = arrEachPart[5].split(":")[1].trim();
		        		  jsonObj.supportWeight = arrEachPart[6].split(":")[1].trim();
		          		  jsonObj.partStatus = "COMPLETED";
		          		  
		        		  console.log(JSON.stringify(jsonObj));
			        	  
		        		  arrGridData.push(jsonObj);
		        	  }
		        	  
		          }
		          $("#grid-table").jqGrid("clearGridData");
		          $('#grid-table').jqGrid('setGridParam', {data: arrGridData}).trigger('reloadGrid');

		          $('#noGridContainer').hide();
		          $('#gridContainer').show();
		      }
		      r.readAsText(f);
		    } else { 
		      alert("Failed to load file");
		    }
		  }

		  document.getElementById('idOutputCalculation').addEventListener('change', readSingleFile, false);

	});

	var grid_data = 
	[
	];	
	
	jQuery(function($) {
		var passed_grid_selector = "#grid-table";
		
		jQuery(passed_grid_selector).jqGrid({
			data: grid_data,
			datatype: "local",
			height: 320,
			colNames:['Client ID','Platform','Part','Weight (KG)','Status'],
			colModel:[
				{name:'client',index:'client', width:150,editable: false},
				{name:'platform',index:'platform', width:150, editable: false},
				{name:'part',index:'part', width:300, editable: false},
				{name:'partWeight',index:'partWeight',formatter:'number',formatoptions:{decimalPlaces: 4}, width:200, editable: true, classes: 'editCls'},
				{name:'partStatus',index:'partStatus', width:200, editable: true, edittype:"select", editrules:{required:true, edithidden:true},editoptions:{ value:{"INPROGRESS":"INPROGRESS","COMPLETED":"COMPLETED"}},formatter:'select', classes: 'editCls'}
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
			caption: "Platform Output Details",
			autowidth: true
	
		});
		
		$('#idSaveOrder').click(function(){
			var passedGrid = $("#grid-table");
			var selData = passedGrid.jqGrid('getGridParam','data');
			
			var param ={'order':JSON.stringify(selData),'printer':$('#idPrinterSelect').val()};
			
			//param = JSON.stringify(param);
			//console.log(param);
			$.ajax({
			  	url: '${pageContext.request.contextPath}/platform.action?op=SAVE',
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
