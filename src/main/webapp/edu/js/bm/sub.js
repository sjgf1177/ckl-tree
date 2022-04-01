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

function showCaption(){
    if( $('.edu_youtube_subtitle_view_btn_con').hasClass("active") ){
        $('.edu_youtube_subtitle_view_btn_con').removeClass('active');
    }else{
        $('.edu_youtube_subtitle_view_btn_con').addClass('active');
    }  
}

$(function() {

    // 아코디언 faq
	$( '.faq_con').each( function(index, container)
    {
        //
        $(container).find( '.faq_tit_con').each( function( i, li )
        {	
        	
            $(li).attr( "_idx", i ).click( function( event )
            {
                var $_li = $( event.currentTarget );
                var _index = parseInt( $_li.attr( "_idx" ) );
                $( $( $_li.parentsUntil( ".faq_con")).parent().find( ".faq_tit_con" )).each( function( j, p )
                {
                    var el = $( $(p).parent().find( ".faq_reply_con") );

                    if( _index == j )
                    {
                        if( $(p).hasClass( "list_on" ) ){
                            $(p).removeClass( "list_on" );
                            $(p).removeAttr("title");
                            el.animate({height: 0}, 300);
                            setTimeout(function(){
                            	el.css({"display":"none"});
                            },300);
                        }else{
                            $(p).addClass( "list_on" );
                            $(p).attr("title","펼쳐짐" );
                            var curHeight = el.height();
                            var autoHeight = el.css('height', 'auto').height();
                            el.css({"display":"block"});
                            el.height(curHeight).animate({height: autoHeight}, 300);
                            
                        }
                    }else{
                        $(p).removeClass( "list_on" );
                        $(p).removeAttr("title");
                        el.animate({height: 0}, 300);
                        setTimeout(function(){
                        	el.css({"display":"none"});
                        },300);
                    }
                });
            });
        });
    });



    //팝업 작업
    var academyList = $(".eduframe_list > li");
    var popupList = $(".academy_pop");


    academyList.on('click', function(){
        var idx = academyList.index(this);
        $(popupList[idx]).show();
        $('body').css('overflow', 'hidden');

        var _this = $(popupList[idx]);
        $(_this).find(".popup_title").focus();
        $(popupList[idx]).find(".popup_close_btn, .btn_style_popup").off('click')
        $(popupList[idx]).find(".popup_close_btn, .btn_style_popup").on('click', function(){
            $(_this).hide();
            $('body').css('overflow', '');
        });

    });


    //자막 열기 --> 웹 접근성 위배 가상키보드 동작 안함
    /*$('.caption_btn').on('click', function(){
        if( $('.edu_youtube_subtitle_view_btn_con').hasClass("active") ){
            $('.edu_youtube_subtitle_view_btn_con').removeClass('active');
        }else{
            $('.edu_youtube_subtitle_view_btn_con').addClass('active');
        }
    });
    $('.caption_btn').on('keydown', function(key){
    	if(key.keyCode == 13){
	        if( $('.edu_youtube_subtitle_view_btn_con').hasClass("active") ){
	            $('.edu_youtube_subtitle_view_btn_con').removeClass('active');
	        }else{
	            $('.edu_youtube_subtitle_view_btn_con').addClass('active');
	        }
    	}
    });*/
    
    $('.edu_view_close_btn').on('click', function(){
    	$('.edu_youtube_subtitle_view_btn_con').removeClass('active');
	});

    // 탭 메뉴
    var tabList = $('.inner_tab > li');
    var contentList = $('.tab_contents');
    var prevTabIndex = 0;
    var tabIndex = getUrlParameter('tabIndex') ? getUrlParameter('tabIndex') : 0;


    tabControl();


    // 탭 클릭 이벤트
    tabList.on('click', function() {
        tabIndex = tabList.index(this);
        tabControl();
    });

    // 탭 컨트롤
    function tabControl(addClass) {

        // 이전 탭, 컨텐츠 hide
        $(tabList[prevTabIndex]).removeClass('active');
        $(tabList[prevTabIndex]).children('a').removeAttr('title');
        $(contentList[prevTabIndex]).removeClass('active');

        // 클릭한 탭, 컨텐츠 show
        $(tabList[tabIndex]).addClass('active');
        $(tabList[tabIndex]).children('a').attr('title', '현재탭');
        $(contentList[tabIndex]).addClass('active');

        prevTabIndex = tabIndex;
    }
    
    
    // sns
	var snsDrop = $('.snsDrop');
	$('.snsToggleOpen').on("click", function() {
		if ($(this).hasClass("on")){
			$(this).removeClass("on");
			$(snsDrop).hide();
		} else{
			$(this).addClass("on");
			$(snsDrop).show();
		}
		/*$(snsDrop).slideToggle();*/
	});

	/*$(".snsToggleOpen").on("focusout keydown", function(e){
		if(e.type="focusout" && (e.shiftKey && e.keyCode == 9)){ //shift tab 과 포커스아웃할때 숨김
			$(snsDrop).hide();
		}
	});*/
	$(snsDrop).parent().on("mouseleave", function(e){
		$(snsDrop).hide();
	});
	
	

	/*$(".CopyClipOpen").bind("keyup", function(event){
		$(snsDrop).hide();
	});*/
	

});

// 온라인교육 탭 스크립트
window.onload = function(){
    var eduOnlineTabList = $(".sub_main_online_education_section .tab_style_2_con > li");
    var eduOnlineTabContents = $(".sub_main_online_education_section .tab_style_2_con > li > .tab_child");

    function onlineIndexControl( idx ){

        eduOnlineTabList.removeClass("on");
        eduOnlineTabList.find(">a").removeClass('active');
        $(eduOnlineTabList[idx]).addClass("on");
        $(eduOnlineTabList[idx]).find(">a").addClass('active');

        var hei = $(eduOnlineTabContents[idx]).outerHeight() + $(eduOnlineTabList[idx]).find(">a").outerHeight();
        eduOnlineTabList.css('height', 'auto');
        $(eduOnlineTabList[idx]).css('height', hei+"px");

    }

    onlineIndexControl(0);

    eduOnlineTabList.on('click', function(){
        var idx = eduOnlineTabList.index(this);
        onlineIndexControl( idx );
    });


    var jobList = $(".sub_main_recruit_magazine_section .tab_style_2_con > li");
    var jobContents = $(".sub_main_recruit_magazine_section .tab_style_2_con > li > .tab_child");

    function jobIndexControl(idx){
        jobList.removeClass("on");
        jobList.find(">a").removeClass('active');
        $(jobList[idx]).addClass("on");
        $(jobList[idx]).find(">a").addClass('active');

        var hei = $(jobContents[idx]).outerHeight() + $(jobList[idx]).find(">a").outerHeight();
        jobList.css('height', 'auto');
        $(jobList[idx]).css('height', hei+"px");
    }

    jobIndexControl(0);


    jobList.on('click', function(){
        var idx = jobList.index(this);
        jobIndexControl( idx );
    });
}