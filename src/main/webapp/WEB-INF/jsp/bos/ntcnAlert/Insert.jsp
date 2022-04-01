<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>강남구청</title>

<script type="text/javascript" src="/admin/common/js/miya_validator.js"></script>
<script type="text/javascript" src="/admin/common/js/jslb_ajax.js"></script>
<script type="text/javascript" src="/admin/common/js/jquery-1.4.2.js"></script>

<link href="/admin/common/css/pollCss/default.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/pollCss/common.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/pollCss/blue.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/pollCss/board_blue.css" rel="stylesheet" type="text/css" />

<script>

function checkAndSubmit(f) {

	var v = new MiyaValidator(f);

    v.add("file1", {
		required: true
    });
    v.add("alert_nm", {
		required: true
    });
    v.add("alert_url", {
    	required: true
    });
    v.add("pub_sdate", {
    	required: true
    });
    v.add("pub_edate", {
    	required: true
    });
    
	result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return false;
	} else {
		if (confirm('등록하시겠습니까?')) {
			return true;
		} else {
			return false;
		}
	}
};
</script>
</head>
<body style="background:none;padding:10px;">
<h3 class="tit_03">알림 관리</h3>


<form name="fm" method="post" action="<c:url value='/admin/portal/ntcnAlert/insert.do'/>" enctype="multipart/form-data" onsubmit="return checkAndSubmit(this);">

<table class="default_write">
	<caption>알림 관리</caption>
	<colgroup>
		<col width="20%" />
		<col width="80%" />
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="regDateStr">등록일</label></th>
			<td class="output">
				<input type="text" id="regDateStr" style="width: 125px" class="board1" value="<fmt:formatDate value="${Bean.reg_dt}" pattern="yyyy년MM월dd일"/>" readonly="readonly" />
			</td>
		</tr>		
		<tr>
			<th scope="row">사용처</th>
			<td class="output" >
				<input type="radio" name="category" id="category" value="01"/>포탈
				<input type="radio" name="category" id="category" value="06"/>어린이
				<input type="radio" name="category" id="category" value="07"/>보건소
			</td>
		</tr>
		
		<tr>
			<th scope="row"><label for="file1">알림 이미지</label></th>
			<td class="output">
				<input id="file1" name="file1" type="file" title="첨부파일1"  class="board1" size="50" style="width:90%" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="alert_nm">알림명</label></th>
			<td class="output">
				<input type="text" id="alert_nm" name="alert_nm" style="width: 125px" class="board1" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="alert_url">알림 URL</label></th>
			<td class="output">
				<input type="text" value="${Bean.alert_url}" id="alert_url" name="alert_url" style="width: 250px" class="board1" />
			</td>
		</tr>
		<tr>
			<th scope="row">게시 기간</th>
			<td colspan="3" class="output">
				<input type="text" name="pub_sdate" readonly="readonly"/><img src="/bos/images/calendar.gif" width="24" height="22" border="0" align="absmiddle" onclick="Calendar_D(document.fm.pub_sdate)"/>
    			~
				<input type="text" name="pub_edate" readonly="readonly"/><img src="/bos/images/calendar.gif" width="24" height="22" border="0" align="absmiddle" onclick="Calendar_D(document.fm.pub_edate)"/>
			</td>
		</tr>
		<tr>
			<th scope="row">팝업 여부</th>
			<td class="output">
				<label for="popup_Y">
					<input type="radio" id="popup_y" name="popup" value="Y" class="ra" <c:if test="${Bean.popup == 'Y'}">checked</c:if> /> 새창 (Y)
				</label>
				<label for="popup_N">
					<input type="radio" id="popup_N" name="popup" value="N" class="ra" <c:if test="${Bean.publish == 'N'}">checked</c:if> /> 현재창 (N)
				</label>
			</td>
		</tr>
		<tr>
			<th scope="row">표시 여부</th>
			<td class="output">
				<label for="publish_Y">
					<input type="radio" id="publish_Y" name="publish" value="Y" class="ra" <c:if test="${Bean.publish == 'Y'}">checked</c:if> /> 보이기 (Y)
				</label>
				<label for="publish_N">
					<input type="radio" id="publish_N" name="publish" value="N" class="ra" <c:if test="${Bean.publish == 'N'}">checked</c:if> /> 숨기기 (N)
				</label>
			</td>
		</tr>
	</tbody>
</table>


<div class="board_btn_set mt13">
		<span class="btn_del"><input type="submit" value="등록하기" /></span>
		<c:url value="/admin/portal/ntcnAlert/List.do" var="list_url">
			<c:param name="category" value="${Bean.category}"/>
			<c:param name="searchCondition" value="${Bean.searchCondition}"/>
			<c:param name="pageIndex" value="${Bean.pageIndex}"/>
		</c:url>
		<span class="btn_list"><a href="${list_url}">목록보기</a></span>
		
</div>
</form>
</body>
</html>