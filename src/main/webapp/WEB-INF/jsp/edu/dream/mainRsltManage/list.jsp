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
					콘텐츠 창작의 소질과 소양을 갖춘
					자로서 플랫폼 기관 및 멘토에게
					창작활동에 필요한 실무를
					습득하는 자
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
					콘텐츠산업 분야의
					창작 전문가로 창의교육생을
					선발하여 창작활동에
					필요한 연수기회를 제공하는 자
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
					소정의 심사를 거쳐 <br>
					&lt;창의인재 동반사업&gt;
					운영기관으로 선정되어
					본 사업을 수행하는 기관
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


<h5 class="border" style="margin-bottom:5px;">
	주요성과 및 사례
</h5>
<!--<div class="col-12 mentorlineup_header">
	<p class="col-12 sub_title">01.현황</p>
	<div class="col-12 mentorlineup_card_wrap_0">
		<div class="col-12 col-xs-6 col-md-0 fn-md tc mentorlineup_card_con">
			<div class="mentorlineup_card">
				<div class="img_box">
					<img src="/edu/images/bm/mentorlineup_img_000.png" alt="창의인재 멘티 이미지">
				</div>
				<p class="text_box">
					<span class="sub_title">창의인재 멘티</span>
					862명
				</p>
			</div>
		</div>
		<div class="mentorlineup_dim"></div>
		<div class="col-12 col-xs-6 col-md-0 fn-md mentorlineup_card_con">
			<div class="mentorlineup_card">
				<div class="img_box">
					<img src="/edu/images/bm/mentorlineup_img_001.png" alt="창의인재 멘토 이미지">
				</div>
				<p class="text_box">
					<span class="sub_title">창의인재 멘토</span>
					375명
				</p>
			</div>
		</div>
		<div class="mentorlineup_dim"></div>
		<div class="col-12 col-xs-4 col-md-0 fn-md mentorlineup_card_con">
			<div class="mentorlineup_card">
				<div class="img_box">
					<img src="/edu/images/bm/mentorlineup_img_002.png" alt="수행프로젝트 이미지">
				</div>
				<p class="text_box">
					<span class="sub_title">수행프로젝트</span>
					1,363개
				</p>
			</div>
		</div>
		<div class="mentorlineup_dim"></div>
		<div class="col-12 col-xs-4 col-md-0 fn-md mentorlineup_card_con long">
			<div class="mentorlineup_card">
				<div class="img_box">
					<img src="/edu/images/bm/mentorlineup_img_003.png" alt="국내외 공모전 수상 이미지">
				</div>
				<p class="text_box">
					<span class="sub_title">국내외 공모전 수상</span>
					119회
				</p>
			</div>
		</div>
		<div class="mentorlineup_dim"></div>
		<div class="col-12 col-xs-4 col-md-0 fn-md mentorlineup_card_con middle">
			<div class="mentorlineup_card">
				<div class="img_box">
					<img src="/edu/images/bm/mentorlineup_img_004.png" alt="작품계약 및 데뷔 이미지">
				</div>
				<p class="text_box">
					<span class="sub_title">작품계약 및 데뷔</span>
					153회
				</p>
			</div>
		</div>
	</div>
</div>
<hr class="col-12 mentorlineup_line"> -->
<div class="col-12 mentorlineup_body_con">
	<!-- <p class="col-12 sub_title">02.주요성과</p> -->
	<c:forEach items="${years}" var="yearNm" varStatus="status">
	<c:forEach var="code" items="${COM087CodeList}" varStatus="status">
		<c:if test="${code.codeNm eq yearNm }">
			<c:set var="yearCode" value="${code.code }"/>
		</c:if>
	</c:forEach>
	<div class="col-12 mentorlineup_body">
		<%-- <div class="mentorlineup_card_header">
			<c:out value="${yearNm}"/>년
		</div> --%>
	<div class="center board_util_btn_con" style="margin:30px 0px 15px 0px;">
		<a href="/edu/dream/mainRsltManage/mainRsltPopList.do?viewType=BODY&amp;year=<c:out value='${yearCode }' />" class="btn_style_0 green radius listBook popUpList" title="<c:out value='${yearNm }'/>년 주요성과 리스트 새 창 열림">
			<c:out value="${yearNm }"/>년 주요성과 리스트
		</a>
	</div>
		<div class="col-12 mentorlineup_card_wrap_1">
			<div class="over-hidden calc_wrap15">
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:if test="${yearNm eq result.yearNm }"> <%--출력연도와 값을 비교해서 값이 맞으면 출력 --%>
				<c:if test="${result.mainExpsrAt eq 'Y' }"> <%--메인이미지 노출 'Y', 'N' 에따른 출력 --%>
				<c:set var="fileList" value="${fileMap[result.atchFileId] }" />
				<c:forEach var="files" items="${fileList }">
					<c:if test="${files.fileFieldName eq 'mainExpsrImage' }">
						<c:set var="file" value="${files }" />
					</c:if>
				</c:forEach>
				<div class="col-6 col-sm-3 mentorlineup_list">
					<div class="mentorlineup_card">
						<div class="img_box">
							<c:if test="${not empty file }">
								<img src="/cmm/fms/getImage.do?atchFileId=<c:out value='${file.atchFileId}'/>&amp;fileSn=<c:out value='${file.fileSn}'/>" alt="<c:out value="${result.rsltSeNm }" /><c:out value="[${result.prdctNm }]" />" style="width: 350px;height: 120px;" class="bdn" />
							</c:if>
						</div>
						<div class="text_box">
							<ul class="list_style_2 mentorlineup">
								<li><c:out value="${result.rsltSeNm }" /></li>
							</ul>
							<h6><c:out value="${result.prdctNm }" /></h6>
							<p class="h_desc6">
								멘티 : <c:out value="${result.mentiNm }" /><br/>
								멘토 : <c:out value="${result.mentoNm }" />
							</p>
						</div>
					</div>
				</div>
					<c:set var="file" value="" />
					</c:if>
					</c:if>
				</c:forEach>
				<c:set var="yearCode" value=""/>
			</div>
		</div>
	</div>
	</c:forEach>
</div>

<style>
	.linemap_wrap .linemap_con li:nth-child(4) { display:none }
</style>