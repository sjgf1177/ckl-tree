<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
<div class="tar alert formLine">
	<form action="" class="form-inline">
		<fieldset>
			<legend>1:1 컨설팅 검색 양식</legend>
			<div class="clearfix">
			<select name="searchCnd" id="searchCnd" title="구분을 선택해 주세요.">
				<option value="1" >내용</option>
			</select>
			<input type="text" name="cnsltReqCn" id="cnsltReqCn" title="검색어를 입력해 주세요." value="<c:out value="${param.cnsltReqCn }" />" style="width:200px">
			<a href="#self" class="btn btn-primary">검색</a>
			</div>
		</fieldset>
	</form>
</div>
 --%>
<div class="col-12 sub_board_header">
	<div class="board_title">
	    <h4>총 <span class="board_count"><c:out value="${empty resultCnt ? 0 : resultCnt  }" /></span>건의 검색 결과가 있습니다.</h4>
    </div>
</div>
<div>
	<table class="board_type_0">
		<caption>1:1 컨설팅 목록</caption>
		<colgroup>
			<col width="8%">
			<col>
			<col>
			<col>
			<col>
			<col>
			<col>
			<col>
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">상태</th>
				<th scope="col">접수일자</th>
				<th scope="col">아이디</th>
				<th scope="col">이름</th>
				<th scope="col">상담일자</th>
				<th scope="col">상담자</th>
				<th scope="col">삭제</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList }">
		<c:choose>
			<c:when test="${result.replyAt eq 'N' and empty result.cnsltReqCn}">
				<c:url var="readUrl" value="/edu/job/empymnCnsl/recruit01.do" >
				<c:param name="menuNo" value="${param.menuNo }"/>
				<c:param name="cnslSn" value="${result.cnslSn }"/>
				</c:url>
			</c:when>
			<c:otherwise >
				<c:url var="readUrl" value="/edu/job/empymnCnsl/view.do" >
				<c:param name="menuNo" value="${param.menuNo }"/>
				<c:param name="cnslSn" value="${result.cnslSn }"/>
				</c:url>
			</c:otherwise>
		</c:choose>
			<tr>
				<td><c:out value="${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}" /></td>
				<td>
					<c:out value="${result.replyAt eq 'Y' and not empty result.cnsltReqCn ? '답변완료' : '대기중' }" />
				</td>
				<td><c:out value="${result.cnsltDt }" /> </td>
				<td><c:out value="${result.userId }" /></td>
				<td><a href="${readUrl }" class="aTrigger"><c:out value="${result.userNm }" /></a></td>
				<td><c:out value="${result.cnsltDt }" /></td>
				<td><c:out value="${not empty result.cnsltNm ? result.cnsltNm: '-' }" /></td>
				<td>
					<c:if test="${result.replyAt eq 'N' and empty result.cnsltReqCn}">
					<c:url var="delUrl" value="/edu/job/${paramVO.programId}/delete.do" >
						<c:param name="menuNo" value="${param.menuNo }"/>
						<c:param name="cnslSn" value="${result.cnslSn }"/>
					</c:url>
						<div class="board_util_btn_con center">
							<a href="<c:out value="${delUrl }" />" class="btn_style_0 small gray">삭제</a>
						</div>
					</c:if>
				</td>
			</tr>

			<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		</tbody>
	</table>
</div>
