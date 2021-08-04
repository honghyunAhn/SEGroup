// 2021 rainbow script_course-detail
window.onload = function () {

    // course-detail.html >> 모집마감일 d-day
    const count = document.querySelector(".course-applyWrap .courseCount");

    function courseCounter() {
        const today = new Date().getTime();
        const distance = dDay - today;
        const day = Math.floor(distance / (1000 * 60 * 60 * 24));
        const btn = document.getElementById("applyBtn");

        if (day >= 1) {
            count.innerHTML = "모집 마감 ⏰ D-" + day;
        } else if (day >= 0 && day <= 1) {
            setInterval(countTime, 1000)
        } else if (day <= -1) {
            count.innerHTML = "모집 기간이 종료되었습니다."
            btn.disable = true
            if (btn.disable == true) {
                btn.style.filter = 'grayscale(100%)'
                btn.style.cursor = 'not-allowed'
            }
            clearInterval(countTime)
        }

        // 모집마감일 타이머 설정
        function countTime() {
            var today = new Date().getTime();
            var distance = dDay - today;
            var hour = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var min = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            var sec = Math.floor((distance % (1000 * 60)) / 1000);
            if (day >= 0 && day <= 1) {
                count.innerHTML = "마감 임박 ⏰ " + hour + "시간 " + min + "분 " + sec + "초 후 종료됩니다.";
            }
        }
    }
    courseCounter();

    // course-detail.html >> scroll event
    const bannerHeight = document.querySelector(".mainBackVideoWrap .background_video").offsetHeight;
    const menuHeight = document.querySelector(".detail-menuWrapper").offsetHeight;

    // course-detail.html >> scroll event >> 과정 상세 메뉴 최상단 고정
    document.addEventListener('scroll', function () {
        const scroll = document.documentElement.scrollTop;
        const titleWrap = document.getElementById("scrollFixed01");
        const menuWrap = document.getElementById("scrollFixed02");
        const applyWrap = document.getElementById("scrollFixed03");
        const nav = document.getElementById("header");

        if (scroll > 500) {
            titleWrap.classList.add("scrollFixed")
            menuWrap.classList.add("scrollFixed")
            applyWrap.classList.add("scrollFixed")
            nav.classList.add("noneScroll")
        } else {
            titleWrap.classList.remove("scrollFixed")
            menuWrap.classList.remove("scrollFixed")
            applyWrap.classList.remove("scrollFixed")
            nav.classList.remove("scrollFixed")
        }

        // side 수강신청 bar -> fixed
        const detailWrap = document.querySelector(".course-detailWrap").offsetHeight;
        const detailHeight = detailWrap - menuHeight - bannerHeight;

        if (scroll >= detailHeight || scroll >= detailWrap) {
            applyWrap.classList.add("scrollSticky")
        } else {
            applyWrap.classList.remove("scrollSticky")
        }
    });

    // course-detail.html >> scroll event >> 스크롤 시 해당 구간 메뉴 active
    const sections = document.querySelectorAll('.courseSectionWrap')
    const links = document.querySelectorAll('.detail-menuWrap .detailMenu')

    function changeLinkState() {
        let index = sections.length;
        const hideHegiht = bannerHeight - menuHeight - 60
        while (--index && window.scrollY - hideHegiht < sections[index].offsetTop) {}

        links.forEach((link) => link.classList.remove('active'));
        links[index].classList.add('active');
    }
    changeLinkState();
    document.addEventListener('scroll', changeLinkState);

    // course-detail.html >> scroll event >> 메뉴 클릭 시 해당 구간으로 이동 및 active
    links.forEach(function (menu) {
        const sectionId = menu.getAttribute("data-link")
        const location = document.querySelector(sectionId).offsetTop;

        // 해당 구간으로 이동
        function moveSection() {
            window.scrollTo({
                top: location + bannerHeight - menuHeight - 60,
                behavior: 'smooth'
            });
        }
        // active 클래스 추가
        function activeEvent() {
            if (!menu.classList.contains('active')) {
                clearActive(links);
                menu.classList.toggle('active');
            }
        }
        // active 클래스 제거
        function clearActive(links) {
            if (links) {
                for (var i = 0; i < links.length; i++) {
                    links[i].classList.remove('active');
                }
            }
        }
        menu.addEventListener("click", moveSection);
        menu.addEventListener("click", activeEvent);
    })


    // course-detail.html >> more review
    const noneReview = document.getElementById("noneReview");
    const moreButton = document.getElementById("moreReview");
    const reviewEl = document.getElementsByClassName('course-review');
    const reviewWrap = document.querySelector('.course-reviewWrap');
    const reviewLength = reviewEl.length;
    if (reviewLength === 0) {
        // 과정 후기 0일 때 메세지 출력, 
        noneReview.style.display = "block";
    } else if (reviewLength >= 3) {
        // 3이상일 때 더보기 버튼 생성 및 3개 이상의 리뷰 숨기기
        for (let i = 3; i < reviewLength; i++) {
            reviewEl[i].style.display = 'none';
        }
        moreButton.style.display = "block";
    }

    // 과정후기 더보기 버튼 클릭 시 모든 후기 보기
    function moreReviewToggle() {
        for (let i = 3; i < reviewLength; i++) {
            if (reviewEl[i].style.display === 'flex' || reviewEl[i].style.display === 'block') {
                reviewEl[i].style.display = 'none';
                moreReview.innerHTML = '과정 후기 더 보기'
                if (reviewLength >= 7) reviewWrap.classList.remove('scrollY')
            } else {
                if (matchMedia("screen and (max-width: 590px)").matches) {
                    reviewEl[i].style.display = 'block';
                }else{
                    reviewEl[i].style.display = 'flex';
                }
                moreReview.innerHTML = '과정 후기 접기'
                if (reviewLength >= 7) reviewWrap.classList.add('scrollY')
            }
        }
    }
    moreButton.addEventListener("click", moreReviewToggle);

    // course-detail.html >> FAQ
    const slideTarget = document.querySelectorAll(".faq");
    const hideTarget = document.querySelectorAll(".answerWrap");
    const toggleTarget = document.querySelectorAll('.angle-down');
    slideTarget.forEach(function (question) {
        function slideEvent() {
            const answer = this.querySelector('.answerWrap')
            const icon = this.querySelector('.img-icon')
            if (!answer.classList.contains('show')) {
                toggleIcon(toggleTarget)
                icon.classList.toggle('angle-up')

                hideAnswer(hideTarget)
                answer.classList.toggle('show');
            } else {
                answer.classList.remove('show');
                icon.classList.remove('angle-up')
            }

            // FAQ 질문 클릭 시, 전체 답변 숨기기
            function hideAnswer(hideTarget) {
                if (hideTarget) {
                    for (var i = 0; i < hideTarget.length; i++) {
                        hideTarget[i].classList.remove('show');
                    }
                }
            }

            // FAQ 질문 클릭 시, 아이콘 변경하기
            function toggleIcon(toggleTarget) {
                if (toggleTarget) {
                    for (var i = 0; i < toggleTarget.length; i++) {
                        toggleTarget[i].classList.remove('angle-up');
                    }
                }
            }
        }
        question.addEventListener("click", slideEvent);
    })
}