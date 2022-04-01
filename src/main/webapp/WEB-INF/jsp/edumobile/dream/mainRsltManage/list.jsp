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
	<ul class="tab_style_1 three_tab size_33">
		<li class="active"><a href="/edumobile/dream/mainRsltManage/list.do?menuNo=600104" title="선택됨"><span>사업소개</span></a></li>
		<li><a href="/edumobile/dream/pltfomList/list.do?menuNo=600105"><span>플랫폼기관</span></a></li>
		<li><a href="/edumobile/dream/mentorManage/list.do?menuNo=600106"><span>멘토라인업</span></a></li>
	</ul>
</div>

<!-- <div class="edu_together_view_inner">
	<p class="view_desc">
		<span class="color_black">창의인재동반사업</span>은 대한민국 콘텐츠사업의 미래를 이끌어갈
		경쟁력 있는 콘텐츠 창작자 육성을 위해 플랫폼기관의 네트워크와 <span class="color_black">콘텐츠분야 정상급 전문가(멘토)가
		창의교육생(멘티)에게 프로젝트 중심의 현장 밀착형 멘토링을 지원하는 사업</span>입니다.
	</p>
	<div class="edu_youtube_wrap">
		<iframe width="560" height="315" src="https://www.youtube.com/embed/lihO7WTTxak" frameborder="0" allowfullscreen title="2016 창의인재동반사업 소개 동영상"></iframe>
	</div>
	<div class="edu_youtube_subtitle_view_btn_con">
		<span class="edu_youtube_subtitle_view_btn caption_btn">
			<a href="javascript:void(0)" class="edu_view_default">자막보기</a>
			<a href="javascript:void(0)" class="edu_view_active">자막내용표시</a>
			<a href="javscript:void(0)" class="edu_view_close_btn" title="자막닫기"></a>
		</span>
		<div class="edu_youtube_subtitle_view_text">
			자막을 준비중입니다.
			2016 창의인재동반사업 소개 3분 36초. 자막최초등록 : rsg20171229
			Create NeWave KOCCA! <br>
			대한민국 영토, 콘텐츠로 넓힌다!  <br>
			2016 콘텐츠 창의인재 양성사업 <br>
			READY CREATOR RUNWAY. <br>
			세계로 뻗어나가는 대한민국 콘텐츠.   <br>
			칸의 자랑스러운 韓영화들. '태양의 후예' 27개국 수출. '스푸키즈'미국 킥스타터 시작. <br>
			대한민국 미래 킬러 콘텐츠의 주역은 여러분 입니다. <br>
			(대한민국 영토, 콘텐츠로 넓힌다! Create NeWave KOCCA 로고) <br>
			(READY CREATOR RUNWAY 로고) <br>
			[2016 창의인재 양성사업 발대식 축하멘트] <br>
			배우 한지민 : 많은 멘티 여러분들 <br>
			가수 악동뮤지션 : 오늘을 시작으로 <br>
			작가 신동익 : 대한민국의 문화 영토를 넓혀 주시기를 부탁드리겠습니다. <br>
			배우 심은경 : 2016년 창의인재 양성 사업 발대식을 <br>
			배우 한지민 : 진심으로 축하드립니다. <br>
			가수 디오 엑소 : 진심으로 축하드립니다. <br>
			가수 악동뮤지션 : 축하드립니다. <br>
			 <br> <br>
			창의인재 동반사업. 전문가 멘토와 역량을 갖춘 멘티의 만남! 창작 노하우를 전수받는 현장밀착형 전진기지.<br>
			K'occa. 창의인재.멘토. 플랫폼 기관. 창의인재 동반사업.<br>
			<br><br>
			(대한민국 영토, 콘텐츠로 넓힌다! Create NeWave KOCCA 로고)<br>
			[2012 창의인재 동반사업]뮤지컬, 2012~2015 앵콜공연. 여신님이 보고계셔 - 멘티 한정석 멘토 조성원<br>
			[2013 창의인재 동반사업]만화, 2014 대한민국 콘텐츠대상 문화체육관광부 장관상 수상 - 멘티 김보민 멘토 장정숙<br>
			[2014 창의인재 동반사업]영화, 480만 관객 동원(국내 다큐멘터리 사상 최대)님아, 그 강을 건너지 마오 - 멘티 백성준 이정준 명준희 나현우, 멘토 진모영<br>
			[2015 창의인재 동반사업]영화, 540만 관객 동원 검은 사제들 - 멘티 장재현 멘토 황병국<br>
			<br><br>
			[2016 창의인재 양성사업 멘토분들을 소개합니다]<br>
			- 창의인재 동반사업 -<br>
			동국대학교 뮤지컬<br>
			세종대학교 산학협력단 웹툰<br>
			초이스컷픽쳐스 영화<br>
			아이엠티브이 방송<br>
			충북지식산업진흥원 스토리텔링<br>
			아트센터 나비 융복합 콘텐츠<br>
			한국독립애니메이션협회 애니메이션<br>
			한국영화프로듀서조합 영화/방송<br>
			<br><br>
			김수로 Mentor (영극<유럽 블로그><데스트랩>등) : 열심히 하십시오. 좋은 성과 거두시길 바라겠습니다.<br>
			김은희 Mentor (드라마<시그널><싸인><유령>등) : 여러분들에게 매우 의미있는 시간이 되길 바랍니다.<br>
			표종록 Mentor (드라마<드림하이>등) : 이런 기회를 주셔서 감사하고 멘티 여러분들 화이팅 하시길 바랍니다.<br>
			장소영 Mentor (뮤지컬<팬텀><그날들>등) : 꿈이 있는 사람은 아름답습니다. 여러분들 항상 응원하겠습니다. 화이팅!<br>
			<br><br>
			우수크리에이터 발굴지원. 신인 창작자와 콘텐츠분야 전문기관의 매칭을 통해 기획,제작,유통 전 단계를 지원하는 프로젝트형 인력양성.<br>
			<br><br>
			(대한민국 영토, 콘텐츠로 넓힌다! Create NeWave KOCCA 로고)<br>
			[2015 우수크리에이터 주요성과] 뮤지컬, 영화제작사 뉴본과 판권계약 거위의 꿈 - 기관 라이브(주) 창작자 김연희<br>
			[2015 우수크리에이터 주요성과] 드라마, JTBC2 및 네이버TV캐스트 방영. 앙마 다이어리 (박세진 "나를 잊지마요") - 기관 앤미디어 창작자 신유담<br>
			<br><br>
			우수크리에이터 발굴지원 사업<br>
			[장르별 운영기관을 소개합니다]<br>
			로이비쥬얼 영상<br>
			오우엔터테이번트 음악<br>
			앤미디어 웹콘텐츠<br>
			뿌리깊은나무들 웹드라마<br>
			알앤디웍스 뮤지컬<br>
			2016 우수크리에이터 발굴지원 사업. 5개 기관 23명 전담인력 46명 멘티.<br>
			한주원(15년 지원작<앙마다이어리> : 좋은 작품에 출연할 수 있었던건 여러분들의 열정 덕분이라고 생각합니다.<br>
			최완규(드라마<옥중화><빛과 그림자> : 포기하지 마시고 꼭 꿈을 이루어내시길 바랍니다.<br>
			노우성(뮤지컬<애드거 앨런 포><셜록홈즈>) : 분명히 좋은 결과가 있을 거라고 생각됩니다.<br>
			<br><br>
			[창의인재 동반사업 멘토진]<br>
			동국대학교 산학협력단 : 고선웅 왕용범 오은희 이종대 장소영 이성준 유인수 김수로 최진 정달영 한승원<br>
			세종대학교 산학협력단 : 김준협 남준석 박인하 박철권 이승진 이종규 이종범 장정숙 전진석 황남용 한창완<br>
			아이엠티브이 : 김이영 곽상원 이영숙 신진주 박원우 정종숙 김은희 장정희 황주하 김은영<br>
			아트센터 나비 : 하이브(한창민) 김윤철 박훈규 왕지원 노소영 김병월 강병수 하대환 양민하 에브리웨어(방현우,허윤실)<br>
			충북지식산업진흥원 : 김정헌 김태원 박지연 서동수 오형석 이경희 이성주 이성희 정세호 천성일 표종록<br>
			초이스컷픽쳐스 : 유영아 이재규 장철수 최낙권 이준택 장진승 김도수 이순규 김종혁 이재문<br>
			한국독립애니메이션협회 : 장형윤 홍덕표 우경민 오서로 김영준 김광회 하광민 이든 박민 이성환<br>
			한국영화프로듀서조합 : 김완식 김현정 박관수 박연선 유병옥 윤창업 이윤진 정주균 최민석 황조윤 이영종<br>
			<br><br>
			[우수크리에이터 발굴지원사업 전담인력]<br>
			로이비쥬얼 : 김선구 조성경<br>
			알앤디웍스 : 김준희 노우성 설도권 오훈식 이혁찬 정태영 최종윤<br>
			앤미디어 : 강동길 박동훈 이경진 이민경 김은진 임성희<br>
			오우엔터테이번트 : 강동윤 유진오 이필호 장승준 이창희 전창엽 최인희 최철호<br>
			뿌리깊은나무들 : 윤신애 최완규<br>
			<br><br>
			장우석 Mentee : 교류 나누면서 상호 발전할 수 있는 계기가 되었으면 좋겠습니다.<br>
			<br><br>
			READY, CREATOR RUNWAY.<br>
			(READY CREATOR RUNWAY 로고)<br>
			(문화체육관광부 로고)<br>
			(Create NeWave K'occa 한국콘텐츠진흥원 로고)
		</div>
	</div>
</div> -->
<div class="edu_together_view_inner">
<h3>콘텐츠 창의인재 동반사업 소개</h3>
	<p class="view_desc">
		<span class="color_black">콘텐츠 창의인재동반사업은 대한민국 콘텐츠산업의 미래를 이끌어갈
		우수한 콘텐츠 창작자 육성을 위해 플랫폼기관의 네트워크와 콘텐츠분야 정상급 전문가(멘토)가
		창의교육생(멘티)에게 프로젝트 중심의 현장 밀착형 멘토링을 지원하는 사업입니다.</span>
	</p>
	<div class="edu_youtube_wrap">
		<!-- <iframe width="560" height="315" src="https://www.youtube.com/embed/lihO7WTTxak" frameborder="0" allowfullscreen title="2016 창의인재동반사업 소개"></iframe> -->
		<video width="100%" height="auto"  poster="/upload/dream/dream_introduce_2018.jpg" oncontextmenu="return false;" controls="true" controlslist="nodownload">
			<source src="/upload/dream/dream_introduce_2018.mp4" type="video/mp4">
		</video>
	</div>
	<div class="edu_youtube_subtitle_view_btn_con">
		<span class="edu_youtube_subtitle_view_btn caption_btn"><span class="edu_view_default" style="color:white">자막보기</span><span class="edu_view_active">자막내용표시</span></span>
		<div class="edu_youtube_subtitle_view_text">
			자막을 준비중입니다.
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
					창의교육생 멘티
				</p>
				<p class="three_card_desc">
					콘텐츠 창작의 소질과 소망을 갖춘
					자로서 플랫폼 기관 및 멘토에게
					창작활동에 필요한 실무를
					습득하는 자
				</p>
				<p style="margin-top:15px;">
					<spen style="font-size:25px; font-weight:bold; color:#01A9DB;">1409</spen> 명
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
					창의교육생 멘토
				</p>
				<p class="three_card_desc">
					콘텐츠사업 분야의
					창작 전문가로 창의교육생을
					선발하여 창작활동에
					필요한 연수기회를 제공하는 자
				</p>
				<p style="margin-top:15px;">
					<spen style="font-size:25px; font-weight:bold; color:#01A9DB;">640</spen> 명
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
					플랫폼 기관
				</p>
				<p class="three_card_desc">
					문체부와 진흥원에서 정한 소정의
					심사를 거쳐 &lt;창의인재 동반사업&gt;
					운영기관으로 선정되어
					본 사업을 수행하는 기관
				</p>
				<p style="margin-top:15px; padding-left:20px;">
					<spen style="font-size:25px; font-weight:bold; color:#01A9DB;">57</spen> 개
				</p>
			</div>
		</div>
	</div>
	<div style="font-size:13px; color:#A4A4A4; text-align:right; margin-right:52px; margin-bottom:25px;">
		* 2012년 ~ 2018년 누적 기준
	</div>
</div>

<h5 class="border" style="margin-bottom:5px;">
	주요성과 및 사례
</h5>
<!-- <div class="col-12 mentorlineup_header">
	<p class="col-12 sub_title">01.현황</p>
	<div class="col-12 mentorlineup_card_wrap_0">
		<div class="col-12 col-xs-6 col-md-0 fn-md tc mentorlineup_card_con">
			<div class="mentorlineup_card">
				<div class="img_box">
					<img src="/edu/images/bm/mentorlineup_img_000.png" alt="">
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
					<img src="/edu/images/bm/mentorlineup_img_001.png" alt="">
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
					<img src="/edu/images/bm/mentorlineup_img_002.png" alt="">
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
					<img src="/edu/images/bm/mentorlineup_img_003.png" alt="">
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
					<img src="/edu/images/bm/mentorlineup_img_004.png" alt="">
				</div>
				<p class="text_box">
					<span class="sub_title">작품계약 및 데뷔</span>
					153회
				</p>
			</div>
		</div>
	</div>
</div> -->
<!-- <hr class="col-12 mentorlineup_line"> -->
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
		<a href="/edu/dream/mainRsltManage/mainRsltPopList.do?viewType=BODY&amp;year=<c:out value='${yearCode }' />" class="btn_style_0 green radius listBook popUpList">
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
<%-- <div class="col-12 mentorlineup_body_con">
	<p class="col-12 sub_title">02.주요성과</p>
	<c:forEach items="${years}" var="yearNm" varStatus="status">
	<c:forEach var="code" items="${COM087CodeList}" varStatus="status">
		<c:if test="${code.codeNm eq yearNm }">
			<c:set var="yearCode" value="${code.code }"/>
		</c:if>
	</c:forEach>
	<div class="col-12 mentorlineup_body">
		<div class="mentorlineup_card_header">
			<c:out value="${yearNm}"/>년
		</div>

		<div class="center board_util_btn_con only_web_btn" style="margin:30px 0px 15px 0px;">
			<a href="/edu/dream/mainRsltManage/mainRsltPopList.do?viewType=BODY&amp;year=<c:out value='${yearCode }' />" class="btn_style_0 green radius listBook popUpList">
				<c:out value="${yearNm }"/>년 주요성과 리스트
			</a>
		</div>
		<div class="col-12 mentorlineup_card_wrap_1">
			<div class="over-hidden calc_wrap15">
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:if test="${yearNm eq result.yearNm }"> 출력연도와 값을 비교해서 값이 맞으면 출력
				<c:if test="${result.mainExpsrAt eq 'Y' }"> 메인이미지 노출 'Y', 'N' 에따른 출력
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
</div> --%>


<style>
	.linemap_wrap .linemap_con li:nth-child(4) { display:none }
</style>



<%-- <div>

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

	<div class="boxInfos1">
		<p><strong class="fs3">창의인재동반사업</strong>은 <br>
			대한민국 콘텐츠사업의 미래를 이끌어갈 경쟁력 있는 콘텐츠 창작자 육성을 위해<br>
			플랫폼기관의 네트워크와 콘텐츠분야 정상급 전문가(멘토)가  창의교육생(멘티)에게 <strong>프로젝트 중심의 현장 밀착형 멘토링을 지원</strong>하는 사업입니다. </p>
	</div>
	<div class="vdoSet mt10">
		<div class="vdoInfoSets">
			<iframe style="width:100%;height:240px;" src="https://www.youtube.com/embed/cWQM5LSHsMI?wmode=opaque" frameborder="0" allowfullscreen="" title="동영상 재생 프레임"></iframe>
			<!-- width:720, height:435px -->
		</div>
		<div class="fl w100p vodPObj">
			<div class="vodBxSet" style="display: none;">
				<div class="vodBxTxt" tabindex="0">
					<dl>
						<dt>Create NeWave KOCCA!</dt>
						<dt>2015 창의인재 동반사업 발대식</dt>
						<br/>
						<dd>나레이션 : 우리는 알고 있습니다</dd>
						<br/>
						<dd>THE NUT JOB 넛잡</dd>
						<dd>글로벌 흥행수익 120,000,000 달러</dd>
						<dd>ROARING CURRENTS 명량</dd>
						<dd>역대 최다관객 17,614,679 명</dd>
						<dd>PORORO 뽀로로</dd>
						<dd>총 수익 830,000,000,000 원</dd>
						<br/>
						<dd>나레이션 : 세상을 바꿔온 콘텐츠의 힘을 우리는 이미 콘텐츠의 힘을 알고 있습니다.</dd>
						<dd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;창의인재 동반사업은 창작자를 꿈꾸는 젊은 인재들에게 현장 밀착형 도제식 멘토링을</dd>
						<dd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제공하여 콘텐츠 창조문화의 인재를 양성하고 고부가가치 콘텐츠를 창작 할 수 있도록</dd>
						<dd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;지원하는 사업 입니다.</dd>
						<dd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;창의인재 동반사업은 지난 3년간 292명의 멘토와 676명의 멘티가 참여하였으며 </dd>
						<dd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;다양한 분야의 현장에서 총 1,086건의 프로젝트를 수행하여 콘텐츠분야 공모전에서 </dd>
						<dd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;100여건의 수상 및 선정고 120여건의 계약을 상사 시켜 왔습니다.</dd>
						<dd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;또한 세계경쟁력위원회에서 선정 인재주도형 혁신 사례로 뽑히기도 하였습니다.</dd>
						<br/>
						<dt>Create NeWave KOCCA!</dt>
						<dt>2015 창의인재 동반사업 발대식</dt>
						
					</dl>
				</div>
			</div>
			<div class="mb10 tar"> <a href="javascript:void(0);" class="closeVodr" style="display:none;"><img src="/edumobile/images/common/vodDesc_off.gif" alt="자막닫기"></a> <a href="javascript:void(0);" class="OpenVodr"><img src="/edumobile/images/common/vodDesc_on.gif" alt="자막보기"></a> </div>
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
	</div>
	<div class="infoBox clear fl mt20">
		<dl>
			<dt><span class="hidden">세계경쟁력위원회연합 선정 인재육성 우수사례</span></dt>
			<dd class="tac"><img src="/edumobile/images/sub4/040201_04.png" alt="" /><br />
				<span class="fs14">창의인재 멘티</span><br>
				<strong><span class="fs5">676</span> 명</strong></dd>
			<dd class="tac"><img src="/edumobile/images/sub4/040201_05.png" alt="" /><br />
				<span class="fs14">창의인재 멘토</span><br>
				<strong><span class="fs5">292</span> 명</strong></dd>
			<dd class="tac"><img src="/edumobile/images/sub4/040201_06.png" alt="" /><br />
				<span class="fs14">수행프로젝트</span><br>
				<strong><span class="fs5">1,086</span> 명</strong></dd>
		</dl>
	</div>
	<div class="hGroup clear first mb10 t10 pb10">
	<c:forEach items="${years}" var="yearNm" varStatus="status"> 년도로 For문을 돌림 
		<c:forEach var="code" items="${COM087CodeList}" varStatus="status">
			<c:if test="${code.codeNm eq yearNm }">
			<c:set var="yearCode" value="${code.code }"/>
			</c:if>
		</c:forEach>
		<a href="/edumobile/dream/mainRsltManage/mainRsltPopList.do?&amp;menuNo=${param.menuNo }&amp;year=<c:out value='${yearCode }' />" class="btn btn-primary btnBlack icoDown popUpList"><c:out value="${yearNm }"/>년 주요성과 리스트</a>
		<c:remove var="yearCode"/>
	</c:forEach>
	</div>
</div>
<!-- //bdList -->

 --%>