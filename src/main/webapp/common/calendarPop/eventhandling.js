/////////////////////////////////////////////////////////////////////////////////////////////////////
//              양/음력 만년달력 페이지의 이벤트 함수들입니다.
//
//                                                           by Albeniz(albenizforever@hotmail.com)
//                                                                        last updated : 2003-12-17
/////////////////////////////////////////////////////////////////////////////////////////////////////

var currentDate = new Date();
var currentDate = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate());

// 각 양식필드들에 관한 이벤트 핸들러 함수들
function btNextMonth_onclick() {
    if (currentDate.getMonth() < 11) {
        currentDate.setMonth(currentDate.getMonth() + 1);
    }
    else {
        currentDate.setFullYear(currentDate.getFullYear() + 1);
        currentDate.setMonth(0);
    }

    drawCalendar(currentDate);
}

function btNextYear_onclick() {
    currentDate.setFullYear(currentDate.getFullYear() + 1);
    drawCalendar(currentDate);
}

function btPrevMonth_onclick() {
    if (currentDate.month > 0) {
        currentDate.setMonth(currentDate.getMonth() - 1);
    }
    else {
        currentDate.setFullYear(currentDate.getFullYear() - 1);
        currentDate.setMonth(11);
    }

    drawCalendar(currentDate);
}

function btPrevYear_onclick() {
    currentDate.setFullYear(currentDate.getFullYear() - 1);
    drawCalendar(currentDate);
}
