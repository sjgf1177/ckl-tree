<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<script type="text/javascript">
//<![CDATA[

$(function(){
	$("#pwdSearchBtn").click(function(){

		var userId = $("#userId").val();
		var userNm = $("#userNm").val();
		var email = $("#email1").val()+"@"+$("#email2").val();
		var mbtlnum = $("#mbtlnum1").val()+"-"+$("#mbtlnum2").val()+"-"+$("#mbtlnum3").val();
		var returnTp = $(':radio[name="returnTp"]:checked').val();



		if (userNm == "") {
			alert("이름을 입력해 주세요.");
			$("#userNm").focus();
			return;
		}
		if (returnTp == "1") {
			if ($("#email1").val() == "" || $("#email2").val() == "") {
				alert("이메일을 입력해 주세요.");
				$("#email1").focus();
				return;
			}
		}
		else if (returnTp == "2") {
			if ($("#mbtlnum1").val() == "" || $("#mbtlnum2").val() == "" || $("#mbtlnum3").val() == "") {
				alert("휴대폰을 입력해 주세요.");
				$("#mbtlnum1").focus();
				return;
			}
		}
		if (userId == "") {
			alert("아이디를 입력해 주세요.");
			$("#userId").focus();
			return;
		}
		$.post(
			"/ckl/userMember/pwdSearchRequest.json",
			{userId : userId, userNm : userNm, email : email, mbtlnum : mbtlnum, returnTp: returnTp},
			function(data) {
				if (data.resultCode == "success") {
					alert(data.msg);
					location.reload();
				}
			},"json"
		);
		return;
	});

	$("input[name=returnTp]").click(function() {
		if ($(this).val() == "1") {
			$("#emailDiv").show();
			$("#mbtlnumDiv").hide();
		}
		else if ($(this).val() == "2") {
			$("#emailDiv").hide();
			$("#mbtlnumDiv").show();
		}
	});
});

//]]>
</script>

	<h2 class="msgXXL">가입 시 입력하신 인적사항을 입력해주시기 바랍니다.</h2>
	<p class="bull">비밀번호는 암호화 되어 있어 조회가 불가능하오니, 임시 비밀번호를 회원가입 시 인증받은 휴대폰 또는 메일 주소로 발송해드립니다.</p>
	<p class="bull">통합 전 기존 회원들은 등록된 <strong>메일로 발송</strong>됩니다.</p>

	<div>
		<h3>인적사항</h3>
		<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
		<div class="bdView">
			<table class="table table-bordered">
				<caption>인적사항 입력</caption>
				<colgroup>
				<col style="width:18%">
				<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="userNm"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 이름</label></th>
						<td><input type="text" name="userNm" id="userNm" value=""></td>
					</tr>
					<tr>
						<th scope="row">
							<span class="hide_star"><span class="sr-only">(필수입력)</span></span> 휴대폰 또는 이메일
						</th>
						<td>
							<label for="returnTp1"><input type="radio" name="returnTp" value="1" id="returnTp1" checked="checked"> 이메일 </label>
							<label for="returnTp2"><input type="radio" name="returnTp" value="2" id="returnTp2"> 휴대폰 </label>
							<span id="emailDiv">
								<input name="email1" id="email1" class="w20p" type="text" title="이메일 아이디" value="" />
								@
								<input name="email2" id="email2" class="w20p emaildomain_form" type="text" title="이메일 주소" value="" />
								<label for="sr_email_more" class="hidden">이메일 도메인 선택</label>
								<select id="sr_email_more" class="input_select select_email_js" style="width:auto" title="직접입력 선택시 자동활성화&amp;포커스 이동">
									<option selected="selected">메일주소선택</option>
									<option value="gmail.com">gmail.com</option>
									<option value="naver.com">naver.com</option>
				                    <option value="hanmail.net">hanmail.net</option>
				                    <option value="daum.net">daum.net</option>
				                    <option value="hotmail.com">hotmail.com</option>
				                    <option value="nate.com">nate.com</option>
				                    <option value="yahoo.co.kr">yahoo.co.kr</option>
									<option value="emaildomain_false">직접입력</option>
								</select>
								<script type="text/javascript">
								//<![CDATA[
								jQuery(function(){
									$('#email2').attr('readonly',true);
									$('select.select_email_js').change(function() {
										if ($(this).val()=='emaildomain_false') {
											$('#email2').val('');
											$('#email2').attr('readonly',false).focus();
										}
										else {
											$('#email2').val('');
											$('#email2').val($(this).val());
											$('#email2').attr('readonly',true);
										}
									});
								});
								//]]>
								</script>
							</span>
							<span id="mbtlnumDiv" style="display:none;">
								<select name="mbtlnum1" id="mbtlnum1" title="휴대폰 앞자리" >
									<option value="">선택</option>
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>
								-
								<input type="text" value="" id="mbtlnum2" name="mbtlnum2" class="w20p" title="휴대폰 중간자리를 입력하세요." maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
								-
								<input type="text" value="" id="mbtlnum3" name="mbtlnum3" class="w20p" title="휴대폰 끝자리를 입력하세요." maxlength="4" onkeyup="this.value=check_txt(this.value)"/>

								<input type="hidden" name="mbtlnum" id="mbtlnum" />
							</span>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<div>
		<h3>아이디</h3>
		<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
		<div class="bdView">
			<table class="table table-bordered">
				<caption>아이디 입력</caption>
				<colgroup>
				<col style="width:16%">
				<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="userId"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 아이디</label></th>
						<td>
							<input type="text" name="userId" id="userId" value="">
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<div class="btnSet tar">
		<a href="#self" id="pwdSearchBtn" class="btn btn-info">비밀번호 찾기</a>
	</div>



