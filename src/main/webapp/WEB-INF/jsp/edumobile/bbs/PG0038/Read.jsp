
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>
<c:forEach var="code" items="${psitnCodeList }">
		<c:if test="${result.option1 eq code.insttSn }">
			<c:set var="psitnCode" value="${code }" />
		</c:if>
</c:forEach>
<script type="text/javascript">

</script>

<c:if test="${result.useAt eq 'Y' && result.delcode eq 0 }">

	<table class="board_type_0 detail notice" summary="notice board view">
	<caption>지원현황 게시판 뷰 페이지</caption>
		<colgroup>
			<col width="100%">
		</colgroup>
	<thead>
	<tr>
		<th>
			<span>
				<c:out value="${result.nttSj}" />
			</span>
			<span class="writer_info">
				<span class="tar"> <c:out value="${result.ntcrNm}"/></span>
				<span>
				<c:out value="${result.frstRegisterPnttm}" />
				</span>
			</span>
		</th>
	</tr>
	</thead>
		<tbody>
		<tr>
			<td>
				<div class="contents_view_area">
					<c:choose>
						<c:when test="${result.htmlYn=='Y'}">${result.nttCn}</c:when>
						<c:otherwise>
								<% pageContext.setAttribute("crlf", "\n"); %>
							${fn:replace(result.nttCn, crlf, "<br/>")}
						</c:otherwise>
					</c:choose>

					<!-- 본문이미지 대체텍스트 -->
					<!-- <div class="hidden">${result.imgDescCn}</div> -->
				</div>
			</td>
		</tr>
		
		<tr style="border-top:1px solid #eeeeee;">
			<td>
				<c:import url="/bos/cmm/fms/fileList.do">
					<c:param name="listType" value="noImg"/>
					<c:param name="fileFieldName" value="sub_file"/>
				</c:import>
			</td>
		</tr>
		</tbody>
	</table>

	<div class="paging view_paging">
		<ul class="pagination">
		<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
			<li class="btn_singlePage prev">
				<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['PREV'].prevNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />">
					${prevNextMap['PREV'].nttSj }
				</a>
			</li>
		</c:if>
		<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
			<li class="btn_singlePage next">
				<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['NEXT'].nextNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />">
					${prevNextMap['NEXT'].nttSj }
				</a>
			</li>
		</c:if>
		</ul>
	</div>
	
</c:if>

<c:if test="${result.useAt eq 'N' && result.delcode eq 1 }">

	<div class="mt40 mb40 tc">
		<h4>삭제된 게시글 입니다.</h4>
	</div>
	
</c:if>

	<div class="board_util_btn_con">
	<c:url var="url" value="/edu/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" />
	<a class="btn_style_0 full list" href="<c:out value='${url}' escapeXml='false'/>">
	목록
	</a>
	</div>



<style>
	.linemap_wrap .linemap_con li:nth-child(4) { display:none }
</style>