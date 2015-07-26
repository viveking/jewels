<%@page import="com.affixus.util.Config"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	pageContext.setAttribute("printerList", Config.printerNames, PageContext.PAGE_SCOPE);
%>
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
				<c:forEach var="entry" items="${printerList}">
					<option value=<c:out value="${entry.key}"/>><c:out value="${entry.value}"/></option>
				</c:forEach>
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
	
	<div class="col-md-offset-1 row" id="SuccessContainer">
		<h1><span class="success">Saved Successfully...</span></h1>
		<p class="lead"> You can proceed to <a id="navigateOG" class="btn btn-xs btn-success" href="#">
												<i class="icon-bolt bigger-110"></i>
												Order Generation
												<i class="icon-arrow-right icon-on-right"></i>
											</a>. </p>
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
		        	  debugger;
		        	  if(arrPathSplit[lenPathSplit - 1].indexOf(".stl;") !== -1 ){
			        	  jsonObj.fileName = arrPathSplit[lenPathSplit - 1].replace(/;/g,'');
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
		          
		          $('#noGridContainer').hide();
		          $('#gridContainer').show();
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
			rowNum:100000,
			//rowList:[10,20,30],
			altRows: true,
			rownumbers: true,  
			multiselect: true,
	        //multiboxonly: true,
			
			caption: "Passed Order Details",
	
			autowidth: true	
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
			rowNum:100000,
			altRows: true,
			rownumbers: true,  
			caption: "Failed Order Details",
			autowidth: true
		});
		
		$('#idSaveOrder').click(function(){
			var passedGrid = $("#passed-grid-table");
			var selRows = passedGrid.jqGrid('getGridParam','selarrrow');
			
			var selData=[];
			$.each(selRows,function(inx,val){
				selData.push(passedGrid.getRowData(val));
			});
			
			var param ={'order':JSON.stringify(selData),'printer':$('#form-field-select-1').val(),'date':$('#id-date-picker-1').val()};
			
			//param = JSON.stringify(param);
			//console.log(param);
			$.ajax({
			  	url: '${pageContext.request.contextPath}/order.action?op=ADD',
			  	type: 'POST',
			  	data: param
			  })
			  .done(function(data) {
			  	console.log("success "+data);
				//Showing Success.....

		        $('#noGridContainer').hide();
		        $('#gridContainer').hide();
		        $('#SuccessContainer').show();
		        $('#navigateOG').addClass("animated tada");
		        			  	
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
        $('#SuccessContainer').hide();
        
	});
	
</script>

<!-- page specific plugin scripts -->

<script src="assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="assets/js/jqGrid/jquery.jqGrid.min.js"></script>
<script src="assets/js/jqGrid/i18n/grid.locale-en.js"></script>

