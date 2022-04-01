<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<base target="_self">
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />
<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.css">

<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>

<script type="text/javascript">
$(function(){

	$("input[name^=fieldAttribute]").click(function(){
		var idx = $(this).attr("id").replace("chk_", "");
		if(this.checked){
			$("#typeSpan_"+idx).show();
		}
		else{
			$("input[name^=fieldType_"+idx+"]").attr("checked", "");
			$("#typeSpan_"+idx).hide();
		}
	});
});

function checkForm()
{
	var form = document.frm2;
	var v = new MiyaValidator(form);
    v.add("fieldAttributeIdx", {
        required: true
    });
	result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	form.submit();
}
</script>

	<div id="content">
		<div class="hgroup">
			<h3>필드내용</h3>
		</div>

<!-- board list start -->
<form name="frm2" method="post" action="/bos/pg/addFieldAttr.do">
	<input type="hidden" name="pageCode" value="${param.pageCode}" />
	<input type="hidden" name="pageType" value="${param.pageType}" />
	<input type="hidden" name="menuNo" value="${param.menuNo}" />
<div>
	<table class="table table-bordered table-striped table-hover">
	<caption>민원업무 및 담당자를 검색</caption>
	<colgroup>
		<col width="15%" />
		<col width="20%" />
		<col width="15%" />
		<col width="*" />
		<col width="10%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col" class="fir">선택</th>
			<th scope="col">name</th>
			<th scope="col">text</th>
			<th scope="col">type</th>
			<th scope="col">목록노출</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="result" items="${fieldAttributes}" varStatus="status">
		<tr>
			<td>
				<input type="hidden" name="fieldName_${status.count}" value="${result.fieldName}" />
				<input type="checkbox" id="chk_${status.count}" name="fieldAttributeIdx" value="${status.count}" <c:if test="${not empty result.fieldType}"> checked</c:if> />
				<input type="hidden" name="fieldId" value="${result.fieldId}" />
			</td>
			<td>${result.fieldName}</td>
			<td>
				<input type="text" name="fieldText_${status.count}" id="fieldText_${status.count}" style="width:200px" class="board1" value="${result.fieldText}" />
			</td>
			<td>
				<span id="typeSpan_${status.count}" ${empty result.fieldType ? 'style="display:none"' : 'style="display:"'}>
					<input type="radio" id="emptyType_${status.count}" name="fieldType_${status.count}" value="empty" ${result.fieldType=='empty'?'checked':''} />empty
					<input type="radio" id="textType_${status.count}" name="fieldType_${status.count}" value="text" ${result.fieldType=='text' || empty result.fieldType?'checked':''} />text
					<input type="radio" id="radioType_${status.count}" name="fieldType_${status.count}" value="radio" ${result.fieldType=='radio'?'checked':''} />radio
					<input type="radio" id="checkboxType_${status.count}" name="fieldType_${status.count}" value="checkbox" ${result.fieldType=='checkbox'?'checked':''} />checkbox
					<input type="radio" id="selectType_${status.count}" name="fieldType_${status.count}" value="select" ${result.fieldType=='select'?'checked':''} />select
				</span>
			</td>
			<td>
				<input type="checkbox" id="chk_${status.count}" name="fieldList_${status.count}" value="Y" <c:if test="${result.fieldList eq 'Y'}"> checked</c:if> />
			</td>
		</tr>
	</c:forEach>
	<c:if test="${fn:length(fieldAttributes) == 0}" >
		<tr><td colspan="5">데이터가없습니다.</td></tr>
	</c:if>
	</tbody>
</table>
</div>
<!-- board list end //-->
</form>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:checkForm();"><span>등록</span></a>
	</div>

</div>

<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>