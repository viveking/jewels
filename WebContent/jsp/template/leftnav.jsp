<div class="sidebar sidebar-fixed" id="sidebar">

	<div class="sidebar-shortcuts" id="sidebar-shortcuts">
		<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
			<button class="btn btn-success">
				<i class="icon-signal"></i>
			</button>

			<button class="btn btn-info">
				<i class="icon-pencil"></i>
			</button>

			<button class="btn btn-warning">
				<i class="icon-group"></i>
			</button>

			<button class="btn btn-danger">
				<i class="icon-cogs"></i>
			</button>
		</div>

		<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
			<span class="btn btn-success"></span> <span class="btn btn-info"></span>

			<span class="btn btn-warning"></span> <span class="btn btn-danger"></span>
		</div>
	</div>
	<!-- #sidebar-shortcuts -->

	<ul class="nav nav-list">
		<li class="active"><a href="#"> <i class="icon-dashboard"></i>
				<span class="menu-text" data-href="/jsp/dashboard/dashboard.jsp">
					Dashboard </span>
		</a></li>
		
		<li>
			<a href="#" class="dropdown-toggle"> <i
				class="icon-list-alt"></i> <span class="menu-text"> Master </span> <b
				class="arrow icon-angle-down"></b>
			</a>

			<ul class="submenu">
				<li><a href="#" data-href="/jsp/master/client_master.jsp">
						<i class="icon-double-angle-right"></i> Client
				</a></li>
				
				<li><a href="#" data-href="/jsp/master/rate_master.jsp">
						<i class="icon-double-angle-right"></i> Rates
				</a></li>
				<li><a href="#" data-href="/jsp/master/user_master.jsp">
						<i class="icon-double-angle-right"></i> User
				</a></li>
				<li><a href="#" data-href="/jsp/master/role_master.jsp">
						<i class="icon-double-angle-right"></i> Role
				</a></li>
			</ul>
		</li>
		<li>
			<a href="#" class="dropdown-toggle"> <i
				class="icon-list-alt"></i> <span class="menu-text"> Order </span> <b
				class="arrow icon-angle-down"></b>
			</a>
			
			<ul class="submenu">
				<li><a href="#" data-href="/jsp/order/newOrder.jsp">
						<i class="icon-double-angle-right"></i> New Order
				</a></li>
				
				<li><a href="#" data-href="/jsp/order/generateOrder.jsp">
						<i class="icon-double-angle-right"></i> Order Generation
				</a></li>

				<li><a href="#" data-href="/jsp/order/updateOrder.jsp">
						<i class="icon-double-angle-right"></i> Update Order
				</a></li>				
<!-- 
				<li><a href="#" data-href="/jsp/order/order.jsp">
						<i class="icon-double-angle-right"></i> Order Generation
				</a></li>
 -->				
			</ul>
			
		</li>
		<li>
			<a href="#" class="dropdown-toggle"> <i
				class="icon-list-alt"></i> <span class="menu-text"> Platform </span> <b
				class="arrow icon-angle-down"></b>
			</a>
			
			<ul class="submenu">
				<li><a href="#" data-href="/jsp/platform/platform_master.jsp">
						<i class="icon-double-angle-right"></i>Create Platform
				</a></li>
				<li><a href="#" data-href="/jsp/platform/platformOptCalc.jsp">
						<i class="icon-double-angle-right"></i> Platform Output Calculation
				</a></li>
				<li><a href="#" data-href="/jsp/platform/partsUpdate.jsp">
						<i class="icon-double-angle-right"></i> Parts Update
				</a></li>
				<li><a href="#" data-href="/jsp/platform/platform_status_update.jsp">
						<i class="icon-double-angle-right"></i> Platform Status Update
				</a></li>
				
			</ul>
			
		</li>
<!-- Invoice starts-->
		<li>
			<a href="#" class="dropdown-toggle"> <i
				class="icon-list-alt"></i> <span class="menu-text"> Invoice </span> 
				<b class="arrow icon-angle-down"></b>
			</a>
			
			<ul class="submenu">
				<li><a href="#" data-href="/jsp/invoice/invoice.jsp">
						<i class="icon-double-angle-right"></i> Invoice
				</a></li>
				
				<li><a href="#" data-href="/jsp/invoice/receipts.jsp">
						<i class="icon-double-angle-right"></i> Receipts
				</a></li>
			</ul>
			
		</li>

<!-- Invoice ends  -->
		<li>
			<a href="#" class="dropdown-toggle"> <i
					class="icon-bar-chart"></i> <span class="menu-text"> Report </span>
					<b class="arrow icon-angle-down"></b>
			</a>
<!-- 
			<ul class="submenu">
				<li><a href="report.action?op=REPORT_DATE"> <i
						class="icon-double-angle-right"></i> Daily Sales
				</a></li>
				
				<li><a href="#" onclick="showSalesReportDialog()"> <i
						class="icon-double-angle-right"></i> Sales Report
				</a></li>

				<li><a href="#" onclick="showPurchaseReportDialog()">
						<i class="icon-double-angle-right"></i> Purchase Report
				</a></li>
			</ul>
 -->		</li>
	</ul>
	<!-- /.nav-list -->

	<div class="sidebar-collapse" id="sidebar-collapse">
		<i class="icon-double-angle-left" data-icon1="icon-double-angle-left"
			data-icon2="icon-double-angle-right"></i>
	</div>

	<script type="text/javascript">
		try {
			ace.settings.check('sidebar', 'collapsed');
		} catch (e) {
		}
	</script>
</div>