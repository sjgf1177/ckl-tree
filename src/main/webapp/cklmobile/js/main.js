/* READY FUNCTION */

$(function(){
	$(".popupList ul").carouFredSel({
		responsive: true,
		align		: "left",
		width		: "100%",
		items		:{
		visible : 1
	},
		scroll      :{
		items		:1,
		duration        : 390,
		timeoutDuration: 5000,
		pauseOnHover	: false
	},
		next: '.nextPop',
		prev: '.prevPop',
		direction	: "left"
	});


	$('.popupList ul').bind('updatePageStatus.cfs', function() {
		var _psTotal = $(this).children().length;
		var _psCurrent = $(this).triggerHandler( 'currentPosition' ) + 1;
		$('.popupZone .total').text(_psCurrent +' / '+ _psTotal);
	}).trigger( 'updatePageStatus.cfs' );


	$(".playPop").hide();
	$(".stopPop").click(function() {
		$(this).hide();
		$(".playPop").show();
		$(".popupList ul").trigger("pause");
	});
	$(".playPop").click(function() {
		$(this).hide();
		$(".stopPop").show();
		$(".popupList ul").trigger("play");
	});
	$('.popupList a').each(function(index) {
		$(this).bind('focus', function() {
			$(".popupList ul").trigger("pause");
		});
	});
});