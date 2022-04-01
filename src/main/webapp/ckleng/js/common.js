// JavaScript Document

//common rollover image
function imgOn(item) {
	var image = item.find("img");
	var imgsrc = jQuery(image).attr("src");
	if (jQuery(image).length) {
		for (var i = 0; i < image.length; i++) {
			var imgsrc = jQuery(image[i]).attr("src");
			var off = imgsrc.replace(/off/, "on");
			jQuery(image[i]).attr("src", off);
		}
	}
}
function imgOff(item) {
	var image = item.find("img");
	for (var i = 0; i < image.length; i++) {
		var imgsrc = jQuery(image[i]).attr("src");
		var off = imgsrc.replace(/on/, "off");
		jQuery(image[i]).attr("src", off);
	}
}
jQuery(function () {
	/*// 퀵메뉴 스크롤
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
	    		scrollArea = $(document).height() - $('#footer_wrap').innerHeight() - $('#quick').innerHeight() -150
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
    });*/

	//roll over
	$(".rv a").bind('mouseover keyup' , function()    { imgOn($(this))})
	$(".rv a").bind('mouseout blur' , function()    { imgOff($(this))})

	//hgroup 겹침현상 해결
	if ($('.hgroup h1 span').width()+$('.hgroup p').width()>770) {
		$('.hgroup').addClass('hgroup-type2')
	}

	/*//gnb 시작
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
	$('#bg_gnb').each(function(index) {
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
			// imgOff(gnb_link_depth1);
			// imgOn(jQuery(this));
			if (jQuery(this).parent().attr('id')=='gnb3') {
				$('#bg_gnb').hide();
			}else{
				$('#bg_gnb').show();
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
				$('#bg_gnb').hide()
				jQuery(gnb_link_depth1[current_menu]).addClass('on')
			}
		};
		if (subMenuOpenIng==false) {
			$('#bg_gnb').hide()
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
	});*/
});


jQuery(function($){

	var article = $('.faq>ul>.article');
	article.addClass('hide');
	article.find('.a').hide();
	//article.eq(0).removeClass('hide');
	//article.eq(0).find('.a').show();
	$('.faq>ul>.article>.q>a').click(function(){
		var myArticle = $(this).parents('.article:first');
		if(myArticle.hasClass('hide')){
			article.addClass('hide').removeClass('show');
			//article.find('.a').slideUp(100);
			article.find('.a').hide();
			myArticle.removeClass('hide').addClass('show');
			myArticle.find('.a').show();
			//myArticle.find('.a').slideDown(100);
		} else {
			myArticle.removeClass('show').addClass('hide');
			myArticle.find('.a').hide();
		}
		return false;
	});
});

$(function(){
	$(".bbs_photo1 .button a").click(function () {
		$(this).parent().parent().find(".con_hid").toggleClass("on");
		$(this).find("span.arr").toggleClass("on");
		$(this).find("span.arr").empty().append("접기");
		$(this).find("span.arr.on").empty().append("더보기");
		return false;
	})

});

$(function(){
	$(".explain .btn").click(function () {
		$(".btn_box>p").addClass("fb");
		$(this).parent().parent().find(".btn_box").toggleClass("on");
		$(this).find("span.arr").toggleClass("on");
		$(this).find("span.arr").empty().append("해설서 보기");
		$(this).find("span.arr.on").empty().append("해설서 닫기");
		return false;
	})
})

$(function(){
	$(".service_type02 .tabnavi4 li").each(function(i) {
		$(this).click(function() {
			$(".service_type02 .tabnavi4 li").removeClass("on");
			//$(this).find("href")
			setTab($(this),i);

			return false;

		});
	});

	function setTab(obj,i) {
		$(obj).addClass("on");
		$(".service_type02 .service_area>div").each(function(x) {
			if(i==x) {
				$(this).css("display","block");
			}else{
				$(this).css("display","none");
			}
		});
	}
});

$(function(){
	$("div.Tab:first").show();
	$("div.Tab.hid:first").hide();
	$(".tab7 ul li:first").addClass("on");
	//$("div.Tab").show();
	$(".histab, .tab7").find("li a").bind("click focus", function(e) {
		var tabId = $(this).parent().attr("id");
		var tabIndex = tabId.substring(tabId.length - 2);
		$(".histab, .tab7").find("li").each(function() {
			if (tabId == $(this).attr("id")) {
				$(this).addClass("on");
			} else {
				$(this).removeClass("on");
			}
		});
		$(".Tab").each(function() {
			var TabId = $(this).attr("id");
			var TabIndex = TabId.substring(TabId.length - 2);
			if (tabIndex == TabIndex) {
				$(this).show();
			} else {
				$(this).hide();
			}
		});

		return false;
	});
});
/*
$(function(){
		$(".layerLink a").click(function () {
			$(this).parent().parent().find(".layer_pop_wrap, .layer_pop_wrap1").toggle();
			//$(this).parent().find(".layer_pop_wrap").toggle();
			return false;
		});
		$(".layer_pop_wrap .close a, .layer_pop_wrap .close1 a").click(function () {
			$(".layer_pop_wrap").hide();
			return false;
		});

		$(".b_sch2").click(function () {
			if( $('.t_sch').css('display') != 'none' ){
				var form = document.frmSearch;
				if(!form.q.value){
					alert("검색어를 입력하세요.");
					$("#q")[0].focus();
					return false;
				}
				return true;
			}
			else{
				$(this).hide();
				$('.t_sch').show();
			}

		});

		$(".tabC li").click(function () {
			$(".tabC li").removeClass("on");
			$(this).addClass("on");
		});

		$(".photoV a").click(function () {
			$(".photoV  .photoV_area").hide();
			$(this).parents('li').find(".photoV_area").show();
			return false;
		});
		$(".photoV a:first").trigger('click')
});
*/