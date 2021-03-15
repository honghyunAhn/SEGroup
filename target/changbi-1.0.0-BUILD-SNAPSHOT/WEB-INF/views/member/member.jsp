<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
$(document).ready(function(){ 
	
});
</script>

<form action="/member/insertUser" method="POST">
아이디 : <input type="text" name="user_id" id="user_id"/>
비밀번호 : <input type="password" name="password" id="password"/>
<input type="hidden" name="email" value="test@ttt.ttt"/>
	<input type="submit" value="회원가입">
</form>