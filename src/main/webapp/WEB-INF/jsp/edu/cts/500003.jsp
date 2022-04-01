<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>














<div class="mb10 alert big_box type_1">
	<p class="alert_title short_bottom">창의인재 배출! 문화사업 전문인력 양성! 에듀코카 &lt;온라인교육&gt; 편을 소개합니다.</p>
	<p class="alert_desc">
	에듀코카는 게임, 방송영상, 만화애니캐릭터, 음악공연 분야 등 온라인 정규과정과, <span class="apply_no_text">열린강좌를
	무료로 서비스</span>하고 있습니다.</p>
</div>

<div class="vodBx mb10">
	<video src="/upload/onlineEdu/KOCCA.mp4" width="100%" height="568" controls><!-- rsg20170908 /contents/pr_movie/kocca_pr_movie_640.mp4  -->
	   <source src="/upload/onlineEdu/KOCCA.mp4" type="video/mp4" /><!-- 모바일 ie9, Chrom, safari-->
	   <!--  <source src="media/chrome.ogv" type='video/ogg; codecs="theora, vorbis"' />firefox, opera, Chrom  -->
	</video>

</div>


<div class="vodPObj">
	<div class="mt15 board_util_btn_con">
		<a href="javascript:void(0);" class="btn_style_0 green openlecture_eye close_w closeVodr" style="display:none; margin-right:0; margin-bottom:0;">자막닫기</a>
		<a href="javascript:void(0);" class="btn_style_0 green openlecture_eye OpenVodr">자막보기</a>
	</div>
	<div class="vodBxSet" style="max-width: 1000px; margin-left: auto; margin-right: auto; box-sizing: border-box; font-size: 1.45rem; line-height: 2.6rem; color: rgb(49, 49, 49); letter-spacing: -0.025em; padding: 20px 25px; border: 2px solid rgb(90, 201, 183); text-align: left; max-height: 300px; overflow-y: auto; background-color:transparent;">
		자막을 준비중입니다.
	</div>
</div>
<script type="text/javascript">
//<![CDATA[

	$(".vodBxSet").hide();
	$(".closeVodr").click(function(e){
		$(this).hide();
		$(".vodBxSet").hide();
		$(".OpenVodr").show();
		$(".OpenVodr").focus();
	});
	$(".OpenVodr").click(function(e){
		$(this).hide();
		$(".vodBxSet").show();
		$(".closeVodr").show();
		$(".closeVodr").focus();
	});
//]]>
</script>