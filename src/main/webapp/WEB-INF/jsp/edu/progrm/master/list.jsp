<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.ckl.progrm.service.ProgrmMasterService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>


<!-- ========== 잡페어 =========== -->
<c:if test="${param.prgSe eq '06'}">
	
	<c:choose>
		<c:when test="${param.prgCl eq '61'}"> <!-- 구직자 사전등록 테스트 -->
			<jsp:include page="/WEB-INF/jsp/edu/cts/500135.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '60'}"> <!-- 참여기업 입사지원 테스트 -->
			<jsp:include page="/WEB-INF/jsp/edu/cts/500134.jsp" flush="true"/>
		</c:when>
	</c:choose>
</c:if>
<!-- ========== // 잡페어 =========== -->

<!-- ========== 오프라인교육 && 취업지원프로그램 =========== -->
<c:if test="${param.prgSe eq '01' || param.prgSe eq '02'}">
	<c:choose>
		<c:when test="${param.prgCl eq '10'}"><!-- 콘텐츠 플러스 -->
			<jsp:include page="/WEB-INF/jsp/edu/cts/500022.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '15'}"><!-- 콘텐츠 밸류업 -->
			<jsp:include page="/WEB-INF/jsp/edu/cts/500023.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '12'}"><!-- 콘텐츠 스텝업  -->
			<jsp:include page="/WEB-INF/jsp/edu/cts/500024.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '13'}"><!-- 콘텐츠 인사이트 -->
			<jsp:include page="/WEB-INF/jsp/edu/cts/500025.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '16'}"><!-- 게임인재원 -->
			<jsp:include page="/WEB-INF/jsp/edu/cts/500165.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '14'}"><!--게임리퍼러시교육-->
			<jsp:include page="/WEB-INF/jsp/edu/cts/500127.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '17'}"><!--콘텐츠원캠퍼스 오픈특강-->
			<jsp:include page="/WEB-INF/jsp/edu/cts/500187.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '18'}"><!--콘텐츠 와이드-->
			<jsp:include page="/WEB-INF/jsp/edu/cts/500195.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '19'}"><!--멘티신청접수-->
			<jsp:include page="/WEB-INF/jsp/edu/cts/500197.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '20'}">
			<jsp:include page="/WEB-INF/jsp/edu/cts/500049.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '70'}">
			<jsp:include page="/WEB-INF/jsp/edu/cts/500198.jsp" flush="true"/>
		</c:when>
	</c:choose>
	
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

</c:if>
<!-- ========== //오프라인교육 =========== -->
 