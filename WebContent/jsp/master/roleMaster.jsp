
<%@page import="com.affixus.util.MongoAttributeList"%>
<%@page import="com.affixus.util.Constants"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

						<div class="page-header">
							<h1>
								Create Role
								<small>
									<i class="icon-double-angle-right"></i>
									Add, Edit and Delete Role.
								</small>
							</h1>
						</div><!-- /.page-header -->

						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->

								<table id="grid-table_role"></table>
								<div id="grid-pager_role"></div>

								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
		
	<script type="text/javascript">
			
			
			jQuery(function($) {
				var grid_selector = "#grid-table_role";
				var pager_selector = "#grid-pager_role";

				jQuery(grid_selector).jqGrid({
					url: "${pageContext.request.contextPath}/rolemaster.action?op=view_all",
					mtype: "POST",
					loadonce: true,
					gridview: true,
					datatype: "json",
					height: 366,
					colNames:['id','Role Name','Client','Rates','User','Role','New Order','Order Generatation','Incomplete Order','Platform Output Calculation','Completed Order Update','Generate Invoice','Print Invoice','Generate DC','Print DC','Platform Status Report',' '],
					colModel:[
						{name:'id',index:'id', width:60, sorttype:"int", editable: false, hidden:true},
						{name:'name',index:'name', width:250, editrules:{required:true},editable: true},
						{name: "clientMaster", width: 70, align: "center",editable: true, formatter: "checkbox", formatoptions: { disabled: true},edittype: "checkbox", editoptions: {value: "true:false"}, stype: "select", searchoptions: { value: ":Any;true:Yes;false:No" } },
						{name: "rateMaster", width: 70, align: "center",editable: true,formoptions:{rowpos:2, colpos:2}, formatter: "checkbox", formatoptions: { disabled: true},edittype: "checkbox", editoptions: {value: "true:false"}, stype: "select", searchoptions: { value: ":Any;true:Yes;false:No" } },
						{name: "userMaster", width: 70, align: "center",editable: true, formatter: "checkbox", formatoptions: { disabled: true},edittype: "checkbox", editoptions: {value: "true:false"}, stype: "select", searchoptions: { value: ":Any;true:Yes;false:No" } },
						{name: "roleMaster", width: 70, align: "center",editable: true,formoptions:{rowpos:4, colpos:2}, formatter: "checkbox", formatoptions: { disabled: true},edittype: "checkbox", editoptions: {value: "true:false"}, stype: "select", searchoptions: { value: ":Any;true:Yes;false:No" } },
						{name: "newOrder", width: 70, align: "center",editable: true, formatter: "checkbox", formatoptions: { disabled: true},edittype: "checkbox", editoptions: {value: "true:false"}, stype: "select", searchoptions: { value: ":Any;true:Yes;false:No" } },
						{name: "generateOrder", width: 70, align: "center",editable: true, formoptions:{rowpos:6, colpos:2},formatter: "checkbox", formatoptions: { disabled: true},edittype: "checkbox", editoptions: {value: "true:false"}, stype: "select", searchoptions: { value: ":Any;true:Yes;false:No" } },
						{name: "incompleteOrder", width: 70, align: "center",editable: true, formatter: "checkbox", formatoptions: { disabled: true},edittype: "checkbox", editoptions: {value: "true:false"}, stype: "select", searchoptions: { value: ":Any;true:Yes;false:No" } },
						{name: "platformOptCalc", width: 70, align: "center",editable: true, formoptions:{rowpos:8, colpos:2},formatter: "checkbox", formatoptions: { disabled: true},edittype: "checkbox", editoptions: {value: "true:false"}, stype: "select", searchoptions: { value: ":Any;true:Yes;false:No" } },
						{name: "orderUpdate", width: 70, align: "center",editable: true, formatter: "checkbox", formatoptions: { disabled: true},edittype: "checkbox", editoptions: {value: "true:false"}, stype: "select", searchoptions: { value: ":Any;true:Yes;false:No" } },
						{name: "generateInvoice", width: 70, align: "center",editable: true, formoptions:{rowpos:10, colpos:2},formatter: "checkbox", formatoptions: { disabled: true},edittype: "checkbox", editoptions: {value: "true:false"}, stype: "select", searchoptions: { value: ":Any;true:Yes;false:No" } },
						{name: "printInvoice", width: 70, align: "center",editable: true, formatter: "checkbox", formatoptions: { disabled: true},edittype: "checkbox", editoptions: {value: "true:false"}, stype: "select", searchoptions: { value: ":Any;true:Yes;false:No" } },
						{name: "generateDC", width: 70, align: "center",editable: true, formoptions:{rowpos:12, colpos:2},formatter: "checkbox", formatoptions: { disabled: true},edittype: "checkbox", editoptions: {value: "true:false"}, stype: "select", searchoptions: { value: ":Any;true:Yes;false:No" } },
						{name: "printDC", width: 70, align: "center",editable: true, formatter: "checkbox", formatoptions: { disabled: true},edittype: "checkbox", editoptions: {value: "true:false"}, stype: "select", searchoptions: { value: ":Any;true:Yes;false:No" } },
						{name: "platformStatusReport", width: 70, align: "center",editable: true, formoptions:{rowpos:14, colpos:2},formatter: "checkbox", formatoptions: { disabled: true},edittype: "checkbox", editoptions: {value: "true:false"}, stype: "select", searchoptions: { value: ":Any;true:Yes;false:No" } },
						{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false,
							formatter:'actions', 
							formatoptions:{ 
								keys:true,
								delOptions:{top:45 , url: "${pageContext.request.contextPath}/rolemaster.action?op=delete", left:((($(window).width() - 300) / 2) + $(window).scrollLeft()), recreateForm: true, closeOnEscape:true, beforeShowForm:beforeDeleteCallback},
								editformbutton:true, editOptions:{top:45, left:((($(window).width() - 600) / 2) + $(window).scrollLeft()), recreateForm: true,width:600, closeOnEscape:true, beforeShowForm:beforeEditCallback}
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
						
						
					},
					
					editurl: "${pageContext.request.contextPath}/rolemaster.action?op=edit",//nothing is saved
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
						edittitle: "Edit Role",
						editicon : 'icon-pencil blue',
						add: true,
						addtext:"Add",
						addtitle: "Add Role",
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
						editCaption: "Edit Role",
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
						addCaption: "Add Role",
						closeAfterAdd: true,
						recreateForm: true,
						closeOnEscape:true,
						url: "${pageContext.request.contextPath}/rolemaster.action?op=add",
						top:50, left:((($(window).width() - 600) / 2) + $(window).scrollLeft()), width:500,
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

				$.extend($.jgrid.edit, {
				    beforeSubmit: function () {
				        $(this).jqGrid("setGridParam", {datatype: "json"});
				        return [true,"",""];
				    }
				});
			});
				
		</script>
