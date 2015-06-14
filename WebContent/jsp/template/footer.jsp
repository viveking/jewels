
		<script src="${pageContext.request.contextPath}/custom/js/munsi.js"></script>
		

		<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/typeahead-bs2.min.js"></script>

		<!-- page specific plugin scripts -->

		<!--[if lte IE 8]>
		  <script src="${pageContext.request.contextPath}/assets/js/excanvas.min.js"></script>
		<![endif]-->
		<script src="${pageContext.request.contextPath}/assets/js/jquery-ui-1.10.4.custom.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/jquery.ui.touch-punch.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/jquery.slimscroll.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/jquery.easy-pie-chart.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/jquery.sparkline.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/flot/jquery.flot.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/flot/jquery.flot.pie.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/flot/jquery.flot.resize.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/date-time/bootstrap-datepicker.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/bootbox.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/jqGrid/jquery.jqGrid.js"></script>
		<%-- <script src="${pageContext.request.contextPath}/assets/js/jqGrid/jquery.jqGrid.min.js"></script> --%>
		<script src="${pageContext.request.contextPath}/assets/js/jqGrid/i18n/grid.locale-en.js"></script>
		<!-- ace scripts -->

		<script src="${pageContext.request.contextPath}/assets/js/ace-elements.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/ace.min.js"></script>
		<!-- JS for Charts -->
		<script src="${pageContext.request.contextPath}/assets/js/amcharts/amcharts.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/assets/js/amcharts/serial.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/assets/js/amcharts/pie.js" type="text/javascript"></script>
		
		<script src="${pageContext.request.contextPath}/assets/js/amcharts/exporting/amexport.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/assets/js/amcharts/exporting/rgbcolor.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/assets/js/amcharts/exporting/canvg.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/assets/js/amcharts/exporting/jspdf.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/assets/js/amcharts/exporting/filesaver.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/assets/js/amcharts/exporting/jspdf.plugin.addimage.js" type="text/javascript"></script>
		
		
		<script type="text/javascript">
			$(document).ready(function(){
			   /*  $(document).bind("contextmenu",function(e){
			        return false;
			    }); */
			    
			    $(".ace-nav>li").click(function(){$(".ace-nav>li").toggleClass( "open" );});
			});
			
			//----------Reporting Dialogs-------------
			
			function showSalesReportDialog() {
				console.log("showReport>> ");
				
				$( "#dialog-report" ).removeClass('hide').dialog({
					resizable: false,
					modal: true,
					title: "",
					autoOpen: false,
					height: 300,
					width: 390,
					title_html: true,
					open: function() {
						$(".ui-dialog-title").empty().append("<div class='widget-header'><span class='ui-jqdialog-title' style='float: left;'>Sales Report</span> </div>");
					    $(".ui-dialog-buttonset").addClass('col-lg-12');
					    $(this).find(".ui-jqgrid-bdiv").css({'overflow-x':'hidden'});
					 

					    $("#dialog-report").load("${pageContext.request.contextPath}/jsp/report/calanderForm.jsp");
					},
					buttons: [
						{
							html: "<i class='icon-download bigger-110'></i>&nbsp; PDF",
							"class" : "btn btn-primary btn-xs pull-left",
							click: function() {
								ajaxReport("SALES","pdf");
							}
						},
						{
							html: "<i class='icon-download bigger-110'></i>&nbsp; Excel",
							"class" : "btn btn-warning btn-xs pull-left",
							click: function() {
								ajaxReport("SALES","xls");
							}
						},
						{
							html: "<i class='icon-remove bigger-110'></i>&nbsp; Cancel",
							"class" : "btn btn-xs pull-right",
							click: function() {
								$( this).dialog( "close" );
							}
						}
						
					]
				});
				
				$( "#dialog-report" ).dialog("open");
			}
			function showPurchaseReportDialog() {
				console.log("PurchaseReport>> ");
				
				$( "#dialog-report" ).removeClass('hide').dialog({
					resizable: false,
					modal: true,
					title: "",
					autoOpen: false,
					height: 300,
					width: 390,
					title_html: true,
					open: function() {
						$(".ui-dialog-title").empty().append("<div class='widget-header'><span class='ui-jqdialog-title' style='float: left;'>Purchase Report</span> </div>");
					    $(".ui-dialog-buttonset").addClass('col-lg-12');
					    $(this).find(".ui-jqgrid-bdiv").css({'overflow-x':'hidden'});
					    $("#dialog-report").load("${pageContext.request.contextPath}/jsp/report/calanderForm.jsp");
					},
					buttons: [
						{
							html: "<i class='icon-download bigger-110'></i>&nbsp; PDF",
							"class" : "btn btn-primary btn-xs pull-left",
							click: function() {
								ajaxReport("PURCHASE","pdf");			
							}
						},
						{
							html: "<i class='icon-download bigger-110'></i>&nbsp; Excel",
							"class" : "btn btn-warning btn-xs pull-left",
							click: function() {
								ajaxReport("PURCHASE","xls");
							}
						},
						{
							html: "<i class='icon-remove bigger-110'></i>&nbsp; Cancel",
							"class" : "btn btn-xs pull-right",
							click: function() {
								$( this).dialog( "close" );
							}
						}
						
					]
				});
				
				$( "#dialog-report" ).dialog("open");
			}
			
			function ajaxReport(reportName,fileType){
				/* $.ajax({
					type: "POST",
					url: "report.action?op=REPORT_DATE",
					data: {fStartDateRep:$("#idStartDateRep").val(),fEndDateRep:$("#idEndDateRep").val(),reportName:reportName,fileType:fileType},
					dataType: 'html'
					})
					.done(function( data ) {
					})
					.fail(function() {
						console.error( "error in fetching data from server....." );
					}); */
				window.location="report.action?op=REPORT_DATE&fStartDateRep="+$("#idStartDateRep").val()+"&fEndDateRep="+$("#idEndDateRep").val()+"&reportName="+reportName+"&fileType="+fileType;
				$("#idMsgDiv").html('<div class="alert alert-block alert-success"><button type="button" class="close" data-dismiss="alert"><i class="icon-remove"></i></button><i class="icon-ok green"></i>Downloaded Successfully.</div>');
			}
		</script>
		
		
</body>
</html>