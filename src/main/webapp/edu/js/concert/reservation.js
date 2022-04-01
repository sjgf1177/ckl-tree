

window.addEventListener( "load", function(){
	reservation.defaultSetting();
})

$.expr[':'].textEquals = function(a, i, m) {
	return $(a).text().match("^" + m[3] + "$");
};

// 예약 객체
var reservation = {

	pop0 : null
	,pop1 : null
	,pop2 : null
	,pop3 : null

	,currentStep : -1
	,currentPop : null


	,concertDateList : null
	,timeListCon : null
	,timeDataList : null

	,reservedSitDataList : null
	,reservMasterCode : -1

	,calendar : null
	,concertId : -1


	,selectedDate : null
	,selectedTimeId : null
	,selectedSitIdList : []
	,viewPeopleNum : 1
	,selectSitComplete : false

	,reserveStatusData : null

	,reservLimitCnt : -1
	,reservSitFix : 0 // 0 : 선택모드 , 1 : 자동모드


	,needLogin : function(){
		if( confirm("로그인이 필요한 서비스입니다. \n 로그인페이지로 이동하시겠습니까?") ){
			var $form = $("#detailLoginForm");
			$form.submit();
		}
	}

	,setReservLimitCnt : function( cnt ){
		this.reservLimitCnt = cnt;
		$("#viewPeopleSelect").empty();
		for( var i=1; i<=this.reservLimitCnt; i++ ){
			$("#viewPeopleSelect").append( "<option value='"+i+"'>"+i+"명</option>");
		}
	}


	,setSitChoiceMode : function( mode ){
		this.reservSitFix = mode;
		if( this.reservSitFix == 1 ){
			$("#sit_fix_dim").show();
		}else{
			$("#sit_fix_dim").hide();
		}
	}


	,defaultSetting : function() {
		this.pop0 = $("#reservPopStep0");
		this.pop1 = $("#reservPopStep1");
		this.pop2 = $("#reservPopStep2");
		this.pop3 = $("#reservPopStep3");

		this.timeListCon = $("#reservationTimeListCon");


		this.calendar = new ReservDateCalendar();
		this.calendar.create();


		this.registEvent();
		this.init();
	}

	,init : function(){
		this.reset();
	}


	,reset : function(){
		// 기본정보 리셋
		this.concertId = -1;
		this.currentStep = -1;
		this.currentPop = null;

		// 공연 일, 시간 및 선택관련 리셋
		this.resetConcertTime();
		this.timeListCon.append("날짜를 선택해 주세요.");

		// 좌석관련 리셋
		this.resetSit();


		// 선택할 수 없는 좌석 데이터 리셋.
		this.reservedSitDataList = null;
		$(".seat_item").removeClass("selected");
		
		this.calendar.resetActiveDate();
	}


	,resetConcertTime : function(){

		this.concertDateList = null;

		this.selectedTimeId = null;
		this.selectedDate = null;


		// 기존에 등록된 회차 리스트 제거.
		this.timeDataList = null;
		if( this.timeListCon && this.timeListCon.length > 0 ) {
			this.timeListCon.empty();
		}

		// 입력내용확인 초기화
		$("#pleaseSelectDateAndTimeMessage").show();
		$("#confirmDateAndTime").hide();

		this.reserveStatusData = null;

	}



	,resetSit : function(){
		this.selectSitComplete = false;
		this.selectedSitIdList = [];
		$(".my_selected_movie_seat_check").empty();
		$(".seat_item").removeClass("select");
	}


	,registEvent : function(){

		var _this = this;

		this.pop0.find(".popup_close_btn").on("click", function(){
			_this.close();
		})
		this.pop1.find(".popup_close_btn").on("click", function(){
			_this.close();
		})
		this.pop2.find(".popup_close_btn").on("click", function(){
			_this.close();
		})
		this.pop3.find(".popup_close_btn").on("click", function(){
			_this.step4SaveData();
		})


		this.calendar.onSelect( function( year , month, date, target ){

			if( $(target).hasClass("canactive") == false ) {
				_this.calendar.setSelectedDate( _this.selectedDate );
				return;
			}

			if( !_this.selectedDate || _this.selectedDate != _this.calendar.getFullDate() ){
				_this.resetConcertTime();
				_this.selectedDate = _this.calendar.getFullDate();
				_this.getTimeData();
			}
		})



		$("#viewPeopleSelect").on("change", function(){
			if( _this.selectedSitIdList.length >= parseInt( $(this).val() ) ){
				alert( "관람인원 수가 선택하신 좌석의 수를 초과했습니다. 좌석을 다시 선택해주세요." );
				_this.resetSit();

				return;
			}

			if( parseInt( _this.reserveStatusData.remainCnt ) < parseInt( $(this).val() ) ){
				alert( "선택하신 관람인원 수가 남은 좌석수를 초과했습니다.\n 예약 가능하신 좌석 수는 "+_this.reserveStatusData.remainCnt+"자리 입니다." );
				$("#viewPeopleSelect option[value='"+_this.reserveStatusData.remainCnt+"']").prop("selected", "true" );

				_this.viewPeopleNum = _this.reserveStatusData.remainCnt;
				return;
			}

			_this.viewPeopleNum = parseInt( $(this).val() );
		});





		$("#step3CompleteBtn").on("click", function(){
			if( confirm( "선택하신 정보로 예약하시겠습니까?" ) ){
				_this.step3SaveData();
			}
		})


		$("#step4CompleteBtn").on("click", function(){
			_this.step4SaveData();
		})
		
		
		$("#tempReservBtn").on("click", function(){
			if( confirm( "예약대기를 신청하시겠습니까?") ){
				_this.tempReserv();
			}
		})
	}


	,open : function( concertId, selectedDate ){
		this.init();

		this.concertId = concertId;

		if( !this.concertDateList ){
			this.getConcertDateList();
		}

		if( selectedDate ){
			this.selectedDate = selectedDate;
		}

		$('body').css('overflow', 'hidden');
		this.showNextStep();
	}


	,print : function(){
		window.print();
	}


	,checkValidStep : function(){

		if( this.currentStep == 0 ){
			if( !this.selectedTimeId ){
				alert( "관람일과 시간을 선택해주세요." );
				return;
			}
		}else if( this.currentStep == 1 ){
			if( !$("[name=view_people_select]").val() ){
				alert( "관람인원을 선택해주세요.");
				return;
			}

			// 좌석 선택모드일 경우만
			if( this.reservSitFix == 0 ) {

				if( this.selectedSitIdList.length == 0 ){
					alert( "좌석을 선택해주세요.");
					return;
				}else if( parseInt($("[name=view_people_select]").val()) != this.selectedSitIdList.length ){
					alert( "좌석을 관람인원 수에 맞게 선택해주세요.");
					return;
				}
			}

		}else if( this.currentStep == 2 ){

		}else if( this.currentStep == 3 ){

		}

		return true;
	}


	,currentStepInit : function(){

		if( this.currentStep == 0 ){

			if( !this.selectedTimeId ){ // 선택한 공연일과 회차가 없을경우

//				if( !this.selectedDate ){
//					this.selectedDate = this.calendar.getFullDate();
//				}
				//this.getTimeData();
			}

		}else if( this.currentStep == 1 ){
			if( this.selectSitComplete == false ){

				// 선착순 좌석제가 아닌, 선택 좌석제라면,
				if( this.reservSitFix == 0 ){
					this.getSitData();
				}
				
				this.getReservStatus();
			}
		}else if( this.currentStep == 2 ){

			this.step3DataSetting();

		}else if( this.currentStep == 3 ){
			this.step4DataSetting();
		}
	}


	// Step 0. 공연일 목록 가져오기
	,getConcertDateList : function(){
		var _this = this;
		
		bm.httpSend( "/testbed/concert/info/getConcertDate.json", { concertId : this.concertId}, function(data) {
			if (data.resultCode == "success") {
				_this.concertDateList = data.concertDateList;
				_this.calendar.setCanActiveDate( _this.concertDateList );

				if( _this.concertDateList.length > 0 ){
					var firstDate = _this.concertDateList[0]["concertDate"];
					if( firstDate ){
						firstDate = firstDate.replace(/-/gi, "" );
						_this.calendar.setActiveDate( firstDate );
						
					}
				}
			}
		});
	}


	// Step 1 . 공연 시간 목록 가져오기
	,getTimeData : function(){
		var _this = this;
		bm.httpSend( "/testbed/concert/info/getTimeListAtDate.json", { selectedDate : this.selectedDate < 10 ? "0"+this.selectedDate :this.selectedDate , concertId : this.concertId}, function(data) {
			if (data.resultCode == "success") {
				_this.timeDataList = data.timeList;
				_this.setTimeList();
			}
		});
	}


	,setTimeList : function(){
		var len = this.timeDataList.length;
		var data, timeRow, template;
		if( len > 0 ) $(this.timeListCon).empty();
		for( var i=0; i<len; i++ ){
			data = this.timeDataList[i];


			if( data.hasReservHistory && parseInt( data.hasReservHistory ) > 0 ){
				template = '<li data-concert-time-id="'+data.concertTimeId+'" onclick="alert(\'선택하신 시간에 '+userName+'님의 예매내역이 존재합니다.\\n다른 시간을 선택해주세요\')"> ' +
					'<div class="popup_list_style_1_text"><span class="start_time">'+data.startTime+'</span> ~ <span class="end_time">'+data.endTime+'</span></div>' +
					'<a href="javascript:void(0);" class="popup_list_style_1_btn select_btn">선택</a>' +
					'</li>';
			}else{
				template = '<li data-concert-time-id="'+data.concertTimeId+'" onclick="reservation.selectConcertTime('+data.concertTimeId+');"> ' +
					'<div class="popup_list_style_1_text"><span class="start_time">'+data.startTime+'</span> ~ <span class="end_time">'+data.endTime+'</span></div>' +
					'<a href="javascript:void(0);" class="popup_list_style_1_btn select_btn">선택</a>' +
					'</li>';
			}

			timeRow = $(template).appendTo( this.timeListCon );

			$(timeRow).attr( "data-can-reserv", data.canReserv );
			if( data.canReserv != 'RY' ){
				$(timeRow).find(".select_btn").text( "매진" );
				//$(timeRow).attr("onclick", "alert('매진되었습니다. 다른 시간을 선택해주세요')" );
			}
		}
	}



	// Step 2 . 좌석 목록 가져오기
	,getSitData : function(){
		var _this = this;
		bm.httpSend( "/testbed/concert/info/getSitData.json", { concertTimeId : this.selectedTimeId}, function(data) {
			if (data.resultCode == "success") {
				_this.reservedSitDataList = data.reservedSitDataList;
				_this.setReservedSitList();
			}
		});
	}

	// Step 2-1. 특정 회차의 예약현황 가져오기 ( 남은 좌석수 산정을 위해 )
	,getReservStatus : function(){
		var _this = this;
		bm.httpSend( "/testbed/concert/info/getReservStatus.json", { concertTimeId : this.selectedTimeId}, function(data) {
			if (data.resultCode == "success") {
				_this.reserveStatusData = data.reservStatus;
			}
		});
	}



	// 예약된 좌석 더이상 예약 못하도록 설정
	,setReservedSitList : function(){

		$(".seat_item").removeClass("selected");
		var len = this.reservedSitDataList.length;
		var sitData;
		for( var i=0; i<len; i++ ){
			sitData = this.reservedSitDataList[i];
			$("[data-sit-id="+sitData.sitId+"]").addClass("selected");
		}

		this.registSitElementEvent();
	}


	,registSitElementEvent : function(){
		var _this = this;

		$(".seat_item").off();
		$("[data-sit-id]").not( ".selected" ).on("click", function(){

			if( $(this).hasClass("disabled_seat") && $(this).hasClass("select") == false ){
				if( confirm("휠체어석입니다. 예약을 진행하시겠습니까?") == false ){
					$(this).removeClass("select");
					return;
				}
			}

			
			// 선택하거나, 변경했으므로,
			_this.selectSitComplete = false;

			var sitId = $(this).attr("data-sit-id");

			if( $(this).hasClass("select") ){
				$(this).removeClass("select");
				_this.selectedSitIdList.splice( _this.selectedSitIdList.indexOf( sitId ), 1 );
			}else{

				if( _this.selectedSitIdList.length >= parseInt( $("#viewPeopleSelect").val() ) ){
					alert( _this.selectedSitIdList.length + "명의 좌석을 모두 선택하셨습니다. " );
					return;
				}

				$(this).addClass("select");
				_this.selectedSitIdList.push( sitId );
			}

			_this.setViewSelectedSit();
		})
	}


	,setViewSelectedSit : function(){

		$(".my_selected_movie_seat_check").empty();

		len = this.selectedSitIdList.length;
		for( var i=0; i<len; i++ ){
			if( i != 0 ){
				$(".my_selected_movie_seat_check").append( '<div class="selected_movie_seat_item_comma">,</div>' );
			}

			$(".my_selected_movie_seat_check").append( '<div class="selected_movie_seat_item">'+this.selectedSitIdList[i]+'</div>' );
		}
	}



	// 공연 시간을 선택한 경우
	,selectConcertTime : function( timeId ){

		
		var listItem = $("[data-concert-time-id='"+timeId+"']");
		var canReserv = $(listItem).attr("data-can-reserv");
		this.selectedTimeId = timeId;
		this.selectedDate = this.calendar.getFullDate();
		
		if( canReserv != 'RY' ){
			alert( "매진된 공연입니다.\n예약대기 버튼을 클릭하시면 예약 대기자로 등록하실 수 있습니다." );
			$("#tempReservBtn").show();
			
			$("#pleaseSelectDateAndTimeMessage").show();
			$("#confirmDateAndTime").hide();
		}else{
			$("#tempReservBtn").hide();
			$("#pleaseSelectDateAndTimeMessage").hide();
			$("#confirmDateAndTime").show();
	
			$("#confirmSelectedDate").text( this.calendar.getFullDateStr() );
			$("#confirmSelectedStartTime").text( listItem.find(".start_time").text() );
			$("#confirmSelectedEndTime").text( listItem.find(".end_time").text() );
		}
	}



	// Step 3. 예매내역 확인을 위한 데이터 셋팅
	,step3DataSetting : function(){
		$("#resevationConfirmDateInfo").text( this.calendar.getFullDateStr() );
		$("#resevationConfirmTimeInfo").text( $("#confirmSelectedStartTime").text() + " ~ " + $("#confirmSelectedEndTime").text() );
		if( this.reservSitFix == 1 ){
			$("#resevationConfirmSitInfo").text( "비지정좌석" );
		}else{
			$("#resevationConfirmSitInfo").text( this.selectedSitIdList.join(", ") );
		}
	}


	,step3SaveData : function(){
		var _this = this;
		bm.httpSend( "/testbed/concert/info/saveReservData.json", { concertId : this.concertId, concertTimeId : this.selectedTimeId, sitList : this.selectedSitIdList.join(","), viewPeopleNum : this.viewPeopleNum, reservPath : '0' }, function(data) {
			if (data.resultCode == "success") {
				_this.reservMasterCode = data.reservMasterCode;
				$("#qrcodeImg").attr("src", "/testbed/concert/info/createQrCode.do?content=" + data.reservMasterCode );
				_this.showNextStep();
			}else{
				if( data.msg && data.msg == 'seatDuplicate' ){
					// 선택했던 시트 초기화
					_this.selectedSitIdList = [];
					$(".seat_item").removeClass("select");
					
					alert( "다른 사용자에의해 선택하신 좌석이 예약되었습니다.\n좌석을 변경 선택 해주세요." );
				}else{
					alert( "저장에 실패했습니다. 새로고침 후 다시 시도해주세요." );
				}
			}
		});
	}
	
	
	,tempReserv : function(){
		var _this = this;
		bm.httpSend( "/testbed/concert/info/saveTempReservData.json", { concertId : this.concertId, concertTimeId : this.selectedTimeId }, function(data) {
			if (data.resultCode == "success") {
				alert( "등록되었습니다." );
			}else{
				if( data.msg && data.msg == 'tempReservDuplicate' ){
					alert( "이미 예약대기자로 등록된 공연입니다." );
				}else{
					alert( "저장에 실패했습니다. 새로고침 후 다시 시도해주세요." );
				}
			}
		});
	}


	,step4DataSetting : function(){
		$("#selectedMemberCnt").text( this.viewPeopleNum );
		$("#selectedDate").text( this.calendar.getFullDateStr() );
		$("#selectedStartTime").text( $("#confirmSelectedStartTime").text() );
		$("#selectedEndTime").text( $("#confirmSelectedEndTime").text() );

		if( this.reservSitFix == 1 ){
			$("#selectedSitList").text( "비지정좌석" );
		}else{
			$("#selectedSitList").text( this.selectedSitIdList.join( " , " ) );
		}
	}


	,step4SaveData : function(){
		var _this = this;
		var agreeEmail = $("#reserve_send_type_mail").is(":checked") ? 1 : 0;
		var agreeSms = $("#reserve_send_type_message").is(":checked") ? 1 : 0;
		var reservDate = this.selectedDate.substring(0,4)+'년 '+this.selectedDate.substring(4,6)+'월 '+this.selectedDate.substring(6,8)+'일';

		bm.httpSend( "/testbed/concert/info/allCompleteSendMessage.json", { concertId : this.concertId, concertTimeId : this.selectedTimeId, reservMasterCode : this.reservMasterCode, agreeEmail : agreeEmail, agreeSms : agreeSms, reservDate : reservDate }, function(data) {
			if (data.resultCode == "success") {
				if( agreeEmail == 1 || agreeSms == 1 ){
					alert( "선택하신 수신정보로 예약내역이 발송되었습니다." );
				}else{
					alert( "예매가 완료되었습니다." );
				}
				_this.close();
			}else{
				alert( "일시적으로 저장에 실패했습니다. 새로고침 후 다시 시도해주세요." );
			}
		});
	}


	,showPrevStep : function(){

		if( this.currentStep == 0 ) return;
		
		this.currentStep--;
		if( this.currentPop ) this.currentPop.hide();

		this.currentPop = this["pop"+this.currentStep];
		this.currentPop.show();

		this.currentStepInit();
	}

	,showNextStep : function(){

		if( this.currentStep == 3 ) return;

		// 현재 스텝 선택 완료 체크
		if( !this.checkValidStep() ) return;


		this.currentStep++;
		if( this.currentPop ) this.currentPop.hide();

		this.currentPop = this["pop"+this.currentStep];
		this.currentPop.show();

		this.currentStepInit();
	}


	,close : function(){

		this.pop0.hide();
		this.pop1.hide();
		this.pop2.hide();
		this.pop3.hide();
		$('body').css('overflow', '');

		this.reset();
	}
}















/**
 * 예약 날짜 컨트롤 달력 객체.
 * @constructor
 */
var ReservDateCalendar = function(){

	this.calendar;
	this.dom = $("#reservationCalendarContaienr")[0];
	this.canActiveDateList = null;

	this.onSelect = function( fn ){
		this.calendar.onSelect( fn );
	}

	this.onRender = function( fn ){
		this.calendar.renderCompleteCallBack = fn;
	}

	this.create = function(){

		var _this = this;

		if( this.calendar == null ){
			this.calendar = new Calendar();
			this.calendar.container = this.dom;
			this.calendar.currentYearSelector = '#bmCalYear';
			this.calendar.currentMonthSelector = '#bmCalMonth';
			this.calendar.setBtnMonth( "#datePickerLeftBtn", "#datePickerRightBtn");
			this.calendar.setRenderSelector(
				".cal_row" // weekTrTemplateSelector
				, ".dp_date" // search in week : dateNumSelector
				, "tbody" //parentSelector
				, "active" //todayClass
			);


			this.onRender( function( year, month, date ){
				_this.setCanActiveDate();
			});


			this.calendar.render();
		}
	}



	this.setSelectedDate = function( yyyymmdd ){
		this.calendar.selecteDate(
			yyyymmdd.slice(6)
			,yyyymmdd.slice(4,6)
			,yyyymmdd.slice(0,4)
		);

		this.calendar.render();
	}


	this.setActiveDate = function( yyyymmdd ){
		this.calendar.selecteDate(
			yyyymmdd.slice(6)
			,yyyymmdd.slice(4,6)
			,yyyymmdd.slice(0,4)
		);

		this.calendar.render();
		$("#reservationCalendarTable td").removeClass("active");
	}

	this.getFullDate = function(){
		return "" + this.calendar.selectedYear + this.calendar.selectedMonth + ( this.calendar.selectedDate < 10 ? "0" + this.calendar.selectedDate : this.calendar.selectedDate );
	}

	this.getFullDateStr = function(){
		return "" + this.calendar.selectedYear +"-"+ this.calendar.selectedMonth +"-"+ ( this.calendar.selectedDate < 10 ? "0" + this.calendar.selectedDate : this.calendar.selectedDate ) + " (" + this.calendar.getDay() + ")";
	}

	this.resetActiveDate = function(){
		this.canActiveDateList = null;
		$("#reservationCalendarTable td").removeClass("active");
	}


	this.setCanActiveDate = function( list ){
		if( list ) this.canActiveDateList = list;

		if( this.canActiveDateList ){
			var dateStr = this.calendar.year + "-" + this.calendar.month + "-" + this.calendar.date;

			var year = this.calendar.year;
			var month = this.calendar.month;
			var date = this.calendar.date;

			$("#reservationCalendarTable a").removeClass("canactive");


			var len = this.canActiveDateList.length;
			var o;
			for( var i=0; i<len; i++ ){
				o = this.canActiveDateList[i].concertDate.split("-");
				if( parseInt( o[0] ) == year && parseInt( o[1] ) == month ){
					$("a:textEquals('"+parseInt( o[2] )+"')").addClass("canactive");
				}
			}

		}
	}

}






































