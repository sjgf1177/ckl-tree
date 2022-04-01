
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>


<%-- 사진이미지  --%>
<c:if test="${fn:length(fileList) gt 0}">
	<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
		<c:if test="${fileList[x].fileFieldName eq 'photo'}">
			<c:set var="fileVO" value="${fileList[x]}" />
		</c:if>
	</c:forEach>
</c:if>

<%-- <ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/> --%>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/dream/${paramVO.programId}/insert.do?menuNo=${param.menuNo }" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/dream/${paramVO.programId}/update.do?menuNo=${param.menuNo }" />
</c:if>

<sec:authorize ifAnyGranted="ROLE_SUPER">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>

<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript">
	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);

		v.add("insttSn", {
	        required: true
	    });


		if($("input[name='photo']").length > 0){
			v.add("photo", {
		        required: true,
		});
		}

		v.add("nm", {
	        required: true
	    });
		v.add("psitn", {
	        required: true
	    });
		/* v.add("histSe", {
	        required: true
	    });
		v.add("histCn", {
	        required: true
	    });
		v.add("mentoNm", {
	        required: true
	    }); */
		v.add("sortOrdr", {
	        required: true
	    });
	    
	    v.add("useAt", {
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
				$("#" + fileId).html("<input type=\"file\" name=\""+fileId+"\" id=\""+fileId+"\" class=\"input_file form-control\"/> 이미지 권장사이즈 : 346*250");
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
		<input type="hidden" name="frstRegisterId" id="frstRegisterId" value="<c:out value="${result.userId }" />" />
		<input type="hidden" name="LastUpdusrId" id="LastUpdusrId" value="<c:out value="${result.userId }" />" />
		<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}">
		<input type="hidden" name="mentoSn" value="<c:out value='${result.mentoSn }' />">
		<h4>■ 멘토 ${masterVO.bbsNm} - ${empty result ? '등록' : '수정'}</h4>
		<div class="bdView">
			<table>
				<caption>${masterVO.bbsNm} - ${empty result ? '등록' : '수정'}</caption>
				<colgroup>
					<col style="width: 15%" />
					<col style="width: 35%" />
					<col style="width: 15%" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">소속</th>
						<td colspan="3" name="insttSn"><select name="insttSn"  title="소속">
								<option value="">소속 선택</option>
								<c:forEach var="code" items="${psitnCodeList }">
									<option value="${code.insttSn}" <c:if test="${result.insttSn eq code.insttSn }">selected="selected"</c:if>>
										<c:out value="${code.yearNm }" />년 <c:out value="${code.insttNm}" />
									</option>

								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<th scope="row"><label for="photo">사진</label></th>
						<td colspan="3" id="photo"><c:if test="${not empty fileVO}">
								<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}" class="${icn}"> <c:out value="${fileVO.orignlFileNm}" />&nbsp;[<c:out value="${fileVO.fileMg}" />&nbsp;byte]
								</a>
								<a href="#" onclick="javascript:delFile2('<c:out value ='${fileVO.atchFileId}'/>', '<c:out value ='${fileVO.fileSn}'/>', '${masterVO.bbsId}','<c:out value='${fileVO.fileFieldName }'/>');"> <img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileVO.fileCn}"/> 삭제" />
								</a>
							</c:if> <%-- #main_image 파일이 없을시  처리  --%> <c:if test="${empty fileVO}">
								<input name="photo" type="file" id="photo" class="input_file form-control" title="사진" />
								이미지 권장사이즈 : 346*250
							</c:if> <c:set var="fileVO" value="" />

						</td>
					</tr>
					<tr>
						<th scope="row">성명</th>
						<td colspan="3"><input type="text" name="nm" id="nm" class="w500" value="${result.nm}" title="성명" /></td>
					</tr>
					<tr>
						<th scope="row">소속</th>
						<td colspan="3"><input type="text" name="psitn" id="psitn" class="w500" value="<c:out value='${result.psitn }' />" title="소속" /></td>
					</tr>
					<tr>
						<th scope="row">멘토링 분야</th>
						<td colspan="3">
						<%-- <label for="대표작/약력" >
							<input type="radio" name="histSe" value="1"  <c:if test="${result.histSe eq '1' }"> checked="checked"</c:if> /> 대표작
						</label>
						<label>
							<input type="radio" name="histSe" value="2"        <c:if test="${result.histSe eq '2' }"> checked="checked"</c:if> />약력
						</label> --%>

						<input type="text" name="histCn" title="멘토링분야" value="<c:out value='${result.histCn }'/>" style="width: 400px">

						</td>
					</tr>
					<tr>
						<th scope="row" for="mentoNm">멘티</th>
						<td colspan="3"><input  id="mentoNm"  name="mentoNm" class="w500" title="멘티" type="text" value="<c:out value='${result.mentoNm }' />"></td>
					</tr>
					<tr>
						<th scope="row" for="sortOrdr">순번</th>
						<td colspan="3"><select name="sortOrdr" title="순번">
								<option value="">순번선택</option>
								<c:forEach begin="1" end="30" varStatus="status">
									<option value="<c:out value='${status.count }'/>" <c:if test="${status.count eq result.sortOrdr}">selected='selected'</c:if>>${status.count}</option>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<th scope="row"><label for="useAt">사용여부</label></th>
						<td>
							<label>
								<input type="radio" name="useAt" id="useAt" value="Y" ${result.useAt eq 'Y' ?'checked':''} />
								사용
							</label>
							<label>
								<input type="radio" name="useAt" id="useAt" value="N" ${result.useAt eq 'N'?'checked':''} />
								미사용
							</label>
						</td>
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




