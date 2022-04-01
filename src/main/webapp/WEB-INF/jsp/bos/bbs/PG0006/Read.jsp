
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
	<%--
	function restore(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/restore.do";
		form.submit();
	}
--%>
	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delPermanently.do";
		form.submit();
	}

</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
<c:if test="${not empty COM066CodeList }">
<c:set value="${COM066CodeList }"  var="codeList" />
</c:if>

<c:if test="${not empty COM067CodeList }">
<c:set value="${COM067CodeList }"  var="codeList" />
</c:if>

<c:if test="${not empty COM068CodeList }">
<c:set value="${COM068CodeList }"  var="codeList" />
</c:if>

<c:if test="${not empty COM069CodeList }">
<c:set value="${COM069CodeList }"  var="codeList" />
</c:if>


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
				<c:if test="${paramVO.bbsId eq 'B0000011' or paramVO.bbsId eq 'B0000017' }">
				<tr>
					<th scope="row">구분</th>
					<td>
						<c:if test="${result.nttType == '1'}">
						공지
						</c:if>
						<c:if test="${result.nttType == '2'}">
						일반
						</c:if>
					</td>
				</tr>

				<c:if test="${result.nttType == '1'}">
				<tr>
					<th scope="row">공지기간</th>
					<td>
						${result.ntceBgnde} ~ ${result.ntceEndde}
					</td>
				</tr>
				</c:if>
			</c:if>

				<tr>
					<th scope="row">제목</th>
					<td>
						${result.nttSj}
					</td>
				</tr>
			<c:if test="${not empty codeList }">
				<tr>
					<th scope="row">구분</th>
					<td>
						<c:out value="${result.option5Nm }" />
				</select>
					</td>
				</tr>
			</c:if>

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
			<c:if test="${not empty result.atchFileId}">
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

	<c:if test="${result.delcode eq '1'}">
	<div class="fl">
		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
	</div>
	</c:if>



<div class="btnSet">
	<div class="fl">
		<%-- <c:if test="${not empty result}">
		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
		</c:if>
 --%>
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
	<%-- <c:if test="${result.delcode eq '1' }" >
		<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>원글복구</span></a>
	</c:if> --%>
		<c:url var="url" value="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}"/>
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>
</div>


</div>
