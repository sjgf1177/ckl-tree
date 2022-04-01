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
	
	<title><spring:message code='site.korName' text=''/></title>
<link href="/admin/common/css/pollCss/default.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/pollCss/common.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/pollCss/blue.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/pollCss/board_blue.css" rel="stylesheet" type="text/css" />


<script type="text/javascript" src="/admin/common/js/miya_validator.js"></script>
<script type="text/javascript">

function setNum(obj) {
    var val=obj.value;
    var re=/[^0-9]/gi;
    obj.value=val.replace(re,"");
};

function checkAndSubmit(f) {
	var v = new MiyaValidator(f);

    v.add("title", {
		required: true
    });
    v.add("start_dt", {
		required: true
    });
    v.add("end_dt", {
		required: true
    });
    v.add("contents", {
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
<h2 style="padding:15px 0 15px 0;">	
		설문
</h2>
<p class="title_deco"></p>
<div class="body">

<form name="fm" method="post" action="<c:url value='/admin/portal/poll/checkform/insert.do'/>" enctype="multipart/form-data" onsubmit="return checkAndSubmit(this);">
	<input type="hidden" name="year_cd" value="000000" />

	<table class="bdView">
		<caption>자율점검 (점검표관리)</caption>
		<colgroup>
			<col width="20%" />
			<col width="30%" />
			<col width="20%" />
			<col width="30%" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><label for="title">제목</label></th>
				<td class="output" colspan="3">
					<input type="text" name="title" id="title" style="width: 300px; padding-left: 5px;" class="board1"/>
				</td>
			</tr>
			
			<tr>
				<th scope="row">응모기간</th>
				<td class="output" colspan="3">
					<input type="text" name="start_dt" id="start_dt" title="응모기간 (시작일자)" style="width: 80px; padding-left: 5px;" class="board1" readonly="readonly"/><img src="/bos/images/calendar.gif" width="24" height="22" border="0" onclick="Calendar_D(document.fm.start_dt)"/>
					<span style="width: 5px;"></span> ~ <span style="width: 5px;"></span>
					<input type="text" name="end_dt" id="end_dt" title="응모기간 (종료일자)" style="width: 80px; padding-left: 5px;" class="board1" readonly="readonly"/><img src="/bos/images/calendar.gif" width="24" height="22" border="0" onclick="Calendar_D(document.fm.end_dt)"/>
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="contents">내용</label></th>
				<td class="outputEditor" colspan="3">
					<textarea name="contents" id="contents" cols="50" rows="20" title="내용" style="width:100%;"></textarea>
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="tel">첨부파일</label></th>
				<td class="output" colspan="3">
					<input name="file1" type="file" title="첨부파일1" class="board1" size="50" style="width:90%;  padding-left: 5px;" />
				</td>
			</tr>
			
		</tbody>
	</table>

		<input type="hidden" name="searchKeyword" value="${Bean.searchKeyword}"/>
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="등록하기" /></span>
	
		<c:url var="list_action" value="/admin/portal/poll/checkform/list.do">
			<c:param name="searchKeyword" value="${Bean.searchKeyword}"/>
		</c:url>
	<span class="btn_list"><a href="${list_action}">목록보기</a></span>
</div>			
</form>

</div>
</body>
</html>
