<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>

<c:set var="action" value="" />
<c:set var="actTp" value="" />
<c:if test="${empty result}">
	<c:set var="action" value="/bos/fcltyResve/hldy/insert.do" />
	<c:set var="actTp" value="insert" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/fcltyResve/hldy/update.do" />
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
	var form = $("#hldyForm")[0];
	var v = new MiyaValidator(form);


    v.add("hldyNm", {
        required: true
    });

    v.add("hldyDe", {
        required: true
    });

    v.add("useAt", {
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

<form id="hldyForm" name="hldyForm" method="post" action="<c:out value="${action }" />" class="form-inline">
<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
<input type="hidden" name="pageQueryString" id="pageQueryString" value="${pageQueryString }" />
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
				<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="hldyNm">휴일명</label></th>
				<td><input type="text" name="hldyNm" id="hldyNm" value="<c:out value="${result.hldyNm }" />" class="col-md-12" /></td>
			</tr>
			<tr>
				<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="hldyDe">일자</label></th>
				<td><input type="text" id="hldyDe" name="hldyDe"  class="sdate" title="일자 입력" style="width:130px" value="<c:out value="${result.hldyDe }" />" readonly="readonly" /></td>
			</tr>
			<tr>
				<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 사용여부</th>
				<td>
					<label for="useAt01"><input type="radio" name="useAt" value="Y" id="useAt01" <c:if test="${result.useAt eq 'Y' }">checked="checked"</c:if> /> 사용 </label>
					<label for="useAt02"><input type="radio" name="useAt" value="N" id="useAt02" <c:if test="${result.useAt eq 'N' }">checked="checked"</c:if> /> 미사용 </label>
				</td>
			</tr>
		</tbody>
	</table>

</div>

<div class="row clear mt20 tac">
	<div class="col-md-12">
		<a class="btn btn-primary" href="#self" id="regBtn"><span>확인</span></a>
		<c:if test="${actTp eq 'update' }">
		<a class="btn btn-primary" href="/bos/fcltyResve/hldy/delete.do?hldyDe=<c:out value="${result.hldyDe }" />&amp;${pageQueryString }" id="delBtn"><span>삭제</span></a>
		</c:if>
		<a class="btn btn-default" href="/bos/fcltyResve/hldy/list.do?${pageQueryString }"><span>취소</span></a>
	</div>
</div>

</form>