<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<form action="/bos/hkFcltyResve/schdul/list.do" name="hldyForm" id="hldyForm" method="get" class="form-inline">
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
						<th scope="row" ><label for="eventNm">행사명</label></th>
						<td><input type="text" name="eventNm" id="eventNm" value="<c:out value="${param.eventNm }" />" /></td>
						<th scope="row" ><label for="place">장소</label></th>
						<td><input type="text" name="place" id="place" value="<c:out value="${param.place }" escapeXml="false" />" /></td>

					</tr>
					<tr>
						<th scope="row" >예약일자</th>
						<td><input type="text" id="stDt" name="stDt"  class="sdate" title="행사일자 시작일 입력" style="width:90px" value="<c:out value="${param.stDt }" />" />
							~
							<input type="text" id="edDt" name="edDt" class="edate" title="행사일자 종료일 입력" style="width:90px" value="<c:out value="${param.edDt }" />" /></td>
						<th scope="row"><label for="eventBeginTime">행사시간</label></th>
						<td><input type="text" name="eventBeginTime" id="eventBeginTime" title="행사시작 시간을 입력하세요." style="width:60px" value="<c:out value="${param.eventBeginTime }" />" />
							시 ~  
							<input type="text" name="eventEndTime" id="eventEndTime" title="행사종료 시간을 입력하세요." style="width:60px" value="<c:out value="${param.eventEndTime }" />" />
							시</td>
					</tr>
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
				<th scope="row" >행사명</th>
				<th scope="row" >행사일자</th>
				<th scope="row" >행사시간</th>
				<th scope="row" >장소</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><c:out value="${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1)) }" /></td>
				<td><a href="/bos/hkFcltyResve/schdul/forUpdate.do?eventSn=<c:out value="${result.eventSn }" />&amp;menuNo=<c:out value="${param.menuNo }" />"><c:out value="${result.eventNm }" /></a></td>
				<td><c:out value="${result.eventDt }" /></td>
				<td><c:out value="${result.eventBeginTime }" />시 ~ <c:out value="${result.eventEndTime }" />시</td>
				<td><c:out value="${result.place }" escapeXml="false" /></td>
			</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
			<tr><td colspan="5" class="tac">- 검색 결과가 없습니다 -</td></tr>
		</c:if>
		</tbody>
	</table>
</div>


<div class="btn_set"><a class="btn btn-primary" href="/bos/hkFcltyResve/schdul/forInsert.do?menuNo=<c:out value="${param.menuNo}"/>"><span>등록</span></a></div>


<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
</c:if>
<!-- //paging -->
