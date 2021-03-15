<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE html>
<html lang="ko">

<body>
    <div class="sub-content">
        <div class="header">
            <div class="titleBar h3">수강신청</div>
            <!-- <h3 class="h3"></h3> -->
            <div class="img-icon times close-modal"></div>
        </div>
        <!-- processWrap : 다음단계로 넘어갈 때 .addClass('.active')됩니다. -->
        <ul class="processWrap d-flex">
            <li class="process"><span class="margin-right10 h5 fc_orD">01</span>수강신청</li>
            <li class="process active"><span class="margin-right10 h5 fc_orD">02</span>환불규정</li>
            <li class="process"><span class="margin-right10 h5 fc_orD">03</span>결제방법</li>
            <li class="process"><span class="margin-right10 h5 fc_orD">04</span>결제</li>
        </ul>
        <div class="modal-sectionWrap">
            <header class="article-title">
                <div class="titleBar-hdr">수강취소 및 환불 관련 규정 2222</div>
            </header>
            <div class="section modal-sub02-01-02">
                <ul>
                    <li>
                        개강 이후 총 수업시간의 50% 초과 경과시에는 수강취소 및 환불이 불가함
                    </li>
                    <li>
                        개강 이전 및 개강 후 수업시간의 50% 이하 경과시에는 아래 절차 및 규정에 따라 수강취소 및 환불 가능함.
                    </li>
                </ul>
                <dl class="cancel-rule">
                    <dt class="rule-ttl fz16">수강취소 절차</dt>
                    <dd class="rule-ctt">
                        <strong>1) 홈페이지 ‘나의강의실’ 에서 해당 과정을 선택한 후, 환불신청서를 작성.</strong>
                    </dd>
                </dl>
                <dl class="cancel-rule">
                    <dt class="rule-ttl fz16">환불규정</dt>
                    <dd class="rule-ctt">
                        <strong>1) 무통장입금(가상계좌)의 경우</strong>
                        <p class="c999">
                            <strong class="c666">- 개강일전 취소 時 </strong>
                            : 가상계좌 이용수수료를 제외한 전액환불
                            <br>환불액 = 납입수강료 – 가상계좌 이용수수료(330원)
                        </p>
                        <p class="c999">
                            <strong class="c666">- 개강 이후 취소 時 </strong>: 수강취소 위약금과 수업경과일수에 해당하는 수강료 일할 공제 후 잔여금액 환불
                            <br>환불액 = 납입수강료 – 위약금(수강료의 10%) – 일할 공제금액
                            <br>(납입수강료 × 수업경과일수/총 수업일수)
                        </p>

                        <strong>2) 카드결제의 경우</strong>
                        <p class="c999">
                            <strong class="c666">- 개강일전 취소 時 </strong>: 전액환불<br>환불액 = 납입수강료 전액
                        </p>
                        <p class="c999">
                            <strong class="c666">- 개강 이후 취소 時 </strong>: 수강취소 위약금과 수업경과일수에 해당하는 수강료 일할 공제 후 잔여금액 환불
                            <br>환불액 = 납입수강료 – 위약금(수강료의 10%) – 일할 공제금액
                            <br>(납입수강료 × 수업경과일수/총 수업일수)
                        </p>
                    </dd>
                </dl>
                <ul>
                    <li>
                        가상계좌 이용수수료 및 신용카드 이용수수료는 카드회사 및 결제대행사와의 계약내용변화에 따라 사전 공지 없이 변경될 수 있습니다.
                    </li>
                    <li>
                        카드결제시 영수증은 이니시스 홈페이지에서 가능 <a class="d-inline h5" href="http://www.inicis.com" target="_blank">( http://www.inicis.com )</a>
                    </li>
                    <li>
                        가상계좌 입금시 계산서신청과 영수증출력은 나의강의실-계산서 및 환급서류 페이지에서 가능
                    </li>
                </ul>
            </div>
            <form class="checkWrap">
                <label>
                    <input type="checkbox" class="check input" name="agree01">
                    위 내용에 동의합니다.
                </label>
            </form>

        </div>
        <div class="button-wrap d-flex">
            <button class="button btn-wh btn-prev prev-step" type="button">이전</button>
            <button class="btn_point btn_xsmall btn_normal btn-next next-step2" type="button">다음</button>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function() {
            //모달 닫기 - 다음/이전 단계 넘어갈 시 load로 불러오니 닫기 버튼 안눌렸음 그래서 임시로 넣어둠
            $('.modal .close-modal').click(function() {
                $('html, body').removeClass("not-scroll");
                $('.modal').hide();
            });
            $('.prev-step').click(function() {
                $('.modal-content').load('modal/modal-sub02-01-01');
            });
            // 다음단계 버튼 클릭
            $('.next-step').click(function() {
                $('.modal-content').load('modal/modal-sub02-01-03');
            });
        });
    </script>
</body>

</html>
