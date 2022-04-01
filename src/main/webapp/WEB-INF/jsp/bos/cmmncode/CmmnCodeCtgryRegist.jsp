<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="cmmnCode" staticJavascript="false" xhtml="true" cdata="false" />
<script type="text/javaScript" language="javascript">
	/* ********************************************************
	 * 목록 으로 가기
	 ******************************************************** */
	function fn_egov_list_CmmnCode() {
		location.href = "/bos/cmmncode/CmmnCodeCtgryList.do";
	}
	/* ********************************************************
	 * 저장처리화면
	 ******************************************************** */
	function fn_egov_regist_CmmnCode(form) {
		if (confirm("<spring:message code="common.save.msg" />")) {
			if (!validateCmmnCode(form)) {
				return;
			} else {
				form.submit();
			}
		}
	}

	var mode = "${empty result ? 'I' : 'M'}";
	var checkIdCount = 0;
	$(function() {

		$("#chkIdBtn").click(function() {
			var codeId = $("#codeId").val();
			if (!codeId) {
				alert("코드ID를 입력해 주세요.");
				$("#codeId")[0].focus();
				return;
			}
			$.getJSON("/bos/member/checkId.json", {
				codeId : codeId
			}, function(data) {
				if (data.cnt > 0) {
					alert("사용하실 수 없는 아이디입니다.");
					$("#userId").val("");
					checkIdCount = 0;
					return;
				} else {
					alert("사용가능한 아이디입니다.");
					checkIdCount++;
					return;
				}
			});
		});
	});
</script>
<form:form commandName="cmmnCode" name="cmmnCode" method="post">
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
					<th scope="row">분류코드명<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></th>
					<td>
						<form:select path="clCode" cssClass="select">
							<form:option value="">-분류코드명 선택-</form:option>
							<c:forEach var="result" items="${cmmnClCode}" varStatus="status">
								<form:option value="${result.clCode}">
									<c:out value="${result.clCodeNm}" />
								</form:option>
							</c:forEach>
						</form:select>
					</td>
				</tr>
				<%-- 
				<tr>
					<th scope="row">코드ID명<img src="/bos/images/common/required.gif" alt="필수" width="15" height="15"></th>
					<td>
						<form:input path="codeId" size="6" maxlength="6" style="width:200px" readonly="readonly" />
						<!--  <input type="button" id="chkIdBtn" name="chkIdBtn" value="중복확인" class="btn btn-inverse" /> -->
						<form:errors path="codeId" />
					</td>
				</tr>
				--%>
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
	<a class="btn btn-primary" href="javascript:fn_egov_regist_CmmnCode(document.cmmnCode);">
		<span>저장</span>
	</a>
	<a class="btn btn-primary" href="javascript:fn_egov_list_CmmnCode();">
		<span>목록</span>
	</a>
</div>

