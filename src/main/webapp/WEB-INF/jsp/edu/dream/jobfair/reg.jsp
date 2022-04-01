
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<%
	int year = egovframework.com.utl.DateUtil.getYear();
	pageContext.setAttribute("year", year);
%>

<%-- <ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/> --%>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/dream/${paramVO.programId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/dream/${paramVO.programId}/update.do" />
</c:if>

<sec:authorize ifAnyGranted="ROLE_SUPER">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>
<%-- LOG_IMAGE 처리 --%>
<c:if test="${fn:length(fileList) gt 0}">
	<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
		<c:if test="${fileList[x].fileFieldName eq 'logImage'}">
			<c:set var="fileVO" value="${fileList[x]}" />
		</c:if>
	</c:forEach>
</c:if>

<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript">
	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);

		if($("input[name='logImage']").length > 0){
			v.add("logImage", {
		        required: true,
		        message : "이미지를 등록해주세요"
		});
		}




		v.add("year", {
	        required: true
	    });

		v.add("insttNm", {
	        required: true
	    });

		v.add("mainSvc", {
	        required: true
	    });

		v.add("detailCn", {
	        required: true
	    });

		v.add("themaColor", {
	        required: true
	    });

		v.add("sortOrdr", {
	        required: true
	    });

		v.add("mentoCo", {
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

	function del() {
		var form = $("#board")[0];
		form.action = "/bos/dream/${paramVO.programId}/delete.do";
		form.submit();
	}

	function delFile2(atchFileId, fileSn, programId, fileId) {
		$.getJSON("/bos/cmm/fms/deleteFileInfs.json", {
			atchFileId : atchFileId,
			fileSn : fileSn,
			programId : programId
		}, function(data) {
			var jdata = data.resultCode;
			if (jdata == 'success') {
				alert("성공적으로 삭제하였습니다.");
				$("#" + fileId).html("<input type=\"file\" name=\""+fileId+"\" id=\""+fileId+"\" class=\"input_file form-control\"/> 이미지 권장사이즈 : 262*60");
			} else
				alert("삭제에 실패하였습니다.");
		});
	}
</script>
<title><c:out value='${masterVO.bbsNm}' /> - 게시글쓰기</title>
</head>
<div id="content">
	<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
		<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
		<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}">
		<input type="hidden" name="insttSn" value="<c:out value='${result.insttSn }' />">
			<h4>■ 플랫폼 기관 ${masterVO.bbsNm} - ${empty result ? '등록' : '수정'}</h4>
		<div class="bdView">
			<table>
			<caption>플랫폼 기관 ${masterVO.bbsNm} - ${empty result ? '등록' : '수정'}</caption>

				<colgroup>
					<col style="width: 15%" />
					<col style="width: 35%" />
					<col style="width: 15%" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="logImage">로고</label></th>
						<td colspan="3" id="logImage">
						<c:if test="${not empty fileVO}">
								<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}" class="${icn}"> <c:out value="${fileVO.orignlFileNm}" />&nbsp;[<c:out value="${fileVO.fileMg}" />&nbsp;byte]
								</a>
								<a href="#" onclick="javascript:delFile2('<c:out value ='${fileVO.atchFileId}'/>', '<c:out value ='${fileVO.fileSn}'/>', '${masterVO.bbsId}','<c:out value='${fileVO.fileFieldName }'/>');"> <img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileVO.fileCn}"/> 삭제" />
								</a>
						</c:if> <%-- #main_image 파일이 없을시  처리  --%>
						<c:if test="${empty fileVO}">
								<input name="logImage" type="file" id="logImage" class="input_file form-control" title="메인이미지" />
								이미지 권장사이즈 : 262*60
						</c:if> <c:set var="fileVO" value="" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="year">년도</label></th>
						<td colspan="3"><select id="year" name="year">
								<option value="">년도 선택</option>

								<c:forEach var="code" items="${COM084CodeList}" varStatus="status">
									<option value="${code.code}" <c:if test="${code.code eq result.year }">selected="selected"</c:if>>
										<c:out value="${code.codeNm}" />
									</option>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<th scope="row">기관명</th>
						<td colspan="3"><input type="text" name="insttNm" id="insttNm" class="w500" value="${result.insttNm}" title="기관명" /></td>
					</tr>
					<tr>
						<th scope="row">대표서비스</th>
						<td colspan="3"><input type="text" name="mainSvc" id="mainSvc" class="w500" value="${result.mainSvc}" title="대표서비스" /></td>
					</tr>
					<tr>
						<th scope="row">상세내용</th>
						<td colspan="3">

						<textarea rows="10"  cols="10"  title="상세내용" name="detailCn"><c:out value='${result.detailCn }' /></textarea>
						</td>
					</tr>
					<tr>
						<th scope="row" for="themaColor">테마색</th>
						<td><input id="themaColor" maxlength="7" name="themaColor" title="테마색" type="text" value="<c:out value='${result.themaColor }' />"> </td>
						<th scope="row">순번</th>
						<td><select name="sortOrdr" title="순번" id="sortOrdr">
								<option value="">순번 선택</option>
								<c:forEach begin="1" end="50" varStatus="status">
									<option value="<c:out value='${status.count }'/>" <c:if test="${status.count eq result.sortOrdr}">selected='selected'</c:if>>${status.count}</option>
								</c:forEach>

						</select></td>
					</tr>
					<tr>
						<th scope="row" for="">멘토</th>
						<td><select name="mentoCo" title="멘토인원" id="mentoCo">
								<option value="">멘토 인원</option>
								<c:forEach begin="1" end="50" varStatus="status">
									<option value="<c:out value='${status.count }'/>" <c:if test="${status.count eq result.mentoCo}">selected='selected'</c:if>>${status.count}</option>
								</c:forEach>

						</select> 명</td>
						<th scope="row">멘티</th>
						<td><select name="mentiCo" title="멘티인원" id="mentiCo">
								<option value="">멘티 인원</option>
								<c:forEach begin="1" end="50" varStatus="status">
									<option value="<c:out value='${status.count }'/>" <c:if test="${status.count eq result.mentiCo}">selected='selected'</c:if>>${status.count}</option>
								</c:forEach>
						</select> 명</td>
					</tr>

				</tbody>
			</table>
		</div>


	</form>
	<c:if test="${not empty result}">
		<%-- <div class="fl">
		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
	</div>--%>
	</c:if>
</div>

<div class="fr">
	<c:choose>
		<c:when test="${empty result}">
			<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
		</c:when>
		<c:otherwise>
			<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
			<%-- 	<c:if test="${result.delcode eq '0' }" > --%>
			<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
			<%-- 	</c:if> --%>
			<c:if test="${result.delcode eq '1' }">
				<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>복구</span></a>
			</c:if>
		</c:otherwise>
	</c:choose>
	<c:url var="url" value="/bos/dream/${paramVO.programId}/list.do?${pageQueryString}" />
	<a class="btn btn-primary" href="${url}"><span>목록</span></a>
</div>




