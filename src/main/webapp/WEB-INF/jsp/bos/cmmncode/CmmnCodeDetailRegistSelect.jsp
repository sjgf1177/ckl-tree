<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="cmmnDetailCode" staticJavascript="false" xhtml="true" cdata="false" />
<script type="text/javaScript" language="javascript">
<!--
	/* ********************************************************
	 * 목록 으로 가기
	 ******************************************************** */
	function fn_egov_list_CmmnDetailCode() {
		location.href = "/bos/cmmncode/CmmnCodeDetailList.do?menuNo=${param.menuNo}";
	}
	/* ********************************************************
	 * 저장처리화면
	 ******************************************************** */
	function fn_egov_regist_CmmnDetailCode(form) {
		if (confirm("<spring:message code="common.save.msg" />")) {
			if (!validateCmmnDetailCode(form)) {
				return;
			} else {
				form.cmd.value = "Regist";
				form.submit();
			}
		}
	}
	/* ********************************************************
	 * CodeId 가져오기
	 ******************************************************** */
	function fn_egov_get_CodeId(form) {
		form.cmd.value = "";
		form.submit();
	}
	-->
</script>

<form:form commandName="cmmnDetailCode" name="cmmnDetailCode" method="post">
	<input name="cmd" type="hidden" value="<c:out value='Regist'/>" />
	<div class="bdView">
		<table>
			<caption>게시판 쓰기</caption>
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">코드ID<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></label></th>
					<td>
						<select name="clCode" class="select" onChange="javascript:fn_egov_get_CodeId(document.cmmnDetailCode)">
							<option value='PLC'><spring:message code='site.korName' text='' /></option>
						</select> <select name="codeId" class="select">
							<option value='COM080'>공모작품갤러리대회별</option>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row">코드<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></label></th>
					<td>
						<form:input path="code" size="15" maxlength="15" />
						<form:errors path="code" />
					</td>
				</tr>
				<tr>
					<th scope="row">코드명<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></label></th>
					<td>
						<form:input path="codeNm" size="60" maxlength="60" />
						<form:errors path="codeNm" />
					</td>
				</tr>
				<tr>
					<th scope="row">코드설명<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></label></th>
					<td>
						<form:textarea path="codeDc" rows="3" cols="60" />
						<form:errors path="codeDc" />
					</td>
				</tr>
				<tr>
					<th scope="row">사용여부<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></label></th>
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
	<a class="btn btn-primary" href="javascript:fn_egov_regist_CmmnDetailCode(document.cmmnDetailCode);">
		<span>등록</span>
	</a>
	<a class="btn btn-primary" href="javascript:fn_egov_list_CmmnDetailCode();">
		<span>목록</span>
	</a>
</div>

