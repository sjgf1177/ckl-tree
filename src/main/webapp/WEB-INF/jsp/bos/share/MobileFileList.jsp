<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
	function delFile(atchFileId, fileSn, bbsId){
		$.getJSON(
				"/bos/cmm/fms/deleteFileInfs.json",
				{atchFileId : atchFileId, fileSn : fileSn, bbsId : bbsId},
				function(data)
				{
					var jdata = data.resultCode;
		            if( jdata == 'success' ) {
		            	alert("성공적으로 삭제하였습니다.");
		            	$("#file_"+fileSn).html("");
		            }
		            else alert("삭제에 실패하였습니다.");
				}
			);
	}
</script>

		<c:if test="${not empty fileList}">
		<ul>
			<c:forEach var="fileVO" items="${fileList}" varStatus="status">
				<c:set var="ext" value="${fn:toLowerCase(fileVO.fileExtsn)}" />
					<c:choose>
						<c:when test="${ext eq 'xls' or ext eq 'xlsx'}">
							<c:set var="icn" value="ico_xls" />
						</c:when>
						<c:when test="${ext eq 'hwp'}">
							<c:set var="icn" value="ico_hwp" />
						</c:when>
						<c:when test="${ext eq 'zip' or ext eq 'alz' }">
							<c:set var="icn" value="ico_zip" />
						</c:when>
						<c:when test="${ext eq 'mp4' or ext eq 'mp3' or ext eq 'wmv' } }">
							<c:set var="icn" value="ico_midea" />
						</c:when>
						<c:when test="${ext eq 'pdf'}">
							<c:set var="icn" value="ico_pdf" />
						</c:when>
						<c:when test="${ext eq 'doc' or ext eq 'docx' }">
							<c:set var="icn" value="ico_word" />
						</c:when>
						<c:when test="${ext eq 'ppt' or ext eq 'pptx' }">
							<c:set var="icn" value="ico_ppt" />
						</c:when>
						<c:when test="${ext eq 'jpg' or ext eq 'jpeg' or ext eq 'png' or ext eq 'gif' }">
							<c:set var="icn" value="ico_img" />
						</c:when>
						<c:otherwise>
							<c:set var="icn" value="ico_file" />
						</c:otherwise>
					</c:choose>
				<li>
					<c:choose>
						<c:when test="${updateFlag=='Y'}">
							<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${param.bbsId}" class="${icn}">
								<span class="fileName"><c:out value="${fileVO.orignlFileNm}"/></span> (<c:out value="${fileVO.fileMg}"/> byte)
							</a>
							<a href="javascript:delFile('${fileVO.atchFileId}', '${fileVO.fileSn}', '${param.bbsId}');">
								<img src="<c:url value='/jbn/images/btn_X.jpg'/>" alt="<c:out value="${fileVO.orignlFileNm}"/> 삭제" />
							</a>
						</c:when>
						<c:otherwise>
							<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${param.bbsId}" class="${icn}">
								<span class="fileName"><c:out value="${fileVO.orignlFileNm}"/></span> (<c:out value="${fileVO.fileMg}"/> byte)
							</a>
						<c:if test="${fileVO.convertCnt > 0}">
							<a href="/cmm/dozen/view.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}" target="_blank" title="${fileVO.orignlFileNm}">빠른보기</a>
						</c:if>
						</c:otherwise>
					</c:choose>
				</li>
			</c:forEach>
		</ul>
	</c:if>