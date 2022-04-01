<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInit(){
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fnList(){
	location.href = "/bos/cmmncode/CmmnCodeClList.do?menuNo=${param.menuNo}";
}
/* ********************************************************
 * 수정화면으로  바로가기
 ******************************************************** */
function fnModify(){
	var varForm				 = document.all["Form"];
	varForm.action           = "<c:url value='/bos/cmmncode/CmmnCodeClModify.do?menuNo=${param.menuNo}'/>";
	varForm.clCode.value     = "${result.clCode}";
	varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
	if (confirm("<spring:message code="common.delete.msg" />")) {
		var varForm				 = document.all["Form"];
		varForm.action           = "<c:url value='/bos/cmmncode/CmmnCodeClRemove.do?menuNo=${param.menuNo}'/>";
		varForm.clCode.value     = "${result.clCode}";
		varForm.submit();
	}
}
//-->
</script>

	<form name="Form" action="" method="post">
		<input name="clCode" type="hidden">
		<input name="cmd" type="hidden">
	</form>
	<div class="bdView">
		<table class="row-fluid">
			<caption>게시판 쓰기</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">분류코드<img src="/bos/images/common/required.gif" alt="필수"  width="15" height="15"></th>
					<td>
						${result.clCode}
					</td>
				</tr>
				<tr>
					<th scope="row">분류코드명<img src="/bos/images/common/required.gif" alt="필수"  width="15" height="15"></th>
					<td>
						${result.clCodeNm}
					</td>
				</tr>
				<tr>
					<th scope="row">분류코드설명<img src="/bos/images/common/required.gif" alt="필수"  width="15" height="15"></th>
					<td>
						<textarea class="textarea span12"  cols="75" rows="14" disabled="true">${result.clCodeDc}</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row">사용여부<img src="/bos/images/common/required.gif" alt="필수"  width="15" height="15"></th>
					<td>
						<select name="useAt" disabled="true">
							<option value="Y" <c:if test="${result.useAt == 'Y'}">selected="selected"</c:if> >Yes</option>
							<option value="N" <c:if test="${result.useAt == 'N'}">selected="selected"</c:if> >No</option>
						</select>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:fnModify();"><span>수정</span></a>
		<a class="btn btn-danger" href="javascript:fnDelete();" onclick="return confirm('정말로 삭제하시겠습니까?')"><span>삭제</span></a>
		<a class="btn btn-primary" href="javascript:fnList();"><span>목록</span></a>
	</div>
