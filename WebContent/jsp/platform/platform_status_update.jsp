
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap-datetimepicker.css" />

<style>
	.FormGrid .EditTable tr:first-child {display: table-row !important;}
</style>
	<div class="page-header">
		<h1>
			Platform Status Update
			<small>
				<i class="icon-double-angle-right"></i>
				Update the status of the platform.
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="form-group">
		<div class="row">

			<div class="col-xs-4">
				<label>Select Platform</label>
				<select class="width-80 chosen-select" id="idSelectPlatform" data-placeholder="Choose Platform">
				</select>
			</div>
			
			<div id="alertContainer" style="position: fixed; bottom:10px; right:10px; z-index:1000">
			</div>

		</div>
	</div>
	<div class="space-4"></div>
	<div class="row">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->

			<table id="grid-table-platform"></table>
			<!-- <div id="grid-pager-platform"></div> -->
			
			<!-- PAGE CONTENT ENDS -->
		</div><!-- /.col -->
	</div><!-- /.row -->
	
		<div class="form-group row">
			<div class="col-md-5">
				<label class="col-sm-3 control-label " for="form-field-1"> Select Status </label>
				<select class="col-md-6 chosen-select" id="idStatus" data-placeholder="Choose Status">
					<option value="COMPLETED">COMPLETED</option>
					<option value="FAILED">FAILED</option>
				</select>
			</div>
			<div class="col-md-1">
				<button class="btn btn-md btn-success" id="idSaveParts">
				<i class="icon-ok"></i>
				Save
				</button>
			</div>
		</div>

	<div id="alertContainer" style="position: fixed; bottom:10px; right:10px; z-index:1000">		
	</div>
	
	<script type="text/javascript">
			
			jQuery(function($) {
				$(".chosen-select").chosen();

				var platformList = {};

				$.ajax({
				  	url: '${pageContext.request.contextPath}/platform.action?op=ALL_PLATFORM_ID&status=INPROGRESS',
				  	type: 'GET',
				  	async: false
				  })
				  .done(function(data) {
				  	console.log("success "+data);
				  	platformList = JSON.parse(data);
				  	//setTimeout(function(){
				  		//alert("Called Timeout");
					  	$.each(platformList ,function(ind,val){
					  		$("#idSelectPlatform").append("<option value="+val+">"+val+"<option>");
					  	});
					  	$('.chosen-select').chosen().trigger("chosen:updated");
				  	//}, 3000);
				  })
				  .fail(function() {
				  	console.log("error");
				  })
				  .always(function() {
				  	console.log("complete");
				  });
				
				$("#idSelectPlatform").on("change",function(){
					$(grid_selector).jqGrid("clearGridData");
						var param = {"sBy":"platform","value":$("#idSelectPlatform").val()};
						  $.ajax({
							  	url: '${pageContext.request.contextPath}/order.action?op=VIEW_PENDING_PARTS',
							  	type: 'POST',
							  	data: param
							  })
							  .done(function(dat) {
							  	
							  	if(dat!=""){
						  			dat = JSON.parse(dat);
							  	}
							  	
					  			$(grid_selector).jqGrid('setGridParam', {data: dat }).trigger('reloadGrid');
							    
							  })
							  .fail(function() {
							  	console.log("error");
							  })
							  .always(function() {
							  	console.log("complete");
							  });
				});
				
				
				var grid_selector = "#grid-table-platform";
				//var pager_selector = "#grid-pager-platform";
				var grid_data = [];	
				
				jQuery(grid_selector).jqGrid({
					data: grid_data,
					datatype: "local",
					mtype: "POST",
					loadonce: true,
					gridview: true,
					height: 366,
					colNames:['id','Client Id','Order Name','Part Name', 'Weight(KG)', 'Prepared By','Order Date','Part Status','',''],
					colModel:[
						{name:'id',index:'id', width:60, sorttype:"int", editable: false, hidden:true},
						{name:'client.clientId',index:'client.clientId', width:100,editable: false},
						{name:'orderName',index:'orderName', width:100,editable: false},
						{name:'partList.name',index:'partList.name', width:100,editable: false},
						{name:'partList.weight',index:'partList.weight', width:100,editable: false},
						{name:'preparedBy',index:'preparedBy', width:100,editable: false},
						{name:'orderDateStr',index:'orderDateStr', width:100,editable: false},
						{name:'partList.status',index:'partList.status', width:100,editable: false},
						{name:'partList.refWeight',index:'partList.refWeight', width:100,editable: false, hidden:true},
						{name:'partList.platformNumber',index:'partList.platformNumber', width:100,editable: false, hidden:true}
					], 
			
					viewrecords : true,
					rownumbers:true,
					rowNum:1000,
					altRows: true,
					
					multiselect: true,
			        multiboxonly: true,
			
					loadComplete : function() {
						
					},
					
					editurl: "${pageContext.request.contextPath}/platform.action?op=edit",//nothing is saved
					//caption: "List of areas",
					scrollOffset: 18,
					autowidth: true
				});


				$('#idSaveParts').click(function(){
					var passedGrid = $(grid_selector);
					var selRows = passedGrid.jqGrid('getGridParam','selarrrow');
					
					var selData=[];
					$.each(selRows,function(inx,val){
						selData.push(passedGrid.getRowData(val));
					});
					
					var param ={'order':JSON.stringify(selData),'status':$('#idStatus').val()};
					
					$.ajax({
					  	url: '${pageContext.request.contextPath}/platform.action?op=SAVE_STATUS_UPDATE',
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

				
				$.extend($.jgrid.edit, {
				    beforeSubmit: function () {
				        $(this).jqGrid("setGridParam", {datatype: "json"});
				        return [true,"",""];
				    }
				});
			});
				
		</script>
