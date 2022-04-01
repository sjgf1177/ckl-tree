
	/* $(function(){
		var slidedown=$('.slidedown');
		var slidedown2=$('.slidedown p');
		var heightDown = $(".slidedown li").length;
		var heightDown2 = -(heightDown*30+14);
		var heightDown3 = (heightDown*30+54)+"px";
		$("#header_wrap .slidedown").css('height', heightDown3);
		$("#header_wrap .slidedown div").css('height', heightDown3);
		$("#header_wrap .slidedown").css('top', heightDown2);
		$(".slidedown li:last-child").removeClass('nobg');
		$(slidedown2).toggle( function()    {
			$(slidedown).animate({'top': '-4px'}, {duration: 500});
			$(slidedown).addClass('slidedown2');
			} , function()    {
			$(slidedown).animate({'top': heightDown2}, {duration: 500});
			$(slidedown).removeClass('slidedown2');
		});
	}); */


	$(function(){
	
		//lnb 시작
		var lnb = jQuery('#lnb');
		if (!lnb.length) lnb = jQuery('.lnb') ;
		var lnb_link_depth1 = jQuery(lnb).find(">ol>li"); // 1depth
		if (!lnb_link_depth1.length) lnb_link_depth1 = jQuery(lnb).find(">ul>li"); // 1depth
		lnb_link_depth1=lnb_link_depth1.filter(':not(".NS")') ;
		
		var lnb_link_depth2 = jQuery(lnb_link_depth1).find('ul>li'); // 2depth
		var d_time = 800 ; // 마우스 아웃시 돌아가는 시간
		var current_menu = 0;
		var current_submenu = 0 ;
	
		lnb_link_depth1.each(function (index) {//1depth action
			//add mouseOver
			jQuery(this).find('>a').bind('mouseenter keyup', function () {
				clearTimeout(clearenter);
				menuover = true;
				jQuery(this).parent().addClass("on").siblings().removeClass("on");
				jQuery(this).parent().siblings().removeClass("on");			
			});
	
			jQuery(this).find('>a').bind('click', function () {
				
				clearTimeout(clearenter);
				menuover = true;
				jQuery(this).parent().addClass("on").siblings().removeClass("on");
				jQuery(this).parent().siblings().removeClass("on");			
				jQuery(this).parent().find("ul li:first").addClass("on");
				current_menu = index;			
				current_submenu = jQuery(lnb_link_depth1[index]).children().index();
				
			});
			//add mouseOut
			jQuery(this).bind('mouseleave blur focusout', function () {
				menuover = false;
				clearenter = setTimeout(menuclear, d_time);
			});
		});
		function menuclear() {
			if (!menuover) {
				lnb_link_depth1.removeClass("on");
				jQuery(lnb_link_depth1[current_menu]).addClass('on');
				jQuery(lnb_link_depth2[current_submenu]).addClass('on');
			}
		}
		
		lnb_link_depth2.each(function (index) {//2depth action	
			//add mouseOver
			jQuery(this).bind('mouseover', function () {			
				clearTimeout(clearenter);
				menuover = true;
				jQuery(this).addClass("on").siblings().removeClass("on");
			});
			jQuery(this).bind('click', function () {
				clearTimeout(clearenter);
				menuover = true;
				current_menu = jQuery(this).parent().parent().index() ;
				current_submenu = index;
			});
			//add mouseOut
			jQuery(this).bind('mouseout blur', function () {
				clearenter = setTimeout(menuclear, d_time);
				jQuery(this).removeClass("on");
				menuover = false;
			});
		});	
	});
	
	
	
	$(function(){
		//gnb 시작
		var gnb_link_depth1=$('#gnb>ul>li');	// 1depth
		var gnb_link_depth2=$('#gnb>ul>li>ol>li');	 // 2depth
		var gnb_link_depth3=$('#gnb>ul>li>ol>li>ol>li');	 // 3depth
		var mousev=$('#gnb a');	// 블릿 텍스트컬러 오버
		var d_time = 1000; // 마우스 아웃시 돌아가는 시간
		var current_menu;
		for (var i = 0; i < gnb_link_depth1.length ; i++ )
		{
			if (0<$(gnb_link_depth1[i]).find('.on').length)
			{
				current_menu = i;
				//alert(current_menu);
			}
		}
				mousev.each(function(){
			//add mouseOver
			$(this).bind('mouseenter keyup' , function()    {
				$(mousev).removeClass('on');
				$(this).addClass('on');
			});
			//add mouseOut
			$(this).bind('mouseleave blur' , function()    {
				$(mousev).removeClass('on');
			});
		});
		gnb_link_depth1.each(function(){
			//add mouseOver
			$(this).bind('mouseenter keyup' , function()    {
				$(this).addClass('on').siblings().removeClass('on');
				menuover=true;
			});
			//add mouseOut
			$(this).bind('mouseleave blur' , function()    {
				menuover=false;
				clearenter = setTimeout(menuclear,d_time);
			});
		});
		function menuclear(){
			if(!menuover){
				gnb_link_depth1.removeClass('on'); //지워야할 클래스위치
				$(gnb_link_depth1[current_menu]).addClass('on');
			}
		}
		gnb_link_depth2.each(function(){
			//add mouseOver
			$(this).bind('mouseover keyup' , function()    {
				clearTimeout(clearenter);
				$(this).parent().parent().find('>a').css('color','#54a1a9');
				$(this).addClass('on').siblings().removeClass('on');
				menuover=true;
			});
			//add mouseOut
			$(this).bind('mouseout blur' , function()    {
				menuover=false;
				clearenter = setTimeout(menuclear,d_time);
				$(this).removeClass('on');
				$(this).parent().parent().find('>a').css('color','#ffffff');
			});
		});
		gnb_link_depth3.each(function(){
			//add mouseOver
			$(this).bind('mouseover keyup' , function()    {
				$(this).parent().parent().find('>a').addClass('obber');
			});
			//add
			$(this).bind('mouseout blur' , function()    {
			$(this).parent().parent().find('>a').removeClass('obber');
			});
		});
	});
