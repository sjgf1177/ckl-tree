
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<script type="text/javascript">
//<![CDATA[
$(function() {
	$( '.check-all' ).click( function() {
        $( '.input_check' ).prop( 'checked', this.checked );
  } );
});


function del(){
	var act = "/bos/job/${paramVO.programId}/delete.json";
	if( "${paramVO.delcode}" == "1" ){
		act = "/bos/job/${paramVO.programId}/delPermanently.json";
	}
	if($(":checkbox:checked").length == 0)
	{
		alert("삭제할 게시물을 선택하세요.");
		return;
	}
	if( !confirm("정말로 삭제하시겠습니까?") ){
		return;
	}
	var inData = $("#frm").serialize();
	$.post(
		act,
		inData,
		function(data){
			var resultCode = data.resultCode;
			var resultMsg = data.msg;
			alert(resultMsg);
			if(resultCode == "success") location.reload();
		}
	);
}
//]]>
</script>


<title>${masterVO.bbsNm}</title>
</head>
<c:url value="/bos/job/entrprsManage/list.do" var="searchUrl" >
	<c:param name="menuNo" value="${param.menuNo }"/>
</c:url>
<form id="frm" name="frm" action ="<c:out value="${searchUrl }" />" method="post">
<input type="hidden" name="entrprsSn" value="${empty result.entrprsSn ? 0 : result.entrprsSn }" />
<input type="hidden" name="pageQueryString" value="<c:out value="${pageQueryString }" />" >
<div id="content">
<!-- 게시판 게시물검색 start -->
<fieldset>
	<legend>채용공고 검색</legend>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>기업 관리</caption>
			<colgroup>
			<col />
			<col />
			<col />
			<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" ><label for="SPNM">기업명</label></th>
					<td colspan="3"><input type="text" name="searchWrd" value="<c:out value="${param.searchWrd }" />" class="w500"></td>
				</tr>
			</tbody>
		</table>
	</div>
	<center><input type="submit"  class="btn btn-primary" value="검색" /> </center>
</fieldset>
	</div>

<!-- 게시판 게시물검색 end -->

<div>
<div class="col-md-6"> 총 <strong class="text-danger"> <c:out value="${resultCnt }"/> </strong> 개의 데이터가 조회되었습니다 </div>
		<table class="table table-bordered table-striped table-hover">
			<caption>${masterVO.bbsNm} 목록</caption>
			<colgroup>
				<col width="5%" />
				<col width="8%" />
				<col width="*%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input type="checkbox" name="check-all" id="tschLfrcOrgplceCode" value="all" class="check-all" <c:if test="${zvl.check_all == 'all'}">checked="checked"</c:if> /></th>
					<th scope="col">번호</th>
					<th scope="col">기업명</th>
					<th scope="col">대표자명</th>
					<th scope="col">사원수</th>
					<th scope="col">설립연도</th>
					<th scope="col">자본금 </th>
					<th scope="col">분야</th>
					<th scope="col">상장여부</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td class="output"><input type="checkbox" name="entrprsSnData" id="entrprsSnData_${result.entrprsSn}" class="input_check" value="<c:out value="${result.entrprsSn}"/>" /></td>
				<td class="output"><c:out value="${(resultCnt) - (paginationInfo.pageSize  * (paramVO.pageIndex-1))}" /></td>
				<td class="tit">
				<c:url var="url" value="/bos/job/${paramVO.programId}/forUpdate.do?entrprsSn=${result.entrprsSn}&" />
					<a href="<c:out value="${url}" />${pageQueryString}">
					<c:out value="${result.entrprsNm }" /></td>
					</a>
				<td class="output">
					 <c:out value="${result.rprsntv}" />
				</td>
				<td class="output"> <c:out value="${result.emplCo }"/> </td>
				<td class="output"> <c:out value="${result.fondYear }"/> </td>
				<td class="output"> <c:out value="${not empty result.capl ? result.capl : '-' } "/><c:out value="${not empty result.capl ? '만원' : '' } "/> </td>
				<td class="output">
				<c:forEach var="code" items="${COM099CodeList }" varStatus="status" >
					<c:if test="${fn:indexOf(result.entrprsStle, code.code) != -1}"><c:out value="${code.codeNm}" /></c:if>
				</c:forEach>
				</td>
				<td class="output"> <c:out value="${result.lstAt eq 'Y' ? '상장' : '비상장' }" /> </td>
			</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="10">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
</form>
<div class="fl">
	<a class="btn btn-primary" href="javascript:del();"><span>삭제</span></a>
</div>
<c:url value="/bos/job/${paramVO.programId}/forInsert.do?" var="insertUrl">
</c:url>
<div class="btn_set">
	<a class="btn btn-primary" href="<c:out value="${insertUrl }" />${pageQueryString}"><span>글쓰기</span></a>
</div>

<!-- board list end //-->
	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
<!-- paging end //-->
	</c:if>
