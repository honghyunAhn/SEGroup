<%@ page contentType="text/html;charset=utf-8" %>
<!doctype html>
<html>
<head>
<title>페이지이동</title>
<meta http-equiv="content-type" content="text/html;charset=utf-8"/>
<meta http-equiv="imagetoolbar" content="no"/>
<meta name="robots" content="noindex, nofollow"/>
<meta http-equiv="pragma" content="no-cache"/>
</head>
<body>
<%
	if (request.getAttribute("script") != null) {
		out.println("<script language=javascript>"+request.getAttribute("script")+"</script>");
	}

	if (request.getAttribute("next") != null) {
		if (request.getHeader("referer") != null) {
			String next = (String)request.getAttribute("next");
			out.println("<script type='text/avascript'>link('"+next+"');</script>");
		} else {
			out.println("<script 'type=text/avascript'>location.href='/';</script>");
		}
	}

%>
</body>
</html>