<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript">
//<![CDATA[

$(function(){

	$(".bdList").hide();

	$("#idSearchBtn").click(function(){
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

		$.post(
			"/edu/userMember/idSearchRequest.json",
			{userNm : userNm, email : email, mbtlnum : mbtlnum, returnTp: returnTp, mode : "m"},
			function(data) {
				var html = "";
				if (data.resultCode == "success") {
					$.each(data.idList, function(i, item) {
						html += getIdListHtml(item.rnum, item.userId, item.sbscrbDt);
					});
				}
				else {
					html = '<tr><td colspan="3">해당 정보로 조회된 아이디가 없습니다.</td></tr>';
				}
				$(".bdList").show();
				$("#idList").html(html);
			},"json"
		);
		return;
	});

	getIdListHtml = function(rnum, userId, sbscrbDt) {
		var html =
			'<tr><td>'+rnum+'</td>'+
			'<td>'+userId+'</td>'+
			'<td>'+sbscrbDt+'</td></tr>';
		return html;
	};

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

function check_txt(value) {
    if (isNaN(value)) {
		alert("숫자로만 입력하셔야 합니다.");
		return "";
	}
    else {
    	//return value;
    }
}

//]]>
</script>

<h2 class="fs4">가입 시 입력하신 인적사항을 입력해주시기 바랍니다.</h2>
<div>
	<h3>인적사항</h3>
	<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>인적사항 입력</caption>
			<colgroup>
			<col style="width:16%">
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
							<input type="text" value="" id="mbtlnum2" name="mbtlnum2" class="w20p" title="휴대폰 중간자리를 입력하세요." maxlength="4" onkeyup="check_txt(this.value)"/>
							-
							<input type="text" value="" id="mbtlnum3" name="mbtlnum3" class="w20p" title="휴대폰 끝자리를 입력하세요." maxlength="4" onkeyup="check_txt(this.value)"/>

							<input type="hidden" name="mbtlnum" id="mbtlnum" />
						</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<div class="btnSet tar">
	<a href="#self" id="idSearchBtn" class="btn btn-info">아이디 찾기</a>
</div>

<div class="bdList" >
<h3>입력하신 정보로 조회된 아이디입니다. </h3>

	<table class="table tac">
		<caption>아이디 목록</caption>
		<colgroup>
		<col style="width:10%;">
		<col>
		<col style="width:20%;">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">아이디</th>
				<th scope="col">가입일시</th>
			</tr>
		</thead>
		<tbody id="idList"></tbody>
		<%--
			<c:forEach var="val" items="${idList}" varStatus="status">
				<tr>
					<td>1</td>
					<td class="tal"><c:out value="${val.userId}"/></td>
					<td>2015-07-01 14:00</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(idList) == 0}"><tr><td colspan="3">해당 정보로 조회된 아이디가 없습니다.</td></tr></c:if>
		</tbody> --%>
	</table>

<div class="btnSet tar">
	<a href="/edu/userMember/pwdSearch.do?menuNo=500084" class="btn btn-info">비밀번호 찾기</a>
</div>
</div>


