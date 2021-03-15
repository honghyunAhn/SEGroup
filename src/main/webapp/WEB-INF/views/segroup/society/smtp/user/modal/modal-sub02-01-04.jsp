<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<body>
	<div class="header d-flex justify_between">
        <div class="titleBar h3" id="class-name-bar"></div>
		<div class="img-icon times close-modal"></div>
    </div>
	<div class="sectionWrap courseRegistrationWrap">
        <!-- processWrap : 다음단계로 넘어갈 때 .addClass('.active')됩니다. -->
        <ul class="processWrap processWrapBar d-flex">
			<li class="process active"><span class="margin-right10 h5">01</span>결제방법</li>
			<li class="process"><span class="margin-right10 h5">02</span>결제</li>
        </ul>
            <div class="section modal-sub02-01-04">
                <div class="header">
                    <strong class="h4">수강신청이 완료되었습니다.</strong>
                    <h5 class="fz14 c999">
                        구매해주셔서 감사합니다.<br>구매한 강의 내역은 나의강의실에서 확인 하실 수 있습니다.
                    </h5>
                </div>
                <div class="button-wrap d-flex justify_end margin-top40">
                    <!-- 버튼 클릭 시 로그인 된 상태로 전환, 메인으로 이동됩니다. -->
                    <button class="btn_normal btn_pp_bg btn_large margin-left20" type="button" onclick="location.href='/smtp/user/sub05-04'">
                        나의강의실로 이동
                    </button>
                </div>
            </div>
        <!-- </div> -->
    </div>
    <script type="text/javascript">
        $(document).ready(function() {
            //모달 닫기 - 다음/이전 단계 넘어갈 시 load로 불러오니 닫기 버튼 안눌렸음 그래서 임시로 넣어둠
          /*   $('.modal .close-modal').click(function() {
                //모달 닫고 다른 수강신청 버튼 클릭했을 때 초기화 되는 것
                //$('.modal-content').load('include/modal-sub02-01-01.html');

                $('html, body').removeClass("not-scroll");
                $('.modal').hide();
            }); */
        });
    </script>
</body>

</html>
