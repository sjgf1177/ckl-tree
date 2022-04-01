
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

<sec:authorize ifAnyGranted="ROLE_SUPER">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>

<c:if test="${fn:length(fileList) gt 0}">
	<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
		<c:if test="${fileList[x].fileFieldName eq 'main_image'}">
			<c:set var="fileVO" value="${fileList[x]}"/>
		</c:if>
	</c:forEach>
</c:if>


<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
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

	    v.add("option1", {
	        required: true
	    });

	    if($("input[name='main_image']").length > 0){
			v.add("main_image", {
		        required: true,

		    });
		}



		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		/* if (CrossEditor.GetBodyValue() == "") {
			alert('내용을 입력해 주세요.');
		    CrossEditor.SetFocusEditor(); // 크로스에디터 Focus 이동
		    return;
		} */

		if (!confirm('등록하시겠습니까?')) {
			return;
		}

// 		var cont = CrossEditor.GetBodyValue();
// 		document.getElementById("nttCn").value= cont;
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
		            	$("#"+fileId).html("<input type=\"file\" name=\""+fileId+"\" id=\""+fileId+"\" class=\"input_file form-control\"/> 이미지 권장사이즈 : 335*245");
		            }
		            else alert("삭제에 실패하였습니다.");
				}
			);
	}


</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
</head>


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

					<tr>
						<th scope="row"><label for="nttSj">제목</label></th>
						<td><input type="text" name="nttSj" id="nttSj" class="w500" value="<c:out value="${result.nttSj}" />" /></td>
					</tr>

					<tr>
						<th scope="row"><label for="nttSj">유튜브링크</label></th>
						<td><input type="text" name="option1" id="option1" class="w500" value="${result.option1}" /></td>
					</tr>

					<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
						<tr>
							<th scope="row"><label for="main_image">유튜브 메인이미지</label></th>
							<td id="main_image">

							<c:if test="${not empty fileVO}">
								<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
									<img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}" style="width: 140px;" alt="${fileVO.fileCn }" /> <br />
											<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
								</a>
								<a href="#" onclick="javascript:delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','main_image');">
									<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileVO.fileCn}"/> 삭제" />
								</a>
							</c:if>
								<%-- #main_image 파일이 없을시  처리  --%>
							<c:if test="${empty fileVO}">
								<input name="main_image" type="file" id="main_image" class="input_file form-control" title="" />
								이미지 권장사이즈 : 335*245
							</c:if>
							<c:set var="fileVO" value=""/>

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
							<th scope="row">조회수</th>
							<td>${result.inqireCo}</td>
						</tr>
					</c:if>


				</tbody>
			</table>
		</div>
	</form>



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

