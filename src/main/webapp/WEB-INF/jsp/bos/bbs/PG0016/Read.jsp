
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<script type="text/javascript">

	function del(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	}

	function restore(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/restore.do";
		form.submit();
	}

	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delPermanently.do";
		form.submit();
	}

</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>


<div id="content">

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}">

<div class="bdView">
		<table summary="제목,사업부,내용,첨부파일,<c:if test="${not empty result}">등록일,</c:if><c:if test="${not empty result}">조회수,</c:if> 포함">
			<caption>${result.nttSj} (읽기)</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>

				<tr>
					<th scope="row">제목</th>
					<td>
						<c:out value="${result.nttSj}" />
					</td>
				</tr>



				<tr>
					<th scope="row">플랫폼 기관</th>
					<td>
						<c:forEach var="code" items="${psitnCodeList }">
									 <c:if test="${result.option1 eq code.insttSn }"> <c:out value="${code.insttNm}" /></c:if>
						</c:forEach>
					</td>
				</tr>
				<c:if test="${paramVO.bbsId eq 'B0000042'  }">
					<tr>
						<th scope="row">멘티 & 멘토 선택</th>
						<td>
						<c:forEach items="${COM089CodeList }" var="code" varStatus="status">
								<c:if test="${result.option2 eq code.code }"><c:out value= '${code.codeNm }' escapeXml="false" /></c:if>
								</label>
						</c:forEach>
						</td>
					</tr>
				</c:if>
					<%-- 임시 주석
					<tr>
						<th scope="row">진행중인 프로젝트</th>
						<td>
							${result.option3 eq 'Y' ? '진행중' : ''}
						</td>
					</tr>
 					--%>
					<tr>
					<th scope="row">내용</th>
					<td>
						<div class="outputEditor" id="dbdata">
							<c:choose>
								<c:when test="${result.htmlYn=='Y'}">${result.nttCn}</c:when>
								<c:otherwise>
									<% pageContext.setAttribute("crlf", "\n"); %>
									${fn:replace(result.nttCn, crlf, "<br/>")}
								</c:otherwise>
							</c:choose>
						</div>
					</td>
				</tr>

			<c:if test="${result.atchFileId ne ''}">
				<tr>
					<th scope="row">첨부파일</th>
					<td>
						<jsp:include page="/WEB-INF/jsp/bos/share/EgovFileList.jsp" flush="true" />
					</td>
				</tr>
			</c:if>

			<c:if test="${not empty result}">
				<tr>
					<th scope="row">등록일</th>
					<td>${result.regDate}</td>
				</tr>
			</c:if>

			<c:if test="${not empty result}">
				<tr>
					<th scope="row">최종수정일</th>
					<td>${result.uptDate}</td>
				</tr>
			</c:if>


			</tbody>
		</table>
	</div>

</form>

	<div class="fl">
		<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
		<a class="btn btn-default" href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap['PREV'].prevNttId}&${pageQueryString}"><span>이전글</span></a>
	    </c:if>
		<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
		<a class="btn btn-default" href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap['NEXT'].nextNttId}&${pageQueryString}"><span>다음글</span></a>
	    </c:if>
	</div>

	<div class="fr" >
		<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/forUpdate.do?nttId=${result.nttId}&${pageQueryString}&${result.delcode}"><span>수정</span></a>
	<c:if test="${result.delcode eq '0' }" >
		<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:if>
	<c:if test="${result.delcode eq '1' }" >
		<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>원글복구</span></a>
	</c:if>
		<c:url var="url" value="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}"/>
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>


</div>
