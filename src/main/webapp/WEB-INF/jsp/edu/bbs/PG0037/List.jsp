
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>
<div class="tab_style_1_con">
	<ul class="tab_style_1 two_tab">
		<li><a href="/edu/main/contents.do?menuNo=500179"><span>사업소개</span></a></li>
		<!-- <li><a href="/edu/main/contents.do?menuNo=500180"><span>마스터클래스</span></a></li>
		<li><a href="/edu/main/contents.do?menuNo=500181"><span>쇼케이스</span></a></li>
		<li><a href="/edu/main/contents.do?menuNo=500182"><span>융복합컨퍼런스</span></a></li> -->
		<li class="active"><a href="/edu/bbs/B0000072/list.do?menuNo=500212" title="현재탭"><span>지원현황</span></a></li>
	</ul>
</div>
	<div class="col-12 sub_board_body">
		<table class="board_type_0" style="margin-bottom:20px;">
			<colgroup>
				<col width="25%">
				<col width="auto">
			</colgroup>
			<tbody>
				<c:set var="endLoop" value="false"/>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:if test="${not endLoop }">
						<c:if test="${result.option1 eq 'Y'}">
							<c:set value="${fileMap[result.atchFileId] }" var="fileList" />
							<c:forEach var="files" items="${fileList }">
								<c:if test="${files.fileFieldName eq 'main_image' }">
									<c:set  var="file" value="${files }"/>
								</c:if>
							</c:forEach>
							<tr>
								<td rowspan="2" style="padding:10px;">
									<img src='/edu/images/edupro/onecampus_logo.png' style="width:100%;height:auto;" alt="콘텐츠원캠퍼스 로고"  />
									<%-- <c:if test="${not empty file }">
										<img src='/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}'  style="width: 100%;height: auto;"  alt="${result.nttSj}"  />
									</c:if> --%>
								</td>
								<td style="padding-left:20px; background-color:#1998d2;">
									<span style=" font-size:1.7rem; color:#ffffff;"><c:out value='${result.nttSj}'/></span>
								</td>
							</tr>
							<tr>
								<td style="text-align:left; padding-left:20px; height:220px; overflow-y:hidden;">
									<div style="height:220px; overflow-y:auto;">${result.nttCn}</div>
								</td>
							</tr>
							<c:set var="endLoop" value="true"/>
						</c:if>
					</c:if>
				</c:forEach>
			</tbody>
		</table>

		<table class="board_type_0">
			<colgroup>
				<col width="100%">
			</colgroup>
			<tbody style="border-top:2px solid #40abd4;">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:if test="${result.option1 eq 'N'}">
						<tr>
							<td class="tal" style="padding-left:20px;background-color:<c:out value='${result.option2}'/>;">
								<c:url var="url" value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}${pageQueryString}" />
								<a href="<c:out value='${url}' escapeXml='false'/>">
									<c:choose>
										<c:when test="${result.delcode ne SearchVO.NON_DELETION}">
											<span class="del"><c:out value='${result.nttSj}' /></span>
										</c:when>
										<c:otherwise>
											<c:out value='${result.nttSj}' />
										</c:otherwise>
									</c:choose> ${result.newYn=='Y'?'[new]':''}
								</a>
							</td>
						</tr>
						<c:set var="resultCnt" value="${resultCnt-1}" />
					</c:if>
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="4">데이터가 없습니다.</td></tr></c:if>
			</tbody>

		</table>
	</div>

	<!-- paging -->
	<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">${pageNav}</div>
		<!-- paging end //-->
	</c:if>
	<!-- //paging -->
