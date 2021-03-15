jQuery(function(){ // on DOM load'
// COMMON javascript

// 1 일반 사항
	// 1.1) 타켓 ID로 Layer 토글: 해당 버튼으로 호출과 닫기 동시 제어
		$('a.btn-toggle').click(function(){
			targetid = $(this).attr("href");
			$(targetid).toggleClass('off');
			return false; //링크실행 방지
		})
	// 1.2) a) 타켓 ID로Layer 호출
		$('a.btn-call').click(function(){
			targetid = $(this).attr("href");
			$(targetid).addClass('off');
		})
	// 1.2) b) Layer 닫기
		$('button.closer').click(function(){
			$(this).parent('div').parent('div').addClass('off');
		})
	// 1.3) self-toggle
		$(".self-toggle").click(function(){
			$(this).toggleClass("off")
		})

// 2. 전체 레이아웃 디자인 관련
	// 2.1) 페이지 높이 리사이즈 - 모바일에서 사용 X
	// 2.2) 페이지 스크롤 시 특정 요소 고정 시키기 - update 2018. 03. 30
		// 2.2) b) 연수 신청 - 연수 과정 상세보기 내용 탭 - 모바일에서 사용 X
		// 2.3) 메뉴 관련
		// 2.3) a) 선택된 메뉴에 스크린리더기용 표시 추가
			$(".gnb .menu-d1>li>a.on, .sub-menu li>a.on, .ctrl-btnSet>button.on").append("<sup class='sr-only'>ON</sup>");
		// 2.3) b) 서브메뉴 마우스 오버시 자동 오픈
			function submenuRodingOpen() {
				$("#sub-menu .menu-d2>li>a.on").next(".menu-d3").show();
				$("#sub-menu .menu-d3>li>a.on").parent("li").parent("ul").show();
			}
			$.fn.submenuOpen = function() {
				$("#sub-menu .menu-d3.on").removeClass("on");
				this.next(".menu-d3").addClass("on").focus();
			}
			submenuRodingOpen();
			$("#sub-menu .menu-d2>li>a").mouseover(function(){
				$(this).submenuOpen();
			}).keypress(function(e){
				if (e.which == 13) { // Enter
					return true;
				} else if (e.which == 118){ // v (view)
					$(this).submenuOpen();
				} else if (e.which == 99){ // c (clear)
					$(this).next(".menu-d3").removeClass("on");
				}
			}).attr("title", "키보드 운영시 v: 하위메뉴 보기, c: 하위메뉴 닫기, Enter: 페이지 이동");
		// 2.3) c) 모바일 전체 메뉴 관련
		$("#fullmenu .menu-d3").prev("a").addClass("havSub")
		$("#fullmenu .menu-d1>li>h5>a").click(function(){
			if($(this).parent("h5").parent("li").attr("class")=="on"){
				$(this).parent("h5").parent("li").toggleClass("on");
			} else {
				$("#fullmenu .menu-d1>li").removeClass("on");
				$(this).parent("h5").parent("li").attr("class","on");
			}
			return false;
		});
		$("#fullmenu .menu-d2 li>a.havSub").click(function(){
			$(this).parent("li").toggleClass("on");
			/*if($(this).parent("li").attr("class")=="on"){
				$(this).parent("li").toggleClass("on");
			} else {
				$(this).parent("li").parent("ul").children("li").removeClass("on");
				$(this).parent("li").attr("class","on");
			}*/
			return false;
		});
// 3.콘텐츠 레이아웃 구성 요소 디자인 관련
	// 3.1) 서브탭 자동 갯수 판별 - 모바일에서 사용 X
	// 3.2) 리스트 및 콘텐츠 상세 맞춤
		// 3.2) a) 펼침 리스트
			// 우철 추가 faq list
			$(".faq_content_list li").click(function(){
				$(this).toggleClass("on")
			})
			// 펼침 상세보기 리스트 - 제목의 a링크를 클릭시 내용 펼침
			$(".spread-list>li>a").click(function(){
				$(this).parent('li').toggleClass("on")
			})
			$(".spread-list .list-item-header .item-title>a").click(function(){
				$(this).parent('span').parent('p').parent('li.list-item').toggleClass("on")
			})
			// 온라인 시험 & 과제. (제목에 a링크 없이 헤더만 클릭해도 펼쳐짐)
			$("#list-exam .list-item-header").click(function(){
				$(this).parent('li.list-item').toggleClass("on")
			})
			// 펼쳐진 상세보기 닫기 버튼
			$(".spread-list .list-item-body .btn-close").click(function(){
				$(this).parent('p').parent('div').parent('div').parent('li.list-item').removeClass("on")
			})
		// 3.2) b) 온라인 시험 단답문제 체크 효과 - 모바일 사용 X
// 4.팝업관련 - popupSizing 함수 외에는 웹과 동일
	// 4.1) 팝업 오픈
		$.fn.popupSizing = function() {
			$(".cl-popup-overlay>.cl-popup-wrap>div:first-child").attr("style","").attr("class","cl-popup-box full");
		}
		// 팝업 - 이미 내용이 로드되어 있을 때
		$(".callPopup").click(function(){
			$(this).popupSizing();
			$(".cl-popup-overlay").addClass("on");
		});
		// 팝업 - 내용을 새로 로드 시켜야 할 때
		$(".roadPopup").click(function(){
			var openURL = $(this).attr("href");
			$(this).popupSizing();
			$(".cl-popup-overlay>.cl-popup-wrap>div:first-child").load(openURL);
			$(".cl-popup-overlay").addClass("on");
			return false;
		});
		// 자식 팝업 - 이미 내용이 로드되어 있을 때
		$(".callChildPopup").click(function(){
			var target = $(this).attr("href");
			$(target).addClass("on");
		});
		// 자식 팝업 - 내용을 새로 로드 시켜야 할 때
		$(".loadChildPopup").click(function(){
			var target = "#" + $(this).attr("data-target");
			var openURL = $(this).attr("href");
			$(target).load(openURL).addClass("on");
			return false;
		});
		// 자식 팝업인데 또 자식 팝업이 필요할 때
		$(".appendChildPopup").click(function(){
			var target = $(this).attr("data-target");
			var openURL = $(this).attr("href");
			$(".cl-popup-wrap").append('<div id='+target+' class="cl-popup-box child-popup on"><div></div><div class="child-popup-bottom"><a href=#'+target+' class="btn primary btnTargetRemove">닫기</a></div></div><a href=#'+target+' class="child-popup-back"> <span class="sr-only">닫기</span></a>')
			$("#"+target+" div:first-child").load(openURL);
			$(".child-popup-back, .btnTargetRemove").click(function(){
				var removeTarget = $(this).attr("href");
				$(removeTarget).remove();
				return false;
			});
			return false;
		});
	// 4.2) 팝업 닫기
		$(".cl-popup-closer, .close").click(function(){
			$(".cl-popup-overlay").removeClass("on");
			return false;
		});
		$(".btnTargetClose").click(function(){
			var removeTarget = $(this).attr("href");
			$(removeTarget).removeClass("on");
			return false;
		});
	// 4.3) 팝업 지우기
		$(".removePopup").click(function(){
			$(".cl-popup-overlay").removeClass("on");
			$(".cl-popup-box").remove();
			return false;
		});
		$(".child-popup-closer").click(function(){
			$(this).parent(".child-popup").removeClass("on");
		});
		$(".btnTargetRemove").click(function(){
			var removeTarget = $(this).attr("href");
			$(removeTarget).remove();
			return false;
		});
// 5.모바일 콘텐츠

// 9. 모바일에서 서브탭을 셀렉트 박스처럼 변경 이용
	$(".tab-group>.group").hide();
	$(".tab-header.sub>li>a.on").parent("li").parent(".sub").prepend("<li class='nowTab'>"+$(".tab-header.sub>li>a.on").html()+"</li>");


	$(".tab-header.sub .nowTab").click(function(){
		$(this).parent(".sub").toggleClass("open");
	});
	$(".affixed-element-sub-top>li>a").click(function(){
		if($(this).attr("class")!="on"){
			$(".tab-header.sub>li>a.on").removeClass("on");
			$(this).addClass("on").parent("li").parent(".sub").removeClass("open");
			$(".tab-header.sub .nowTab").text($(this).text());
			$(".tab-group .group").hide();
			$(".tab-group .group"+$(this).attr("href")).show();
		}
		return false;
	});

	//$(".tab-group .group"+$(".tab-header.sub>li>a.on").attr("href")).show();
	var id = $(".tab-header.sub>li>a.on").attr("href") || '';
	if (id.length > 1 && id.charAt(0) == '#') {
		$(".tab-group .group"+$(".tab-header.sub>li>a.on").attr("href")).show();
	}

});

//기수선택 공통 팝업(layer)
function popCourseCardinalSelect(course_id) {
	var layerId  = 'layerNotationSelect';
	if($('#'+layerId).length < 1) {
		$.ajax({
			type: "POST",
			url: "/common/layer/learn/cardinalSelect",
			dataType: "text",
			data: {'course_id': course_id},
			success: function(txt) {
				$(document.body).append(txt);
				popupOpen(layerId);
			}
		});
	} else {
		changeCardinalCourse(course_id);
		popupOpen(layerId);
	}
}

// 신청가능한 과정,기수인지 체크
function checkApplyAvailable(course_id, cardinal_id){
	var valid = false;
	$.ajax({
		type: "post",
		url: "/learn/apply/ajaxCheckApplyAvailable",
		data: {"course_id": course_id, "cardinal_id": cardinal_id},
		async: false,
		success: function(result) {
			if (isSuccessAjaxResponse(result)) {
				valid = (result.AVAIL_YN == 'Y');
			} else {
				alertAjaxFailMessage(result);
			}
		},
		error: function(e) {
			alert(e.responseText);
		}
	});
	return valid;
}

// 수강가능한지 체크 후 수강신청이동 - 로그인이 안됐을 경우 alert
function authAlertApply(course_id, cardinal_id, group_id) {
	group_id = group_id || '';
	if (typeof(globals) != 'undefined' && globals.islogin) {
		if (checkApplyAvailable(course_id,cardinal_id)) {	// 수강신청화면 이동
			location.replace('/learn/apply/apply?course_id='+course_id+'&cardinal_id='+cardinal_id + (isEmpty(group_id)?'':'&group_id='+group_id));
		} else {
			alert('이미 수강 신청하였거나 이수 및 연기 중인 과정입니다.\n나의 강의실에서 확인하여 주시기 바랍니다.');
			return;
		}
	} else {
		alert('로그인 후 이용해 주세요.');
		if ($('#layerLogin').length > 0) {
			$('.cl-popup-overlay').removeClass("on");
			popupOpen('layerLogin');
		}
	}
}

// PC버전에서만 가능한 기능 입니다.
function alertPcOnly() {
	alert('해당 기능은 PC 버전에서만 가능합니다.');
}

function popupOpen(popup) {
	$("#"+popup).addClass("on");
}

function popupClose(popup) {
	$("#"+popup).removeClass("on");
}

function addComma(num) {
  var regexp = /\B(?=(\d{3})+(?!\d))/g;
   return num.toString().replace(regexp, ',');
};

function generateRandom(min, max) {
  var ranNum = Math.floor(Math.random()*(max-min+1)) + min;
  return ranNum+"";
};

// Daum 주소 서비스 API 연동
function daumPostcode(idx) {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
			var extraRoadAddr = ''; // 도로명 조합형 주소 변수

			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				extraRoadAddr += data.bname;
			}

			// 건물명이 있고, 공동주택일 경우 추가한다.
			if(data.buildingName !== '' && data.apartment === 'Y'){
				extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			}

			// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			if(extraRoadAddr !== ''){
				extraRoadAddr = ' (' + extraRoadAddr + ')';
			}

			// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
			if(fullRoadAddr !== ''){
				fullRoadAddr += extraRoadAddr;
			}

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            // document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
			$(".zipcode").eq(idx).val(data.zonecode);

            if(data.userSelectedType == 'R') {
            	// document.getElementById('addr').value = fullRoadAddr;
            	$(".addr").eq(idx).val(fullRoadAddr);
            } else if(data.userSelectedType == 'J') {
            	// document.getElementById('addr').value = data.jibunAddress;
            	$(".addr").eq(idx).val(data.jibunAddress);
            }

            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                //예상되는 도로명 주소에 조합형 주소를 추가한다.
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                // document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                // document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

            } else {
                // document.getElementById('guide').innerHTML = '';
            }

            // document.getElementById('etcAddr').focus();
            $(".etc_addr").eq(idx).focus();
        }
    }).open();
}

function getListQuery(formEl,arr) {
	var query = '';
	var el;
	for(var i=0; i<arr.length; i++) {
		el = formEl.elements[arr[i]];
		if (el == null || el.value == '') continue;
		query += arr[i] + '=' + el.value + '&';
	}
	return query;
}

// trim
function trim(val) {
	if (val == null) return "";
	return val.replace(/(^\s*)|(\s*$)/gi, "");
}

// check empty
function isEmpty(str) {
	return (str == null || trim(str) == '')
}

// byte length
function getBytes(source) {
	if (source == null) return 0;
	if (typeof source == 'string') str = source;
	else if (typeof source == 'object' && source.value != null) str = source.value;
	else return -1;
	var b = 0;
	var len = (str)?str.length:0;
 	for (var i=0; i<len; i++) b = (str.charCodeAt(i) > 255) ? b+2:b+1;
	return b;
}

// concat array
function concatArray(arr, sepa) {
	if (arr == null || arr.length < 1) return '';

	sepa = sepa || '';
	var str = '';
	for(var k in arr) {
		if (isEmpty(arr[k])) continue;
		if (sepa != '' && !isEmpty(str)) str += sepa;
		str += arr[k];
	}
	return str;
}

// validation email
function isValidEmail(source) {
	var str = null;
	if (source == null) return false;
	if (typeof source == 'string') str = trim(source);
	else if (typeof source == 'object' && source.value != null) str = trim(source.value);
	else return false;

	var regExp = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i;
	if(!regExp.test(str)) return false;
	return true;
}

// validation password
function isValidPassword(source) {
	/*
	 * 8~30 byte 이내
	 * 영문자,숫자,특수문자 반드시 포함
	 * 공백불허
	 */
	var str = null;
	if (source == null) return false;
	if (typeof source == 'string') str = trim(source);
	else if (typeof source == 'object' && source.value != null) str = trim(source.value);
	else return false;

	var aBlank = /[\s]/;
	var anUpperCase = /[A-Z]/;
	var aLowerCase = /[a-z]/;
	var aNumber = /[0-9]/;
	var aSpecial = /[~|!|@|#|$|%|^|&|*|(|)|-|_|=|+]/;

	if (str.search(aBlank) != -1) {
		return false;
	}

	if(str.length < 8 || str.length > 30) return false;
	var numUpper = 0;
	var numLower = 0;
	var numNums = 0;
	var numSpecials = 0;
	for(var i=0; i<str.length; i++){
		if(anUpperCase.test(str[i])) numUpper++;
		else if(aLowerCase.test(str[i])) numLower++;
		else if(aNumber.test(str[i])) numNums++;
		else if(aSpecial.test(str[i])) numSpecials++;
	}

	if((numUpper+numLower) < 1 || numNums < 1 || numSpecials <1) return false;

	return true;
}

// validation name
function isValidName(source) {
	/*
	 * 한글2~15, 영문 4~30자
	 * 특수문자, 공백 불허
	 */
	var str = null;
	if (source == null) return false;
	if (typeof source == 'string') str = trim(source);
	else if (typeof source == 'object' && source.value != null) str = trim(source.value);
	else return false;

	var aBlank = /[\s]/;
	var aSpecial = /[~|!|@|#|$|%|^|&|*|(|)|-|_|=|+]/;

	if (str.search(aBlank) != -1 || str.search(aSpecial) != -1) {
		return false;
	}

	var bytes = getBytes(str);
	if(bytes < 4 || bytes > 30) return false;

	return true;
}

// validation tel
function isValidTel(source, ignoreSepa) {
	/*
	 * 유무선전화번호
	 */
	ignoreSepa = ignoreSepa || true;	// 구분자(-,),공백) 무시
	var str = null;
	if (source == null) return false;
	if (typeof source == 'string') str = trim(source);
	else if (typeof source == 'object' && source.value != null) str = trim(source.value);
	else return false;

	if (ignoreSepa) {
		str = str.replace(/\-/g,'')
				.replace(/\)/g,'')
				.replace(/\s/g,'');
	}

	var regx = /^(01[016789]{1}|070|02|0[3-9]{1}[0-9]{1})[0-9]{3,4}[0-9]{4}$/;

	return regx.test(str);
}

// validation 생년월일
function isValidBirthday(source) {
	var str = null;
	if (source == null) return false;
	if (typeof source == 'string') str = trim(source);
	else if (typeof source == 'object' && source.value != null) str = trim(source.value);
	else return false;

	var regx = /^[1-2]{1}[0-9]{3}-[0-1]{1}[0-9]{1}-[0-3]{1}[0-9]{1}$/;

	return regx.test(str);
}

function isValidNeis(source) {
	/*
	 * 10자리 영자숫자 조합
	 */
	var str = null;
	if (source == null) return false;
	if (typeof source == 'string') str = trim(source);
	else if (typeof source == 'object' && source.value != null) str = trim(source.value);
	else return false;

	var reg = /^[0-9a-zA-Z]{3}[0-9]{7}$/;

	return reg.test(str);
}

function isSuccessAjaxResponse(result) {
	return !isEmpty(result['CODE']) && result['CODE'] === 'SUCCESS';
}

function alertAjaxFailMessage(result) {
	if (!isEmpty(result['CODE']) && result['CODE'] !== 'SUCCESS' && !isEmpty(result['MESSAGE'])) {
		if(result['MESSAGE'].length > 100) {
			alert('오류가 발생하였습니다.');
		} else {
			alert(result['MESSAGE']);
		}
	};
}

// 로그인이 안됐을 경우 alert
function authAlertMove(move_url) {
	if (typeof(globals) != 'undefined' && globals.islogin) {
		location.href = move_url;
	} else {
		alert('로그인 후 이용해 주세요.');
		if ($('#layerLogin').length > 0) {
			popupOpen('layerLogin');
		}
	}
}

// 미리보기 없음 alert
function alertNoPreview() {
	alert('이 과정은 미리보기가 없습니다.');
}

// secure url
function getSecureUrl(url, port) {
	port = port || '443';
	var h = window.location.host;
	var d = h;
	if (h.lastIndexOf(":") >= 0) d = h.substring(0,h.lastIndexOf(":"));
	var secure = 'https://' + d + (port=='443'?'':(':'+port)) + (url.indexOf('/')<0?'/':'') + url;
	return secure;
}

// 팝업
function makeCenterWindow(pageURL, windowId, widthWindow, heightWindow) {
	var height = screen.height;
	var width = screen.width;
	var leftpos = width / 2 - widthWindow / 2;
	var toppos = height / 2 - heightWindow / 2;

	var w = open(pageURL, windowId, "scrollbars=no, resizable=no, width=" + widthWindow + ", height=" + heightWindow + ", left=" + leftpos + ", top=" + toppos);
	w.focus();
	return w;
}

function makeCenterWindowScroll(pageURL, windowId, widthWindow, heightWindow) {
	var height = screen.height;
	var width = screen.width;
	var leftpos = width / 2 - widthWindow / 2;
	var toppos = height / 2 - heightWindow / 2;
	var w = open(pageURL, windowId, "scrollbars=yes, resizable=no, width=" + widthWindow + ", height=" + heightWindow + ", left=" + leftpos + ", top=" + toppos);
	w.focus();
}

function popIdenWindow(url, w, h) {	//
	var _idenWin = null;
	_idenWin = window.open(url,'_iden','width='+w+'px, height='+h+'px, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
/*
 * 본인인증시 ie에서 opener 사라짐 fix
 * if (typeof(globals) != 'undefined' && globals.isMobile) {
		_idenWin = window.open(url,'_iden','width='+w+'px, height='+h+'px, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	} else {
		_idenWin = window.open(null,'_iden','width='+w+'px, height='+h+'px, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		var html = '<html><head><meta name="viewport" content="width=device-width"><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><style>*{padding:0}</style><head><body>'
			+ '<iframe width="100%" height="100%" src="'+url+'" frameborder="0" scrolling="no" style="height: 100vh" allowfullscreen></iframe>'
			+'</body></html>';
		_idenWin.document.open();
		_idenWin.document.write(html);
		_idenWin.document.close();
	}*/
	_idenWin.focus();
	return _idenWin;
}

//
function setLimits(limits, regist_pc_count) {
	if (limits.indexOf("3") > -1 && regist_pc_count < 1) { //타PC 제한이 걸려 있는 경우
		alert("[타PC 작업제한]\n접속IP 등록 후 진행하여 주십시오.");
		location.href = "/mypage/ip/ip";
	}
}

//특수키 제한
function setLimitkeys(limitKeys) {
	if (limitKeys.indexOf("1") > -1) { //CTRL+C
		jQuery(document).bind("cut copy",function(e){  e.preventDefault(); });
		$(document).keydown(function(e){ if((e.ctrlKey && e.keyCode == 67) || (e.ctrlKey && e.keyCode == 67)) return false; });
	}
	if (limitKeys.indexOf("2") > -1) { //CTRL+P
		$(document).keydown(function(e){ if(e.ctrlKey && e.keyCode == 80) return false; });
	}
	if (limitKeys.indexOf("3") > -1) { //CTRL+V
		jQuery(document).bind("paste",function(e){e.preventDefault();});
		$(document).keydown(function(e){ if(e.ctrlKey && e.keyCode == 86) return false; });
	}
	if (limitKeys.indexOf("4") > -1) { //CTRL+F
		$(document).keydown(function(e){ if(e.ctrlKey && e.keyCode == 70) return false; });
	}
	if (limitKeys.indexOf("5") > -1) { //우마우스클릭
		jQuery(document).bind("contextmenu",function(e){e.preventDefault();});
		$(document).contextmenu(function(e){return false;});
	}
}

function setCookie(cname, cvalue, exp) {
	var date = new Date();
	date.setTime(date.getTime() + exp*24*60*60*1000);
	document.cookie = cname + '=' + cvalue + ';expires=' + date.toUTCString() + ';path=/';
}

function getCookie(cname) {
	var value = document.cookie.match('(^|;) ?' + cname + '=([^;]*)(;|$)');
	return value ? value[2] : null;
}

function alertNoaccountPaymentInfo() {
	//무통장 / 가상계좌 -> alert(); 결제 수단을 무통장 입금으로 선택하셨습니다. 무통장 계좌버는 ~~~~. 감사합니다.
	var message = "결제 수단을 무통장 입금으로 선택하셨습니다.\n";
	message += "아래의 계좌로 입금하여 주시기 바랍니다.\r\n";
	message += "은행 : 하나은행\n";
	message += "계좌번호 : 168-910019-27904\n";
	message += "예금주 : 주식회사 창비교육\r\n";
	message += "감사합니다.\n";

	alert(message);
}

/**
 * 입력값에 특정 문자가 있는지 체크하는 로직이며
 * 특정문자를 허용하고 싶지 않을때 사용할수도 있다
 * if (containsChars(form.name, "!,*&^%$#@~;")){
 *       alert("특수문자를 사용할수 없습니다");
 * }
 */
function containsChars(value, chars){
       for (var i=0; i < value.length; i++){
             if (chars.indexOf(value.charAt(i)) != -1){
                    return true;
             }
       }
       return false;
}

/**
 * 입력값이 특정 문자만으로 되어있는지 체크하며
 * 특정문자만을 허용하려 할때 사용한다.
 * if (containsChars(form.name, "ABO")){
 *    alert("혈액형 필드에는 A,B,O 문자만 사용할수 있습니다.");
 * }
 */
function containsCharsOnly(value, chars){
       for (var i=0; i < value.length; i++){
             if (chars.indexOf(value.charAt(i)) == -1){
                    return false;
             }
       }
       return true;
}

/**
 * 입력값이 숫자, 대시"-" 로 되어있는지 체크한다
 * 전화번호나 우편번호, 계좌번호에 -  체크할때 유용하다
 */
function isNumDash(value){
   var chars = "-0123456789";
   return containsCharsOnly(value, chars);
}

