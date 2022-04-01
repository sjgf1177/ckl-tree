<%@page import="egovframework.com.cmm.service.FileVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<script type="text/javascript">

$(function(){
	// 달력 팝업
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#startDt").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#endDt").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});

	// 취소 버튼 이벤트
	$(".addTimeCancleBtn").click(function(){
		$(".ui-dialog-titlebar-close").click();
	});
	// json
	$.fn.serializeFormJSON = function () {

	        var o = {};
	        var a = this.serializeArray();
	        $.each(a, function () {
	            if (o[this.name]) {
	                if (!o[this.name].push) {
	                    o[this.name] = [o[this.name]];
	                }
	                o[this.name].push(this.value || '');
	            } else {
	                o[this.name] = this.value || '';
	            }
	        });
	        return o;
    };
});

function checkForm() {

	var form = document.frmTime;
	var v = new MiyaValidator(form);

	$("#startTime").val($("#startDt").val()+" "+$("#concertStartHr").val()+$("#concertStartMin").val());
	v.add("startTime", {
		required : true
	});
	$("#endTime").val($("#startDt").val()+" "+$("#concertEndHr").val()+$("#concertEndMin").val());
	v.add("endTime", {
		required : true
	});
	v.add("startDt", {
		required : true
	});
	// 시작시간 종료시간 비교
	if ( $("#startTime").val() > $("#endTime").val() ){
		alert("시작시간과 종료시간을 다시 입력해주세요.");
		return ;
	}
	if ( $("[name='repeatDay']:checked").length > 0 )
		v.add("endDt", {
			required : true
		});
	// 날짜 순서 비교
	if ( $("#startDt").val() > $("#endDt").val() ){
		alert("공연 일시와 반복 종료일을 다시 입력해주세요.");
		return ;
	}
	// 반복요일 리스트
	var repeatDays = $("[name='repeatDay']:checked").map(function() { return this.value; }).get().join(',');
	$("#repeatDays").val( repeatDays ); 
	if ( $("#endDt").val() != '' )
		v.add("repeatDays", {
			required : true
		});

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

// 	if (!confirm("${empty result ? '등록' : '수정'}하시겠습니까?")) {
	if (!confirm("선택하신 시간을 ${empty result ? '등록' : '수정'}하시겠습니까?\n공연시간을 다시한번 확인해주세요.")) {
	    return;
	}
	
	//form.submit();
	$.ajax({
		url : '/bos/concert/time/insert.json',
		dataType : 'json',
		data : $(form).serializeFormJSON(),
		success : function(data) {
			if (data.resultCode == 'success') {
				location.reload();
			} else {
				alert(data.msg);
			}
		}
	});
}
</script>

<div id="wrap" class="popupWrap">
	<div class="row">
         <div class="col-md-12">
             <h1>공연일정등록</h1>
             <div class="panel panel-default">
				<div class="panel-body">
				<form name="frmTime" method="post" action="?" enctype="multipart/form-data">
				<input type="hidden" name="concertId" id="concertId" value="${result.concertId}">
				<input type="hidden" name="repeatDays" id="repeatDays" value="${result.repeatDays}">
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
											<input type="hidden" name="startTime" id="startTime" value="${result.startTime}">
											<input type="hidden" name="endTime" id="endTime" value="${result.endTime}">
											<input type="text" name="startDt" id="startDt" style="width:110px" title="예약시작일 입력" value="${startDt}" readonly="readonly" />
											
											<select id="concertStartHr" name="concertStartHr" style="width:60px" title="예약시작 시간">
											    <option value="">선택</option>
											<c:forEach var="x" begin="0" end="23">
												<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
												<option value="${val}" <c:if test="${val eq result.concertStartHr}">selected="selected"</c:if>>${val}시</option>
											</c:forEach>
											</select>
											
											<select id="concertStartMin" name="concertStartMin" style="width:60px" title="예약시작분">
											    <option value="">선택</option>
											<c:forEach var="x" begin="0" end="59" step="5">
												<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
												<option value="${val}" <c:if test="${val eq result.concertStartMin}">selected="selected"</c:if>>${val}분</option>
											</c:forEach>
											</select>
											&nbsp;~&nbsp;
											<select id="concertEndHr" name="concertEndHr" style="width:60px" title="예약마감 시간">
											    <option value="">선택</option>
											<c:forEach var="x" begin="0" end="23">
												<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
												<option value="${val}" <c:if test="${val eq result.concertEndHr}">selected="selected"</c:if>>${val}시</option>
											</c:forEach>
											</select>
											
											<select id="concertEndMin" name="concertEndMin" style="width:60px" title="예약마감분">
											    <option value="">선택</option>
											<c:forEach var="x" begin="0" end="59" step="5">
												<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
												<option value="${val}" <c:if test="${val eq result.concertEndMin}">selected="selected"</c:if>>${val}분</option>
											</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<th scope="row" ><label for="srh_dtlsInfo">반복 종료일</label></th>
										<td>
											<%-- <c:set var="beginMin">${fn:substring(result.beginDt, 14, 16)}</c:set> --%>
											<input type="text" name="endDt" id="endDt" style="width:110px" title="반복 종료일 입력" value="${endDt}" readonly="readonly" />
											<label><input type="checkbox" name="repeatDay" id="repeatDay1" value="2"/>월</label>
											<label><input type="checkbox" name="repeatDay" id="repeatDay2" value="3"/>화</label>
											<label><input type="checkbox" name="repeatDay" id="repeatDay3" value="4"/>수</label>
											<label><input type="checkbox" name="repeatDay" id="repeatDay4" value="5"/>목</label>
											<label><input type="checkbox" name="repeatDay" id="repeatDay5" value="6"/>금</label>
											<label><input type="checkbox" name="repeatDay" id="repeatDay6" value="7"/>토</label>
											<label><input type="checkbox" name="repeatDay" id="repeatDay7" value="1"/>일</label>
										</td>
									</tr>
									<tr>
										<th scope="row" ><label for="commentMsg">비고</label></th>
										<td><input type="text" name="commentMsg" id="commentMsg" value="" class="w500" /></td>
									</tr>
								</tbody>
								</table>
							</div>
					</fieldset>
				</form>
				<div class="btnSet tar">
					<a href="javascript:checkForm();" class="btn btn-primary">등록</a>
					<a href="#self" class="btn btn-primary addTimeCancleBtn">취소</a>
				</div>
				</div>
			</div>
	</div>
</div>

<script type="text/javascript">

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