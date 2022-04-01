<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/WEB-INF/jsp/bos/bbs/com/bbsHead.jsp" flush="true" />
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">



	var mode = "${empty result ? 'I' : 'M'}";


	function checkForm() {
		var form = document.f_regi;

		var v = new MiyaValidator(form);
		if( mode == "I" ){
		    v.add("userId", {
		        required: true
		    });
		}

	    v.add("email1", {
	        required: true,
			span: 2,
			glue: "@",
			option: "email"
	    });

	    v.add("moblphon1", {
	        required: true,
	        span: 3,
	        glue: "-",
	        option: "phone"
	    });

	    v.add("status", {
	        required: true
	    });

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (confirm("${empty result ? '등록' : '수정'}하시겠습니까?")) {
			form.submit();
		}

	}


</script>
</head>
<body>
<div id="content">
	<div class="hgroup">
		<h3 >일반회원관리</h3>
	</div>

<form name="f_regi" method="post" action="/bos/member/${empty result ? 'insertUser' : 'updateUser'}.do" enctype="multipart/form-data">
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}" />
	<input type=hidden name="pageQueryString" value='${pageQueryString}'>
	<div class="bdView">
		<table>
			<caption>일반회원관리 필수정보 입력</caption>
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="35%"/>
			</colgroup>
			<tbody>
				<tr>
					<th><label for="userId">아이디</label></th>
					<td>
					<c:choose>
						<c:when test="${not empty result}">
							${result.userId}<input type="hidden" name="userId" id="userId" value="${result.userId}" />
						</c:when>
						<c:otherwise>
							<input type="text" name="userId" id="userId" value="${result.userId}" style="width:200px" />
						</c:otherwise>
					</c:choose>
					</td>

					<th><label for="userNm"><span class="req">*</span>이름</label></th>
					<td>
						<c:choose>
						<c:when test="${not empty result}">
							${result.userNm}<input type="hidden" name="userNm" id="userNm" value="${result.userNm}" />
						</c:when>
						<c:otherwise>
							<input type="text" name="userNm" id="userNm" value="${result.userNm}" style="width:200px" />
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<th><label for="brthdy">생년월일</label></th>
					<td>
						${result.brthdy}
					</td>

					<th><label for="sex1">성별</label></th>
					<td>
						<c:choose>
							<c:when test="${result.sex eq 'M'}">남</c:when>
							<c:when test="${result.sex eq 'F'}">여</c:when>
						</c:choose>
					</td>
				</tr>

				<tr>
					<th scope="row"><label for="file1">프로필 이미지</label></th>
					<td colspan="3">
						<c:if test="${not empty fileList }">
						<c:forEach var="fileVO" items="${fileList}" varStatus="status">
							<c:if test="${fileVO.fileFieldName eq 'file1'}">
							<img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}" style="border: 0px;" width="126" height="73"/>
							</c:if>
						</c:forEach>
						</c:if>
						<input id="file1" name="file1" type="file" title="첨부파일1" class="board1" size="50" style="width:90%" />

					</td>
				</tr>
				<tr>
					<th><label for="email1"><span class="req">*</span>이메일</label></th>
					<td colspan="3">
					<c:set var="data" value="${fn:split(result.email,'@')}" />
					<c:choose>
					<c:when test="${fn:length(data) >= 2}">
							<input name="email1" id="email1" type="text" title="이메일 아이디" value="${data[0]}" style="width:100px" class="board1 email_id"/>
							@
							<input name="email2" id="email2" type="text" title="이메일 주소" value="${data[1]}" style="width:200px" class="board1 email_addr"/>
					</c:when>
					<c:otherwise>
							<input name="email1" id="email1" type="text" title="이메일 아이디" value="" style="width:100px" class="board1 email_id"/>
							@
							<input name="email2" id="email2" type="text" title="이메일 주소" value="" style="width:200px" class="board1 email_addr"/>
					</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<th><label for="moblphon"><span class="req">*</span>휴대폰</label></th>
					<td colspan="3">
						<c:set var="data" value="${fn:split(result.moblphon,'-')}" />
						<c:choose>
							<c:when test="${fn:length(data) >= 3}">
								<select name="moblphon1" id="moblphon1" title="지역 국번 앞 3자리"  class="input_select" >
									<option value="">선택</option>
									<option value="010" <c:if test="${data[0] eq '010'}">selected="selected"</c:if>>010</option>
									<option value="011" <c:if test="${data[0] eq '011'}">selected="selected"</c:if>>011</option>
									<option value="016" <c:if test="${data[0] eq '016'}">selected="selected"</c:if>>016</option>
									<option value="017" <c:if test="${data[0] eq '017'}">selected="selected"</c:if>>017</option>
									<option value="018" <c:if test="${data[0] eq '018'}">selected="selected"</c:if>>018</option>
									<option value="019" <c:if test="${data[0] eq '019'}">selected="selected"</c:if>>019</option>
								</select>
								-
								<input type="text" id="moblphon2" name="moblphon2" value="${data[1]}" class="tel" title="대표전화 중간4자리" maxlength="4" />
								-
								<input type="text" id="moblphon3" name="moblphon3" value="${data[2]}" class="tel" title="대표전화 끝4자리" maxlength="4" />
							</c:when>
							<c:otherwise>
								<select name="moblphon1" id="moblphon1" title="지역 국번 앞 3자리" class="input_select" >
									<option value="">선택</option>
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>
								-
								<input type="text" value="" id="moblphon2" name="moblphon2" class="tel" title="대표전화 중간4자리" maxlength="4"/>
								-
								<input type="text" value="" id="moblphon3" name="moblphon3" class="tel" title="대표전화 끝4자리" maxlength="4"/>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th><label for="emailAt1">수신여부</label></th>
					<td colspan="3">
						코스콤 핀테크 뉴스레터등의 다양한 정보를 받으시겠습니까?<br />
						이메일 수신 <input type="radio" id="emailAt1" name="emailAt" value="Y" <c:if test="${result.emailAt eq 'Y'}">checked="checked"</c:if> class="input_radio" /> 수신동의
						<input type="radio" id="emailAt2" name="emailAt" value="N" <c:if test="${result.emailAt eq 'N'}">checked="checked"</c:if> class="input_radio" /> 수신 비동의 <br />
						SMS 수신 <input type="radio" id="smsAt1" name="smsAt" value="Y" <c:if test="${result.smsAt eq 'Y'}">checked="checked"</c:if> class="input_radio" /> 수신동의
						<input type="radio" id="smsAt2" name="smsAt" value="N" <c:if test="${result.smsAt eq 'N'}">checked="checked"</c:if> class="input_radio" /> 수신 비동의
					</td>
				</tr>
				<tr>
					<th><label for="status"><span class="req">*</span>상태</label></th>
					<td colspan="3">
						<select id="status" name="status">
						    <option value="">--승인상태선택--</option>
							<option value="Y" <c:if test="${result.status eq 'Y'}">selected="selected"</c:if>>승인</option>
							<option value="N" <c:if test="${result.status eq 'N'}">selected="selected"</c:if>>중지</option>
						</select>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

</form>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:checkForm();"><span>${empty result ? '등록' : '수정'}</span></a>

		<a class="btn btn-primary" onclick="history.back(-2);"><span>취소</span></a>
	</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>