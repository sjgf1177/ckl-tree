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
	
	//roll over
	$(".rv a").bind('mouseover keyup' , function()    { imgOn($(this))})
	$(".rv a").bind('mouseout blur' , function()    { imgOff($(this))})

	$(".gnbOpen a").click(function () {
		$(".gnbSet").show();
		return false;
	});
	$(".closetotMenuT").click(function () {
		$(".gnbSet").hide();
		$(".gnbOpen a").focus();
		return false;
	});


	$('.closetotMenuT').click(function(e) {
		$('.totMenuT').hide();
	});
	$('.gnbTotMenu').click(function(e) {
		$('.totMenuT').slideToggle();
		return false;
	});
	$('#skipNav').click(function(e) {
		$('.totMenuT').show();
		$('.gnbHome').focus();
		alert("bbb");
		return false;
	});

	var totHeightNum = $("#wrap").height()+130;
	$('.gnbSet').height(totHeightNum);
	$('.gnb').height(totHeightNum - $(".gnbLink").height());
});



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
		jQuery(this).find('>a').bind('click', function () {
			clearTimeout(clearenter);
			menuover = true;
			if(jQuery(this).parent().hasClass('hover') || jQuery(this).parent().hasClass('on')){
				jQuery(this).parent().removeClass('hover');
				jQuery(this).parent().removeClass('on');
			}else{
				jQuery(this).parent().addClass("hover").siblings().removeClass("hover");
			}
			jQuery(this).parent().siblings().removeClass("on");
		});
		//add mouseOut
		jQuery(this).bind('blur focusout', function () {
			//menuover = false;
			//clearenter = setTimeout(menuclear, depth1_d_time);
		});
	});

	function menuclear() {//first seting
		if (subMenuOpenIng==true) {
			if (!menuover) {
				gnb_link_depth1.removeClass("on");
				gnb_link_depth1.removeClass("hover");
				// imgOff(gnb_link_depth1)
				jQuery(gnb_link_depth1[current_menu]).addClass('on')
			}
		};
		if (subMenuOpenIng==false) {
			gnb_link_depth1.removeClass('on');
			gnb_link_depth1.removeClass('hover');
			jQuery(gnb_link_depth1[current_menu]).addClass('on')
		};
	}
	gnb_link_depth1.find('li:last-child').addClass('last')
	gnb_link_depth2.each(function () {//2depth action
		//add mouseOver
		jQuery(this).bind('keyup', function () {
			clearTimeout(clearenter);
			menuover = true;
			jQuery(this).addClass("on").siblings().removeClass("on");
			//imgOn(jQuery(this));
		});
		//add mouseOut
		jQuery(this).bind('blur', function () {
			//clearenter = setTimeout(menuclear, d_time);
			//imgOff(jQuery(this));
			jQuery(this).removeClass("on");
			menuover = false;
		});
	});


	//nav
	$('.navAll>ul>li').not(':has(ul)').addClass('notul')
	depth1 = $('.navAll>ul>li').has('ul')
	depth1.find('>a').each(function (index) {
		$(this).after('<button>하위메뉴 토글</button>')
	})
	depth1ToggleBtn = $('.navAll>ul>li>button')
	depth1ToggleBtn.each(function (index) {
		$(this).click(function(){
			$(this).parent('li').toggleClass('on').siblings().removeClass('on')
		})
	})

	$('.navAllOpen').click(function(){
		$('.navAll').show().addClass('on');
		$('.navAllbg').show();
	})
	$('.navAllClose,.navAllbg').click(function(){
		$('.navAll').hide().removeClass('on');
		$('.navAllbg').hide();
	})
	setTimeout(500,$('.navAllbg').height($('html').height()));
	setTimeout(500,$('.navAllClose').height($('html').height()));
	$('.navOpen').click(function(){
		$('.navList').toggleClass('active');
		$('.navListbg').toggle();
		$(this).toggleClass('on');
	})
	if ($('.navList li').length%2==1) {$('.navList li:last').addClass('last')};
	if ($('.subNav a').length%2==1) {$('.subNav div>span:last').addClass('last')};
	
});

/*
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
});*/
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