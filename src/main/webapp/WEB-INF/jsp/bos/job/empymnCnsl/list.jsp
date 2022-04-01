
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<script type="text/javascript">

function del(){
	var act = "/bos/job/${paramVO.bbsId}/delete.json";
	if( "${paramVO.delcode}" == "1" ){
		act = "/bos/job/${paramVO.bbsId}/delPermanently.json";
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

	$(function() {
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$("#sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
		$("#edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});

		var strKey = '${paramVO.searchWrd}'; // 하이라이트를 적용할 스트링

		 if(strKey != ''){

			$('.tit').highlight(strKey); //line class에 해당하는 요소들에서 strKey 값들을 하이라이트 처리

		 }

		$( '.check-all' ).click( function() {
	          $( '.input_check' ).prop( 'checked', this.checked );
	    } );
	});


</script>

<title>${masterVO.bbsNm}</title>
</head>
<form id="frm" name="frm" action ="/bos/job/${paramVO.programId}/list.do?menuNo=<c:out value='${param.menuNo }'/>" method="post">
<input type="hidden" name="pageQueryString" id="pageQueryString" value="${pageQueryString }">
<input type="hidden" name="menuNo" value="<c:out value="${param.menuNo }" />">
<input type="hidden" name="cnslSn" value="${empty result.cnslSn ? 0 : result.cnslSn }" />
<div id="content">

	<!-- 게시판 게시물검색 start -->
	<fieldset>
		<legend>1:1 취업 컨설팅</legend>
		<div class="bdView">
			<table class="table table-bordered">
				<caption>1:1 취업컨설팅</caption>
				<colgroup>
				<col />
				<col />
				<col />
				<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" ><label for="SPNM">아이디</label></th>
						<td><input type="text" name="userId" id="userId" value="${paramVO.userId }" /></td>
						<th scope="row" ><label for="SPNM">이름</label></th>
						<td><input type="text" name="userNm" id="userNm" value="${paramVO.userNm }" /></td>
					</tr>
					<tr>
						<th scope="row" ><label for="SPNM">상태</label></th>
						<td>
						<select name="ablmanSttus" id="ablmanSttus" title="창여여부를 선택해 주세요.">
							<option value="" >상태 선택</option>
							<c:forEach var="code" items="${COM080CodeList }" varStatus="status" >
								<option value="${code.code }"<c:if test="${code.code eq paramVO.ablmanSttus}">selected="selected"</c:if>><c:out value="${code.codeNm}" /></option>
							</c:forEach>
						</select>
						</td>
						<th scope="row" ><label for="USEG">상담기간</label></th>
						<td>
							<input type="text" id="sdate" name="sdate" value="${param.sdate}" size="10" /> ~
  						    <input type="text" id="edate" name="edate" value="${param.edate}" size="10" />

						 </td>
					</tr>
				</tbody>
			</table>
		</div>
		<input type="submit" style="right: " class="btn btn-primary" value="검색" />
	</fieldset>
</div>
	</form>
<div class="row mt10 mb5">
	<div class="col-md-6"> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${paginationInfo.totalPageCount }" /></strong> Page </div>
	<div class="col-md-6 tar">
		<label for="pageUnit">표시수 :</label>
		<select name="pageUnit" id="pageUnit" onchange="window.location.href=this.value;">
			<c:forEach var="pageSize" begin="10" end="50" step="10">
				<option value="list.do?pageUnit=<c:out value="${pageSize }" />&<c:out value='${pageQueryString }' escapeXml="false" />" <c:if test="${paramVO.pageUnit eq pageSize }">selected="selected"</c:if>><c:out value="${pageSize }" />개</option>
			</c:forEach>

		</select>
	</div>
</div>


		<!-- 게시판 게시물검색 end -->

		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>${masterVO.bbsNm} 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="10%" />
				<col width="8%" />
				<col width="10%" />
				<col width="8%" />
				<col width="*" />
				<col width="13%" />
				<col width="13%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">회원여부</th>
					<th scope="col">아이디</th>
					<th scope="col">이름</th>
					<th scope="col">성별</th>
					<th scope="col">학교/학과</th>
					<th scope="col">상담일</th>
					<th scope="col">등록일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>

					<td class="output">${result.nttType=='1' ? '공지' : (resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}</td>


			    	 <td class="output">
			    	 <c:out value="${not empty result.userId ? '회원' : '비회원' }" />
			    	 </td>


					<td class="output"><c:out value="${not empty result.userId ? result.userId : '-'}" /></td>

						<td class="tit">
						<c:url var="url" value="/bos/job/${paramVO.programId}/view.do?cnslSn=${result.cnslSn}&amp;${pageQueryString}" />
						<a href="${url}">
							<span >${result.userNm}</span>
						</a>
					</td>


					<td class="output">
						<c:forEach var="code" items="${COM079CodeList}" varStatus="status">
									 <c:if test="${fn:indexOf(result.sex, code.code) != -1}">${code.codeNm}</c:if>
						</c:forEach>
					</td>

					<td class="output">
						${result.schul }/${result.subjct }

					</td>
					<td class="output"><fmt:formatDate value="${result.hopeEra}" pattern="yyyy-MM-dd"/></td>
					<td class="output"><fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/></td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="10">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
	<div class="btn_set">
<c:if test="${empty paramVO.delcode or paramVO.delcode eq '0'}">
		<a class="btn btn-primary" href="/bos/job/${paramVO.programId}/forInsert.do?${pageQueryString}"><span>글쓰기</span></a>
		<a class="btn btn-info" href="/bos/job/${paramVO.programId}/downloadExcelEmpymnCnsl.xls?${pageQueryString}"><span>Excel</span></a>
</c:if>
<c:if test="${paramVO.delcode eq '1'}">
		<a class="btn btn-primary" href="/bos/job/${paramVO.programId}/list.do?delcode=0"><span>돌아가기</span></a>
</c:if>

	</div>

		<!-- board list end //-->
	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
	</c:if>


</div>


