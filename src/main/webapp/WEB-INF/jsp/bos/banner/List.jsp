<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>
<script type="text/javascript">


$(document).ready(function(){

	var strKey = '${paramVO.searchWrd}'; // 하이라이트를 적용할 스트링

	 if(strKey != ''){

		$('.tit').highlight(strKey); //line class에 해당하는 요소들에서 strKey 값들을 하이라이트 처리

	 }

});
</script>
		<!-- 게시판 게시물검색 start -->
	<form action="/bos/banner/list.do?menuNo=${param.menuNo}" method="post">
		<div class="sh">
			<fieldset>
				<select id="useAt" name="useAt" title="검색조건">
				   <option value=''>사용여부</option>
					<option value='Y' <c:if test="${param.useAt == 'Y'}">selected="selected"</c:if>>사용</option>
					<option value='N' <c:if test="${param.useAt == 'N'}">selected="selected"</c:if>>미사용</option>
				</select>

				<select id="searchCnd" name="searchCnd" title="검색조건">
				 <option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >제목</option>
				</select>
				<legend>게시판 게시물검색</legend>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchWrd" value='${paramVO.searchWrd}' />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
		    </fieldset>
		</div>
	</form>


	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>메인비주얼 관리 목록</caption>
			<colgroup>
				<col width="5%" />
				<col width="20%" />
				<col width="20%" />
				<col width="*" />
				<col width="13%" />
				<col width="8%" />
				<col width="6%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">이미지</th>
					<th scope="col">제목</th>
					<th scope="col">배너URL(링크)</th>
					<th scope="col">등록일</th>
					<th scope="col">노출순서</th>
					<th scope="col" class="last">사용</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${resultList}" var="item" varStatus="status">
				<c:set var="files" value="${fileMap[item.atchFileId]}" />
				<%--이미지 파일 구문 --%>
					<c:forEach var="fileList" items="${files }">
						<c:if test="${fileList.fileFieldName eq 'file1' }">
						 	<c:set var ="fileVO" value="${fileList }" />
						</c:if>
					</c:forEach>
					<tr>
						<!-- 번호 -->
						<td>
							${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}
						</td>
						<!-- 배너 이미지 -->
						<td>
						<c:if test="${not empty fileVO }">
							<img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}" style="border: 0px;" width="200px" />
						</c:if>
						</td>
						<!-- 배너명-->
						<td class="tit">
							<c:url value='/bos/banner/forUpdate.do?bnrCd=${item.bnrCd}&${pageQueryString}' var="read_url" />
							<a href="${read_url}"><b>${item.bnrNm}</b></a>
						</td>
						<!-- 배너 URL -->
						<td>
							<a href="${item.bnrUrl}" target="_blank" class="no_break" title="새창 열림">
								<util:head value="${item.bnrUrl}" length="100" />
							</a>
						</td>

						<td>
							 <fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd"/>
						</td>

						<!-- 순서 -->
						<td>

							${item.orderly}
						</td>

						<!-- 표시 여부 -->
						<td>
							<c:choose>
								<c:when test="${item.publish == 'Y'}"><font color="blue">사용</font></c:when>
								<c:otherwise><font color="red">미사용</font></c:otherwise>
							</c:choose>
						</td>
					</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
					<c:set var="fileVO" value="" />
				</c:forEach>
			<c:if test="${fn:length(resultList) eq 0}"><tr><td colspan="7">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
	<!-- board list end //-->

	<div class="btn_set">
		<a class="btn btn-primary" href="/bos/banner/forInsert.do?menuNo=${param.menuNo}"><span>등록</span></a>
	</div>

	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div>
	</c:if>
