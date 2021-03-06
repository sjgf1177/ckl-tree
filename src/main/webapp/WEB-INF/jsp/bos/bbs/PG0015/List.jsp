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
	});
</script>

<title>${masterVO.bbsNm}</title>
</head>

<form id="frm" name="frm" action ="/bos/bbs/${paramVO.bbsId}/list.do?menuNo=${paramVO.menuNo}" method="post">
	<div id="content">

		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<input type="text" id="sdate" name="sdate" value="${param.sdate}" size="10" /> ~
			    <input type="text" id="edate" name="edate" value="${param.edate}" size="10" />

			<c:if test="${bbsId eq 'B0000038'}">
				<select name="option1" id="option1">
					<option value="">분야선택</option>
					<option value="01" <c:if test="${paramVO.option1 eq '01'}">selected="selected"</c:if>>현장교육</option>
					<option value="02" <c:if test="${paramVO.option1 eq '02'}">selected="selected"</c:if>>온라인교육</option>
					<option value="03" <c:if test="${paramVO.option1 eq '03'}">selected="selected"</c:if>>창의인재동반</option>
					<option value="04" <c:if test="${paramVO.option1 eq '04'}">selected="selected"</c:if>>취업정보</option>
				</select>
			</c:if>

				<select id="stributary" name="searchCnd" title="검색조건">
				   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >제목</option>
				   <option value="4" <c:if test="${paramVO.searchCnd == '4'}">selected="selected"</c:if> >회원명</option>
				   <option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >내용</option>
				   <option value="3" <c:if test="${paramVO.searchCnd == '3'}">selected="selected"</c:if> >제목+내용</option>
				</select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchWrd" value="${paramVO.searchWrd}" />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn" />
				</label>
			</fieldset>
		</div>
		<!-- 게시판 게시물검색 end -->

		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>${masterVO.bbsNm} 목록</caption>
			<colgroup>
				<col width="6%" />
				<col width="6%" />
			<c:if test="${bbsId eq 'B0000038'}">
				<col width="6%" />
			</c:if>
				<col width="*" />
				<col width="6%" />
				<col width="10%" />
				<col width="12%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">상태</th>
				<c:if test="${bbsId eq 'B0000038'}">
					<th scope="col">분류</th>
				</c:if>
					<th scope="col">제목</th>
					<th scope="col">첨부</th>
					<th scope="col">접수일자</th>
					<th scope="col">작성자</th>
					<th scope="col">답변일자</th>
					<th scope="col">답변자</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td class="output">${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
				<c:if test="${bbsId eq 'B0000038'}">
					<td class="output">
						<c:choose>
							<c:when test="${result.option1 eq '01'}">현장교육</c:when>
							<c:when test="${result.option1 eq '02'}">온라인교육</c:when>
							<c:when test="${result.option1 eq '03'}">창의인재동반</c:when>
							<c:when test="${result.option1 eq '04'}">취업정보</c:when>
						</c:choose>
					</td>
				</c:if>
					<td class="output">${result.replyAt eq 'Y' ? '완료' : '미완료'}</td>
					<td class="tit">
						<c:url var="url" value="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&${pageQueryString}" />
						<a href="${url}">
						<c:choose>
							<c:when test="${result.delcode ne SearchVO.NON_DELETION}">
							<span class="del">${result.nttSj}</span>
							</c:when>
							<c:otherwise>${fn:trim(result.nttSj) eq '' or empty result.nttSj ? '제목 없음' : result.nttSj}</c:otherwise>
						</c:choose>
						</a>
					</td>
			    	<td class="output">
			    		<c:if test="${not empty result.atchFileId and result.fileCount > 0}">
			    		<a href="/bos/cmm/fms/FileDown.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}">
			    			<img src="/bos/images/common/disk.gif" alt="${result.orignlFileNm}"/>
			    		</a>
			    		</c:if>
			    	</td>
					<td class="output">${result.frstRegisterPnttm}</td>
					<td class="output">${result.ntcrNm}</td>
					<td class="output">${result.replyRegisterPnttm}</td>
					<td class="output">${result.replyNtcrNm}</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="8">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->
	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
	</c:if>

	<div class="btn_set">
<c:if test="${empty paramVO.delcode or paramVO.delcode eq '0'}">
   <sec:authorize ifAnyGranted="ROLE_SUPER">
		<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/list.do?delcode=1"><span>삭제글보기</span></a>
   </sec:authorize>
   <!--
		<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/forInsert.do?bbsId=${paramVO.bbsId}&${pageQueryString}"><span>글쓰기</span></a>
	-->
</c:if>
<c:if test="${paramVO.delcode eq '1'}">
		<a class="btn" href="/bos/bbs/${paramVO.bbsId}/list.do?delcode=0"><span>돌아가기</span></a>
</c:if>
	</div>


</div>

</form>
