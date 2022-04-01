<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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
<script type="text/javascript" src="/portal/open_content/system/js/Calendar.js" ></script>

<link href="/admin/common/css/pollCss/default.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/pollCss/common.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/pollCss/blue.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/pollCss/board_blue.css" rel="stylesheet" type="text/css" />

<script>

function checkAndSubmit() {

	if (confirm('삭제하시겠습니까?')) {
		return true;
	} else {
		return false;
	}
};
</script>
</head>
<body style="background:none;padding:10px;">
<h3 class="tit_03">알림 관리</h3>

<table class="bdView">
	<caption>알림 관리</caption>
	<colgroup>
		<col width="20%" />
		<col width="80%" />
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="renew_date">변경일자</label></th>
			<td class="output">
				<fmt:formatDate value="${result.last_mod_dt}" pattern="yyyy년MM월dd일"/>
			</td>
		</tr>
		<tr>
			<th scope="row">구분</th>
			<td class="output">
				<c:choose>
					<c:when test="${result.category == '00'}">포탈</c:when>
					<c:when test="${result.category == '07'}">보건소</c:when>
					<c:when test="${result.category == '99'}">구의회</c:when>
					<c:when test="${result.category == '06'}">구의회</c:when>
				</c:choose>
			</td>
		</tr>

		<tr>
			<th scope="row">알림명</th>
			<td class="output">
				${result.alert_nm}
			</td>
		</tr>

		<tr>
			<th scope="row">알림 URL</th>
			<td class="output">
				${result.alert_url}
			</td>
		</tr>

		<tr>
			<th scope="row">알림 이미지</th>
			<td class="output">
				<img src="/portal/images/alert/${result.img_nm}" style="border: 0px;"/>
			</td>
		</tr>

		<tr>
			<th scope="row">게시 기간</th>
			<td colspan="3" class="output">
				<fmt:formatDate value='${result.pub_sdate}' pattern='yyyy년MM월dd일'/>
    			~
				<fmt:formatDate value='${result.pub_edate}' pattern='yyyy년MM월dd일'/>
			</td>
		</tr>

		<tr>
			<th scope="row">팝업 여부</th>
			<td class="output">
				<c:choose>
					<c:when test="${result.popup == 'Y'}">새창 (Y)</c:when>
					<c:when test="${result.popup == 'N'}">현재창 (N)</c:when>
				</c:choose>
			</td>
		</tr>

		<tr>
			<th scope="row">표시 여부</th>
			<td class="output">
				<c:choose>
					<c:when test="${result.publish == 'Y'}">보이기 (Y)</c:when>
					<c:when test="${result.publish == 'N'}">숨기기 (N)</c:when>
				</c:choose>
			</td>
		</tr>

	</tbody>
</table>

<div class="board_btn_set mt13">
		<c:url value="/admin/portal/ntcnAlert/List.do" var="list_url">
			<c:param name="pageIndex" value="${Bean.pageIndex}"/>
			<c:param name="searchCondition" value="${Bean.searchCondition}"></c:param>
			<c:param name="category" value="${Bean.category}"></c:param>
		</c:url>
		<span class="btn_list"><a href="${list_url}">목록보기</a></span>

		<c:url value="/admin/portal/ntcnAlert/delete.do" var="del_url">
			<c:param name="alert_cd" value="${result.alert_cd}"/>
			<c:param name="pageIndex" value="${Bean.pageIndex}"/>
			<c:param name="searchCondition" value="${Bean.searchCondition}"></c:param>
			<c:param name="category" value="${Bean.category}"></c:param>
		</c:url>
			<span class="btn_del"><a href="${del_url}">삭제하기</a></span>

		<c:url value="/admin/portal/ntcnAlert/forUpdate.do" var="upt_url">
			<c:param name="alert_cd" value="${result.alert_cd}"/>
			<c:param name="pageIndex" value="${Bean.pageIndex}"/>
			<c:param name="searchCondition" value="${Bean.searchCondition}"></c:param>
			<c:param name="category" value="${Bean.category}"></c:param>
		</c:url>
			<span class="btn_del"><a href="${upt_url}">수정하기</a></span>
</div>

</body>
</html>
