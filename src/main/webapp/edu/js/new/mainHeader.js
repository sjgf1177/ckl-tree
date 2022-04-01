$(function(){
	function checkMobileSize() {
	    var x = $(window).width() + getScrollbarWidth();
	    if (x >= 1200) {
	        return false;
	    } else {
	        return true;
	    }
	}
	
	function getScrollbarWidth() {
	    var outer = document.createElement("div");
	    outer.style.visibility = "hidden";
	    outer.style.width = "100px";
	    outer.style.msOverflowStyle = "scrollbar"; // needed for WinJS apps

	    document.body.appendChild(outer);

	    var widthNoScroll = outer.offsetWidth;
	    // force scrollbars
	    outer.style.overflow = "scroll";

	    // add innerdiv
	    var inner = document.createElement("div");
	    inner.style.width = "100%";
	    outer.appendChild(inner);

	    var widthWithScroll = inner.offsetWidth;

	    // remove divs
	    outer.parentNode.removeChild(outer);

	    return widthNoScroll - widthWithScroll;
	}

	
	$(window).resize(function(){
		isMobileSize = checkMobileSize();
		if(!isMobileSize){
			$("#main_nav").removeClass("show");
			$("#main_nav > ul > li > ul").css({"display":""});
			$("body").css({"position":""});
			$("header").removeClass("active");
		}else{
			$("header").css({"height":"auto"});
			$("nav").removeClass("gnbActive");
			$("header").css({"background":""});
			$(".gnb_menu").css({"display":"inline-block"});
			$(".gnb_close").css({"display":"none"});
		}
	});
	
	/* gnb 메뉴 */
	$(".navbar-nav > li").on('mouseenter', function(){
		if(!$("nav.navbar").hasClass("gnbActive") && !checkMobileSize()){
			$('header').stop().animate({"height":"170px"}, 200);
		}
    });
	$(".navbar-nav > li").on('mouseleave', function(){
		if(!$("nav.navbar").hasClass("gnbActive") && !checkMobileSize()){
			$('header').stop().animate({"height":"145px"}, 200);
		}
    });
	
	/* gnb 메뉴 focus 이동시 메뉴 영역 확장 */
	$(".navbar-nav").on('focusin', function(){
		$('header').stop().animate({"height":"170px"}, 200);
    });
	$(".navbar-nav").off('focusin', function(){
			$('header').stop().animate({"height":"145px"}, 200);
    });
	$(".navbar-nav > li > a").on('focus', function(){
		$(this).parent().addClass("active").siblings().removeClass("active");
	});
	
	$(".gnb_menu").on("click", function(){
		$("nav").addClass("gnbActive");
		$("header").css({"background":"#0480A9"});
		$(".gnb_menu").css({"display":"none"});
		$(".gnb_close").css({"display":"inline-block"});
		$('.gnb_close').attr({"alt":"GNB 메뉴 닫기"});
	})
	
	$("#all_search_label").on("click", function(){
		$(this).addClass("active");
		$(".navbar-nav").css({"display":"none"});
		$(".gnb_menu").css({"display":"none"});
		$(".gnb_close").css({"display":"inline-block"});
		$('.gnb_close').attr({"alt":"통합검색 닫기"});
	});
	
	$(".gnb_close").on("click", function(){
		if($("#all_search_label").hasClass("active")){
			$("#all_search_label").removeClass("active");
			$(".navbar-nav").css({"display":"flex"});
			$(".gnb_menu").css({"display":"inline-block"});
			$(".gnb_close").css({"display":"none"});
			$('.gnb_close').attr({"alt":"GNB 메뉴 닫기"});
		}else{
			$("nav").removeClass("gnbActive");
			$("header").css({"background":""});
			$(".gnb_menu").css({"display":"inline-block"});
			$(".gnb_close").css({"display":"none"});
		}
	});
	
	$("#main_nav > ul > li").on("click", function(){
		if($("#main_nav").hasClass("show")){
			$(this).children("ul").toggle('fast');
		}
	});
	
	$("header .navbar-toggler").on("click", function(){
		if($("header").hasClass("active")){
			$("header").removeClass("active");
		}else{
			$("header").addClass("active");
		}
	});
})