<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript">
//<![CDATA[           
/* $(document).ready(
	function(){
		if ("<c:out value='${masterResult.indvdlinfoAgreAt}'/>" == "N"){
			checkForm();
		}
	}		
) */

function checkForm() {
	var frm = document.getElementById("frm");

 	if (!frm.agreAt1.checked) {
		alert("개인정보 수집 및 이용에 동의하십시오.");
		frm.agreAt1.focus();
		return;
	} 
	 
 	if ("<c:out value='${masterResult.indvdlinfoThreeAgreAt}'/>" == "Y") {
	 	if (!frm.agreAt3.checked) {
			alert("개인정보 제3자 제공을 위한 이용에 동의하십시오.");
			frm.agreAt3.focus();
			return;
		} 	 
 	}

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
	<div class="signup_step_bar recruit_step">
	    <div class="step_wrap active">
	        <p class="step_box">
	            <span class="step_title">STEP1</span>
	            개인정보 동의<span class="sr-only">(현재단계)</span>
	        </p>
	    </div>
	    <div class="step_line_wrap">
	        <div class="step_right_arrow">
	        </div>
	    </div>
	    <div class="step_wrap">
	        <p class="step_box">
	            <span class="step_title">STEP2</span>
	            신청 정보 입력
	        </p>
	    </div>
	    <div class="step_line_wrap">
	        <div class="step_right_arrow">
	        </div>
	    </div>
	    <div class="step_wrap">
	        <p class="step_box">
	            <span class="step_title">STEP3</span>
	            입력내용 확인
	        </p>
	    </div>
	    <c:choose>
		    <c:when test="${param.prgCl eq '10'}">
			    <div class="step_line_wrap">
			        <div class="step_right_arrow">
			        </div>
			    </div>
			    <div class="step_wrap">
			        <p class="step_box">
			            <span class="step_title">STEP4</span>
			       접수완료
			        </p>
			    </div>
			    <div class="step_line_wrap">
			        <div class="step_right_arrow">
			        </div>
			    </div>
			    <div class="step_wrap">
			        <p class="step_box">
			            <span class="step_title">STEP5</span>
				필수 온라인 과정 수료
			        </p>
			    </div>
			    <div class="step_line_wrap">
			        <div class="step_right_arrow">
			        </div>
			    </div>
			    <div class="step_wrap">
			        <p class="step_box">
			            <span class="step_title">STEP6</span>
			            신청완료
			        </p>
			    </div>   
		    </c:when>
		    <c:otherwise>
			    <div class="step_line_wrap">
			        <div class="step_right_arrow">
			        </div>
			    </div>
			    <div class="step_wrap">
			        <p class="step_box">
			            <span class="step_title">STEP4</span>
			            신청완료
			        </p>
			    </div>
		    </c:otherwise>
	    </c:choose>
	</div>
<!-- 실시간 접수 상태 -->
<jsp:include page="/WEB-INF/jsp/edu/progrm/applcnt/rltm.jsp" flush="true" />

	<form name="frm" id="frm" class="mt20" action="/edu/progrm/applcnt/reg02.do?prgSn=<c:out value='${masterResult.prgSn}'/>&amp;menuNo=<c:out value="${param.menuNo }"/>&amp;prgSe=<c:out value="${param.prgSe }"/>&amp;prgCl=<c:out value="${param.prgCl }"/>&amp;siteSe=<c:out value="${param.siteSe }"/>" method="post">
	<input type="hidden" name="sttus" value="${param.sttus}">
	<input type="hidden" name="confmStepAt" value="${masterResult.confmStepAt}">
		<div class="mb20">
			<h3>개인 정보 수집 및 이용</h3>
			<div tabindex="0" class="agreeScr">
				에듀코카는 프로그램 신청/접수을 위해 아래와 같은 최소한의 필수 정보와 선택정보를 수집합니다.<br/><br/>
				개인 정보보호를 위한 이용자 동의사항<br/>
				1. 수집ㆍ이용 목적 : [${masterResult.prgClNm}-${masterResult.prgNm}]의 신청/접수를 위한 사용자 정보 수집 및 이용<br/>
				2. 개인 정보 수집 항목 :<br/>
				[프로그램]<br/>
				-	필수항목 : 이름
				<c:set var="numY" value="0"/>
				<c:forEach var="val" items="${essntlAtYList}" varStatus="status">
					<c:if test="${val.title ne '이름' }">
						, <c:out value='${val.title}'/><c:set var="numY" value="${numY+1}"/>
					</c:if>
				</c:forEach>
				<br/>
				-	선택항목 :
				<c:set var="numN" value="0"/>
				<c:forEach var="val" items="${essntlAtNList}" varStatus="status">
					<c:if test="${val.title ne '이름' }">
						<c:if test="${numN > 0}">, </c:if><c:out value='${val.title}'/><c:set var="numN" value="${numN+1}"/>
					</c:if>
				</c:forEach>
				<br/>
				3. 개인 정보 보유 및 이용기간 : 신청/접수 후 3년간 정보를 보관<br/>
				4. 동의 거부 시 불이익에 관한 사항 : 수집ㆍ이용에 관한 사항의 동의를 거부할 때에는 해당 서비스의 이용이 제한됩니다. 단, 선택정보 사항을 획득하지 못한 사유로 인하여 서비스 제공을 거부하지 않습니다.
				<br/><br/>
			</div>
			<div class="mb20 agreeScrBtm">
				<input type="checkbox" name="agreAt1" id="agreAt1" value="Y">
				<label for="agreAt1">
					위 개인 정보 수집 및 이용 내용에 동의합니다.
				</label>
			</div>
			
		<c:if test="${masterResult.indvdlinfoThreeAgreAt eq 'Y'}">
			<h3>개인 정보 제3자 제공을 위한 동의</h3>
			<div tabindex="0" class="agreeScr">
				개인 정보 제3자 제공을 위한 이용자 동의사항<br/>
				1. 개인 정보를 제공받는 자 : ${masterResult.indvdlinfoProvider}<br/>
				2. 수집ㆍ이용 목적 : [${masterResult.prgClNm}-${masterResult.prgNm}]의 신청/접수를 위한 사용자 정보 수집 및 이용<br/>
				3. 개인 정보 수집 항목 :<br/>
				[프로그램]<br/>
				-	필수항목 : 이름
				<c:set var="numY" value="0"/>
				<c:forEach var="val" items="${essntlAtYList}" varStatus="status">
					<c:if test="${val.title ne '이름' }">
						, <c:out value='${val.title}'/><c:set var="numY" value="${numY+1}"/>
					</c:if>
				</c:forEach>
				<br/>
				-	선택항목 :
				<c:set var="numN" value="0"/>
				<c:forEach var="val" items="${essntlAtNList}" varStatus="status">
					<c:if test="${val.title ne '이름' }">
						<c:if test="${numN > 0}">, </c:if><c:out value='${val.title}'/><c:set var="numN" value="${numN+1}"/>
					</c:if>
				</c:forEach>
				<br/>
				4. 개인 정보 보유 및 이용기간 : 신청/접수 후 3년간 정보를 보관<br/>
				5. 동의 거부 시 불이익에 관한 사항 : 수집ㆍ이용에 관한 사항의 동의를 거부할 때에는 해당 서비스의 이용이 제한됩니다. 단, 선택정보 사항을 획득하지 못한 사유로 인하여 서비스 제공을 거부하지 않습니다.
				<br/><br/>
			</div>
			<div class="agreeScrBtm">
				<input type="checkbox" name="agreAt3" id="agreAt3" value="Y">
				<label for="agreAt3">
					위 개인정보 제3자 제공을 위한 내용에 동의합니다.
				</label>
			</div>
		</c:if>
		<br/>
		<c:if test="${masterResult.indvdlinfoAgreAt eq 'Y'}">
			<h3>추가정보 수집 및 이용 동의</h3>
			<div tabindex="0" class="agreeScr">
				${masterResult.indvdlinfoAgreCn}<br/><br/>
			</div>
			<div class="agreeScrBtm">
				<input type="checkbox" name="agreAt2" id="agreAt2" value="Y">
				<label for="agreAt2">
					위 추가정보 수집 및 이용 내용에 동의합니다.
				</label>
			</div>
		</c:if>

		</div>
		<div class="board_util_btn_con">
			<a href="javascript:checkForm();" class="btn_style_0 full right">다음</a>
			<a href="javascript:void(0);" onclick="javascript:history.back(0);return false;" class="btn_style_0 full close_w">취소</a>
		</div>
	</form>
</div>
