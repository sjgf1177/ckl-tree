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

<!-- bdList -->
<%--
<div class="pl10 pr10">
	<div class="alert alert-info">
		<div class="clearfix">
			<div class="fl">
				<p class="fs4">장르, 플랫폼, 산업 간 융합을 통해 사업화 아이디어를 자유롭게 구현하는<br>
					콘텐츠 예비창업․창작자들의 코워킹(Co-Working) 플랫폼 지향</p>
				<ul class="bull">
					<li>집중지원 프로그램 : 아이디어가 프로토타입으로 구현될 수 있도록 집중 멘토링 및 기획.제작 지원</li>
					<li>커뮤니티 프로그램 : 창작자의 자율적 커뮤니티 조성을 위한 Lab Salon, 네트워크 강화를 위한<br>
						상상캠프 프로그램 운영</li>
					<li>MCN 프로그램 : 1인 크리에이터 및 제작활성화를 위한 콘텐츠산업 트랜드 선도 프로그램</li>
				</ul>
			</div>
			<div class="fr"> <img src="/ckl/images/sub4/200024.jpg" alt="아이디어 융합팩토리 관련 행사사진" /> </div>
		</div>
	</div>
--%>

	<c:choose>
		<c:when test="${param.prgCl eq '30'}">
			<jsp:include page="/WEB-INF/jsp/cklmobile/cts/400019.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '31'}">
			<jsp:include page="/WEB-INF/jsp/cklmobile/cts/400021.jsp" flush="true"/>
		</c:when>
	</c:choose>



	<div class="hgroup">
		<h2>관련프로그램</h2>
	</div>

	<div class="bdList">
		<ul class="tableUl">
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<li><a href="/cklmobile/progrm/master/view.do?prgSn=<c:out value="${result.prgSn}"/>&amp;${pageQueryString}" class="db"><span class="title db"><c:out value="${result.prgNm}"/></span>
				<span class="info1"><span class="date"><c:out value="${result.reqstMthdNm}"/>/<c:out value="${result.beginDt}"/> ~ <c:out value="${result.rcritComptAt eq 'Y' ? '모집완료시' : result.endDt}"/></span></span>
				</a>
			</li>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}" >
			<li>데이터가 없습니다.</li>
		</c:if>
		</ul>
	</div>

<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
</c:if>

</div>
<!-- //bdList -->