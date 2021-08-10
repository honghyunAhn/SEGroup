<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="adBannerWrapper swiper-container">
    <div class="adBannerWrap swiper-wrapper d-flex">
        <div class="adBanner swiper-slide">
            <a href="#">
                <img src="resources/segroup/society/smtp/img/banner_adImg01.jpg" alt="내가 들은 강의 자랑하고 선물 받자! 수강 후기 남기고 기프티콘 받아가세요!">
            </a>
        </div>
        <div class="adBanner swiper-slide">
            <a href="#">
                <img src="resources/segroup/society/smtp/img/banner_adImg02.jpg" alt="소프트엔지니어소사이어티 카카오톡 채널 OPEN! 카카오톡 채널 추가하고 10% 할인받고!">
            </a>
        </div>
    </div>
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
    <div class="swiper-pagination"></div>
</div>
<script>
     var swiper = new Swiper(".adBannerWrapper", {
    centeredSlides: true,
    autoplay: {
      delay: 4000,
      disableOnInteraction: false,
    },
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
    pagination: {
      el: ".swiper-pagination",
      clickable: true,
    },
  });
</script>