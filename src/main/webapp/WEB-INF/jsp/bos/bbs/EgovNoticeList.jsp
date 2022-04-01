<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovNoticeList.jsp
  * @Description : 게시물 목록화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.03.19   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.19
  *  @version 1.0
  *  @see
  *
  *  Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />



<title>종로구청</title>
<meta name="robots" content="all" />
<meta name="keywords" content="종로구청" />
<meta name="description" content="종로구청" />
<meta name="author" content="종로구청" />
<link href="/admin/common/css/common_style.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/board.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../system/js/common_ui.js"></script>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>

<c:choose>
<c:when test="${preview == 'true'}">
<script type="text/javascript">
<!--
	function press(event) {
	}

	function fn_egov_addNotice() {
	}

	function fn_egov_select_noticeList(pageNo) {
	}

	function fn_egov_inqire_notice(nttId, bbsId) {
	}
//-->
</script>
</c:when>
<c:otherwise>
<script type="text/javascript">
<!--
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_noticeList('1');
		}
	}

	function fn_egov_addNotice() {
		document.frm.action = "<c:url value='/admin/bbs${prefix}/addBoardArticle.do'/>";
		document.frm.submit();
	}

	function fn_egov_select_noticeList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/admin/bbs${prefix}/selectBoardList.do'/>";
		document.frm.submit();
	}

	function fn_egov_inqire_notice(nttId, bbsId) {
		document.frm.nttId.value = nttId;
		document.frm.bbsId.value = bbsId;
		document.frm.action = "<c:url value='/admin/bbs${prefix}/selectBoardArticle.do'/>";
		document.frm.submit();
	}
//-->
</script>
</c:otherwise>
</c:choose>
<title><c:out value="${brdMstrVO.bbsNm}"/></title>
</head>
<body>
<form name="frm" action ="" method="post">
<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
<input type="hidden" name="nttId"  value="0" />
<input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
<input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />

	<!-- text_area start -->
	<div class="text_area">

		<!-- 게시판 게시물검색 start -->
		<fieldset id="src">
			<legend>게시판 게시물검색</legend>

				<span class="boardsearch">
				<label for="stributary" class="blind">게시물 분류 선택</label>
					<select id="stributary" name="searchCnd" title="검색조건">
					   <!-- option selected="selected" value''>--선택하세요--</option-->
					   <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >제목</option>
					   <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >내용</option>
					   <option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> >작성자</option>
					</select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:150px" name="searchWrd" value='<c:out value="${searchVO.searchWrd}"/>' />
				</label>
				<label for="input2">
					<input id="input2" type="image" alt="검색" src="../portal/open_content/images/common/btn/btn_search_01.gif" onClick="fn_egov_select_noticeList('1');"/>
				</label>
				</span>
		</fieldset><!-- 게시판 게시물검색 end -->

		<!-- board list start -->
		<table class="list_type01" >
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="*" />
				<col width="15%" />
				<col width="15%" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="fir">번호</th>
					<th scope="col">제목</th>
					<th scope="col">등록일</th>
					<th scope="col">작성자</th>
					<th scope="col">첨부파일</th>
					<th scope="col">조회수</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
					<td class="tal">
				    	<c:if test="${result.replyLc!=0}">
				    		<c:forEach begin="0" end="${result.replyLc}" step="1">
				    			&nbsp;
				    		</c:forEach>
				    		<img src="<c:url value='/images/egovframework/cop/bbs/icon/reply_arrow.gif'/>" alt="reply arrow">
				    	</c:if>
				    	<c:choose>
				    		<c:when test="${result.isExpired=='Y' || result.useAt == 'N'}">
				    			<c:out value="${result.nttSj}" />
				    		</c:when>
				    		<c:otherwise>
					    		<c:choose>
						    		<c:when test="${result.secret == 'N'}">
								    	<a href="javascript:fn_egov_inqire_notice('<c:out value="${result.nttId}"/>','<c:out value="${result.bbsId}"/>')">
								    	<c:out value="${result.nttSj}"/></a>
								    </c:when>
								    <c:when test="${result.secret == 'Y'}">
								    	<c:out value="${result.nttSj}"/>
								    </c:when>
							    </c:choose>
				    		</c:otherwise>
				    	</c:choose>
					<img src="../images/common/icon/ico_new.gif" class="vam" alt="새로운 글" /></td>
					<td><c:out value="${result.frstRegisterPnttm}"/></td>
			    	<c:if test="${anonymous != 'true'}">
				    	<td><c:out value="${result.frstRegisterNm}"/></td>
				    </c:if>
					<td><a href="#"><img src="../images/common/icon/icon_disk.gif" alt="첨부파일" /></a></td>
					<td><c:out value="${result.inqireCo}"/></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<!-- board list end //-->

		<div id="btn_area">
			<!-- <div class="btn_right_fl">
				<a href="#"><img src="../images/common/btn/btn_modify.gif" alt="수정" /></a>
				<a href="#"><img src="../images/common/btn/btn_delete.gif" alt="삭제" /></a>
			</div> -->
			<div class="btn_right_fr">
				<a href="javascript:fn_egov_addNotice();"><img src="../images/common/btn/btn_regist.gif" alt="등록" /></a>
			</div>
		</div><!-- btn end //-->

		<div class="paging">
			<div class="paging_con">
				${pagination}
			</div>
		</div><!-- paging end //-->
	</div><!-- text_area end -->


	<input name="pageIndex" type="hidden" value="${searchVO.pageIndex}"/>
</form>
</body>
</html>