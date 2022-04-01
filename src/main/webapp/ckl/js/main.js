/* READY FUNCTION */

var subMenuOpenIng=false;
$(document).ready(function() {


	//gnb 시작
	//메뉴
	var menuover = false; //current menu
	var subMnenuover = false; // 서브메뉴 활성화 상태
	var clearenter
	var gnb = jQuery('#gnb')
	if (!gnb.length) gnb = jQuery('.gnb')
	var gnb_link_depth1 = jQuery(gnb).find(">ol>li"); // 1depth
	if (!gnb_link_depth1.length) gnb_link_depth1 = jQuery(gnb).find(">ul>li"); // 1depth
	var gnb_link_depth2 = jQuery(gnb_link_depth1).find('>ul>li'); // 2depth
	var d_time = 0 // 마우스 아웃시 돌아가는 시간
	var depth1_d_time = 500 //1뎁스 메뉴 아웃시 돌아가는 시간
	var current_menu
	for (var i = 0; i < gnb_link_depth1.length; i++) {
		if (jQuery(gnb_link_depth1[i]).hasClass('on')) {
			current_menu = i
		};
	}
	gnb_link_depth1.each(function (index) {//1depth action
		//add mouseOver
		jQuery(this).find('>a').bind('mouseenter keyup', function () {
			clearTimeout(clearenter);
			menuover = true;
			jQuery(this).parent().addClass("hover").siblings().removeClass("hover");
			jQuery(this).parent().siblings().removeClass("on");
			if (jQuery(this).parent().attr('id')=='gnb3') {
				$('#gnbbg').hide();
			}else{
				$('#gnbbg').show();
			};
		});
		//add mouseOut
		jQuery(this).bind('mouseleave blur focusout', function () {
			menuover = false;
			clearenter = setTimeout(menuclear, depth1_d_time);
		});
	});

	function menuclear() {//first seting
		if (subMenuOpenIng==true) {
			if (!menuover) {
				gnb_link_depth1.removeClass("on");
				gnb_link_depth1.removeClass("hover");
				// imgOff(gnb_link_depth1)
				$('#gnbbg').hide()
				jQuery(gnb_link_depth1[current_menu]).addClass('on')
			}
		};
		if (subMenuOpenIng==false) {
			$('#gnbbg').hide()
			gnb_link_depth1.removeClass('on');
			gnb_link_depth1.removeClass('hover');
			jQuery(gnb_link_depth1[current_menu]).addClass('on')
		};
	}
	gnb_link_depth1.find('li:last-child').addClass('last')
	gnb_link_depth2.each(function () {//2depth action
		//add mouseOver
		jQuery(this).bind('mouseover keyup', function () {
			clearTimeout(clearenter);
			menuover = true;
			jQuery(this).addClass("on").siblings().removeClass("on");
			//imgOn(jQuery(this));
		});
		//add mouseOut
		jQuery(this).bind('mouseout blur', function () {
			//clearenter = setTimeout(menuclear, d_time);
			//imgOff(jQuery(this));
			jQuery(this).removeClass("on");
			menuover = false;
		});
	});







	$('.closeSch').hide()
	$('.OpenSch').click(function(event) {
		$('.shSet').slideDown();
		$(this).hide();
		$('.closeSch').show();
		return false;
	});
	$('.closeSch').click(function(event) {
		$('.shSet').slideUp();
		$(this).hide();
		$('.OpenSch').show();
		return false;
	});




	//퀵메뉴 스크롤링
	var sidebar = $('#quick') // 해당 요소
    b_width = $(document.body).width(); //페이지 전체크기
    d_width = $("body").width(); //본문 전체 크기임
    window_height = $(window).height(); //본문 전체 크기임
    t_height = $(document.body).scrollTop(); //상단 높이
    width = (b_width - d_width) <= 0 ? 900 : b_width/2 - 610; //중앙에서 어느 위치에 놓을지 적는다.
    height = t_height + 0; //상단부터 띄워야 하는 높이
    sidebar.css({top:height, display:'block'});
    var currentPosition = parseInt(sidebar.css("top"));
    $(window).scroll(function() {
        if(window_height < 560){
            sidebar.css({top:0, display:'block'});
        }else{
	    	var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.
	    	if (position > 150) {
	    		//스크롤 제한 구역 = 전체높이 - 푸터높이 -  스크롤 높이 - 150 (150을 뺀이유는 퀵메뉴의 top 이 content 종속이라서 )
	    		scrollArea = $(document).height() - $('#footer').innerHeight() - $('#quick').innerHeight() -150
	    		//현재위치>스크롤 제한 구역
	    		if (position > scrollArea) {
	    			sidebar.stop().animate({"top":scrollArea+'px'},1000); //무빙속도
	    		}else{
		    		sidebar.stop().animate({"top":position-150},1000); //무빙속도
	    		};
	    	}else{
	    		sidebar.stop().animate({"top":"0"},1000); //무빙속도
	    	};
    	}
    });




		var date_s= $('.sdate');
		for (var i=0;i<date_s.length ; i++ ){
			var innerhtml="<div class=\"calendarzone\"><input type=\"button\" src=\"/images/common/cal.gif\" alt=\"시작날짜 달력에서 선택\" onclick=\"return showCalendar('startDate-lry');\"/><div id=\"startDate-lry\" class=\"calendarSLayer\"><iframe id=\"startDate-ifrm\" name=\"startDate-ifrm\" class=\"calendar-frame\" src=\"/edu/html/incFrCalendar.html\" title=\"시작 날짜입력 프레임\" frameborder=\"0\" scrolling=\"no\"><\/iframe></div></div>";
			$(date_s[i]).before( innerhtml );
		}

		var date_e = $('.edate');
		for (var i=0;i<date_e.length ; i++ ){
			var innerhtml="<div class=\"calendarzone\"><input type=\"button\" src=\"/images/common/cal.gif\" alt=\"종료날짜 달력에서 선택\"  onclick=\"return showCalendar('endDate-lry');\"/><div id=\"endDate-lry\" class=\"calendarSLayer\"><iframe id=\"endDate-ifrm\" name=\"endDate-ifrm\" class=\"calendar-frame\" src=\"/edu/html/incFrCalendar.html\" title=\"종료 날짜입력 프레임\" frameborder=\"0\" scrolling=\"no\"><\/iframe></div></div>";
			$(date_e[i]).before( innerhtml );
		}

		$('.closetotMenuT').click(function(event) {
			$('.totMenuT').hide();
			$('.gnbTotMenu').focus();
			return false;
		});
		$('.gnbTotMenu').click(function(event) {
			$('.totMenuT').slideToggle();
			return false;
		});

});


//달력
function showCalendar(ele){
	var ele = document.getElementById(ele);
	if(ele.style.display != 'block'){
		ele.style.display ="block";
		ele.style.zIndex = "100";
	}else{
		ele.style.display ="none";
		ele.style.zIndex = "0";
	}
	return false;
}