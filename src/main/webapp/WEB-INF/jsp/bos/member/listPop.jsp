<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />
<meta name="keywords" content="<spring:message code='site.korName' text=''/>" />
<meta name="description" content="<spring:message code='site.korName' text=''/>" />
<meta name="author" content="<spring:message code='site.korName' text=''/>" />
<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {
		$("#chkAll").click(function(){
			if(this.checked)
				$(":checkbox").attr("checked", true);
			else
				$(":checkbox").attr("checked", false);
		});
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$("#sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
		$("#edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	});

	function selectMember(){
		if($(":checkbox:checked").length == 0)
		{
			alert("관리자를 선택하세요.");
			return;
		}

		var f = document.frm2;
		f.action = "/bos/sndEmail/insert.do";
		f.submit();
	}

	function search(){
		var f = document.frm2;
		f.action = "/bos/member/listPop.do";
		f.submit();
	}
</script>

<title>직원관리</title>
</head>
<body>
	<div id="content" class="ml25">
		<div class="hgroup">
			<h3>직원관리</h3>
		</div>

<form name="frm2" method="post" action="/bos/member/listPop.do">
	<input type="hidden" name="bbsId" value="${paramVO.bbsId}" />
		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<input type="text" id="sdate" name="sdate" value="${param.sdate}" size="10" /> ~
			    <input type="text" id="edate" name="edate" value="${param.edate}" size="10" />

				<label for="stributary" class="blind">검색조건</label>
				<select id="stributary" name="searchCnd" title="검색조건">
				   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >아이디</option>
				   <option value="4" <c:if test="${paramVO.searchCnd == '4'}">selected="selected"</c:if> >이름</option>
				</select>
						<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchWrd" value="${paramVO.searchWrd}" />
						<input id="input2" type="submit" class="btn btn-default" value="검색" />

			</fieldset>
		</div>
		<!-- 게시판 게시물검색 end -->


<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>직원관리 목록</caption>
			<colgroup>
				<col width="6%" />
				<col width="10%" />
				<col width="10%" />
				<col width="15%" />
				<col width="*" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input type="checkbox" name="chkAll" id="chkAll" /></th>
					<th scope="col" class="fir">번호</th>
					<th scope="col">아이디</th>
					<th scope="col">사업부명</th>
					<th scope="col">관리자명</th>
					<th scope="col">등록일</th>
					<th scope="col">상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><input type="checkbox" name="userIdData" value="${result.userId}" /></td>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td>${result.userId}</td>
					<td>${result.deptName}</td>
					<td>${result.userNm}</td>
					<td>${result.regDate}</td>
					<td>
						<c:choose>
							<c:when test="${result.status eq 'N'}">정상</c:when>
							<c:when test="${result.status eq 'H'}">중지</c:when>
						</c:choose>
					</td>
				</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="8">데이터가없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
<!-- board list end //-->
</form>
<div class="row fr">
		<div class="col-md-6 tar">
			<a class="btn btn-primary" href="javascript:selectMember();"><span>선택</span></a>
		</div>
	</div>
	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>


	<!--
	<div class="row">
		<div class="col-md-6 tar">
			<a class="btn btn-primary" href="javascript:selectMember();"><span>선택</span></a>
		</div>
	</div>
	 -->

</div>

</form>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>