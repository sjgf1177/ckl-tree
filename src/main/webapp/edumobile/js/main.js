/* --------------------------------------------
 READY FUNCTION
-------------------------------------------- */
$(document).ready(function() {




	$('#m1Roller').carouFredSel({
		width: '100%',
		height: 'auto',
		auto: false,
		responsive: true,
		items: {
			visible: 1,
			start: 1
		},
		scroll: {
			items: 1,
			duration: 1000,
			timeoutDuration: 30000,
			onBefore: function( data ) {
				//data.items.old.eq(2).removeClass('selected');
				//console.log(data.items.old.eq(2).find('img').attr("title"));
				//data.items.old.eq(2).find('.descTts span').text(data.items.old.eq(2).find('img').attr('title'));
				//data.items.visible.eq(2).addClass('selected');
			}
		},
		onCreate: function( e ) {
			//openItem( e.items.eq( 1 ) );
		},
		prev: '#prevm1Roller',
		next: '#nextm1Roller',
		//play: '#m1RollerPlay',
		//stop: '#m1RollerStop',
		pagination: {
			//container: '#pagerm1Roller'
		}
	});



	//m2RollingSet
	$('#m2Tabs').carouFredSel({
		circular: false,
		items: 1,
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

	$("#m2RollingSet .inCtrl:first-child").addClass("on");
	$('#m2Setpager a').each(function(index){
		$(this).bind("click", function(){
			$("#m2RollingSet .inCtrl").removeClass("on");
			$("#m2RollingSet .inCtrl").eq(index).addClass("on");
		})
	});


	//m2Rlling2
	var $pagers20 = $('#m20Pager a');
	var _onBefore20 = function() {
		$(this).find('img').stop().fadeTo( 300, 1 );
		$pagers20.removeClass( 'selected' );
	};
	$('#m20Roller').carouFredSel({
		items: 1,
		width: 320,
		auto: false,
		responsive: true,
		scroll: {
			duration: 750
		},
		prev: {
			button: '#m20prev',
			items: 1,
			onBefore: _onBefore20
		},
		next: {
			button: '#m20next',
			items: 1,
			onBefore: _onBefore20
		}
	});

	//m2Rlling2
	var $pagers21 = $('#m21Pager a');
	var _onBefore21 = function() {
		$(this).find('img').stop().fadeTo( 300, 1 );
		$pagers21.removeClass( 'selected' );
	};
	$('#m21Roller').carouFredSel({
		items: 1,
		width: '100%',
		auto: false,
		responsive: true,
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
		items: 1,
		width: '100%',
		auto: false,
		responsive: true,
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


	$("#m3RollingSet .inCtrl:first-child").addClass("on");
	$('#m3Setpager a').each(function(index){
		$(this).bind("click", function(){
			$("#m3RollingSet .inCtrl").removeClass("on");
			$("#m3RollingSet .inCtrl").eq(index).addClass("on");
		})
	});


	//m2Rlling2
	var $pagers30 = $('#m30Pager a');
	var _onBefore30 = function() {
		$(this).find('img').stop().fadeTo( 300, 1 );
		$pagers30.removeClass( 'selected' );
	};
	$('#m30Roller').carouFredSel({
		items: 1,
		width: '100%',
		height:240,
		auto: false,
		responsive:true,
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
		items: 1,
		width: '100%',
		auto: false,
		responsive:true,
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
		items: 1,
		width: '100%',
		auto: false,
		responsive:true,
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

});


