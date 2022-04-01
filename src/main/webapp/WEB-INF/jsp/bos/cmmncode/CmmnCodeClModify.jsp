<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="cmmnClCode" staticJavascript="false" xhtml="true" cdata="false" />
<script type="text/javaScript" language="javascript">
<!--
	/* ********************************************************
	 * 목록 으로 가기
	 ******************************************************** */
	function fn_egov_list_CmmnClCode() {
		location.href = "/bos/cmmncode/CmmnCodeClList.do?menuNo=${param.menuNo}";
	}
	/* ********************************************************
	 * 저장처리화면
	 ******************************************************** */
	function fn_egov_modify_CmmnClCode(form) {
		if (confirm("<spring:message code="common.save.msg" />")) {
			if (!validateCmmnClCode(form)) {
				return;
			} else {
				form.submit();
			}
		}
	}
	-->
</script>

<form:form commandName="cmmnClCode" name="cmmnClCode" method="post">
	<input name="cmd" type="hidden" value="Modify">
	<form:hidden path="clCode" />

	<div class="bdView">
		<table>
			<caption>게시판 쓰기</caption>
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<tbody>
				<tr>
					<th width="20%" height="23" class="required_text" nowrap>분류코드<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></th>
					<td width="80%" nowrap colspan="3">${cmmnClCode.clCode}</td>
				</tr>
				<tr>
					<th width="20%" height="23" class="required_text" nowrap>분류코드명<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></th>
					<td width="80%" nowrap>
						<form:input path="clCodeNm" size="60" maxlength="60" />
						<form:errors path="clCodeNm" />

					</td>
				</tr>
				<tr>
					<th height="23" class="required_text">분류코드설명<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></th>
					<td>
						<form:textarea path="clCodeDc" rows="3" cols="60" />
						<form:errors path="clCodeDc" />
					</td>
				</tr>
				<tr>
					<th width="20%" height="23" class="required_text" nowrap>사용여부<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></th>
					<td width="30%" nowrap class="title_left" colspan="3">
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
	<a class="btn btn-primary" href="JavaScript:fn_egov_modify_CmmnClCode(document.cmmnClCode);">
		<span>저장</span>
	</a>
	<a class="btn btn-primary" href="javascript:fn_egov_list_CmmnClCode()">
		<span>목록</span>
	</a>
</div>

