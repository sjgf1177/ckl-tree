/**
 * Created by ceo on 2017-10-24.
 */




var concertList = {

    calendar : null
    
    ,listType : 1 //  1 : dately ,  2 : monthly
    ,menuNo : ''
    ,pageIndex : ''
	,siteId : 'testbed'
	,selectedYear : -1
    ,selectedMonth : -1
    ,selectedDate : -1
	,isCardListMode : true


    ,defaultSetting : function( menuNo, pageIndex, siteId, listType, selectedYear, selectedMonth, selectedDate ){
    	
    	this.menuNo = isNaN( parseInt( menuNo ) ) || !parseInt( menuNo ) ? '' : parseInt( menuNo );
    	
    	this.pageIndex = isNaN( parseInt( pageIndex ) ) || !parseInt( pageIndex ) ? 1 : parseInt( pageIndex );
    	this.listType = isNaN( parseInt( listType ) ) || !parseInt( listType ) ? 1 : parseInt( listType );
    	this.siteId = siteId == 'undefined' || !siteId ? 'testbed' : siteId; 
    	
    	this.selectedYear = isNaN( parseInt( selectedYear ) ) || !parseInt( selectedYear ) ? null : parseInt( selectedYear );
    	this.selectedMonth = isNaN( parseInt( selectedMonth ) ) || !parseInt( selectedMonth ) ? 0 : parseInt( selectedMonth );
    	this.selectedDate = isNaN( parseInt( selectedDate ) ) || !parseInt( selectedDate ) ? -1 : parseInt( selectedDate );
    	
        this.registEvent();
        this.init();
    }



    ,registEvent : function(){
        var _this = this;

        $("[data-concertlist-month]").on("click", function(){
            _this.calendar.selectedMonth = $( this).attr( "data-concertlist-month" );
            _this.setDate();
        })
        $("[data-concertlist-month]").on("keydown", function(key){
        	if(key.keyCode == 13){
	            _this.calendar.selectedMonth = $( this).attr( "data-concertlist-month" );
	            _this.setDate();
        	}
        })

        $("[data-concertlist-type]").on("click", function(){
            _this.listType = $(this).attr( "data-concertlist-type" );

            if( _this.listType == 2 && _this.calendar.selectedDate == 0 ){
                if( _this.isCardListMode == false ){
                    _this.isCardListMode = true;
                    _this.hideCardList();
                }


            }else{
                if( _this.isCardListMode == true ){
                    _this.isCardListMode = false;
                    _this.showCardList();
                }

            }

            _this.setDate();
        })
        $("[data-concertlist-type]").on("keydown", function(key){
        	if(key.keyCode == 13){
	            _this.listType = $(this).attr( "data-concertlist-type" );
	
	            if( _this.listType == 2 && _this.calendar.selectedDate == 0 ){
	                if( _this.isCardListMode == false ){
	                    _this.isCardListMode = true;
	                    _this.hideCardList();
	                }
	
	
	            }else{
	                if( _this.isCardListMode == true ){
	                    _this.isCardListMode = false;
	                    _this.showCardList();
	                }
	
	            }
	
	            _this.setDate();
        	}
        })


        // 월별 화면의 년도 선택시
        $("#filterMonthlyYearSelect").on("change", function(){
            _this.calendar.selectedYear = $(this).val();
            _this.setDate();
        })


        // 일별 화면의 월 선택시
        $("#filterDatelyMonthSelect").on("change", function(){
            _this.calendar.selectedMonth = $(this).val();
            _this.setDate();
        })

        // 일별 화면의 년도 선택시
        $("#filterDatelyYearSelect").on("change", function(){
            _this.calendar.selectedYear = $(this).val();
            _this.setDate();
        })
    }


    ,showCardList : function(){
        $("#cardListView").show();
        $("#monthlyListView").hide();
    }

    ,hideCardList : function(){
        $("#cardListView").hide();
        $("#monthlyListView").show();
    }


    ,init : function(){

        var _this = this;


        if( !this.calendar ){

            this.calendar = new Calendar();

            this.calendar.container = $(".movie_plan_calendar_view_con")[0];

            this.calendar.setRenderSelector(
                ".cal_row" // weekTrTemplateSelector
                , ".calendar_date" // search in week : dateNumSelector
                , "tbody" //parentSelector
                , "active" //todayClass
            );


            // 날짜가 선택되었을 때
            this.calendar.onSelect( function( year , month, date, target ){
                _this.setDate();
            })


            // defaultSetting
            var year = this.calendar.selectedYear;
            var month = this.calendar.selectedMonth;
            var date = this.calendar.selectedDate;
            
            if( this.selectedYear != -1 ) year = this.selectedYear;
            if( this.selectedMonth != -1 ) month = this.selectedMonth;
            if( this.selectedDate != -1 ) date = this.selectedDate;
            
            this.calendar.selecteDate( date, month, year );
        }


        this.setDate( true );
    }



    ,setDate : function( isInit ){

        if( this.listType == 1 ){
            if( this.calendar.selectedMonth == 0 ){
                this.calendar.selectedMonth = 1;
            }

            // 일별 선택값 입력
            $("#filterDatelyYearSelect option[value='"+this.calendar.selectedYear+"']").prop("selected", "true");
            $("#filterDatelyMonthSelect option[value='"+this.calendar.selectedMonth+"']").prop("selected", "true");

            // 일별 - 카드형
            $(".movie_plan_calendar_wrap").removeClass("active");
            $(".movie_calendar_year").text( this.calendar.selectedYear + "년 " + this.calendar.selectedMonth + "월 "  + this.calendar.selectedDate + "일" );
            $(".movie_calendar_date_color").text( this.calendar.selectedDate );
            $(".movie_calendar_date_text").text( "일" );

            this.calendar.selecteDate( this.calendar.selectedDate, this.calendar.selectedMonth, this.calendar.selectedYear );
            this.calendar.render();

        }else{

            // 월별 셀렉트박스 입력
            $("#filterMonthlyYearSelect option[value='"+this.calendar.selectedYear+"']").prop("selected", "true");
            $("[data-concertlist-month='"+this.calendar.selectedMonth+"']").addClass( "active" );

            // 월별 - 리스트형
            $("[data-concertlist-month]").removeClass("active");
            $("[data-concertlist-month='"+this.calendar.selectedMonth+"']").addClass( "active" );

            $(".movie_plan_calendar_wrap").addClass("active");
            if( this.calendar.selectedMonth == 0 ){
                $(".movie_calendar_year").text( this.calendar.selectedYear + "년 ");
                $(".movie_calendar_date_color").text( "전체" );
                $(".movie_calendar_date_text").text( "" );
            }else{
                $(".movie_calendar_year").text( this.calendar.selectedYear + "년 " + this.calendar.selectedMonth + "월");
                $(".movie_calendar_date_color").text( this.calendar.selectedMonth );
                $(".movie_calendar_date_text").text( "월" );
            }
        }


        if( this.listType == 2 && this.calendar.selectedMonth == 0 ){
            var mm = "";
            var rowSpan = 1;
            var startCell = null;
            var prevMonth=0, prevDate= 0, prevRow;
            $("[data-concert-month]").each(function(){
                var currentMonth = $(this).attr( "data-concert-month" );
                var currentDate = $(this).attr( "data-concert-date" );

                // 일별처리
                if( prevMonth == currentMonth && prevDate == currentDate && prevRow ){
                    $(prevRow).find(".monthly_desc").append(", ");
                    $(prevRow).find(".monthly_desc").append( $(this).find(".quick_btn") )
                    $(this).remove();
                    return;
                }else{
                    prevRow = this;
                    prevMonth = currentMonth;
                    prevDate = currentDate;
                }
            })

            $("[data-concert-month]").each(function(){
                var currentMonth = $(this).attr( "data-concert-month" );

                // 월별 처리.
                if( currentMonth != mm ){
                    if( startCell ){
                        $(startCell).attr( "rowSpan", rowSpan );
                    }

                    mm = currentMonth;
                    startCell = $(this).find(".monthly_title");
                    rowSpan = 1;
                }else{
                    rowSpan++;
                    $(this).find(".monthly_title").remove();
                }
            })
            
            if( startCell ){
                $(startCell).attr( "rowSpan", rowSpan );
            }
        }

        
        if( !isInit ){ // 초기화가 아닐때만 페이지 이동을 처리함.
        	
        	var year, month, date;
        	year = this.calendar.selectedYear;
        	month = this.calendar.selectedMonth;
        	date = this.calendar.selectedDate;
        	
        	// 월별 선택일 경우 날짜를 전송하지 않음.
        	if( this.listType == 2 ){
        		date = "";
        	}
        	
        	// 월을 전체 선택으로 했을 경우 월을 전송하지 않음.
        	if( this.calendar.selectedMonth == 0 ){
        		month = "";
        	}
        	
        	location.href = "/"+this.siteId+"/concert/info/rentList.do?menuNo="+ this.menuNo + "&pageIndex="+ 1 + "&siteId="+ this.siteId + "&listType=" + this.listType + "&selectedYear=" + year + "&selectedMonth=" + month + "&selectedDate=" + date;
        }
        
    }




    ,removeEvent : function(){

    }

    ,destroy : function(){
        this.removeEvent();


    }
}




// view_by_date_calendar_icon 클릭 시 calendar_style_1_wrap 에 active부여, 한번 더 클릭하거나 영역 바깥을 클릭 하면 active 제거 스크립트 필요
// view_by_date_calendar_text 에 calendar_style_1_wrap 안에 있는 table에서의 값을 value로 추가
// movie_plan_calendar_wrap 에 active가 붙어있고 data-concertlist-month의 값이 0인 것을 눌렀을 때 movie_plan_monthly_list 가 보이고 movie_plan_orderby_list는 display:none;
// data-concertlist-month가 0이 아닌 다른 것을 눌렀을 때는 movie_plan_monthly_list가 안보이고 movie_plan_orderby_list만 display:block; 스크립트 필요