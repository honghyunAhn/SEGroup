<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi " />
<meta name="format-detection" content="telephone=no">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<head>
	<title></title>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">

<style>
.sub_top_img{ width: 984px; height: 300px; }
</style>

</head>
<body>
<%@include file="../menu.jsp"%>
<div class="sub_m_contents">
		<div class="main_top_slidewrap">
		<div class="sub_top_img">
			<img src="<c:url value="/resources/segroup/society/edu/image/sub/images/sub_top_img.png" />" alt="sub_top_img" />
		</div>
		<div class="master_bottom_menu">
			<ul>
				<li class="choice_menu mbm1"><a href="#fe_01">과정개요</a></li>
				<li class="mbm2"><a href="#fe_02">커리큘럼</a></li>
				<li class="mbm3"><a href="#fe_03">강사진</a></li>
				<li class="mbm4"><a href="#fe_04">수강절차</a></li>
				<li class="mbm5"><a href="#fe_05">수강신청</a></li>
				<li class="mbm6"><a href="#fe_06">수강문의</a></li>
			</ul>
		</div>
		<div class="master_bottom_contents">
			<div class="info1" id="fe_01">과정소개</div>
			<div class="info2" id="fe_02">커리큘럼 안내</div>
			<div class="info_4_m">
				<h2><p>교수님 사진<span>더보기<img src="<c:url value="/resources/segroup/society/edu/image/sub/plus.png" />" alt=""/></span></p></h2>
				<div class="box_wrap">
				    <div class="box box_left">
						<h3>홍길도 교수님<span><img src="<c:url value="/resources/segroup/society/edu/image/sub/one_next.png" />" alt=""/></span></h3>
                        <em class="label"><i>기초</i><b>JAVA</b></em>
					</div>
				    <div class="box box_right">
                        <h3>홍길도 교수님<span><img src="<c:url value="/resources/segroup/society/edu/image/sub/one_next.png" />" alt=""/></span></h3>
                        <em class="label"><i>기초</i><b>JAVA</b></em>

					</div>
				    <div class="box box_left">
                        <h3>홍길도 교수님<span><img src="<c:url value="/resources/segroup/society/edu/image/sub/one_next.png" />" alt=""/></span></h3>
                        <em class="label"><i>기초</i><b>JAVA</b></em>

					</div>
				    <div class="box box_right">
                        <h3>홍길도 교수님<span><img src="<c:url value="/resources/segroup/society/edu/image/sub/one_next.png" />" alt=""/></span></h3>
                        <em class="label"><i>기초</i><b>JAVA</b></em>

					</div>
				</div>
			</div>
			<div class="info4" id="fe_03">
				<ul>
					<li>
						<dl>
							<dt>
								<h2>ICT 세상을 열어줄</h2>
								<h1>홍길도</h1>
							</dt>
							<dd>
									<a href=""><img src="<c:url value="/resources/segroup/society/edu/image/sub/img_teacher.png" />"></a>
							</dd>
						</dl>
								<p>Java 기초</p>
								<p>처음부터 쉽게 쉽게</p>
					</li>
					<li>
						<dl>
							<dt>
								<h2>ICT 세상을 열어줄</h2>
								<h1>홍길도</h1>
							</dt>
							<dd>
								<a href=""><img src="<c:url value="/resources/segroup/society/edu/image/sub/img_teacher.png" />"></a>
							</dd>
						</dl>
								<p>Java 기초</p>
								<p>처음부터 쉽게 쉽게</p>
					</li>
					<li>
						<dl>
							<dt>
								<h2>ICT 세상을 열어줄</h2>
								<h1>홍길도</h1>
							</dt>
							<dd>
								<a href=""><img src="<c:url value="/resources/segroup/society/edu/image/sub/img_teacher.png" />"></a>
							</dd>
						</dl>
								<p>Java 기초</p>
								<p>처음부터 쉽게 쉽게</p>
					</li>
					<li>
						<dl>
							<dt>
								<h2>ICT 세상을 열어줄</h2>
								<h1>홍길도</h1>
							</dt>
							<dd>
								<a href=""><img src="<c:url value="/resources/segroup/society/edu/image/sub/img_teacher.png" />"></a>
							</dd>
						</dl>
								<p>Java 기초</p>
								<p>처음부터 쉽게 쉽게</p>
					</li>
					<li>
						<dl>
							<dt>
								<h2>ICT 세상을 열어줄</h2>
								<h1>홍길도</h1>
							</dt>
							<dd>
								<a href=""><img src="<c:url value="/resources/segroup/society/edu/image/sub/img_teacher.png" />"></a>
							</dd>
						</dl>
								<p>Java 기초</p>
								<p>처음부터 쉽게 쉽게</p>
					</li>
				</ul>
			</div>
			<div class="info3" id="fe_04">수강 신청 절차</div>
			<div class="info5" id="fe_05">수강신청</div>
			<div class="info6" id="fe_06">
				<dl>
					<dt>
						<h1>상담받으실 연락 정보</h1>
						<h2>연락처 남겨주시면 궁금하신 사항에 대해 신속하게 응대해 드립니다.</h2>
					</dt>
					<dd>
						<table class="info_table_pc">
						  <tr>
						    <th>상담일시</th>
						    <td colspan="3"><input type="text" name=""></td>						    
						  </tr>
						  <tr>
						    <th>이름</th>
						    <td><input type="text" name="" readonly="readonly"></td>
						    <th>성별</th>
						    <td>
						    	<input type="radio" name=""> 남자
						    	<input type="radio" name=""> 여자
						    	<!-- 
								<select class="select_gender">
						    		<option value='' selected>선택</option>
						    		<option>여자</option>
						    		<option>남자</option>						    		
						    	</select>
								 -->
						    </td>
						  </tr>
						  <tr>
						    <th>휴대폰</th>
						    <td class="cellphone_input"><input type="text" name="" readonly="readonly"> - <input type="text" name="" readonly="readonly"> - <input type="text" name="" readonly="readonly"></td>
						    <th>이메일</th>
						    <td><input type="text" name="" readonly="readonly"></td>
						  </tr>
						</table>

						<table class="info_table_m">

							<tr>
							  <th>상담일시</th>
						      <td><input type="text" name=""></td>
							</tr>
							<tr>
							  <th>이름</th>
						      <td><input type="text" name="" readonly="readonly"></td>
							</tr>
							<tr>
							  <th>성별</th>
					      <td>
								<input type="radio" name=""> 남자
						    	<input type="radio" name=""> 여자
					      </td>
							</tr>							

							<tr>
							  <th>휴대폰</th>
						      <td class="cellphone_input"><input type="text" name="" readonly="readonly"> - <input type="text" name="" readonly="readonly"> - <input type="text" name="" readonly="readonly"></td>	 
							</tr>

							<tr>
							  <th>이메일</th>
						      <td><input type="text" name="" readonly="readonly"></td>
							</tr>

							<tr>
							  <th>상담 내용</th>
						      <td><input type="text" name=""></td>
							</tr>

						</table>

					</dd>
					<dd>
						<div class="master_agree_wrap">
							<div class="master_agree">
							<p>제 1 장 총 칙</p>

							<p>제 1 조 목적
								본 약관은 서비스 이용자가 주식회사 (이하 “회사”라 합니다)가 제공하는 온라인상의 인터넷 서비스(이하 “서비스”라고 하며, 접속 가능한 유∙
								류와는 상관없이 이용 가능한 회사가 제공하는 모든 서비스를 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 회사가 </p>
							</div>
							<div class="master_agree2">
									<!-- <input type="checkbox" name=""> -->
								<div class="check_box"></div>
								개인정보 처리방침 동의
								<span class="see_more sm1">전문보기 +</span>
							</div>
						</div>
						<input type="button" name="문의하기" class="confirms_btn" value="문의하기">
					</dd>
				</dl>
			</div>
		</div>
		<div class="master_contact">
			<dl>
				<dt>
						<p>자세한  내용을 알고 싶으시면  아래,</p> 
						<p>상담 신청으로 친절하게 설명을 받으실 수 있습니다.</p>
				</dt>
				<dd>빠른 상담 전화문의 : 02-3672-6900</dd>
			</dl>
		</div>
	</div>
</div>
<%@include file="../footer.jsp"%>

<div class="agree_pop_bk">

    <div class="agree_all agree_all_01">
      <div class="agree_all_txt">
        <p class="agree_title">제 1 장 총 칙</p>
        <p class="agree_text">
         제 1 조 목적<br>
         본 약관은 서비스 이용자가 주식회사 (이하 “회사”라 합니다)가 제공하는 온라인상의 인터넷 서비스(이하 “서비스”라고 하며, 접속 가능한 유∙류와는 상관없이 이용 가능한 회사가 제공하는 모든 서비스를 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 회사가
         본 약관은 서비스 이용자가 주식회사 (이하 “회사”라 합니다)가 제공하는 온라인상의 인터넷 서비스(이하 “서비스”라고 하며, 접속 가능한 유∙류와는 상관없이 이용 가능한 회사가 제공하는 모든 서비스를 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 회사가
         본 약관은 서비스 이용자가 주식회사 (이하 “회사”라 합니다)가 제공하는 온라인상의 인터넷 서비스(이하 “서비스”라고 하며, 접속 가능한 유∙류와는 상관없이 이용 가능한 회사가 제공하는 모든 서비스를 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 회사가
         본 약관은 서비스 이용자가 주식회사 (이하 “회사”라 합니다)가 제공하는 온라인상의 인터넷 서비스(이하 “서비스”라고 하며, 접속 가능한 유∙류와는 상관없이 이용 가능한 회사가 제공하는 모든 서비스를 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 회사가
         본 약관은 서비스 이용자가 주식회사 (이하 “회사”라 합니다)가 제공하는 온라인상의 인터넷 서비스(이하 “서비스”라고 하며, 접속 가능한 유∙류와는 상관없이 이용 가능한 회사가 제공하는 모든 서비스를 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 회사가
         본 약관은 서비스 이용자가 주식회사 (이하 “회사”라 합니다)가 제공하는 온라인상의 인터넷 서비스(이하 “서비스”라고 하며, 접속 가능한 유∙류와는 상관없이 이용 가능한 회사가 제공하는 모든 서비스를 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 회사가
         본 약관은 서비스 이용자가 주식회사 (이하 “회사”라 합니다)가 제공하는 온라인상의 인터넷 서비스(이하 “서비스”라고 하며, 접속 가능한 유∙류와는 상관없이 이용 가능한 회사가 제공하는 모든 서비스를 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 회사가
        </p>
      </div>
      <div class="btn_pop">확인</div>
    </div><!--agree_all-->

</div><!--agree_pop_bk-->
</body>
</html>