<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<script type="text/javaScript" language="javascript">
	/* ********************************************************
	 * 목록 으로 가기
	 ******************************************************** */
	function fn_egov_list_CmmnClCode() {
		location.href = "/bos/cmmncode/CmmnCodeClList.do?menuNo=${param.menuNo}";
	}
	/* ********************************************************
	 * 저장처리화면
	 ******************************************************** */
	function fn_egov_regist_CmmnClCode() {
		var varFrom = document.cmmnClCode;
		var v = new MiyaValidator(varFrom);
		v.add("clCode", {
			required : true
		});
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}
		if (isInHangeul(varFrom.clCode.value)) {
			alert("한글은 허용하지 않습니다.");
			varFrom.authorCode.focus();
			return;
		}

		if (confirm("<spring:message code="common.save.msg" />")) {
			varFrom.submit();
		}
	}
	function isInHangeul(input_s) {
		var pattern = /[\u3131-\u314e|\u314f-\u3163|\uac00-\ud7a3]/g;
		return (pattern.test(input_s)) ? true : false;
	}
</script>

<form:form commandName="cmmnClCode" name="cmmnClCode" method="post">
	<input name="cmd" type="hidden" value="<c:out value='save'/>" />
	<div class="bdView">
		<table>
			<caption>게시판 쓰기</caption>
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="clCode">분류코드<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></label></th>
					<td>
						<form:input name="분류코드" path="clCode" size="3" maxlength="3" />
						<form:errors path="clCode" />
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="clCodeNm">분류코드명<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></label></th>
					<td>
						<form:input path="clCodeNm" size="60" maxlength="60" />
						<form:errors path="clCodeNm" />
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="clCodeNm">분류코드설명<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></label></th>
					<td>
						<form:textarea path="clCodeDc" rows="3" cols="60" />
						<form:errors path="clCodeDc" />
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="clCodeNm">사용여부<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></label></th>
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
	<a class="btn btn-primary" href="javascript:fn_egov_regist_CmmnClCode();">
		<span>등록</span>
	</a>
	<a class="btn btn-primary" href="javascript:fn_egov_list_CmmnClCode()">
		<span>목록</span>
	</a>
</div>

