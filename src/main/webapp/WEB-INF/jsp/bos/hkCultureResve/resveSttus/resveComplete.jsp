<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>


<ul class="navWizard">
	<li><span>공간 및 일자/시간 선택</span></li>
	<li><span>예약 정보 입력</span></li>
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

<h4>예약 단체 정보</h4>
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
				<th scope="row" >단체명</th>
				<td colspan="3"><c:out value="${result.resveNm }" /></td>
			</tr>
			<tr>
				<th scope="row" >연락처</th>
				<td><c:out value="${result.mbtlnum }" /></td>
				<th scope="row" >이메일</th>
				<td><c:out value="${result.email }" /></td>
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
	<div class="col-md-12"><a href="/bos/hkCultureResve/resveSttus/list.do?menuNo=<c:out value="${param.menuNo }" />" class="btn btn-primary">확인</a></div>
</div>
