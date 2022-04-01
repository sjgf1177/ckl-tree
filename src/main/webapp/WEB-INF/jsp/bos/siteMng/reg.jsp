<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/siteMng/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/siteMng/update.do" />
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />




<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript">

	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);
	    v.add("siteName", {
	        required: true
	    });
	    v.add("siteDesc", {
	        required: true
	    });
	    v.add("siteUrl", {
	        required: true
	    });
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (!confirm('등록하시겠습니까?')) {
			return;
		}

		form.submit();
	}

</script>

<title>사이트관리</title>
</head>
<body>

<div id="content">
	<div class="hgroup">
		<h3 >사이트관리</h3>
	</div>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
<input type="hidden" name="siteId" value="${result.siteId}" />
<div class="bdView">
<table>
	<caption>게시판 쓰기</caption>
	<colgroup>
		<col width="15%"/>
		<col width="85%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="siteName">사이트폴더명</label></th>
			<td>
				<input type="text" name="siteName" id="siteName"  class="iput_txt wi100per" value="${result.siteName}" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="siteDesc">사이트명</label></th>
			<td>
				<input type="text" name="siteDesc" id="siteDesc"  class="iput_txt wi100per" value="${result.siteDesc}" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="siteUrl">사이트URL</label></th>
			<td>
				<input type="text" name="siteUrl" id="siteUrl"  class="iput_txt wi100per" value="${result.siteUrl}" />
			</td>
		</tr>
	</tbody>
</table>
</div>
</form>

	<div class="btn_set">
	<c:choose>
	<c:when test="${empty result}" >
		<a class="btn btn-primary" href="javascript:checkForm();"><span>등록</span></a>
	</c:when>
	<c:otherwise>
		<a class="btn btn-info" href="javascript:checkForm();"><span>수정</span></a>
		<a class="btn btn-danger"  href="/bos/siteMng/delete.do?siteId=${result.siteId}" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:otherwise>
	</c:choose>
		<c:url var="url" value="/bos/siteMng/list.do" />
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>

</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>