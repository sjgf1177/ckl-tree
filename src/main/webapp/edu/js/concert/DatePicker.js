/**
 * Created with JetBrains PhpStorm.
 * User: kjhnotebook
 * Date: 15. 2. 25
 * Time: 오후 4:45
 * To change this template use File | Settings | File Templates.
 */


bm.datepicker = {

    syncDatePicker : function(){
        var list = [];
        var targetList = {};

        $('[data-datepicker]').each( function(){
            var selector = $(this).attr("data-datepicker");
            if( selector == "" || selector == "this") selector = this;

            $(this).on( 'click', function( e ){
                e.stopImmediatePropagation();
                bm.datepicker.show( selector );
            });
        });
    }

    ,registDatePicker : function( element, target ){
        $(element).on( 'click', function( e ){
            e.stopImmediatePropagation();

            if( target === undefined || target == "" || target == "this") target = this;
            bm.datepicker.show( target );
        });
    }


    ,templateSelector : ".cal_tb_con > table .cal_row"
    ,datepickerBase : '<div class="view_by_date_hidden_calendar" style="display:block;" id="datePicker">'+
						    '<div class="calendar_style_1_wrap type_2 always_on">'+
						    '<div class="calendar_style_1_month_con">'+
						        '<div class="calendar_style_1_month_inner">'+
						            '<div class="arrow_box">'+
						                '<a href="javascript:void(0);" id="datePickerLeftBtn"><img src="/edu/images/bm/calendar_month_left_arrow.png" alt="한달 전" class="cal_prev_month"></a>'+
						            '</div>'+
						            '<div class="calendar_month_text" style="display:inline-block;">'+
						                '<span class="year_text" id="bmCalYear">2017</span>년 <span class="month_text" id="bmCalMonth">09</span>월'+
						            '</div>'+
						            '<div class="arrow_box">'+
						                '<a href="javascript:void(0);" id="datePickerRightBtn"><img src="/edu/images/bm/calendar_month_right_arrow.png" alt="한달 후" class="cal_next_month"></a>'+
						            '</div>'+
						        '</div>'+
						    '</div>'+
						    '<div class="cal_tb_con">'+
						        '<table class="calendar_style_1 type_2 cal_tb" summary="movie plan view calendar">'+
						            '<caption>공연일정 선택 달력</caption>'+
						            '<colgroup><col width="14.28%"><col width="14.28%"><col width="14.28%"><col width="14.28%"><col width="14.28%"><col width="14.28%"><col width="14.28%"></colgroup>'+
						            '<thead><tr><th class="sunday">일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th class="saturday">토</th></tr></thead>'+
						            '<tbody>'+
						            '<tr class="cal_row_template cal_row">'+
						                '<td class="sunday"><a href="javascript:void(0)" class="calendar_date dp_date"></a></td>'+
						                '<td><a href="javascript:void(0)" class="calendar_date dp_date"></a></td>'+
						                '<td><a href="javascript:void(0)" class="calendar_date dp_date"></a></td>'+
						                '<td><a href="javascript:void(0)" class="calendar_date dp_date"></a></td>'+
						                '<td><a href="javascript:void(0)" class="calendar_date dp_date"></a></td>'+
						                '<td><a href="javascript:void(0)" class="calendar_date dp_date"></a></td>'+
						                '<td class="saturday"><a href="javascript:void(0)" class="calendar_date dp_date"></a></td>'+
						            '</tr>'+
						            '</tbody>'+
						        '</table>'+
						    '</div>'+
						'</div>'+
						'</div>'

                        
    ,template : null
    ,datepickerEl : null
    ,delimiter : "-"
    ,calendar : null
    ,isCreated : false

    ,getCalendar : function(){
        if( this.datepickerEl == null ){
            this.setCalendar();
        }
        return this.datepickerEl;
    }

    ,setCalendar : function(){
        this.datepickerEl = $( this.datepickerBase )[0];
    }

    ,setTemplate : function( datepickerBase, templateSelector ){
        this.datepickerBase = datepickerBase;
        this.templateSelector = templateSelector;
        this.setCalendar();
    }

    ,hide : function(){
        $( document.body ).off("click");
        $(this.datepickerEl).hide();
    }

    ,show : function( input, callBack ){
        var cal = this.getCalendar();
        var _this = this;

        if( this.calendar == null ){
            this.calendar = new Calendar();
            this.calendar.container = this.datepickerEl;
            this.calendar.currentYearSelector = '#bmCalYear';
            this.calendar.currentMonthSelector = '#bmCalMonth';
            this.calendar.setBtnMonth( "#datePickerLeftBtn", "#datePickerRightBtn");
            this.calendar.setRenderSelector(
                this.templateSelector // weekTrTemplateSelector
                , ".dp_date" // search in week : dateNumSelector
                , ".cal_tb_con > table" //parentSelector
                , "datepicker_today" //todayClass
            );
        }

        this.calendar.onSelect( function( year, month, date ){
            if( !date ) return;
            if( month < 10 ) month = "0"+month; // 10보다 작을 경우 앞에 0 붙혀줌
            if( date < 10 ) date = "0"+date; // 10보다 작을 경우 앞에 0 붙혀줌
            var curr = "" + year + _this.delimiter + month + _this.delimiter + date;
            if( callBack ) callBack( year, month, date );
            if( input ) $(input).val( curr );

            _this.hide();
        });


        var targetLeft = 0;
        var targetTop = 0;

        if( input ){
            var val = $(input).val().split( this.delimiter );
            if( val.length == 3 ){
                if( parseInt( val[0] ) > 0 ){
                    this.calendar.year = parseInt( val[0] );
                }
                if( parseInt( val[1] ) > 0 ){
                    this.calendar.month = parseInt( val[1] );
                }
                this.calendar.date = parseInt( val[2] );
            }

            var offset = $(input).offset();
            targetTop = offset.top + $(input).height();
            targetLeft = offset.left;
        }

        this.calendar.render();
        $(this.datepickerEl).css( {
            "position" : "absolute"
            ,"top" : targetTop
            ,"left" : targetLeft
            ,"zIndex" : 1000000
        });

        if( this.isCreated ){
            $( this.datepickerEl).show();
        }else{
            $(document.body).append( this.datepickerEl );
            this.isCreated = true;
            $(this.datepickerEl).on('click', function (e) {
                e.stopImmediatePropagation();
            });
        }

        $( document.body ).on("click", function(e){
            _this.hide();
        })
    }
}
