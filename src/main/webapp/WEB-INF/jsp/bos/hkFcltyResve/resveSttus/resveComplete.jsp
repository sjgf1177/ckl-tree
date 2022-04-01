<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>


<ul class="navWizard">
	<li><span>공간 및 일자/시간 선택</span></li>
	<li><span>예약자 정보 입력</span></li>
	<li class="last active"><span class="sr-only">(현재 페이지)</span><span>예약완료</span></li>
</ul>


<div class="alert alert-info clear">
	<p class="fs18">시설 예약이 완료되었습니다.</p>
</div>


<h4 class="clear">예약정보</h4>

<div class="bdView">
	<table class="table table-bordered">
		<caption>

		</caption>
		<colgroup>
		<col />
		<col />
		<col />
		<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">예약번호</th>
				<td colspan="3"><c:out value="${result.resveNo }" /></td>
			</tr>
			<tr>
				<th scope="row" >시설공간</th>
				<td colspan="3"><c:out value="${result.areaSeNm }" /> &gt; <c:out value="${result.lcSeNm }" /> &gt; <c:out value="${result.fcltySeNm }" /> &gt; <c:out value="${result.spceNm }" /></td>
			</tr>
			<tr>
				<th scope="row" >예약일자</th>
				<td>
					<fmt:parseDate value="${result.resveDt}" var="dateFmt" pattern="yyyy-MM-dd"/>
                	<fmt:formatDate value="${dateFmt}" pattern="yyyy년 MM월 dd일"/>
				</td>
				<th scope="row" >예약시간</th>
				<td>
					<util:fz resultLen="2" source="${result.resveBeginTime }" isFront="true" />:00
					 ~ <util:fz resultLen="2" source="${result.resveEndTime }" isFront="true" />:59 (<c:out value="${(result.resveEndTime-result.resveBeginTime+1) }" />시간)
				</td>
			</tr>
		</tbody>
	</table>
</div>


<h4>장비 신청정보</h4>
<div class="bdView">
	<table class="table table-bordered">
		<caption>

		</caption>
		<colgroup>
		<col />
		<col />
		</colgroup>
		<thead>
			<tr>
				<th scope="row" >장비구분</th>
				<th>신청수량</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="eqpmnItem" items="${result.eqpmnList }" varStatus="status">
			<tr>
				<td scope="row" ><c:out value="${eqpmnItem.eqpmnNm }" /></td>
				<td><c:out value="${eqpmnItem.eqpmnQy }" /></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(result.eqpmnList) == 0 }">
			<tr><td class="tac">신청장비가 존재하지 않습니다.</td></tr>
		</c:if>
		</tbody>
	</table>
</div>



<h4>예약자 정보</h4>
<div class="tbrinfo text-danger"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
<div class="bdView">
	<table class="table table-bordered">
		<caption>

		</caption>
		<colgroup>
		<col />
		<col />
		<col />
		<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row" >이름</th>
				<td colspan="3"><c:out value="${result.resveNm }" /></td>
			</tr>
			<tr>
				<th scope="row" >휴대폰</th>
				<td><c:out value="${result.mbtlnum }" /></td>
				<th scope="row" >이메일</th>
				<td><c:out value="${result.email }" /></td>
			</tr>
			<tr>
				<th scope="row" >나이</th>
				<td><c:out value="${result.ageSeNm }" /></td>
				<th scope="row" >직업</th>
				<td><c:out value="${result.jobSeNm }" /></td>
			</tr>
			<tr>
				<th scope="row" >거주지역</th>
				<td><c:out value="${result.resdncSeNm }" /></td>
				<th scope="row" >사용인원</th>
				<td><c:out value="${result.useNmpr }" /> 명</td>
			</tr>
			<tr>
				<th scope="row" >사용목적</th>
				<td colspan="3"><c:out value="${result.usePurposeCn }" /></td>
			</tr>
			<tr>
				<th scope="row" >예약정보 수신방법</th>
				<td colspan="3"><c:out value="${result.resveRecptnSeNm }" /></td>
			</tr>
		</tbody>
	</table>
</div>

<div class="row clear mt20 tac">
	<div class="col-md-12"><a href="/bos/hkFcltyResve/resveSttus/list.do?menuNo=<c:out value="${param.menuNo }" />" class="btn btn-primary">확인</a></div>
</div>
