/**
 *
 * User: kjhbond
 * Date: 13. 4. 26
 * Time: 오후 6:33
 * To change this template use File | Settings | File Templates.
 */



var Calendar = function(){

    var dateObj = new Date();
    this.LANG_KR = "kr";
    this.LANG_EN = "en";

    this.lang = this.LANG_KR; // 기본언어설정 : 한국어
    this.container = document.body;

    // 년 월 일 요일 정보
    this.year = dateObj.getFullYear();
    this.month = dateObj.getMonth() + 1;
    this.date = dateObj.getDate();


    this.selectedYear = this.year;
    this.selectedMonth = this.month;
    this.selectedDate = this.date;

    // 현재 년, 월, 일, 요일 셋팅을 위한 셀렉터
    this.currentYearSelector = null;
    this.currentMonthSelector = null;
    this.currentDateSelector = null;
    this.currentDaySelector = null;


    // 이동 버튼 셀렉터
    this.goTodayBtnSelector = null;
    this.prevMonthBtnSelector = null;
    this.nextMonthBtnSelector = null;
    this.prevYearBtnSelector = null;
    this.nextYearBtnSelector = null;


    // 달력 외부 연동 엘리먼트 셀렉터들..
    this.parentSelector = null;
    this.weekTrTemplateSelector = null;;
    this.weekTrTemplate = null;
    this.dateNumSelector = null;
    this.todayClass = null;

    this.renderCallBack = null;
    this.renderCompleteCallBack = null;
    this.selectCallBack = null;
    this.renderData = null;

    // 날짜 이동 버튼 핸들러
    // return boolean ( true / false ) : false 일 경우 기본 기능을 막는다. preventDefault();
    this.onPrevMonth = null;
    this.onNextMonth = null;
}


Calendar.prototype = {
    selecteDate : function( date, month, year ){
    	
        this.date = this.selectedDate = date;
        
        if( month ){ this.month = this.selectedMonth = month; }
        if( year ){ this.year = this.selectedYear = year; }
        
        if( date === 0 ) this.selectedDate = 0;
        if( month === 0 ) this.selectedMonth = 0;
        if( year === 0 ) this.selectedYear = 0;
        
        
    }

    ,getYear : function(){
        return this.year;
    }

    ,getMonth : function(){
        return bm.string.numUtitToString( this.month );
    }

    ,getDate : function(){
        return bm.string.numUtitToString( this.date );
    }

    ,getYYYYMMDD : function( delimiter ){
        delimiter = delimiter === undefined ? "-" : delimiter;
        return this.getYear() + delimiter + this.getMonth() + delimiter + this.getDate();
    }


    ,getSelectedYear : function(){
        return this.year;
    }

    ,getSelectedMonth : function(){
        return bm.string.numUtitToString( this.selectedMonth );
    }

    ,getSelectedDate : function(){
        return bm.string.numUtitToString( this.selectedDate );
    }

    ,getSelectedYYYYMMDD : function( delimiter ){
        delimiter = delimiter === undefined ? "-" : delimiter;
        return this.getSelectedYear() + delimiter + this.getSelectedMonth() + delimiter + this.getSelectedDate();
    }

    ,getDay : function(){
        var dateObj = new Date(this.year, this.month-1, this.date);
        var dayList = [ "일", "월", "화", "수", "목", "금", "토" ];
        return dayList[ dateObj.getDay() ];
    }

    // 언어별 getDay() 함수에 대응되는 요일
    ,getDayString : function( dayInt, lang ){
        dayInt = dayInt != undefined ? dayInt : this.getDay();
        lang = lang || this.lang;
        var dayList;

        if( lang == this.LANG_KR ){
            dayList = [ "일", "월", "화", "수", "목", "금", "토" ];
        }else if( lang == this.LANG_EN ){
            dayList = [ "SUNDAY", "MONDAY", "THUSDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY" ];
        }

        return dayList[dayInt];
    }


    // 특정 년 월의 마지막 날짜
    ,getLastDate : function( year , month ){
        var d = 0;
        if (month == 3 || month == 5 || month == 8 || month == 10) {
            d = 30;
        } else {
            d = 31;
            if (month == 1) {
                if (year % 4 != 0) d = 28;
                else d = 29;
            }
        }
        return d;
    }

    ,setBtnMonth : function( prevBtnSelector, nextBtnSelector, onRenderComplete ) {
        var _this = this;

        // 이전에 버튼이 있으면 이벤트 제거
        if( this.nextYearBtnSelector ) $(this.container).find(this.nextYearBtnSelector).off( 'click');
        if( this.prevYearBtnSelector ) $(this.container).find(this.prevYearBtnSelector).off( 'click');

        this.nextMonthBtnSelector = nextBtnSelector;
        this.prevMonthBtnSelector = prevBtnSelector;

        if( this.nextMonthBtnSelector ){
            $(this.container).find(this.nextMonthBtnSelector).off( 'click' );
            $(this.container).find(this.nextMonthBtnSelector).on( 'click', function(){
                _this.nextMonth();
                if(_this.onNextMonth && _this.onNextMonth() == false) return; // 렌더링을 막는다.
                _this.render();
                if( onRenderComplete ) onRenderComplete();
            });
        }
        if( this.prevMonthBtnSelector ){
            $(this.container).find(this.prevMonthBtnSelector).off( 'click' );
            $(this.container).find(this.prevMonthBtnSelector).on( 'click', function(){
                _this.prevMonth();
                if(_this.onPrevMonth && _this.onPrevMonth() == false) return; // 렌더링을 막는다.
                _this.render();
                if( onRenderComplete ) onRenderComplete();
            });
        }
    }

    /**
     * 이전년도, 다음년도 버튼
     */
    ,setBtnYear : function( prevBtnSelector, nextBtnSelector ) {
        var _this = this;

        // 이전에 버튼이 있으면 이벤트 제거
        if( this.nextYearBtnSelector ) $(this.container).find(this.nextYearBtnSelector).off( 'click');
        if( this.prevYearBtnSelector ) $(this.container).find(this.prevYearBtnSelector).off( 'click');

        this.nextYearBtnSelector = nextBtnSelector;
        this.prevYearBtnSelector = prevBtnSelector;

        if( this.nextYearBtnSelector ){
            $(this.container).find(this.nextYearBtnSelector).off( 'click' );
            $(this.container).find(this.nextYearBtnSelector).on( 'click', function(){
                _this.nextYear();
                _this.render();
            } );
        }
        if( this.prevYearBtnSelector ){
            $(this.container).find(this.prevYearBtnSelector).off( 'click' );
            $(this.container).find(this.prevYearBtnSelector).on( 'click', function(){
                _this.prevYear();
                _this.render();
            } );
        }
    }

    /**
     * 오늘로 이동 버튼
     */
    ,setBtnToday : function( goTodayBtnSelector ) {

        var _this = this;

        // 이전에 버튼이 있으면 이벤트 제거
        if( this.goTodayBtnSelector ) $(this.container).find(this.goTodayBtnSelector).off( 'click');

        this.goTodayBtnSelector = goTodayBtnSelector;

        if( this.goTodayBtnSelector ){
            $(this.container).find(this.goTodayBtnSelector).off( 'click');
            $(this.container).find(this.nextYearBtnSelector).on( 'click', function(){
                _this.goToday();
                _this.render();
            } );
        }
    }

    // 현재 기준 다음달
    ,nextMonth : function(){
        if (this.month >= 12) {
            this.month = 1;
            this.year += 1;
        }else this.month++;
    }

    // 현재 기준 이전달
    ,prevMonth : function(){
        if (this.month <= 1) {
            this.month = 12;
            this.year -= 1;
        }
        else this.month--;
    }

    // 현재 기준 다음년도
    ,nextYear : function(){
        this.year++;
    }

    // 현재 기준 이전년도
    ,prevYear : function(){
        this.year--;
    }

    // 현재 날짜로 이동
    // [cjw] 오늘 클릭시, 현재 날짜로 이동할때 선택된 날짜도 오늘로 표기 필요할듯! -2016.06.01
    ,goToday : function(){
        var dateObj = new Date();
        this.selectedYear = this.year = dateObj.getFullYear();
        this.selectedMonth = this.month = dateObj.getMonth() + 1;
        this.selectedDate = this.date = dateObj.getDate();
    }

    // 이차원 배열 달력
    ,getRender : function(){
        return this.getRenderAt( this.year, this.month, this.date );
    }

    // 특적 년,월,일의 이차원배열 달력
    ,getRenderAt : function( year, month, date ){
        var limit = this.getLastDate( year, month-1 );
        var d = new Date( year, month-1, date );

        var weekList = [], dayList;
        var day = 1;
        var startDay = new Date( year, month-1, 1 );
        var j = startDay.getDay();
        for( var i=0; i<6; i++){
            dayList = [];
            while( j<7 ){
                dayList[j] = day++;
                j++;
                if( day > limit ) break;
            }
            weekList.push( dayList );
            if( day > limit ) break;
            j=0;
        }

        return weekList;
    }


    /**
     * 사용자 정의 셀렉터 추가.
     */
    ,setRenderSelector : function( weekTrTemplateSelector, dateNumSelector, parentSelector, todayClass ){
        this.parentSelector = parentSelector;
        this.weekTrTemplateSelector = weekTrTemplateSelector;;
        this.weekTrTemplate = $(this.container).find(weekTrTemplateSelector)[0].outerHTML;
        $(this.container).find(weekTrTemplateSelector).remove();
        this.dateNumSelector = dateNumSelector;
        this.todayClass = todayClass;
    }

    /**
     * 현재 년 월 일 요일 있으면 자동 html 삽입
     */
    ,renderCurrentDate : function(){
        if( this.currentYearSelector ){
            $(this.container).find(this.currentYearSelector).text( this.year );
        }

        var month = bm.string.numUtitToString( this.month );
        if( this.currentMonthSelector ){
            $(this.container).find(this.currentMonthSelector).text( month );
        }

        if( this.currentDateSelector ){
            $(this.container).find(this.currentDateSelector).text( this.date );
        }

        if( this.currentDaySelector ){
            $(this.container).find(this.currentDaySelector).text( this.getDayString() );
        }
    }

    ,onSelect : function( fn ){
        this.selectCallBack = fn;
    }

    /**
     * fn : 일자, 몇주째, 요일int, 요일String 호출
     * 화면 그리기
     */
    ,render : function( fn ){
        if( fn ){
            this.renderCallBack = fn;
        }

        // 타이틀 재설정
        this.renderCurrentDate();

        if( !this.weekTrTemplateSelector ) return;

        // 기존 tr 삭제.
        $(this.weekTrTemplateSelector).find( this.dateNumSelector).off( 'click' );
        //$(this.container).find(this.weekTrTemplateSelector).empty(); // tr 안에 내용만 비움
        // tr 완전 제거 [chojw] 2017-02-07 수정
        $(this.container).find(this.weekTrTemplateSelector).remove();

        // 날짜 그리기 시작
        this.renderData = this.getRender();
        var i, j;
        var weekElement, iLen = this.renderData.length;
        var dayList, jLen;
        var date = 1;
        var currDate;

        var _this = this;

        for( i=0; i<iLen; i++ ){

            weekElement = $(this.weekTrTemplate);
            $(this.container).find(this.parentSelector).append( weekElement[0] );
            dayList = this.renderData[i];
            jLen = dayList.length;
            for( j=0; j<jLen; j++ ){
                if( dayList[j] ){
                    currDate = weekElement.find( this.dateNumSelector )[j];
                    $( currDate ).html( date );
                    // 현재 엘리먼트, 날짜, row행, column줄 , 요일 반환
                    if( this.renderCallBack ) this.renderCallBack( currDate, date, i, j, this.getDayString(j) );

                    if( this.todayClass && date == this.selectedDate && this.year == this.selectedYear && this.month == this.selectedMonth ){
                        $(weekElement.find( 'td' )[j]).addClass( this.todayClass );
                    }
                    
                    $(weekElement.find( 'td' )[j]).data( "111111" );
                    date++;
                }
            }
        }

        $(this.container).find(this.weekTrTemplateSelector).find( 'td').on( 'click', function(){
            var dateNumEl = $(this).find( _this.dateNumSelector )[0];
            var date;
            if( dateNumEl ){
                date = dateNumEl.innerHTML;
            }

            if( !date ) return;

            _this.date = parseInt( date );
            _this.selecteDate( _this.date, _this.month, _this.year );
            if( _this.todayClass ){
                $(_this.container).find(_this.weekTrTemplateSelector).find( 'td').removeClass( _this.todayClass );
                $(this).addClass( _this.todayClass );
            }

            //if( _this.selectCallBack ) _this.selectCallBack( _this.year, _this.month, date );
        })


        $(this.container).find(this.weekTrTemplateSelector).find( this.dateNumSelector ).on( 'click', function(){
            if( !this.innerHTML ) return;

            _this.date = parseInt( this.innerHTML );
            _this.selecteDate( _this.date, _this.month, _this.year );

            if( _this.selectCallBack ) _this.selectCallBack( _this.year, _this.month, this.innerHTML, this );
        });



        if( this.renderCompleteCallBack ) this.renderCompleteCallBack( this.year, this.month, this.date );
    }


}

