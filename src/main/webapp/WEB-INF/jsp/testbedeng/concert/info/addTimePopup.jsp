<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="wrap" class="popupWrap">
	<div class="row">
         <div class="col-md-12">
             <h1>공연일정등록</h1>
             <div class="panel panel-default">
				<div class="panel-body">
				<form action="/bos/concert/time/insert.do" name="addTimePopForm" id="addTimePopForm" method="get">
					<fieldset>
						<legend>공연일정등록</legend>
							<div class="bdView mb0">
								<table class="table table-bordered">
								<caption>공연일정등록</caption>
								<colgroup>
								<col />
								<col />
								<col />
								<col />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row" ><label for="srh_eqpmnNm">일시선택</label></th>
										<td>
											<input type="hidden" name="scheduleTime" id="scheduleTime" value="${result.scheduleTime}">
											<c:set var="scheduleDt">${fn:substring(result.scheduleTime, 0, 0)}</c:set>
											<c:set var="scheduleTm">${fn:substring(result.scheduleTime, 11, 3)}</c:set>
											<%-- <c:set var="beginMin">${fn:substring(result.beginDt, 4, 6)}</c:set> --%>
											<input type="text" name="scheduleDt" id="scheduleDt" style="width:110px" title="예약시작일 입력" value="${scheduleDt}" readonly="readonly" />
											
											<select id="scheduleTm" name="scheduleTm" style="width:60px" title="예약시작 시간">
											    <option value="">선택</option>
											<c:forEach var="x" begin="0" end="23">
												<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
												<option value="${val}" <c:if test="${val eq result.scheduleTimeHh}">selected="selected"</c:if>>${val}시</option>
											</c:forEach>
											</select>
											
											<select id="endMin" name="endMin" style="width:60px" title="예약마감분">
											    <option value="">선택</option>
											<c:forEach var="x" begin="0" end="59">
												<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
												<option value="${val}" <c:if test="${val eq result.reservEndTimeMi}">selected="selected"</c:if>>${val}분</option>
											</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<th scope="row" ><label for="srh_dtlsInfo">반복 종료일</label></th>
										<td>
											<input type="hidden" name="repeatTime" id="repeatTime" value="${result.repeatTime}">
											<c:set var="repeatDt">${fn:substring(result.repeatTime, 0, 10)}</c:set>
											<c:set var="repeatTm">${fn:substring(result.repeatTime, 11, 13)}</c:set>
											<%-- <c:set var="beginMin">${fn:substring(result.beginDt, 14, 16)}</c:set> --%>
											<input type="text" name="repeatDt" id="repeatDt" style="width:110px" title="예약시작일 입력" value="${repeatDt}" readonly="readonly" />
											<label><input type="checkbox" name="repeatDay" id="repeatDay1" value="mon"/>월</label>
											<label><input type="checkbox" name="repeatDay" id="repeatDay2" value="mon"/>화</label>
											<label><input type="checkbox" name="repeatDay" id="repeatDay3" value="mon"/>수</label>
											<label><input type="checkbox" name="repeatDay" id="repeatDay4" value="mon"/>목</label>
											<label><input type="checkbox" name="repeatDay" id="repeatDay5" value="mon"/>금</label>
											<label><input type="checkbox" name="repeatDay" id="repeatDay6" value="mon"/>토</label>
											<label><input type="checkbox" name="repeatDay" id="repeatDay7" value="mon"/>일</label>
										</td>
									</tr>
									<tr>
										<th scope="row" ><label for="srh_dtlsInfo">비고</label></th>
										<td><input type="text" name="dtlsInfo" id="srh_dtlsInfo" value="" class="w500" /></td>
									</tr>
								</tbody>
								</table>
							</div>
					</fieldset>
				</form>
				<div class="btnSet tar">
					<a href="#self" id="addTimeBtn" class="btn btn-primary">등록</a>
					<a href="#self" class="btn btn-primary addTimeCancleBtn">취소</a>
				</div>
				</div>
			</div>
	</div>
</div>

<script type="text/javascript">

$(function(){
	// 달력 팝업
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#scheduleDt").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#repeatDt").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});

	// 취소 버튼 이벤트
	$(".addTimeCancleBtn").click(function(){
		$(".ui-dialog-titlebar-close").click();
	});
});
//<![CDATA[

/* 
	$("#addTimeBtn").click(function() {
		var url = "/bos/fcltyResve/fclty/eqpmnPopup.json";
		var params = $("#addTimePopForm").serialize();
		$.get(url, params, function(data) {
			var $trClone = $(".tmp_eqpmnPopList > tr").clone();
			$(".eqpmnPopList").empty();
			$.each(data.eqpmnList, function(key, item) {
				$trClone.find(".data_eqpmnSns").val(item.eqpmnSn);
				$trClone.find(".data_eqpmnNms").text(item.eqpmnNm);
				$trClone.find(".data_eqpmnQy").text(item.eqpmnQy);
				$trClone.find(".data_resveSeNm").text(item.resveSeNm);
				$trClone.find(".data_useAt").text(item.useAt == "Y" ? "사용" : "미사용");
				$trClone.appendTo($(".eqpmnPopList"));
			});
			if (data.eqpmnList.length == 0) {
				$("<tr>").append($("<td>").attr({"class" : "tac", "colspan" : "5"}).text("- 검색 결과가 없습니다 -")).appendTo($(".eqpmnPopList"));
			}

		},"json");
	});

	$("#eqpmnPopCnfrmBtn").click(function() {
		//$("eqpmnNms").val();
		if ($(".eqpmnPopList").find(".data_eqpmnSns").filter(":checked").size() == 0) {
			alert("장비를 선택해 주세요.");
			return false;
		}

		var eqpmnSns = [];
		var eqpmnNms = [];
		$(".eqpmnPopList").find(".data_eqpmnSns").filter(":checked").each(function(n) {
			eqpmnSns.push($(this).val());
			eqpmnNms.push($(this).closest("tr").find(".data_eqpmnNms").text());
		});
		$("#eqpmnNms").val(eqpmnNms.join(","));
		$("#eqpmnSns").val(eqpmnSns.join(","));

		$(".ui-dialog-titlebar-close").trigger("click");
	});
	 */

//]]>
</script>