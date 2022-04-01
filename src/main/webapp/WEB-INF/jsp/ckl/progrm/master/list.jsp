<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.ckl.progrm.service.ProgrmMasterService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>
<c:set var="WAITING" value="<%=ProgrmMasterService.Status.WAITING.getValue()%>"/>
<c:set var="PROGRESS" value="<%=ProgrmMasterService.Status.PROGRESS.getValue()%>"/>
<c:set var="FINISH_PSNCPA" value="<%=ProgrmMasterService.Status.FINISH_PSNCPA.getValue()%>"/>
<c:set var="FINISH" value="<%=ProgrmMasterService.Status.FINISH.getValue()%>"/>


<!-- <div>
	<div style="background:url(/edu/images/sub3/ac030101_02.gif) no-repeat 100% 0;">
		<img src="/edu/images/sub3/ac030101_01.gif" alt="빅킬러 콘텐츠를 개발할 수 있는 기술간, 콘텐츠간 융합교육을 위해 필수기술교육, 맞춤 멘토링, 시제품 개발을 위한 프로젝트형 교육과정을 통해 기술기반 창업인재양성을 지원">
		<ul class="bull mt45 ml0">
			<li><strong>교육목적</strong><br />
				콘텐츠 장르간, 기술간 융합 교육을 통해 새로운 융합콘텐츠를 발굴·개발할 수 있는 창작자 양성 및 스타트업 배출</li>
			<li><strong>교육내용</strong><br />
				다양한 프로젝트를 수행할 수 있는 필수기술교육 + 멘토링(프로젝트 맞춤형 기술 및 비즈니스전략 등) + 프로젝트(시제품 개발지원)</li>
			<li><strong>지원자격</strong><br />
				웨어러블, IOT, 가상환경, 아트테크, 로보틱스 등 새롭게 등장한 분야의 융합 콘텐츠 창작에 관심이 많고 기업가 정신을 갖춘 청년 70명 내외</li>
			<li><strong>교육문의</strong><br />
				<div class="dlListTable mt10">
					<dl>
						<dt class="w20p">창의인재양성</dt>
						<dd>김문주 과장<span class="bar"></span><span class="icons ico9"></span> 02-2161-0067 <span class="bar"></span>
							<a href="mailto:gale@kocca.kr" target="_blank" title="담당자에게 메일 보내기(새창열림)"><span class="icons ico10"></span> gale@kocca.kr</a></dd>
					</dl>
					<dl>
						<dt class="w20p">창의인재양성</dt>
						<dd>안정권 사원<span class="bar"></span><span class="icons ico9"></span> 02-2161-0072  <span class="bar"></span> <a href="mailto:gale@kocca.kr" target="_blank" title="담당자에게 메일 보내기(새창열림)"><span class="icons ico10"></span> jkwind22@kocca.kr</a></dd>
					</dl>
				</div>
			</li>
		</ul>
	</div>
</div> -->

<%-- <c:choose>
	<c:when test="${param.prgCl eq '30'}">
		<jsp:include page="/WEB-INF/jsp/ckl/cts/200024.jsp" flush="true"/>
	</c:when>
	<c:when test="${param.prgCl eq '31'}">
		<jsp:include page="/WEB-INF/jsp/ckl/cts/200028.jsp" flush="true"/>
	</c:when>
	<c:when test="${param.prgCl eq '32'}">
		<jsp:include page="/WEB-INF/jsp/ckl/cts/200062.jsp" flush="true"/>
	</c:when>
	<c:when test="${param.prgCl eq '33'}">
		<jsp:include page="/WEB-INF/jsp/ckl/cts/200063.jsp" flush="true"/>
	</c:when>
	<c:when test="${param.prgCl eq '34'}">
		<jsp:include page="/WEB-INF/jsp/ckl/cts/200077.jsp" flush="true"/>
	</c:when>
</c:choose> --%>

<div class="hgroup">
	<h2>관련프로그램</h2>
	<div class="fr">
		<span class="dib mr30"><span class="icons ico21"></span> : 진행중</span>
		<span class="dib mr30"><span class="icons ico22"></span> : 대기</span>
		<span class="dib mr30"><span class="icons ico23"></span> : 마감(대기신청가능)</span>
		<span class="dib"><span class="icons ico24"></span> : 마감</span>
	</div>
</div>

<div class="bdList">
	<table class="table">
		<caption>
			<strong>관련프로그램 목록</strong>
			<detail>
				<summary>프로그램 명,신청방식(정원), 신청기간, 진행상태로 구분되는 표</summary>
			</detail>
		</caption>
		<colgroup>
		<col  />
		<col style="width:18%;" />
		<col style="width:20%;" />
		<col style="width:10%;" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">프로그램 명</th>
				<th scope="col">신청방식(정원)</th>
				<th scope="col">신청기간</th>
				<th scope="col">진행상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td class="tal"><a href="/ckl/progrm/master/view.do?prgSn=<c:out value="${result.prgSn}"/>&amp;${pageQueryString}"><c:out value="${result.prgNm}"/></a></td>
					<td><c:out value="${result.reqstMthdNm}"/></td>
					<td><c:out value="${result.beginDt}"/><br /> <c:out value="${result.rcritComptAt eq 'Y' ? '모집완료시' : result.endDt}"/></td>
					<td>
						<c:choose>
							<c:when test="${result.progrsSttus eq PROGRESS}"><span class="icons ico21"><span class="sr-only">진행</span></span></c:when>
							<c:when test="${result.progrsSttus eq WAITING}"><span class="icons ico22"><span class="sr-only">대기</span></span></c:when>
							<c:when test="${result.progrsSttus eq FINISH_PSNCPA}"><span class="icons ico23"><span class="sr-only">마감(대기신청가능)</span></span></c:when>
							<c:when test="${result.progrsSttus eq FINISH}"><span class="icons ico24"><span class="sr-only">마감</span></span></c:when>
						</c:choose>
					</td>
				</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="4">데이터가 없습니다.</td></tr>
			</c:if>
		</tbody>
	</table>
</div>

<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
</c:if>

