<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String userAgent = request.getHeader("user-agent");
	if(userAgent.matches(".*Android.*"))
	{
		//out.print("Android");
		out.print("{\"version\":\"9.0\", \"link\":\"market://details?id=changbi.com.changbi_android\", \"new\":\"new version android\",\"flag\":\"SERVICE\",\"message\":\"\" }");
	}
	else
	{
		//out.print("No Android");//아이폰이면
		out.print("{\"version\":\"1.3\", \"link\":\"https://teacher.changbiedu.com/app/app_down.jsp\", \"new\":\"new version iOS\",\"flag\":\"SERVICE\",\"message\":\"\" }");
	}
%>
