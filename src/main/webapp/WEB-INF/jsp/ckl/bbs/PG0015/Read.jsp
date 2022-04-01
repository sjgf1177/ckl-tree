
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<script type="text/javascript">

</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
</head>

<div class="dlListTable">
	<dl>
		<dt>제목</dt>
		<dd><c:out value="${result.nttSj}"/></dd>
		<dt>작성자</dt>
		<dd class="w15p tac"><c:out value="${result.ntcrNm}"/></dd>
	</dl>
	<dl>
		<dt>첨부파일</dt>
		<dd>
			<c:forEach var="fileVO" items="${fileList}" varStatus="status">
				<a href="/ckl/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${param.bbsId}" class="${icn}">
					<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
				</a>
			</c:forEach>
			<c:if test="${fn:length(fileList) == 0}">등록된 첨부파일이 없습니다.</c:if>
		</dd>
		<dt>작성일</dt>
		<dd class="w15p tac"><c:out value="${result.frstRegisterPnttm}"/></dd>
	</dl>
	<div class="editDB">
		<% pageContext.setAttribute("crlf","\r\n"); %>
		${fn:replace(fn:replace(fn:escapeXml(result.nttCn), crlf, '<br/>') , ' ', '&nbsp;')}
	</div>

<!-- 답변 -->
<c:set var="reply" value="${replyList[0]}" />
<c:if test="${masterVO.replyPosblAt eq 'Y' and result.parnts eq 0 and not empty reply}">
<h3>답변</h3>
	<dl>
		<dt>담당자</dt>
		<dd><c:out value="${reply.ntcrNm}"/></dd>
		<dt>답변일</dt>
		<dd class="w15p tac"><c:out value="${reply.frstRegisterPnttm}"/></dd>
	</dl>
	<dl>
		<dt>첨부파일</dt>
		<dd>
			<c:forEach var="fileVO" items="${replyFileMap[reply.atchFileId] }" varStatus="status">
				<a href="/edu/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${param.bbsId}" class="${icn}">
					<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte] <br />
				</a>
			</c:forEach>
			<c:if test="${fn:length(fileList) == 0}">등록된 첨부파일이 없습니다.</c:if>
		</dd>
	</dl>


	</dl>
	<div class="editDB">
		${reply.nttCn}
	</div>
</c:if>

	<div class="btnSet tar">
		<a href="/ckl/bbs/${paramVO.bbsId}/forUpdate.do?nttId=${result.nttId}&amp;myAt=${param.myAt}&amp;${pageQueryString}" class="btn btn-primary">수정</a>
		<c:set var="list" value="list"/>
		<c:if test="${param.my eq 'Y'}">	<c:set var="list" value="listMy"/></c:if>
		<a href="/ckl/bbs/${paramVO.bbsId}/${list}.do?${pageQueryString}" class="btn btn-primary">목록</a>
	</div>

</div>
