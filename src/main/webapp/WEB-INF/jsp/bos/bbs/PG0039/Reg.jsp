
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>




<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/bbs/${paramVO.bbsId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/bbs/${paramVO.bbsId}/update.do" />
</c:if>

<script type="text/javascript">

$(function() {
	$(".sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
});

	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);
	    v.add("nttSj", {
	        required: true
	    });

	    v.add("option12", {
	        required: true
	    });

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (!confirm('등록하시겠습니까?')) {
			return;
		}

		form.submit();
	}
	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	}

	function delFile2(atchFileId, fileSn, bbsId, fileId){
		$.getJSON(
				"/bos/cmm/fms/deleteFileInfs.json",
				{atchFileId : atchFileId, fileSn : fileSn, bbsId : bbsId},
				function(data)
				{
					var jdata = data.resultCode;
		            if( jdata == 'success' ) {
		            	alert("성공적으로 삭제하였습니다.");
		            	$("#"+fileId).html("<input type=\"file\" name=\""+fileId+"\" id=\""+fileId+"\" class=\"input_file form-control\"/> 이미지 권장사이즈 : 300*150");
		            }
		            else alert("삭제에 실패하였습니다.");
				}
			);
	}



</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
</head>

<div id="content">

	<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
		<input type="hidden" name="pageQueryString" value="${pageQueryString}" /> 
		<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" /> 
		<input type="hidden" name="bbsId" value="${masterVO.bbsId}" /> 
		<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}"> 
		<input type="hidden" name="htmlYn" value="${result.htmlYn}" />

		<div class="bdView">
			<table summary="<c:if test="${roleSuper eq 'Y'}">게시구분,게시기간,</c:if>제목,담당부서,내용<c:if test="${not empty result}">등록일,</c:if><c:if test="${not empty result}">조회수,</c:if> 포함">
				<caption>${masterVO.bbsNm} - ${empty result ? '쓰기' : '수정'}</caption>
				<colgroup>
					<col style="width: 15%" />
					<col />
				</colgroup>
				<tbody>
					<%--########################### MAIN_IMAGE 시작 --%>
					<%--이미지 탐색 main_image 처리 --%>
					<c:if test="${fn:length(fileList) gt 0}">
						<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
							<c:if test="${fileList[x].fileFieldName eq 'main_image'}">
								<c:set var="fileVO" value="${fileList[x]}"/>
							</c:if>
						</c:forEach>
					</c:if>
					<%--이미지 탐색 main_image 끝 --%>
					<tr>
						<th scope="row">썸네일 이미지 파일</th>
						<td>
							<div style="margin:3px 0;font-weight:bold;">※모든 파일 이름을 다르게 입력해주세요.</div>
							<c:if test="${not empty fileVO}">
								<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
									<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
								</a>
								<a href="#" onclick="javascript:delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','main_image');">
									<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileVO.fileCn}"/> 삭제" />
								</a>
							</c:if>
				
							<%-- #main_image 파일이 없을시  처리  --%>
							<c:if test="${empty fileVO}">
								<input name="main_image" type="file" id="main_image" class="input_file form-control" title="메인이미지" />
							</c:if>
							<c:set var="fileVO" value=""/>
						</td>
					</tr>
					<%--########################### MAIN_IMAGE 끝 --%>
					<tr>
						<th scope="row"><label for="nttSj">제목</label></th>
						<td><input type="text" name="nttSj" id="nttSj" class="w500" value="<c:out value="${result.nttSj}" />" /></td>
					</tr>

					<tr>
						<th>매체명</th>
						<td><input type="text" name="option11" title="매체명" class="w500" value="<c:out value="${result.option11 }" />"></td>
					</tr>
					<tr>
						<th>게재일</th>
						<td> <input type="text" name="ntceBgnde" title="게제일" class="sdate" readonly="readonly" value="<c:out value="${result.ntceBgnde }" />"></td>
					</tr>
					
					<tr>
						<th>기사 URL</th>
						<td><input type="text" name="option12" title="해당기사 바로가기" class="w500" value="<c:out value="${result.option12 }" />"></td>
					</tr>
					<tr>
						<th scope="row"><label for="useAt">사용여부</label></th>
						<td>
							<label>
								<input type="radio" name="useAt" id="useAt" value="Y" ${result.useAt eq 'Y' || result.parent eq null?'checked':''} />
								사용
							</label>
							<label>
								<input type="radio" name="useAt" id="useAt" value="N" ${result.useAt eq 'N'?'checked':''} />
								미사용
							</label>
						</td>
					</tr>
					<c:if test="${not empty result}">
						<tr>
							<th scope="row">등록일</th>
							<td>${result.regDate}</td>
						</tr>
					</c:if>



					<c:if test="${not empty result}">
						<tr>
							<th scope="row">조회수</th>
							<td>${result.inqireCo}</td>
						</tr>
					</c:if>


				</tbody>
			</table>
		</div>
	</form>
	<c:if test="${not empty result}">
		<div class="fl">
			
		</div>
	</c:if>



	<div class="fr" >
	<c:choose>
	<c:when test="${empty result}" >
		<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
	</c:when>
	<c:otherwise>
		<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
	<c:if test="${result.delcode eq '0' }" >
		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:if>

	</c:otherwise>
	</c:choose>
		<c:url var="url" value="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}"/>
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
</div>

