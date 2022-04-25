<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.ckl.progrm.service.ProgrmMasterService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>
 
<!-- ﻿<div class="tab_style_1_con">
	<ul class="tab_style_1 two_tab">
		<li class="active"><a href="/edu/main/contents.do?menuNo=500213" title="현재탭"><span>소개</span></a></li>
		<li><a href="/edu/bbs/B0000073/list.do?menuNo=500214"><span>교육과정</span></a></li>
	</ul>
</div> -->

<div class="creator_body_con">
	<div class="creator_body_list">
		<img src="../img/content_impact.JPG" alt="콘텐츠임팩트" style="margin-bottom:25px; width:60%;">
		<p style="font-size:22px; font-weight:bold; margin-bottom:10px;">[콘텐츠 장르별 문화기술 전문인력 양성 사업]</p>
		<p class="h_desc5" style="text-align:left;">
			: 혁신과 융합을 대표하는 국내외 기관, 콘텐츠 기업, 창작자, 개발자와의 협업을 기반으로 선도형 융복합 전문 인재 (크리에이터, 문화기술개발자)를 양성하는 것을 목표로 합니다.<br/>
			협업 프로젝트를 통해 5G, 블록체인, 빅데이터, AR, VR 등 신기술과 콘텐츠를 접목시켜 세상에 없던 새로운 혁신적인 융복합 콘텐츠를 지향하고, 고급 크리에이터 및 문화기술개발자를 발굴·양성하는 한국콘텐츠진흥원의 인재 양성 사업입니다. 

		</p>
		
		<img src="../img/content_impact_bi.gif" alt="콘텐츠임팩트 BI" style="margin-bottom:25px; max-width:400px;">
		<p style="font-size:20px; font-weight:bold; margin-bottom:10px;">[콘텐츠임팩트]</p>
		<p class="h_desc5" style="text-align:left;">
			콘텐츠임팩트는 콘텐츠 장르별 문화기술 전문인력 양성 사업의 BI입니다.<br/>
			국내외 유수의 혁신 기관과 기업, 예술가, 개발자 등 다양한 주체들이 협력하여 사회 전반에 긍정적 혁신을 도모하는 과제를 설정하고, 그 실천의 결과물로 나온 콘텐츠가 중심이 되는 <b>콘텐츠 임팩트(Content Impact)</b><br/> 
			임팩트 있는 콘텐츠(Impact Content)가 진정한 <b>콘텐츠 임팩트(Content Impact)</b>입니다.<br/> 
			Content Impact : Impact Content <b>CIIC</b>
		</p>
		<p style="font-size:20px; font-weight:bold; margin-bottom:10px;">[운영내용]</p>
		<table class="content_impact_table">
			<colgroup>
				<col width="10%">
				<col width="30%">
				<col width="30%">
				<col width="30%">
			</colgroup>
			<tr>
				<td></td>
				<td><img src="../img/content_impact_content_icon.jpg" alt="콘텐츠임팩트 아이콘_과정"></td>
				<td><img src="../img/content_impact_project_icon.jpg" alt="콘텐츠임팩트 아이콘_프로젝트"></td>
				<td><img src="../img/content_impact_goal_icon.jpg" alt="콘텐츠임팩트 아이콘_수료인원"></td>
			</tr>
			<tr>
				<td>2021년</td>
				<td><span>5개</span>과정</td>
				<td><span>37개</span>프로젝트</td>
				<td><span>193명</span>수료</td>
			</tr>
			<tr>
				<td>2020년</td>
				<td><span>6개</span>과정</td>
				<td><span>40개</span>프로젝트</td>
				<td><span>211명</span>수료</td>
			</tr>
		</table>
		<p style="font-size:20px; font-weight:bold; margin-bottom:10px;">[콘텐츠임팩트 하이라이트]</p>
		<video poster="/upload/dream/content_impact_highlight.png" width="100%" height="auto" oncontextmenu="return false;" controls="true" controlslist="nodownload">
			<source src="/upload/dream/content_impact_highlight.mp4" type="video/mp4">
		</video>
		<div class="edu_youtube_subtitle_view_btn_con">
			<button class="edu_youtube_subtitle_view_btn caption_btn" onclick="showCaption();"><span class="edu_view_default" style="color:white">자막보기</span><span class="edu_view_active">자막닫기</span></button>
			<div class="edu_youtube_subtitle_view_text" tabindex="0">
				인공지능, 감성인식 등 첨단문화기술과 콘텐츠의 혁신적인 만남</br>
상상을 현실로 만들기 위해 한계에 도전하는 곳</br>
콘텐츠임팩트는 미래세상을 열어갈 융복합 인재를 키웁니다. </br>
</br>
4차산업혁명시대를 이끌어갈 핵심인재를 양성하기 위해 </br>
한국콘텐츠진흥원이 2018년부터 운영하고 있는 콘텐츠임팩트 </br>
</br>
창의와 혁신을 대표하는 국내외 대학, 콘텐츠기업, 창제작자 및 개발자와의 협업을 기반으로 </br>
지식과 경험을 넓히고 새로운 가능성을 실험하는 프로젝트 중심의 실습교육이 이루어집니다. </br>
올해는 특히 팀별 전담 멘토인 퍼실리테이터를 배정해 교육완성도를 높이고 있습니다. </br>
</br>
(인터뷰: 박제성 교수)</br>
저는 참여한 교육생들의 에너지와 열정이 굉장히 놀라웠구요.</br>
짧은 기간에 멋진 프로젝트들을 성공시키기 위해 굉장히 노력하고 발전해나아가는 모습이 인상적이었고 큰 보람이었습니다. </br>
</br>
1과정 인공지능x스토리 AI:Storyteller</br>
AI가 시를 쓰는 스토리텔링과 인공지능의 결합 방대한 데이터를 기반으로 분석과 학습이 가능한 인공지능 기술을 스토리 창작에 활용하다.</br>
사람과 인공지능의 협력 알고리즘을 만들어갑니다. </br>
</br>
2과정 과학기술x미디어아트 다빈치 프로젝트 </br>
예술과 기술의 만남 아트앤테크놀로지 </br>
첨단과학기술과 미디어아트의 결합은 예술적 감수성에 기술적 상상력을 더해 표현의 장벽을 넘어 미학적 항해의 지평을 넓혀줍니다. </br>
</br>
(인터뷰: 윤정원 교육생) </br>
가장 좋은 점은 저희가 처음에 옛날에는 생각하지 못했던 부분에 대해서 조금더 정밀하게 검증하고 검토하는 단계가 추가가 돼서 </br>
기존의 작품을 만들 때 생각하지 못했던 부분에 대해 많은 피드백이 있었던것 같고, 두번째는 교수님과 같이 멘토 퍼실리테이터분과 같이 진행을 하다보니까 </br>
교수님의 연구실에서 좀 더 배우는 부분이 있고 교수님이 더 상세하게 피드백을 적극적으로 수용하면서 더 콘텐츠를 발전시킬 수 있었던 것 같습니다. </br>
</br>
3과정 감성인식x인터랙티브콘텐츠 콘텐츠, 공감하다 </br>
감성인식 기술로 인간과 공감하는 콘텐츠는 미래가 현재에게 보내는 메세지입니다.</br>
뇌파나 심전도 등 생체신호와 음성안면인식 기술 등을 활용하면 가상현실에서의 심리치료처럼 인간의 감성과 상호작용하는 콘텐츠 개발이 가능해집니다. </br>
</br>
4과정 음악x인공지능 Music Meets AI </br>
인공지능과 뮤지션의 협업. 노랫말을 쓰고 멜로디를 붙이는 단계를 넘어 </br>
이제 인공지능은 사라진 우리 전통가락을 되살리고 아티스트의 창작을 지원하는 데이터 생성과 협업을 위한 피처링 추천에 이르기까지 음악산업의 다양한 가능성을 제시합니다.</br> 
</br>
5과정 5GxVR 5G 실감형 콘텐츠랩</br>
VR, AR 등 가상현실기술을 이용한 실감콘텐츠는 5G기술기반 고부가가치 산업의 핵심입니다.</br>
인기아이돌의 뮤직비디오를 360도 3D 영상으로 즐길 수 있는 버추얼 플레이 기술</br>
오감을 자극하는 확장현실기반 1인칭 슛팅게임 등 실제감을 극대화 시킨 콘텐츠로 5G 생태계를 열어갑니다. </br>
</br>
6과정 공연기술X라이브퍼포먼스 Future on the Stage</br>
첨단 무대기술과 공연예술의 만남</br>
XR기술로 생성된 가상세트와 실시간 라이브 공연의 콜라보 </br>
공간의 제한과 상상력의 한계를 뛰어넘는 프로젝션 맵핑으로 온라인으로 연결된 글로벌 팬덤을 열광시킬 미래형 랜선공연을 선사합니다. </br>
</br>
신기술은 콘텐츠를 진화하게 만들고</br>
새로워진 콘텐츠는 기술을 더 성장시킵니다. </br>
대한민국 차세대 콘텐츠 산업을 변화시킬 창의와 혁신!</br>
콘텐츠임팩트가 만들어 갑니다.
			</div>
		</div>
	</div>
</div>

<%-- <c:if test="${userVO.userId eq 'sjsjgg' || userVO.userId eq 'nicemingun' || userVO.userId eq 'gosomi' || userVO.userId eq 'lotus1212' || userVO.userId eq 'kimsj5927'}"> --%>
<div class="col-12 contents_card_list">
	<div class="over-hidden calc_wrap19">
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:set value="${fileMap[result.atchFileId] }" var="fileList" />
			<c:forEach var="files" items="${fileList }">
				<c:if test="${files.fileFieldName eq 'mainImg' }">
					<c:set  var="file" value="${files }"/>
				</c:if>
			</c:forEach>
			<div class="col-12 col-md-6 contents_card_con">
				<c:choose>
					<c:when test="${param.prgCl eq '19'}">
						<a href="/edu/progrm/applcnt/reg01.do?prgSn=<c:out value="${result.prgSn}"/>&amp;${pageQueryString}" class="contents_crad_wrap">
					</c:when>
					<c:otherwise>
						<a href="/edu/progrm/master/view.do?prgSn=<c:out value="${result.prgSn}"/>&amp;${pageQueryString}" class="contents_crad_wrap">
					</c:otherwise>
				</c:choose>
			
				<c:choose>
					<c:when test="${result.prgCl eq 17 }">
						<div style="display: inline-block; vertical-align:middle; margin-right:10px; width:90px; height:120px; line-height:120px;">
							<c:if test="${not empty file }">
								<img src='/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}'  style="width: 100%;height: auto;"  alt="${result.prgNm}"  />
							</c:if>
						</div>
						<div class="contents_text_wrap" style="">
							<h6>
								<c:out value="${result.prgNm}"/>
							</h6>
							<ul>
								<li><span>일정</span> : <c:out value="${result.beginDt}"/></li>
							</ul>
						</div>
					</c:when>
					<c:otherwise>
						<div class="contents_circle_wrap">
							<c:choose>
								<c:when test="${result.progrsSttus eq 'W'}">
									<div class="contents_circle deadline">
										<p>대기</p>
									</div>
								</c:when>
								<c:when test="${result.progrsSttus eq 'P'}">
									<div class="contents_circle">
										<p>진행</p>
									</div>
								</c:when>
								<c:when test="${result.progrsSttus eq 'FP'}">
									<div class="contents_circle">
										<p>진행</p>
									</div>
								</c:when>
								<c:when test="${result.progrsSttus eq 'F'}">
									<div class="contents_circle deadline">
										<p>마감</p>
									</div>
								</c:when>
							</c:choose>
						</div>
						<div class="contents_text_wrap">
							<h6>
								<c:out value="${result.prgNm}"/>
							</h6>
							<ul>
								<li><span>신청방식</span> : <c:out value="${result.reqstMthdNm}"/></li>
								<li><span>신청기간</span> : <c:out value="${result.beginDt}"/> ~ <c:out value="${result.rcritComptAt eq 'Y' ? '모집완료시' : result.endDt}"/></li>
							</ul>
						</div>
					</c:otherwise>
				</c:choose>
			</a>
		</div>
		<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
	</div>
</div>

<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
</c:if>
<%-- </c:if> --%>
<style>
	.content_impact_table{width:100%; margin-bottom:79px}
	.content_impact_table tr:not(:first-child){height:50px; line-height:50px;}
	.content_impact_table tr:last-child{border-top:2px #ededed dashed;}
	.content_impact_table tr td{text-align:center;}
	.content_impact_table tr td img{width:70px}
	.content_impact_table tr td span{font-size:20px; color:#2e75b6; font-weight:bold; margin-right:10px;}
	.edu_youtube_subtitle_view_btn_con{text-align: right; margin-bottom: 40px;}
	.edu_youtube_subtitle_view_btn_con .edu_youtube_subtitle_view_btn{font-size:14px; font-size:1.4rem; line-height:20px; line-height:2.0rem; color:#fff; display:inline-block; border-radius:1px; cursor: pointer;
	    text-align: left; padding-right:41px; padding-left:12px; padding-top:9px; padding-bottom:8px; background-image:url('/edu/images/bm/edu_yotubue_subtitle_view.png'); background-repeat: no-repeat; background-position: right 12px center; background-color: #1da28d; box-sizing: border-box;}
	.edu_youtube_subtitle_view_btn_con .edu_youtube_subtitle_view_btn .edu_view_default{display:inline-block;}
	.edu_youtube_subtitle_view_btn_con .edu_youtube_subtitle_view_btn .edu_view_active{display:none;}
	.edu_youtube_subtitle_view_btn_con .edu_youtube_subtitle_view_btn .edu_view_close_btn{display:none; float:right; width:17px; height:17px; background-image: url('/edu/images/bm/edu_yotubue_subtitle_close.png');}
	.edu_youtube_subtitle_view_btn_con.active .edu_youtube_subtitle_view_btn{overflow:hidden; display:block; width:100%; padding-left:25px; background-image:none; padding-right:25px;}
	.edu_youtube_subtitle_view_btn_con.active .edu_youtube_subtitle_view_btn .edu_view_default{display:none;}
	.edu_youtube_subtitle_view_btn_con.active .edu_youtube_subtitle_view_btn .edu_view_active{display:inline-block;}
	.edu_youtube_subtitle_view_btn_con.active .edu_youtube_subtitle_view_btn .edu_view_close_btn{display:inline-block; }
	.edu_youtube_subtitle_view_btn_con .edu_youtube_subtitle_view_text{font-size: 14.5px; font-size: 1.45rem; line-height: 26px; line-height: 2.6rem; color: #999999; letter-spacing: -0.025em;
	    padding-top:20px; padding-left:25px; padding-right:25px; padding-bottom:20px; border:2px solid #5ac9b7; text-align: left; display:none; max-height:300px; overflow-y: auto;}
	.edu_youtube_subtitle_view_btn_con.active .edu_youtube_subtitle_view_text{display:block;}
</style>
