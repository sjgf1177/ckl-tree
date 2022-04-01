
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />
<c:if test="${fn:length(fileList) gt 0}">
	<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
		<c:if test="${fileList[x].fileFieldName eq 'main_image'}">
			<c:set var="fileVO" value="${fileList[x]}" />
		</c:if>
	</c:forEach>
</c:if>





<table class="contents_insight_view">
	<caption>온라인 모의면접 뷰 페이지</caption>
	<colgroup>
		<col width="20%">
		<col width="auto">
		<col width="20%">
		<col width="auto">
	</colgroup>
	<tbody>
		<tr>
			<th>면접유형</th>
			<td colspan="3"><c:out value="${result.nttSj}" /></td>
		</tr>
	<tr>
		<th>분야</th>
		<td>
			<c:if test="${not empty COM113CodeList }">
				<c:forEach var="code" items="${COM113CodeList}" varStatus="status">
					<c:if test="${code.code eq result.option1}">${code.codeNm}</c:if>
				</c:forEach>
			</c:if>
		</td>
		<th>문항수</th>
		<td>
			<c:out value="${result.option2}" />
		</td>
	</tr>
	</tbody>
</table>
<div class="insight_view_contents online_interview_view_contents">
	<c:choose>
		<c:when test="${result.htmlYn=='Y'}">${result.nttCn}</c:when>
		<c:otherwise>
			<% pageContext.setAttribute("crlf", "\n"); %>
			${fn:replace(result.nttCn, crlf, "<br/>")}
		</c:otherwise>
	</c:choose>

	<!-- 본문이미지 대체텍스트 -->
	<!-- <div class="hidden">${result.imgDescCn}</div> -->
	<!-- 입장 버튼  -->
	<div style="text-align:center;margin-top:30px;">
		<div class="center board_util_btn_con">
			<input class="btn_style_0 small" type="button" value="입장하기" onclick="openInterviewPopup('${result.option3}');"/>
		</div>
	</div>
	<!-- //입장 버튼  -->
</div>
<hr class="contents_insight_line">
<div class="board_util_btn_con">
	<c:url var="url" value="/edu/bbs/${paramVO.bbsId}/list.do?option3=${param.option3 }&${pageQueryString}" />
	<a class="btn_style_0 full list" href="<c:out value='${url}' escapeXml='false'/>"><span>목록</span></a>
</div>
<!-- bdView -->
<%-- <div class="dlListTable">
	<div class="row">
		<div class="col-md-1">
			<c:if test="${not empty fileVO}">
				<img src="/cmm/fms/getImage.do?atchFileId=<c:out value='${fileVO.atchFileId}'/>&fileSn=<c:out value='${fileVO.fileSn}'/>" alt="${fileVO.fileCn}" style="height: 82px" />
			</c:if>
		</div>
		<div class="col-md-11">
			<dl>
				<dt>면접유형</dt>
				<dd>
					<!-- 면접유형 --> <c:out value="${result.nttSj}" />
				</dd>
			</dl>
			<dl>
				<dt>분야</dt>
				<dd>
					<!-- 분야 -->
					<c:if test="${not empty COM113CodeList }">
						<c:forEach var="code" items="${COM113CodeList}" varStatus="status">
							<c:if test="${code.code eq result.option1}">${code.codeNm}</c:if>
						</c:forEach>
					</c:if>
					<!-- //분야 -->
				</dd>
				<dt>문항수</dt>
				<dd> 
					<!-- 문항수 --><c:out value="${result.option2}" />
				</dd>
			</dl>
		</div>
	</div>
	<!-- 내용 -->
	<div class="editDB">
		<c:choose>
			<c:when test="${result.htmlYn=='Y'}">${result.nttCn}</c:when>
			<c:otherwise>
				<% pageContext.setAttribute("crlf", "\n"); %>
				${fn:replace(result.nttCn, crlf, "<br/>")}
			</c:otherwise>
		</c:choose>

		<!-- 본문이미지 대체텍스트 -->
		<!-- <div class="hidden">${result.imgDescCn}</div> -->
		<!-- 입장 버튼  -->
		<div style="text-align:center;margin-top:30px;">
			<input type="button" value="입장하기" onclick="openInterviewPopup('${result.option3}');" style="border:1px solid black;padding:15px;background:gray;color:white;"/>
		</div>
		<!-- //입장 버튼  -->
	</div>
	<!-- //내용 -->

	<div class="btnSet tar">
		<c:url var="url" value="/edu/bbs/${paramVO.bbsId}/list.do?option3=${param.option3 }&${pageQueryString}" />
		<a class="btn btn-primary" href="<c:out value='${url}' escapeXml='false'/>"><span>목록</span></a>
	</div>


	<!-- <div class="dlListTable">
						<dl>
							<dt>다음글</dt>
							<dd>아프리카 인기 BJ와 함께하는 ‘MCN 크리에이터 커뮤니티’ 개최</dd>
						</dl>
						<dl>
							<dt>이전글</dt>
							<dd>아프리카 인기 BJ와 함께하는 ‘MCN 크리에이터 커뮤니티’ 개최</dd>
						</dl>
					</div> -->
	<!-- //bdView -->
</div> --%>

<script type="text/javascript">
	// 온라인 모의면접 입장하기
	function openInterviewPopup(url){
		window.open(url, "모의면접", "width=1180, height=760, menubar=no, status=no, toolbar=no")
	}
</script>
