<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.cal_reserv_ok{
	background: #b1dca2 url(/ckl/images/common/icoRev.png) no-repeat -180px -160px;
}
.cal_reserv_ing{
	background: #abd8e8 url(/ckl/images/common/icoRev.png) no-repeat -100px -160px;
}
.cal_reserv_end{
	background: #ebbcbe url(/ckl/images/common/icoRev.png) no-repeat -22px -160px;
}
.cal_reserv_ok .on{
	background: #51a832 url(/ckl/images/common/icoRev.png) no-repeat -165px 6px;
}
</style>

<input type="hidden" name="chkSum" id="chkSum" value="${chkSum }" />
<table style="width: auto;" class="cal_mtable">
	<caption>월간일정(요일로 구분되는 표)</caption>
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
			<c:if test="${not empty result.sun.day && result.sun.diffDay >= 0 && result.sun.diffDay < 30}">
				<c:set var="sunClass" value="cal_reserv_ok" />
				<c:set var="sunClassKo" value="예약가능"/>
				<c:if test="${wkendResvePolsblAt ne 'Y' }">
					<c:set var="sunClass" value="cal_reserv_end" />
					<c:set var="sunClassKo" value="예약불가"/>
				</c:if>
				<c:if test="${wkendResvePolsblAt eq 'Y' and result.sun.resveWaitTp eq 'Y' }">
					<c:set var="sunClass" value="cal_reserv_ing" />
					<c:set var="sunClassKo" value="대기예약"/>
				</c:if>
				<c:if test="${result.sun.hldyTp eq 'Y' }">
					<c:set var="sunClass" value="cal_reserv_end" />
					<c:set var="sunClassKo" value="예약불가"/>
				</c:if>
				<c:if test="${ result.sun.todayTp eq 'Y'}">
					<c:set var="sunClass" value="${sunClass } cal_today" />
					<c:set var="sunClassKo" value="대기예약"/>
				</c:if>
			</c:if>
			<td class="${empty result.sun.day ? 'cal_blank' : sunClass}"><a data-value="<c:out value="${result.sun.day }" />" href="#self" title="<c:out value="${sunClassKo}"/>">${empty result.sun.day ? '<span class="sr-only">공백</span>' : result.sun.day}</a></td>

			<c:if test="${not empty result.mon.day && result.mon.diffDay >= 0 && result.mon.diffDay < 30 }">
				<c:set var="monClass" value="cal_reserv_ok" />
				<c:set var="monClassKo" value="예약가능"/>
				<c:if test="${result.mon.resveWaitTp eq 'Y' }">
					<c:set var="monClass" value="cal_reserv_ing" />
					<c:set var="monClassKo" value="대기예약"/>
				</c:if>
				<c:if test="${result.mon.hldyTp eq 'Y' }">
					<c:set var="monClass" value="cal_reserv_end" />
					<c:set var="monClassKo" value="예약불가"/>
				</c:if>
				<c:if test="${ result.mon.todayTp eq 'Y'}">
					<c:set var="monClass" value="${monClass } cal_today" />
					<c:set var="monClassKo" value="대기예약"/>
				</c:if>
			</c:if>
			<td class="${empty result.mon.day ? 'cal_blank' : monClass}"><a data-value="<c:out value="${result.mon.day }" />" href="#self" title="<c:out value="${monClassKo}"/>">${empty result.mon.day ? '<span class="sr-only">공백</span>' : result.mon.day}</a></td>

			<c:if test="${not empty result.tue.day && result.tue.diffDay >= 0 && result.tue.diffDay < 30 }">
				<c:set var="tueClass" value="cal_reserv_ok" />
				<c:set var="tueClassKo" value="예약가능"/>
				<c:if test="${result.tue.resveWaitTp eq 'Y' }">
					<c:set var="tueClass" value="cal_reserv_ing" />
					<c:set var="tueClassKo" value="대기예약"/>
				</c:if>
				<c:if test="${result.tue.hldyTp eq 'Y' }">
					<c:set var="tueClass" value="cal_reserv_end" />
					<c:set var="tueClassKo" value="예약불가"/>
				</c:if>
				<c:if test="${ result.tue.todayTp eq 'Y'}">
					<c:set var="tueClass" value="${tueClass } cal_today" />
					<c:set var="tueClassKo" value="대기예약"/>
				</c:if>
			</c:if>
			<td class="${empty result.tue.day ? 'cal_blank' : tueClass}"><a data-value="<c:out value="${result.tue.day }" />" href="#self" title="<c:out value="${result.tue.day }"/>일 <c:out value="${tueClassKo}"/>">${empty result.tue.day ? '<span class="sr-only">공백</span>' : result.tue.day}</a></td>

			<c:if test="${not empty result.wed.day && result.wed.diffDay >= 0 && result.wed.diffDay < 30 }">
				<c:set var="wedClass" value="cal_reserv_ok" />
				<c:set var="wedClassKo" value="예약가능"/>
				<c:if test="${result.wed.resveWaitTp eq 'Y' }">
					<c:set var="wedClass" value="cal_reserv_ing" />
					<c:set var="wedClassKo" value="대기예약"/>
				</c:if>
				<c:if test="${result.wed.hldyTp eq 'Y' }">
					<c:set var="wedClass" value="cal_reserv_end" />
					<c:set var="wedClassKo" value="예약불가"/>
				</c:if>
				<c:if test="${ result.wed.todayTp eq 'Y'}">
					<c:set var="wedClass" value="${wedClass } cal_today" />
					<c:set var="wedClassKo" value="대기예약"/>
				</c:if>
			</c:if>
			<td class="${empty result.wed.day ? 'cal_blank' : wedClass}"><a data-value="<c:out value="${result.wed.day }" />" href="#self" title="<c:out value="${wedClassKo}"/>">${empty result.wed.day ? '<span class="sr-only">공백</span>' : result.wed.day}</a></td>

			<c:if test="${not empty result.thu.day && result.thu.diffDay >= 0 && result.thu.diffDay < 30 }">
				<c:set var="thuClass" value="cal_reserv_ok" />
				<c:set var="thuClassKo" value="예약가능"/>
				<c:if test="${result.thu.resveWaitTp eq 'Y' }">
					<c:set var="thuClass" value="cal_reserv_ing" />
					<c:set var="thuClassKo" value="대기예약"/>
				</c:if>
				<c:if test="${result.thu.hldyTp eq 'Y' }">
					<c:set var="thuClass" value="cal_reserv_end" />
					<c:set var="thuClassKo" value="예약불가"/>
				</c:if>
				<c:if test="${ result.thu.todayTp eq 'Y'}">
					<c:set var="thuClass" value="${thuClass } cal_today" />
					<c:set var="thuClassKo" value="대기예약"/>
				</c:if>
			</c:if>
			<td class="${empty result.thu.day ? 'cal_blank' : thuClass}"><a data-value="<c:out value="${result.thu.day }" />" href="#self" title="<c:out value="${thuClassKo}"/>">${empty result.thu.day ? '<span class="sr-only">공백</span>' : result.thu.day}</a></td>

			<c:if test="${not empty result.fri.day && result.fri.diffDay >= 0 && result.fri.diffDay < 30 }">
				<c:set var="friClass" value="cal_reserv_ok" />
				<c:set var="friClassKo" value="예약가능"/>
				<c:if test="${result.fri.resveWaitTp eq 'Y' }">
					<c:set var="friClass" value="cal_reserv_ing" />
					<c:set var="friClassKo" value="대기예약"/>
				</c:if>
				<c:if test="${result.fri.hldyTp eq 'Y' }">
					<c:set var="friClass" value="cal_reserv_end" />
					<c:set var="friClassKo" value="예약불가"/>
				</c:if>
				<c:if test="${ result.fri.todayTp eq 'Y'}">
					<c:set var="friClass" value="${friClass } cal_today" />
					<c:set var="friClassKo" value="대기예약"/>
				</c:if>
			</c:if>
			<td class="${empty result.fri.day ? 'cal_blank' : friClass}"><a data-value="<c:out value="${result.fri.day }" />" href="#self" title="<c:out value="${friClassKo}"/>">${empty result.fri.day ? '<span class="sr-only">공백</span>' : result.fri.day}</a></td>


			<c:if test="${not empty result.sat.day && result.sat.diffDay >= 0 && result.sat.diffDay < 30 }">
				<c:set var="satClass" value="cal_reserv_ok" />
				<c:set var="satClassKo" value="예약가능"/>
				<c:if test="${wkendResvePolsblAt ne 'Y' }">
					<c:set var="satClass" value="cal_reserv_end" />
					<c:set var="satClassKo" value="예약불가"/>
				</c:if>
				<c:if test="${wkendResvePolsblAt eq 'Y' and result.sat.resveWaitTp eq 'Y' }">
					<c:set var="satClass" value="cal_reserv_ing" />
					<c:set var="satClassKo" value="대기예약"/>
				</c:if>
				<c:if test="${result.sat.hldyTp eq 'Y' }">
					<c:set var="satClass" value="cal_reserv_end" />
					<c:set var="satClassKo" value="예약불가"/>
				</c:if>
				<c:if test="${ result.sat.todayTp eq 'Y'}">
					<c:set var="satClass" value="${satClass } cal_today" />
					<c:set var="satClassKo" value="대기예약"/>
				</c:if>
			</c:if>
			<td class="${empty result.sat.day ? 'cal_blank' : satClass}"><a data-value="<c:out value="${result.sat.day }" />" href="#self" title="<c:out value="${satClassKo}"/>" >${empty result.sat.day ? '<span class="sr-only">공백</span>' : result.sat.day}</a></td>
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
$(document).ready(function(){
	$(".cal_none a").attr("tabindex", "-1");
	$(".cal_blank a").attr("tabindex", "-1");
	
})

//]]>
</script>
