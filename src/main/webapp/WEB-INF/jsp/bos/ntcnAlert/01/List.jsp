<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>
<script type="text/javascript">

function del(){
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
		"/bos/bbs/deleteAll.json",
		inData,
		function(data){
			var resultCode = data.resultCode;
			var resultMsg = data.msg;
			alert(resultMsg);
			if(resultCode == "success") location.reload();
		}
	);
}

$(document).ready(function(){

	var strKey = '${paramVO.searchWrd}'; // 하이라이트를 적용할 스트링

	 if(strKey != ''){

		$('.tit').highlight(strKey); //line class에 해당하는 요소들에서 strKey 값들을 하이라이트 처리

	 }

});
</script>

		<!-- 게시판 게시물검색 start -->
	<form  id="frm" name="frm" action="/bos/ntcnAlert/list.do?type=01&siteId=${param.siteId}&menuNo=${param.menuNo}" method="post">
		<div class="sh">
			<fieldset>
		<select name="useAt" id="useAt">
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
			<caption>알림 관리 목록</caption>
			<colgroup>
				<col width="5%" />
				<col width="10%" />
			<%-- 	<col width="10%" /> --%>
				<col width="*" />
				<%-- <col width="22%" /> --%>
				<%-- <col width="15%" /> --%>
				<col width="26%" />
				<col width="12%" />
				<col width="8%" />
				<col width="6%" />
			</colgroup>
			<thead>
				<tr>
					<%-- <th scope="col"><input type="checkbox" name="check-all" id="tschLfrcOrgplceCode" value="all" class="check-all" <c:if test="${zvl.check_all == 'all'}">checked="checked"</c:if> /></th> --%>
					<th scope="col">번호</th>
					<!-- <th scope="col">사이트명</th> -->
					<th scope="col">이미지</th>
					<th scope="col">제목</th>
					<th scope="col">등록일</th>
					<!-- <th scope="col">게시기간</th> -->
					<th scope="col">노출순서</th>
					<th scope="col">사용</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${resultList}" var="item" varStatus="status">
					<tr>
						<%-- <td class="output"><input type="checkbox" name="nttIdData" id="nttIdData_${result.nttId}" class="input_check" value="<c:out value="${result.nttId}"/>" /></td> --%>
						<!-- 번호 -->
						<td>
							${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}
						</td>
						<!-- 구분 -->
						<%-- <td>
							<strong>
								${item.category_nm}
							</strong>
						</td> --%>
						<!-- 이미지-->
						<td>
						<c:if test="${not empty item.fileSn}">
							<img src="/cmm/fms/getImage.do?atchFileId=${item.atchFileId}&fileSn=${item.fileSn}" style="border: 0px;" width="126" height="73" />
						</c:if>
						</td>
						<!-- 알림 URL
						<td class="tal">
							<a href="${item.alert_url}" target="_blank" alt="새창"><util:head value="${item.alert_url}" length="100" /></a>
						</td>
						-->
						<!-- 제목 -->
						<td class="tit">
							<c:url value='/bos/ntcnAlert/forUpdate.do?ntcnNo=${item.ntcnNo}&${pageQueryString}' var="read_url" />
							<a href="${read_url}"><b>${item.ntcnNm}</b></a>
						</td>
						<%-- <!-- 게시기간 -->
						<td>
							${item.pub_sdate}
		    			~
							${item.pub_edate}
						</td> --%>
						<td>${item.frstRegistPnttm}</td>


						<!-- 노출순서 -->
						<td>
						${item.sortOrdr}
						</td>


						<!-- 표시 여부 -->
						<td>
							<c:choose>
								<c:when test="${item.useAt == 'Y' && item.status == '2'}"><font color="blue">사용</font></c:when>
								<c:otherwise><font color="red">미사용</font></c:otherwise>
							</c:choose>
						</td>
					</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="8">데이터가없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
<!-- board list end //-->

	<div class="btn_set">
		<a class="btn btn-primary" href="/bos/ntcnAlert/forInsert.do?${pageQueryString}"><span>등록</span></a>
	</div>

		<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">
			<div class="paging_con">
				${pageNav}
			</div>
		</div><!-- paging end //-->
		</c:if>
