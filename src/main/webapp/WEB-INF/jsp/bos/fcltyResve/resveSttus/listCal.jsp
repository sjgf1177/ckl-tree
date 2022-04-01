<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<input type="hidden" name="chkSum" id="chkSum" value="${chkSum }" />
<table style="width:100%;" class="cal_mtable" summary="일요일, 월요일, 화요일, 수요일, 목요일, 금요일, 토요일로 구분되는 표">
	<caption>월간일정</caption>
	<colgroup>
		<col>
		<col>
		<col>
		<col>
		<col>
		<col>
		<col>
	</colgroup>
	<thead>
		<tr>
			<th scope="col" class="bln">일</th>
			<th scope="col">월</th>
			<th scope="col">화</th>
			<th scope="col">수</th>
			<th scope="col">목</th>
			<th scope="col">금</th>
			<th scope="col" class="brn">토</th>
		</tr>
	</thead>
	<tbody class="sixLine">

	<c:forEach var="result" items="${calList }">

		<c:set var="sunClass" value="cal_none" />
		<c:set var="monClass" value="cal_none" />
		<c:set var="tueClass" value="cal_none" />
		<c:set var="wedClass" value="cal_none" />
		<c:set var="thuClass" value="cal_none" />
		<c:set var="friClass" value="cal_none" />
		<c:set var="satClass" value="cal_none" />

		<tr>
			<c:if test="${not empty result.sun.day && result.sun.diffDay >= 0 && result.sun.diffDay < 90}">
				<c:set var="sunClass" value="cal_reserv_ok" />
				<c:if test="${fcltyItem.wkendResvePolsblAt ne 'Y' }">
					<c:set var="sunClass" value="cal_reserv_end" />
				</c:if>
				<c:if test="${fcltyItem.wkendResvePolsblAt eq 'Y' and result.sun.resveWaitTp eq 'Y' }">
					<c:set var="sunClass" value="cal_reserv_ing" />
				</c:if>
				<c:if test="${result.sun.hldyTp eq 'Y' }">
					<c:set var="sunClass" value="cal_reserv_end" />
				</c:if>
				<c:if test="${ result.sun.todayTp eq 'Y'}">
					<c:set var="sunClass" value="${sunClass } cal_today" />
				</c:if>
			</c:if>
			<td class="${empty result.sun.day ? 'cal_blank' : sunClass}"><a data-value="<c:out value="${result.sun.day }" />" href="#self">${result.sun.day }</a></td>

			<c:if test="${not empty result.mon.day && result.mon.diffDay >= 0 && result.mon.diffDay < 90 }">
				<c:set var="monClass" value="cal_reserv_ok" />
				<c:if test="${result.mon.resveWaitTp eq 'Y' }">
					<c:set var="monClass" value="cal_reserv_ing" />
				</c:if>
				<c:if test="${result.mon.hldyTp eq 'Y' }">
					<c:set var="monClass" value="cal_reserv_end" />
				</c:if>
				<c:if test="${ result.mon.todayTp eq 'Y'}">
					<c:set var="monClass" value="${monClass } cal_today" />
				</c:if>
			</c:if>
			<td class="${empty result.mon.day ? 'cal_blank' : monClass}"><a data-value="<c:out value="${result.mon.day }" />" href="#self">${result.mon.day }</a></td>

			<c:if test="${not empty result.tue.day && result.tue.diffDay >= 0 && result.tue.diffDay < 90 }">
				<c:set var="tueClass" value="cal_reserv_ok" />
				<c:if test="${result.tue.resveWaitTp eq 'Y' }">
					<c:set var="tueClass" value="cal_reserv_ing" />
				</c:if>
				<c:if test="${result.tue.hldyTp eq 'Y' }">
					<c:set var="tueClass" value="cal_reserv_end" />
				</c:if>
				<c:if test="${ result.tue.todayTp eq 'Y'}">
					<c:set var="tueClass" value="${tueClass } cal_today" />
				</c:if>
			</c:if>
			<td class="${empty result.tue.day ? 'cal_blank' : tueClass}"><a data-value="<c:out value="${result.tue.day }" />" href="#self">${result.tue.day }</a></td>

			<c:if test="${not empty result.wed.day && result.wed.diffDay >= 0 && result.wed.diffDay < 90 }">
				<c:set var="wedClass" value="cal_reserv_ok" />
				<c:if test="${result.wed.resveWaitTp eq 'Y' }">
					<c:set var="wedClass" value="cal_reserv_ing" />
				</c:if>
				<c:if test="${result.wed.hldyTp eq 'Y' }">
					<c:set var="wedClass" value="cal_reserv_end" />
				</c:if>
				<c:if test="${ result.wed.todayTp eq 'Y'}">
					<c:set var="wedClass" value="${wedClass } cal_today" />
				</c:if>
			</c:if>
			<td class="${empty result.wed.day ? 'cal_blank' : wedClass}"><a data-value="<c:out value="${result.wed.day }" />" href="#self">${result.wed.day }</a></td>

			<c:if test="${not empty result.thu.day && result.thu.diffDay >= 0 && result.thu.diffDay < 90 }">
				<c:set var="thuClass" value="cal_reserv_ok" />
				<c:if test="${result.thu.resveWaitTp eq 'Y' }">
					<c:set var="thuClass" value="cal_reserv_ing" />
				</c:if>
				<c:if test="${result.thu.hldyTp eq 'Y' }">
					<c:set var="thuClass" value="cal_reserv_end" />
				</c:if>
				<c:if test="${ result.thu.todayTp eq 'Y'}">
					<c:set var="thuClass" value="${thuClass } cal_today" />
				</c:if>
			</c:if>
			<td class="${empty result.thu.day ? 'cal_blank' : thuClass}"><a data-value="<c:out value="${result.thu.day }" />" href="#self">${result.thu.day }</a></td>

			<c:if test="${not empty result.fri.day && result.fri.diffDay >= 0 && result.fri.diffDay < 90 }">
				<c:set var="friClass" value="cal_reserv_ok" />
				<c:if test="${result.fri.resveWaitTp eq 'Y' }">
					<c:set var="friClass" value="cal_reserv_ing" />
				</c:if>
				<c:if test="${result.fri.hldyTp eq 'Y' }">
					<c:set var="friClass" value="cal_reserv_end" />
				</c:if>
				<c:if test="${ result.fri.todayTp eq 'Y'}">
					<c:set var="friClass" value="${friClass } cal_today" />
				</c:if>
			</c:if>
			<td class="${empty result.fri.day ? 'cal_blank' : friClass}"><a data-value="<c:out value="${result.fri.day }" />" href="#self">${result.fri.day }</a></td>


			<c:if test="${not empty result.sat.day && result.sat.diffDay >= 0 && result.sat.diffDay < 90 }">
				<c:set var="satClass" value="cal_reserv_ok" />
				<c:if test="${fcltyItem.wkendResvePolsblAt ne 'Y' }">
					<c:set var="satClass" value="cal_reserv_end" />
				</c:if>
				<c:if test="${fcltyItem.wkendResvePolsblAt eq 'Y' and result.sat.resveWaitTp eq 'Y' }">
					<c:set var="satClass" value="cal_reserv_ing" />
				</c:if>
				<c:if test="${result.sat.hldyTp eq 'Y' }">
					<c:set var="satClass" value="cal_reserv_end" />
				</c:if>
				<c:if test="${ result.sat.todayTp eq 'Y'}">
					<c:set var="satClass" value="${satClass } cal_today" />
				</c:if>
			</c:if>
			<td class="${empty result.sat.day ? 'cal_blank' : satClass}"><a data-value="<c:out value="${result.sat.day }" />" href="#self">${result.sat.day }</a></td>
		</tr>
	</c:forEach>

	</tbody>
</table>

<script type="text/javascript">
//<![CDATA[
fnInitYearMonth();

//날짜 값 초기 세팅(year, month);
function fnInitYearMonth() {

	var dayYY = "<c:out value="${dayYY}" />";
	var dayMM = "<c:out value="${dayMM}" />";
	var prevDt = "<c:out value="${prevDt}" />";
	var nextDt = "<c:out value="${nextDt}" />";


	$(".headStep3").find(".year").text(dayYY);
	$(".headStep3").find(".month").text(dayMM);
	$(".headStep3").find(".prevMonth").attr("data-value",prevDt);
	$(".headStep3").find(".nextMonth").attr("data-value",nextDt);

}

//]]>
</script>
