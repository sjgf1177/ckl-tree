var historyReserv = {

		
		cancelReserv : function( mstCode ){
			
			var _this = this;
			
			if( confirm( "취소하시겠습니까?") ){
				bm.httpSend( "/testbed/concert/info/cancelReservStatus.json", { reservMasterCode : mstCode }, function(data) {
					if (data.resultCode == "success") {
						alert( "취소처리 되었습니다." );
						location.reload();
					}else{
						alert( "일시적으로 취소처리가 되지 않았습니다. 페이지를 새로고침 후 다시 시도해주세요." );
					}
				});
			}
			
		}
		
}