
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<script type="text/javascript">
<%--
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
--%>
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
<form id="frm" name="frm" action ="/bos/bbs/${paramVO.bbsId}/list.do?menuNo=<c:out value="${param.menuNo }" />" method="post">
<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
<input type="hidden" name="pageQueryString" value="<c:out value="${pageQueryString }" escapeXml="false"/>">
<input type="hidden" name="menuNo" value="<c:out value="${param.menuNo }" />">
	<div id="content">

		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<input type="text" id="sdate" name="sdate" value="${param.sdate}" size="10" /> ~
			    <input type="text" id="edate" name="edate" value="${param.edate}" size="10" />

				<label for="stributary" class="blind"></label>
				<select id="stributary" name="searchCnd" title="검색조건">
				   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >제목</option>
				   <option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >내용</option>
				   <option value="3" <c:if test="${paramVO.searchCnd == '3'}">selected="selected"</c:if> >사업부명</option>
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
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>${masterVO.bbsNm} 목록</caption>
			<colgroup>
<%-- 				<col width="5%" /> --%>
				<col width="8%" />
				<col width="13%" />
				<col width="*" />
				<col width="8%" /> 
				<col width="13%" />
			</colgroup>
			<thead>
				<tr>
<%-- 					<th scope="col"><input type="checkbox" name="check-all" id="tschLfrcOrgplceCode" value="all" class="check-all" <c:if test="${zvl.check_all == 'all'}">checked="checked"</c:if> /></th> --%>
					<th scope="col">번호</th>
					<th scope="col">분야</th>
					<th scope="col">면접유형</th>
					<th scope="col">문항수</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:set var="files" value="${fileMap[result.atchFileId]}" />
				<tr>
				
					<td class="output"><!--번호-->${result.nttType=='1' ? '공지' : (resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td class="tit"><!--분야-->
						<c:if test="${not empty COM113CodeList }">
							<c:forEach var="code" items="${COM113CodeList}" varStatus="status">
								<c:if test="${code.code eq result.option1}">${code.codeNm}</c:if>
							</c:forEach>
						</c:if>
					</td>
					<td class="output"><!--면접유형-->
						<a href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&${pageQueryString}">${result.nttSj}</a> 
					</td>
			    	<td class="output"><!--문항수-->${result.option2}</td>
			    	
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="9">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
<%-- 	<div class="fl"><a class="btn btn-primary" href="javascript:del();"><span>삭제</span></a></div>--%>
	<div class="btn_set">
<c:if test="${empty paramVO.delcode or paramVO.delcode eq '0'}">
  <%--  <sec:authorize ifAnyGranted="ROLE_SUPER">
		<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/list.do?delcode=1"><span>삭제글보기</span></a>
   </sec:authorize> --%>
		<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/forInsert.do?${pageQueryString}"><span>글쓰기</span></a>
<%-- 		<a class="btn btn-info" href="/bos/bbs/${paramVO.bbsId}/downloadExcel.xls?${pageQueryString}&amp;fieldList=Y"><span>Excel</span></a>--%>
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

</form>
