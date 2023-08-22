
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />
<jsp:useBean id="todayNow" class="java.util.Date"  />
<fmt:formatDate value="${todayNow}" var="today" pattern="yyyy-MM-dd" />
	<c:url value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/list.do?menuNo=${param.menuNo }" var="searchUrl" />
	<!-- bdList -->
<div class="tab_style_1_con"> 
	<ul class="tab_style_1 two_tab">
		<li class="active">
			<a href="/edu/bbs/B0000048/list.do?menuNo=500205" title="현재탭">
				<span>이벤트</span>
			</a>
		</li>
		<li>
			<a href="/edu/bbs/B0000023/list.do?menuNo=500206">
				<span>콘텐츠이야기</span>
			</a>
		</li>
	</ul>
</div>
	<!--content-->
<div class="col-12 event_card_wrap">
	<div class="col-12 calc_wrap19">
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:set value="${fileMap[result.atchFileId] }" var="fileList" />
		<c:url var="url" value="/edu/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}${pageQueryString}" />
		<div class="col-6 col-sm-4 tc event_card_list go">
			<a href="<c:out value="${url }" escapeXml="false" />" class="col-12 show fn event_card">
				<div class="col-12 img_box">
					<c:choose>
						<c:when test='${ fileList.size() > 0 }'>
							<c:forEach var="file" items="${fileList }">
								<c:choose>
									<c:when test="${file.fileFieldName eq 'main_image' }">
										<%--<img alt="에듀코카 이벤트 이미지" src="/cmm/fms/getImage.do?atchFileId=<c:out value="${file.atchFileId}" />&amp;fileSn=<c:out value="${file.fileSn}" />" style="width: 336px;height: 216px" />--%>
										<img alt="에듀코카 이벤트 이미지" src="<c:out value="${file.imgUrl}" />" style="width: 336px;height: 216px" />
									</c:when>
									<c:otherwise>
										<%--<img alt="No Image" src="/edu/images/bm/noimage.png" />--%>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<img alt="No Image" src="/edu/images/bm/noimage.png" />
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${(result.nttType=='1') and (today ge result.ntceBgnde) and (today le result.ntceEndde) }">
							<span class="event_text go">진행</span>
						</c:when>
						<c:when test="${(today gt result.ntceBgnde) and (today gt result.ntceEndde)  }">
							<span class="event_text end">마감</span>
						</c:when>
						<c:when test="${(today lt result.ntceBgnde) and (today lt result.ntceEndde)  }">
							<span class="event_text end">예정</span>
						</c:when>
					</c:choose>
				</div>
				<div class="col-12 text_box">
					<p class="event_num">${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</p>
					<h5><c:out value="${result.nttSj }" /></h5>
					<p class="event_date">기간 : <span class="show"><c:out value="${result.ntceBgnde }" /></span> ~ <span class="show"><c:out value="${result.ntceEndde }" /></span></p>
				</div>
			</a>
		</div>
		<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
	</div>
</div>

<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">${pageNav}</div>
	<!-- paging end //-->
</c:if>
<!-- //paging -->
