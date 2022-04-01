// 팝업존
jQuery.fn.slideUpDown = function(options, configs) {
	opt = jQuery.extend({
			list_item	: jQuery(this).find('.item'),
			itemSet		: jQuery(this).find('.itemSet'),
			prevBtn		: jQuery(this).find(".prevBtn"),
			nextBtn		: jQuery(this).find(".nextBtn"),
			playBtn		: jQuery(this).find(".playBtn"),
			stopBtn		: jQuery(this).find(".stopBtn"),
			scrollArea	: jQuery(this).find(".area"),
			scrollTime	: 4000,
			dep_step 	: 268, //	dep_step = jQuery('.area li img:first').width()
			autoPlay	: false
		},options);
		// var slideSet	= jQuery('.slideSet')
		var list_item	= opt.list_item;
		var itemSet		= opt.itemSet;
		var prevBtn		= opt.prevBtn;
		var nextBtn		= opt.nextBtn;
		var playBtn		= opt.playBtn;
		var stopBtn		= opt.stopBtn;
		var scrollArea	= opt.scrollArea;
		var scrollTime	= opt.scrollTime;
		var dep_step 	= opt.dep_step;
		var movie_dep	= 0;
		var max = list_item.length;
		var play_inter;

	nextBtn.click(function(){
		// scrollArea.scrollTop(0);
		if (Math.abs(movie_dep) <  itemSet.innerHeight()-dep_step){
			movie_dep = movie_dep - dep_step;
			itemSet.css("top",movie_dep);
		}else{
			console.log('더이상 없음')
		}
		return false;
  	});
	prevBtn.click(function(){

		// scrollArea.scrollTop(0);
		if (movie_dep >=0)
		{

		}
		else
		{
			movie_dep=movie_dep + dep_step;
			itemSet.css("top",movie_dep);
		}
		return false;
	});
	playBtn.bind('click' , function()    {
		clearInterval(play_inter);
		play_inter = setInterval(popup_play,scrollTime) // 시간
	})
	stopBtn.bind('click' , function()    {
		clearInterval(play_inter);
	})
	
	function popup_play(){
		if (Math.abs(movie_dep) <  itemSet.innerHeight()-dep_step)
		{
			movie_dep = movie_dep - dep_step;
			itemSet.css("top",movie_dep);
		}
		else
		{
			movie_dep = 0;
			itemSet.css("top",movie_dep);
		}
	}
	jQuery(list_item).bind('mouseover',function(){
		//stopBtn.trigger("click"); 
	})
	jQuery(list_item).bind('mouseout',function(){
		//playBtn.trigger("click"); 
	})
	if (opt.autoPlay) playBtn.trigger("click"); // 시작시 재생
};
