<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<% 
 /**
  * @Class Name : EgovNoticeRegist.jsp
  * @Description : 게시물  생성 화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.03.24   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.24
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
<script type="text/javascript">
_editor_area = "nttCn";
</script>
<script type="text/javascript" src="<c:url value='/html/egovframework/cmm/utl/htmlarea3.0/htmlarea.js'/>"></script>

<!-- script type="text/javascript" src="<c:url value='/html/egovframework/cmm/utl/htmlarea/EgovWebEditor.js'/>" ></script-->


<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">
	function fn_egov_validateForm(obj) {
		return true;
	}
	
	function fn_egov_regist_notice() {
		document.board.onsubmit();
		
		if (!validateBoard(document.board)){
			return;
		}
		
		if (confirm('<spring:message code="common.regist.msg" />')) {
			//document.board.onsubmit();
			document.board.action = "<c:url value='/admin/bbs${prefix}/insertBoardArticle.do'/>";
			document.board.submit();					
		}
	}
	
	function fn_egov_select_noticeList() {
		document.board.action = "<c:url value='/admin/bbs${prefix}/selectBoardList.do'/>";
		document.board.submit();	
	}	
</script>

<title><c:out value='${bdMstr.bbsNm}'/> - 게시글쓰기</title>
</head>
<!-- body onload="javascript:editor_generate('nttCn');"-->
<body onLoad="HTMLArea.init(); HTMLArea.onload = initEditor; document.board.nttSj.focus();">

<form:form commandName="board" name="board" method="post" enctype="multipart/form-data" >

<input name="pageIndex" type="hidden" value="${searchVO.pageIndex}"/>
<input type="hidden" name="bbsId" value="<c:out value='${bdMstr.bbsId}'/>" />
<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
<input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
<input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
<input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
<input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />

<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
<input type="hidden" name="authFlag" value="<c:out value='${bdMstr.authFlag}'/>" />

<c:if test="${anonymous != 'true'}">
<input type="hidden" name="ntcrNm" value="dummy">	<!-- validator 처리를 위해 지정 -->
<input type="hidden" name="password" value="dummy">	<!-- validator 처리를 위해 지정 -->
</c:if>

<c:if test="${bdMstr.bbsAttrbCode != 'BBSA01'}">
   <input name="ntceBgnde" type="hidden" value="10000101">
   <input name="ntceEndde" type="hidden" value="99991231">
</c:if>

<fieldset>
<div  class="board_view">
<table class="view_type01">
	<caption>게시판 쓰기</caption>
	<colgroup>
		<col width="20%" />
		<col width="30%" />
		<col width="20%" />
		<col width="30%" />
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="date1">작성자</label></th>
			<td>
				<input type="text" id="date1" style="width:125px" class="board1" />
			</td>
			<th scope="row" class="b_l"><label for="date2">작성일</label></th>
			<td>
				<input type="text" id="date2" style="width:125px" class="board1" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="num1">전화번호</label></th>
			<td>
				<input type="text" id="num1" style="width:30px" class="board1" title="전화번호국번" /> -
				<label for="num2" class="blind">전화 두번째 번호</label>
				<input type="text" id="num2" style="width:30px" class="board1" title="전화 두번째 번호" /> -
				<label for="num3" class="blind">전화 세번째 번호</label>
				<input type="text" id="num3" style="width:30px" class="board1" title="전화 세번째 번호" />
			</td>
			<th scope="row" class="b_l"><label for="cnum1">휴대 전화번호</label></th>
			<td>								
				<input type="text" id="cnum1" style="width:30px" class="board1" title="휴대전화번호국번" /> -
				
				<label for="cnum2" class="blind">휴대전화 두번째 번호</label>
				<input type="text" id="cnum2" style="width:30px" class="board1" title="휴대전화 두번째 번호" /> -
				
				<label for="cnum3" class="blind">휴대전화 세번째 번호</label>
				<input type="text" id="cnum3" style="width:30px" class="board1" title="휴대전화 세번째 번호" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="subject"><spring:message code="cop.nttSj" /></label></th>
			<td colspan="3">
				<input type="text" name="nttSj" id="subject" style="width:510px" class="board1" />
			</td>
		</tr><form:errors path="nttSj" />							
		<tr>
			<th scope="row" class="con_tit"><label for="writecontents"><spring:message code="cop.nttCn" /></label></th>
			<td colspan="3">								
		      <textarea id="nttCn" name="nttCn" class="textarea" cols="75" rows="28" style="width:550px;"></textarea> 
		      <form:errors path="nttCn" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="subject">비밀글</label></th>
			<td colspan="3">
		     	<spring:message code="button.possible" /> : <input type="radio" name="secret"  value="Y" />&nbsp;
		     	<spring:message code="button.impossible" /> : <input type="radio" name="secret"  value="N"  />
		     	<br/><form:errors path="secret" />
			</td>
		</tr>		
   <c:choose>
	  	<c:when test="${bdMstr.bbsAttrbCode == 'BBSA01'}">
		  <tr> 
		    <th height="23" class="emphasisRight"><spring:message code="cop.noticeTerm" />
		    <img src="<c:url value='/bos/images/common/required.gif' />" width="15" height="15" alt="required"></th>
		    <td colspan="3">
		      <input name="ntceBgnde" type="hidden" >
		      <input name="ntceBgndeView" type="text" size="10" value=""  readOnly
		      	onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceBgnde, document.board.ntceBgndeView);" >
		      <img src="<c:url value='/images/egovframework/cop/bbs/icon/bu_icon_carlendar.gif' />"
		      	onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceBgnde, document.board.ntceBgndeView);"
			    width="15" height="15" alt="calendar">
		      ~
		      <input name="ntceEndde" type="hidden"  />
		      <input name="ntceEnddeView" type="text" size="10" value=""  readOnly
		      	onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceEndde, document.board.ntceEnddeView);"  >
		      <img src="<c:url value='/images/egovframework/cop/bbs/icon/bu_icon_carlendar.gif' />"
		      	onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceEndde, document.board.ntceEnddeView);"
			    width="15" height="15" alt="calendar">
			    <br/><form:errors path="ntceBgnde" />
			    <br/><form:errors path="ntceEndde" />
			    
		    </td>
		  </tr>	  	
	  	</c:when>
	  	<c:when test="${anonymous == 'true'}">
		  <tr> 
		    <th height="23" class="emphasisRight"><spring:message code="cop.ntcrNm" />
		    <img src="<c:url value='/bos/images/common/required.gif' />" width="15" height="15" alt="required"></th>
		    <td colspan="3">
		      <input name="ntcrNm" type="text" size="20" value="" maxlength="10" >
		    </td>
		  </tr>
		  <tr> 
		    <th height="23" class="emphasisRight"><spring:message code="cop.password" />
		    <img src="<c:url value='/bos/images/common/required.gif' />" width="15" height="15" alt="required"></th>
		    <td colspan="3">
		      <input name="password" type="password" size="20" value="" maxlength="20" autocomplete="off" >
		    </td>
		  </tr>	  	
	  	</c:when>
	  	<c:otherwise>
	  	
	  	</c:otherwise>
	  </c:choose>

	  <c:if test="${bdMstr.fileAtchPosblAt == 'Y'}">  	  	  
	  <tr>
	    <th height="23"><spring:message code="cop.atchFile" /></th>
	    <td colspan="3">
            <table width="100%" cellspacing="0" cellpadding="0" border="0" align="center">
			    <tr>
			        <td><input name="file_1" id="egovComFileUploader" type="file" /></td>
			    </tr>
			    <tr>
			        <td>
			        	<div id="egovComFileList"></div>
			        </td>
			    </tr>
   	        </table>		      
	    </td>
	  </tr>
     <script type="text/javascript">
	     var maxFileNum = document.board.posblAtchFileNumber.value;
	     if(maxFileNum==null || maxFileNum==""){
	    	 maxFileNum = 3;
	     }     
		 var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
		 multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );			
     </script>	  
      
	  </c:if>
	</tbody>
</table>
</div>
	
</fieldset>
 
				<div id="btn_area">
	<div class="btn_right_fr">
		<a href="javascript:fn_egov_regist_notice();"><img src="../../images/common/btn/btn_regist.gif" alt="등록" /></a>
		<a href="javascript:fn_egov_select_noticeList();"><img src="../../images/common/btn/btn_list.gif" alt="목록" /></a>	
	</div>
	
</div><!-- btn end -->
 
</form:form>
</body>
</html>