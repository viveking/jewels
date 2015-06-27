
<%@page import="com.affixus.util.MongoAttributeList"%>
<%@page import="com.affixus.util.Constants"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

						<div class="page-header">
							<h1>
								Create User
								<small>
									<i class="icon-double-angle-right"></i>
									Add, Edit and Delete User.
								</small>
							</h1>
						</div><!-- /.page-header -->

						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->

								<table id="grid-table_user"></table>
								<div id="grid-pager_user"></div>

								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
		
	<script type="text/javascript">
			
			
			jQuery(function($) {
				var grid_selector = "#grid-table_user";
				var pager_selector = "#grid-pager_user";

				var PT_inversionHrData = <%= MongoAttributeList.getRateListByPrinter("1")%>;
				var PT_viber25 = <%= MongoAttributeList.getRateListByPrinter("2")%>;
				var PT_viber50 = <%= MongoAttributeList.getRateListByPrinter("3")%>;
				var PT_rubberMould = <%= MongoAttributeList.getRateListByPrinter("4")%>;
				
				jQuery(grid_selector).jqGrid({
					url: "${pageContext.request.contextPath}/usermaster.action?op=view_all",
					mtype: "POST",
					loadonce: true,
					gridview: true,
					datatype: "json",
					height: 366,
					colNames:['id','Username','Email','Password', 'Mobile', 'Role','Address',' '],
					colModel:[
						{name:'id',index:'id', width:60, sorttype:"int", editable: false, hidden:true},
						{name:'username',index:'username', width:250, editrules:{required:true},editable: true},
						{name:'email',index:'email', width:250, editrules:{required:true},editable: true},
						{name:'password',index:'password', width:150,editable: true, hidden:true,"formatter":"password","edittype":"password", editrules:{required:true, edithidden:true},editoptions:{size:"20",maxlength:"30"}},
						{name:'mobile',index:'mobile', width:150,editable: true,editoptions:{size:"20",maxlength:"30"}},
						{name:'role',index:'role',sortable:false,editable: true, edittype:"select", editrules:{required:true, edithidden:true},editoptions:{ dataInit: function(elem) {$(elem).width(160);}, value:"Invoice:Invoice;DC:DC"},formatter:'select'},
						{name:'address',index:'address', sortable:false,editable:true, edittype:"textarea", hidden:true, editrules:{required:false, edithidden:true},editoptions:{rows:"2",cols:"20"}},
						{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false,
							formatter:'actions', 
							formatoptions:{ 
								keys:true,
								delOptions:{top:45 , url: "${pageContext.request.contextPath}/usermaster.action?op=delete", left:((($(window).width() - 300) / 2) + $(window).scrollLeft()), recreateForm: true, closeOnEscape:true, beforeShowForm:beforeDeleteCallback},
								editformbutton:true, editOptions:{top:45, left:((($(window).width() - 600) / 2) + $(window).scrollLeft()), recreateForm: true, closeOnEscape:true, beforeShowForm:beforeEditCallback}
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
					
					editurl: "${pageContext.request.contextPath}/usermaster.action?op=edit",//nothing is saved
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
						edittitle: "Edit User",
						editicon : 'icon-pencil blue',
						add: true,
						addtext:"Add",
						addtitle: "Add User",
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
						editCaption: "Edit User",
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
						addCaption: "Add User",
						closeAfterAdd: true,
						recreateForm: true,
						closeOnEscape:true,
						url: "${pageContext.request.contextPath}/usermaster.action?op=add",
						top:50, left:((($(window).width() - 600) / 2) + $(window).scrollLeft()), width:400,
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
