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
		            	file_number-=1;
		            	
		            }
		            else alert("삭제에 실패하였습니다.");
				}
			);
	}
</script>
<c:if test="${not empty replyFileMap}">
<ul style="list-style-type:none;">
	<c:forEach var="fileVO" items="${param.fileStatus eq 'completeAnswer' ? replyFileMap[completeAnswerVO.atchFileId] : replyFileMap[answeringVO.atchFileId] }" varStatus="status">
			<c:set var="ext" value="${fn:toLowerCase(fileVO.fileExtsn)}" />
		<c:choose>
			<c:when test="${ext == 'xls'}">
				<c:set var="icn" value="<img src='/bos/images/ico_xls.gif' alt='엑셀' />" />
			</c:when>
			<c:when test="${ext == 'hwp'}">
				<c:set var="icn" value="<img src='/bos/images/ico_hwp.gif' alt='한글'  />"/>
			</c:when>
			<c:when test="${ext == 'pdf'}">
				<c:set var="icn" value="<img src='/bos/images/ico_pdf.gif' alt='PDF'  />"/>
			</c:when>
			<c:when test="${ext == 'ppt'}">
				<c:set var="icn" value="<img src='/bos/images/ico_ppt.gif' alt='파워포인트' />" />
			</c:when>
			<c:when test="${ext == 'doc'}">
				<c:set var="icn" value="<img src='/bos/images/ico_word.gif' alt='워드'  />"/>
			</c:when>
			<c:otherwise>
				<c:set var="icn" value="<img src='/bos/images/common/disk.gif' alt='첨부파일'  />"/>
			</c:otherwise>
		</c:choose>
		<li>
			<%-- <c:if test="${ext == 'jpg' || ext == 'bmp' || ext == 'png' || ext == 'gif'}">
				<img src="${fileVO.imgUrl}" alt="${result.nttSj}"/><br/>
			</c:if> --%>
			<c:choose>
				<c:when test="${updateFlag=='Y'}">
					<div id="file_${fileVO.fileSn}">
					<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${param.bbsId}">
						${icn} <c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
					</a>
					<a href="javascript:delFile('${fileVO.atchFileId}', '${fileVO.fileSn}', '${param.bbsId}');">
						<img src="<c:url value='/portal/images/common/bu5_close.gif'/> alt="<c:out value="${fileVO.orignlFileNm}"/> 삭제" />
					</a>
					</div>
				</c:when>
				<c:otherwise>
					<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${param.bbsId}">
						${icn} <c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
					</a>	       
				</c:otherwise>
			</c:choose>
		</li>
	</c:forEach>
</ul>
</c:if>