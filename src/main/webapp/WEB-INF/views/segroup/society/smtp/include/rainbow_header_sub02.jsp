<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="headerWrap">
    <%@include file="rainbow_header_basic.jsp" %>
    <div class="header-menuWrap">

        <ul class="header-menu d-flex justify_end fc_fff">
        	<li class="hdrMenu"><a href="javascript:page_move('/smtp/course/short-term/short-term-info','c000000543')">SWDO 마스터 사전학습반</a></li>
            <li class="hdrMenu"><a href="javascript:page_move('/smtp/course/short-term/short-term-info','c000000538')">AI 개요와 딥러닝 개념</a></li>
            <li class="hdrMenu"><a href="javascript:page_move('/smtp/course/short-term/short-term-info','c000000539')">코딩한줄 없는 AI 활용</a></li>
            <li class="hdrMenu"><a href="javascript:page_move('/smtp/course/short-term/short-term-info','c000000535')">입문 : 이제부터파이썬 - 딥러닝을 위한 파이썬 기초과정</a></li>
            <li class="hdrMenu"><a href="javascript:page_move('/smtp/course/short-term/short-term-info','c000000537')">파이썬으로 배우는 데이터분석과 시각화</a></li>
            <li class="hdrMenu"><a href="javascript:page_move('/smtp/course/short-term/short-term-info','c000000536')">파이썬 기반 데이터 사이언스 기초</a></li>
            <li class="hdrMenu"><a href="javascript:page_move('/smtp/course/short-term/short-term-info','c000000540')">파이썬을 이용한 웹 스크래핑</a></li>
        </ul>
    </div>
    <script type="text/javascript">
        $(function() {
            // include/rainbow_header_sub0$ 활성화된 메뉴 링크 삭제
            var path = window.location.href;
            $('.header-menuWrap .header-menu .hdrMenu>a').each(function() {
                if (this.href === path) {
                    $(this).hide();
                    $(this).next().css({
                        "display": "block"
                    });
                }
            });
        });
        
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
</div>
