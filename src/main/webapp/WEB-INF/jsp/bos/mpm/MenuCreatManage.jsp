<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /* Image Path 설정 */
  String imagePath_icon   = "/bos/images/common/";
  String imagePath_button = "/images/egovframework/sym/mpm/button/";
%>
<script  language="javascript1.2">

/* ********************************************************
 * 최초조회 함수
 ******************************************************** */
function fMenuCreatManageSelect(){
    document.menuCreatManageForm.action = "<c:url value='/bos/mpm/MenuCreatManageSelect.do?menuNo=${param.menuNo}'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.menuCreatManageForm.pageIndex.value = pageNo;
	document.menuCreatManageForm.action = "<c:url value='/bos/mpm/MenuCreatManageSelect.do?menuNo=${param.menuNo}'/>";
   	document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */
function selectMenuCreatManageList() {
	document.menuCreatManageForm.pageIndex.value = 1;
    document.menuCreatManageForm.action = "<c:url value='/bos/mpm/MenuCreatManageSelect.do?menuNo=${param.menuNo}'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 메뉴생성 화면 호출
 ******************************************************** */
function selectMenuCreat(AuthorCode) {
   	document.menuCreatManageForm.action = "<c:url value='/bos/mpm/MenuCreatSelect/"+ AuthorCode +".do?menuNo=${param.menuNo}'/>";
   	document.menuCreatManageForm.submit();
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>

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

<form name="menuCreatManageForm" action ="javascript:fMenuCreatManageSelect();" method="post">

<input name="checkedMenuNoForDel" type="hidden" />
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<%-- <input type="text" id="sdate" name="sdate" value="${param.sdate}" size="10" /> ~
			    <input type="text" id="edate" name="edate" value="${param.edate}" size="10" /> --%>

				<label for="stributary" class="blind"></label>
				<select id="stributary" name="searchCondition" title="검색조건">
				   <option value="1" <c:if test="${paramVO.searchCondition == '1'}">selected="selected"</c:if> >권한ID</option>
				   <option value="2" <c:if test="${paramVO.searchCondition == '2'}">selected="selected"</c:if> >권한명</option>
				</select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchKeyword" value="${param.searchKeyword}" />
				</label>
				<label for="input2">
					<a href="javascript:selectMenuCreatManageList()" class="btn btn-seach">검색</a>
				</label>
			</fieldset>
		</div>
<!-- 게시판 게시물검색 end -->
		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="15%" />
				<col width="20%" />
				<col width="*" />
				<col width="15%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">권한ID</th>
					<th scope="col">권한명</th>
					<th scope="col">권한 설명</th>
					<th scope="col">메뉴생성여부</th>
					<th scope="col" class="last">메뉴생성</th>
				</tr>
			</thead>
			<tbody>
			 <c:forEach var="result" items="${list_menumanage}" varStatus="status">
			  <tr>
			    <td><c:out value="${result.authorCode}"/></td>
			    <td><c:out value="${result.authorNm}"/></td>
			    <td><c:out value="${result.authorDc}"/></td>
			    <td>
			          <c:if test="${result.chkYeoBu > 0}">Y</c:if>
			          <c:if test="${result.chkYeoBu == 0}">N</c:if>
			    </td>
	            <td>
	            	<input type="button" class="btn btn-xs btn-inverse" value="메뉴생성" onclick="selectMenuCreat('${result.authorCode}')" />
	            </td>
			  </tr>
			 </c:forEach>
			 <c:if test="${fn:length(list_menumanage) == 0}"><tr><td colspan="5">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>

	<c:if test="${fn:length(list_menumanage) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>

</form>
