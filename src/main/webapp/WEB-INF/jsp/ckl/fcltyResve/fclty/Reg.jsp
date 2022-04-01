<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${empty result}">
	<c:set var="action" value="/edu/bbs/${paramVO.bbsId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/edu/bbs/${paramVO.bbsId}/update.do" />
</c:if>

<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript">

	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);

	    v.add("option1", {
	        required: true
	    });
	    v.add("nttSj", {
	        required: true
	    });
	    v.add("ntcrNm", {
	        required: true
	    });
	    v.add("secret", {
	        required: true
	    });
	    v.add("nttCn", {
	        required: true
	    });

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (!confirm("${empty result ? '등록' : '수정'}하시겠습니까?")) {
			return;
		}

		form.submit();
	}

	function del(){
		var form = $("#board")[0];
		form.action = "/edu/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	}

</script>

<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
<input type="hidden" name="ntcrTel" value="<c:out value='${user.moblphon}'/>"/>
<input type="hidden" name="ntcrEmail" value="<c:out value='${user.email}'/>"/>
<input type="hidden" name="nttId" value="<c:out value='${empty result.nttId ? 0 : result.nttId}'/>" />
<input type="hidden" name="bbsId" value="<c:out value='${masterVO.bbsId}'/>" />
<input type="hidden" id="atchFileId" name="atchFileId" value="<c:out value='${result.atchFileId}'/>">
<input type="hidden" name="htmlAt" value="${empty result ? 'N' : result.htmlAt }" />
<input type="hidden" name="option20" value="${user.userId }" />
<input type="hidden" name="myAt" value="${param.myAt}" />
	<div class="bdView">

		<table class="table table-bordered">
			<caption>문의하기 입력</caption>
			<colgroup>
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="option1"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 질문분류</label></th>
					<td>
						<select name="option1" id="option1">
							<option value="">분야선택</option>
							<option value="01" <c:if test="${result.option1 eq '01'}">selected="selected"</c:if>>현장교육</option>
							<option value="02" <c:if test="${result.option1 eq '02'}">selected="selected"</c:if>>온라인교육</option>
							<option value="03" <c:if test="${result.option1 eq '03'}">selected="selected"</c:if>>창의인재동반</option>
							<option value="04" <c:if test="${result.option1 eq '04'}">selected="selected"</c:if>>취업정보</option>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="nttSj"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 제목</label></th>
					<td><input type="text" name="nttSj" id="nttSj" value="<c:out value='${result.nttSj}'/>" class="w50p"></td>
				</tr>
				<tr>
					<th scope="row"><label for="ntcrNm"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 작성자</label></th>
					<td><input type="text" name="ntcrNm" id="ntcrNm" value="<c:out value='${empty result ? user.userNm : result.ntcrNm}'/>"></td>
				</tr>
				<tr>
					<th scope="row"><label for="secret1"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 공개여부</label></th>
					<td>
						<input type="radio" name="secret" id="secret1" value="N" <c:if test="${result.secret eq 'N'}">checked="checked"</c:if>><label for="secret1">공개</label>
						<input type="radio" name="secret" id="secret2" value="Y" <c:if test="${result.secret eq 'Y'}">checked="checked"</c:if>><label for="secret2">비공개</label>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="nttCn"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 내용</label></th>
					<td>
						<textarea name="nttCn" id="nttCn" cols="120" rows="12" class="col-md-12" onfocus="if(this.value=='텍스트를 입력하세요.')this.value='';" onkeyup="if(this.value=='텍스트를 입력하세요.')this.value='';" title="텍스트를 입력하세요.">${result.nttCn}</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row">첨부된 파일</th>
					<td>
						<jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" />
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
			</tbody>
		</table>
	</div>
</form>

<div class="btnSet tac">
	<a href="javascript:checkForm();" class="btn btn-primary">저장</a>
	<a href="#" onclick="javascript:history.back(0);return false;" class="btn btn-primary">취소</a>
	<c:if test="${not empty result}" >
		<a href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');" class="btn btn-danger" >삭제</a>
	</c:if>
</div>

