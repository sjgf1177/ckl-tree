<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />



<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.css">

<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript">
$(function() {
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#pub_sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#pub_edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
});

function checkAndSubmit() {

	var form = $("#fm")[0];
	var v = new MiyaValidator(form);
	var categoryFlag = "${param.category eq '0' ? 'Y' : 'N'}";
	var regFlag = "${empty result ? 'Y' : 'N'}";
	if(regFlag == "Y"){
	    v.add("file1", {
			required: true
	    });
	}

	if(categoryFlag == 'N'){
	    v.add("category", {
			required: true
	    });
	}
    v.add("alert_nm", {
		required: true
    });
    v.add("pub_sdate", {
    	required: true
    });
    v.add("pub_edate", {
    	required: true
    });

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}
	if (confirm('등록하시겠습니까?')) {
		form.submit();
	}
}

</script>
<title>포탈메인화면관리</title>
</head>
<body>
<div id="content">
	<div class="hgroup">
		<h3 class="tit_03">하단배너관리</h3>
	</div>

<c:set var="action" value="${empty result ? '/bos/ntcnAlert/insert.do' : '/bos/ntcnAlert/update.do'}" />
<form id="fm" name="fm" method="post" action="${action}" enctype="multipart/form-data">
		<input type="hidden" name="type" value="04" />
		<input type="hidden" name="category" value="2" />
<c:if test="${not empty result}">
	<input type="hidden" name="alert_cd" value="${result.alert_cd}" />
</c:if>

<div class="bdView">
<table>
	<caption>알림 관리 수정</caption>
	<colgroup>
		<col width="15%"/>
		<col width="85%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="file1">이미지</label></th>
			<td class="output">
			<c:if test="${not empty result}">
				<input type="hidden" name="img_org_nm" value="${result.img_org_nm}" />
				<input type="hidden" name="img_nm" value="${result.img_nm}" />
				<img src="/files/ntcnAlert/${result.img_nm}" style="border: 0px;" width="252" height="143"/>
				<br/>
			</c:if>
				<input id="file1" name="file1" type="file" title="첨부파일1" class="board1" size="50" style="width:90%" />
				<br/>
				 이미지 권장사이즈 : 341 * 111<br/>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="alert_nm">알림명</label></th>
			<td class="output">
				<input type="text" id="alert_nm" name="alert_nm" value="${result.alert_nm}" style="width: 600px" class="board1" />
			</td>
		</tr>

		<tr>
			<th scope="row"><label for="alert_url">알림 URL</label></th>
			<td class="output">
				<input type="text" id="alert_url" name="alert_url" value="${result.alert_url}" style="width: 600px" class="board1" />
			</td>
		</tr>

		<tr>
			<th scope="row">게시 기간</th>
			<td colspan="3" class="output">
				<input type="text" id="pub_sdate" name="pub_sdate" value="<fmt:formatDate value="${result.pub_sdate}" pattern="yyyy-MM-dd"/>"/>
    			~
				<input type="text" id="pub_edate" name="pub_edate" value="<fmt:formatDate value="${result.pub_sdate}" pattern="yyyy-MM-dd"/>"/>
			</td>
		</tr>

		<tr>
			<th scope="row">팝업 여부</th>
			<td class="output">
				<label for="popup_Y">
					<input type="radio" id="popup_y" name="popup" value="Y" class="ra" <c:if test="${result.popup == 'Y'}">checked</c:if> /> 새창 (Y)
				</label>
				<label for="popup_N">
					<input type="radio" id="popup_N" name="popup" value="N" class="ra" <c:if test="${result.popup == 'N'}">checked</c:if> /> 현재창 (N)
				</label>
			</td>
		</tr>

		<tr>
			<th scope="row">표시 여부</th>
			<td class="output">
				<label for="publish_Y">
					<input type="radio" id="publish_Y" name="publish" value="Y" class="ra" <c:if test="${result.publish == 'Y'}">checked</c:if> /> 보이기 (Y)
				</label>
				<label for="publish_N">
					<input type="radio" id="publish_N" name="publish" value="N" class="ra" <c:if test="${result.publish == 'N'}">checked</c:if> /> 숨기기 (N)
				</label>
			</td>
		</tr>

	</tbody>

</table>
</div>
</form>

	<div class="btn_set">
	<c:choose>
	<c:when test="${empty result}" >
		<a class="btn btn-primary" href="javascript:checkAndSubmit();"><span>등록</span></a>
	</c:when>
	<c:otherwise>
		<a class="btn btn-info" href="javascript:checkAndSubmit();"><span>수정</span></a>
		<c:url value="/bos/ntcnAlert/delete.do" var="del_url">
			<c:param name="type" value="04"/>
			<c:param name="alert_cd" value="${result.alert_cd}"/>
			<c:param name="category" value="${param.category}"/>
		</c:url>
		<a class="btn btn-danger"  href="${del_url}" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:otherwise>
	</c:choose>
		<c:url value="/bos/ntcnAlert/List.do" var="list_url" >
			<c:param name="type" value="04"/>
			<c:param name="category" value="${param.category}"/>
		</c:url>
		<a class="btn btn-primary" href="${list_url}"><span>목록</span></a>
	</div>

</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>