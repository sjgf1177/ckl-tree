<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>


<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />
<script type="text/javascript">
//<![CDATA[
$(window).ready(function() {
	$(".popUpList").click(function() {
		var url = $(this).attr("href");
		window.open(url,"주요성과관리_팝업","scrollbars=yes,width=800, height=700");
		return false;
	});

});

//]]>
</script>


<div class="tab_style_1_con">
	<ul class="tab_style_1 three_tab size_24">
		<li class="active"><a href="/edu/dream/mainRsltManage/list.do?menuNo=500040" title="현재탭"><span>사업소개</span></a></li>
		<li><a href="/edu/dream/pltfomList/list.do?menuNo=500117"><span>플랫폼기관</span></a></li>
		<!-- <li><a href="/edu/dream/mentorManage/list.do?menuNo=500119"><span>멘토라인업</span></a></li> -->
		<li><a href="/edu/bbs/B0000041/list.do?menuNo=500211"><span>창의현장</span></a></li>
	</ul>
</div>

<div class="edu_together_view_inner">
<h3>콘텐츠 창의인재동반사업 소개</h3>
	<p class="view_desc">
		<span class="color_black">콘텐츠 창의인재동반사업은 대한민국 콘텐츠산업의 미래를 이끌어갈
		우수한 콘텐츠 창작자 육성을 위해 플랫폼기관의 네트워크와 콘텐츠분야 정상급 전문가(멘토)가
		창의교육생(멘티)에게 프로젝트 중심의 현장 밀착형 멘토링을 지원하는 사업입니다.</span>
	</p>
	<div class="edu_youtube_wrap">
		<!-- <iframe width="560" height="315" src="https://www.youtube.com/embed/lihO7WTTxak" frameborder="0" allowfullscreen title="2016 창의인재동반사업 소개"></iframe> -->
		<video width="100%" height="auto"  poster="https://edu.kocca.kr/upload/dream/dream_introduce_2020_ep.jpg" oncontextmenu="return false;" controls="true" controlslist="nodownload">
			<source src="https://edu.kocca.kr/upload/dream/dream_introduce_2020_ep.mp4" type="video/mp4">
		</video>
	</div>
	<div class="edu_youtube_subtitle_view_btn_con">
		<button class="edu_youtube_subtitle_view_btn caption_btn" onclick="showCaption();"><span class="edu_view_default" style="color:white">자막보기</span><span class="edu_view_active">자막닫기</span></button>
		<div class="edu_youtube_subtitle_view_text" tabindex="0">
			
			유민호 │작곡가
			<br/><동백꽃 필 무렵> OST 작·편곡
			<br/><조선로코 녹두전> OST 작·편곡
			<br/><검법남녀> OST 작·편곡
			<br/>
			<br/>(멘트)작업을 하다 보면 혼자 벽에 막혀 답답한 순간이 많은데 그럴 때마다 멘토님이 다양한 의견을 주신 덕분에 난관을 보다 쉽게 극복할 수 있었던 것 같아요.
			<br/>
			<br/>당신의 든든한 지원자
			<br/>창의인재동반사업 멘토링 프로그램
			<br/>
			<br/>곽보연 │ 웹툰 작가
			<br/>웹툰 <우리는 매일매일> 연재
			<br/>구독자 40만명
			<br/>총 조회수 1,520만 건
			<br/>
			<br/>(멘트)제 머릿속으로만 상상하던 캐릭터와 이야기를 실제로 연재하게 됐다는 게 신기해요
			<br/>다양하게 멘토에게 도움을 받을 수 있다는 게 가장 큰 장점이죠
			<br/>
			<br/>다양한 멘토들의 서포트
			<br/>창의인재동반사업 멘토링 프로그램
			<br/>
			<br/>이승환 │ 게임개발자
			<br/>액션 RPG 게임 <그레이트 소드> 출시
			<br/>구글 및 앱스토어
			<br/>누적 다운로드 13만
			<br/>
			<br/>(멘트)게임이 좋아서 무작정 게임을 만드는 사람이 되어야겠다고 생각했죠
			<br/>그런데 그게 쉽나요?
			<br/>지금은 창의인재동반사업 덕분에 꿈을 이룬 것 같아 너무 기쁩니다.
			<br/>
			<br/>내 꿈을 향한 도전
			<br/>창의인재동반사업 멘토링 프로그램
			<br/>
			<br/>꿈을 현실로 만들고 싶다면
			<br/>
			<br/>(멘트)꿈을 현실로 만들고 싶다면
			<br/>
			<br/>지금 도전하세요
			<br/>창의인재동반사업이 도와줄 거에요
			<br/>
			<br/>(멘트)지금 도전하세요
			<br/>창의인재동반사업이 당신을 돕겠습니다.
			<br/>
			<br/>(멘트)창의인재동반사업, 다음 성공의 주인공은 당신입니다.
			<br/>
			<br/>문화체육관광부(로고) 한국콘텐츠진흥원(로고)
			<br/>
			<br/>(멘트)한국콘텐진흥원
			<br/>
		</div>
	</div>
</div>

<div class="edu_together_three_card_con" style="border-bottom:1px solid #eeeeee;">
	<div class="col-12 col-md-4 edu_together_three_card_list">
		<div class="col-12">
			<div class="icon_box">
				<img src="/edu/images/bm/edu_together_icon_000.png" alt="창의교육생 멘티">
			</div>
			<div class="text_box">
				<p class="three_card_title">
					창의교육생(멘티)
				</p>
				<p class="three_card_desc">
					콘텐츠 창작의 소질과 소양을 갖춘, 플랫폼기관 및 멘토로부터
					창작실무와 노하우를 전수받고자 하는 열정 넘치는 예비창작자
				</p>
				<p style="margin-top:15px;">
					<spen style="font-size:25px; font-weight:bold; color:#01A9DB;">2,368</spen> 명
				</p>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-4 edu_together_three_card_list">
		<div class="col-12">
			<div class="icon_box">
				<img src="/edu/images/bm/edu_together_icon_001.png" alt="창의교육생 멘토">
			</div>
			<div class="text_box">
				<p class="three_card_title">
					멘토
				</p>
				<p class="three_card_desc">
					콘텐츠산업 분야의 전문가로서,
					플랫폼기관과 함께 청년인재(멘티)를
					선발, 도제식 교육을 통한 노하우 전수
				</p>
				<p style="margin-top:15px;">
					<spen style="font-size:25px; font-weight:bold; color:#01A9DB;">1,118</spen> 명
				</p>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-4 edu_together_three_card_list">
		<div class="col-12">
			<div class="icon_box">
				<img src="/edu/images/bm/edu_together_icon_002.png" alt="플랫폼 기관">
			</div>
			<div class="text_box">
				<p class="three_card_title">
					플랫폼기관
				</p>
				<p class="three_card_desc">
					소정의 심사를 거쳐 선발된 기관으로
					멘토와 멘티의 양방향 네트워크
					연계를 통해 현장형 도제식 멘토링,
					창의숙성과정을 운영하는 기관
				</p>
				<p style="margin-top:15px; padding-left:20px;">
					<spen style="font-size:25px; font-weight:bold; color:#01A9DB;">93</spen> 개
				</p>
			</div>
		</div>
	</div>
	<div style="font-size:13px; color:#A4A4A4; text-align:right; margin-right:52px; margin-bottom:25px;">
		* 2012년 ~ 2020년 누적 기준
	</div>
</div>

<style>
	.linemap_wrap .linemap_con li:nth-child(4) { display:none }
</style>