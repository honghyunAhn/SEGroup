<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp" %>
    <script class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js">
    </script>
</head>

<body>
    <!-- community - 05. 오시는 길 -->
    <div class="container_rainbow">
    	<%@include file="../include/rainbow_header.jsp" %>
        <div class="content course-point04" id="main">
            <div class="sub-content community01-01">
                <div class="section_header">
                    <h3 class="h3">🚗 오시는 길</h3>
                </div>
                <div class="section_map">
                    <ul class="map_headerWrap d-flex">
                        <li class="map_header h3 active">
                            <a tab="#tab1">서울센터</a>
                        </li>
                        <li class="map_header h3">
                            <a tab="#tab2">광주센터</a>
                        </li>
                        <li class="map_header h3">
                            <a tab="#tab3">부산센터</a>
                        </li>
                    </ul>
                    <ul class="map_bodyWrap">
                        <!-- 서울센터 -->
                        <li id="tab1" class="map_body">
                            <p class="fc_999">
                                06164 서울특별시 강남구 영동대로 513(삼성동, 코엑스)4층 ICT센터
                            </p>
                            <div class="map">
                                <div id="daumRoughmapContainer1629445244605"
                                    class="root_daum_roughmap root_daum_roughmap_landing"></div>
                            </div>
                            <div class="map_wayWrap">
                                <div class="map_way">
                                    <div class="d-flex map-way-hdr">
                                        <div class="img-icon bus"></div>
                                        <div class="margin-left5">
                                            <strong>버스 이용고객</strong>
                                            <span class="fc_999">코엑스 동문 앞 (2398 정류장)</span>
                                        </div>
                                    </div>
                                    <ul class="way margin-top5">
                                        <li>
                                            간선버스&nbsp;
                                            <span style="color:darkblue">146, 301, 401, 342, 362, N61(심야)</span>
                                        </li>
                                        <li>
                                            간선버스&nbsp;
                                            <span style="color:firebrick">9407, 9414, 9607, 500-2</span>
                                        </li>
                                        <li>
                                            지선버스&nbsp;
                                            <span style="color:darkgreen">2415, 3217, 3411, 3412, 3414,
                                                4318</span>
                                        </li>
                                        <li>
                                            공항리무진&nbsp;
                                            <span style="color:darkorange">6006</span>
                                        </li>
                                        <li>
                                            마을버스&nbsp;
                                            <span style="color:forestgreen">강남08</span>
                                        </li>
                                    </ul>
                                </div>
                                <div class="map_way">
                                    <div class="d-flex map-way-hdr">
                                        <div class="img-icon subway"></div>
                                        <div class="margin-left5">
                                            <strong>지하철 이용고객</strong>
                                        </div>
                                    </div>
                                    <ul class="way margin-top5">
                                        <li>
                                            지하철&nbsp;
                                            <span style="color:forestgreen">2호선 삼성역 </span>EXIT 6
                                        </li>
                                        <li>
                                            지하철&nbsp;
                                            <span style="color:darkgoldenrod">9호선 봉은사역 </span>EXIT 7
                                        </li>
                                    </ul>
                                </div>
                                <div class="map_way">
                                    <div class="d-flex map-way-hdr">
                                        <div class="img-icon car"></div>
                                        <div class="margin-left5">
                                            <strong>자가용 이용고객</strong>
                                            <span class="fc_999">(주차비 미지원)</span>
                                        </div>
                                    </div>
                                    <ul class="way">
                                        <li>코엑스 옥상 주차장 - 코엑스 서문(EAST GATE)</li>
                                        <li>E20 엘리베이터 탑승 - 4F으로 이동</li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                        <!-- 광주센터 -->

                        <li id="tab2" class="map_body">
                            <p class="fc_999">
                                62364 광주광역시 광산구 무진대로 282 광주무역회관 7F
                            </p>
                            <div class="map">
                                <div id="daumRoughmapContainer1629445358123"
                                    class="root_daum_roughmap root_daum_roughmap_landing"></div>
                            </div>

                            <div class="map_wayWrap">
                                <div class="map_way">
                                    <div class="d-flex map-way-hdr">
                                        <div class="img-icon bus"></div>
                                        <div class="margin-left5">
                                            <strong>버스 이용고객</strong>
                                        </div>
                                    </div>
                                    <ul class="way margin-top5">
                                        <li>
                                            간선버스&nbsp;
                                            <span style="color:darkblue">문흥18, 첨단20, 송정29, 봉선37, 첨단40</span>
                                        </li>
                                        <li>
                                            지선버스&nbsp;
                                            <span style="color:darkgreen">송정98</span>
                                        </li>
                                        <li>
                                            마을버스&nbsp;
                                            <span style="color:forestgreen">700, 720, 750</span>
                                        </li>
                                    </ul>
                                </div>
                                <div class="map_way">
                                    <div class="d-flex map-way-hdr">
                                        <div class="img-icon subway"></div>
                                        <div class="margin-left5">
                                            <strong>지하철 이용고객</strong>
                                        </div>
                                    </div>
                                    <ul class="way margin-top5">
                                        <li>
                                            지하철&nbsp;
                                            <span style="color:forestgreen">1호선 공항역 </span>EXIT 6
                                        </li>
                                    </ul>
                                </div>
                                <div class="map_way">
                                    <div class="d-flex map-way-hdr">
                                        <div class="img-icon car"></div>
                                        <div class="margin-left5">
                                            <strong>자가용 이용고객</strong>
                                            <span class="fc_999">(주차비 미지원)</span>
                                        </div>
                                    </div>
                                    <ul class="way">
                                        <li>터미널 방향 - 광주여대방향 80m 도로 끝 유턴 후 직진</li>
                                        <li>광산 IC에서 흑석사거리 방향 직진 후,</li>
                                        <li>지하도 진입하지말고 유턴 후 직진</li>
                                    </ul>
                                </div>
                            </div>
                        </li>

                        <!-- 부산센터 -->
                        <li id="tab3" class="map_body">
                            <p class="fc_999">
                                48939 부산광역시 중구 충장대로 11 부산무역회관2F
                            </p>
                            <div class="map">
                                <div id="daumRoughmapContainer1629445426784"
                                    class="root_daum_roughmap root_daum_roughmap_landing"></div>
                            </div>
                            <div class="map_wayWrap">
                                <div class="map_way">
                                    <div class="d-flex map-way-hdr">
                                        <div class="img-icon bus"></div>
                                        <div class="margin-left5">
                                            <strong>버스 이용고객</strong>
                                        </div>
                                    </div>
                                    <ul class="way margin-top5">
                                        <li>
                                            일반버스&nbsp;
                                            <span style="color:darkgreen">5-1, 17, 26, 27, 40, 41, 66, 81, 82,
                                                87, 88</span> 등
                                        </li>
                                        <li>
                                            급행버스&nbsp;
                                            <span style="color:darkorange">1003</span>
                                        </li>
                                    </ul>
                                </div>
                                <div class="map_way">
                                    <div class="d-flex map-way-hdr">
                                        <div class="img-icon subway"></div>
                                        <div class="margin-left5">
                                            <strong>지하철 이용고객</strong>
                                        </div>
                                    </div>
                                    <ul class="way margin-top5">
                                        <li>
                                            지하철&nbsp;
                                            <span style="color:firebrick">1호선 중앙역 </span>EXIT 12
                                        </li>
                                    </ul>
                                </div>
                                <div class="map_way">
                                    <div class="d-flex map-way-hdr">
                                        <div class="img-icon car"></div>
                                        <div class="margin-left5">
                                            <strong>자가용 이용고객</strong>
                                            <span class="fc_999">(주차비 미지원)</span>
                                        </div>
                                    </div>
                                    <ul class="way">
                                        <li>(부산역 기준) 중앙대로260번길 우회전 후 16m 이동</li>
                                        <li>중앙대로260번길 지하차도 진입 후 331m 이동</li>
                                        <li>충장대로 부산역 방면으로 U턴 후 754m 이동</li>
                                        <li>충장대로 고가도로 옆도로 진입 후 1.1km 이동</li>
                                        <li>충장대로13번길 우회전 후 53m 이동</li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>


            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp" %>
    </div>
    <script type="text/javascript">
        const tabList = document.querySelectorAll('.map_headerWrap .map_header a');
        const contents = document.querySelectorAll('.map_bodyWrap .map_body');
        let activeCont = ''; // 현재 활성화 된 컨텐츠 (기본:#tab1 활성화)

        for (var i = 0; i < tabList.length; i++) {
            tabList[i].addEventListener('click', function (e) {
                e.preventDefault();
                for (var j = 0; j < tabList.length; j++) {
                    tabList[j].parentNode.classList.remove('active');
                    contents[j].style.display = 'none';
                }
                this.parentNode.classList.add('active');
                activeCont = this.getAttribute('tab');
                document.querySelector(activeCont).style.display = 'block';
            });
        }

        // load map
        tabList.forEach(function (tab) {
            var executed = false;

            var secondMap = (function () {
                return function () {
                    if (!executed) {
                        executed = true;
                        new daum.roughmap.Lander({
                            "timestamp": "1629445358123",
                            "key": "2738v",
                            "mapWidth": "558",
                            "mapHeight": "300"
                        }).render();
                    }
                };
            })();
            var thirdMap = (function () {
                return function () {
                    if (!executed) {
                        executed = true;
                        new daum.roughmap.Lander({
                            "timestamp": "1629445426784",
                            "key": "2738w",
                            "mapWidth": "558",
                            "mapHeight": "300"
                        }).render();
                    }
                };
            })();

            function loadMap() {
                let tabNum = this.getAttribute('tab');
                if (tabNum === '#tab2') {
                    secondMap();
                } else if (tabNum === '#tab3') {
                    thirdMap();
                }
            }
            tab.addEventListener("click", loadMap);
        })

        new daum.roughmap.Lander({
            "timestamp": "1629445244605",
            "key": "2738u",
            "mapWidth": "558",
            "mapHeight": "300"
        }).render();

        
        // community nav active
        navLinks[3].parentElement.classList.add('current')
        subNav[3].classList.add('active');
    </script>
</body>
</html>