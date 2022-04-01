

window.addEventListener( "load", function(){
	reservationAdmin.defaultSetting();
})

// 예약 객체
var reservationAdmin = {

	pop1 : null

	,reservedSitDataList : null
	,reservMasterCode : -1

	,concertId : -1

	,concertTimeId : null
	,selectedSitIdList : []
	,viewPeopleNum : 1

	,reserveStatusData : null
	,reservLimitCnt : -1
	,reservSitFix : 0 // 0 : 선택모드 , 1 : 자동모드

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
		this.pop1 = $("#reservPopStep1");

		this.registEvent();
	}

	
	,init : function(){
		this.reset();
		
		// 선착순 좌석제가 아닌, 선택 좌석제라면,
		if( this.reservSitFix == 0 ){
			this.getSitData();
		}
		
		this.getReservStatus();
	}


	,reset : function(){

		// 좌석관련 리셋
		this.resetSit();

		// 선택할 수 없는 좌석 데이터 리셋.
		this.reservedSitDataList = null;
		$(".seat_item").removeClass("selected");
		
	}


	,resetSit : function(){
		this.selectedSitIdList = [];
		$(".my_selected_movie_seat_check").empty();
		$(".seat_item").removeClass("select");
	}


	,registEvent : function(){

		var _this = this;
		this.pop1.find(".popup_close_btn").on("click", function(){
			_this.close();
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


		// 좌석 선택 확인.
		$("#confirmBtn").on("click", function(){
			if( !_this.checkValid() ) return;
			_this.confirmSelectedSeat();
		})

	}



	,checkValid : function(){

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
		return true;
	}


	// Step 2 . 좌석 목록 가져오기
	,getSitData : function(){
		var _this = this;
		bm.httpSend( "/testbed/concert/info/getSitData.json", { concertTimeId : this.concertTimeId}, function(data) {
			if (data.resultCode == "success") {
				_this.reservedSitDataList = data.reservedSitDataList;
				_this.setReservedSitList();
			}
		});
	}

	// Step 2-1. 특정 회차의 예약현황 가져오기 ( 남은 좌석수 산정을 위해 )
	,getReservStatus : function(){
		var _this = this;
		bm.httpSend( "/testbed/concert/info/getReservStatus.json", { concertTimeId : this.concertTimeId}, function(data) {
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
		$(".seat_item").not( ".selected" ).on("click", function(){

			if( $(this).hasClass("disabled_seat") ){
				if( confirm("휠체어석입니다. 예약을 진행하시겠습니까?") == false ){
					$(this).removeClass("select");
					return;
				}
			}

			
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


	,confirmSelectedSeat : function(){
		
		var _this = this;
		
		$("#viewPeopleNum").text( _this.viewPeopleNum );
		var sitInfo = _this.reservSitFix == 0 ? _this.selectedSitIdList.join(",") : "비지정좌석";
		$("#sitIdList").text( sitInfo );
		_this.close();
	}
	

	,open : function( concertId, concertTimeId ){

		this.concertId = concertId;
		this.concertTimeId = concertTimeId;

		this.init();
		this.pop1.show();
		$('body').css('overflow', 'hidden');
	}


	,close : function(){
		this.pop1.hide();
		this.reset();
		$('body').css('overflow', '');
	}
}






































