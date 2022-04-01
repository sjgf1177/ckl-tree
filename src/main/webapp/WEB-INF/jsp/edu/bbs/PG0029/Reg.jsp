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


<div class="col-12 sub_board_header">
	<ul class="list_style_2">
		<li>
			명예훼손, 욕설 및 저속한 표현, 근거없는 비방 등 기타 불건전한 내용을 담고 있을 경우 내용에 상관없이 삭제됩니다.<br/>
			아울러 개인정보가 불법적으로 이용되는 것을 막기 위해 이용자께서는 e-메일, 주소, 주민번호, 전화번호 등<br/>
			개인정보에 관한 사항을 게시하는 것을 주의하시기 바랍니다.
		</li>
	</ul>
</div>

<div class="col-12 sub_board_body">
	<p class="board_caption">
		<span>
		표시는 필수입력 항목입니다.
		</span>
	</p>
	<table class="board_type_1">
	<caption>qna 등록 게시판입니다.</caption>
	<colgroup>
		<col width="auto" class="board_header_column">
		<col width="auto">
	</colgroup>
	<tbody>
	<tr>
		<th>
			<span>작성자</span>
		</th>
		<td>
			<span class="board_type_1_input_con">
				<input type="text" class="input_style_0" name="ntcrNm" id="ntcrNm" value="<c:out value='${empty result ? user.userNm : result.ntcrNm}'/>" placeholder="홍길동" title="이름을 입력해 주세요">
				<!-- <label for="ntcrNm"></label> -->
			</span>
		</td>
	</tr>
	<tr>
		<th>
			<span>공개여부</span>
		</th>
		<td>
			<span class="radio_box_con">
				<input type="radio" class="radio_style_0" name="secret" id="secret1" value="N" <c:if test="${result.secret eq 'N'}">checked="checked"</c:if>>
				<label for="secret1">공개</label>
			</span>
			<span class="radio_box_con">
				<input type="radio" class="radio_style_0" name="secret" id="secret2" value="Y" <c:if test="${result.secret eq 'Y' or empty result.secret}">checked="checked"</c:if>>
				<label for="secret2">비공개</label>
			</span>
		</td>
	</tr>
	<tr>
		<th>
			<span>질문분류</span>
		</th>
		<td>
			<span class="board_type_1_select_con">
				<select name="request_type" id="request_type" class="select_style_1" title="질문하려는 분야를 선택해 주세요">
					<option value="01" <c:if test="${result.option1 eq '01'}">selected="selected"</c:if>>현장교육</option>
					<option value="02" <c:if test="${result.option1 eq '02'}">selected="selected"</c:if>>온라인교육</option>
					<option value="03" <c:if test="${result.option1 eq '03'}">selected="selected"</c:if>>창의인재동반</option>
					<option value="04" <c:if test="${result.option1 eq '04'}">selected="selected"</c:if>>취업정보</option>
				</select>
				<!-- <label for="request_type"></label> -->
			</span>
		</td>
	</tr>
	<tr>
		<th>
			<span>제목</span>
		</th>
		<td>
			<span class="board_type_1_input_con">
				<input type="text" name="nttSj" id="nttSj" value="<c:out value='${result.nttSj}'/>" class="input_style_0"  placeholder="파이널 입문과정" title="제목을 입력해 주세요">
				<!-- <label for="nttSj"></label> -->
			</span>
		</td>
	</tr>
	<tr>
		<th>
			<span>내용</span>
		</th>
		<td>
			<span class="board_type_1_textarea_con">
				<textarea name="nttCn" id="nttCn" cols="30" rows="10" onfocus="if(this.value=='텍스트를 입력하세요.')this.value='';" onkeyup="if(this.value=='텍스트를 입력하세요.')this.value='';" title="텍스트를 입력하세요." placeholder="플러그인이 지원되지 않습니다&#13;&#10;확인부탁드립니다&#13;&#10;010.6497.4024">${result.nttCn}</textarea>
				<!-- <label for="nttCn"></label> -->
			</span>
		</td>
	</tr>
		<tr>
			<th>
				<span>첨부파일</span>
			</th>
			<td>
				<div>첨부된 파일</div>
				<jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" />
			</td>

			<c:if test="${not empty result.atchFileId}">
			<td>
				<div>첨부파일</div>
				<jsp:include page="/WEB-INF/jsp/bos/share/EgovFileList.jsp" flush="true" />
			</td>
			</c:if>
			<!--<td>
				<a href="javascript:void(0)" class="upload_file_add_row_btn">
				첨부파일추가
				</a>
				<div class="upload_file_add_row_con">
					<div class="upload_file_row">
						<span class="board_type_1_input_file_con">
							<input type="file" id="request_upload_file_select" class="input_file_style_0">
							<label for="request_upload_file_select">파일선택</label>
						</span>
						<span class="board_type_1_input_con file_name">
							<input type="text" id="request_upload_file_name" class="input_style_0" placeholder="1234567890.jpg" readonly>
							<label for="request_upload_file_name"></label>
						</span>
						<a href="javascript:void(0)" class="upload_file_delete_btn"></a>
					</div>
				</div>
			</td>-->
		</tr>
	</tbody>
	</table>

	<div class="btnSet tac">
		<a href="javascript:checkForm();" class="btn btn-primary">저장</a>
		<a href="javascript:void(0);" onclick="javascript:history.back(0);return false;" class="btn btn-primary">취소</a>
		<c:if test="${not empty result}" >
			<a href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');" class="btn btn-danger" >삭제</a>
		</c:if>
	</div>

</div>

</form>

