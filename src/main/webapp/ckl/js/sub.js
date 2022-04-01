/* READY FUNCTION */
var subMenuOpenIng=false;
$(document).ready(function() {
	// $( "*" ).delegate( "*", "focusin", function(e) {
	// 	e.stopPropagation();
	// 	if($("*").is(":focus")){
	//  		console.log($(this).position().top+"_현재 포커스의 위치값_"+$(this).position().left
	//  			+"///offset Top"+$(this).offset().top
	//  			+" offset left:"+$(this).offset().left)
	//  	};
/*
	$("*").bind("focusin", function(e){
			console.log($(this)+"포커스 이벤트 찾기"+$(this).position().top);
		if(e.type="focusout" && (e.shiftKey && e.keyCode == 9)){ //shift tab 과 포커스아웃할때 숨김
		}
	});
	$(document).on("keyup", function(e){
		if(e.keyCode == 9 || (e.keyCode == 9 && e.shiftKey)){ //tab key click
			console.log(e.pageX+"posi"+e.which);
			if(e.target) {
			}else if(e.srcElement){
			}
			//console.log(sTop+"Stop");
		}
	});
	});
	*/
	$('.subPageInfo *, .contentSet *').each(function(index, el) {
		$(this).on('focus', function(event) {
			// event.preventDefault();
			scrolltopPosition = $(window).scrollTop() + 102 //102은 navi 높이
			thisPosition = $(this).offset().top
			// console.log(scrolltopPosition , ' vs ' , thisPosition)
			if (scrolltopPosition > thisPosition) {
				var y = thisPosition-102
				window.scrollTo(0,y)
			};
		});
	});

	// skip Link Scroll Top

	$('.skipContents').click(function(e) {
		e.stopPropagation();
		var target = $(this).attr('href');
		var delay = 200;
		$('html,body').animate({scrollTop:0}, delay);
		$(".snsToggleOpen").focus();
		return false;
	});

	$('#gnbbg').hide();
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
	var depth1_d_time = 1000 //1뎁스 메뉴 아웃시 돌아가는 시간
	var current_menu
	for (var i = 0; i < gnb_link_depth1.length; i++) {
		if (jQuery(gnb_link_depth1[i]).hasClass('on')) {
			current_menu = i
		};
	}
	$('#gnbbg').each(function(index) {
		$(this).bind('mouseenter', function() {
			clearTimeout(clearenter);
			menuover = true;
		});
		jQuery(this).bind('mouseleave blur focusout', function () {
			menuover = false;
			clearenter = setTimeout(menuclear, d_time);
		});

	});
	gnb_link_depth1.each(function (index) {//1depth action
		//add mouseOver
		jQuery(this).find('>a').bind('mouseenter keyup', function () {
			clearTimeout(clearenter);
			menuover = true;
			jQuery(this).parent().addClass("hover").siblings().removeClass("hover");
			jQuery(this).parent().siblings().removeClass("on");
			$('#gnbbg').show();
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


	var lnbF = $("#lnb li");
	var lnbS = $("#lnb li li");
	var lnb_wrap = $("#lnb");
	var lnb_dp1=$("#lnb>ul>li");	// 1depth
	var currentLnb;
	var subLnbOpenIng = false;
	var clearLnbenter;
	for (var i = 0; i < lnb_dp1.length; i++) {
		if (jQuery(lnb_dp1[i]).hasClass('on')) {
			currentLnb = i
		};
	}

	function lnbClear() {//first seting
		if (subLnbOpenIng==true) {
			if (!menuover) {
				lnb_dp1.removeClass("active");
				$(lnb_dp1[currentLnb]).addClass('active')
			}
		};
		if (subLnbOpenIng==false) {
			lnb_dp1.removeClass('active');
			lnb_dp1.removeClass('hover');
			$(lnb_dp1[currentLnb]).addClass('on')
		};
	}


	$(lnbF).bind('mouseover keyup' , function()	{
		$(this).parent().siblings().removeClass("active");
		$(this).addClass("active").parent().siblings().removeClass("active");
		clearTimeout(clearLnbenter);
	});
	$(lnbF).bind('mouseout blur' , function()	{
	 // $(this).removeClass("active");
		 clearLnbenter = setTimeout(lnbClear, depth1_d_time);
	});
	$(lnbS).bind('mouseenter keyup' , function()	{
		$(this).parent().parent().parent().addClass("active").siblings().removeClass("active");
		$(this).addClass("active");
		clearTimeout(clearLnbenter);
	});
	$(lnbS).bind('mouseout blur' , function()	{
		 clearLnbenter = setTimeout(lnbClear, depth1_d_time);
		//$(this).parent().parent().parent().removeClass("active");
		//lnbClear();
	});

	$('.snsDrop').hide();

	$('.closetotMenuT').click(function(event) {
		$('.totMenuT').hide();
		$('.gnbTotMenu').focus();
		return false;
	});
	$('.gnbTotMenu').click(function(event) {
		$('.totMenuT').slideToggle();
		return false;
	});


	//snsToogle
	var snsDrop = $('.snsDrop');
	$('.snsToggleOpen').bind("click", function(event) {
		$(snsDrop).slideToggle();
	});
	$(snsDrop).parent().on("mouseleave", function(e){
		$(snsDrop).hide();
	});

	$(".snsToggleOpen").on("focusout keydown", function(e){
		if(e.type="focusout" && (e.shiftKey && e.keyCode == 9)){ //shift tab 과 포커스아웃할때 숨김
			$(snsDrop).hide();
		}
	});

	$(".CopyClipOpen").bind("keyup", function(event){
		$(snsDrop).hide();
	});


	//퀵메뉴 스크롤링
	var sidebar = $('#quick'); // 해당 요소
    b_width = $(document.body).width(); //페이지 전체크기
    d_width = $("body").width(); //본문 전체 크기임
    window_height = $(window).height(); //본문 전체 크기임
    t_height = $(document.body).scrollTop(); //상단 높이
    width = (b_width - d_width) <= 0 ? 900 : b_width/2 - 610; //중앙에서 어느 위치에 놓을지 적는다.
    height = t_height + 0; //상단부터 띄워야 하는 높이
    sidebar.css({top:height, display:'block'});

	var conLeft;// 본문상단의 lng메뉴 위치감 조정
    var currentPosition = parseInt(sidebar.css("top"));
    $(window).scroll(function() {
	    var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.
        if(window_height < 560){
            sidebar.css({top:0, display:'block'});
        }else{
	    	if (position > 150) {
	    		//스크롤 제한 구역 = 전체높이 - 푸터높이 -  스크롤 높이 - 150 (150을 뺀이유는 퀵메뉴의 top 이 content 종속이라서 )
	    		scrollArea = $(document).height() - $('#footer').innerHeight() - $('#quick').innerHeight() -200
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

		conLeft = parseInt($(".contentSet").offset().left);// 본문상단의 lng메뉴 위치감 조정
    	if (position > 280) {
    		$(".navSet").addClass("lnbTop");
    		$(".navSet").css({"left":conLeft+"px"})
    		$("#gnb").addClass("gnbTop");
    		$(".gnbTop").css({"left":conLeft+"px"})
    		//if (!document.all) console.log(conLeft+"contentSet"+d_width);
    	}else{
    		$(".navSet").removeClass("lnbTop");
    		$("#gnb").removeClass("gnbTop");
    		$("#gnb").css({"left":"0"})
    	}
    });


	var contentH = $("#content").height();
	$(".contentRightMini").height(contentH);
	$(".contentRight").height(contentH);

	 $('.sdate').each(function(i) {
		 var sobjId = $(this).attr("id");
			if (!sobjId) {
				//alert("id 속성값을 지정해주세요.");
				return false;
			}
			var innerhtml="<div class=\"calendarzone\"><input type=\"button\" src=\"/images/common/cal.gif\" alt=\"시작날짜 달력에서 선택\" onclick=\"return showCalendar('"+sobjId+"-lry');\"/><div id=\""+sobjId+"-lry\" class=\"calendarSLayer\"><iframe id=\""+sobjId+"-ifrm\" name=\""+sobjId+"-ifrm\" class=\"calendar-frame\" src=\"/common/layerCalendar.jsp\" title=\"시작 날짜입력 프레임\" frameborder=\"0\" scrolling=\"no\"><\/iframe></div></div>";
			var innerhtml="<div class=\"calendarzone\"><input type=\"button\" src=\"/images/common/cal.gif\" alt=\"시작날짜 달력에서 선택\" onclick=\"return showCalendar('"+sobjId+"-lry');\"/><div id=\""+sobjId+"-lry\" class=\"calendarSLayer\"><iframe id=\""+sobjId+"-ifrm\" name=\""+sobjId+"-ifrm\" class=\"calendar-frame\" src=\"/common/layerCalendar.jsp\" title=\"시작 날짜입력 프레임\" frameborder=\"0\" scrolling=\"no\"><\/iframe></div></div>";
			$(this).after( innerhtml );
			if(($("#content").width()/2) < $(this).position().left){	//중간에서 오른쪽에 있을 경우
				$(this).next().find(".calendarSLayer").css("right", "0");
			}else{
				$(this).next().find(".calendarSLayer").css("left", "0");
			}
	 });

	$('.edate').each(function(i) {
		var eobjId = $(this).attr("id");
		if (!eobjId) {
			//alert("id 속성값을 지정해주세요.");
			return false;
		}
		var innerhtml="<div class=\"calendarzone\"><input type=\"button\" src=\"/images/common/cal.gif\" alt=\"종료날짜 달력에서 선택\"  onclick=\"return showCalendar('"+eobjId+"-lry');\"/><div id=\""+eobjId+"-lry\" class=\"calendarSLayer\"><iframe id=\""+eobjId+"-ifrm\" name=\""+eobjId+"-ifrm\" class=\"calendar-frame\" src=\"/common/layerCalendar.jsp\" title=\"종료 날짜입력 프레임\" frameborder=\"0\" scrolling=\"no\"><\/iframe></div></div>";
		$(this).after( innerhtml );
		if(($("#content").width()/2) < $(this).position().left){	//중간에서 오른쪽에 있을 경우
			$(this).next().find(".calendarSLayer").css("right", "0");
		}else{
			$(this).next().find(".calendarSLayer").css("left", "0");
		}
	});


	/* 배너존 */
	function adPlay(){
		$(".banner .area ul").carouFredSel({
				align       : "left",
				//width		: 840, //전체 너비
				height	: 60, //전체 높이
				items		: {
					visible : 6 //보여질 갯수
					},
				scroll      : {
					items		:1, //스크롤링할 갯수
					duration        : 500, //시간
					pauseOnHover	: true //마우스오버시 일시정지기능 마우스 아웃시 자동재생됨
					},
				prev:{
					button : '.banner_pre',
					wipe : true, //로테이션 허용(리스트 처음에서 클릭시 마지막요소로 이동)
					pauseOnHover:false
				},
				next: {
					button :'.banner_next',
					wipe : true,
					pauseOnHover:false
				},
				direction	: "left"
		}).parent().css("margin", "auto");
	}
	$(".banner .area ul img").each(function(index) {
		$(this).load(function(){
			$(this).width($(this).width())
		})
	});
	// Create new image
	var img = new Image();
	var imageSrc = $(".banner .area ul img:last").attr('src');
	img.onload = function() {
		adPlay();
	};

	img.src = imageSrc;

	$('.banner_play').hide();
	$(".banner_play").click(function() {
		$(".banner_zone_area ul").trigger("play");
		$('.banner_stop').show();
		$(this).hide();
		return false;
	});
	$('.banner_stop').click(function() {
		$(".banner .area ul").trigger("pause", true);
		$('.banner_play').show();
		$(this).hide();
		return false;
	});
	//주메뉴와 LNB 왼쪽위치
	$(window).on("resize", function(){
		$(".lnbTop").css({"left": $(".contentSet").offset().left+"px"});
		$(".gnbTop").css({"left": $(".contentSet").offset().left+"px"});
	});



});


//달력
function showCalendar(ele){
	var ele = document.getElementById(ele);
	if(ele.style.display != 'block'){
		$(".calendarSLayer").hide();
		ele.style.display ="block";
		ele.style.zIndex = "100";

	}else{
		ele.style.display ="none";
		ele.style.zIndex = "0";
	}
	return false;
}

function windowOpen () {
	var nUrl; var nWidth; var nHeight; var nLeft; var nTop; var nScroll;
	nUrl = arguments[0];
	nWidth = arguments[1];
	nHeight = arguments[2];
	nScroll = (arguments.length > 3 ? arguments[3] : "no");
	nLeft = (arguments.length > 4 ? arguments[4] : (screen.width/2 - nWidth/2));
	nTop = (arguments.length > 5 ? arguments[5] : (screen.height/2 - nHeight/2));

	winopen=window.open(nUrl, 'sns_win', "left="+nLeft+",top="+nTop+",width="+nWidth+",height="+nHeight+",scrollbars="+nScroll+",toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no");
}

function facebookOpen() {
	var link = encodeURIComponent(location.href);
	var url = "http://www.facebook.com/sharer.php?u=" + link;
	//windowOpen (url, 500, 300, 'no');
	windowOpen (url, 900, 450, 'no');
	return false;
}
//twitter

function twitterOpen() {
	var titl = encodeURIComponent(document.title);
	var link = encodeURIComponent(location.href);

	var url = "http://twitter.com/share?text=" + titl + "&url=" + link;
	windowOpen (url, 800, 400, 'yes');
	return false;
}