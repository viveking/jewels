<%@page import="com.affixus.util.Config"%>
<%@page import="com.affixus.util.MongoAttributeList"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	pageContext.setAttribute("platformNumber", MongoAttributeList.getPlatformDBNextSequence(),PageContext.PAGE_SCOPE);
	pageContext.setAttribute("printerList", Config.printerNames, PageContext.PAGE_SCOPE);
	
%>
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
		
		<div class="col-xs-2">
			<label for="plateformNumber">Platform Number</label>
			<input type="text" id="plateformNumber" value=${platformNumber} readonly="readonly"/>
		</div>
		<div class="col-xs-3">
		
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

		
		<div class="col-xs-3">
		
			<label for="idPrinterSelect">Select Printer</label>
			
			<select class="form-control" id="idPrinterSelect">
				<c:forEach var="entry" items="${printerList}">
					<option value=<c:out value="${entry.key}"/>><c:out value="${entry.value}"/></option>
				</c:forEach>
			</select>
		</div>
		
		<div class="col-xs-3">
		
			<label for="idOutputCalculation">Upload File</label>
					
			<input type="file" id="idOutputCalculation" />
		</div>
	</div>
	
	<div class="row" id="gridContainer">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->

			<table id="grid-table"></table>
			<button style="margin:10px 0 0 0;" class="btn btn-md btn-success" id="idSaveOrder">
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
		
        $('input[name=date-range-picker]').daterangepicker({
        	format: 'DD-MM-YYYY',
        	separator: ' to '
        	}).prev().on(ace.click_event, function(){
			$(this).next().focus();
		});
        
        $(".chosen-select").chosen();
        		
		
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
		        		  jsonObj.partWeight = Number(arrEachPart[5].split(":")[1].trim())*1000;
		        		  jsonObj.supportWeight = Number(arrEachPart[6].split(":")[1].trim())*1000;
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
			height: "auto",
			colNames:['Client ID','Platform','Part','Weight (Grams)','Status'],
			colModel:[
				{name:'client',index:'client', width:150,editable: false},
				{name:'platform',index:'platform', width:150, editable: false},
				{name:'part',index:'part', width:300, editable: false},
				{name:'partWeight',index:'partWeight',formatter:'number',formatoptions:{decimalPlaces: 2}, width:200, editable: true, classes: 'editCls'},
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
		
		function isRightPlatformFileLoaded(dataArr){
			var flag = true;
			var platformNumber = $("#plateformNumber").val();
			for(var i=0;i<dataArr.length;i++){
				if(platformNumber !== dataArr[i].platform){
					flag=false;
					break;
				}
			}
			
			return flag;
		}
		$('#idSaveOrder').click(function(){
			
			
			
			var passedGrid = $("#grid-table");
			var selData = passedGrid.jqGrid('getGridParam','data');
			
			if(isRightPlatformFileLoaded(selData)){
				
				var dateRange = $('#idFromToDate').val();
				var date = dateRange.split(" to ");
				
				if(date[1] !== undefined) {
						var param ={
							'order':JSON.stringify(selData),
							'printer':$('#idPrinterSelect').val(),
							'orderFromDateStr':date[0] || "",
							'orderToDateStr':date[1] || "",
							'platformNumber':$("#plateformNumber").val()
						};
						
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
					}
					else {	
						alert("Please select valid date.");
					}
				} else {
				alert("Platform file loaded is not matched with platform number");				
			}
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
