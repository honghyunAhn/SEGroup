<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="fullBannerWrapper swiper-container">
    <div class="swiper-wrapper fullBannerWrap d-flex">
        <div class="swiper-slide fullBanner">
            <a href="">
                <img src="resources/segroup/society/smtp/img/fullBanner01.jpg" alt="일본취업 필수과정 일본취업을 위한 JPT&JLPT 바로가기">
            </a>
        </div>

        <div class="swiper-slide fullBanner">
            <a href="https://www.softsociety.net/lms/main">
                <img src="resources/segroup/society/smtp/img/fullBanner02.jpg" alt="나에게 맞는 강의가 궁금하다면? We can do it! 두잇캠퍼스 바로가기">
            </a>
        </div>
        <div class="swiper-slide fullBanner">
            <a href="">
                <img src="resources/segroup/society/smtp/img/fullBanner03.jpg" alt="레인보우 교육일정 안내 2021 연간 교육 일정 바로가기">
            </a>
        </div>
        <div class="swiper-slide fullBanner">
            <a href="https://blog.naver.com/scitmaster">
                <img src="resources/segroup/society/smtp/img/fullBanner04.jpg" alt="해외취업의 모든 것 NAVER 블로그 바로가기">
            </a>
        </div>
        <div class="swiper-slide fullBanner">
            <a href="https://www.youtube.com/channel/UCCsiCEQ8g6PacQLuJEYEWpw?view_as=subscriber">
                <img src="resources/segroup/society/smtp/img/fullBanner05.jpg" alt="해외취업의 모든 것 YouTube 채널 바로가기">
            </a>
        </div>
    </div>
    <div class="swiper-pagination swiper-pagination-clickable swiper-pagination-bullets"></div>
</div>

<script>
    var swiper = new Swiper(".fullBannerWrapper", {
    slidesPerView: 1,
    spaceBetween: 10,
    normalizeSlideIndex: true,
    breakpointsInverse: true,
    breakpoints: {
      320: {
        slidesPerView: 1,
        spaceBetween: 10,
      },
      640: {
        slidesPerView: 2,
        spaceBetween: 10,
      },
      768: {
        slidesPerView: 3,
        spaceBetween: 10,
      },
      1024: {
        slidesPerView: 4,
        spaceBetween: 10,
      },
      1200: {
        slidesPerView: 5,
        spaceBetween: 10,
      },
    },
    autoplay: {
      delay: 4000,
      disableOnInteraction: false,
    },
    pagination: {
      el: ".swiper-pagination",
      clickable: true,
    },
  });
</script>