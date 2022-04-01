<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<% 
 /**
  * @Class Name : EgovBdMstrUpdtByTrget.jsp
  * @Description : 게시판 속성정보 변경화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.03.12   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.12
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
<link href="<c:url value='/css/egovframework/cop/bbs/com.css' />" rel="stylesheet" type="text/css">

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardMaster" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	function fn_egov_validateForm(obj) {
		return true;
	}
	
	function fn_egov_update_brdMstr() {

		if (!validateBoardMaster(document.boardMaster)){
			return;
		}
		
		if (confirm('<spring:message code="common.update.msg" />')) {
			document.boardMaster.action = "<c:url value='/admin/bbs/UpdateBBSMasterInfByTrget.do'/>";
			document.boardMaster.submit();					
		}
	}
	
	function fn_egov_select_brdMstrList() {		
		document.boardMaster.action = "<c:url value='/admin/bbs/selectBdMstrListByTrget.do'/>";
		document.boardMaster.submit();	
	}
	
	function fn_egov_delete_brdMstr(){
		if (confirm('<spring:message code="common.delete.msg" />')) {
			document.boardMaster.action = "<c:url value='/admin/bbs/DeleteBBSMasterInfByTrget.do'/>";
			document.boardMaster.submit();	
		}		
	}
	
	function fn_egov_inqire_tmplatInqire() {
		var retVal;
		var url = "<c:url value='/cop/com/openPopup.do?requestUrl=/cop/com/selectTemplateInfsPop.do&typeFlag=BBS&width=850&height=360'/>";		
		var openParam = "dialogWidth: 850px; dialogHeight: 360px; resizable: 0, scroll: 1, center: 1";
		 
		retVal = window.showModalDialog(url,"p_tmplatInqire", openParam);
		if(retVal != null){
			var tmp = retVal.split("|");
			document.boardMaster.tmplatId.value = tmp[0];
			document.boardMaster.tmplatNm.value = tmp[1];
		}
	}	
</script>
<title>게시판 정보수정</title>
</head>
<body>

<form:form commandName="boardMaster" name="boardMaster" method="post">
<input name="pageIndex" type="hidden" value="${searchVO.pageIndex}"/>
<input name="bbsId" type="hidden" value="<c:out value='${result.bbsId}'/>" />
<input name="trgetId" type="hidden" value="<c:out value='${result.trgetId}'/>" />
<input name="bbsTyCode" type="hidden" value="<c:out value='${result.bbsTyCode}'/>" />
<input name="bbsAttrbCode" type="hidden" value="<c:out value='${result.bbsAttrbCode}'/>" />
<input name="replyPosblAt" type="hidden" value="<c:out value='${result.replyPosblAt}'/>" />

<div id="border" style="width:730px">
	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%"class="title_left">
	   <img src="<c:url value='/images/egovframework/cop/bbs/icon/tit_icon.gif' />" width="16" height="16" hspace="3" alt="title icon">&nbsp;게시판 정보수정</td>
	 </tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register">
	  <tr> 
	    <th width="20%" height="23" class="required_text" nowrap >게시판명
	    <img src="<c:url value='/bos/images/common/required.gif' />" width="15" height="15" alt="required"></th>
	    <td width="80%" nowrap colspan="3">
	      <input name="bbsNm" type="text" size="60" value='<c:out value="${result.bbsNm}"/>'  maxlength="60" style="width:100%">
	      <br/><form:errors path="bbsNm" /> 
	    </td>
	  </tr>
	  <tr> 
	    <th height="23" class="required_text" >게시판 소개
	    <img src="<c:url value='/bos/images/common/required.gif' />" width="15" height="15" alt="required"></th>
	    <td colspan="3">
	      <textarea name="bbsIntrcn" class="textarea"  cols="75" rows="4" style="width:100%"><c:out value="${result.bbsIntrcn}"/></textarea> 
	      <form:errors path="bbsIntrcn" />
	    </td>
	  </tr>
	  <tr> 
	    <th width="20%" height="23" class="" nowrap >게시판 유형</th>
	    <td width="30%" nowrap><c:out value="${result.bbsTyCodeNm}"/>	
	    </td>
	    <th width="20%" height="23" class="" nowrap >게시판 속성</th>    
	    <td width="30%" nowrap><c:out value="${result.bbsAttrbCodeNm}"/>	
	    </td>    
	  </tr> 
	  <tr> 
	    <th width="20%" height="23" class="" nowrap >답장가능여부</th>
	    <td><c:out value="${result.replyPosblAt}"/></td>
	    <th width="20%" height="23" class="required_text" nowrap >파일첨부가능여부
	    <img src="<c:url value='/bos/images/common/required.gif' />" width="15" height="15" alt="required"></th>    
	    <td width="30%" nowrap class="">
	     	Y : <input type="radio" name="fileAtchPosblAt" class="radio2" value="Y" <c:if test="${result.fileAtchPosblAt == 'Y'}"> checked="checked"</c:if>>&nbsp;
	     	N : <input type="radio" name="fileAtchPosblAt" class="radio2" value="N" <c:if test="${result.fileAtchPosblAt == 'N'}"> checked="checked"</c:if>>
	     	<br/><form:errors path="fileAtchPosblAt" />
	    </td>    
	  </tr> 
	  <tr> 
	    <th width="20%" height="23" class="required_text" nowrap >첨부가능파일 숫자
	    <img src="<c:url value='/bos/images/common/required.gif' />" width="15" height="15" alt="required"></th>
	    <td width="30%" nowrap>
	     	<select name="posblAtchFileNumber" class="select">fdsf
	  		   <option selected="selected" value"0">--선택하세요--</option>
	  		   <option value='1' <c:if test="${result.posblAtchFileNumber == '1'}">selected="selected"</c:if>>1개</option>
	  		   <option value='2' <c:if test="${result.posblAtchFileNumber == '2'}">selected="selected"</c:if>>2개</option>
	  		   <option value='3' <c:if test="${result.posblAtchFileNumber == '3'}">selected="selected"</c:if>>3개</option>
	  	   </select>
	  	   <br/><form:errors path="bbsIntrcn" />
	    </td>
	    <th width="20%" height="23" class="required_text" nowrap >첨부가능파일사이즈
	    <img src="<c:url value='/bos/images/common/required.gif' />" width="15" height="15" alt="required"></th>    
	    <td width="30%" nowrap>
	     	<select name="posblAtchFileSize" class="select">
	  		   <option selected="selected" value"">--선택하세요--</option>
	  		   <option value='5000000' <c:if test="${result.posblAtchFileNumber == '5000000'}">selected="selected"</c:if>>5M Byte</option>
	  		   <option value='10000000' <c:if test="${result.posblAtchFileNumber == '10000000'}">selected="selected"</c:if>>10M Byte</option>
	  	   </select>
	  	   <br/><form:errors path="posblAtchFileSize" />
	    </td>    
	  </tr>   
	  <tr> 
	    <th width="20%" height="23" class="required_text" nowrap >템플릿 정보
	    <img src="<c:url value='/bos/images/common/required.gif' />" width="15" height="15" alt="required"></th>
	    <td width="30%" nowrap colspan="3">
	     <input name="tmplatNm" type="text" size="20" value="<c:out value="${result.tmplatNm}"/>"  maxlength="20" readonly >
	     <input name="tmplatId" type="hidden" size="20" value='<c:out value="${result.tmplatId}"/>' >
	     &nbsp;<a href="javascript:fn_egov_inqire_tmplatInqire()" style="selector-dummy: expression(this.hideFocus=false);"><img src="<c:url value='/images/egovframework/cop/bbs/icon/search.gif' />"
	     			width="15" height="15" align="absmiddle" alt="search"></a>
		<br/><form:errors path="tmplatId" />
	    </td>
	  </tr>         
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr> 
	    <td height="10"></td>
	  </tr>
	</table>
	<div align="center">
	<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr> 
      <td><img src="<c:url value='/images/egovframework/cop/bbs/btn/bu2_left.gif'/>" width="8" height="20" alt="button left"></td>
      <td background="<c:url value='/images/egovframework/cop/bbs/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_update_brdMstr()">수정</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cop/bbs/btn/bu2_right.gif'/>" width="8" height="20" alt="button right"></td> 
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/cop/bbs/btn/bu2_left.gif'/>" width="8" height="20" alt="button left"></td>
      <td background="<c:url value='/images/egovframework/cop/bbs/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_delete_brdMstr()">삭제</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cop/bbs/btn/bu2_right.gif'/>" width="8" height="20" alt="button right"></td>    
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/cop/bbs/btn/bu2_left.gif'/>" width="8" height="20" alt="button left"></td>
      <td background="<c:url value='/images/egovframework/cop/bbs/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_select_brdMstrList();">목록</a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cop/bbs/btn/bu2_right.gif'/>" width="8" height="20" alt="button right"></td>            	        
	</tr>
	</table>
	</div>
</div>
</form:form>
</body>
</html>