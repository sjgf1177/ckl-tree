/* READY FUNCTION */

$(document).ready(function() {

	var lnbBtn = $('#lnb ul');
	var lnbDp1 = $('#lnb>ul>li');
	var lnbclearenter;

	function lnbmenuclear() {//first seting
		if (menuover) {
			return false;
		}else{
			lnbDp1.removeClass("on");
		}
	}

	lnbBtn.each(function(){ //레프트 메뉴
		$(this).parent().has('ul').addClass("hasList");
		//add mouseOver
		$(this).find('a').bind('mouseenter keyup focusin' , function()    {
			menuover=true;
			clearTimeout(lnbclearenter);
			if ($(this).parent().has('ul').length)
			{
				$(this).parent().addClass("on").siblings().removeClass("on");
				return false;
			}
		});
        $(this).find('a').bind('mouseleave blur' , function()    {
			menuover = false;
			lnbclearenter = setTimeout(lnbmenuclear, 800);

        });
	});


	$('.snsDrop').hide();
	$('.closetotMenuT').click(function(event) {
		$('.totMenuT').hide();
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

/*
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

*/

	/* 배너존 
	function adPlay(){
		$(".banner .area ul").carouFredSel({
				align       : "left",
				//width		: 840, //전체 너비
				height	: 60, //전체 높이
				items		: {
					visible : 7 //보여질 갯수
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
	})*/
});


//달력
/*function showCalendar(ele){
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
}*/