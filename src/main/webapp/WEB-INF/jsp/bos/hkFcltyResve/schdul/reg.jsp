<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>

<c:set var="action" value="" />
<c:set var="actTp" value="" />
<c:if test="${empty result}">
	<c:set var="action" value="/bos/hkFcltyResve/schdul/insert.do" />
	<c:set var="actTp" value="insert" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/hkFcltyResve/schdul/update.do" />
	<c:set var="actTp" value="update" />
</c:if>

<script type="text/javascript">
//<![CDATA[
var actTp = "<c:out value="${actTp}" />";

$(function() {
	$("#delBtn").click(function() {
		if (confirm("삭제 하시겠습니까?")) {
			location.href =  $(this).attr("href");
		}
		return false;
	});

	$("#regBtn").click(function() {
		checkForm();
		return false;
	});
});




function checkForm() {
	var form = $("#schdulForm")[0];
	var v = new MiyaValidator(form);


    v.add("eventNm", {
        required: true
    });

    v.add("eventDt", {
        required: true
    });

    v.add("eventBeginTime", {
        required: true,
        option : "number"
    });

    v.add("eventEndTime", {
        required: true,
        option : "number"
    });

    v.add("place", {
        required: true
    });


	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	var msg = "등록";
	if (actTp == "update") msg = "수정";
	if (confirm(msg + "하시겠습니까?")) form.submit();
}

//]]>
</script>

<form id="schdulForm" name="schdulForm" method="post" action="<c:out value="${action }" />" class="form-inline">
<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
<input type="hidden" name="eventSn" id="eventSn" value="<c:out value="${result.eventSn }" />" />

<div class="bdView">

	<table class="table table-bordered">
		<caption>

		</caption>
		<colgroup>
		<col />
		<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="eventNm">행사명</label></th>
				<td><input type="text" name="eventNm" id="eventNm" value="<c:out value="${result.eventNm }" escapeXml="false" />" class="col-md-12" /></td>
			</tr>
			<tr>
				<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="schdulDe">행사일자</label></th>
				<td><input type="text" id="eventDt" name="eventDt"  class="sdate" title="일자 입력" style="width:130px" value="<c:out value="${result.eventDt }" />" readonly="readonly" /></td>
			</tr>
			<tr>
				<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="schdulDe">행사일시</label></th>
				<td>
					<input type="text" id="eventBeginTime" name="eventBeginTime" title="행사시작시간 입력" style="width:90px" value="<c:out value="${result.eventBeginTime }" />" />시
					~ <input type="text" id="eventEndTime" name="eventEndTime" title="행사종료시간 입력" style="width:90px" value="<c:out value="${result.eventEndTime }" />" />시

				</td>
			</tr>
			<tr>
				<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="place">장소</label></th>
				<td><input type="text" name="place" id="place" value="<c:out value="${result.place }" escapeXml="false" />" class="col-md-12" /></td>
			</tr>
		</tbody>
	</table>

</div>

<div class="row clear mt20 tac">
	<div class="col-md-12">
		<a class="btn btn-primary" href="#self" id="regBtn"><span>확인</span></a>
		<c:if test="${actTp eq 'update' }">
		<a class="btn btn-primary" href="/bos/hkFcltyResve/schdul/delete.do?eventSn=<c:out value="${result.eventSn }" />&amp;${pageQueryString }" id="delBtn"><span>삭제</span></a>
		</c:if>
		<a class="btn btn-default" href="/bos/hkFcltyResve/schdul/list.do?${pageQueryString }"><span>취소</span></a>
	</div>
</div>

</form>