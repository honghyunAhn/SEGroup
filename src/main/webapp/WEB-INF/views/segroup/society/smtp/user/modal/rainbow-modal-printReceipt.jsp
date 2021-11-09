<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<script type="text/javascript">
    function printWindow() {
    	
    	const html = document.querySelector('html');
    	const printContents = document.querySelector('#test').innerHTML;
    	const printDiv = document.createElement('DIV');
    	
    	html.appendChild(printDiv);
    	printDiv.innerHTML = printContents;
    	document.body.style.display = 'none';
    	window.print();
    	document.body.style.display = 'block';
    	printDiv.style.display = 'none'; 

    }


    var afterPrint = function() {
    	var course_id = $(':hidden[name="m_course_id"]').val();
    	var cardinal_id = $(':hidden[name="m_cardinal_id"]').val();
    	var receipt_num = $(':hidden[name="receiptNum"]').val();
    	var receipt_date = $(':hidden[name="receiptDate"]').val();
    	
    	//프린트 후 일련번호 저장
    	$.ajax({
    			type	: "post",
    			url		: "/lms/user/insert_receipt",
    			data    : {
    						'course_id' : course_id
    						,'cardinal_id' : cardinal_id
    						,'receipt_num' : receipt_num
    						,'receipt_date' : receipt_date
    					  },
    			success	: function() {

    			},
    			error : function (request, status, error) {
    					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
    			}
    		});
    };

    window.onafterprint = afterPrint;
    </script>
    <div class="modal">
        <div class="sub-content modal-content course-point05" id="main">
            <div class="modal-header d-flex justify_between">
                <h3 class="h3">영수증 출력하기</h3>
                <div class="img-icon times close-modal"></div>
            </div>
            <div class="section" id="test">
            <table class="modal-table">
                <thead class="table-title thead">
                    <tr>
                    	<!-- receiptNum : count 영수증 번호
                             receiptTo : 공급 받는자
                             receiptDate : 작성일
                             receiptValue : 공급가액
                             receiptTax : 세액
                             receiptItemList : 품목
                             receiptItemPrice : 단가
                             receiptItemAmount : 수량
                             receiptItemValue : 공급대가 -->
                        <th class="receiptNum" colspan="2">영수증 번호</th>
                        <th colspan="7">영 수 증 (공급받는자용)</th>
                        <th colspan="4" class="receiptTo user_nm"><span>고객명</span>&nbsp;귀하</th>
                    </tr>
                </thead>
                <tbody class="table-list tbody">
                    <input type="hidden" name="receiptDate" value="">
                    <input type="hidden" name="receiptNum" value="">
                    <input type="hidden" name="m_course_id" value="">
                    <input type="hidden" name="m_cardinal_id" value="">
                    <tr>
                        <th rowspan="3">공<br>급<br>자</th>
                        <th>등록번호</th>
                        <td>468-81-00409</td>
                        <th>상호</th>
                        <td colspan="9">소프트엔지니어소사이어티 (Soft Engineer Society)</td>
                    </tr>
                    <tr>
                        <th>대 표 자</th>
                        <td>김치중</td>
                        <th>사업장주소</th>
                        <td colspan="9" class="positionImg">
                            서울시 강남구 영동대로 513, 4층 017-1호 (삼성동, 코엑스)
                            <img src="/resources/segroup/society/smtp/img/stamp.png" alt="도장" class="stampImg">
                        </td>
                    </tr>
                    <tr>
                        <th>업 태</th>
                        <td>서비스</td>
                        <th>종 목</th>
                        <td colspan="9">소프트웨어 개발, 제조 및 판매업</td>
                    </tr>
                    <tr>
                        <th colspan="4">작 성 일</th>
                        <th colspan="8">단 가</th>
                        <th>비 고</th>
                    </tr>
                    <tr class="receipt_price">
                        <td class="receiptDate" colspan="4" rowspan="2">YYYY-MM-DD</td>
                        <td>천</td>
                        <td>백</td>
                        <td>십</td>
                        <td>만</td>
                        <td>천</td>
                        <td>백</td>
                        <td>십</td>
                        <td>일</td>
                        <td rowspan="2">-</td>
                    </tr>
                    <tr class="priceIdx receipt_price">
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <th colspan="4">품 목</th>
                        <th colspan="9">단 가</th>
                    </tr>
                    <tr>
                        <td class="receiptItemList" colspan="4">과정명</td>
                        <td class="receiptItemPrice" colspan="9">단가</td>
                    </tr>
                    <tr>
                        <th colspan="13">위 금액을 영수(청구)함</th>
                    </tr>
                </tbody>
            </table>
            </div>
            <div class="section_btnWrap d-flex justify_center">
                <button class="btn_normal btn_xlarge bgc_point" type="button"
                onclick="printWindow()">출력하기</button>
            </div>
        </div>
    </div>
