<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
//<![CDATA[

	$(function() {

		secsnRequest = function() {
			if (!checkPwd0Fc()) {
				alert("기존 비밀번호가 일치하지 않습니다.");
				$("#password0").focus();
				return;
			}
			if (!confirm("탈퇴 하시겠습니까?")) {
				return;
			}

			$.post(
				"/edumobile/userMember/secsnRequest.json",
				{userSn : "<c:out value='${user.userIdx}'/>", userId : "<c:out value='${user.userId}'/>"},
				function(data) {
					if (data.resultCode == "success") {
						alert("탈퇴되었습니다. 이용해주셔서 대단히 감사합니다.");
						logoutSSO();
					}
				},"json"
			);
		};

	});

	function checkPwd0Fc() {
		$.ajaxSetup({
			async: false
		});
		var flag = true;

		$.post(
			"/edumobile/userMember/pwdCheck.json",
			{userSn : "<c:out value='${user.userIdx}'/>", password : $("#password0").val()},
			function(data) {
				if (data.resultCode == "success") {
					flag = true;
				}
				else {
					flag = false;
				}
			},"json"
		);

		return flag;
	}

//]]>
</script>


	<h3 class="mt30">회원 탈퇴를 하시기 전에 다음의 내용을 꼭 확인해주시기 바랍니다.</h3>
	<div class="alert mt30 mb20">
		<ul class="bull">
			<li>회원탈퇴 시 회원정보는 즉시 삭제됩니다. </li>
			<li>탈퇴하셔도 회원님께서 작성하신 게시글 / 문의 / 신청 글은 삭제되지 않습니다. </li>
		</ul>
	</div>

	<fieldset>
		<legend>회원탈퇴 정보 입력</legend>
			<div>
				<h3>확인</h3>
				<div class="tbrinfo text-danger clear hide_star_con"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
				<div class="bdView sub_board_body">
					<table class="contents_insight_view">
						<caption>
						(콘텐츠아카데미) 아이디, (필수입력) 기존 비밀번호 정보를 포함하는 표
						</caption>>
						<colgroup>
						<col style="width:20%">
						<col>
						</colgroup> 
						<tbody>
							<tr>
								<th scope="row"><span class="red_star_text">아이디</span></th>
								<td><c:out value="${user.userId}"/></td>
							</tr>
							<tr>
								<th scope="row"><label for="password0" class="red_star_text"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 기존 비밀번호</label></th>
								<td>
									<span class="input_style_1_con">
										<input type="password" name="password0" id="password0" class="input_style_1" style="width:150px" value="">
									</span>

								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="board_util_btn_con">
				<a href="javascript:secsnRequest();" class="btn_style_0 full check">탈퇴</a>
			</div>
	</fieldset>
