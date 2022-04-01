function layer_open(el, layerId) {
    var temp = $('#' + el);		//레이어의 id를 temp변수에 저장
    var bg = temp.prev().hasClass('layer-bg');	//dimmed 레이어를 감지하기 위한 boolean 변수

    if (bg) {
        temp.parent('.layer').fadeIn();
        $('.video-slider').slick({ // 슬라이드 스크립트 여기에 붙이기. 20201117
                dots: true,
                infinite: true,
                speed: 500,
                autoplay: false,
                fade: true,
                cssEase: 'linear'
        });
        $('.video-slider').resize(); // 슬라이드 작동!! 
        // $('.video-slider').slick('slickGoTo',0);  // 슬라이드 초기화 
    } else {
        temp.fadeIn();	//bg 클래스가 없으면 일반레이어로 실행한다.
        return false;
    }


    // 화면의 중앙에 레이어를 띄운다.
    if (temp.outerHeight() < $(document).height()) temp.css('margin-top', '-' + temp.outerHeight() / 2 + 'px');
    else temp.css('top', '0px');
    if (temp.outerWidth() < $(document).width()) temp.css('margin-left', '-' + temp.outerWidth() / 2 + 'px');
    else temp.css('left', '0px');

    temp.find('.btn-layer-close').click(function (e) { 
        if (bg) {
            $('.layer ').fadeOut();
        } else {
            temp.fadeOut();		//'닫기'버튼을 클릭하면 레이어가 사라진다.
        }
        e.preventDefault();

        //슬릭이 진행중인지 css로 체크 20201117
        if( $('.video-slider').hasClass('slick-initialized') ){
            $('.video-slider').slick('unslick');//슬릭해제
        }else{
            $('.video-slider').slick(slickInfoObj);
        }
        
    });

    
    if(layerId != '' || layerId != null){
    	// 레이어팝업에서 사용할 ID를 받는다.
    	getLayerId(layerId);
    }
    
}

// 20201116 추가 
function layer_open2(el, layerId) {
    var temp = $('#' + el);		//레이어의 id를 temp변수에 저장
    var bg = temp.prev().hasClass('layer-bg');	//dimmed 레이어를 감지하기 위한 boolean 변수

    if (bg) {
        temp.parent('.layer').fadeIn();
        $('.video-slider').slick({  // 슬라이드 스크립트 여기에 붙이기. 20201117
            dots: true,
                infinite: true,
                speed: 500,
                autoplay: false,
                fade: true,
                cssEase: 'linear'
        });
        $('.video-slider').resize(); // 슬라이드 작동!! 
        // $('.video-slider').slick('slickGoTo',0);  // 슬라이드 초기화
        // $('.video-slider').not('.slick-initialized').slick();
    } else {
        temp.fadeIn();	//bg 클래스가 없으면 일반레이어로 실행한다.
        return false;
    }

    // 화면의 중앙에 레이어를 띄운다.
    if (temp.outerHeight() < $(document).height()) temp.css('margin-top', '-' + temp.outerHeight() / 2 + 'px');
    else temp.css('top', '0px');
    if (temp.outerWidth() < $(document).width()) temp.css('margin-left', '-' + temp.outerWidth() / 2 + 'px');
    else temp.css('left', '0px');

    temp.find('.btn-layer-close').click(function (e) { 
        if (bg) {
            $('.layer ').fadeOut();
        } else {
            temp.fadeOut();		//'닫기'버튼을 클릭하면 레이어가 사라진다.
        }
        e.preventDefault();

        //슬릭이 진행중인지 css로 체크 20201117
        if( $('.video-slider').hasClass('slick-initialized') ){
            $('.video-slider').slick('unslick');//슬릭해제
        }else{
            $('.video-slider').slick(slickInfoObj);
        }
    });
    
    if(layerId != '' || layerId != null){
    	// 레이어팝업에서 사용할 ID를 받는다.
    	getLayerId(layerId);
    }
    
}

//20201117 NoneDot 추가 
function layer_open_nonedot(el, layerId) {
    var temp = $('#' + el);		//레이어의 id를 temp변수에 저장
    var bg = temp.prev().hasClass('layer-bg');	//dimmed 레이어를 감지하기 위한 boolean 변수

    if (bg) {
        temp.parent('.layer').fadeIn();
        $('.video-slider').slick({  // 슬라이드 스크립트 여기에 붙이기. 20201117
            dots: false,
                infinite: true,
                speed: 500,
                autoplay: false,
                fade: true,
                cssEase: 'linear'
        });
        $('.video-slider').resize(); // 슬라이드 작동!! 
        // $('.video-slider').slick('slickGoTo',0);  // 슬라이드 초기화
        // $('.video-slider').not('.slick-initialized').slick();
    } else {
        temp.fadeIn();	//bg 클래스가 없으면 일반레이어로 실행한다.
        return false;
    }

    // 화면의 중앙에 레이어를 띄운다.
    if (temp.outerHeight() < $(document).height()) temp.css('margin-top', '-' + temp.outerHeight() / 2 + 'px');
    else temp.css('top', '0px');
    if (temp.outerWidth() < $(document).width()) temp.css('margin-left', '-' + temp.outerWidth() / 2 + 'px');
    else temp.css('left', '0px');

    temp.find('.btn-layer-close').click(function (e) { 
        if (bg) {
            $('.layer ').fadeOut();
        } else {
            temp.fadeOut();		//'닫기'버튼을 클릭하면 레이어가 사라진다.
        }
        e.preventDefault();

        //슬릭이 진행중인지 css로 체크 20201117
        if( $('.video-slider').hasClass('slick-initialized') ){
            $('.video-slider').slick('unslick');//슬릭해제
        }else{
            $('.video-slider').slick(slickInfoObj);
        }
    });
    
    if(layerId != '' || layerId != null){
    	// 레이어팝업에서 사용할 ID를 받는다.
    	getLayerId(layerId);
    }
    
}
