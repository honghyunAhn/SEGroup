/**
 * Soft Enginner Society
 * 이종호
 */
(function (global, $) {
	
	'use strict';
	
	$.fn.PACalendar = function(options){
		//기본 옵션
		var defaults = {
			calendarIndex : 0,
			calendarLen : 0,
			calendarWidth : 1560,
			calendarHeaderHeight : 200,
			calendarRowHeight : 42,
			startDate : new Date(),
			endDate : new Date(),
			startTime : '00',
			endTime : '24',
			standardMinute : 60,
			roomCount : 10,
			timeInterval : 10,
			showDuration : 200,
			targetDate : null,
			hiddenFlag : false,
			hiddenNumbers : [],			// ex : [{day : "2019-09-02",num : [2,4]},{day : "2019-09-04",num : [3,6]	}]
			printFlag : true,
			targetElement : null,
			naviAttrs : {
				class : "calendar_navi"
			},
			naviContainer : null,
			btnAttrs : {
				left : {
					id : "btn_left",
					class : "",
					value : "left"
				},
				right : {
					id : "btn_right",
					class : "",
					value : "right"
				},
				print : {
					id : "btn_print",
					class : "",
					value : "print"
				}
			},
			calWrapAttrs : {
				class : "calendar_wrapper"
			},
			calContainerAttrs : {
				class : "calendar_container"
			},
			calObjectAttrs : {
				id : "calendarDiv",
				class : "calendar_object"
			},
			messages : {
				roomName : "Room",
				hidden : "Hidden",
				leftOver : "first day of schedule",
				rightOver : "last day of schedule"
			}
		}
		//사용자 지정 옵션 추가
		var settings = $.extend(true,{},defaults,options);
		
		var PACalendar = {
			init : function(){
				console.log("init calendar");
				//선택된 타겟 설정
				settings.targetElement = $(this);
				//달력 네이게이션 부모 지정
				settings.naviContainer = settings.naviContainer == null ? settings.targetElement : settings.naviContainer;
				//시작일 종료일 형 변환
				settings.startDate = settings.startDate instanceof Date ? settings.startDate : new Date(settings.startDate);
				settings.endDate = settings.endDate instanceof Date ? settings.endDate : new Date(settings.endDate);
				//달력 생성
				this.create();
			},
			create : function(){
				console.log("create calendar");
				//달력 네비게이션 틀 생성
				var calendarNavi = $("<div />")
						.attr( settings.naviAttrs )
						.appendTo( settings.naviContainer );
				
				//달력 네비게이션 버튼 생성
				$.each( settings.btnAttrs , function(index , item){
					//인쇄 설정값이 false 일때 인쇄 버튼은 생성하지 않음
					if(!settings.printFlag && index == "print"){
						return;
					}
					var naviBtn = $("<button />")
							.attr( item )
							.html( item.value );
					
					calendarNavi.append( naviBtn );
				});
				
				//달력 가로 스크롤 틀 생성
				var calWrap = $("<div />")
						.attr( settings.calWrapAttrs );
				
				//달력 컨테이너 틀 생성
				var calContainer = $("<div />")
						.attr ( settings.calContainerAttrs )
						.appendTo ( calWrap );
				
				//달력 객체 틀 생성
				var calObject = $("<div />")
						.attr ( settings.calObjectAttrs )
						.appendTo ( calContainer );
				
				var period = Math.abs( settings.startDate.getTime() - settings.endDate.getTime() );
				period = Math.ceil( period / (1000 * 3600 * 24) );
				
				//달력 틀 붙이기
				settings.targetElement.append( calWrap );

				//달력 붙이기
				calObject.append( renderTablesHtml(period) );
				
				//숨기기 활성화
				$(".calendar_table").each(function(){
					var t = $(this);
					var hiddenArr = t.find(".remove");
					$.each(hiddenArr , function(index,item){
						var eq = $(this).index();
						t.find("tr").find('td:eq('+eq+'),th:eq('+eq+')').remove();
					});
				});
				
				//달력 크기 동적 할당
				var calHeight = ( ( (settings.endTime - settings.startTime) * Math.ceil( settings.standardMinute / settings.timeInterval ) ) * settings.calendarRowHeight ) + settings.calendarHeaderHeight;
				calContainer.css("height",calHeight);
				
				//버튼 함수 설정
				this.buttonFnc();
				
				function renderTablesHtml(period){
					var htmls = [];
					var day;
					var date;
					for ( day = 0; day <= period; day++){
						date = getTableDate(day);
						settings.targetDate = date;
						htmls.push(renderTableHtml(day));
					}
					
					return htmls.join('');
				};
				
				function renderTableHtml(day){
					var classNames = [
													'calendar_table',
													settings.targetDate,
													day == 0 ? 'on' : ''
												];
					
					return '' +
						'<table class="' + classNames.join(' ') +'">' +
						renderTableHeaderHtml() +
						renderTableBodyHtml() +
						'</table>';
				};
				
				function renderTableHeaderHtml(){
					return '' +
						'<thead>' +
						renderTableHeaderRowsHtml() +
						'</thead>';
				};
				
				function renderTableHeaderRowsHtml(){
					return '' +
						renderTableHeaderTitleRowHtml() +
						renderTableHeaderRoomRowHtml() +
						'';
				};
				
				function renderTableHeaderTitleRowHtml(){
					var hiddenObj = getHiddenFilter().pop();
					var hiddenNumCnt = typeof hiddenObj == "undefined" ? 0 : hiddenObj.num.length;
					var colspan = settings.roomCount - hiddenNumCnt + 1;
					
					return '' +
						'<tr>' +
							'<th class="scheduleTitle" colspan="'+ colspan +'">' + 
								settings.targetDate + 
							'</th>' +
						'</tr>';
				};
				
				function renderTableHeaderRoomRowHtml(){
					return '' +
						'<tr>' +
						renderTableHeaderRoomCellsHtml() +
						'</tr>';
				};
				
				function renderTableHeaderRoomCellsHtml(){
					var htmls = [];
					var col;
					for ( col = 0; col <= settings.roomCount; col++ ){
						htmls.push(renderTableHeaderRoomCellHtml(col));
					}
					return htmls.join('');
				};
				
				function renderTableHeaderRoomCellHtml(col){
					var hiddenObj = getHiddenFilter().pop();
					var hiddenNumArr = typeof hiddenObj == "undefined" ? [] : hiddenObj.num;
					var classNames = ['room'];
					if($.inArray( col, hiddenNumArr ) != -1){
						classNames.push("remove");
					}
					
					if( col > 0){
						return '' +
							'<td class="' + classNames.join(' ') + '" num="' + col + '">' +
								'<p>' +
								( settings.messages.roomName + col ) +
								'</p>' +
								(
								settings.hiddenFlag ?
									'( ' + settings.messages.hidden +
									'<input type="checkbox" class="room_ck">' +
									' )' 
									: ''
								) +
							'</td>';
					} else {
						return '' + 
							'<td></td>' ;
					}
				};
				
				function renderTableBodyHtml(){
					return '' +
						'<tbody>' +
						renderTableBodyRowsHtml() +
						'</tbody>';
				};
				
				function renderTableBodyRowsHtml(){
					var htmls = [];
					var time;
					for( time = settings.startTime; time < settings.endTime; time++ ){
						htmls.push(renderTableBodyRowHtml(time));
					}
					return htmls.join('');
				};
				
				function renderTableBodyRowHtml(time){
					var htmls = [];
					var minuteCnt = Math.ceil( settings.standardMinute / settings.timeInterval );
					var minute;
					for( minute = 0; minute < minuteCnt; minute++ ){
						htmls.push('<tr class="day-list">');
						htmls.push(renderTableBodyCellsHtml(time,minute));
						htmls.push('</tr>');
					}
					return htmls.join('');
				};
				
				function renderTableBodyCellsHtml(time,minute){
					var htmls = [];
					var cellCnt;
					htmls.push(renderTableBodyTimeCellHtml(time,minute));
					for ( cellCnt = 1; cellCnt <= settings.roomCount; cellCnt++ ){
						htmls.push(renderTableBodyScheduleCellHtml(time,minute,cellCnt));
					}
					return htmls.join('');
				};
				
				function renderTableBodyTimeCellHtml(time,minute){
					return '' +
						'<td>' +
						getCellDate(time,minute) + 
						' ~ ' +
						getCellDate(time,minute+1) +
						'</td>';
				};
				
				function renderTableBodyScheduleCellHtml(time,minute,cellCnt){
					return '' +
						'<td class="c_td cursor" day="'+settings.targetDate+'" time="'+getCellDate(time,minute)+'" room="'+cellCnt+'">' +
						'</td>';
				};
				
				function getCellDate(time,minute){
					var min = minute * settings.timeInterval > 60 ? 60 : minute * settings.timeInterval;
					return new Date(
								0,
								0,
								0,
								time,
								min
							).format("HH:mm");
				};
				
				function getTableDate(day){
					return new Date(
								settings.startDate.getFullYear(),
								settings.startDate.getMonth(),
								settings.startDate.getDate() + day
							).format("yyyy-MM-dd");
				};
				
				function getHiddenFilter(){
					return $.grep(settings.hiddenNumbers, function(object){
						return object["day"] === settings.targetDate;
					});
				};
				
			},
			buttonFnc : function (){

				calendarInit();
				var left = settings.btnAttrs.left.id;
				var right = settings.btnAttrs.right.id;
				
				$("#"+left).off().on("click",function(){
					var nIndex = settings.calendarIndex - 1;
					
					if(nIndex < 0){
						alert(settings.messages.leftOver);
						settings.calendarIndex = 0;
					}else{
						showCalendarAt(nIndex);
					}
				});
				
				$("#"+right).off().on("click",function(){
					var nIndex = settings.calendarIndex + 1;
					if (nIndex > settings.calendarLen){
						alert(settings.messages.rightOver);
						settings.calendarIndex = settings.calendarLen;
					}else{
						showCalendarAt(nIndex);
					}
				});
				
				
				function showCalendarAt(nIndex){
					var nPosition = -settings.calendarWidth * nIndex;
					var obj = settings.calObjectAttrs.class;
					
					$(".calendar_table").removeClass("on");
					$(".calendar_table").eq(nIndex).addClass("on");
					
					$("."+obj).stop();
					$("."+obj).animate({
						left: nPosition
					}, settings.showDuration);
					settings.calendarIndex = nIndex;
				};
				
				function calendarInit(){
					settings.calendarLen = $(".calendar_table").length -1;
				};
				
			}
		}
		
		this.print = function(){
			console.log("print calendar");
		};
		
		return this.each(function(n){
			$.fn.extend(this, PACalendar);
			this.init();
		});
	};
	
})(window, window.jQuery);