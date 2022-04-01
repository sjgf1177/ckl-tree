//반응형 사이즈별 클래스
$(window).on("load resize", function(){
  var w = $(window).width(); 
  if(w >= 812){  // 웹
    $('.layer').removeClass("mobile").addClass("web"); 
  }
  if(w < 812){  // 모바일
    $('.layer').removeClass("web").addClass("mobile");
  }
});


// gnb 하나씩 보기  20201116
(function($){
  
  var gnb = {
    click : function (target, speed) {
      var _self = this,
          $target = $(target);
      _self.speed = speed || 300;
      
      $target.each(function(){
        if(findChildren($(this))) {
          return;
        }
        $(this).addClass('noDepth');
      });
      
      function findChildren(obj) {
        return obj.find('> ul').length > 0;
      }
      
      $target.on('click','a', function(e){
          e.stopPropagation();
          var $this = $(this),
              $depthTarget = $this.next(),
              $siblings = $this.parent().siblings();
        
        $this.parent('li').find('ul li').removeClass('on');
        $siblings.removeClass('on');
        $siblings.find('ul').slideUp(250);
        
        if($depthTarget.css('display') == 'none') {
          _self.activeOn($this);
          $depthTarget.slideDown(_self.speed);
        } else {
          $depthTarget.slideUp(_self.speed);
          _self.activeOff($this);
        }
      })
    },
    activeOff : function($target) {
      $target.parent().removeClass('on');
    },
    activeOn : function($target) {
      $target.parent().addClass('on');
    }
  };

  // gnb
  $(function(){
    gnb.click('#header li', 300)
  });
 
}(jQuery));
// gnb 하나씩 보기  20201116



$(function () {

  // $('#fullpage').fullpage({// 풀페이지  20201124 삭제 
	// 	//options here
	// 	// autoScrolling:true,
  //   // scrollHorizontally: true
  //   autoScrolling: false
	// });

	// //methods
	// // $.fn.fullpage.setAllowScrolling(false);


  // 메뉴 이동 스크롤 
  $(".gnb-menu li a").click(function(){            
  //   // event.preventDefault();
    $('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
  });

});

// 모바일, 웹 분리
$(window).on("load resize", function(){
  var w = $(window).width(); 
  if(w >= 812){  // 웹

    // 지앤비 전체보기
    $(".btn-all-view").click(function () {
      $(".btn-all-close").css("display", "block");
      $(".btn-all-view").css("display", "none");
      $("#headerAll").css("right", "0");
      $(".gnb-bg").css("right", "0");
      $("#header .gnb-menu ul").css("display", "none");
      $("#header .gnb-menu > li").css("opacity", "0");
      $("#headerAll .gnb-menu > li").css("opacity", "1");
    });
    $(".btn-all-close").click(function () {
      $(".btn-all-close").css("display", "none");
      $(".btn-all-view").css("display", "block");
      $("#headerAll").css("right", "-100%");
      $(".gnb-bg").css("right", "-100%");
      $("#header .gnb-menu > li").css("opacity", "1");
      $("#headerAll .gnb-menu > li").css("opacity", "0");
    });

    // gnb on 밑줄
    $('#headerAll .gnb-menu > li').mouseover(function () {
      $(this).children('a').addClass('on');
    });
    $('#headerAll .gnb-menu > li').mouseout(function () {
      $(this).children('a').removeClass('on');
    });
  }

  if(w < 812){  // 모바일
    $(".btn-all-view").click(function () {
      $(".btn-all-close").css("display", "block");
      $(".btn-all-view").css("display", "none");
      $(".gnb").css("right", "0");
      $(".gnb").css("margin-right", "0");
      $(".gnb-bg").css("right", "0");
    });
    $(".btn-all-close").click(function () {
      $(".btn-all-close").css("display", "none");
      $(".btn-all-view").css("display", "block");
      $(".gnb").css("right", "-100%");
      $(".gnb").css("margin-right", "0");
      $(".gnb-bg").css("right", "-100%");
    });
  }
});