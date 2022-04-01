<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript">
//<![CDATA[

function checkForm() {
	var frm = document.getElementById("frm");

/* 	if (!frm.agreAt1.checked) {
		alert("개인정보 수집 및 이용에 동의하십시오.");
		frm.agreAt1.focus();
		return;
	} */

	if ("<c:out value='${masterResult.indvdlinfoAgreAt}'/>" == "Y") {
		if (!frm.agreAt2.checked) {
			alert("추가정보 수집 및 이용에 동의하십시오.");
			frm.agreAt2.focus();
			return;
		}
	}

	frm.submit();
}

//]]>
</script>

<div class="memberStep1">
	<div class="stepInline">
		<ol>
			<li class="on">개인정보 동의<span class="sr-only">(현재단계)</span></li>
			<li>신청 정보 입력</li>
			<li>입력내용 확인</li>
			<li>신청완료</li>
		</ol>
	</div>

<!-- 실시간 접수 상태 -->
<jsp:include page="/WEB-INF/jsp/ckl/progrm/applcnt/rltm.jsp" flush="true" />

	<form name="frm" id="frm" action="/ckl/progrm/applcnt/reg02.do?prgSn=<c:out value='${masterResult.prgSn}'/>&amp;menuNo=<c:out value="${param.menuNo }"/>&amp;prgSe=<c:out value="${param.prgSe }"/>&amp;prgCl=<c:out value="${param.prgCl }"/>&amp;siteSe=<c:out value="${param.siteSe }"/>" method="post">
	<input type="hidden" name="sttus" value="${param.sttus}">
	<input type="hidden" name="confmStepAt" value="${masterResult.confmStepAt}">
		<div>
			<%-- <h3>개인정보 수집 및 이용</h3>
			<div tabindex="0" class="agreeScr">
				콘텐츠코리아랩은 프로그램 신청/접수을 위해 아래와 같은 최소한의 필수정보와 선택정보를 수집합니다.<br/><br/>
				개인정보보호를 위한 이용자 동의사항<br/>
				1. 수집•이용 목적 : [${masterResult.prgClNm}-${masterResult.prgNm}]의 신청/접수를 위한 사용자 정보 수집 및 이용<br/>
				2. 개인정보 수집 항목 :<br/>
				[프로그램]<br/>
				-	필수항목 :
				<c:set var="numY" value="0"/>
				<c:forEach var="val" items="${essntlAtYList}" varStatus="status">
					<c:if test="${numY > 0}">, </c:if><c:out value='${val.title}'/><c:set var="numY" value="${numY+1}"/>
				</c:forEach>
				<br/>
				-	선택항목 :
				<c:set var="numN" value="0"/>
				<c:forEach var="val" items="${essntlAtNList}" varStatus="status">
					<c:if test="${numN > 0}">, </c:if><c:out value='${val.title}'/><c:set var="numN" value="${numN+1}"/>
				</c:forEach>
				<br/>
				3. 개인정보 보유 및 이용기간 : 신청/접수 후 3년간 정보를 보관<br/>
				4. 동의 거부 시 불이익에 관한 사항 : 수집•이용에 관한 사항의 동의를 거부할 때에는 해당 서비스의 이용이 제한됩니다. 단, 선택정보 사항을 획득하지 못한 사유로 인하여 서비스 제공을 거부하지 않습니다.
				<br/><br/>
			</div>
			<div class="agreeScrBtm">
				<label for="agreAt1"><input type="checkbox" name="agreAt1" id="agreAt1" value="Y">
					위 개인정보 수집 및 이용 내용에 동의합니다.</label>
			</div> --%>

		<c:if test="${masterResult.indvdlinfoAgreAt eq 'Y'}">
			<h3>추가정보 수집 및 이용 동의</h3>
			<div tabindex="0" class="agreeScr">
				${masterResult.indvdlinfoAgreCn}<br/><br/>
			</div>
			<div class="agreeScrBtm">
				<label for="agreAt2"><input type="checkbox" name="agreAt2" id="agreAt2" value="Y">
					위 추가정보 수집 및 이용 내용에 동의합니다.</label>
			</div>
		</c:if>

		</div>
		<div class="btnSet">
			<a href="javascript:checkForm();" class="btn btn-primary">다음</a>
			<a href="#" onclick="javascript:history.back(0);return false;" class="btn btn-primary">취소</a>
		</div>
	</form>
</div>
