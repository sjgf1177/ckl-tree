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
	<!-- bdView -->
<div class="pl10 pr10">
	<div class="bdView">
		<div class="dlListTable">
			<dl>
				<dt>구분/분류</dt>
				<dd><c:out value="${result.prgSeNm}"/> <c:out value="${empty result.prgClNm ? '' : '/'}"/> <c:out value="${result.prgClNm}"/></dd>
			</dl>
			<dl>
				<dt>프로그램명</dt>
				<dd><c:out value="${result.prgNm}"/></dd>
			</dl>
			<dl>
				<dt>담당부서</dt>
				<dd><c:out value="${result.deptNmKor}"/></dd>
			</dl>
			<dl>
				<dt>신청기간</dt>
				<dd><c:out value="${result.beginDt}"/> ~ <c:out value="${result.rcritComptAt eq 'Y' ? '모집완료시' : result.endDt}"/></dd>
			</dl>
			<dl>
				<dt>신청방식</dt>
				<dd><c:out value="${result.reqstMthdNm}"/> <c:if test="${result.reqstMthd eq '01'}">(<c:out value="${result.psncpa}"/>명)</c:if></dd>
			</dl>
			<dl>
				<dt>교육기간</dt>
				<dd><c:out value="${result.prgBgnde}"/> ~ <c:out value="${result.prgEndde}"/></dd>
			</dl>
			<dl>
				<dt>진행상태</dt>
				<dd>
					<c:choose>
						<c:when test="${progrsSttus eq WAITING}">대기</c:when>
						<c:when test="${progrsSttus eq PROGRESS}">진행</c:when>
						<c:when test="${progrsSttus eq FINISH_PSNCPA}">진행(선착순마감)</c:when>
						<c:when test="${progrsSttus eq FINISH}">마감</c:when>
					</c:choose>
				</dd>
			</dl>
		</div>

		<!-- webediter -->
		<div class="editDB">
			${result.prgCn}
			<!-- 본문이미지 대체텍스트 -->
			<%-- <!-- <div class="hidden">${result.imgDescCn}</div> --> --%>
		</div>
		<!-- //webediter -->


		<div class="box text-danger"><span class="icons icoAlert"></span> 신청 / 접수는 PC 버전에서 가능합니다.</div>

		<div class="mt20 tar">
			<a href="/cklmobile/progrm/master/list.do?${pageQueryString}" class="btn btn-sm btn-trans"><span class="btnIc btnList"></span> 목록보기</a>
		</div>

<%--
		<div class="dlListTable">
			<dl>
				<dt>다음글</dt>
				<dd>세계인이 동참하는 한글 상품 아이디어 공모전이 열린다.</dd>
			</dl>
			<dl>
				<dt>이전글</dt>
				<dd>세계인이 동참하는 한글 상품 아이디어 공모전이 열린다.</dd>
			</dl>
		</div>
 --%>
	</div>
</div>
<!-- //bdView -->