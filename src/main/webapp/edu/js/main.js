/* READY FUNCTION */
$(document).ready(function() {
	$('.closetotMenuT').click(function(event) {
		$('.totMenuT').hide();
		$('.gnbTotMenu a').focus();
		return false;
	});
	$('.gnbTotMenu a').click(function(event) {
		$('.totMenuT').slideToggle();
		return false;
	});


	var m1RollObj = $('#m1Roller>div');
	var m1RollNum = $('#m1Roller').find('div').length;
	function menuclear() {
	 	if(m1RollNum == 1){
	 		$('.m1R_0').addClass('selected');
	 	}else if(m1RollNum == 2){
	 		$('.m1R_1').addClass('selected');
	 	}else if(m1RollNum == 3){
	 		$('.m1R_2').addClass('selected');
	 	}
	}
	menuclear();

	$(m1RollObj).find('a').bind('mouseover focusin' , function()	{
		$(this).parent().siblings().removeClass("selected");
		$(this).parent().addClass("selected");
	});
	/*$(m1RollObj).bind('mouseout focusout' , function()	{
	 	 $(this).removeClass("selected");
			menuclear();
	});*/

	$('#m1Roller').carouFredSel({
		width: '100%',
		auto: true,
		align: "center",
		items: {
			visible: 3,
			start: 1
		},
		pauseOnHover: true,
		scroll: {
			items: 1,
			duration: 1000,
			pauseOnHover: true,
			timeoutDuration: 5000,
			onBefore: function( data ) {
				data.items.old.eq(1).removeClass('selected');
				//console.log(data.items.old.eq(2).find('img').attr("title"));
				//data.items.old.eq(1).find('.descTts span').text(data.items.old.eq(1).find('img').attr('title'));
				data.items.visible.eq(1).addClass('selected');
			}
		},
		prev: '#prevm1Roller',
		next: '#nextm1Roller',
		play: '#m1RollerPlay',
		pause:'#m1RollerStop'
		/*pagination: {
			container: '#pagerm1Roller'
		}*/
	});
	$("#m1RollerPlay").hide();
	$("#m1RollerPlay").click(function(){
		$(this).hide();
		$("#m1RollerStop").show();
		$('#m1Roller').trigger("play", true); //재생
	});
	$("#m1RollerStop").click(function(){
		$(this).hide();
		$("#m1RollerPlay").show();
		$('#m1Roller').trigger("pause", true); //정지
	});
	$('#m1Roller a').bind("focus", function(e){
		$('#m1Roller').trigger("pause", true); //정지
	})

	//m2RollingSet
	$('#m2Tabs').carouFredSel({
		circular: false,
		items: 1,
		infinite: true,
		width: '100%',
		auto: false,
		scroll: {
			items: 1,
			duration: 1500
		},
		pagination: {
			container: '#m2Setpager',
			anchorBuilder: function( nr ) {
				return '<a href="javascript:void(0);">' + $(this).find('h3').text() + '</a>';
			}
		}
	});

	//m2Rlling2
	var $pagers21 = $('#m21Pager a');
	var _onBefore21 = function() {
		$(this).find('img').stop().fadeTo( 300, 1 );
		$pagers21.removeClass( 'selected' );
	};
	$('#m21Roller').carouFredSel({
		items: 3,
		width: '100%',
		auto: false,
		scroll: {
			duration: 750
		},
		prev: {
			button: '#m21prev',
			items: 1,
			onBefore: _onBefore21
		},
		next: {
			button: '#m21next',
			items: 1,
			onBefore: _onBefore21
		}
	});



//m2Rlling2
	var $pagers22 = $('#m22Pager a');
	var _onBefore22 = function() {
		$(this).find('img').stop().fadeTo( 300, 1 );
		$pagers22.removeClass( 'selected' );
	};
	$('#m22Roller').carouFredSel({
		items: 3,
		width: '100%',
		auto: false,
		scroll: {
			duration: 750
		},
		prev: {
			button: '#m22prev',
			items: 1,
			onBefore: _onBefore22
		},
		next: {
			button: '#m22next',
			items: 1,
			onBefore: _onBefore22
		},
	});

	//키보드 이동시 해당 탭 이동
	$('#m2Setpager > a:eq(1)').click();


	//m2RollingSet
	$('#m3Tabs').carouFredSel({
		circular: false,
		items: 1,
		width: '100%',
		auto: false,
		scroll: {
			items: 1,
			duration: 1500
		},
		pagination: {
			container: '#m3Setpager',
			anchorBuilder: function( nr ) {
				return '<a href="javascript:void(0);">' + $(this).find('h3').text() + '</a>';
			}
		}
	});


	//m2Rlling2
	var $pagers30 = $('#m30Pager a');
	var _onBefore30 = function() {
		$(this).find('img').stop().fadeTo( 300, 1 );
		$pagers30.removeClass( 'selected' );
	};
	$('#m30Roller').carouFredSel({
		items: 3,
		width: '100%',
		auto: false,
		scroll: {
			duration: 750
		},
		prev: {
			button: '#m30prev',
			items: 1,
			onBefore: _onBefore30
		},
		next: {
			button: '#m30next',
			items: 1,
			onBefore: _onBefore30
		},
	});



	//m2Rlling2
	var $pagers31 = $('#m31Pager a');
	var _onBefore31 = function() {
		$(this).find('img').stop().fadeTo( 300, 1 );
		$pagers21.removeClass( 'selected' );
	};
	$('#m31Roller').carouFredSel({
		items: 3,
		width: '100%',
		auto: false,
		scroll: {
			duration: 750
		},
		prev: {
			button: '#m31prev',
			items: 1,
			onBefore: _onBefore31
		},
		next: {
			button: '#m31next',
			items: 1,
			onBefore: _onBefore31
		},
	});



	//m2Rlling2
	var $pagers32 = $('#m32Pager a');
	var _onBefore32 = function() {
		$(this).find('img').stop().fadeTo( 300, 1 );
		$pagers32.removeClass( 'selected' );
	};
	$('#m32Roller').carouFredSel({
		items: 3,
		width: '100%',
		auto: false,
		scroll: {
			duration: 750
		},
		prev: {
			button: '#m32prev',
			items: 1,
			onBefore: _onBefore32
		},
		next: {
			button: '#m32next',
			items: 1,
			onBefore: _onBefore32
		},
	});










	$("div[id*=menu]").each(function(index, element) {
			//console.log($("#menu"+index+" a:visible").is(":focus"));
			// $("#menu"+(index+1)+" a:visible:last").bind("focusout",	function(e){
			// 	if($("#menu"+(index)+" a:visible").is(":focus")) {
			// 		scrollPage(index);
			// 		return false;
			// 	}else{
			// 		scrollPage(index+1);
			// 		return false;
			// 	}
			// });

			$("#menu"+(index+1)+" a:visible:last,"+"#menu"+(index+1)+" button").bind("focus",	function(e){
				// console.log(index,'this = ',this.text())

				if($("#menu"+(index)+" a:visible").is(":focus")) {
					scrollPage(index-1);
					return false;
				}else{
					scrollPage(index);
					return false;
				}
			});

			//키보드 체크로 화면 강제 보이도록 설정
			$("#menu"+(index+1)+" a").keydown(function(e){
				if((e.shiftKey && e.keyCode == 9) ||  e.keyCode == 9 ){
					$(".animated").addClass("animatedKey");
				}

			});

			$(".noticeAresToggle").click(function(e) {
			    $('.noticeAreaSet').toggleClass('statusOff');
			    $('.noticeWrap').toggleClass('open');
			    $('#visualText').toggleClass('fadeOut');
				return false;
			});
	});

	/* SCROLL NAVIGATION */
		$('.scroll').bind('click', function(event) {
			var $anchor = jQuery(this);
			var headerH = jQuery('#navigation').outerHeight();
			//console.log($($anchor.attr('href')).offset().top - 100 + "px")
			//console.log('=============')
				$('html, body').stop().animate({
					scrollTop : $($anchor.attr('href')).offset().top - 70+ "px"
				}, 1200, 'easeInOutExpo');
			event.preventDefault();
		});

	/*  MENU HIDE AFTER CLICK --  mobile devices */
		$('.nav li a').click(function () {
			 $('.navbar-collapse').removeClass('in');
		});

	/* FIXED MENU ON SCROLL */
		$("#sticky-section").sticky({topSpacing:0});

	/* --------------------------------------------
	 ANIMATED ITEMS
	-------------------------------------------- */
		var ie8youtubeChk = false;

		$('.animated').appear(function() {
			var elem = $(this);
			var animation = elem.data('animation');
			if ( !elem.hasClass('visible') ) {
				var animationDelay = elem.data('animation-delay');
				if ( animationDelay ) {

				if( navigator.appName.indexOf("Microsoft") > -1 ) // IE
				{
					if( navigator.appVersion.indexOf("MSIE 9") > -1 || navigator.appVersion.indexOf("MSIE 8") > -1 || navigator.appVersion.indexOf("MSIE 7") > -1) // IE8
					{
						setTimeout(function(){ elem.addClass( animation + " visible" );}, 0);
					}else{
						setTimeout(function(){ elem.addClass( animation + " visible" );}, animationDelay);	 //IE9 이상
					}
				}else{
					setTimeout(function(){ elem.addClass( animation + " visible" );}, animationDelay);//IE가 아니면
				}

				} else {
					elem.addClass( animation + " visible" );
				}
			}
			if (elem.hasClass('movie') ) {
				if( navigator.appName.indexOf("Microsoft") > -1 ) // IE
				{
					if( navigator.appVersion.indexOf("MSIE 9") > -1 || navigator.appVersion.indexOf("MSIE 8") > -1 || navigator.appVersion.indexOf("MSIE 7") > -1) // IE8
					{
						if (ie8youtubeChk==false) {
							$('iframe').each(function() {
								var url = $(this).attr("src");
								$(this).attr("src",url);
							});
							ie8youtubeChk = true;
						};
						// alert('ie8')
					}else{
						//IE9 이상
					}
				}else{
					//IE가 아니면
				}
			}
		});

	/* 네비게이션 활성화 */
		$('body').scrollspy({
			target: '#parallax',
			offset: 76
		});

	/* --------------------------------------------
	 EFFECT OVERLAY
	-------------------------------------------- */
		if (Modernizr.touch) {
			// show the close overlay button
			$(".close-overlay").removeClass("hidden");
			// handle the adding of hover class when clicked
			$(".img").click(function(e){
				if (!$(this).hasClass("hover")) {
					$(this).addClass("hover");
				}
			});
			// handle the closing of the overlay
			$(".close-overlay").click(function(e){
				e.preventDefault();
				e.stopPropagation();
				if ($(this).closest(".img").hasClass("hover")) {
					$(this).closest(".img").removeClass("hover");
				}
			});
		} else {
			// handle the mouseenter functionality
			$(".img").mouseenter(function(){
				$(this).addClass("hover");
			})
			// handle the mouseleave functionality
			.mouseleave(function(){
				$(this).removeClass("hover");
			});
		}


});



	//https://github.com/jquery/jquery-mousewheel
!function(a){"function"==typeof define&&define.amd?define(["jquery"],a):"object"==typeof exports?module.exports=a:a(jQuery)}(function(a){function b(b){var g=b||window.event,h=i.call(arguments,1),j=0,l=0,m=0,n=0,o=0,p=0;if(b=a.event.fix(g),b.type="mousewheel","detail"in g&&(m=-1*g.detail),"wheelDelta"in g&&(m=g.wheelDelta),"wheelDeltaY"in g&&(m=g.wheelDeltaY),"wheelDeltaX"in g&&(l=-1*g.wheelDeltaX),"axis"in g&&g.axis===g.HORIZONTAL_AXIS&&(l=-1*m,m=0),j=0===m?l:m,"deltaY"in g&&(m=-1*g.deltaY,j=m),"deltaX"in g&&(l=g.deltaX,0===m&&(j=-1*l)),0!==m||0!==l){if(1===g.deltaMode){var q=a.data(this,"mousewheel-line-height");j*=q,m*=q,l*=q}else if(2===g.deltaMode){var r=a.data(this,"mousewheel-page-height");j*=r,m*=r,l*=r}if(n=Math.max(Math.abs(m),Math.abs(l)),(!f||f>n)&&(f=n,d(g,n)&&(f/=40)),d(g,n)&&(j/=40,l/=40,m/=40),j=Math[j>=1?"floor":"ceil"](j/f),l=Math[l>=1?"floor":"ceil"](l/f),m=Math[m>=1?"floor":"ceil"](m/f),k.settings.normalizeOffset&&this.getBoundingClientRect){var s=this.getBoundingClientRect();o=b.clientX-s.left,p=b.clientY-s.top}return b.deltaX=l,b.deltaY=m,b.deltaFactor=f,b.offsetX=o,b.offsetY=p,b.deltaMode=0,h.unshift(b,j,l,m),e&&clearTimeout(e),e=setTimeout(c,200),(a.event.dispatch||a.event.handle).apply(this,h)}}function c(){f=null}function d(a,b){return k.settings.adjustOldDeltas&&"mousewheel"===a.type&&b%120===0}var e,f,g=["wheel","mousewheel","DOMMouseScroll","MozMousePixelScroll"],h="onwheel"in document||document.documentMode>=9?["wheel"]:["mousewheel","DomMouseScroll","MozMousePixelScroll"],i=Array.prototype.slice;if(a.event.fixHooks)for(var j=g.length;j;)a.event.fixHooks[g[--j]]=a.event.mouseHooks;var k=a.event.special.mousewheel={version:"3.1.12",setup:function(){if(this.addEventListener)for(var c=h.length;c;)this.addEventListener(h[--c],b,!1);else this.onmousewheel=b;a.data(this,"mousewheel-line-height",k.getLineHeight(this)),a.data(this,"mousewheel-page-height",k.getPageHeight(this))},teardown:function(){if(this.removeEventListener)for(var c=h.length;c;)this.removeEventListener(h[--c],b,!1);else this.onmousewheel=null;a.removeData(this,"mousewheel-line-height"),a.removeData(this,"mousewheel-page-height")},getLineHeight:function(b){var c=a(b),d=c["offsetParent"in a.fn?"offsetParent":"parent"]();return d.length||(d=a("body")),parseInt(d.css("fontSize"),10)||parseInt(c.css("fontSize"),10)||16},getPageHeight:function(b){return a(b).height()},settings:{adjustOldDeltas:!0,normalizeOffset:!0}};a.fn.extend({mousewheel:function(a){return a?this.bind("mousewheel",a):this.trigger("mousewheel")},unmousewheel:function(a){return this.unbind("mousewheel",a)}})});


var $win = $(window),
	sTop,
	wH,
	scrollIndex = 0,
	htmlclass = $("html").prop("class");

	function onScroll() {
		 //console.log($win.scrollTop());
		sTop = $win.scrollTop();
		if(sTop < 300) {
			$(".scrolling").fadeOut();
		}else{
			$(".scrolling").fadeIn();
			$('.ad').hide();
			$('.adClose').addClass('off');
			$('.header_set').show();
			$('.globalRight, .globalLeft').hide();
		}


		if(sTop < 50) {
			$('#header').removeClass('headerTopOn');
			//$('.headerCts').hide();
			//$(".scrolling").fadeOut();
		}else{
			$('#header').addClass('headerTopOn');
			//$('.headerCts').slideDown();
			//$(".scrolling").fadeIn();
		}
		if(sTop < 200) {
			$('.navSet').removeClass('lnbTop');
		}else{
			$('.navSet').addClass('lnbTop');
		}

		//	console.log(sTop)
		if(sTop > 0) {
			scrollIndex = 0;
			$('#parallax').removeClass('set2').removeClass('set3').removeClass('set4').removeClass('setFooter')
			$(".home_btn_con li").removeClass("animated");
			$('#navigation').hide();

			if(sTop >= 535) { //535
				$('#navigation').show();
				scrollIndex = 1;
				$('#parallax').addClass('set2').removeClass('set3').removeClass('set4').removeClass('setFooter')
				if(sTop >= 1135) {
					scrollIndex = 2;
					$('#parallax').addClass('set3').removeClass('set2').removeClass('set4').removeClass('setFooter')
					//$topBar.addClass("last");
					if(sTop >= 1799) {
						scrollIndex = 3;
						$('#parallax').addClass('set4').removeClass('set2').removeClass('set3').removeClass('setFooter')
						// console.log(sTop)
						if(sTop >= 2599) {
							scrollIndex = 4;
							$('#parallax').addClass('setFooter').removeClass('set4').removeClass('set2').removeClass('set3')

							// if(sTop >= 2790) {
							// 	scrollIndex = 5;
							// }
						}
					}

				} else {
					//opBar.removeClass("last");
				}
			} else {
				//$topBar.removeClass("colored");
			}
		} else {
			//$topBar.removeClass("moving");
		}
	}
	function scrollPage(num) {
		var dur = 750;
		if(num == 0) {
			var targetAxis = 0;
		} else if(num == 1) {
			var targetAxis = 535;
		} else if(num == 2) {
			var targetAxis = 1135;
		} else if(num == 3) {
			var targetAxis = 1799;
		} else if(num == 4) {
			var targetAxis = 2599;
		}
		// else if(num == 5) {
		// 	var targetAxis = 3150;
		// }
		// console.log(num);
		// console.log(targetAxis+':---');

		$("body, html").stop().animate({
			scrollTop : targetAxis
		}, {
			duration : dur,
			easing : "easeOutCubic",
			queue : false
		});
	}
	function nextPage() {
		var toPage = scrollIndex + 1;
		if(toPage > 5) {
			toPage = 5;
		}
		// console.log(toPage)
		scrollPage(toPage);
	}
	function prevPage() {
		var toPage = scrollIndex - 1;
		if(toPage < 0) {
			toPage = 0;
		}
		scrollPage(toPage);
	}



	$win.on("mousewheel", function(e) {
		e.preventDefault();
		e.stopPropagation();
		if($("body").is(":animated") || $("html").is(":animated") ) {
			return false;
		}
		if(e.deltaY < 0) {
			nextPage();
		} else if(e.deltaY > 0) {
			prevPage();
		}
	});

	$win.on("scroll", function() {
		onScroll();
	});


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
