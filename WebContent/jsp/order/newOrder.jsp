
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

<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->
		<div class="form-group">
			<div class="col-xs-12">
				<label for="form-field-select-1">Select Printer</label>
	
				<select class="form-control" id="form-field-select-1">
					<option selected="selected" value="0">-- Select PriceList Group --</option>
					<option value="INVISIONHR">INVISIONHR</option>
					<option value="VIPER25">VIPER25</option>
					<option value="VIPER50">VIPER50</option>
					<option value="ZNone">ZNone</option>
				</select>
			</div>
			<label for="id-date-picker-1">Date Picker</label>
			<div class="col-xs-12">
				
				<div class="input-group">
					<input class="form-control date-picker" id="id-date-picker-1" type="text" data-date-format="dd-mm-yyyy">
					<span class="input-group-addon">
						<i class="fa fa-calendar bigger-110"></i>
					</span>
				</div>
			</div>
			<div class="col-xs-12">
				<input type="file" id="newOrderInputFile">
					
				<label class="ace-file-input">
					<span class="ace-file-container" data-title="Choose">
					<span class="ace-file-name" data-title="No File ...">
					<i class=" ace-icon fa fa-upload"></i></span></span>
					<a class="remove" href="#"><i class=" ace-icon fa fa-times"></i></a>
				</label>
			</div>
		</div>
		
		<!-- PAGE CONTENT ENDS -->
	</div><!-- /.col -->
</div><!-- /.row -->