<%@ page language="java" isELIgnored="false" contentType="text/html; charset=ISO-8859-1"	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head lang="en">

	<meta charset="utf-8" />
	<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon"> 
	<title>Jyoti Solutions</title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="description" content="overview &amp; stats" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<jsp:include page='/jsp/template/cssandjs.jsp' />

<!-- WEB SOCKET START -->
<% 
String appPath = request.getContextPath();
%>
<script type="text/javascript">
var webSocket = null;
var url = '';
var jsAppName = '<%=appPath%>';
/* if(window.location.protocol == 'http:') {	
	url  = 'ws://' + window.location.host+jsAppName+'/alert';
}
else{
	url = 'wss://' + window.location.host+jsAppName+'/alert';
}
console.log("WS url:"+url);

if ('WebSocket' in window) {
	webSocket = new WebSocket(url);
} 
else if ('MozWebSocket' in window) {
	webSocket = new MozWebSocket(url);
} 
else {
	console.log("Info: WebSocket WebSocket is not supported by this browser");
}

webSocket.onopen = function () {
	console.log('Info: WebSocket connection opened.');
};

webSocket.onclose = function () {
	console.log('Info: WebSocket closed.');
};

webSocket.onmessage = function (message) {
	printMsg(message.data);
};

function printMsg(message)
{
	console.log("called....");
	console.log(message);
	var JsonAlertObj = JSON.parse(message);
	var shortageObj = JsonAlertObj.SHORTAGE_ALERT;
	var expiryObj = JsonAlertObj.EXPIRY_ALERT;
	
	//----------- Shortage Javascript ALERT ----------------
	$("#idSortageCount").html(shortageObj.length);
	$("#idSortageList").empty();
	
	var header="<li class='dropdown-header'>\
					<i class='icon-shopping-cart'></i>\
					Shortage of Product\
				</li>";
	$("#idSortageList").append(header);
	$.each(shortageObj,function(ir,value){
		var itemLi = "<li> \
						<a href='#'> \
							<div class='clearfix'> \
								<span class='pull-left red bigger-150 col-lg-6' style='padding: 0;'>"+ value.name +"</span> \
								<span class='pull-right bigger-150'><i class='icon-shopping-cart'> </i><b>"+ value.currentStock +"</b></span> \
								<span class='col-lg-6' style='padding: 0;'>	Code : <span>"+ value.code +"</span></span> \
							</div> \
						</a> \
					</li>";
		$("#idSortageList").append(itemLi);
	});
	
	if(shortageObj.length>0){
		var showAll = "<li></li>"; 
		$("#idSortageList").append(showAll);
	}


	//----------- Expiry Javascript ALERT ------------- //
	$("#idExpiryCount").html(expiryObj.length);
	$("#idExpiryList").empty();
	header="<li class='dropdown-header'>\
					<i class='icon-warning-sign'></i>\
					Expired Product\
				</li>";
	$("#idExpiryList").append(header);
	$.each(expiryObj,function(ir,value){
		var itemBat = "";
		$.each(value.batchList,function(itrb,valueBatch){
			itemBat = itemBat + "<div class='col-lg-12'><span>"+valueBatch.batchNumber+"</span><span class='badge badge-info'>"+valueBatch.sExpdate+"</span></div>";
		});
		
		var itemLi = "<li>\
						<a href='#'>\
							<div class='clearfix'>\
								<span class='pull-left'>\
									<i class='btn btn-xs no-hover btn-pink icon-calendar'></i>"+value.name+"\
								</span>\
								<div class='container'>"+itemBat+"</div>\
							</div>\
						</a>\
					</li>";
		
		$("#idExpiryList").append(itemLi);
	});
	
	
	if(expiryObj.length>0){
		var showAll = "<li></li>";
		$("#idExpiryList").append(showAll);
	}
	
	
}; */
</script>
<!-- WEB SOCKET START -->
	
</head>
<body class="navbar-fixed">

	<div class="navbar navbar-default navbar-fixed-top" id="navbar">
			<script type="text/javascript">
				//try{ace.settings.check('navbar' , 'fixed');}catch(e){}
			</script>

			<div class="navbar-container" id="navbar-container">
				<div class="navbar-header pull-left">
					<a href="#" class="navbar-brand">
						
							<b class="icon-barchart" style="color:red"></b>
						<small class='munsi_logo'>Balaji_CAM_Solution</small>
						
					</a><!-- /.brand -->
				</div><!-- /.navbar-header -->

				<div class="navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						<li class="grey">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-tasks"></i>
								<span id="idSortageCount" class="badge badge-grey">0</span>
							</a>

							<ul id="idSortageList" class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
							</ul>
						</li>

						<li class="purple">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-bell-alt icon-animated-bell"></i>
								<span id="idExpiryCount" class="badge badge-important">0</span>
							</a>

							<ul id="idExpiryList" class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">

							</ul>
						</li>

<!-- 						<li class="green">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-envelope icon-animated-vertical"></i>
								<span class="badge badge-success">5</span>
							</a>

							<ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="icon-envelope-alt"></i>
									5 Messages
								</li>

								<li>
									<a href="#">
										<img src="assets/avatars/avatar.png" class="msg-photo" alt="Alex's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Alex:</span>
												Ciao sociis natoque penatibus et auctor ...
											</span>

											<span class="msg-time">
												<i class="icon-time"></i>
												<span>a moment ago</span>
											</span>
										</span>
									</a>
								</li>

								<li>
									<a href="#">
										<img src="assets/avatars/avatar3.png" class="msg-photo" alt="Susan's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Susan:</span>
												Vestibulum id ligula porta felis euismod ...
											</span>

											<span class="msg-time">
												<i class="icon-time"></i>
												<span>20 minutes ago</span>
											</span>
										</span>
									</a>
								</li>

								<li>
									<a href="#">
										<img src="assets/avatars/avatar4.png" class="msg-photo" alt="Bob's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Bob:</span>
												Nullam quis risus eget urna mollis ornare ...
											</span>

											<span class="msg-time">
												<i class="icon-time"></i>
												<span>3:15 pm</span>
											</span>
										</span>
									</a>
								</li>

								<li>
									<a href="inbox.html">
										See all messages
										<i class="icon-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li>
 -->
						<li class="">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<i class="icon-user"></i>
								<span class="user-info">
									<small>Welcome,</small>
									User
								</span>

								<i class="icon-caret-down"></i>
							</a>

							<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<li>
									<a href="#">
										<i class="icon-cog"></i>
										Settings
									</a>
								</li>

								<li>
									<a href="#">
										<i class="icon-user"></i>
										Profile
									</a>
								</li>

								<li class="divider"></li>

								<li>
									<a href="#">
										<i class="icon-off"></i>
										Logout
									</a>
								</li>
							</ul>
						</li>
					</ul><!-- /.ace-nav -->
				</div><!-- /.navbar-header -->
			</div><!-- /.container -->
		</div>