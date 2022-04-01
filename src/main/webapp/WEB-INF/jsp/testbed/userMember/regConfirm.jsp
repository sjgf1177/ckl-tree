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

<!-- <h2 class="fs4">비밀번호를 입력해주시기 바랍니다.</h2> -->
<form action="/<c:out value="${paramVO.siteName }" />/userMember/forUpdate.do" method="post" name="pwdConfirmForm" id="pwdConfirmForm">
<div>
	<div class="tbrinfo text-danger clear hide_star_con no_margin"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
	<div class="bdView sub_board_body">
		<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
		<table class="contents_insight_view">
			<caption>비밀번호 입력</caption>
			<colgroup>
			<col style="width:18%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="chkPwd" class="red_star_text"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 비밀번호</label></th>
					<td>
						<span class="input_style_1_con">
							<input type="password" name="chkPwd" id="chkPwd" class="input_style_1" style="width:150px" value="">
						</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
</form>

<div class="board_util_btn_con">
	<a href="#self" id="pwdConfirmBtn" class="btn_style_0 full center short btn-info">비밀번호 확인</a>
</div>



