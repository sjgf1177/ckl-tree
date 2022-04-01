<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript">
//<![CDATA[

$(function(){

	$("#pwdConfirmBtn").click(function(){

		if ($("#chkPwd").val() == "") {
			alert("비밀번호를 입력해 주세요.");
			$("#password").focus();
			return;
		}

		$("#pwdConfirmForm").submit();
		return false;
	});


});

//]]>
</script>

<h2 class="fs4">비밀번호를 입력해주시기 바랍니다.</h2>
<div>
	<h3>비밀번호 확인</h3>
	<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
	<div class="bdView">
	<form action="/<c:out value="${paramVO.siteName }" />/userMember/forUpdate.do" method="post" name="pwdConfirmForm" id="pwdConfirmForm">
		<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
		<table class="table table-bordered">
			<caption>비밀번호 입력</caption>
			<colgroup>
			<col style="width:18%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="chkPwd"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 비밀번호</label></th>
					<td><input type="password" name="chkPwd" id="chkPwd" value=""></td>
				</tr>
			</tbody>
		</table>
	</form>
	</div>
</div>

<div class="btnSet tar">
	<a href="#self" id="pwdConfirmBtn" class="btn btn-info">비밀번호 확인</a>
</div>



