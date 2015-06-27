
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

						<div class="page-header">
							<h1>
								Create Rates
								<small>
									<i class="icon-double-angle-right"></i>
									Add, Edit and Delete Rates.
								</small>
							</h1>
						</div><!-- /.page-header -->

						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->

								<table id="grid-table_rate"></table>
								<div id="grid-pager_rate"></div>

								<!-- Dialog RateList-->
								<div id="dialog-rateList" class="hide">
									<table id="grid-table-rateList"></table>
								</div>
								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
							<div id="alertContainer" style="position: fixed; bottom:10px; right:10px; z-index:1000">
				
							</div>
						</div><!-- /.row -->
		<script type="text/javascript">	
			
			jQuery(function($) {
				var grid_selector = "#grid-table_rate";
				var pager_selector = "#grid-pager_rate";

				//var dataType = [{"id":"1","name":"Wma","description":"assasa","rateList":"","action":""}];
				
				jQuery(grid_selector).jqGrid({
					//data:dataType,
					url: "${pageContext.request.contextPath}/rateMaster.action?op=view_all",
					mtype: "POST",
					loadonce: true,
					gridview: true,
					datatype: "json",
					height: 366,
					colNames:['id','Name','Description','Printer Type', 'Rate List' ,''],
					colModel:[
						{name:'id',index:'id', width:60, sorttype:"int", editable: false, hidden:true},		
						{name:'name',index:'name', width:100, editrules:{required:true},editable: true},
						{name:'description',index:'description', width:300, sortable:false,editable:true, edittype:"textarea", editrules:{required:false, edithidden:true}},
						
						{name:'printerType',index:'printerType', sortable:false,editable: true,hidden:false, edittype:"select",editrules:{required:false, edithidden:true},editoptions:{ dataInit: function(elem) {$(elem).width(160);}, value:"1:Invision HR;2:Viper 25;3:Viper 50;4:Rubber Mould"},formatter:'select'},
						
						{name:'rateList',width:165, sortable:false,editable: false,formatter:function(){ return '<a href="action=manage_rateList">Click here</a>';}},
						
						{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false,
							formatter:'actions', 
							formatoptions:{ 
								keys:true,
								delOptions:{top:45 , url: "${pageContext.request.contextPath}/rateMaster.action?op=delete", left:((($(window).width() - 300) / 2) + $(window).scrollLeft()), recreateForm: true, closeOnEscape:true, beforeShowForm:beforeDeleteCallback},
								editformbutton:true, editOptions:{top:45, left:((($(window).width() - 600) / 2) + $(window).scrollLeft()), width:600, recreateForm: true, closeOnEscape:true, beforeShowForm:beforeEditCallback}
							}
						}
					],
					
					viewrecords : true,
					rownumbers:true,
					rowNum:10,
					rowList:[10,20,30],
					pager : pager_selector,
					altRows: true,
					
					multiselect: false,
			        multiboxonly: true,
			
					loadComplete : function() {
						var table = this;
						setTimeout(function(){
							updatePagerIcons(table);
							enableTooltips(table);
						}, 0);
						
						var ids = jQuery(grid_selector).getDataIDs();
	                    var myGridNode = jQuery(grid_selector)[0];
	                    for (var i = 0, idCount = ids.length; i < idCount; i++) {
	                        var a = $("#"+ids[i]+" a",myGridNode);
	                        a.html("Add/Edit Rates");
	                        a.each(function() {
	                        	var sHref = $( this ).attr('href');
	                        	$( this ).attr('href',"#?id="+ids[i]+"&"+sHref);
	                        });
	                        a.click(function(e) {
	                            var hash=e.currentTarget.hash;
	                            if (hash.substring(0,5) === '#?id=') {
	                                var id = hash.substring(5,hash.length);
	                                if(hash.indexOf('action=manage_rateList') > -1){
	                                	showRateList(id);
	                                }
	                            }
	                            e.preventDefault();
	                        });
	                    }  
					},
			
					editurl: "${pageContext.request.contextPath}/rateMaster.action?op=edit",//nothing is saved
					//caption: "List of areas",
					scrollOffset: 18,
					autowidth: true
				});

				jQuery(grid_selector).jqGrid('bindKeys', {"onEnter":function( rowid ) {  
					//alert("You enter a row with id: " + rowid);
                    editingRowId = rowid;
                    // we use aftersavefunc to restore focus
                    jQuery(grid_selector).find('#jEditButton_'+editingRowId).click();
                   
				} } );
				//switch element when editing inline
				function aceSwitch( cellvalue, options, cell ) {
					setTimeout(function(){
						$(cell) .find('input[type=checkbox]')
								.wrap('<label class="inline" />')
							.addClass('ace ace-switch ace-switch-5')
							.after('<span class="lbl"></span>');
					}, 0);
				}
				//enable datepicker
				function pickDate( cellvalue, options, cell ) {
					setTimeout(function(){
						$(cell) .find('input[type=text]')
								.datepicker({format:'dd-mm-yyyy' , autoclose:true}); 
					}, 0);
				}
			
				//navButtons
				jQuery(grid_selector).jqGrid('navGrid',pager_selector,
					{ 	//navbar options
						edit: false,
						edittitle: "Edit Rate",
						editicon : 'icon-pencil blue',
						add: true,
						addtext:"Add",
						addtitle: "Add Rate",
						addicon : 'icon-plus-sign purple',
						del: false,
						delicon : 'icon-trash red',
						search: true,
						searchicon : 'icon-search orange',
						refresh: true,
						refreshicon : 'icon-refresh green',
						view: false,
						viewicon : 'icon-zoom-in grey',
					},
					{
						//edit record form
						//closeAfterEdit: true,
						editCaption: "Edit Rate",
						recreateForm: true,
						closeOnEscape:true,
						closeAfterEdit:true,
						beforeShowForm : function(e) {
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />');
							style_edit_form(form);
						}
					},
					{
						//new record form
						addCaption: "Add Rate",
						
						closeAfterAdd: true,
						recreateForm: true,
						closeOnEscape:true,
						url: "${pageContext.request.contextPath}/rateMaster.action?op=add",
						top:50, left:((($(window).width() - 600) / 2) + $(window).scrollLeft()), width:600,
						viewPagerButtons: false,
						beforeShowForm : function(e) {
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" ></div>');
							style_edit_form(form);
						}
					},
					{
						//delete record form
						recreateForm: true,
						closeOnEscape:true,
						beforeShowForm : function(e) {
							var form = $(e[0]);
							if(form.data('styled')) return false;
							
							form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />');
							style_delete_form(form);
							
							form.data('styled', true);
						},
						onClick : function(e) {
							alert(1);
						}
					},
					{
						//search form
						recreateForm: true,
						afterShowSearch: function(e){
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />');
							style_search_form(form);
						},
						afterRedraw: function(){
							style_search_filters($(this));
						}
						,
						multipleSearch: true,
						closeOnEscape:true
					},
					{
						//view record form
						recreateForm: true,
						closeOnEscape:true,
						beforeShowForm: function(e){
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />');
						}
					}
				);
			
				function style_edit_form(form) {
					//enable datepicker on "sdate" field and switches for "stock" field
					form.find('input[name=sdate]').datepicker({format:'dd-mm-yyyy' , autoclose:true})
						.end().find('input[name=stock]')
							  .addClass('ace ace-switch ace-switch-5').wrap('<label class="inline" />').after('<span class="lbl"></span>');
			
					//update buttons classes
					var buttons = form.next().find('.EditButton .fm-button');
					buttons.addClass('btn btn-sm').find('[class*="-icon"]').remove();//ui-icon, s-icon
					buttons.eq(0).addClass('btn-primary').prepend('<i class="icon-ok"></i>');
					buttons.eq(1).prepend('<i class="icon-remove"></i>');
					
					buttons = form.next().find('.navButton a');
					buttons.find('.ui-icon').remove();
					buttons.eq(0).append('<i class="icon-chevron-left"></i>');
					buttons.eq(1).append('<i class="icon-chevron-right"></i>');		
				}
			
				function style_delete_form(form) {
					var buttons = form.next().find('.EditButton .fm-button');
					buttons.addClass('btn btn-sm').find('[class*="-icon"]').remove();//ui-icon, s-icon
					buttons.eq(0).addClass('btn-danger').prepend('<i class="icon-trash"></i>');
					buttons.eq(1).prepend('<i class="icon-remove"></i>');
				}
				
				function style_search_filters(form) {
					form.find('.delete-rule').val('X');
					form.find('.add-rule').addClass('btn btn-xs btn-primary');
					form.find('.add-group').addClass('btn btn-xs btn-success');
					form.find('.delete-group').addClass('btn btn-xs btn-danger');
				}
				function style_search_form(form) {
					var dialog = form.closest('.ui-jqdialog');
					var buttons = dialog.find('.EditTable');
					buttons.find('.EditButton a[id*="_reset"]').addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'icon-retweet');
					buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'icon-comment-alt');
					buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').attr('class', 'icon-search');
				}
				
				function beforeDeleteCallback(e) {
					var form = $(e[0]);
					if(form.data('styled')) return false;
					
					form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />');
					style_delete_form(form);
					
					form.data('styled', true);
				}
				
				function beforeEditCallback(e) {
					var form = $(e[0]);
					form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />');
					style_edit_form(form);
				}
				
				//replace icons with FontAwesome icons like above
				function updatePagerIcons(table) {
					var replacement = 
					{
						'ui-icon-seek-first' : 'icon-double-angle-left bigger-140',
						'ui-icon-seek-prev' : 'icon-angle-left bigger-140',
						'ui-icon-seek-next' : 'icon-angle-right bigger-140',
						'ui-icon-seek-end' : 'icon-double-angle-right bigger-140'
					};
					$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
						var icon = $(this);
						var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
						
						if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
					});
				}
			
				function enableTooltips(table) {
					$('.navtable .ui-pg-button').tooltip({container:'body'});
					$(table).find('.ui-pg-div').tooltip({container:'body'});
				}
			

				//-----> press g for setting focus on jqgrid
				$(document).bind('keydown', 'Alt+g', function(){
				    var	ids = jQuery(grid_selector).jqGrid("getDataIDs");
					if(ids && ids.length > 0){
						jQuery(grid_selector).focus();
						jQuery(grid_selector).jqGrid("setSelection", ids[0]);
					}
			    });


				//---------  RateList JQGrid------
				
				var grid_selector_rateList = "#grid-table-rateList",lastSel,
			    cancelEditing = function(myGrid) {
			        var lrid;
			        if (typeof lastSel !== "undefined") {
			            // cancel editing of the previous selected row if it was in editing state.
			            // jqGrid hold intern savedRow array inside of jqGrid object,
			            // so it is safe to call restoreRow method with any id parameter
			            // if jqGrid not in editing state
			            myGrid.jqGrid('restoreRow',lastSel);

			            // now we need to restore the icons in the formatter:"actions"
			            lrid = $.jgrid.jqID(lastSel);
			            $("tr#" + lrid + " div.ui-inline-edit, " + "tr#" + lrid + " div.ui-inline-del").show();
			            $("tr#" + lrid + " div.ui-inline-save, " + "tr#" + lrid + " div.ui-inline-cancel").hide();
			        }
			    };
				jQuery(grid_selector_rateList).jqGrid({
					mtype: "POST",
					loadonce: true,
					gridview: true,
					datatype: "json",
					colNames:['id','From (in gms)','TO (in gms)','Rate (in INR)','Action'],
					colModel:[
						{name:'id',index:'id', width:30, sorttype:"int", hidden:true, editrules:{required:false, addhidden:true}, editable: false},
						{name:'from',index:'from', width:180,editable:true, sorttype:"int"},
						{name:'to',index:'to', width:180, editable:true, sorttype:"int"},
						{name:'rate',index:'rate', width:100, sortable:false,editable: true,editoptions:{size:"20",maxlength:"130"}},
						{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false,
							formatter:'actions', 
							formatoptions:{ 
								keys:true,
								delOptions:{top:45 , url: "${pageContext.request.contextPath}/rateListMaster.action?op=delete", left:((($(window).width() - 300) / 2) + $(window).scrollLeft()), recreateForm: true, closeOnEscape:true, beforeShowForm:beforeDeleteCallback},
								onEdit: function (id) {
				                    if (typeof (lastSel) !== "undefined" && id !== lastSel) {
				                        cancelEditing(grid_selector_rateList);
				                    }
				                    lastSel = id;
				                }
							}
						}
					],
			
					viewrecords : true,
					pager : "",
					altRows: false,
					multiselect: false,
					//multikey: "ctrlKey",
			       /*  multiboxonly: true, */
			        height: 'auto',
			        loadComplete : function() {
						var table = this;
						setTimeout(function(){
							styleCheckbox(table);
							updatePagerIcons(table);
							enableTooltips(table);
						}, 0);
					},
					caption: "Rate List",
					scrollOffset: 18,
					autowidth: true,
					autoheight:true
				});

				jQuery(grid_selector_rateList).jqGrid('bindKeys', {"onEnter":function( rowid ) {  
					editingRowId = rowid;
                    jQuery(grid_selector_rateList).find('#jEditButton_'+editingRowId).click();
				} } );

				//----------------------------------------
				//----------Rate List JS ------------
				//----------------------------------------
				function showRateList(row) {
					console.log("showRateList[param]> "+row);
					
					$( "#dialog-rateList" ).removeClass('hide').dialog({
						resizable: false,
						modal: true,
						title: "",
						autoOpen: false,
						height: 400,
						width: 590,
						title_html: true,
						open: function() {
							$(".ui-dialog-title").empty().append("<div class='widget-header'><span class='ui-jqdialog-title' style='float: left;'>Manage Rate List</span> </div>");
						    $(".ui-dialog-buttonset").addClass('col-lg-12');
						    $(this).find(".ui-jqgrid-bdiv").css({'overflow-x':'hidden'});

						    var rateRowData = jQuery(grid_selector).jqGrid('getRowData',row.split('&')[0]);
						    prodMasterSelID = rateRowData.id;
						    jQuery(grid_selector_rateList).setGridParam( { datatype:"json", url:"${pageContext.request.contextPath}/rateListMaster.action?op=view&rateId="+rateRowData.id} );
						    jQuery(grid_selector_rateList).jqGrid('setCaption', "Rate List for "+rateRowData.name);

						    jQuery(grid_selector_rateList).jqGrid("clearGridData");
						    jQuery(grid_selector_rateList).trigger("reloadGrid");
						},
						buttons: [
							{
								html: "<i class='icon-plus bigger-110'></i>&nbsp; Add",
								"class" : "btn btn-primary btn-xs pull-left",
								click: function() {
						            var newId = $.jgrid.randId();
									var datarow = {id:newId,quantity:"",batchNumber:"",expDate:"",mfgDate:""};

								    jQuery(grid_selector_rateList).jqGrid('addRowData', newId , datarow, "last");
									var editparameters = {
											"keys" : true,
											"oneditfunc" : null,
											"successfunc" : null,
											"url" : "#",
										    "extraparam" : {},
											"errorfunc": null,
											"afterrestorefunc" : null,
											"restoreAfterError" : true,
											"mtype" : "POST"
										};
									jQuery(grid_selector_rateList).jqGrid('editRow',newId , editparameters );
								}
							},
							{
								html: "<i class='icon-remove bigger-110'></i>&nbsp; Cancel",
								"class" : "btn btn-xs pull-right",
								click: function() {
									$( this).dialog( "close" );
								}
							},{
								html: "<i class='icon-save bigger-110'></i>&nbsp; Save",
								"class" : "btn btn-success btn-xs pull-right",
								click: function() {
									debugger;
									var $this = $(grid_selector_rateList), rows = $(grid_selector_rateList).jqGrid('getRowData'), l = rows.length, i, row;
								    for (i = 0; i < l; i++) {
								        row = rows[i];
								        $this.saveRow(row.id, true, 'clientArray');
								    }
									
									var passedGrid = $(grid_selector_rateList);
									var selData = passedGrid.jqGrid('getRowData');
									
									var param ={'rateList':JSON.stringify(selData),'rateId':prodMasterSelID};
									
									console.log(param);
									$.ajax({
									  	url: '${pageContext.request.contextPath}/rateListMaster.action?op=save',
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
							}
							
						]
					});
					
					$.extend($.jgrid.edit, {
					    beforeSubmit: function () {
					        $(this).jqGrid("setGridParam", {datatype: "json"});
					        jQuery(grid_selector).jqGrid("setGridParam", {datatype: "json"});
					        return [true,"",""];
					    }
					});
					
					$( "#dialog-rateList" ).dialog("open");
				}
				
				$.extend($.jgrid.edit, {
				    beforeSubmit: function () {
				        $(this).jqGrid("setGridParam", {datatype: "json"});
				        return [true,"",""];
				    }
				});
			});
				
		</script>
