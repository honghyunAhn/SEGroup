<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/segroup/society/smp/css/course.css">
<script>
window.onload = function(){
	var browser = navigator.userAgent.toLowerCase();
    if ( -1 != browser.indexOf('chrome') ){
               window.print();
    }else if ( -1 != browser.indexOf('trident') ){
               try{
                        //참고로 IE 5.5 이상에서만 동작함

                        //웹 브라우저 컨트롤 생성
                        var webBrowser = '<OBJECT ID="previewWeb" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';

                        //웹 페이지에 객체 삽입
                        document.body.insertAdjacentHTML('beforeEnd', webBrowser);

                        //ExexWB 메쏘드 실행 (7 : 미리보기 , 8 : 페이지 설정 , 6 : 인쇄하기(대화상자))
                        previewWeb.ExecWB(7, 1);

                        //객체 해제
                        previewWeb.outerHTML = "aaaaaaaa";
               }catch (e) {
                        alert("- 도구 > 인터넷 옵션 > 보안 탭 > 신뢰할 수 있는 사이트 선택\n   1. 사이트 버튼 클릭 > 사이트 추가\n   2. 사용자 지정 수준 클릭 > 스크립팅하기 안전하지 않은 것으로 표시된 ActiveX 컨트롤 (사용)으로 체크\n\n※ 위 설정은 프린트 기능을 사용하기 위함임");
               }             
    }
	
}
</script>
</head>
<body>

</body>
</html>

<div id="page">
   <div class="fontChange">
      <div class="title">
         <br>
         <h1>수강확인서</h1>
         </br>
      </div>
      <tr>
         <div class="index">
               <br><h2>이름 : ${printStudentInfo.user_nm}</h2></br>
               <br><h2>기수 : ${printStudentInfo.gisu_num}기</h2></br>
               <br><h2>생년월일 : ${printStudentInfo.user_birth}</h2></br>
               <br><h2>시작일자 : ${printStudentInfo.gisu_crc_st}</h2></br>
               <br><h2>종료일자 : ${printStudentInfo.gisu_crc_et}</h2></br>
         </div>
         <div class="content">

            <p><th><h2>
                     위 학습자는 KITA 무역아카데미의
                     <p>SC IT MASTER가 실시하는 강좌의 수강을 확인하여
                     <p>이 증서를 발급함
            </h2></th></p>
         </div>
      </tr>
      <div class="last">
         <p><th><h2>${nYear }년 ${nMonth }월 ${nDay }일</h2></th>   </p>
         <p><th><h2>
                  무역아카데미 원장
                  <p>여명환
               
               </h2></th>
         </p>
      </div>
   </div>
</div>