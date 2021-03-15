<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, target-densitydpi=medium-dpi " />
<meta name="format-detection" content="telephone=no">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script
	src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<head>
<title></title>
<script
	src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link
	href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<style>
@media screen and (max-width: 750px) {
	/*sub_gallary개별 스타일*/
	.gallary_thumb {
		width: 750px;
	}
	.gallary_thumb li.gallary_thum_c {
		float: none;
		width: 312px;
		margin: 0 auto 35px;
	}
	.gallary_thumb>ul:last-child>li:last-child {
		margin-bottom: 0px;
	}
	.gallary_thum_c dl .gal_picture {
		width: 304px;
	}
}
</style>

    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="/resources/segroup/society/edu/js/jquery-tjgallery.min.js"></script>
<script>
	$(function() {

		// waiting for loading page
		$(window).load(function() {
			$('.pictures').tjGallery({
				selector : '.item',
				margin : 10,
                row_min_height  : 300 // 높이 설정
			});
		})

		// call desrtoy
		$('#destroy').click(function() {
			$('.pictures').tjGallery('destroy');
			$('#destroy').hide();
		});

	})
</script>
<style>
body {
	margin: 0px;
	padding: 20px;
	font-size: 14px;
	font-family: 'Roboto', Arial, Helvetica, sans-serif;
	background: #fafafa;
}

.pictures {
	font-size: 0px;
}

.pictures .item {
	position: relative;
	display: inline-block;
}

.pictures .item img {
	position: relative;
	z-index: 11;
}

.pictures .item .item_description {
	position: absolute;
	z-index: 10;
	left: -15px;
	top: -15px;
	right: -15px;
	bottom: -60px;
	-webkit-box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.4);
	-moz-box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.4);
	box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.4);
	background: #151515;
	padding: 15px;
	display: none;
}

.pictures .item .item_description span {
	color: #ffffff;
	font-size: 13px;
	display: block;
	position: absolute;
	bottom: 15px;
	height: 30px;
}

.pictures .item:hover {
	z-index: 100;
}

.pictures .tjGalleryItem .item:hover .item_description {
	display: block;
}
</style>


</head>
<body>
	<%@include file="../menu.jsp"%>

<div class="pictures">
      <div class="item">
    <div class="item_description"><span>Lorem Ipsum is simply dummy text</span></div>
    <img src="/resources/segroup/society/edu/image/main/main_menu_thumb1.jpg" alt="" /></div>
      <div class="item">
    <div class="item_description"><span>Lorem Ipsum is simply dummy text</span></div>
    <img src="/resources/segroup/society/edu/image/main/main_menu_thumb2.jpg" alt="" /></div>
      <div class="item">
    <div class="item_description"><span>Lorem Ipsum is simply dummy text</span></div>
    <img src="/resources/segroup/society/edu/image/main/main_menu_thumb3.jpg" alt="" /></div>
      <div class="item">
    <div class="item_description"><span>Lorem Ipsum is simply dummy text</span></div>
    <img src="/resources/segroup/society/edu/image/main/knowhow1.jpg" alt="" /></div>
      <div class="item">
    <div class="item_description"><span>Lorem Ipsum is simply dummy text</span></div>
    <img src="/resources/segroup/society/edu/image/main/knowhow2.jpg" alt="" /></div>
      <div class="item">
    <div class="item_description"><span>Lorem Ipsum is simply dummy text</span></div>
    <img src="/resources/segroup/society/edu/image/main/knowhow3.jpg" alt="" /></div>
      <div class="item">
    <div class="item_description"><span>Lorem Ipsum is simply dummy text</span></div>
    <img src="/resources/segroup/society/edu/image/main/knowhow4.jpg" alt="" /></div>
      <div class="item">
    <div class="item_description"><span>Lorem Ipsum is simply dummy text</span></div>
    <img src="/resources/segroup/society/edu/image/main/main_menu_thumb1.jpg" alt="" /></div>
      <div class="item">
    <div class="item_description"><span>Lorem Ipsum is simply dummy text</span></div>
    <img src="/resources/segroup/society/edu/image/main/main_menu_thumb2.jpg" alt="" /></div>
      <div class="item">
    <div class="item_description"><span>Lorem Ipsum is simply dummy text</span></div>
    <img src="/resources/segroup/society/edu/image/main/main_menu_thumb3.jpg" alt="" /></div>
      <div class="item">
    <div class="item_description"><span>Lorem Ipsum is simply dummy text</span></div>
    <img src="/resources/segroup/society/edu/image/main/knowhow1.jpg" alt="" /></div>
    </div>

    
	<div class="sub_m_contents">
		<div class="master_bottom_menu">
			<ul>
				<li class="choice_menu mbm1">갤러리1</li>
				<li class="mbm2">갤러리2</li>
				<li class="mbm3">갤러리3</li>
				<li class="mbm4">갤러리4</li>
				<li class="mbm5">갤러리5</li>
				<li class="mbm6">갤러리6</li>
			</ul>
		</div>
		<div class="gallary_thumb">
			<ul>
				<li class="gallary_thum_c">
					<dl>
						<dt class="gal_picture">
							<div class="picture_con"></div>
						</dt>
						<dd>
							<ul>
								<li>Title</li>
								<li>작성자 17-09-30</li>
								<li>조회수 200</li>
							</ul>
						</dd>
					</dl>
				</li>
				<li class="gallary_thum_c">
					<dl>
						<dt class="gal_picture">
							<div class="picture_con"></div>
						</dt>
						<dd>
							<ul>
								<li>Title</li>
								<li>작성자 17-09-30</li>
								<li>조회수 200</li>
							</ul>
						</dd>
					</dl>
				</li>
				<li class="gallary_thum_c">
					<dl>
						<dt class="gal_picture">
							<div class="picture_con"></div>
						</dt>
						<dd>
							<ul>
								<li>Title</li>
								<li>작성자 17-09-30</li>
								<li>조회수 200</li>
							</ul>
						</dd>
					</dl>
				</li>
			</ul>
			<ul>
				<li class="gallary_thum_c">
					<dl>
						<dt class="gal_picture">
							<div class="picture_con"></div>
						</dt>
						<dd>
							<ul>
								<li>Title</li>
								<li>작성자 17-09-30</li>
								<li>조회수 200</li>
							</ul>
						</dd>
					</dl>
				</li>
				<li class="gallary_thum_c">
					<dl>
						<dt class="gal_picture">
							<div class="picture_con"></div>
						</dt>
						<dd>
							<ul>
								<li>Title</li>
								<li>작성자 17-09-30</li>
								<li>조회수 200</li>
							</ul>
						</dd>
					</dl>
				</li>
				<li class="gallary_thum_c">
					<dl>
						<dt class="gal_picture">
							<div class="picture_con"></div>
						</dt>
						<dd>
							<ul>
								<li>Title</li>
								<li>작성자 17-09-30</li>
								<li>조회수 200</li>
							</ul>
						</dd>
					</dl>
				</li>
			</ul>
			<ul>
				<li class="gallary_thum_c">
					<dl>
						<dt class="gal_picture">
							<div class="picture_con"></div>
						</dt>
						<dd>
							<ul>
								<li>Title</li>
								<li>작성자 17-09-30</li>
								<li>조회수 200</li>
							</ul>
						</dd>
					</dl>
				</li>
				<li class="gallary_thum_c">
					<dl>
						<dt class="gal_picture">
							<div class="picture_con"></div>
						</dt>
						<dd>
							<ul>
								<li>Title</li>
								<li>작성자 17-09-30</li>
								<li>조회수 200</li>
							</ul>
						</dd>
					</dl>
				</li>
				<li class="gallary_thum_c">
					<dl>
						<dt class="gal_picture">
							<div class="picture_con"></div>
						</dt>
						<dd>
							<ul>
								<li>Title</li>
								<li>작성자 17-09-30</li>
								<li>조회수 200</li>
							</ul>
						</dd>
					</dl>
				</li>
			</ul>
		</div>
		<div class="pagination_wrap">
			<div class="pagination_con">
				<ul>
					<li><span> <input type="button" value="<<">
					</span> <span> <input type="button" value="<">
					</span></li>
					<li class="pagn_center">
						<ol>
							<li><input type="button" name="" value="1"></li>
							<li><input type="button" name="" value="2"></li>
							<li><input type="button" name="" value="3"></li>
							<li><input type="button" name="" value="4"></li>
							<li><input type="button" name="" value="5"></li>
							<li><input type="button" name="" value="6"></li>
							<li><input type="button" name="" value="7"></li>
							<li><input type="button" name="" value="8"></li>
							<li><input type="button" name="" value="9"></li>
							<li><input type="button" name="" value="10"></li>
						</ol>
					</li>
					<li><span> <input type="button" value=">>">
					</span> <span> <input type="button" value=">">
					</span></li>
				</ul>
			</div>
		</div>
		<div class="gal_last">
			<div class="gal_search">
				<input type="search" name="" value=""> <input type="image"
					name=""
					src="<c:url value="/resources/segroup/society/edu/image/sub/btn_searchs.png" />">
			</div>
			<div class="gal_write">
				<input type="button" name="" value="글쓰기">
			</div>
		</div>
	</div>

	<%@include file="../footer.jsp"%>
</body>
</html>