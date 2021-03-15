// user_02_myPage_script.js
$(function() {
    // FullCalendar
    // 증빙자료 버튼 생성
//    var makeBtn = $('.fc-daygrid-day-events').after('<div class="uploadWrap"><input type="file" class="uploadBtn" id="uploadBtn"><label for="uploadBtn">증빙자료</label></div>');
//
//    $('.uploadWrap').hide();
//    $(window).ready(function() {
//        // 지각 증빙자료 첨부 버튼
//        $('.fc-event-title.fc-sticky:contains("지각")').parents('.fc-daygrid-day-events').next('.uploadWrap').show();
//        // 결석 증빙자료 첨부 버튼
//        $('.fc-event-title.fc-sticky:contains("결석")').parents('.fc-daygrid-day-events').next('.uploadWrap').show();
//        // 조퇴 증빙자료 첨부 버튼
//        $('.fc-event-title.fc-sticky:contains("조퇴")').parents('.fc-daygrid-day-events').next('.uploadWrap').show();
//    });
//     var txt = $('.fc-event-title.fc-sticky').text();
//     if(txt.match('지각')){
//         $('.fc-event-title.fc-sticky').css("color","red");
//     }
    // 성적관리 tabTableWrlap
    var i = 0;
    $('.tabTableWrap>.tabGroup>li').click(function() {
        var $tab = $(this).parent().children();
        var $sub = $(this).parent().next('.subGroup').children();
        i = $(this).index();
        $tab.removeClass('active');
        $(this).addClass('active');
        $sub.hide();
        $sub.eq(i).show();
    });
    // 성적관리 tabTableWrlap 끝
    
 // 20-08-28 성적 점수 환산 추가
    // 테이블의 과목별 점수는 그래프에서 값 도출
    // .score_ICT : ICT점수
    // .score_JP : 일본어점수
    // .score_BS : basic점수

    // .score_per : 배점비율
    // .score_exc : 환산점수
    // .score_grd : 등급
    // .score_total : 종합점수
    // .score__exc_total : 환산점수 합계

/*    var score1 = 0,
        score2 = 0,
        score3 = 0,
        score4 = 0,
        calExc = 0,
        sum = 0;
    function tableCal() {
        $('tr.score_cal').each(function() {
            // 과목별 점수 및 배점비율 가져오기
            score1 = $(this).find('.score1').text();
            score2 = $(this).find('.score2').text();
            // 계산된 환산점수 적용하기
            calExc = parseFloat(score1) * score2 / 100;
            $(this).find('.score3').text(calExc);
        });

        // 과목별 환산점수 합계 구하기
        $('.sum').each(function(){
            var v1=0,v2=0,v3=0;
            v1 =  $(this).parents('tbody').find('tr.score_cal').eq(0).find('.score3').html();
            v2 =  $(this).parents('tbody').find('tr.score_cal').eq(1).find('.score3').html();
            v3 =  $(this).parents('tbody').find('tr.score_cal').eq(2).find('.score3').html();
            sum = parseFloat(v1) + parseFloat(v2) + parseFloat(v3);
            console.log(sum);
            $(this).html(sum);
        });
        // 점수별 등급 적용하기
    }
    tableCal();
    // 성적 점수 환산 끝
*/});
