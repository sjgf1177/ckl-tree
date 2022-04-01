<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>${appMst.applyName}</title>
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
$(function(){
	$("#pageUnit").change(function(){
		var size = $(this).val();
		$("#frm")[0].submit();
	});

	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
});
</script>

</head>
<body>
	<div id="content">
		<div class="hgroup">
			<h3>페이지만족도</h3>
		</div>

		<!-- 게시판 게시물검색 start -->
		<form method="post" name="frm" action="/bos/satisfaction/statusView.do">
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>사이트선택
				<select id="siteId" name="siteId" class="input_select">
				    	<%-- <option value="">사이트선택</option> --%>
					 <c:forEach var="site" items="${siteList}" varStatus="status">
					 	<c:set var="data"><util:fz source="${site.siteId}" resultLen="2" isFront="true" /></c:set>
					    <c:if test="${site.siteId ne '1' }"><option value='${data}' <c:if test='${fn:indexOf(data,param.siteId) ne -1 and not empty param.siteId}'>selected='selected'</c:if> >${site.siteDesc}</option></c:if>
					 </c:forEach>
				</select>
				<span class="boardsearch">
					<input type="text" id="sdate" name="sdate" value="${param.sdate}" class="board1" style="width:70px;" title="검색 시작날싸입력 예 2011-10-24" readonly />
					~
					<input type="text" id="edate" name="edate" value="${param.edate}" class="board1" style="width:70px;" title="검색 종료날짜 입력 예 2011-10-24" readonly />

				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
				</span>
			</fieldset>
		</div>
		</form>
		<!-- board list start -->
		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="15%" />
				<col width="15%" />
				<col width="*" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">만족도</th>
					<th scope="col">비율</th>
					<th scope="col">그래프</th>
					<th scope="col" class="last">참여수</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="item" items="${resultMap}" varStatus="status">
				<tr>
					<td class="output"><a href="/bos/satisfaction/opinionList/${item.value.status}.do?siteId=${param.siteId}&sdate=${param.sdate}&edate=${param.edate}"><strong style="color: drakgray;">${item.value.statusName}</strong></a>
					</td>
					<td class="output">${item.value.statusCnt}/${item.value.totCnt}(${item.value.statusPercent}%)</td>
					<td class="output tal">
						 <img src="/images/grp1.gif" style="width:${item.value.statusPercent}%; height:8px" alt="" />
					</td>
					<td class="output"><a href="/bos/satisfaction/opinionList.do?siteId=${param.siteId}&status=${item.value.status}&sdate=${param.sdate}&edate=${param.edate}"><strong style="color: drakgray;">${item.value.statusCnt}</strong></a></td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultMap) == 0}"><tr><td colspan="9">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
</div>

<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>