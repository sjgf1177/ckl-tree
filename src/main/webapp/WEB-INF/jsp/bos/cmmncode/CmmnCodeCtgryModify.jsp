<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="cmmnCode" staticJavascript="false" xhtml="true" cdata="false" />
<script type="text/javaScript">
<!--
	/* ********************************************************
	 * 목록 으로 가기
	 ******************************************************** */
	function fn_egov_list_CmmnCode() {
		location.href = "/bos/cmmncode/CmmnCodeCtgryList.do";
	}
	/* ********************************************************
	 * 저장처리화면
	 ******************************************************** */
	function fn_egov_modify_CmmnCode(form) {
		if (confirm("<spring:message code="common.save.msg" />")) {
			if (!validateCmmnCode(form)) {
				return;
			} else {
				form.submit();
			}
		}
	}
//-->
</script>

<form:form commandName="cmmnCode" name="cmmnCode" method="post">
	<input name="cmd" type="hidden" value="Modify">
	<form:hidden path="clCode" />
	<form:hidden path="codeId" />
	<div class="bdView">
		<table>
			<caption>게시판 쓰기</caption>
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">분류코드명<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></th>
					<td>${cmmnCode.clCodeNm}</td>
				</tr>
				<tr>
					<th scope="row">코드ID<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></th>
					<td>${cmmnCode.codeId}</td>
				</tr>
				<tr>
					<th scope="row">코드카테고리명<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></th>
					<td>
						<form:input path="codeIdNm" size="60" maxlength="60" />
						<form:errors path="codeIdNm" />
					</td>
				</tr>
				<tr>
					<th scope="row">코드ID설명<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></th>
					<td>
						<form:textarea path="codeIdDc" rows="3" cols="60" />
						<form:errors path="codeIdDc" />
					</td>
				</tr>
				<tr>
					<th scope="row">사용여부<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></th>
					<td>
						<form:select path="useAt">
							<form:option value="Y" label="Yes" />
							<form:option value="N" label="No" />
						</form:select>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</form:form>

<div class="btn_set">
	<a class="btn btn-primary" href="javascript:fn_egov_modify_CmmnCode(document.cmmnCode);">
		<span>저장</span>
	</a>
	<a class="btn btn-primary" href="javascript:fn_egov_list_CmmnCode();">
		<span>목록</span>
	</a>
</div>

