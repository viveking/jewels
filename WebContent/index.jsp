<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	HttpSession sesn = request.getSession(false);
	if(sesn==null || sesn.getAttribute("SESSION_SET")==null ){
		response.sendRedirect("login.jsp");
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<body>
<jsp:forward page="/home.jsp"></jsp:forward>
</body>
</html>