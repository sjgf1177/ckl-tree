<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<form action="/bos/hkFcltyResve/hldy/list.do" name="hldyForm" id="hldyForm" method="get" class="form-inline">
<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
<fieldset>
	<legend></legend>
		<div class="bdView mb0">
			<table class="table table-bordered">
				<caption>

				</caption>
				<colgroup>
				<col style="width:20%" />
				<col style="width:30%" />
				<col style="width:20%" />
				<col style="width:30%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="hldyYear">년도</label></th>
						<td>
							<select name="hldyYear" id="hldyYear">
								<c:forEach begin="${currYear - 1 }" end="${currYear + 10 }"  var="yearItem">
								<option value="<c:out value="${yearItem }" />" <c:if test="${yearItem eq (empty param.hldyYear ? currYear : param.hldyYear) }">selected="selected"</c:if>><c:out value="${yearItem }" /></option>
								</c:forEach>
							</select>
						</td>
						<th scope="row" ><label for="hldyNm">휴일명</label></th>
						<td><input type="text" name="hldyNm" id="hldyNm" value="<c:out value="${param.hldyNm }" />" /></td>

					</tr>
					<!--
					<tr>
						<th scope="row">일자</th>
						<td colspan="3"><input type="text" id="sdate" name="sdate"  class="sdate" title="일자 시작일 입력" style="width:130px"value="" />
							~
							<input type="text" id="edate" name="edate"  class="edate" title="일자 종료일 입력" style="width:130px"value="" /></td>
					</tr>
					 -->
				</tbody>
			</table>
		</div>
		<div class="btnSet tar"><input type="submit" class="btn btn-primary" value="검색" /></div>

</fieldset>
</form>



<div class="row mt10 mb5">
	<div class="col-md-12"> 총 : <strong class="text-danger"><c:out value="${fn:length(resultList) }" /></strong>건</div>
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
		</colgroup>
		<thead>
			<tr>
				<th scope="row" >번호</th>
				<th scope="row" >휴일명</th>
				<th scope="row" >일자</th>
				<th scope="row" >사용여부</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><c:out value="${status.count }" /></td>
				<td><a href="/bos/hkFcltyResve/hldy/forUpdate.do?hldyDe=<c:out value="${result.hldyDe }" />&amp;menuNo=<c:out value="${param.menuNo }" />"><c:out value="${result.hldyNm }" /></a></td>
				<td><c:out value="${result.hldyDe }" /></td>
				<td><c:out value="${result.useAt eq 'Y' ? '사용' : '미사용' }" /></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
			<tr><td colspan="4" class="tac">- 검색 결과가 없습니다 -</td></tr>
		</c:if>
		</tbody>
	</table>
</div>


<div class="btn_set"><a class="btn btn-primary" href="/bos/hkFcltyResve/hldy/forInsert.do?menuNo=<c:out value="${param.menuNo}"/>"><span>등록</span></a></div>
