<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/jquery-ui/jquery-ui.js"></script>

<script type="text/javascript" src="<c:url value='/js/egovframework/cop/bbs/EgovBBSMng.js' />" ></script>
<script type="text/javascript">
$(function(){
	$("#pageUnit").change(function(){
		var size = $(this).val();
		$("#frm")[0].submit();
	});
});

function goSearch(frm){

	if(frm.sdate.value > frm.edate.value){

		alert("기간을 올바르게 선택해주세요.");
		frm.sdate.value = "";
		frm.edate.value = "";
		return false;
	}
}
</script>

<title>${param.menuNm}</title>
</head>
<body>
<form id="frm" name="frm" action ="list.do" method="post" onsubmit="return goSearch(this);">

	<div id="content">
		<div class="hgroup">
			<h3>메타 데이터 검색</h3>
		</div>

		<div class="sh">
			<fieldset>
				<legend>게시판 게시물검색</legend>
				<select id="stributary" name="searchCnd" title="검색조건">
				   <option value="1" <c:if test="${param.searchCnd eq '1'}">selected="selected"</c:if> >코멘트</option>
				   <option value="2" <c:if test="${param.searchCnd eq '2'}">selected="selected"</c:if> >테이블ID</option>
				   <option value="3" <c:if test="${param.searchCnd eq '3'}">selected="selected"</c:if> >필드ID</option>
				</select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchWrd" value="${paramVO.searchWrd}" />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
			</fieldset>
		</div>
<!-- 게시판 게시물검색 end -->

		<!-- board list start -->
	<div class="tar">
	Total : <c:out value="${resultCnt}" />개 [ <c:out value="${paramVO.pageIndex}/${paginationInfo.totalPageCount}" />pages ]
	</div>
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">테이블ID(코멘트)</th>
					<th scope="col">필드ID</th>
					<th scope="col">필드 코멘트</th>
					<th scope="col">사이즈</th>
					<th scope="col" class="last">PK</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:url var="url" value="/bos/${paramVO.programId}/forUpdate.do?${pageQueryString}">
					<c:param name="seq" value="${result.seq}" ></c:param>
				</c:url>
				<tr>
					<td class="output">
						<c:out value="${resultCnt - (paramVO.pageSize * (paramVO.pageIndex-1))}" />
					</td>
					<!-- 제목 -->
					<td class="tit">
						&nbsp;<c:out value="${result.tableName}" />(<c:out value="${result.tableComments}" />)
					</td>
			    	<td class="tit">
						&nbsp;<c:out value="${result.columnName}" />
					</td>
			    	<td class="tit">
			    		&nbsp;<c:out value="${result.comments}" />
			    	</td>
			    	<td class="tit">
			    		&nbsp;<c:out value="${result.fSize}" />
			    	</td>
					<td class="output">
						&nbsp;<c:out value="${result.pk}" />
					</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) eq 0}"><tr><td colspan="7">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

	<div class="btn_set">
	<%-- 	<a href="/bos/${paramVO.programId}/forInsert.do?${pageQueryString}" class="btn btn-primary">등록</a> --%>
	</div>

	<c:if test="${fn:length(resultList) > 0}">
	<div id="paging">
		<div class="paging_con">
			<c:out value="${pageNav}" escapeXml="false" />
		</div>
	</div><!-- paging end //-->
	</c:if>
</div>
</form>
<br/>
<div><input type="text" name="" value="/WebContent${pageContext.request.requestURI}" class="input_txt file_socueurl" style="color:red;width:100%"/></div>
</body>
</html>