
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
	var act = "/bos/bbs/${paramVO.bbsId}/delete.json";
	if( "${paramVO.delcode}" == "1" ){
		act = "/bos/bbs/${paramVO.bbsId}/delPermanently.json";
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

<form id="frm" name="frm" action ="/bos/bbs/${paramVO.bbsId}/list.do" method="post">
<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<div id="content">

		<!-- 게시판 게시물검색 start -->
			<fieldset>
					<legend>시설관리 검색</legend>
					<div class="bdView">
						<table class="table table-bordered">
							<caption>시설관리</caption>
							<colgroup>
							<col />
							<col />
							<col />
							<col />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row" ><label for="SPNM">아이디</label></th>
									<td><input type="text" name="ntcrId" id="ntcrId" value="" /></td>
									<th scope="row" ><label for="SPNM">이름</label></th>
									<td><input type="text" name="ntcrNm" id="ntcrNm" value="" /></td>
								</tr>
								<tr>
									<th scope="row" ><label for="SPNM">상태</label></th>
									<td><input type="text" name="SPNM" id="SPNM" value="" /></td>
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

<div class="row mt10 mb5">
	<div class="col-md-6"> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${totalPage }" /></strong> Page </div>
	<div class="col-md-6 tar">
		<label for="pageUnit">표시수 :</label>
		<select name="pageUnit" id="pageUnit">
			<option value="10" <c:if test="${paramVO.pageUnit eq 10 }">selected="selected"</c:if>>10개</option>
			<option value="20" <c:if test="${paramVO.pageUnit eq 20 }">selected="selected"</c:if>>20개</option>
			<option value="30" <c:if test="${paramVO.pageUnit eq 30 }">selected="selected"</c:if>>30개</option>
			<option value="40" <c:if test="${paramVO.pageUnit eq 40 }">selected="selected"</c:if>>40개</option>
			<option value="50" <c:if test="${paramVO.pageUnit eq 50 }">selected="selected"</c:if>>50개</option>
		</select>
	</div>
</div>
</form>
		<!-- 게시판 게시물검색 end -->

		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>${masterVO.bbsNm} 목록</caption>
			<colgroup>
				<col width="5%" />
				<col width="8%" />
				<col width="10%" />
				<col width="8%" />
				<col width="10%" />
				<col width="8%" />
				<col width="*" />
				<col width="13%" />
				<col width="13%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input type="checkbox" name="check-all" id="tschLfrcOrgplceCode" value="all" class="check-all" <c:if test="${zvl.check_all == 'all'}">checked="checked"</c:if> /></th>
					<th scope="col">번호</th>
					<th scope="col">회원여부</th>
					<th scope="col">아이디</th>
					<th scope="col">이름</th>
					<th scope="col">성별</th>
					<th scope="col">학교/학과</th>
					<th scope="col">상담일</th>
					<th scope="col">등록일</th>
					<th scope="col">조회</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:set var="files" value="${fileMap[result.atchFileId]}" />
				<tr>
					<td class="output"><input type="checkbox" name="nttIdData" id="nttIdData_${result.nttId}" class="input_check" value="<c:out value="${result.nttId}"/>" /></td>

					<td class="output">${result.nttType=='1' ? '공지' : (resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>


			    	 <td class="output">${result.option1}	</td>


					<td class="output">${result.ntcrId}</td>

						<td class="tit">
						<c:url var="url" value="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&${pageQueryString}" />
						<a href="${url}">
						<c:choose>
							<c:when test="${result.delcode ne SearchVO.NON_DELETION}">
							<span class="del">${result.ntcrNm}</span>
							</c:when>
							<c:otherwise>${result.ntcrNm}</c:otherwise>
						</c:choose>
						<c:if test="${result.commentCnt>0}">(댓글:${result.commentCnt})</c:if>
						<c:if test="${result.replyCnt>0}">(댓글:${result.replyCnt})</c:if>
						${result.newYn=='Y'?'[new]':''}
						</a>
					</td>


					<td class="output">${result.option2}</td>

					<td class="output">
						${result.option4 }/${result.option5 }

					</td>
					<td class="output">${result.option12}</td>
					<td class="output">${result.frstRegisterPnttm}</td>
					<td class="output">${result.inqireCo}</td>

				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="9">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
	<div class="fl"><a class="btn btn-primary" href="javascript:del();"><span>삭제</span></a></div>
	<div class="btn_set">
<c:if test="${empty paramVO.delcode or paramVO.delcode eq '0'}">
   <sec:authorize ifAnyGranted="ROLE_SUPER">
		<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/list.do?delcode=1"><span>삭제글보기</span></a>
   </sec:authorize>
		<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/forInsert.do?${pageQueryString}"><span>글쓰기</span></a>
		<a class="btn btn-info" href="/bos/bbs/${paramVO.bbsId}/downloadExcel.xls?${pageQueryString}&amp;fieldList=Y"><span>Excel</span></a>
</c:if>
<c:if test="${paramVO.delcode eq '1'}">
		<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/list.do?delcode=0"><span>돌아가기</span></a>
</c:if>
	</div>

		<!-- board list end //-->
	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
	</c:if>


</div>


