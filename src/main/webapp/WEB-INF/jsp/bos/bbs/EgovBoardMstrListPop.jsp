<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<base target="_self">
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />
<meta name="keywords" content="<spring:message code='site.korName' text=''/>" />
<meta name="description" content="<spring:message code='site.korName' text=''/>" />
<meta name="author" content="<spring:message code='site.korName' text=''/>" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/showModalDialogCallee.js'/>" ></script>

<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_brdMstr('1');
		}
	}
	function fn_egov_select_brdMstr(pageNo){
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "/bos/bbs/SelectBBSMasterInfs.do";
		document.frm.submit();
	}

	function fn_egov_select_brdMstrInfo(bbsId){
		var menuLink = "/${siteMng.siteName}/bbs/" + bbsId + "/list.do";
		var retVal   = new Object();
		retVal.menuLink = menuLink;
		retVal.bbsId = bbsId;

		setReturnValue(retVal);
		parent.window.returnValue = retVal;
		parent.window.close();
	}
</script>
<title>게시판 정보</title>
</head>
<body id="wrap_pop">
<form name="frm" action ="/bos/bbs/SelectBBSMasterInfs.do" method="post">
<input type="hidden" name="popupYn" value="Y">
<input type="hidden" name="siteId" value="${param.siteId}">
<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}">

	<div id="content">
		<div class="hgroup">
			<h3>게시판 정보</h3>
		</div>

		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<label for="stributary" class="blind">검색조건</label>
				<select id="stributary" name="searchCnd" title="검색조건">
			   		<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >게시판명</option>
				</select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchWrd" value="${param.searchWrd}" />
				</label>
				<label for="input2">
					<a href="javascript:fn_egov_select_brdMstr('1')" class="btn btn-seach">검색</a>
				</label>
			</fieldset>
		</div>
<!-- 게시판 게시물검색 end -->

		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="*" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">게시판명</th>
					<th scope="col">게시판유형</th>
					<th scope="col">게시판속성</th>
					<th scope="col">생성일</th>
					<th scope="col" class="last">사용여부</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td class="output">${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}</td>
					<td class="tit">
						<a href="javascript:fn_egov_select_brdMstrInfo('${result.bbsId}');">${result.bbsNm}(${result.bbsId})</a>
					</td>
			    	<td class="output">${result.bbsTyCodeNm}</td>
			    	<td class="output">${result.bbsAttrbCodeNm}</td>
					<td class="output">${result.frstRegisterPnttm}</td>
					<td class="output">
				    	<c:if test="${result.useAt == 'N'}">미사용</c:if>
				    	<c:if test="${result.useAt == 'Y'}">사용</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="6">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->

</form>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>