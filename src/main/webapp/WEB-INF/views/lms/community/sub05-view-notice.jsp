<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="description" content="다양한 전공과 ICT·AI를 융합하여 K-Digital 인재로 컬러링 해드립니다.">
    <meta name="keywords" content="해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Rainbow 레인보우</title>
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/reset.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper.min.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style_responsive.css">
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script_responsive.js"></script>
    <script type="text/javascript">
    
    	var board_content_seq = '${search.board_content_seq}';
    	var id = '${search.id}';
    	var detail;
    	
    	$(document).ready(function(){
    		setContent();
    	});
    	function setContent() {
    		if(board_content_seq !== undefined && board_content_seq != '') {
	    		$.ajax({
					contentType : "application/json",
					dataType : "json",
					url : "/smtp/community/noticeList",
					data: {"board_content_seq" : board_content_seq},
					async : false,
					success : function(result) {
						detail = result[0];
					}
				});
	    		$('div.post-title').html(detail.board_content_title);
	    		$('div.date').html(getDateFormat(detail.board_content_ins_dt));
	    		$('div.post-content').html(detail.board_content_ct);
	    		var content = '';
	    		if(detail.file.length != 0) {
	    			$.each(detail.file, function(index, item) {
	    				content += '<div style="padding-right=10px;">';
	    				content += '<a href="/file_download?origin=' + item.origin_file_name + '&saved=' + item.file_name + '&path=' + item.file_path.replace(item.file_name , '') + '">';
	    				content += '<b>' + item.origin_file_name + '</b>';
	    				content += '</a>';
	    				content += '</div>';
	    			});
	    		}
	    		$('div.file').append(content);
    		} else if(id !== undefined && id != '') {
    			$.ajax({
					contentType : "application/json",
					dataType : "json",
					url : "/smtp/community/courseNoticeList",
					data: {"id" : id},
					async : false,
					success : function(result) {
						detail = result[0];
					}
				});
    			$('div.post-title').html(detail.title);
    			var reg_date = detail.reg_date.substr(0,4) + '-' + detail.reg_date.substr(4,2) + '-' + detail.reg_date.substr(6,2);
	    		$('div.date').html(reg_date);
	    		$('div.post-content').html(detail.comment);
	    		var content = '';
	    		if(detail.file.length != 0) {
	    			$.each(detail.file, function(index, item) {
	    				content += '<div style="padding-right=10px;">';
	    				content += '<a href="/file_download?origin=' + item.origin_file_name + '&saved=' + item.file_name + '&path=' + item.file_path.replace(item.file_name , '') + '">';
	    				content += '<b>' + item.origin_file_name + '</b>';
	    				content += '</a>';
	    				content += '</div>';
	    			});
	    		}
	    		$('div.file').append(content);
    		}
    	}
    </script>
</head>

<body>
    <div class="container_rainbow rainbow_myClass">
        <div class="content sub-content content_myClsss view-post" id="main">
            <div class="section section_sub05-01">
                <header class="article-title">
                    <div class="titleBar-hdr h4">공지사항</div>
                </header>
                <form action="" id="" class="formStyle" method="post">
                    <div class="d-flex post-titleWrap">
                        <label class="label" for="post-title">제 목</label>
                        <div class="post-title">
                        </div>
                    </div>
                    <div class="d-flex">
                        <label class="label" for="date">등록일</label>
                        <div class="date"></div>
                    </div>
                    <div class="post-content">
                    </div>
                    <div class="d-flex file">
                    	<label class="label" for="date">첨부파일</label>
                    </div>
                </form>
                <!-- <div class="button-wrap d-flex">
                    <button type="button" class="btn_normal btn_default btn_xsmall prev-step">이전</button>
                    <button type="button" onclick="location.href='sub05-04.html'" class="button btn-pColor btn-list">글 목록</button>
                    <button type="button" class="btn_normal btn_default btn_xsmall next-step">다음</button>
                </div> -->
            </div>

        </div>
    </div>
</body>

</html>

<div class="sub-content view-post">
</div>
