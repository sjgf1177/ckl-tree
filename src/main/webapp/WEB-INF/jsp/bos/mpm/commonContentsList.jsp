<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>콘텐츠관리</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>

<script type="text/javaScript" language="JavaScript">
<!--

function contentsSelect(pcode,uid, subject){

	var  url = "";
	if ('${zvl.searchType}'=='c1'){
		url = "/global/cts/view.do";
		url +="?pcode="+pcode;
		url +="&uId="+uid;

   		 }else if ('${zvl.searchType}'=='c2'){
			url = "/global/cts/list.do";
			url +="?pcode="+pcode;
		}

	opener.document.getElementById("gcon_pcode").value=pcode;
	opener.document.getElementById("gcon_uid").value=uid;
	opener.document.getElementById("gcon_subject").value=subject;
	opener.document.getElementById("menuLink").value=url;
	self.close();
}

//-->
</script>
</head>

	<div id="content">
		<div class="hgroup">
			<h3>콘텐츠관리</h3>
		</div>

		<div id="topDesc" class="topDesc">
			<ul>
				<li>해당 프로그램은 사용자 매뉴에 대한 콘텐츠를 관리하는 곳입니다.</li>
				<li>새로운 매뉴에 대한 항목은 매뉴에서 먼저 생성 후 사용이 가능합니다.</li>
			</ul>
		</div>

	<form name="listForm" action="<c:url value='/bos/mpm/commonContents/list/${zvl.siteId }.do'/>" method="post">
  		<input type="hidden" name="siteId" value="${zvl.siteId}"/>
		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<label for="stributary" class="blind">검색조건</label>
		    	<select name="sUseYn" id="stributary"  class="select">
		    		<option value="" ${zvl.sUseYn eq '' ? 'selected="selected"' : ''}>전체</option>
		    		<option value="Y" ${zvl.sUseYn eq 'Y' ? 'selected="selected"' : ''}>사용</option>
		    		<option value="N" ${zvl.sUseYn eq 'N' ? 'selected="selected"' : ''}>미사용</option>
		    	</select>
		    	<select name="searchKey" id="searchKey"  class="select" style="vertical-align:middle;">
		    		<option value="path" ${zvl.searchKey eq 'path' ? 'selected="selected"' : ''}>매뉴명</option>
		    	</select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchStr" value="${zvl.searchStr}" />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
			</fieldset>
		</div>
	</form>

	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="10%" />
				<col width="*" />
				<col width="20%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">매뉴번호</th>
					<th scope="col">매뉴명</th>
					<th scope="col">매뉴사용여부</th>
					<th scope="col" class="last">수정일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${list}" varStatus="status">
				<tr>
					<td class="output">${zvl.resultCnt-((zvl.pageIndex-1)*zvl.pageSize)-status.index}</td>
					<td class="output">${result.menuNo}</td>
			    	<td class="output tal"><a href="/bos/mpm/commonContents/modify/${zvl.siteId}.do?${zvl.paramUrl}&sUseYn=${zvl.sUseYn}&sMenuNo=${result.menuNo}">${fn:replace(result.ph,'H>','')}</a></td>
			    	<td class="output">${result.useYn eq 'Y' ? '사용' : '미사용'}</td>
					<td class="output">${result.modifyDay}</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(list) == 0}"><tr><td colspan="7">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>

	<c:if test="${fn:length(list) > 0}">
	<div class="paging">
		<div class="paging_con">
			${zvl.pageNavi}
		</div>
	</div><!-- paging end //-->
	</c:if>
</div>

<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>
