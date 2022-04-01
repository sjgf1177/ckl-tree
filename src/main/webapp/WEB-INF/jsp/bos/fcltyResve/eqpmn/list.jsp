<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<form id="eqpmnForm" name="eqpmnForm" method="get" action="/bos/fcltyResve/eqpmn/list.do" class="form-inline">
<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
<fieldset>
	<legend></legend>
		<div class="bdView mb0">
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
							<th scope="row" ><label for="eqpmnNm">장비명</label></th>
							<td><input type="text" name="eqpmnNm" id="eqpmnNm" value="<c:out value="${param.eqpmnNm}" />" /></td>
							<th scope="row" ><label for="dtlsInfo">세부내역</label></th>
							<td><input type="text" name="dtlsInfo" id="dtlsInfo" value="<c:out value="${param.dtlsInfo}" />" /></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="btnSet tar"><input type="submit" class="btn btn-primary" value="검색" /></div>
	</fieldset>
</form>



<div class="row mt10 mb5">
	<div class="col-md-6"> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${totalPage }" /></strong> Page </div>
</div>



<div class="bdList">
	<table class="table table-bordered">
		<caption>

		</caption>
		<colgroup>
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		</colgroup>
		<thead>
			<tr>
				<th scope="row" >번호</th>
				<th scope="row" >장비구분</th>
				<th scope="row" >장비명</th>
				<th scope="row" >상세장비수량</th>
				<th scope="row" >예약구분</th>
				<th scope="row" >예약가능여부</th>
				<th scope="row" >상태</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><c:out value="${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1)) }" /></td>
				<td><c:out value="${result.eqpmnSeNm }" /></td>
				<td><a href="/bos/fcltyResve/eqpmn/view.do?eqpmnSn=<c:out value="${result.eqpmnSn }" />&amp;${pageQueryString}"><c:out value="${result.eqpmnNm }" /></a></td>
				<td><c:out value="${result.eqpmnQy }" /></td>
				<td><c:out value="${result.resveSeNm }" /></td>
				<td><c:out value="${result.resvePosblAt eq 'Y' ? '예약가능' : '예약불가' }" /></td>
				<td><c:out value="${result.useAt eq 'Y' ? '사용' : '미사용' }" /></td>
			</tr>
		<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
			<tr><td colspan="6">- 검색 결과가 없습니다 -</td></tr>
		</c:if>
		</tbody>
	</table>
</div>




<div class="btn_set"><a class="btn btn-primary" href="/bos/fcltyResve/eqpmn/forInsert.do?${pageQueryString}"><span>등록</span></a></div>


<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
</c:if>
<!-- //paging -->