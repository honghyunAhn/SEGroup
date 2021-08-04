<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
function page_move(url, some_data) {
    var form = document.createElement("form");
    var input;
    form.action = url;
    form.method = "post";
    input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute('name', "course_id");
    input.setAttribute("value", some_data);
    form.appendChild(input);
    
    document.body.appendChild(form);
    form.submit();
    form.remove();
}
</script>
<div class="headerWrap">
    <%@include file="rainbow_header_basic.jsp" %>
    <div class="header-menuWrap">

        <ul class="header-menu d-flex justify_end fc_fff">
            <li class="hdrMenu"><a href="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000526')">SWDO 마스터</a></li>
        	<li class="hdrMenu"><a href="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000525')">SCIT 마스터</a></li>
<!--                 <li class="hdrMenu"><a href="sub03-03.html">글로벌 디지털 인재양성</a></li> -->
<!--                 <li class="hdrMenu"><a href="sub03-04.html">일본취업학교</a></li> -->
        </ul>
    </div>
</div>