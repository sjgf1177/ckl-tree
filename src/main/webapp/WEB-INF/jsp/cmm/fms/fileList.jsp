<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
	function delFile(atchFileId, fileSn){
		if (!confirm('삭제 하시겠습니까?')) {
			return false;
		}
		$.getJSON(
				"/bos/cmm/fms/deleteFileInfs.json",
				{atchFileId : atchFileId, fileSn : fileSn},
				function(data)
				{
					var jdata = data.resultCode;
		            if( jdata == 'success' ) {
		            	alert("성공적으로 삭제하였습니다.");
		            	location.reload();
		            	//$("#realfile_"+fileSn).html("");
		            }
		            else alert("삭제에 실패하였습니다.");
				}
			);
	}
</script>

<c:if test="${fn:length(fileList) > 0}">
<ul style="list-style-type:none;">
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
			<c:when test="${ext eq 'jpg' or ext eq 'jpeg' or ext eq 'png' }">
				<c:set var="icn" value="ico_img" />
			</c:when>
			<c:otherwise>
				<c:set var="icn" value="ico_file" />
			</c:otherwise>
		</c:choose>
		<li>
			<c:set var="cnd" value="N"/>
			<c:if test="${empty param.fileFieldName}"><c:set var="cnd" value="Y"/></c:if>
			<c:if test="${not empty param.fileFieldName and param.fileFieldName eq fileVO.fileFieldName}"><c:set var="cnd" value="Y"/></c:if>
			<c:if test="${cnd eq 'Y'}">
				<c:choose>
					<c:when test="${param.listType eq 'img'}">
						<img src='/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}'  width="120" height="100" alt="${fileVO.fileCn}" />
						<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}"  class="${icn}">
							<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
						</a>
					</c:when>
					<c:when test="${param.listType eq 'noImg'}">
						<c:if test="${fileVO.fileFieldName ne 'mainImg'}">
							<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}" class="${icn}">
								<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
							</a>
							<c:if test="${param.updateFlag=='Y'}">
								<a href="#" onclick="javascript:delFile('${fileVO.atchFileId}', '${fileVO.fileSn}', '${param.bbsId}');">
									<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileVO.fileCn}"/> 삭제" />
								</a>
							</c:if>
						</c:if>
					</c:when>
					<c:otherwise>
						<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}" class="${icn}">
							<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
						</a>
					</c:otherwise>
				</c:choose>
				<c:if test="${param.updateFlag=='Y'}">
					<c:if test="${param.listType ne 'noImg'}">
						<a href="#" onclick="javascript:delFile('${fileVO.atchFileId}', '${fileVO.fileSn}', '${param.bbsId}');">
							<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileVO.fileCn}"/> 삭제" />
						</a>
					</c:if>
				</c:if>
			</c:if>
		</li>
	</c:forEach>
</ul>
</c:if>
