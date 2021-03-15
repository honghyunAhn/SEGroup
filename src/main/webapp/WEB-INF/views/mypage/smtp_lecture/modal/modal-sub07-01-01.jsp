<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<body>

    <div class="sub-content modal-content">
        <div class="header">
            <div class="titleBar h3 classTitle">설문 조사</div>
            <!-- <h3 class="h3"></h3> -->
            <div class="img-icon times close-modal"></div>
        </div>
        <!-- <div class="modal-sectionWrap"> -->
        <div class="section section-margin modal-sub07-01 sub07-01 sub07-01-01">
            <!-- 학습현황 탭 -->
            <div class="class-tabMenu">
                <!-- 내용이 많아 스크롤이 필요할 경우 modal-sectionWrap클래스 활성화할 것 -->
                <div class="modal-subGroup subGroup modal-ovflowY">
                    <div class="tab-sub sub01">
                        
                         <div class="statusWrap modal-sectionWrap" id="modal_title">
                            </div>
                        <div class="completionWrap modal-sectionWrap" id="modal_content">
                        	
                        	

                        </div>
                    </div>
                    <!-- player submit form -->
					<form id="chapterForm" name="chapterForm">
						<input type="hidden" name="id" id="id" value="">
						<input type="hidden" name="cardinal" id="cardinal" value="">
						<input type="hidden" name="course" id="course" value="">
						<input type="hidden" name="chapter" id="chapter" value="">
					</form>
					
					





                </div>
            </div>
        </div>
        <!-- </div> -->
       <!--  <div class="button-wrap d-flex">
            <button class="button btn-myClass" type="button">학습시작</button>
        </div> -->
    </div>

</body>

</html>
