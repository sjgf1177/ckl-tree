var mainRollingObj = {
	isRolling : null
	, $conEl : null
	, $itemList : null
	, $firEl : null
	, $lstEl : null
	, selectIdx : null
	, autoPlay : null
	,init : function(){
		var _this = this;
		this.isRolling = false;
		this.$conEl = $('#mainSubRolling');
		this.$itemList = $('#mainSubRolling .item');
		this.$itemList.each(function(){
			$(this).on('mouseenter', function(){
				_this.setMouseEnterEvent($(this));
			})
		});
		this.selectIdx = $(window).width() >= 768 ? 1 : 0;

		$('.caroufredsel_arrow').on('click', function(){
			_this.setRollingEvent($(this));
		});
		this.setResizeEvent();
		$(this.$itemList[this.selectIdx]).addClass('selected');
		$($('.main_top_rolling_icon .rolling_btn')[this.selectIdx]).addClass('active');
		this.setIntervalEvent();
	}
	, setIntervalEvent : function(){
		var _this = this;
		this.autoPlay = setInterval(function(){
			_this.setRollingEvent($('.caroufredsel_arrow.right'));
		}, 3000);
	}
	, setRollingEvent : function(el){
		if(this.isRolling) return;
		var _this = this;
		this.isRolling = true;
		clearInterval(this.autoPlay);
		this.$itemList = $('#mainSubRolling .item');
		this.$firEl = $(this.$itemList[0]).removeClass('selected').clone().on('mouseenter' , function(){
			_this.setMouseEnterEvent($(this));
		});
		this.$lstEl = $(this.$itemList[this.$itemList.length-1]).removeClass('selected').clone().on('mouseenter' , function(){
			_this.setMouseEnterEvent($(this));
		});
		if(el.hasClass('right')){
			this.$conEl.append(this.$firEl);
			this.$conEl.animate({'left':(-300)+"px"}, 800, function(){
				_this.selectIdx = $(window).width() >= 768 ? 1 : 0;
				$(_this.$itemList[0]).remove();
				_this.$conEl.css({'left':0});
				_this.$itemList.removeClass("selected");
				$($('#mainSubRolling .item')[_this.selectIdx]).addClass('selected');
				_this.updateRollingIcon();
				_this.setIntervalEvent();
				_this.isRolling = false;
			});
		}else{
			this.$conEl.prepend(this.$lstEl);
			this.$conEl.css({"left" : (-300)+"px"});
			this.$conEl.animate({'left':0}, 800, function(){
				_this.selectIdx = $(window).width() >= 768 ? 1 : 0;
				$(_this.$itemList[_this.$itemList.length-1]).remove();
				_this.$itemList.removeClass("selected");
				$($('#mainSubRolling .item')[_this.selectIdx]).addClass('selected');
				_this.updateRollingIcon();
				_this.setIntervalEvent();
				_this.isRolling = false;
			});
		}
	}
	, setMouseEnterEvent : function(el){
		if(this.isRolling)return;
		this.$conEl = $('#mainSubRolling');
		this.$itemList = $('#mainSubRolling .item');
		this.$itemList.removeClass("selected");
		el.addClass('selected');
	}
	,updateRollingIcon : function(){
		var clName = $(this.$conEl.find('.selected'))[0].className;
		var idx = 0;
		if( clName.indexOf('rolling0') != -1){
			idx = 0;
		}else if( clName.indexOf('rolling1') != -1){
			idx = 1;
		}else if( clName.indexOf('rolling2') != -1){
			idx = 2;
		}else if( clName.indexOf('rolling3') != -1){
			idx = 3;
		}else if( clName.indexOf('rolling4') != -1){
			idx = 4;
		}
		$('.main_top_rolling_icon .rolling_btn').removeClass('active');
		$($('.main_top_rolling_icon .rolling_btn')[idx]).addClass('active');
	}
	,setResizeEvent : function(){
		var _this = this;
		$(window).on('resize', function(){
			if($(this).width() >= 768){
				if($('#mainSubRolling .item').index($('#mainSubRolling .item.selected')) != 1){
					$('#mainSubRolling .item').removeClass("selected");
					$($('#mainSubRolling .item')[1]).addClass('selected');
					_this.updateRollingIcon();
				}
			}else{
				if($('#mainSubRolling .item').index($('#mainSubRolling .item.selected')) > 0){
					$('#mainSubRolling .item').removeClass("selected");
					$($('#mainSubRolling .item')[0]).addClass('selected');
					_this.updateRollingIcon();
				}
			}
		})
	}

}
function shuffle(arr){
	if(arr instanceof Array)
	{
		var len = arr.length;
		if(len == 1) return arr;
		var i = len * 2;
		while(i > 0)
		{
			var idx1 = Math.floor(Math.random()* len);
			var idx2 = Math.floor(Math.random()* len);
			if(idx1 == idx2) continue;
			var temp = arr[idx1];
			arr[idx1] = arr[idx2];
			arr[idx2] = temp;
			i--;
		}
	}
	else
	{
		alert("No Array Object");
	}
	return arr;
}

function visualShuffle( arrList ){
	var visualList = $('[class*="main_visual_00"]');
	var originArr = [];

	var shuffleArr = shuffle(arrList);

	for( var i=0; i<visualList.length; i++ ){
		$(visualList[i]).css( "background-image", "url(/edu/images/bm/"+shuffleArr[i]+"_m.jpg)" );
	}
}
var swiper0 = null;
var swiper1 = null;
var swiper2 = null;
var swiper3 = null;
var swiper4 = null;
var swiper5 = null;
var swiper6 = null;
window.onload = function(){

	var visualList = $('[class*="main_visual_00"]');
	var arrList = [];
	for( var i=0; i<visualList.length; i++ ){
		arrList.push("main_visual_img_00" + i);
	}

	visualShuffle( arrList );
	mainRollingObj.init();


	//var eventRolling = new rollingController(eventObjectList, 'event_body_con', 'contents_body');
	//var stepUpRolling = new rollingController(stepUpList, 'step_up_body_con', 'contents_body');
    //setProgramList(eventObjectList);
    //setCareersList(careersList);
    //setSubjectList(subjectObjectList,'#subject_body_con' );
    //setSubjectList(openSubObjectList, '#offjt_body_con');

	swiper0 = new Swiper('#event_body_con', {
		pagination: '#event_body_con .swiper-pagination'
		,loop : true
		,paginationClickable: true
		,direction: 'horizontal' // 슬라이드 진행방향은 수평(vertical하면 수직으로 움직임)
		,slidesPerView: 1 // 한번에 보이는 슬라이드 갯수
		,spaceBetween: 20 // 슬라이드 사이의 간격 px 단위
		,mousewheelControl: true // 마우스 휠로 슬라이드 움직임
		// 더 외 추가 가능 요소들
		,paginationBulletRender: function (swiper, index, className) {
			
			return '<span class="' + className + '" style="margin-top: 30px;"></span>';
		}
	});

	swiper1 = new Swiper('#program_body_con', {
		pagination: '#program_body_con .swiper-pagination'
		,loop : true
		,paginationClickable: true
		,direction: 'horizontal' // 슬라이드 진행방향은 수평(vertical하면 수직으로 움직임)
		,slidesPerView: 1 // 한번에 보이는 슬라이드 갯수
		,spaceBetween: 20 // 슬라이드 사이의 간격 px 단위
		,mousewheelControl: true // 마우스 휠로 슬라이드 움직임
		// 더 외 추가 가능 요소들
		,paginationBulletRender: function (swiper, index, className) {
			return '<span class="' + className + '" style="margin-top: 30px;"></span>';
		}
	});
	swiper2 = new Swiper('#subject_body_con', {
		direction: 'vertical' // 슬라이드 진행방향은 수평(vertical하면 수직으로 움직임)
		,loop : true
		,speed : 500
		,slidesPerView: 3 // 한번에 보이는 슬라이드 갯수
		,spaceBetween: 10 // 슬라이드 사이의 간격 px 단위
		//,mousewheelControl: true // 마우스 휠로 슬라이드 움직임
		,autoplay:3500
		//,pagination: '.swiper-pagination'
		,paginationClickable: true
		,nextButton: '#subject_body_con + .online_btn_con .online_btn_up'
		,prevButton: '#subject_body_con + .online_btn_con .online_btn_down'
		// 더 외 추가 가능 요소들
	});
	swiper3 = new Swiper('#offjt_body_con', {
		direction: 'vertical' // 슬라이드 진행방향은 수평(vertical하면 수직으로 움직임)
		,loop : true
		,speed : 500
		,slidesPerView: 3 // 한번에 보이는 슬라이드 갯수
		,spaceBetween: 10 // 슬라이드 사이의 간격 px 단위
		//,mousewheelControl: true // 마우스 휠로 슬라이드 움직임
		,autoplay:3500
		//,pagination: '.swiper-pagination'
		,nextButton: '#offjt_body_con + .online_btn_con .online_btn_up'
		,prevButton: '#offjt_body_con + .online_btn_con .online_btn_down'
		,paginationClickable: true
		// 더 외 추가 가능 요소들
	});
	swiper4 = new Swiper('#step_up_body_con', {
		pagination: '#step_up_body_con .swiper-pagination'
		,loop : true
		,paginationClickable: true
		,direction: 'horizontal' // 슬라이드 진행방향은 수평(vertical하면 수직으로 움직임)
		,slidesPerView: 1 // 한번에 보이는 슬라이드 갯수
		,spaceBetween: 20 // 슬라이드 사이의 간격 px 단위
		//,mousewheelControl: true // 마우스 휠로 슬라이드 움직임
		// 더 외 추가 가능 요소들
		,paginationBulletRender: function (swiper, index, className) {
			return '<span class="' + className + '" style="margin-top: 30px;"></span>';
		}
	});
	swiper5 = new Swiper('#careers_body_con', {
		pagination: '#careers_body_con .swiper-pagination'
		,loop : true
		,paginationClickable: true
		,direction: 'horizontal' // 슬라이드 진행방향은 수평(vertical하면 수직으로 움직임)
		,slidesPerView: 4 // 한번에 보이는 슬라이드 갯수
		,spaceBetween: 0 // 슬라이드 사이의 간격 px 단위
		,mousewheelControl: true // 마우스 휠로 슬라이드 움직임
		,autoplay: 2000 // 마우스 휠로 슬라이드 움직임
		,speed: 1000
		// 더 외 추가 가능 요소들
		,paginationBulletRender: function (swiper, index, className) {
			return '<span class="' + className + '" style="margin-top: 30px;"></span>';
		}
	});
	/*
	swiper6 = new Swiper('#relation_site', {
		pagination: '#relation_site .swiper-pagination'
		,loop : true
		,paginationClickable: true
		,direction: 'horizontal' // 슬라이드 진행방향은 수평(vertical하면 수직으로 움직임)
		,slidesPerView: 1 // 한번에 보이는 슬라이드 갯수
		,spaceBetween: 20 // 슬라이드 사이의 간격 px 단위
		,mousewheelControl: true // 마우스 휠로 슬라이드 움직임
		// 더 외 추가 가능 요소들
		,paginationBulletRender: function (swiper, index, className) {
			return '<span class="' + className + '" style="margin-top: 30px;"></span>';
		}
	});
	*/
	function setPagination(){
		if($(window).width() > 992){
			swiper4.lockSwipes();
			$(swiper4.container).find('.swiper-pagination').hide();
		}else{
			swiper4.unlockSwipes();
			$(swiper4.container).find('.swiper-pagination').show();
		}
		/*
		swiper0.container.find('.swiper-pagination').html(swiper0.bullets).css({'margin-top':'30px'});
		swiper1.container.find('.swiper-pagination').html(swiper1.bullets).css({'margin-top':'30px'});
		swiper2.container.find('.swiper-pagination').html(swiper2.bullets).css({'margin-top':'30px'});
		swiper3.container.find('.swiper-pagination').html(swiper3.bullets).css({'margin-top':'30px'});
		swiper4.container.find('.swiper-pagination').html(swiper4.bullets).css({'margin-top':'30px'});
		swiper5.container.find('.swiper-slide').attr('style','');
		swiper5.container.find('.swiper-pagination').html(swiper5.bullets).css({'margin-top':'30px'});
		swiper6.container.find('.swiper-pagination').html(swiper6.bullets).css({'margin-top':'30px'});
		*/
	}
	
	setPagination();
	/*	
	setTimeout(setPagination, 1000);
    if($(window).width() > 992){
		swiper4.lockSwipes();
		swiper4.container.find('.swiper-pagination').hide();
	}else{
		swiper4.unlockSwipes();
		swiper4.container.find('.swiper-pagination').show();
	}*/
	
	$('.go_up_btn').click(function(){
		$('html, body').animate({scrollTop : 0},800);
		return false;
	});

	$(window).on('resize',function(){
		setPagination();
		/*if($(window).width() > 992){
			swiper4.lockSwipes();
			swiper4.container.find('.swiper-pagination').hide();
		}else{
			swiper4.unlockSwipes();
			swiper4.container.find('.swiper-pagination').show();
		}*/
	});


    var mainVisualAutoPlay = setInterval(function(){visualRight();}, 10000);
   // clearInterval(mainVisualAutoPlay);
    function visualRight(){
        if( isMove ) return;
        else isMove = true;
        //clearInterval(mainVisualAutoPlay);
        var idx = $('[class*="main_visual_00"]').index( $('[class*="main_visual_00"].active') );
        var lastIdx = $('[class*="main_visual_00"]').index( $('[class*="main_visual_00"]:last-child') );
        var prev = null;
        var next = null;
        var curr = $('[class*="main_visual_00"].active');
        if(idx == lastIdx ){
            next = $('[class*="main_visual_00"]')[0];
        }else{
            next = $('[class*="main_visual_00"]')[idx+1];
        }
        curr.css({'left':'0%'});
        $(next).css({'left':'100%'});
        $(prev).css({'left':'-100%'});
        curr.animate({'left':'-100%'}, 500);
        $(next).animate({'left':'0%'}, 500, function(){
            isMove = false;
            //mainVisualAutoPlay = setInterval(visualRight, 3000);
            //clearInterval(mainVisualAutoPlay);
        });

        curr.removeClass('active')
        $(next).addClass('active')
    }
    var isMove = false;
    function visualLeft(){
        if( isMove ) return;
        else isMove = true;
        //clearInterval(mainVisualAutoPlay);
        var idx = $('[class*="main_visual_00"]').index( $('[class*="main_visual_00"].active') );
        var lastIdx = $('[class*="main_visual_00"]').index( $('[class*="main_visual_00"]:last-child') );
        var prev = null;
        var next = null;
        var curr = $('[class*="main_visual_00"].active');
        if(idx == 0 ){
            prev = $('[class*="main_visual_00"]')[lastIdx];
        }else{
            prev = $('[class*="main_visual_00"]')[idx-1];
        }


        curr.css({'left':'0%'});
        $(next).css({'left':'100%'});
        $(prev).css({'left':'-100%'});
        curr.animate({'left':'100%'}, 500);
        $(prev).animate({'left':'0%'}, 500, function(){
            isMove = false;
           // mainVisualAutoPlay = setInterval(visualRight, 3000);
            //clearInterval(mainVisualAutoPlay);
        });


        curr.removeClass('active')
        $(prev).addClass('active')
    }

    $('.m1R_1').mouseover(function(){
        $('.m1R_1').removeClass('selected');
        $(this).addClass('selected');
    });

    $('.m1R_1').mouseleave(function(){
        $(this).removeClass('selected');
        $(this).addClass('selected');

    });

    var hotIssueInterval = setInterval(intervalHotIssue, 2000);
    function intervalHotIssue(){
        var $list = $('.focus_prev_list');
        var idx = $list.index($('.focus_prev_list.active').removeClass('active')) + 1;
        $($list[idx]).addClass('active');
    }

//    setInterval(
//    	function(){visualLeft();}, 3000
//    );
//    
    $(".visual_inner .visual_arrow.left").on('click', function(){
        visualLeft();
    });
    $(".visual_inner .visual_arrow.right").on('click', function(){
        visualRight();
    });
}

var getUrlParameter = function getUrlParameter(sParam) {
	var sPageURL = decodeURIComponent(window.location.search.substring(1)),
		sURLVariables = sPageURL.split('&'),
		sParameterName,
		i;

	for (i = 0; i < sURLVariables.length; i++) {
		sParameterName = sURLVariables[i].split('=');

		if (sParameterName[0] === sParam) {
			return sParameterName[1] === undefined ? true : sParameterName[1];
		}
	}
};
