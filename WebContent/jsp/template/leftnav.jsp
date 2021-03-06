<%@page import="com.affixus.pojo.auth.User"%>
<%@page import="com.affixus.pojo.auth.Role"%>
<%
	HttpSession sesn = request.getSession(false);
	Role role=null;
	if(sesn!=null || sesn.getAttribute("user")!=null ){
		User user = (User) sesn.getAttribute("user");
		role = user.getRole();
	}
%>
<div class="sidebar sidebar-fixed" id="sidebar">

	<div class="sidebar-shortcuts" id="sidebar-shortcuts">
		<!-- <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
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
		</div> -->

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
				<% if(role.isClientMaster()){ %>
					<li><a href="#" data-href="/jsp/master/clientMaster.jsp">
						<i class="icon-double-angle-right"></i> Client
					</a></li>
				<%} %>
				<% if(role.isRateMaster()){ %>
					<li><a href="#" data-href="/jsp/master/rateMaster.jsp">
							<i class="icon-double-angle-right"></i> Rates
					</a></li>
				<%} %>
				<% if(role.isUserMaster()){ %>
					<li><a href="#" data-href="/jsp/master/userMaster.jsp">
							<i class="icon-double-angle-right"></i> User
					</a></li>
				<%} %>
				<% if(role.isRoleMaster()){ %>
					<li><a href="#" data-href="/jsp/master/roleMaster.jsp">
							<i class="icon-double-angle-right"></i> Role
					</a></li>
				<%} %>
			</ul>
		</li>
		<li>
			<a href="#" class="dropdown-toggle"> <i
				class="icon-list-alt"></i> <span class="menu-text"> Order </span> <b
				class="arrow icon-angle-down"></b>
			</a>
			
			<ul class="submenu">
				<% if(role.isNewOrder()){ %>
					<li><a href="#" data-href="/jsp/order/newOrder.jsp">
							<i class="icon-double-angle-right"></i> New Order
					</a></li>
				<%} %>
				<% if(role.isGenerateOrder()){ %>
				
					<li id="liOrderGeneration"><a href="#" data-href="/jsp/order/generateOrder.jsp">
							<i class="icon-double-angle-right"></i> Order Generation
					</a></li>
					<!-- 
					<li><a href="#" data-href="/jsp/order/updateOrder.jsp">
							<i class="icon-double-angle-right"></i> Update Order
					</a></li>				
	  				-->
				<%} %>
				<% if(role.isIncompleteOrder()){ %>
					<li><a href="#" data-href="/jsp/order/incompleteOrder.jsp">
							<i class="icon-double-angle-right"></i> Incomplete Order
					</a></li>
				<%} %>
 				
			</ul>
			
		</li>
		<li>
			<a href="#" class="dropdown-toggle"> <i
				class="icon-list-alt"></i> <span class="menu-text"> Platform </span> <b
				class="arrow icon-angle-down"></b>
			</a>
			
			<ul class="submenu">
				<!--li><a href="#" data-href="/jsp/platform/platform_master.jsp">
						<i class="icon-double-angle-right"></i>Create Platform
				</a></li-->
				<% if(role.isPlatformOptCalc()){ %>
					<li><a href="#" data-href="/jsp/platform/platformOptCalc.jsp">
							<i class="icon-double-angle-right"></i> Platform Output Calculation
					</a></li>
				<%} %>
				<% if(role.isOrderUpdate()){ %>	
					<li><a href="#" data-href="/jsp/platform/orderUpdate.jsp">
							<i class="icon-double-angle-right"></i> Completed Order Update
					</a></li>
				<%} %>	
				<!-- <li><a href="#" data-href="/jsp/platform/platform_status_update.jsp">
						<i class="icon-double-angle-right"></i> Platform Status Update
				</a></li> -->
				
			</ul>
			
		</li>
<!-- Invoice starts-->
		<li>
			<a href="#" class="dropdown-toggle"> <i
				class="icon-list-alt"></i> <span class="menu-text"> Invoice </span> 
				<b class="arrow icon-angle-down"></b>
			</a>
			
			<ul class="submenu">
				
				
				<li>
					<a href="#" class="dropdown-toggle"> <i
						class="icon-list-alt"></i> <span class="menu-text"> Invoice </span> 
						<b class="arrow icon-angle-down"></b>
					</a>
			
					<ul class="submenu">
						<% if(role.isGenerateInvoice()){ %>
							<li>
								<a href="#" data-href="/jsp/invoice/generateInvoice.jsp">
									<i class="icon-double-angle-right"></i>Generate Invoice
								</a>
							</li>
						<%} %>
						<% if(role.isPrintInvoice()){ %>
							<li>
								<a href="#" data-href="/jsp/invoice/printInvoice.jsp">
									<i class="icon-double-angle-right"></i>Print Invoice
								</a>
							</li>
						<%} %>	
					</ul>
				</li>
				
				<li>
					<a href="#" class="dropdown-toggle"> <i
						class="icon-list-alt"></i> <span class="menu-text"> DC </span> 
						<b class="arrow icon-angle-down"></b>
					</a>
			
					<ul class="submenu">
					<% if(role.isGenerateDC()){ %>
						<li><a href="#" data-href="/jsp/invoice/generateDC.jsp">
							<i class="icon-double-angle-right"></i>Generate DC
						</a></li>
					<%} %>
					<% if(role.isPrintDC()){ %>
						<li><a href="#" data-href="/jsp/invoice/printDC.jsp">
								<i class="icon-double-angle-right"></i>Print DC
						</a></li>
						</ul>
					<%} %>
				</li>
				
				

				<li><a href="#" data-href="/jsp/template/under_maintenance.jsp">
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
		
			<ul class="submenu">
				<!-- 	<li><a href="#" data-href="/jsp/report/platformStatus.jsp"> 
						<i class="icon-double-angle-right"></i> Platform Status
					</a></li>
				 -->
				<% if(role.isPlatformOptCalc()){ %>
					<li><a href="#" data-href="/jsp/report/platform_status_update.jsp"> 
						<i class="icon-double-angle-right"></i> Platform Status
					</a></li>
				<% } %>
			</ul>
 		
		</li>
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