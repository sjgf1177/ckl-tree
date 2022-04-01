<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util"%>
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
<div>
	<c:if test="${param.contest eq 'Y'}">코드명 입력하시고 등록버튼 누르시면 됩니다.</c:if>
</div>
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
						<c:choose>
							<c:when test="${param.contest eq 'Y'}">
								<select name="clCode" class="select" onChange="javascript:fn_egov_get_CodeId(document.cmmnDetailCode)">
									<option value='PLC'><spring:message code='site.korName' text='' /></option>
								</select>
								<select name="codeId" class="select">
									<option value='COM080'>공모작품갤러리대회별</option>
								</select>
							</c:when>
							<c:otherwise>
								<select name="clCode" class="select" onChange="javascript:fn_egov_get_CodeId(document.cmmnDetailCode)">
									<c:forEach var="result" items="${cmmnClCodeList}" varStatus="status">
										<option value='<c:out value="${result.clCode}"/>' <c:if test="${result.clCode == cmmnCode.clCode}">selected="selected"</c:if>><c:out value="${result.clCodeNm}" /></option>
									</c:forEach>
								</select>
								<select name="codeId" class="select">
									<c:forEach var="result" items="${cmmnCodeList}" varStatus="status">
										<option value='<c:out value="${result.codeId}"/>' <c:if test="${result.codeId == cmmnCode.codeId}">selected="selected"</c:if>><c:out value="${result.codeIdNm}" /></option>
									</c:forEach>
								</select>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row">코드<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></label></th>
					<td>
						<c:choose>
							<c:when test="${param.contest eq 'Y'}">
								<c:set var="codeMaxValue">
									<util:fz source='${COM080Max}' resultLen='2' isFront='true' />
								</c:set>
								<form:input path="code" size="15" maxlength="15" value="${codeMaxValue}" />
								<form:errors path="code" />
							</c:when>
							<c:otherwise>
								<form:input path="code" size="15" maxlength="15" />
								<form:errors path="code" />
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row">코드명<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></label></th>
					<td>
						<form:input path="codeNm" size="60" maxlength="60" />
						<form:errors path="codeNm" />
					</td>
				</tr>
				<c:if test="${param.contest ne 'Y' }">
					<tr>
						<th scope="row">코드설명<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></label></th>
						<td>
							<form:textarea path="codeDc" rows="3" cols="60" />
							<form:errors path="codeDc" />
						</td>
					</tr>
				</c:if>
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

