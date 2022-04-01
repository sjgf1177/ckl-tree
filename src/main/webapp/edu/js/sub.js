/* --------------------------------------------
 READY FUNCTION
-------------------------------------------- */
$(document).ready(function() {
	$('#content *').each(function(index, el) {
		$(this).on('focus', function(event) {
			// event.preventDefault();
			scrolltopPosition = $(window).scrollTop() + 120 //102은 navi 높이
			thisPosition = $(this).offset().top
			// console.log(scrolltopPosition , ' vs ' , thisPosition)
			if (scrolltopPosition > thisPosition) {
				var y = thisPosition-120
				window.scrollTo(0,y)
			};
		});
	});

	var lnbF = $("#lnb li");
	var lnbS = $("#lnb li li");
	var lnb_wrap = $("#lnb");
	var lnb_dp1=$("#lnb>ul>li");	// 1depth
	var currentLnb;
	var subLnbOpenIng = false;
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


	$(lnbF).bind('mouseover focusin' , function()	{
		$(this).parent().siblings().removeClass("active");
		$(this).addClass("active").parent().siblings().find("a").removeClass("active");
	});
	$(lnbF).bind('mouseout focusout' , function()	{
	  $(this).removeClass("active");
	});
	$(lnbS).bind('mouseenter focusin' , function()	{
		$(this).parent().parent().parent().addClass("active").siblings().removeClass("active");
		$(this).addClass("active");
	});
	$(lnbS).bind('mouseout focusout' , function()	{
		$(this).parent().parent().parent().removeClass("active");
		lnbClear();
	});





	$('.closetotMenuT').click(function(event) {
		$('.totMenuT').hide();
		$('.gnbTotMenu').focus();
	});
	$('.gnbTotMenu').click(function(event) {
		$('.totMenuT').slideToggle();
		return false;
	});

	//snsToogle
	var snsDrop = $('.snsDrop');
	$('.snsToggleOpen').on("click", function() {
		$(snsDrop).slideToggle();
	});

	/*$(".snsToggleOpen").on("focusout keydown", function(e){
		if(e.type="focusout" && (e.shiftKey && e.keyCode == 9)){ //shift tab 과 포커스아웃할때 숨김
			$(snsDrop).hide();
		}
	});
	$(snsDrop).parent().on("mouseleave", function(e){
		$(snsDrop).hide();
	});*/

	/*$(".CopyClipOpen").bind("keyup", function(event){
		$(snsDrop).hide();
	});*/

	// skip contents
	$('.skipContents').click(function(e) {
		e.stopPropagation();
		var target = $(this).attr('href');
		var delay = 200;
		$('html,body').animate({scrollTop:0}, delay);
		$(".snsToggleOpen").focus();
		return false;
	});



	//퀵메뉴 스크롤링
	function quick(){
		try{
			var quick_menu = $('#quick');
			var quick_menu_bg = $('.quickSet');
			var footerPos = $("#footer");
			var footPosH = footerPos.offset().top - 600;//푸터의 높이값 + 퀵메뉴의 높이값
			var quick_top = 70;



			quick_menu.css('top', $(window).height);
			quick_menu.animate({"top": $(document).scrollTop() + quick_top + "px"}, 500);
			quick_menu_bg.css({"height": $(document).scrollTop() + quick_top + "px"});

			$(window).scroll(function(){
				if($(document).scrollTop() < footPosH){
					quick_menu.stop();
					quick_menu.animate({"top" : $(document).scrollTop() + quick_top + "px"}, 1000);
					quick_menu_bg.css({"height": $(document).scrollTop() + quick_top + "px"});
				}

			});
		}catch(err){

		}
	}
	quick();
});




var $win = $(window),
	sTop,
	wH,
	scrollIndex = 0,
	htmlclass = $("html").prop("class");

	function onScroll() {
		sTop = $win.scrollTop();
		if(sTop < 100) {
			$('#header').removeClass('headerTopOn');
			$('.navSet').removeClass('lnbTop');
			$("#wrap").css("padding-top", "0");
			//$('.headerCts').hide();
			//$(".scrolling").fadeOut();
		}else{
			$('#header').addClass('headerTopOn');
			$('.navSet').addClass('lnbTop');
			$("#wrap").css("padding-top", "120px");
			//$('.headerCts').slideDown();
			//$(".scrolling").fadeIn();
		}
	}
	function scrollPage(num) {
		var dur = 750;
		if(num == 0) {
			var targetAxis = 0;
		} else if(num == 1) {
			var targetAxis = 660;
		}
		// console.log(num);
		$("body, html").stop().animate({
			scrollTop : targetAxis
		}, {
			duration : dur,
			easing : "easeOutCubic",
			queue : false
		});
	}

	/*$win.on("mousewheel", function(e) {
		if($("body").is(":animated") || $("html").is(":animated") ) {
			return false;
		}
	});*/

	$win.on("scroll", function() {
		onScroll();
	});


	$( "*" ).delegate( "*", "focusin", function(e) {
		e.stopPropagation();
		if($("*").is(":focus")){
			/*
	 		console.log($(this).position().top+"_현재 포커스의 위치값_"+$(this).position().left
	 			+"///offset Top"+$(this).offset().top
	 			+" offset left:"+$(this).offset().left)
	 		*/
	 	};
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
	});*/
	});






$(document).ready(function() {

	 $('.sdate').each(function(i) {
		 var sobjId = $(this).attr("id");
		 var title = $(this).attr('title') && $(this).attr('title') != "" ? $(this).attr('title') : "시작날짜 입력";
			if (!sobjId) {
				//alert("id 속성값을 지정해주세요.");
				return false;
			}
			var innerhtml="<div class=\"calendarzone\"><input type=\"button\" src=\"/images/common/cal.gif\" title=\""+title+" 선택\" onclick=\"return showCalendar('"+sobjId+"-lry');\"/><div id=\""+sobjId+"-lry\" class=\"calendarSLayer\"><iframe id=\""+sobjId+"-ifrm\" name=\""+sobjId+"-ifrm\" class=\"calendar-frame\" src=\"/common/layerCalendar.jsp\" title=\""+title+" 프레임\" frameborder=\"0\" scrolling=\"no\"><\/iframe></div></div>";
			$(this).after( innerhtml );
			if(($("#content").width()/2) < $(this).position().left){	//중간에서 오른쪽에 있을 경우
				$(this).next().find(".calendarSLayer").css("right", "0");
			}else{
				$(this).next().find(".calendarSLayer").css("left", "0");
			}
	 });

	$('.edate').each(function(i) {
		var eobjId = $(this).attr("id");
		var title = $(this).attr('title') && $(this).attr('title') != "" ? $(this).attr('title') : "종료날짜 입력";
		if (!eobjId) {
			//alert("id 속성값을 지정해주세요.");
			return false;
		}
		var innerhtml="<div class=\"calendarzone\"><input type=\"button\" src=\"/images/common/cal.gif\" title=\""+title+" 선택\"  onclick=\"return showCalendar('"+eobjId+"-lry');\"/><div id=\""+eobjId+"-lry\" class=\"calendarSLayer\"><iframe id=\""+eobjId+"-ifrm\" name=\""+eobjId+"-ifrm\" class=\"calendar-frame\" src=\"/common/layerCalendar.jsp\" title=\""+title+" 프레임\" frameborder=\"0\" scrolling=\"no\"><\/iframe></div></div>";
		$(this).after( innerhtml );
		if(($("#content").width()/2) < $(this).position().left){	//중간에서 오른쪽에 있을 경우
			$(this).next().find(".calendarSLayer").css("right", "0");
		}else{
			$(this).next().find(".calendarSLayer").css("left", "0");
		}
	});


	/*$(".schOps").click(function(){
		$(".globalSchSet").slideDown(function(){
			$(".schWordInput").focus();
		});
		return false;
	});

	$(".schGlobalCloser").click(function(){
		$(".globalSchSet").slideUp(function(){
			$(".schOps").focus();
			return false;
		});
	});
	$(".menuOps").focusin(function(e){
		$(".globalSchSet").slideUp("fast");
		return false;
	})*/



	$(".copyClipOpen").click(function(){
		$(".copyClipSet").slideDown(function(){
			$(".copyClipText").focus();
		});
		return false;
	});

	$(".winPrintOpen").focusin(function(e){
		$(".copyClipSet").slideUp("fast");
		return false;
	})

});

//달력
function showCalendar(ele){
	var ele = document.getElementById(ele);
	$(".calendarSLayer").hide();
	if(ele.style.display != 'block'){
		ele.style.display ="block";
		ele.style.zIndex = "100";
	}else{
		ele.style.display ="none";
		ele.style.zIndex = "0";
	}
	return false;
}


//셀렉트박스 페이지 이동
function fnGoLinkSite(e){
	if (!e.link.value)
	{
		alert("선택된 사이트가 없습니다.");
		return false;
	}
	else {
		e.action = e.link.value;
		return true;
	}
}


function winPopup1(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
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
