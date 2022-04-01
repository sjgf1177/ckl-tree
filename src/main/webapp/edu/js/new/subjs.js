$(function(){
	function checkMobileSize() {
	    var x = $(window).width() + getScrollbarWidth();
	    if (x >= 992) {
	        return false;
	    } else {
	        return true;
	    }
	}
	listMypageNoData();
	function listMypageNoData(){
		if($(window).width() <= 992){
			$(".listMypageNoData").find("td").attr({"colspan":"6"});
			$(".listMyPageNoData2").find("td").attr({"colspan":"5"});
			$(".listMypageNoData").parents("tbody").siblings("colgroup").find("col:nth-child(6)").css({"width":"27%"});
			$(".listMypageNoData").parents("tbody").siblings("colgroup").find("col:nth-child(7)").css({"width":"27%"});
			$(".listMyPageNoData2").parents("tbody").siblings("colgroup").find("col:nth-child(2)").css({"width":"47%"});
		}else{
			$(".listMypageNoData").find("td").attr({"colspan":"9"});
			$(".listMypageNoData2").find("td").attr({"colspan":"6"});
			$(".listMypageNoData").parents("tbody").siblings("colgroup").find("col:nth-child(6)").css({"width":"14%"});
			$(".listMypageNoData").parents("tbody").siblings("colgroup").find("col:nth-child(7)").css({"width":"14%"});
			$(".listMypageNoData2").parents("tbody").siblings("colgroup").find("col:nth-child(2)").css({"width":"39%"});
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
		listMypageNoData();
		if(!isMobileSize){
			$("body").css({"position":""});
			if($(".gnb_wrap").hasClass("active") === true){
				$(".logo_con").hide();
				$(".header_con .pr15.pl15").css({"position":"relative"});
				$(".header_section").css({"width":"100%"});
				$(".gnb_con li ul").css({"display":"block"});
			}else{
				$(".logo_con").show();
			}
		}else{
			$(".logo_con").show();
			$(".logo_con").css({"display":""});
			if($(".gnb_wrap").hasClass("active") === true){
				$("body").css({"position":"fixed"});
				$(".gnb_con > li").find("ul").css({"display":""});
			}
		}
	});
	
	/* 맨위로 버튼  */
	$(".btn_go_top").on('click', function(){
		$('html, body').animate({scrollTop : 0},800);
		return false;
	});
	
	/* gnb 메뉴 */
	$(".gnb_con > li").on('mouseenter', function(){
        if( !gnbAllMenu ){
            TweenMax.to($('.gnb_menu_dim'), 0.3, {"height" : "30px"});
        }
    });
    $(".header_con").on('mouseleave', function(){
        if( !gnbAllMenu ){
            TweenMax.to($('.gnb_menu_dim'), 0.3, {"height": "0px"});
        }
    });
    
    /* gnb 메뉴 focus 이동시 메뉴 영역 확장 */
	$(".gnb_con").on('focusin', function(){
        if( !gnbAllMenu ){
            TweenMax.to($('.gnb_menu_dim'), 0.3, {"height" : "30px"});
        }
    });
	$(".gnb_con").on('focusout', function(){
        if( !gnbAllMenu ){
        	TweenMax.to($('.gnb_menu_dim'), 0.3, {"height" : "0px"});
        }
    });
	$(".gnb_con > li > a").on('focus', function(){
		$(this).parent().addClass("active").siblings().removeClass("active");
	});
	
    $('.gnb_icon').on('click', function(){
    	if($(".gnb_close").css("display") == "none"){
    		$('.gnb_all_menu_dim').css({"height": "0px"});
    	}else if($(".gnb_menu").css("display") == "none"){
    		$('.gnb_all_menu_dim').css({"height": "400px"});
    	}
    });
    $('.gnb_menu').on("click",function(key){	
    	$('.gnb_all_menu_dim').css({"height": "400px"});
	});
	$('.gnb_close').on("click",function(key){
	    	$('.gnb_all_menu_dim').css({"height": "0px"});
	});
	$('.gnb_menu').on("keydown",function(key){
		if(key.keyCode == 13){
	    	$('.gnb_all_menu_dim').css({"height": "400px"});
		}
	});
	$('.gnb_close').on("keydown",function(key){
		if(key.keyCode == 13){
	    	$('.gnb_all_menu_dim').css({"height": "0px"});
		}
	});
    
    $('.gnb_menu').on('click', function(){
    	if( isMobileSize ){
    		$(".header_wrap .logo_con").css({"margin-right":"0"})
    		$(".header_con").find(".pr15.pl15").css({"position":"fixed","left":"0"});
    		$("body").css({"position":"fixed"});
    	}
    });
    $('.gnb_close').on('click', function(){
    	if( isMobileSize ){
    		$(".header_con").find(".pr15.pl15").css({"position":"relative","left":"0"});
    		$(".header_section").css({"width":"100%"});
    		$("body").css({"position":""});
    	}
    	$(".gnb_con > li").find("ul").css({"display":""});
    });
    
   
	/*  home 서브 메인 슬라이드  */
	$(".visual_arrow.left").on('click', function(){
        visualLeft();
    });
    $(".visual_arrow.right").on('click', function(){
        visualRight();
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
    
    /* ------------------------------ */
    //half_banner
    $(".half_banner li").each(function(){
        var background_image = $(this).find(".banner_box").attr("data-image");
        $(this).find(".banner_box").css({"background-image":"url('"+background_image+"')"});
    });
    
    //full_banner
    $(".full_banner").each(function(){
        var background_image = $(this).attr("data-image");
        $(this).css({"background-image":"url('"+background_image+"')"});
    });
    
    var myPlayer;
    
    //openPopup_thumbnail
    $(".openPopup_thumbnail").on("click",function(){
    	var ele = "";
    	if($(this).hasClass("brochure_thumbnail")){
    		ele = "<img src='/edu/new_image/brochure.jpg' alt='한국콘텐츠 아카데미 온라인교육 브로슈어\n";
    		ele +="한국콘텐츠아카데미\n";
    		ele +="온라인교육\n";
    		ele +="ContentAcademy\n";
    		ele +="edu.kocca.kr\n";
    		ele +="www.facebook.com/edukocca\n";
    		ele +="blog.naver.com/koccaedu\n";
    		ele +="twitter.com/edukocca\n";
    		ele +="카카오플러스친구에서 한국콘텐츠아카데미 검색\n";
    		ele +="http://m.edu.kocca.kr/(모바일앱)\n";
    		ele +="한국콘텐츠진흥원 한국콘텐츠아카데미\n";
    		ele +="http://edu.kocca.kr\n";
    		ele +="\n";
    		ele +="교육분야 및 체계\n";
    		ele +="400여편의 최신 전문과정 무료제공\n";
    		ele +="방송영상 > 방송영상 기획, 방송영상 연출, 방송영상 촬영, 방송영상 편집, 방송영상 비즈, 방송영상 교양\n";
    		ele +="게임 > 게임 기획, 게임 연출/그래픽/사운드, 게임 프로그래밍, 게임 비즈, 게임 교양\n";
    		ele +="문화 > 만화/애니/캐릭터 > 만.애.캐 기획, 만화 제작, 애니 제작, 캐릭터 제작, 만.애.캐 비즈, 만.애.캐 교양\n";
    		ele +="문화 > 음악/공연 > 음악/공연 기획, 음악/공연 제작, 음악/공연 비즈, 음악/공연 교양\n";
    		ele +="\n";
    		ele +="기업/학교/단체 맞춤교육(상시접수)\n";
    		ele +="기업 및 기관대상 맞춤 무료 교육\n";
    		ele +="\n";
    		ele +="교육문의|한국콘텐츠아카데미\n";
    		ele +="tel : 02-6310-0770\n";
    		ele +="email : edukocca@kocca.kr\n";
    		ele +="\n";
    		ele +="\n";
    		ele +="열린강좌\n";
    		ele +="콘텐츠 분야별 최신 정보와 트렌드를 쉽고 재미있는 동영상 강좌로 구성하여 제공합니다. 또한 명사 특강을 통해 콘텐츠 제작 및 성공 노하우를 전해드립니다.\n";
    		ele +="\n";
    		ele +="최신과정\n";
    		ele +="방송\n";
    		ele +="VR콘텐츠의 특징 및 제작의 이해 hit\n";
    		ele +="MCN의 이해 hit\n";
    		ele +="하이퍼랩스의 특징과 이해\n";
    		ele +="최고가 최고를 만나다_여운혁PD/김형준PD/백미경 작가 new\n";
    		ele +="헬리캠을 이용한 촬영기법\n";
    		ele +="Final Cut Pro X를 이용한 영상편집 입문\n";
    		ele +="최고가 최고를 만나다_김은숙&김은희 new\n";
    		ele +="게임\n";
    		ele +="Unity를 이용한 Shader 제작 기초\n";
    		ele +="앱인벤터를 활용한 모바일 게임 만들기\n";
    		ele +="장르별 모바일 게임 마케팅 트렌드\n";
    		ele +="인디게임, 결과물로 이어지는 게임제작 new\n";
    		ele +="모바일 게임개발 최적화 기술\n";
    		ele +="물리기반 Shader\n";
    		ele +="게임스토리를 기반으로 한 트랜스미디어 전략\n";
    		ele +="만화/애니/캐릭터\n";
    		ele +="만화 웹툰 콘티 작법\n";
    		ele +="웹툰 플랫폼의 이해\n";
    		ele +="한국사회를 웹툰에 담는다! 최규석 웹툰작가 new\n";
    		ele +="무슨 생각으로 그리는가! 주호민 웹툰작가 new\n";
    		ele +="이종범의 디지털로 웹툰 제작하기 hit\n";
    		ele +="하일권, 다음 장면이 궁금한 만화를 그려라!\n";
    		ele +="아이디어, 당신의 삶에서 찾아라! 김양수 웹툰작가 new\n";
    		ele +="음악/공연\n";
    		ele +="공연 해외 수출 전략\n";
    		ele +="한승원과 Matthew jessner를 만나다\n";
    		ele +="최고가 최고를 만나다_윤상 new\n";
    		ele +="프로툴즈/큐베이스를 활용한 홈레코딩 new\n";
    		ele +="김지원 대표의 뮤지컬 제작 이야기 new\n";
    		ele +="비즈니스/기타\n";
    		ele +="신규 플랫폼을 통한 캐릭터 비즈니스 트랜드\n";
    		ele +="기획에서 투자까지, 연상호를 만나다\n";
    		ele +="크라우드펀딩의 이해 new\n";
    		ele +="재담미디어, 꿈의 창업을 성공으로 이끈 비법 new\n";
    		ele +="유영아 작가에게 듣는다! 만들어지는 이야기 쓰기\n";
    		ele +="효과적인 디지털 마케팅 수행을 위한 트렌드 리포트 new\n";
    		ele +="크리에이터를 만나다_양띵/허팝/도띠/이사배 new\n";
    		ele +="\n";
    		ele +="정규과정\n";
    		ele +="게임 기획 및 개발에 필요한 기초 이론을 소개하는 기획 부분, 그래픽 기초부터 3D까지 다루는 제작-디자인 부문, 다양한 프로그래밍 도구의 기능을 안내하는 제작-프로그래밍 부분 등 국내 최고 현장 중심 강사진의 강의로 제공해드립니다.\n";
    		ele +="기획\n";
    		ele +="게임 그래픽 제작의 이해\n";
    		ele +="수치 레벨디자인 기초 new\n";
    		ele +="게임 레벨 디자인의 이해\n";
    		ele +="제작(디자인)\n";
    		ele +="3D Studio Max를 이용한 그래픽 실습 hit\n";
    		ele +="게임 캐릭터 제작\n";
    		ele +="Substance Painter, 사실적 재질 표현에 다가가다! new\n";
    		ele +="제작(프로그래밍)\n";
    		ele +="가상현실게임 개발 hit\n";
    		ele +="Unity3D를 이용한 게임 만들기 new\n";
    		ele +="인공지능을 위한 Python 프로그래밍\n";
    		ele +="RPG 메이커로 만드는 롤플레잉 게임 제작 클래스 new\n";
    		ele +="비즈니스\n";
    		ele +="온라인 게임의 해외진출 전략\n";
    		ele +="게임종사자를 위한 저작권 노하우\n";
    		ele +="교양\n";
    		ele +="스마트폰과 문화\n";
    		ele +="트렌드 워칭 - 스마트 환경에서의 콘텐츠 비즈니스 외\n";
    		ele +="\n";
    		ele +="정규과정 방송\n";
    		ele +="정규과정\n";
    		ele +="콘텐츠 분야별 체계적인 이론과 실습과정으로 구성된 튜토리얼, 코스웨어 중심의 기초/전문 교육 과정을 제공하고 있습니다.\n";
    		ele +="방송영상 콘텐츠 기획에 필요한 이론을 소개하는 기획 부문, 스마트폰과 DSLR 등을 활용한 영상 제작 과정을 다루는 제작-촬영 부문, 다양한 편집프로그램의 기능을 안내하는 제작-편집 부문 등 체계적인 이론과 실습 위주의 과정을 제공해드립니다.\n";
    		ele +="대표과정\n";
    		ele +="기획\n";
    		ele +="촬영에서 편집까지 비주얼 스토리텔링\n";
    		ele +="방송영상 콘텐츠기획\n";
    		ele +="UHD 방송의 이해 및 제작기법\n";
    		ele +="제작(촬영)\n";
    		ele +="영상촬영기본/조명이 주는 놀라운 변화 new\n";
    		ele +="스마트폰을 활용한 영상 제작 hit\n";
    		ele +="전문가도 부럽지 않은 DSLR활용하기 hit\n";
    		ele +="제작(편집)\n";
    		ele +="컬러 커렉션 앤 그레이팅/다빈치 리졸브를 활용한 영상 색보정 new\n";
    		ele +="EDIUS 영상편집/Adobe Premiere Pro CC hit\n";
    		ele +="After Effects를 이용한 모션그래픽 실습 hit\n";
    		ele +="비즈니스\n";
    		ele +="분야별로 배우는 콘텐츠 마케팅\n";
    		ele +="방송종사자를 위한 저작권 노하우\n";
    		ele +="교양\n";
    		ele +="재미있는 영화읽기 hit\n";
    		ele +="문화계 거장들의 인생 이야기\n";
    		ele +="\n";
    		ele +="정규과정 문화\n";
    		ele +="만화/애니메이션/캐릭터, 음악/공연 등 문화 콘텐츠 산업 전반에 대한 기획, 제작, 비즈니스, 교양 부문 과정을 이론부터 실제까지 체계적으로 구성하여 전달해드립니다.\n";
    		ele +="대표과정\n";
    		ele +="기획\n";
    		ele +="11가지 법칙으로 끝내는 스토리텔링 hit\n";
    		ele +="캐릭터와 플롯을 통해 보는 만화 창작의 비밀\n";
    		ele +="히트하는 뮤지컬, 기획부터 홍보까지\n";
    		ele +="제작\n";
    		ele +="캐릭터 움직임의 원리\n";
    		ele +="스케치업을 활용한 웹툰 배경 제작 hit\n";
    		ele +="클립스튜디오를 통해 작품 완성하기 new\n";
    		ele +="애니메이션 VFX new\n";
    		ele +="비즈니스\n";
    		ele +="애니메이션의 시작과 현재, 그리고 전망\n";
    		ele +="성공적인 비즈니스 모델 수립\n";
    		ele +="뮤지컬에서의 저작권과 상표권 new\n";
    		ele +="음악저작권 바로 알기 new\n";
    		ele +="교양\n";
    		ele +="글로컬문화콘텐츠의 이해와 사례\n";
    		ele +="사례로 보는 SNS 비즈니스 전략\n";
    		ele +="콘텐츠 투자 유치 노하우 new\n";
    		ele +="성공사례 - 문화콘텐츠를 말하다 hit\n";
    		ele +="'/>";
    	}else{
    		ele = "<video id=\"my-video\" controls class=\"video-js\" data-setup=\"{}\"></video>";
    	}
    	var html = "<div class='academyStory bg_popup'>";
    	html += "<span class='btn_popupClose' title='팝업창 닫기'>X</span>";
    	html += "<div class='popup_box'>";
    	html += ele;
    	html += "</div>";
    	html += "</div>";
    	$("body").prepend(html);
    	$(".sub_layout_page").css({"position":"fixed"});
    	
    	if(!$(this).hasClass("brochure_thumbnail")){
    		myPlayer = videojs('my-video', {"controls" : true, "autoplay" : false, "preload" : "auto", "loop" : false});
    		
			if($(this).hasClass("thumbnail_01")){
				myPlayer.src({type:"video/mp4", src:"http://edu_kocca.ecn.cdn.infralab.net/kocca/pr_video/pr_video_01.mp4"});
				track = "<br><div class='movDescTxt' tabindex='0' style='background:#fff; max-width: 800px; margin-left: auto; margin-right: auto; box-sizing: border-box; font-size: 1.45rem; line-height: 2.6rem; color: rgb(49, 49, 49); letter-spacing: -0.025em; padding: 20px 25px; border: 2px solid rgb(90, 201, 183); text-align: left; max-height: 300px; overflow-y: auto;'>";
				track +="트랜디한 내용의 교육과정을<br>";
				track +="<br>";
				track +="최고의 강사진들과 함께<br>";
				track +="<br>";
				track +="한국콘텐츠아카데미 온라인교육<br>";
				track +="나에게 딱맞는 분야를 찾아서!<br>";
				track +="<br>";
				track +="방송영상<br>";
				track +="방송 기획, 제작, 편집까지!<br>";
				track +="각종 편집 프로그램 사용법과<br>";
				track +="유명 크리에이터들의 인터뷰를 보실 수 있습니다.<br>";
				track +="<br>";
				track +="게임<br>";
				track +="게임의 기획, 그래픽기초~3D 등<br>";
				track +="재미있었던 게임들의 운영 방법과 전략, 제작에 대해서<br>";
				track +="지식을 얻으실 수 있습니다.<br>";
				track +="<br>";
				track +="만화/애니/캐릭터<br>";
				track +="내가 즐겨 보는 웹툰은 어떻게 만들어 졌을까요?<br>";
				track +="유명 웹툰, 그림 작가들의 이야기를 들어보고<br>";
				track +="직접 프로그램 운영법을 배워 만들어 봅시다!<br>";
				track +="<br>";
				track +="음악/공연<br>";
				track +="음악, 공연의 제작, 유통, 마케팅의 방법과 저작권 등<br>";
				track +="음악, 공연 분야에서 꿈을 펼치실 분들을 위한<br>";
				track +="맞춤강의!<br>";
				track +="<br>";
				track +="이 모든 것을<br>";
				track +="언제든지<br>";
				track +="핸드폰으로 컴퓨터로 어디서나<br>";
				track +="누구나 한국콘텐츠아카데미 회원이라면<br>";
				track +="<br>";
				track +="무료로<br>";
				track +="<br>";
				track +="어디에서?<br>";
				track +="<br>";
				track +="한국콘텐츠아카데미<br>";
				track +="</div>"
			}else{
				myPlayer.src({type:"video/mp4", src:"http://edu_kocca.ecn.cdn.infralab.net/kocca/pr_video/pr_video_2019.mp4"});
				track = "<br><div class='movDescTxt' tabindex='0' style='background:#fff; max-width: 800px; margin-left: auto; margin-right: auto; box-sizing: border-box; font-size: 1.45rem; line-height: 2.6rem; color: rgb(49, 49, 49); letter-spacing: -0.025em; padding: 20px 25px; border: 2px solid rgb(90, 201, 183); text-align: left; max-height: 300px; overflow-y: auto;'>";
				track += "융합형 인재 양성의 허브 한국콘텐츠아카데미에서는 콘텐츠 창작자들의 위해 방송영상, 게임, 만화/애니메이션/캐릭터, 음악/공연 등 분야별 전문가들의 다양하고 생생한 노하우가 담긴 교육과정을 새롭게 준비했습니다.<br>";
				track += "<br>";
				track += "영상기획과 구성, 글쓰기 노하우, 영상 편집효과를 배우고 프로그램 저작권 보호방안 확인을 통해 방송역량 실무역량 UP!<br>";
				track += "<br>";
				track += "게임 속 공간 기획부터 제작 마케팅 노하우, 퍼블리싱 계약에 필요한 정보, 그리고 게임 제작 후기를 통해 게임 제작 스킬 UP!<br>";
				track += "<br>";
				track += "만화연출을 위한 장면 설계, 웹툰 창작자의 권리 보호를 위한 저작권 실무, 그리고 애니메이션 스토리텔링과 리깅 원리 학습을 통해 만화/애니메이션/캐릭터 제작 스킬 UP!<br>";
				track += "<br>";
				track += "뮤지컬 장르와 브로드웨이 뮤지컬을 이해하고 무대연출과 공연 영상 디자인의 노하우 강의를 통해 음악/공연 제작 역량 UP!<br>";
				track += "<br>";
				track += "그리고 각 콘텐츠 분야 명사들의 노하우를 전수하는 특강도 준비했습니다.<br>";
				track += "<br>";
				track += "이 외에도, 실무중심의 차별화된 교육과 각 분야별 학습자 누구나 쉽게 이해하고 직접 느끼면서 활용할 수 있는 강의를 운영하고 있어 방송, 게임, 만화/애니메이션/캐릭터, 음악/공연 등 콘텐츠 전 분야의 기초 역량은 물론 특화된 전문역량을 키울 수 있습니다.<br>";
				track += "<br>";
				track += "해당 과정은 한국콘텐츠아카데미 홈페이지에서 신청할 수 있으며 PC와 스마트 기기로 언제어디서든 학습이 가능합니다.<br>";
				track += "<br>";
				track += "한국콘텐츠아카데미가 최고의 강사진들과 함께 새롭게 준비한 과정들을 지금바로 만나보세요!<br>";
				track += "</div>";
				
			}
			$("#my-video").after(track);
    	}
    });
    $(".openPopup_thumbnail").on("keydown",function(key){
    	if(key.keyCode == 13){
	    	var ele = "";
	    	if($(this).hasClass("brochure_thumbnail")){
	    		ele = "<img src='/edu/new_image/brochure.jpg' alt='한국콘텐츠 아카데미 온라인교육 브로슈어\n";
	    		ele +="한국콘텐츠아카데미\n";
	    		ele +="온라인교육\n";
	    		ele +="ContentAcademy\n";
	    		ele +="edu.kocca.kr\n";
	    		ele +="www.facebook.com/edukocca\n";
	    		ele +="blog.naver.com/koccaedu\n";
	    		ele +="twitter.com/edukocca\n";
	    		ele +="카카오플러스친구에서 한국콘텐츠아카데미 검색\n";
	    		ele +="http://m.edu.kocca.kr/(모바일앱)\n";
	    		ele +="한국콘텐츠진흥원 한국콘텐츠아카데미\n";
	    		ele +="http://edu.kocca.kr\n";
	    		ele +="\n";
	    		ele +="교육분야 및 체계\n";
	    		ele +="400여편의 최신 전문과정 무료제공\n";
	    		ele +="방송영상 > 방송영상 기획, 방송영상 연출, 방송영상 촬영, 방송영상 편집, 방송영상 비즈, 방송영상 교양\n";
	    		ele +="게임 > 게임 기획, 게임 연출/그래픽/사운드, 게임 프로그래밍, 게임 비즈, 게임 교양\n";
	    		ele +="문화 > 만화/애니/캐릭터 > 만.애.캐 기획, 만화 제작, 애니 제작, 캐릭터 제작, 만.애.캐 비즈, 만.애.캐 교양\n";
	    		ele +="문화 > 음악/공연 > 음악/공연 기획, 음악/공연 제작, 음악/공연 비즈, 음악/공연 교양\n";
	    		ele +="\n";
	    		ele +="기업/학교/단체 맞춤교육(상시접수)\n";
	    		ele +="기업 및 기관대상 맞춤 무료 교육\n";
	    		ele +="\n";
	    		ele +="교육문의|한국콘텐츠아카데미\n";
	    		ele +="tel : 02-6310-0770\n";
	    		ele +="email : edukocca@kocca.kr\n";
	    		ele +="\n";
	    		ele +="\n";
	    		ele +="열린강좌\n";
	    		ele +="콘텐츠 분야별 최신 정보와 트렌드를 쉽고 재미있는 동영상 강좌로 구성하여 제공합니다. 또한 명사 특강을 통해 콘텐츠 제작 및 성공 노하우를 전해드립니다.\n";
	    		ele +="\n";
	    		ele +="최신과정\n";
	    		ele +="방송\n";
	    		ele +="VR콘텐츠의 특징 및 제작의 이해 hit\n";
	    		ele +="MCN의 이해 hit\n";
	    		ele +="하이퍼랩스의 특징과 이해\n";
	    		ele +="최고가 최고를 만나다_여운혁PD/김형준PD/백미경 작가 new\n";
	    		ele +="헬리캠을 이용한 촬영기법\n";
	    		ele +="Final Cut Pro X를 이용한 영상편집 입문\n";
	    		ele +="최고가 최고를 만나다_김은숙&김은희 new\n";
	    		ele +="게임\n";
	    		ele +="Unity를 이용한 Shader 제작 기초\n";
	    		ele +="앱인벤터를 활용한 모바일 게임 만들기\n";
	    		ele +="장르별 모바일 게임 마케팅 트렌드\n";
	    		ele +="인디게임, 결과물로 이어지는 게임제작 new\n";
	    		ele +="모바일 게임개발 최적화 기술\n";
	    		ele +="물리기반 Shader\n";
	    		ele +="게임스토리를 기반으로 한 트랜스미디어 전략\n";
	    		ele +="만화/애니/캐릭터\n";
	    		ele +="만화 웹툰 콘티 작법\n";
	    		ele +="웹툰 플랫폼의 이해\n";
	    		ele +="한국사회를 웹툰에 담는다! 최규석 웹툰작가 new\n";
	    		ele +="무슨 생각으로 그리는가! 주호민 웹툰작가 new\n";
	    		ele +="이종범의 디지털로 웹툰 제작하기 hit\n";
	    		ele +="하일권, 다음 장면이 궁금한 만화를 그려라!\n";
	    		ele +="아이디어, 당신의 삶에서 찾아라! 김양수 웹툰작가 new\n";
	    		ele +="음악/공연\n";
	    		ele +="공연 해외 수출 전략\n";
	    		ele +="한승원과 Matthew jessner를 만나다\n";
	    		ele +="최고가 최고를 만나다_윤상 new\n";
	    		ele +="프로툴즈/큐베이스를 활용한 홈레코딩 new\n";
	    		ele +="김지원 대표의 뮤지컬 제작 이야기 new\n";
	    		ele +="비즈니스/기타\n";
	    		ele +="신규 플랫폼을 통한 캐릭터 비즈니스 트랜드\n";
	    		ele +="기획에서 투자까지, 연상호를 만나다\n";
	    		ele +="크라우드펀딩의 이해 new\n";
	    		ele +="재담미디어, 꿈의 창업을 성공으로 이끈 비법 new\n";
	    		ele +="유영아 작가에게 듣는다! 만들어지는 이야기 쓰기\n";
	    		ele +="효과적인 디지털 마케팅 수행을 위한 트렌드 리포트 new\n";
	    		ele +="크리에이터를 만나다_양띵/허팝/도띠/이사배 new\n";
	    		ele +="\n";
	    		ele +="정규과정\n";
	    		ele +="게임 기획 및 개발에 필요한 기초 이론을 소개하는 기획 부분, 그래픽 기초부터 3D까지 다루는 제작-디자인 부문, 다양한 프로그래밍 도구의 기능을 안내하는 제작-프로그래밍 부분 등 국내 최고 현장 중심 강사진의 강의로 제공해드립니다.\n";
	    		ele +="기획\n";
	    		ele +="게임 그래픽 제작의 이해\n";
	    		ele +="수치 레벨디자인 기초 new\n";
	    		ele +="게임 레벨 디자인의 이해\n";
	    		ele +="제작(디자인)\n";
	    		ele +="3D Studio Max를 이용한 그래픽 실습 hit\n";
	    		ele +="게임 캐릭터 제작\n";
	    		ele +="Substance Painter, 사실적 재질 표현에 다가가다! new\n";
	    		ele +="제작(프로그래밍)\n";
	    		ele +="가상현실게임 개발 hit\n";
	    		ele +="Unity3D를 이용한 게임 만들기 new\n";
	    		ele +="인공지능을 위한 Python 프로그래밍\n";
	    		ele +="RPG 메이커로 만드는 롤플레잉 게임 제작 클래스 new\n";
	    		ele +="비즈니스\n";
	    		ele +="온라인 게임의 해외진출 전략\n";
	    		ele +="게임종사자를 위한 저작권 노하우\n";
	    		ele +="교양\n";
	    		ele +="스마트폰과 문화\n";
	    		ele +="트렌드 워칭 - 스마트 환경에서의 콘텐츠 비즈니스 외\n";
	    		ele +="\n";
	    		ele +="정규과정 방송\n";
	    		ele +="정규과정\n";
	    		ele +="콘텐츠 분야별 체계적인 이론과 실습과정으로 구성된 튜토리얼, 코스웨어 중심의 기초/전문 교육 과정을 제공하고 있습니다.\n";
	    		ele +="방송영상 콘텐츠 기획에 필요한 이론을 소개하는 기획 부문, 스마트폰과 DSLR 등을 활용한 영상 제작 과정을 다루는 제작-촬영 부문, 다양한 편집프로그램의 기능을 안내하는 제작-편집 부문 등 체계적인 이론과 실습 위주의 과정을 제공해드립니다.\n";
	    		ele +="대표과정\n";
	    		ele +="기획\n";
	    		ele +="촬영에서 편집까지 비주얼 스토리텔링\n";
	    		ele +="방송영상 콘텐츠기획\n";
	    		ele +="UHD 방송의 이해 및 제작기법\n";
	    		ele +="제작(촬영)\n";
	    		ele +="영상촬영기본/조명이 주는 놀라운 변화 new\n";
	    		ele +="스마트폰을 활용한 영상 제작 hit\n";
	    		ele +="전문가도 부럽지 않은 DSLR활용하기 hit\n";
	    		ele +="제작(편집)\n";
	    		ele +="컬러 커렉션 앤 그레이팅/다빈치 리졸브를 활용한 영상 색보정 new\n";
	    		ele +="EDIUS 영상편집/Adobe Premiere Pro CC hit\n";
	    		ele +="After Effects를 이용한 모션그래픽 실습 hit\n";
	    		ele +="비즈니스\n";
	    		ele +="분야별로 배우는 콘텐츠 마케팅\n";
	    		ele +="방송종사자를 위한 저작권 노하우\n";
	    		ele +="교양\n";
	    		ele +="재미있는 영화읽기 hit\n";
	    		ele +="문화계 거장들의 인생 이야기\n";
	    		ele +="\n";
	    		ele +="정규과정 문화\n";
	    		ele +="만화/애니메이션/캐릭터, 음악/공연 등 문화 콘텐츠 산업 전반에 대한 기획, 제작, 비즈니스, 교양 부문 과정을 이론부터 실제까지 체계적으로 구성하여 전달해드립니다.\n";
	    		ele +="대표과정\n";
	    		ele +="기획\n";
	    		ele +="11가지 법칙으로 끝내는 스토리텔링 hit\n";
	    		ele +="캐릭터와 플롯을 통해 보는 만화 창작의 비밀\n";
	    		ele +="히트하는 뮤지컬, 기획부터 홍보까지\n";
	    		ele +="제작\n";
	    		ele +="캐릭터 움직임의 원리\n";
	    		ele +="스케치업을 활용한 웹툰 배경 제작 hit\n";
	    		ele +="클립스튜디오를 통해 작품 완성하기 new\n";
	    		ele +="애니메이션 VFX new\n";
	    		ele +="비즈니스\n";
	    		ele +="애니메이션의 시작과 현재, 그리고 전망\n";
	    		ele +="성공적인 비즈니스 모델 수립\n";
	    		ele +="뮤지컬에서의 저작권과 상표권 new\n";
	    		ele +="음악저작권 바로 알기 new\n";
	    		ele +="교양\n";
	    		ele +="글로컬문화콘텐츠의 이해와 사례\n";
	    		ele +="사례로 보는 SNS 비즈니스 전략\n";
	    		ele +="콘텐츠 투자 유치 노하우 new\n";
	    		ele +="성공사례 - 문화콘텐츠를 말하다 hit\n";
	    		ele +="'/>";
	    	}else{
	    		ele = "<video id=\"my-video\" controls class=\"video-js\" data-setup=\"{}\"></video>";
	    	}
	    	var html = "<div class='academyStory bg_popup'>";
	    	html += "<span class='btn_popupClose' tabindex='0' title='팝업창 닫기'>X</span>";
	    	html += "<div class='popup_box'>";
	    	html += ele;
	    	html += "</div>";
	    	html += "</div>";
	    	$("body").prepend(html);
	    	$('.btn_popupClose').focus();
	    	$(".sub_layout_page").css({"position":"fixed"});
	    	
	    	if(!$(this).hasClass("brochure_thumbnail")){
	    		myPlayer = videojs('my-video', {"controls" : true, "autoplay" : false, "preload" : "auto", "loop" : false});
	    		
				if($(this).hasClass("thumbnail_01")){
					myPlayer.src({type:"video/mp4", src:"http://edu_kocca.ecn.cdn.infralab.net/kocca/pr_video/pr_video_01.mp4"});
					track = "<br><div class='movDescTxt' tabindex='0' style='background:#fff; max-width: 800px; margin-left: auto; margin-right: auto; box-sizing: border-box; font-size: 1.45rem; line-height: 2.6rem; color: rgb(49, 49, 49); letter-spacing: -0.025em; padding: 20px 25px; border: 2px solid rgb(90, 201, 183); text-align: left; max-height: 300px; overflow-y: auto;'>";
					track +="트랜디한 내용의 교육과정을<br>";
					track +="<br>";
					track +="최고의 강사진들과 함께<br>";
					track +="<br>";
					track +="한국콘텐츠아카데미 온라인교육<br>";
					track +="나에게 딱맞는 분야를 찾아서!<br>";
					track +="<br>";
					track +="방송영상<br>";
					track +="방송 기획, 제작, 편집까지!<br>";
					track +="각종 편집 프로그램 사용법과<br>";
					track +="유명 크리에이터들의 인터뷰를 보실 수 있습니다.<br>";
					track +="<br>";
					track +="게임<br>";
					track +="게임의 기획, 그래픽기초~3D 등<br>";
					track +="재미있었던 게임들의 운영 방법과 전략, 제작에 대해서<br>";
					track +="지식을 얻으실 수 있습니다.<br>";
					track +="<br>";
					track +="만화/애니/캐릭터<br>";
					track +="내가 즐겨 보는 웹툰은 어떻게 만들어 졌을까요?<br>";
					track +="유명 웹툰, 그림 작가들의 이야기를 들어보고<br>";
					track +="직접 프로그램 운영법을 배워 만들어 봅시다!<br>";
					track +="<br>";
					track +="음악/공연<br>";
					track +="음악, 공연의 제작, 유통, 마케팅의 방법과 저작권 등<br>";
					track +="음악, 공연 분야에서 꿈을 펼치실 분들을 위한<br>";
					track +="맞춤강의!<br>";
					track +="<br>";
					track +="이 모든 것을<br>";
					track +="언제든지<br>";
					track +="핸드폰으로 컴퓨터로 어디서나<br>";
					track +="누구나 한국콘텐츠아카데미 회원이라면<br>";
					track +="<br>";
					track +="무료로<br>";
					track +="<br>";
					track +="어디에서?<br>";
					track +="<br>";
					track +="한국콘텐츠아카데미<br>";
					track +="<div>"
				}else{
					myPlayer.src({type:"video/mp4", src:"http://edu_kocca.ecn.cdn.infralab.net/kocca/pr_video/pr_video_2019.mp4"});
					track = "<br><div class='movDescTxt' tabindex='0' style='background:#fff; max-width: 800px; margin-left: auto; margin-right: auto; box-sizing: border-box; font-size: 1.45rem; line-height: 2.6rem; color: rgb(49, 49, 49); letter-spacing: -0.025em; padding: 20px 25px; border: 2px solid rgb(90, 201, 183); text-align: left; max-height: 300px; overflow-y: auto;'>";
					track += "융합형 인재 양성의 허브 한국콘텐츠아카데미에서는 콘텐츠 창작자들의 위해 방송영상, 게임, 만화/애니메이션/캐릭터, 음악/공연 등 분야별 전문가들의 다양하고 생생한 노하우가 담긴 교육과정을 새롭게 준비했습니다.<br>";
					track += "<br>";
					track += "영상기획과 구성, 글쓰기 노하우, 영상 편집효과를 배우고 프로그램 저작권 보호방안 확인을 통해 방송역량 실무역량 UP!<br>";
					track += "<br>";
					track += "게임 속 공간 기획부터 제작 마케팅 노하우, 퍼블리싱 계약에 필요한 정보, 그리고 게임 제작 후기를 통해 게임 제작 스킬 UP!<br>";
					track += "<br>";
					track += "만화연출을 위한 장면 설계, 웹툰 창작자의 권리 보호를 위한 저작권 실무, 그리고 애니메이션 스토리텔링과 리깅 원리 학습을 통해 만화/애니메이션/캐릭터 제작 스킬 UP!<br>";
					track += "<br>";
					track += "뮤지컬 장르와 브로드웨이 뮤지컬을 이해하고 무대연출과 공연 영상 디자인의 노하우 강의를 통해 음악/공연 제작 역량 UP!<br>";
					track += "<br>";
					track += "그리고 각 콘텐츠 분야 명사들의 노하우를 전수하는 특강도 준비했습니다.<br>";
					track += "<br>";
					track += "이 외에도, 실무중심의 차별화된 교육과 각 분야별 학습자 누구나 쉽게 이해하고 직접 느끼면서 활용할 수 있는 강의를 운영하고 있어 방송, 게임, 만화/애니메이션/캐릭터, 음악/공연 등 콘텐츠 전 분야의 기초 역량은 물론 특화된 전문역량을 키울 수 있습니다.<br>";
					track += "<br>";
					track += "해당 과정은 한국콘텐츠아카데미 홈페이지에서 신청할 수 있으며 PC와 스마트 기기로 언제어디서든 학습이 가능합니다.<br>";
					track += "<br>";
					track += "한국콘텐츠아카데미가 최고의 강사진들과 함께 새롭게 준비한 과정들을 지금바로 만나보세요!<br>";
					track += "</div>";
				}
				$("#my-video").after(track);
	    	}
    	}
    });
  
    
    $(document).on('click', '.btn_popupClose, .academyStory.bg_popup', function(e){
    	if($(".popup_box").has(e.target).length==0){
    		if($("#my-video").length > 0){
    			myPlayer.dispose();
    		}
    		$(".academyStory.bg_popup").empty();
    		$(".academyStory.bg_popup").remove();
    		$(".sub_layout_page").css({"position":""});
    	}
    });
    
    $(document).on('keydown', '.btn_popupClose, .academyStory.bg_popup', function(e){
    	console.log(e);
    	if(e.keyCode == 13){
    	if($(".popup_box").has(e.target).length==0){
    			
	    		if($("#my-video").length > 0){
	    			myPlayer.dispose();
	    		}
	    		$(".academyStory.bg_popup").empty();
	    		$(".academyStory.bg_popup").remove();
	    		$(".sub_layout_page").css({"position":""});
    		}
    	}
    	
    });
    
    /*//vertical_slide
    var scroll_ele = $(".vertical_slide");
    scroll_ele.scroll(function(){
        if($(this).scrollTop() != 0){
            $(this).find(".top_blur").css({"display":"block"});
        }else if($(this).scrollTop() != $(this).height()){
            $(this).find(".bottom_blur").css({"display":"block"});
        }else if($(this).scrollTop() == 0){
            $(this).find(".top_blur").css({"display":"none"});
        }
    });*/
    
});