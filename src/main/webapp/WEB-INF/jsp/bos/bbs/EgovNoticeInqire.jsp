<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
 /**
  * @Class Name : EgovNoticeInqire.jsp
  * @Description : 게시물 조회 화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.03.23   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.23
  *  @version 1.0 
  *  @see
  *  
  *  Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/admin/common/css/common_style.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/board.css" rel="stylesheet" type="text/css" />

<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">
	function onloading() {
		if ("<c:out value='${msg}'/>" != "") {
			alert("<c:out value='${msg}'/>");
		}
	}
	
	function fn_egov_select_noticeList(pageNo) {
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/admin/bbs${prefix}/selectBoardList.do'/>";
		document.frm.submit();	
	}
	
	function fn_egov_delete_notice() {
		if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
			alert('등록시 사용한 패스워드를 입력해 주세요.');
			document.frm.password.focus();
			return;
		}
		
		if (confirm('<spring:message code="common.delete.msg" />')) {
			document.frm.action = "<c:url value='/admin/bbs${prefix}/deleteBoardArticle.do'/>";
			document.frm.submit();
		}	
	}
	
	function fn_egov_moveUpdt_notice() {
		if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
			alert('등록시 사용한 패스워드를 입력해 주세요.');
			document.frm.password.focus();
			return;
		}

		document.frm.action = "<c:url value='/admin/bbs${prefix}/forUpdateBoardArticle.do'/>";
		document.frm.submit();			
	}
	
	function fn_egov_addReply() {
		document.frm.action = "<c:url value='/admin/bbs${prefix}/addReplyBoardArticle.do'/>";
		document.frm.submit();			
	}
	
	function autoResize(i){
	    var iframeHeight=
	    (i).contentWindow.document.body.scrollHeight;
	    var iframeWidth=
	    (i).contentWindow.document.body.scrollWidth;	    
	    (i).height=iframeWidth+20;
	    (i).height=iframeHeight+20;
	}
</script>
<title><c:out value='${result.bbsNm}'/> - 글조회</title>
</head>
<body onload="onloading();">
<form name="frm" method="post" action="">
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
<input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" />
<input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" />
<input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" />
<input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" />
<!-- //board_view start -->
<div class="board_view">
<table class="view_type01">
	<caption>일반게시판 보기 페이지</caption>
	<colgroup>
		<col width="12%" />
		<col width="*" />
		<col width="12%" />
		<col width="30%" />
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">제목</th>
			<td><c:out value="${result.nttSj}" /></td>
			<th scope="row">작성자</th>
			<td>
		    <c:choose>
		    	<c:when test="${anonymous == 'true'}">
		    		******
		    	</c:when>
		    	<c:when test="${result.ntcrNm == ''}">
		    		<c:out value="${result.frstRegisterNm}" />
		    	</c:when>
		    	<c:otherwise>
		    		<c:out value="${result.ntcrNm}" />
		    	</c:otherwise>
		    </c:choose>			
			</td>
			</tr>
		<tr>
			<th scope="row">등록일</th>
			<td>20009. 11. 01</td>
			<th scope="row">조회수</th>
			<td><c:out value="${result.inqireCo}" /></td>
		</tr>
		<tr>
			<th scope="row" class="con_tit">내용</th>
			<td colspan="3"><c:out value="${result.nttCn}" escapeXml="false" />	
			<br/><br/><br/><br/><br/>
			<br/><br/><br/><br/><br/>
			</td>
		</tr>
	  <c:if test="${anonymous == 'true'}">
	  <tr> 
	    <th height="23"><spring:message code="cop.password" /></th>
	    <td colspan="5">
	    	<input name="password" type="password" size="20" value="" maxlength="20" autocomplete="off" >
	    </td>
	  </tr>
	  </c:if> 		
	</tbody>
</table>
</div>
<div id="btn_area">
	<div class="btn_right_fl">
	<c:if test="${result.frstRegisterId == sessionUniqId}">     
		<a href="javascript:fn_egov_moveUpdt_notice()"><img src="../../images/common/btn/btn_modify.gif" alt="수정" /></a>
		<a href="javascript:fn_egov_delete_notice()"><img src="../../images/common/btn/btn_delete.gif" alt="삭제" /></a>
	</c:if>	
	</div>
	<div class="btn_right_fr">
		<a href="javascript:fn_egov_select_noticeList('1')"><img src="../../images/common/btn/btn_list.gif" alt="목록" /></a>	
	</div>
	
</div><!-- btn end -->
</form>
</body>
</html>