<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
//<![CDATA[

//]]>
</script>


<!-- <p>원하시는 장비를 선택 후 신청수량을 입력하여 주세요.</p> -->
<p><label for="noEqpnm" style="display: none;"><input type="checkbox" name="noEqpnm" id="noEqpnm" value="N" <c:if test="${fn:length(eqpmnList) == 0 }">checked="checked"</c:if> style="display: none;" />장비 이용 안함</label></p>

<ul id="eqpmnList" <c:if test="${fn:length(eqpmnList) == 0 }">style="display:none;"</c:if>>
<c:forEach var="result" items="${list }" varStatus="status">
	<li><input type="checkbox" name="eqpmnSn" id="eqpmnSn${status.index }" checked="checked" value="<c:out value="${result.eqpmnSn }" />" style="display: none;"/> <c:out value="${result.eqpmnNm }" />
		<a class="" href="/ckl/hkFcltyResve/eqpmn/viewPopup.do?eqpmnSn=<c:out value="${result.eqpmnSn }"/>&amp;viewType=BODY" onclick="window.open(this.href,'eqpmnPop','width=800, height=925, scrollbars=no');return false;" class="text-danger">[장비보기]</a>
		<div>
			<span class="ml20">수량 : <span class="fcRed remndrQy"><c:out value="${result.remndrQy }" /></span></span>
			<div class="toolsCnt btn-group fr">
				<input type="hidden" name="remndrQy" id="remndrQy${status.index }" value="<c:out value="${result.remndrQy }" />" />
				<input type="hidden" name="eqpmnNm" id="eqpmnNm${status.index }" value="<c:out value="${result.eqpmnNm }" />" />
				<input type="hidden" name="eqpmnDetailSnStr" id="eqpmnDetailSnStr${status.index }" value="<c:out value="${result.eqpmnDetailSnStr }" />" />
				<input type="hidden" name="inputEqpmnQy" id="inputEqpmnQy${status.index }" value="<c:out value="${empty result.inputEqpmnQy ? result.remndrQy : result.inputEqpmnQy }" />" />

				<%-- <button type="button" class="btn btn-default btnSm minusBtn" title="신청수량 1 빼기">-<span class="sr-only">신청수량 1 빼기</span></button>
				<button type="button" class="btn btn-default btnSm qtyNum"><c:out value="${empty result.inputEqpmnQy ? 0 : result.inputEqpmnQy }" /></button>
				<button type="button" class="btn btn-default btnSm plusBtn" title="신청수량 1 더하기">+<span class="sr-only">신청수량 1 더하기</span></button> --%>
			</div>
		</div>
	</li>


</c:forEach>
<c:if test="${fn:length(list) == 0 }">
	<li class="nodata">장비가 존재하지 않습니다.</li>
</c:if>
</ul>


