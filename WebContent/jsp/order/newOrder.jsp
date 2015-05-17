
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="page-header">
	<h1>
		New Order
		<small>
			<i class="icon-double-angle-right"></i>
			Upload CAM Order.
		</small>
	</h1>
</div><!-- /.page-header -->

<div class="form-group">

	<div class="row">
		<div class="col-xs-4">
		
			<label for="form-field-select-1">Select Printer</label>
			
			<select class="form-control" id="form-field-select-1">
				<option value="INVISIONHR">INVISIONHR</option>
				<option value="VIPER25">VIPER25</option>
				<option value="VIPER50">VIPER50</option>
				<option value="ZNone">ZNone</option>
			</select>
		</div>
		<div class="col-xs-4">
		
			<label for="id-date-picker-1">Order Date</label>
					
			<div class="input-group">
				<input class="form-control date-picker" id="id-date-picker-1" type="text" data-date-format="dd-mm-yyyy" />
				<span class="input-group-addon">
					<i class="icon-calendar bigger-110"></i>
				</span>
			</div>
		</div>
		
		<div class="col-xs-4">
		
			<label for="id-date-picker-1">Upload File</label>
					
			<input type="file" id="id-orderFile" />
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-offset-1 col-xs-10">
			<!-- PAGE CONTENT BEGINS -->

			<table id="passed-grid-table"></table>
			<button class="btn btn-md btn-success">
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
		
		$('#id-orderFile').ace_file_input({
			no_file:'No File ...',
			btn_choose:'Choose',
			btn_change:'Change',
			droppable:false,
			onchange:null,
			thumbnail:false //| true | large
			//whitelist:'gif|png|jpg|jpeg'
			//blacklist:'exe|php'
			//onchange:''
			//
		});
		
		function readSingleFile(evt) {
		    //Retrieve the first (and only!) File from the FileList object
		    var f = evt.target.files[0]; 

		    if (f) {
		      var r = new FileReader();
		      r.onload = function(e) { 
			      var contents = e.target.result;
			      var arrFiles = contents.split("\r\n");
		          var lenArrFiles = arrFiles.length;
		          var arrGridData = [],arrFailedData = [];
		          for(var i=0;i<lenArrFiles;i++){
		        	  var arrPathSplit = arrFiles[i].split("\\");
		        	  var jsonObj = {};
		        	  var lenPathSplit = arrPathSplit.length;
		        	  if(arrPathSplit[lenPathSplit - 1].endsWith(".stl;")){
			        	  jsonObj.fileName = arrPathSplit[lenPathSplit - 1];
			        	  jsonObj.clientOrderName = arrPathSplit[lenPathSplit - 2];
			        	  jsonObj.clientName = arrPathSplit[lenPathSplit - 3];
			        	  if(clientNameJson.hasOwnProperty(arrPathSplit[lenPathSplit - 3])){
			        		  jsonObj.status = "PASS";
			        		  arrGridData.push(jsonObj);
			        	  }else{
			        		  jsonObj.status = "FAIL";
			        		  arrFailedData.push(jsonObj);
			        	  }
			        	 		        		  
		        	  }
		          }
		          
		          $('#passed-grid-table').jqGrid('setGridParam', {data: arrGridData}).trigger('reloadGrid');

		          $('#failed-grid-table').jqGrid('setGridParam', {data: arrFailedData}).trigger('reloadGrid');
		      }
		      r.readAsText(f);
		    } else { 
		      alert("Failed to load file");
		    }
		  }

		  document.getElementById('id-orderFile').addEventListener('change', readSingleFile, false);

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

	
	});
</script>

<!-- page specific plugin scripts -->

<script src="assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="assets/js/jqGrid/jquery.jqGrid.min.js"></script>
<script src="assets/js/jqGrid/i18n/grid.locale-en.js"></script>

