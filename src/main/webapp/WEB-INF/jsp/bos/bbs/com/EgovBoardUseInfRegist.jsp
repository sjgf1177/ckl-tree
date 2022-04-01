<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<% 
 /**
  * @Class Name : EgovBoardUseInfRegist.jsp
  * @Description : 게시판  사용정보  등록화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.04.02   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.04.02
  *  @version 1.0
  *   
  *  Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/cop/com.css' />" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardUseInf" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	function fn_egov_select_bbsUseInfs(){
		document.boardUseInf.action = "<c:url value='/admin/bbs/com/selectBBSUseInfs.do'/>";
		document.boardUseInf.submit();
	}
	
	function fn_egov_regist_bbsUseInf(){
		if (!validateBoardUseInf(document.boardUseInf)){
			return;
		}
		
		if (confirm('<spring:message code="common.regist.msg" />')) {
			document.boardUseInf.param_trgetType.value = document.boardUseInf.trgetType.value;
			document.boardUseInf.action = "<c:url value='/admin/bbs/com/insertBBSUseInf.do'/>";
			document.boardUseInf.submit();		
		}
	}
	
	function fn_egov_inqire_bbsInf(){
		var retVal;
		var url = "/cop/com/openPopup.do?requestUrl=/admin/bbs/SelectBBSMasterInfsPop.do&width=850&height=520";		
		var openParam = "dialogWidth: 850px; dialogHeight: 520px; resizable: 0, scroll: 1, center: 1";	
		
		retVal = window.showModalDialog(url,"p_cmmntyInqire", openParam);
		if(retVal != null){
			var tmp = retVal.split("|");
			document.boardUseInf.bbsId.value = tmp[0];
			document.boardUseInf.bbsNm.value = tmp[1];
		}		
	}
	
	function fn_egov_selectTargetType(obj) {

		var retVal;
		var _strType = obj.value;
		
		if (_strType == 'CMMNTY') {
			retVal = fn_egov_inqire_cmmnty();
		} else if (_strType == 'CLUB') {
			retVal = fn_egov_inqire_club();
		} else if (_strType == '') {
			retVal = "|";
		} else {
			retVal = "SYSTEM_DEFAULT_BOARD"+"|"+"시스템 활용";
		}
				
		if (retVal != null) {
			var tmp = retVal.split("|");
			document.boardUseInf.trgetId.value = tmp[0];
			document.boardUseInf.trgetNm.value = tmp[1];
		}
	}
	
	function fn_egov_inqire_cmmnty(){
		var retVal;
		var url = "/cop/com/openPopup.do?requestUrl=/cop/cmy/selectCmmntyInfsByPop.do&width=850&height=360";		
		var openParam = "dialogWidth: 850px; dialogHeight: 360px; resizable: 0, scroll: 1, center: 1";
		 
		retVal = window.showModalDialog(url,"p_cmmntyInqire", openParam);
		return retVal;
	}	
	
	function fn_egov_inqire_club(){
		var retVal;
		var url = "/cop/com/openPopup.do?requestUrl=/cop/clb/selectClubInfsByPop.do&width=850&height=360";		
		var openParam = "dialogWidth: 850px; dialogHeight: 360px; resizable: 0, scroll: 1, center: 1";
		 
		retVal = window.showModalDialog(url,"p_cmmntyInqire", openParam);
		return retVal;		
	}
</script>
<title>게시판 사용등록</title>
</head>
<body>
<form:form commandName="boardUseInf" name="boardUseInf" method="post" >
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
<input type="hidden" name="param_trgetType" value="" />

<div id="border" style="width:730px">
	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%"class="title_left">
	   <img src="<c:url value='/images/egovframework/cop/com/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle" alt="title icon">
	   &nbsp;게시판 사용등록</td>
	 </tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register">
	  <tr> 
	    <th width="30%" height="23" class="required_text" nowrap ><spring:message code="cop.bbsNm" />
	    <img src="<c:url value='/images/egovframework/cop/com/icon/required.gif' />" width="15" height="15" alt="required"></th>
	    <td width="70%" nowrap colspan="3">
	      <input name="bbsId" type="hidden" /> 
	      <input name="bbsNm" type="text" size="40" value=""  maxlength="40" readonly /> 
	      &nbsp;<a href="javascript:fn_egov_inqire_bbsInf();" style="selector-dummy: expression(this.hideFocus=false);"><img src="<c:url value='/images/egovframework/cop/com/icon/search.gif' />"
	     			width="15" height="15" align="absmiddle" alt="search" /></a>
 		<br/><form:errors path="bbsId" /> 	     			
	    </td>
	  </tr>
	  <tr> 
	    <th width="30%" height="23" class="required_text" nowrap ><spring:message code="cop.trgetNm" />
	    <img src="<c:url value='/images/egovframework/cop/com/icon/required.gif' />" width="15" height="15" alt="required"></th>
	    <td width="70%" nowrap colspan="3">
		   <select name="trgetType" class="select" onChange="javascript:fn_egov_selectTargetType(this)" >
			   <option selected="selected" value''>--선택하세요--</option>
			   <option value="CMMNTY" >커뮤니티</option>
			   <option value="CLUB" >동호회</option>			   
			   <option value="SYSTEM" >시스템</option>			   
		   </select>
		   <input type="hidden" name="trgetId" value="" />
		   <input type="text" name="trgetNm" value=""  size="40" readOnly />
		   <br/><form:errors path="trgetId" />
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
      <td><img src="<c:url value='/images/egovframework/cop/com/btn/bu2_left.gif'/>" width="8" height="20" alt="button left"></td>
      <td background="<c:url value='/images/egovframework/cop/com/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_regist_bbsUseInf();"><spring:message code="button.create" /></a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cop/com/btn/bu2_right.gif'/>" width="8" height="20" alt="button right"></td> 
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/cop/com/btn/bu2_left.gif'/>" width="8" height="20" alt="button left"></td>
      <td background="<c:url value='/images/egovframework/cop/com/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_select_bbsUseInfs();"><spring:message code="button.list" /></a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cop/com/btn/bu2_right.gif'/>" width="8" height="20" alt="button right"></td>    
	</tr>
	</table>
	</div>
</div>
</form:form>
</body>
</html>