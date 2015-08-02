
<%@page import="com.affixus.util.MongoAttributeList"%>
<%@page import="com.affixus.util.Constants"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


						<div class="page-header">
							<h1>
								Create Client
								<small>
									<i class="icon-double-angle-right"></i>
									Add, Edit and Delete client details.
								</small>
							</h1>
						</div><!-- /.page-header -->

						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->

								<table id="grid-table_area"></table>
								<div id="grid-pager_area"></div>

								<!-- Dialog Scheme -->
								<div id="dialog-beat" class="hide">
									<table id="grid-table-beat"></table>

								</div>	
								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
		
	<script type="text/javascript">
			
			jQuery(function($) {
				var grid_selector = "#grid-table_area";
				var pager_selector = "#grid-pager_area";
				
				
				var PT_inversionHrData = <%= MongoAttributeList.getRateListByPrinter("invisionHR")%>;
				var PT_viber25 = <%= MongoAttributeList.getRateListByPrinter("viper25")%>;
				var PT_viber50 = <%= MongoAttributeList.getRateListByPrinter("viper50")%>;
				//var PT_ZNone = <%= MongoAttributeList.getRateListByPrinter("zNONE")%>;
				var PT_rubberMould = <%= MongoAttributeList.getRateListByPrinter("rubberMOULD")%>;
				
				var invType = {"0":"Select Inv. Type","1":"CST Invoice","2":"Estimate Sales","3":"Tax Invoice"};
				var percent = {"CST0%":"CST @ 0%","CST1%":"CST @ 1%","CST2%":"CST @ 2%","CST4%":"CST @ 4%","ES0%":"Estimate Sales @ 0%","ES1%":"Estimate Sales @ 1%","TI0%":"Tax Invoice @ 0%","TI1%":"Tax Invoice @ 1%","TI12.5%":"Tax Invoice @ 12.5%"};
				var cstPercent = {"CST0%":"CST @ 0%","CST1%":"CST @ 1%","CST2%":"CST @ 2%","CST4%":"CST @ 4%"};
				var estSalesPercent = {"ES0%":"Estimate Sales @ 0%","ES1%":"Estimate Sales @ 1%"};
				var tiPercent = {"TI0%":"Tax Invoice @ 0%","TI1%":"Tax Invoice @ 1%","TI12.5%":"Tax Invoice @ 12.5%"};
				
				var invTypePercent = {"0":{},"1":cstPercent,"2":estSalesPercent,"3":tiPercent};
				
				var resetPercentValues = function () {
                    // set 'value' property of the editoptions to initial state
                    jQuery(grid_selector).jqGrid('setColProp', 'invoicePercentage', { editoptions: { value: percent} });
                };

				jQuery(grid_selector).jqGrid({
					url: "${pageContext.request.contextPath}/clientmaster.action?op=view_all",
					mtype: "POST",
					loadonce: true,
					gridview: true,
					datatype: "json",
					height: 366,
					colNames:['id','ClientId','Name','Address', 'City', 'Limit','Credit Period','VAT','CST','PAN',
					          'Mobile 1','Mobile 2','Email 1','Email 2','Voucher Type','Invoice Type',
					          'Invoice Percentage','Invision HR','Rubber Mould','Viper 25','Viper 50',
					          'Auto Approval','Send Invoice SMS','Active',' '],
					colModel:[
						{name:'id',index:'id', width:60, sorttype:"int", editable: false, hidden:true},
						{name:'clientId',index:'clientId', width:250, editrules:{required:true},editable: true},
						{name:'name',index:'name', width:250, editrules:{required:true},editable: true, formoptions:{rowpos:1, colpos:2}},
						{name:'address',index:'address', sortable:false,editable:true, edittype:"textarea", hidden:true, editrules:{required:false, edithidden:true},editoptions:{rows:"2",cols:"20"}},
						{name:'city',index:'city', width:150,editable: true,editoptions:{size:"20",maxlength:"30"}},
						{name:'creditPeriod',index:'creditPeriod',editable: true, hidden:true, editrules:{required:false, edithidden:true},editoptions:{size:"20",maxlength:"30"}},
						{name:'limit',index:'limit', width:150,editable: true,formoptions:{rowpos:4, colpos:2},editoptions:{size:"20",maxlength:"30"}},
						{name:'vatNo',index:'vatNo', sortable:false,editable: true,editoptions:{size:"20",maxlength:"30"}},
						{name:'cstNo',index:'cstNo', sortable:false,editable: true,editoptions:{size:"20",maxlength:"30"}},
						{name:'panNo',index:'panNo', sortable:false,editable: true,editoptions:{size:"20",maxlength:"30"}},
						{name:'mobileNo1',index:'mobileNo1', sortable:false,editable: true,hidden:true, editrules:{required:false, edithidden:true},editoptions:{size:"20",maxlength:"30"}},
						{name:'mobileNo2',index:'mobileNo2', sortable:false,editable: true,hidden:true, formoptions:{rowpos:10, colpos:2}, editrules:{required:false, edithidden:true},editoptions:{size:"20",maxlength:"30"}},						
						{name:'email1',index:'email1', sortable:false,editable: true,hidden:true, editrules:{required:false, edithidden:true},editoptions:{size:"20",maxlength:"30"}},
						{name:'email2',index:'email2', sortable:false,editable: true,hidden:true, formoptions:{rowpos:12, colpos:2},editrules:{required:false, edithidden:true},editoptions:{size:"20",maxlength:"30"}},
						{name:'voucherType',index:'voucherType', sortable:false,editable: true, edittype:"select", editrules:{required:false, edithidden:true},editoptions:{ dataInit: function(elem) {$(elem).width(160);}, value:"Invoice:Invoice;DC:DC"},formatter:'select'},
						//{name:'invoiceType',index:'invoiceType', sortable:false,editable: true,edittype:"select",hidden:true, editrules:{required:false, edithidden:true},editoptions:{ dataInit: function(elem) {$(elem).width(160);}, value:"abc:qpr;axx:aaa"},formatter:'select'},
						{
							name:'invoiceType',index:'invoiceType',width: 100, editable: true,
	                        formatter: 'select', edittype: 'select',
	                        editoptions: {
	                            value: invType,
	                            dataInit: function (elem) {
	                                var v = $(elem).val();
	                                // to have short list of options which corresponds to the country
	                                // from the row we have to change temporary the column property
	                                jQuery(grid_selector).jqGrid('setColProp', 'invoicePercentage', { editoptions: { value: invTypePercent[v]} });
	                            },
	                            dataEvents: [
	                                {
	                                    type: 'change',
	                                    fn: function (e) {
	                                        // build 'State' options based on the selected 'Country' value
	                                        var v = $(e.target).val(),
	                                            sc = invTypePercent[v],
	                                            newOptions = '',
	                                            stateId,
	                                            form,
	                                            row;
	                                        for (stateId in sc) {
	                                            if (sc.hasOwnProperty(stateId)) {
	                                                newOptions += '<option role="option" value="' + stateId + '">' +
	                                                    percent[stateId] + '</option>';
	                                            }
	                                        }
	
	                                        resetPercentValues();
	
	                                        // populate the subset of contries
	                                        if ($(e.target).is('.FormElement')) {
	                                            // form editing
	                                            form = $(e.target).closest('form.FormGrid');
	                                            $("select#invoicePercentage.FormElement", form[0]).html(newOptions);
	                                        } else {
	                                            // inline editing
	                                            row = $(e.target).closest('tr.jqgrow');
	                                            $("select#" + $.jgrid.jqID(row.attr('id')) + "_invoicePercentage", row[0]).html(newOptions);
	                                        }
	                                    }
	                                }
	                            ]
	                        }
	                    },
						{name:'invoicePercentage',index:'invoicePercentage', sortable:false,editable: true,hidden:true, edittype:"select",formoptions:{rowpos:15, colpos:2},hidden:true, editrules:{required:false, edithidden:true},editoptions:{ dataInit: function(elem) {$(elem).width(160);}, value:percent},formatter:'select'},
						
						{name:'invisionHR',index:'invisionHr', sortable:false,editable: true,hidden:true, edittype:"select",hidden:true, editrules:{required:false, edithidden:true},editoptions:{ dataInit: function(elem) {$(elem).width(160);}, value:PT_inversionHrData},formatter:'select'},
						{name:'rubberMOULD',index:'rubberMould', sortable:false,editable: true,hidden:true, edittype:"select",hidden:true, editrules:{required:false, edithidden:true},editoptions:{ dataInit: function(elem) {$(elem).width(160);}, value:PT_rubberMould},formatter:'select'},
						{name:'viper25',index:'viper25', sortable:false,editable: true,hidden:true, edittype:"select",hidden:true, editrules:{required:false, edithidden:true},editoptions:{ dataInit: function(elem) {$(elem).width(160);}, value:PT_viber25},formoptions:{rowpos:17, colpos:2},formatter:'select'},
						{name:'viper50',index:'viper50', sortable:false,editable: true,hidden:true, edittype:"select",hidden:true, editrules:{required:false, edithidden:true},editoptions:{ dataInit: function(elem) {$(elem).width(160);}, value:PT_viber50},formoptions:{rowpos:18, colpos:2},formatter:'select'},
						
						{name:'autoApproval',index:'autoApproval', sortable:false,editable: true, hidden:true, edittype:"checkbox",editrules:{required:false, edithidden:true},editoptions:{value:"true:false", defaultValue:"true"}},
						{name:'sendInvoiceSms',index:'sendInvoiceSms', sortable:false,editable: true,hidden:true, edittype:"checkbox",editrules:{required:false, edithidden:true},editoptions:{value:"true:false", defaultValue:"true"}},
						{name:'active',index:'active', sortable:false, editable: true, hidden:true, edittype:"checkbox",editrules:{required:false, edithidden:true},formoptions:{rowpos:22, colpos:2},editoptions:{value:"true:false", defaultValue:"true"}},
						
						{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false,
							formatter:'actions', 
							formatoptions:{ 
								keys:true,
								delOptions:{top:45 , url: "${pageContext.request.contextPath}/clientmaster.action?op=delete", left:((($(window).width() - 300) / 2) + $(window).scrollLeft()), recreateForm: true, closeOnEscape:true, beforeShowForm:beforeDeleteCallback},
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
						
						
					},
					
					editurl: "${pageContext.request.contextPath}/clientmaster.action?op=edit",//nothing is saved
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
						edittitle: "Edit Client",
						editicon : 'icon-pencil blue',
						add: true,
						addtext:"Add",
						addtitle: "Add Client",
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
						editCaption: "Edit Client",
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
						addCaption: "Add Client",
						
						closeAfterAdd: true,
						recreateForm: true,
						closeOnEscape:true,
						url: "${pageContext.request.contextPath}/clientmaster.action?op=add",
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

				$.extend($.jgrid.edit, {
				    beforeSubmit: function () {
				        $(this).jqGrid("setGridParam", {datatype: "json"});
				        return [true,"",""];
				    }
				});
			});
				
		</script>
