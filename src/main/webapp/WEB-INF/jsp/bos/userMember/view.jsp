<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
var brthdy = "";
var email = "";
var mbtlnum = "";
$(function(){
	brthdy = $("#brthdy").text();
	$("#brthdy").text($("#brthdy").text().replace(/\d/g,"*"));
	email = $("#email").text();
	$("#email").text($("#email").text().replace(/[a-z|A-Z|0-9]/g,"*"));
	mbtlnum = $("#mbtlnum").text();
	$("#mbtlnum").text($("#mbtlnum").text().replace(/\d/g,"*"));

	$(".viewIndvdInfo").click(function() {
		if ("#brthdy" == $(this).attr("href")) {
			$("#brthdy").text(brthdy);
		}
		else if ("#email" == $(this).attr("href")) {
			$("#email").text(email);
		}
		else if ("#mbtlnum" == $(this).attr("href")) {
			$("#mbtlnum").text(mbtlnum);
		}
		return false;
	});


	$("#pwdInitl").click(function(){
		var mbtlnum = "${result.mbtlnum}";
		var telno = "";
		if (!confirm('비밀번호를 초기화 하시겠습니까?\n[휴대폰번호 뒷번호로 초기화 됩니다.]')) {
			return false;
		}
		if (mbtlnum == "") {
			alert("등론된 휴대폰번호가 없습니다.");
			return false;
		}
		else {
			telno = mbtlnum.split("-")[2];
		}
		$.post(
			"/bos/userMember/pwdInitl.json",
			{userSn : "${result.userSn}", telno : telno, userId : "${result.userId}"},
			function(data)
			{
				var resultCode = data.resultCode;
				alert("휴대폰 뒷번호로 초기화 되었습니다.");
				if(resultCode == "success") location.reload();
			},"json"
		)
	});

	$(".trmnatBtn").click(function() {
		var userSn = $(this).attr("data-userSn");
		var authSe = $(this).attr("data-authSe");
		if (confirm("연결을 해지하시겠습니까?")) {
			var url = "/bos/userMember/snsTrmnat.json";
			var params = {
				userSn : authSe,
				authSe : authSe
			}
			$.post(url, params ,function(data) {
				if (data.resultCode == "success") {
					alert("연결이 해지되었습니다.");
					window.location.reload();
				}
				else {
					alert("연결이 해지가 실패했습니다.");
				}
			},"json");
		}
		return false;
	});

	$("#failrBtn").click(function() {
		if (confirm("아이디 잠김을 해제하시겠습니까?")) {
			var url = "/bos/userMember/pwdUnlocking.json";
			var params = {
				userId : '${result.userId}', gubun : 'Y'
			}
			$.post(url, params ,function(data) {
				if (data.resultCode == "success") {
					alert("아이디 잠김해제되었습니다.");
					window.location.reload();
				}
				else {
					alert("해제가 실패했습니다.");
				}
			},"json");
		}
		return false;
	});

});

	function delUser(){
		var form = document.f_regi;
		if (confirm("정말로 삭제하시겠습니까?")) {
			form.action="/bos/userMember/delete.do";
			form.submit();
		}
	}

</script>
<ccc:constantsMap className="kr.co.unp.member.service.UserMemberService" var="UserMemberService"/>

<form name="f_regi" method="post" action="#" enctype="multipart/form-data">
	<input type="hidden" name="userSn" value="${result.userSn}">
	<input type=hidden name="pageQueryString" value='${pageQueryString}'>

	<h4>인적사항</h4>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
			<col style="width:15%" />
			<col  />
			</colgroup>
			<tbody>
				<tr>
					<th>이름</th>
					<td>${result.userNm}</td>
				</tr>
				<tr>
					<th>생년월일/ 성별</th>
					<td><span id="brthdy"><fmt:formatDate value="${result.brthdy }" pattern="yyyy-MM-dd"/></span><a href="#brthdy" class="viewIndvdInfo">[정보확인]</a>  /
					<c:choose>
						<c:when test="${result.sex eq 'W'}">
							여자
						</c:when>
						<c:when test="${result.sex eq 'M' }">
							남자
						</c:when>
					</c:choose>
 					</td>
				</tr>
			</tbody>
		</table>
	</div>


	<h4>로그인 정보</h4>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
			<col style="width:15%" />
			<col  />
			</colgroup>
			<tbody>
				<tr>
					<th>아이디</th>
					<td>${result.userId}</td>
				</tr>
				<tr>
					<th>최종접속일시 / 아이피</th>
					<td>${result.lastLoginDt}, ${result.drmncyCnvrsDt } 휴면회원 전환 예정/${result.userIp}</td>
				</tr>
				<tr>
					<th>비밀번호    최종 변경일시</th>
					<td>${result.pwdChangeDt}, ${result.pwdChangePrearngeDt } 안내 메일 발송 예정</td>
				</tr>
				<tr>
					<th>개인정보처리방침 동의 일시</th>
					<td>${result.agreDt}, ${result.reAgreDt} 재동의 예정</td>
				</tr>
				<tr>
					<th>가입일시 </th>
					<td>${result.sbscrbDt} </td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="bdView">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
				<col style="width:15%" />
				<col  />
			</colgroup>
			<tbody>
				<tr>
					<th>가입 인증구분</th>
					<td><c:out value="${result.authSeNm }" /> <c:out value="${result.authDt }" /> 인증</td>
				</tr>
			</tbody>
		</table>
	</div>

	<h4>간편로그인 설정</h4>
		<div class="bdView">
			<table class="table table-bordered">
				<caption>
				</caption>
				<colgroup>
				<col>
				<col>
				<col>
				</colgroup>
				<thead>
					<tr>
						<th>서비스</th>
						<th>연결하기&nbsp;</th>
						<th>연결 해지</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="simpleVO" items="${simpleList }" varStatus="status">
					<tr>
						<td>
						<c:choose>
							<c:when test="${simpleVO.code eq '03' }">
								<img src="/bos/images/ico_naver.gif" width="77" height="33" alt="네이버" />
							</c:when>
							<c:when test="${simpleVO.code eq '01' }">
								<img src="/bos/images/ico_kakao.gif" width="88" height="34" alt="카카오" />
							</c:when>
							<c:when test="${simpleVO.code eq '04' }">
								<img src="/bos/images/ico_facebook.gif" width="85" height="39" alt="페이스북">
							</c:when>
							<c:when test="${simpleVO.code eq '02' }">
								<img src="/bos/images/ico_google.gif" width="65" height="29" alt="구글" />
							</c:when>
						</c:choose>
						</td>
						<td>
						<c:if test="${not empty simpleVO.authKey }">
							${simpleVO.authDt } 연결완료
						</c:if>
						</td>
						<td>
						<c:if test="${not empty simpleVO.authKey }">
							<a class="btn btn-default btn-sm trmnatBtn" data-userSn="${simpleVO.userSn }" data-authSe="${simpleVO.authSe }" href="#self"><span>해지</span></a>
						</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>

		<h4>추가 회원 정보</h4>
		<div class="bdView">
			<table class="table table-bordered">
				<caption>추가 회원 정보</caption>
				<colgroup>
				<col style="width:15%" />
				<col  />
				</colgroup>
				<tbody>
					<tr>
						<th>이메일</th>
						<td>
							<span id="email">${result.email}</span><a href="#email" class="viewIndvdInfo">[정보확인]</a>
							<c:if test="${result.authSe eq '01'}">[인증됨 ${result.authDt}]</c:if>

						</td>
					</tr>
					<tr>
						<th>휴대폰</th>
						<td>
							<span id="mbtlnum">${result.mbtlnum}</span><a href="#mbtlnum" class="viewIndvdInfo">[정보확인]</a>
							<c:if test="${result.authSe eq '02'}">[인증됨 ${result.authDt}]</c:if>
						</td>
					</tr>
					<tr>
						<th>정보수신 여부</th>
						<td>${result.emailAt eq 'Y' ? 'Email' : ''}${result.emailAt eq 'Y' and result.smsAt eq 'Y' ? ' ,' : ''} ${result.smsAt eq 'Y' ? 'SMS' : ''}</td>
					</tr>
					<tr>
						<th>거주지</th>
						<td>
							<c:choose>
								<c:when test="${result.resdncSe eq '02'}">${result.resdncOvsea}</c:when>
								<c:otherwise>
									<c:forEach var="code" items="${COM063CodeList}">
										<c:if test="${result.sido eq code.code}"><c:out value="${code.codeNm}"/></c:if>
									</c:forEach>
									<c:forEach var="code" items="${COM063CodeList}">
										<c:if test="${result.gugun eq code.code}"><c:out value="${code.codeNm}"/></c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th>직업</th>
						<td>${result.jobNm}</td>
					</tr>
				</tbody>
			</table>
		</div>

</form>

<div class="row clear mt20">
	<div class="col-md-11 tac">
	<c:if test="${result.failrCnt >= 5}">
		<a href="#" id="failrBtn" class="btn btn-primary">잠김해제</a>
	</c:if>
		<a href="/bos/userMember/forUpdate.do?userSn=${result.userSn}&${pageQueryString}" class="btn btn-primary">수정</a>
		<a href="#" id="pwdInitl" class="btn btn-inverse">비밀번호 초기화</a>
		<a href="javascript:delUser();" class="btn btn-danger">삭제</a>
	</div>
	<div class="col-md-1"><a href="/bos/userMember/list.do?${pageQueryString}" class="btn btn-primary">목록</a></div>
</div>
