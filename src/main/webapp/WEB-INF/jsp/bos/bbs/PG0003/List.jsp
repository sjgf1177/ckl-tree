
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<script type="text/javascript">



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
				<col width="8%" />
				<col width="*" />
<%-- 				<col width="13%" /> --%>
				<col width="13%" />
				<col width="13%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
<!-- 					<th scope="col">첨부</th> -->
					<th scope="col">작성자</th>
					<th scope="col">등록일</th>
					<th scope="col">조회</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td class="output">${result.nttType=='1' ? '공지' : (resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>

					<td class="tit">
						<c:url var="url" value="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&${pageQueryString}&viewType=PORTALBODY" />
						<a href="${url}">
							
							<!-- 말머리 -->
							<c:if test="${not empty COM127CodeList }">
							<span class="point0">
							<c:forEach var="code" items="${COM127CodeList}" varStatus="status" >
								<c:if test="${code.code eq result.option1 }">
									[ ${code.codeNm} ]&nbsp;
								</c:if>
							</c:forEach>
							</span>
							</c:if>
							<!-- //말머리 -->
							
						 	<c:out value="${fn:trim(result.nttSj) eq '' or empty result.nttSj ? '제목 없음' : result.nttSj}" />
						</a>
					</td>


<!-- 			    	<td class="output"> -->
<%-- 			    		<c:if test="${not empty result.atchFileId and result.fileCount > 0}"> --%>
<%-- 			    		<a href="/bos/cmm/fms/FileDown.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}"> --%>
<%-- 			    			<img src="/bos/images/common/disk.gif" alt="${result.orignlFileNm}"/> --%>
<!-- 			    		</a> -->
<%-- 			    		</c:if> --%>
<!-- 			    	</td> -->

					<td class="output tac">${result.ntcrNm}</td>

					<td class="output">${result.frstRegisterPnttm}</td>

					<td class="output">${result.inqireCo}</td>

				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="6">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
<%--	<div class="fl"><a class="btn btn-primary" href="javascript:del();"><span>삭제</span></a></div> --%>
	<div class="btn_set">
<c:if test="${empty paramVO.delcode or paramVO.delcode eq '0'}">
   <sec:authorize ifAnyGranted="ROLE_SUPER">
<%-- 		<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/list.do?delcode=1"><span>삭제글보기</span></a> --%>
   </sec:authorize>
		<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/forInsert.do?${pageQueryString}"><span>글쓰기</span></a>
<%-- 		<a class="btn btn-info" href="/bos/bbs/${paramVO.bbsId}/downloadExcel.xls?${pageQueryString}&amp;fieldList=Y"><span>Excel</span></a> --%>
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
