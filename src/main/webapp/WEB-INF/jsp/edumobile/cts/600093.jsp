<%@page contentType="text/html;charset=utf-8" %>
<div class="col-12 tc" style="text-align: center;"> 
	<img src="http://edu.kocca.or.kr/upload/jobfair/170829notice.jpg" alt="기업 참가 신청 포스터" />
	
	<p>
	<br />
	<br />
	
		<a href="http://edu.kocca.or.kr/upload/jobfair/170818jobfair-Comp.zip"><span style="color: rgb(64, 171, 212); font-size: 35px; font-weight: bold; text-decoration: underline;">첨부파일 다운로드</span></a>
	
	</p>

</div>

<script>

$(function() {
	$('#jobFairCompImg').rwdImageMaps(); 
});
/*
* rwdImageMaps jQuery plugin v1.5
*
* Allows image maps to be used in a responsive design by recalculating the area coordinates to match the actual image size on load and window.resize
*
* Copyright (c) 2013 Matt Stow
* https://github.com/stowball/jQuery-rwdImageMaps
* http://mattstow.com
* Licensed under the MIT license
*/
;(function(a){a.fn.rwdImageMaps=function(){var c=this;var b=function(){c.each(function(){if(typeof(a(this).attr("usemap"))=="undefined"){return}var e=this,d=a(e);a("<img />").load(function(){var g="width",m="height",n=d.attr(g),j=d.attr(m);if(!n||!j){var o=new Image();o.src=d.attr("src");if(!n){n=o.width}if(!j){j=o.height}}var f=d.width()/100,k=d.height()/100,i=d.attr("usemap").replace("#",""),l="coords";a('map[name="'+i+'"]').find("area").each(function(){var r=a(this);if(!r.data(l)){r.data(l,r.attr(l))}var q=r.data(l).split(","),p=new Array(q.length);for(var h=0;h<p.length;++h){if(h%2===0){p[h]=parseInt(((q[h]/n)*100)*f)}else{p[h]=parseInt(((q[h]/j)*100)*k)}}r.attr(l,p.toString())})}).attr("src",d.attr("src"))})};a(window).resize(b).trigger("resize");return this}})(jQuery);

</script>