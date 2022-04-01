<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>이용자의견</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />


<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.css">

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript">
$(function() {
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
});
</script>
</head>
<body>
	<div id="content">
		<div class="hgroup">
			<h3>이용자의견</h3>
		</div>

		<!-- 게시판 게시물검색 start -->
		<form method="post" name="frm" action="/bos/satisfaction/opinionList.do?siteId=${param.siteId}&status=${param.status}">
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<span class="boardsearch">
					<input type="text" id="sdate" name="sdate" value="${param.sdate}" class="board1" style="width:70px;" title="검색 시작날싸입력 예 2011-10-24" readonly />
					~
					<input type="text" id="edate" name="edate" value="${param.edate}" class="board1" style="width:70px;" title="검색 종료날짜 입력 예 2011-10-24" readonly />
				<label for="stributary" class="blind">게시물 분류 선택</label>
					<select id="stributary" name="searchType" title="검색조건">
					   <option value="0" <c:if test="${param.searchType == 0}">selected</c:if>>메뉴이름</option>
					   <option value="1" <c:if test="${param.searchType == 1}">selected</c:if>>위치</option>
					</select>
				<label for="searchWrd">
					<input id="searchWrd" name="searchTxt" value="${param.searchTxt}" class="searchinput" type="text" title="검색어입력" style="width:150px" />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
				</span>
			</fieldset>
		</div>
		</form>
		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="10%" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="fir">번호</th>
					<th scope="col">메뉴이름</th>
					<th scope="col">위치</th>
					<th scope="col">등록일</th>
					<th scope="col">한줄의견내용</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="varStatus">
				<tr>
					<td>${zvl.totCnt - (zvl.pageIndex-1)*zvl.pageUnit - (varStatus.count-1)}</td>
					<td><a href="${result.fullMenuLink}" target="_blank" title="새창열림">${result.menuNm}</a></td>
					<td>${fn:replace(result.path,'|', '>')}</td>
					<td>${result.regDate}</td>
					<td>${result.opinion}</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="6">데이터가 없습니다.</td></tr>
			</c:if>
			</tbody>
		</table>
	</div>
</div>

	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>

	<div class="btn_set">
		<c:url var="url" value="/bos/satisfaction/statusView.do?siteId=${param.siteId}&sdate=${param.sdate}&edate=${param.edate}" />
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>

<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>
