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


<!-- ========== 잡페어 =========== -->
<c:if test="${param.prgSe eq '06'}">
	
	<c:choose>
		<c:when test="${param.prgCl eq '61'}"> <!-- 구직자 사전등록 테스트 -->
			<jsp:include page="/WEB-INF/jsp/edumobile/cts/500135.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '60'}"> <!-- 참여기업 입사지원 테스트 -->
			<jsp:include page="/WEB-INF/jsp/edumobile/cts/500134.jsp" flush="true"/>
		</c:when>
	</c:choose>
</c:if>
<!-- ========== // 잡페어 =========== -->

<!-- ========== 오프라인교육 && 취업지원프로그램 =========== edumobile -->
<c:if test="${param.prgSe eq '01' || param.prgSe eq '02'}">
	<c:choose>
		<c:when test="${param.prgCl eq '10'}">
			<jsp:include page="/WEB-INF/jsp/edu/cts/500022.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '15'}"><!-- 콘텐츠 밸류업 -->
			<jsp:include page="/WEB-INF/jsp/edu/cts/500023.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '12'}">
			<jsp:include page="/WEB-INF/jsp/edu/cts/500024.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '13'}">
			<jsp:include page="/WEB-INF/jsp/edu/cts/500025.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '14'}"><!--게임리퍼러시교육-->
			<jsp:include page="/WEB-INF/jsp/edu/cts/500127.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '16'}"><!-- 콘텐츠 와이드 -->
			<jsp:include page="/WEB-INF/jsp/edu/cts/500165.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '17'}"><!--콘텐츠원캠퍼스 오픈특강-->
			<jsp:include page="/WEB-INF/jsp/edu/cts/500187.jsp" flush="true"/>
		</c:when>
		<c:when test="${param.prgCl eq '20'}">
			<jsp:include page="/WEB-INF/jsp/edu/cts/500049.jsp" flush="true"/>
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
				<a href="/edu/progrm/master/view.do?prgSn=<c:out value="${result.prgSn}"/>&amp;${pageQueryString}" class="contents_crad_wrap">
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
									<li><span>신청방식</span> : <c:out value="${result.reqstMthdNm}"/></li>
									<li><span>신청기간</span> : <c:out value="${result.beginDt}"/> ~ <c:out value="${result.rcritComptAt eq 'Y' ? '모집완료시' : result.endDt}"/></li>
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
			<c:if test="${fn:length(resultList) == 0}" >
				<div class="col-12 col-md-6 contents_card_con">
					<a href="/edumobile/progrm/master/view.do?prgSn=<c:out value="${result.prgSn}"/>&amp;${pageQueryString}" class="contents_crad_wrap">
						<div class="contents_circle_wrap">
							<div class="contents_circle">
								<p>없음</p>
							</div>
						</div>
						<div class="contents_text_wrap">
							<h6>
								콘텐츠 내용이 없습니다.
							</h6>
						</div>
					</a>
				</div>
			</c:if>
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




<%--
<!-- webediter -->
<div class="editDB">
	<div class="bbs">
		<div class="alert alert-info">
			<div class="row">
				<div class="col-md-7">
					<p class="titles">콘텐츠 분야 선제적 도전사례 및 협업노하우를 공유하는 열린 세미나</p>
					<ul class="bull ml0">
						<li>국내외 전문가 초청 성공, 협업사례 공유 세미나 (2015년 10회 개최)</li>
						<li>영화 &lt;배트맨시리즈&gt;, 드라마 &lt;하우스오브카드&gt;, 예능 &lt;무한도전&gt;,</li>
						<li>공연 &lt;맨 오브 라만차&gt; 등</li>
						<li><strong>대상</strong><br>
							<div>
								<p class="bullDot">콘텐츠 분야 전공자, 현업인 등</p>
							</div>
						</li>
					</ul>
				</div>
				<div class="col-md-5 tar">
					<img src="/edumobile/images/sub2/500025.jpg" alt="세미나 장면">
				</div>
			</div>
		</div>
	</div>
</div>
<!-- //webediter -->
 --%>
<%-- <c:choose>
	<c:when test="${param.prgCl eq '10'}">
		<jsp:include page="/WEB-INF/jsp/edumobile/cts/600018.jsp" flush="true"/>
	</c:when>
	<c:when test="${param.prgCl eq '12'}">
		<jsp:include page="/WEB-INF/jsp/edumobile/cts/600020.jsp" flush="true"/>
	</c:when>
	<c:when test="${param.prgCl eq '13'}">
		<jsp:include page="/WEB-INF/jsp/edumobile/cts/600021.jsp" flush="true"/>
	</c:when>
	<c:when test="${param.prgCl eq '20'}">
		<jsp:include page="/WEB-INF/jsp/edumobile/cts/600045.jsp" flush="true"/>
	</c:when>
</c:choose>





<h2>관련프로그램</h2>
<div class="bdList">
	<ul class="tableUl">
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<li><a href="/edumobile/progrm/master/view.do?prgSn=<c:out value="${result.prgSn}"/>&amp;${pageQueryString}"><span class="title"><c:out value="${result.prgNm}"/></span>
				<span class="info1"><span class="date"><c:if test="${not empty result  }">기간 : <c:out value="${result.beginDt}"/> ~ <c:out value="${result.rcritComptAt eq 'Y' ? '모집완료시' : result.endDt}"/></c:if></span>
					<span class="db"><c:out value="${result.reqstMthdNm}"/></span></span>
				</a>
			</li>
		</c:forEach>
			<c:if test="${fn:length(resultList) == 0}" >
				<li>데이터가 없습니다.</li>
			</c:if>
	</table>
</div>

<!-- //bdList -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
</c:if> --%>
