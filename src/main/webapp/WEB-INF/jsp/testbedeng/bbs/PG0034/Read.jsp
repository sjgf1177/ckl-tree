
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<script type="text/javascript">

</script>


	<table class="board_type_0 detail notice" summary="notice board view">
		<caption>일반형 게시판 뷰 페이지</caption>
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
					<span>
					Hit.<c:out value="${result.inqireCo}"></c:out>
					</span>
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
				<div class="table_info_header">
					<span>공연명 : <c:out value="${result.option1}" /></span>
					<div class="upload_file">
						<c:forEach var="fileVO" items="${fileList}" varStatus="status">
                        <a href="/${paramVO.siteName}/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${param.bbsId}" class="${icn}">
                            첨부파일 : <c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte] <br />
                        </a>
                        </c:forEach>
                        <c:if test="${fn:length(fileList) == 0}"><a href="javascript:void(0)">첨부파일 : 등록된 첨부파일이 없습니다.</a></c:if>
					</div>
				</div>
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
	</tbody>
	</table>
	<div class="paging view_paging">
		<ul class="pagination">
			<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
				<li class="btn_singlePage prev">
					<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['PREV'].prevNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />"> <c:out value="${prevNextMap['PREV'].nttSj }" />
					</a>
				</li>
			</c:if>
			<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
				<li class="btn_singlePage next">
					<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['NEXT'].nextNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />"> <c:out value="${prevNextMap['NEXT'].nttSj }" />
					</a>
				</li>
			</c:if>
		</ul>
	</div>
	<div class="board_util_btn_con">
		<c:url var="url" value="/${paramVO.siteName}/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" />
		<a class="btn_style_0 full list" href="<c:out value='${url}' escapeXml='false'/>">
			목록
		</a>
	</div>