
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>


	<div class="fontsize0 sub_contents_body">
	<div class="col-12 program_list">
	<p class="sub_title">
	VR / 코딩 / 공연 / IOT / 메이커 분야에 관심이 있으신가요?
	</p>
	<ul class="sub_desc">
	<li>
	한국콘텐츠진흥원의 새로운 교육 플랫폼 콘텐츠인재캠퍼스의 <span>콘텐츠창작자 중심</span>의 기술교육 프로그램!
	</li>
	<li>
	<span>실무 전문가들이 직접 지도</span>를 받으며 최신 영상/음향/시제품제작 장비들을 운용해 보는 엄청난 기회!
	</li>
	<li>
	콘텐츠에 기술을 적용하고 싶거나 <span>관련된 분야의 네트워킹을 확장</span>할 수 있는 좋은 기회가 여러분을 기다립니다.
	</li>
	</ul>
	<div class="img_box">
	<img src="/edu/images/bm/program_img_002.jpg" alt="프로그램구성 이미지">
	</div>
	</div>
	<div class="col-12 program_list borad">
	<div class="col-12 program_list sub_board_header program">
	<ul class="list_style_2 program">
	<li>
	<p class="sub_title">접수시간</p>
	<p class="sub_text">2017.06.08 ~ 06.26</p>
	</li>
	<li>
	<p class="sub_title">교육기간</p>
	<p class="sub_text">2017.7월 ~ 12월</p>
	</li>
	<li>
	<p class="sub_title">교육장소</p>
	<p class="sub_text">콘텐츠인재캠퍼스 <br>(서울 동대문구 회기로 66)</p>
	</li>
	<li>
	<p class="sub_title">콘텐츠테크랩 교육참가자 모집</p>
	<p class="sub_text">사업설명회</p>
	<p class="sub_text"><span class="sub_text_title">일시</span> : 2017.06.20</p>
	<p class="sub_text"><span class="sub_text_title">장소</span> : 콘텐츠인재캠퍼스 대강의실</p>
	</li>
	</ul>
	</div>
	<h5 class="col-12">
	테크랩 공지사항
	</h5>
	<!--공지사항-->
	<!-- bdList -->
	<div class="col-12 show-table sub_board_header control_board_header">
		<div class="col-5 show-tablecell fn vm board_title">
		<h4>총 <span class="board_count"><c:out value="${resultCnt }" />개</span>의 게시글 등록</h4>
		</div>
		<div class="col-7 show-tablecell fn vm tr board_sorting_con">
		<form action="/<c:out value="${paramVO.siteName }"/>/bbs/${paramVO.bbsId}/list.do" class="form-inline" method="post">
		<input type="hidden" name="menuNo" value="${param.menuNo }" >
		<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
		<input type="hidden" name="pageQueryString" value="<c:out value='${pageQueryString}'  escapeXml='false'/>" />
		<span class="tl select_box">
		<select name="board_sorting" id="board_sort" class="select_style_0" title="구분을 선택해 주세요">
		<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if>>제목</option>
		<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if>>내용</option>
		</select>
		<!-- <label for="board_sort"></label> -->
		</span>
		<span class="tl input_search_con">
		<input type="text" class="board_search" name="searchWrd" id="searchWrd" title="검색어를 입력해 주세요." placeholder="검색어 입력" value="${paramVO.searchWrd }" />
		<input type="submit" id="input2" name="input2" value="" class="search_summit btn-primary" title="검색" />
		</span>
		<c:if test="${not empty paramVO.searchWrd }">
			<a href="/edu/bbs/<c:out value="${paramVO.bbsId}" />/list.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm ml10">전체목록</a>
		</c:if>
		</form>
		</div>
	</div>

	<table class="board_type_0">
		<caption><c:out value="${masterVO.bbsNm}" /> 목록</caption>
		<colgroup>
		<col width="auto" class="count_column">
		<col width="auto">
		<col width="auto" class="write_date_column">
		<col width="90px">
		</colgroup>
		<thead>
		<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성일</th>
		<th>조회</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
			<td><c:out value="${(resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}" /></td>
			<td>
			<c:url var="url" value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&amp;${pageQueryString}" />
			<a href="<c:out value='${url}' escapeXml='false'/>">
			<c:out value='${result.nttSj}' />
			</a>
			</td>
			<td>${result.frstRegisterPnttm}</td>
			<td>${result.inqireCo}</td>
			</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="4">데이터가 없습니다.</td></tr></c:if>
		</tbody>
	</table>

	<!-- paging -->
	<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">${pageNav}</div>
		<!-- paging end //-->
	</c:if>
	<!-- //paging -->

	<sec:authorize ifAnyGranted="ROLE_USER">
		<c:if test="${userVO.mentoYn eq 'Y' }">
			<div class="board_util_btn_con">
			<a href="/edu/bbs/${paramVO.bbsId}/forInsert.do?${pageQueryString}" class="btn_style_0 full add btn-primary">글쓰기</a>
			</div>
		</c:if>
	</sec:authorize>
	<!--//공지사항-->
	</div>
	<div class="col-12 program_list">
	<h5>
	테크랩 소개
	</h5>
	<div class="col-12 tab_style_1_con">
	<ul class="tab_style_1 inner_tab">
	<li class="active"><span>프로그램 구성</span></li>
	<li><span>테크랩 랩마스터 소개</span></li>
	</ul>
	</div>

	<!-- 프로그램구성 -->
	<div class="tab_contents program active">
	<div class="col-12 program_table">
	<p class="table_caption">5개 분야 10개 과정</p>
	<table class="table_style_1">
	<caption>프로그램 구성페이지</caption>
	<colgroup>
	<col width="12%">
	<col width="33%">
	<col width="auto">
	</colgroup>
	<thead>
	<tr>
	<th>분야</th>
	<th>과정</th>
	<th>교육내용</th>
	</tr>
	</thead>
	<tbody>
	<tr>
	<td rowspan="2">VR</td>
	<td>VR 무비랩</td>
	<td>VR 촬영/편집 기술과 새로운 스토리텔링 영화 생산</td>
	</tr>
	<tr>
	<td>VR 콘텐츠랩</td>
	<td>VR기반 웹드라마, 예능, MCN 등 콘텐츠중심의 VR영상 제작</td>
	</tr>
	<tr>
	<td rowspan="2">공연</td>
	<td>랩탑오케스트라랩</td>
	<td>라이브코딩을 활용하여 융복합 공연제작</td>
	</tr>
	<tr>
	<td>뉴미디어 공연랩</td>
	<td>뉴미디어 테크놀로지를 활용한 공연기획</td>
	</tr>
	<tr>
	<td rowspan="2">공연</td>
	<td>콘텐츠코딩랩</td>
	<td>콘텐츠분야에 적용할 수 있는 기초 프로그래밍 교육</td>
	</tr>
	<tr>
	<td>인터랙티브코딩랩</td>
	<td>센서를 활용한 인터렉티브 콘텐츠를 제작 코딩교육</td>
	</tr>
	<tr>
	<td rowspan="2">메이커</td>
	<td>오토마타스토리북랩</td>
	<td>자동인형장치로 움직이는 동화책 만들기</td>
	</tr>
	<tr>
	<td>라이프디자인랩</td>
	<td>아이디어에 기술과 디자인을 응용하여 일상을 개선하는 제품제작</td>
	</tr>
	<tr>
	<td rowspan="2">오픈소스</td>
	<td>드론챌린지랩</td>
	<td>드론제작 및 드론활용 콘텐츠 기획 교육</td>
	</tr>
	<tr>
	<td>IOT랩</td>
	<td>아두이노와 라즈베리파이를 활용, 아이디어 시제품 제작</td>
	</tr>
	</tbody>
	</table>
	</div>
	</div>
	<!--// 프로그램구성 -->

	<!-- 테크랩마스터 소개-->
	<div class="tab_contents">
	<div class="col-12 aboutTechLabMaster_list_wrap">
	<div class="col-12 calc_wrap15">
	<div class="col-12 tc aboutTechLabMaster_list">
	<div class="col-12 show fn aboutTechLabMaster_card">
	<div class="img_box">
	<img src="/edu/images/bm/aboutTechLabMaster_img_000.jpg" alt="콘텐츠테크랩 랩마스터 김태은">
	</div>
	<div class="text_box">
	<h5>
	김태은
	<span>VR무비랩</span>
	</h5>
	<hr class="h_line5">
	<p class="h_desc5">
	<span>
	VR 스토리텔링의 시각화, VR카메라 작동기법,<br>
	스티칭 과정(편집), CG합성과 영상의 최종 마스터링 과정
	</span>
	CF, 뮤직비디오, 장,단편 영화 감독으로 2 0년 넘게 활동하고 있으며 최근에는 VR로 그 영역을 확장하고 있다.
	2015년 VR콘텐츠인 &lt;조선일렉트로닉스&gt;로 한국콘텐츠진흥원과 문화창조융합센터에서 전시하였다.
	</p>
	</div>
	</div>
	</div>
	<div class="col-12 tc aboutTechLabMaster_list">
	<div class="col-12 show fn aboutTechLabMaster_card">
	<div class="img_box">
	<img src="/edu/images/bm/aboutTechLabMaster_img_006.jpg" alt="콘텐츠테크랩 랩마스터 이태현">
	</div>
	<div class="text_box">
	<h5>
	이태현
	<span>VR콘텐츠</span>
	</h5>
	<hr class="h_line5">
	<p class="h_desc5">
	<span>
	기술중심이 아닌 콘텐츠 중심의 VR프로젝트<br>
	생산을 위해 다양한 프로젝트 실험
	</span>
	댄스, 스포츠, 뮤직비디오, 웹드라마, 관광등 다양한 장르의 VR콘텐츠를 100편 이상 제작한 경험을
	가지고 있으며 현재 구독자 10만명, 누적조회수 4천만의 유튜브 채널을 운영하고 있다.
	</p>
	</div>
	</div>
	</div>
	<div class="col-12 tc aboutTechLabMaster_list">
	<div class="col-12 show fn aboutTechLabMaster_card">
	<div class="img_box">
	<img src="/edu/images/bm/aboutTechLabMaster_img_008.jpg" alt="콘텐츠테크랩 랩마스터 박성민">
	</div>
	<div class="text_box">
	<h5>
	박성민
	<span>랩탑오케스트라랩</span>
	</h5>
	<hr class="h_line5">
	<p class="h_desc5">
	<span>
	SonicPI와 SuperCollider 교육 및 실습을 통해 프로그래밍을 이용한 사운드/멀티미디어
	제작 기술을 이해하고 새로운 창작기법 / 퍼포먼스 방법론 등을 연구
	</span>
	실용음악을 전공하고 코딩을 독학으로 공부한 독특한 이력으로 현재 아시아문화중심도시 레지던시에 입주중이다. 국내에는 다소 생소한 라이브코딩을
	선도적으로 시작하여 LG IFA Show 2015, 젠틀몬스터 등에서 공연했다.
	</p>
	</div>
	</div>
	</div>
	<div class="col-12 tc aboutTechLabMaster_list">
	<div class="col-12 show fn aboutTechLabMaster_card">
	<div class="img_box">
	<img src="/edu/images/bm/aboutTechLabMaster_img_001.jpg" alt="콘텐츠테크랩 랩마스터 장승주">
	</div>
	<div class="text_box">
	<h5>
	장승주
	<span>뉴미디어 공연랩</span>
	</h5>
	<hr class="h_line5">
	<p class="h_desc5">
	<span>
	2,3D 영상 및 제너레이티브 사운드 제작과 프로젝션 맵핑
	</span>
	2016 현대카드 컬쳐프로젝트 젊은 건축가 파이널리스트와 2016 SIGGRAPH 인터렉티브 키네틱아트부분 수상한 실력파 SM, 아디다스와 같은 커머셜
	프로젝트부터 서울 문화역 284 같은 예술전시 그리고 클럽 옥타곤까지 장르를 구분하지 않고 기술기반 콘텐츠를 창작하고 있다.
	</p>
	</div>
	</div>
	</div>
	<div class="col-12 tc aboutTechLabMaster_list">
	<div class="col-12 show fn aboutTechLabMaster_card">
	<div class="img_box">
	<img src="/edu/images/bm/aboutTechLabMaster_img_005.jpg" alt="콘텐츠테크랩 랩마스터 신믿음">
	</div>
	<div class="text_box">
	<h5>
	신믿음
	<span>콘텐츠코딩랩</span>
	</h5>
	<hr class="h_line5">
	<p class="h_desc5">
	<span>
	유니티 및 피지컬컴퓨팅 기초
	</span>
	홍익대학교 영상대학원 인터렉션디자인 겸임교수이며 디자이너로 출발하여 AR특허를 갖고 있는 기술기반창작 전문가이다. 10여개가 넘는 대학에서
	콘텐츠제작 코딩수업을 진행하였고 PATI의 주요 멤버로 활약하기도 했다.
	</p>
	</div>
	</div>
	</div>
	<div class="col-12 tc aboutTechLabMaster_list">
	<div class="col-12 show fn aboutTechLabMaster_card">
	<div class="img_box">
	<img src="/edu/images/bm/aboutTechLabMaster_img_002.jpg" alt="콘텐츠테크랩 랩마스터 이재중">
	</div>
	<div class="text_box">
	<h5>
	이재중
	<span>인터렉티브코딩랩</span>
	</h5>
	<hr class="h_line5">
	<p class="h_desc5">
	<span>
	프로세싱과 키넥트를 기본으로 한 인터렉티브 코딩
	</span>
	LG CES 2017, 삼성QM3 캠페인, 네파 등의 인터렉티브 마케팅 콘텐츠를 만든 모온컴퍼니의 이사이다. 비주얼 코딩프로그램 프로세싱의 국내 최고
	전문가로 꼽힌다.
	</p>
	</div>
	</div>
	</div>
	<div class="col-12 tc aboutTechLabMaster_list">
	<div class="col-12 show fn aboutTechLabMaster_card">
	<div class="img_box">
	<img src="/edu/images/bm/aboutTechLabMaster_img_009.jpg" alt="콘텐츠테크랩 랩마스터 정민정">
	</div>
	<div class="text_box">
	<h5>
	정민정
	<span>오토마타 스토리북랩</span>
	</h5>
	<hr class="h_line5">
	<p class="h_desc5">
	<span>
	오토마타 기계장치와 작동원리
	</span>
	국내에서 손꼽히는 오토마타 제작자로 과학창의재단에서 주최한 2016 메이커페스티벌 오토마타 특별전과 다수의 관련 전시에 참여하였다.
	</p>
	</div>
	</div>
	</div>
	<div class="col-12 tc aboutTechLabMaster_list">
	<div class="col-12 show fn aboutTechLabMaster_card">
	<div class="img_box">
	<img src="/edu/images/bm/aboutTechLabMaster_img_003.jpg" alt="콘텐츠테크랩 랩마스터 장영진">
	</div>
	<div class="text_box">
	<h5>
	장영진
	<span>라이프 디자인</span>
	</h5>
	<hr class="h_line5">
	<p class="h_desc5">
	<span>
	참여자 개개인의 아이디어와 배경지식을 살려 일상생활에 도움이 될 수 있는 가젯 제작
	</span>
	2011년 음성을 인식하여 그림을 그리는 로봇 작품 제작을 시작으로 2013년 디지털 일력 Tear A day, 2014년 물 절약 라디오 Wet Music,
	2015년 iot 무드조명 Lumicandle, 2016년 빛나는 샌드백 LighthingBag 등 다양한 메이커 프로젝트를 진행하였다.
	2015년부터 전북콘텐츠코리아랩의 창작멘토로 활동하고 있으며, 하드웨어 창작자를 지원하는 디자인 스튜디오 영랩을 운영하고 있으며
	10여팀 이상의 창작팀에 대한 창작 교육 및 지원사업을 진행해 오고있다.
	</p>
	</div>
	</div>
	</div>
	<div class="col-12 tc aboutTechLabMaster_list">
	<div class="col-12 show fn aboutTechLabMaster_card">
	<div class="img_box">
	<img src="/edu/images/bm/aboutTechLabMaster_img_007.jpg" alt="콘텐츠테크랩 랩마스터 문참근">
	</div>
	<div class="text_box">
	<h5>
	문창근
	<span>드론챌린지랩</span>
	</h5>
	<hr class="h_line5">
	<p class="h_desc5">
	<span>
	멀티로터형 무인 항공기 제작에 필수적인 제어, 항법 모듈에 대한 기본적인 이해와 제작 실습을 통하여 쿼드로터형 무인 항공기를
	직접 제작하며 드론을 비롯한 스마트 운행체의 완전 자율주행 솔루션 제작
	</span>
	열다섯 살인 2002년부터 직접 드론을 제작했다. 2014년 영국에서 투자금을 유치해 국내 및 국제특허(PCT)를 출원했으며 현재 국내 산업용 드론 제작과 기술
	전파에 앞장서고 있다. 드론 생태계에 다양한 Third Party 업체들의 참여를 유도할 수 있는 Android와 같은 개방형 소프트웨어 플랫폼을 구축하고 있다.
	</p>
	</div>
	</div>
	</div>
	<div class="col-12 tc aboutTechLabMaster_list">
	<div class="col-12 show fn aboutTechLabMaster_card">
	<div class="img_box">
	<img src="/edu/images/bm/aboutTechLabMaster_img_004.jpg" alt="콘텐츠테크랩 랩마스터 최은희">
	</div>
	<div class="text_box">
	<h5>
	최은희
	<span>IoT랩</span>
	</h5>
	<hr class="h_line5">
	<p class="h_desc5">
	<span>
	아두이노, 라즈베리파이, 레이저커딩, 3D프린터, CNC등을 이용하여 하드웨어 Mock-up부터 코딩까지 One-Stop으로 교육
	</span>
	다수의 전기자동차, 드론 해커톤 및 시제품 제작 해커톤 운영 총괄을 맡은 이력이 있다. 2015년 경기창조혁신센터에서 IOT랩장을 맡았으며
	다수의 메이커 행사를 기획했다. DIY 세그웨이, bb8 등 아두이노를 활용하여 다양한 프로젝트를 진행하였다. 현재는 코딩 초심자들을 위하여
	'Making Coding'이라는 컨셉을 가지고 다양한 교육을 진행 중이다.
	</p>
	</div>
	</div>
	</div>
	</div>
	</div>
	</div>
	<!--// 테크랩마스터 소개-->
	</div>

	</div>


<!--content-->


