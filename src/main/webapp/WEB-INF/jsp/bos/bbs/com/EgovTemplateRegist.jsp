<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<% 
 /**
  * @Class Name : EgovTemplateRegist.jsp
  * @Description : 템플릿 속성 등록화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.03.18   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.18
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
<validator:javascript formName="templateInf" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	function fn_egov_regist_tmplatInfo(){
		if (!validateTemplateInf(document.templateInf)){
			return;
		}
		
		if (confirm('<spring:message code="common.regist.msg" />')) {
			document.templateInf.action = "<c:url value='/cop/com/insertTemplateInf.do'/>";
			document.templateInf.submit();
		}
	}
	
	function fn_egov_select_tmplatInfo(){
		document.templateInf.action = "<c:url value='/cop/com/selectTemplateInfs.do'/>";
		document.templateInf.submit();	
	}

	function fn_egov_selectTmplatType(obj){
		if (obj.value == 'TMPT01') {
			document.getElementById('sometext').innerHTML = "게시판 템플릿은 CSS만 가능합니다.";
		} else if (obj.value == '') {
			document.getElementById('sometext').innerHTML = "";
		} else {
			document.getElementById('sometext').innerHTML = "템플릿은 JSP만 가능합니다.";
		}		
	}

	function fn_egov_previewTmplat() {
		var frm = document.templateInf;
		
		var url = frm.tmplatCours.value;

		var target = "";

		if (frm.tmplatSeCode.value == 'TMPT01') {
			target = "/cop/bbs/previewBoardList.do";
			width = "750";
		} else if (frm.tmplatSeCode.value == 'TMPT02') {
			target = "/cop/cmy/previewCmmntyMainPage.do";
			width = "980";
		} else if (frm.tmplatSeCode.value == 'TMPT03') {
			target = "/cop/cus/previewClubMainPage.do";
			width = "980";
		} else {
			alert('<spring:message code="cop.tmplatCours" /> 지정 후 선택해 주세요.');
		}

		if (target != "") {
			window.open(target + "?searchWrd="+url, "preview", "width=" + width + "px, height=500px;");
		}
	}
</script>
<title>템플릿 등록</title>
</head>
<body>
<form:form commandName="templateInf" name="templateInf" method="post" >
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />

<div id="border" style="width:730px">
	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%"class="title_left">
	   <img src="<c:url value='/images/egovframework/cop/com/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle" alt="title icon">&nbsp;템플릿 정보등록</td>
	 </tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register">
	  <tr> 
	    <th width="20%" height="23" class="required_text" nowrap ><spring:message code="cop.tmplatNm" />
	    <img src="<c:url value='/images/egovframework/cop/com/icon/required.gif' />" width="15" height="15" alt="required"></th>
	    <td width="80%" nowrap>
	      <input name="tmplatNm" type="text" size="60" value="" maxlength="60" style="width:100%">
	      <br/><form:errors path="tmplatNm" /> 
	    </td>
	  </tr>
	  <tr> 
	    <th height="23" class="required_text" ><spring:message code="cop.tmplatSeCode" />
	    <img src="<c:url value='/images/egovframework/cop/com/icon/required.gif' />" width="15" height="15" alt="required"></th>
	    <td>
	   	<select name="tmplatSeCode" class="select" onchange="fn_egov_selectTmplatType(this)">
			   <option selected="selected" value''>--선택하세요--</option>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
			</c:forEach>	
		   </select>&nbsp;&nbsp;&nbsp;<span id="sometext"></span>
		   <br/><form:errors path="tmplatSeCode" />
	    </td>
	  </tr> 
	  <tr> 
	    <th width="20%" height="23" class="required_text" nowrap ><spring:message code="cop.tmplatCours" />
	    <img src="<c:url value='/images/egovframework/cop/com/icon/required.gif' />" width="15" height="15" alt="required"></th>
	    <td width="80%" nowrap>
	      <input name="tmplatCours" type="text" size="60" value="" maxlength="60" style="width:100%">
	      <br/><form:errors path="tmplatCours" /> 
	    </td>
	  </tr>
	  <tr> 
	    <th width="20%" height="23" class="required_text" nowrap ><spring:message code="cop.useAt" />
	    <img src="<c:url value='/images/egovframework/cop/com/icon/required.gif' />" width="15" height="15" alt="required"></th>
	    <td width="80%" nowrap>
	     	Y : <input type="radio" name="useAt" class="radio2" value="Y"  checked>&nbsp;
	     	N : <input type="radio" name="useAt" class="radio2" value="N">
	     	<br/><form:errors path="useAt" />
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
      <a href="javascript:fn_egov_regist_tmplatInfo();"><spring:message code="button.create" /></a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cop/com/btn/bu2_right.gif'/>" width="8" height="20"alt="button right"></td> 
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/cop/com/btn/bu2_left.gif'/>" width="8" height="20" alt="button left"></td>
      <td background="<c:url value='/images/egovframework/cop/com/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_select_tmplatInfo();"><spring:message code="button.list" /></a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cop/com/btn/bu2_right.gif'/>" width="8" height="20" alt="button right"></td>
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/cop/com/btn/bu2_left.gif'/>" width="8" height="20" alt="button left"></td>
      <td background="<c:url value='/images/egovframework/cop/com/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_previewTmplat();"><spring:message code="cop.preview" /></a> 
      </td>
      <td><img src="<c:url value='/images/egovframework/cop/com/btn/bu2_right.gif'/>" width="8" height="20" alt="button right"></td>            
	</tr>
	</table>
	</div>
</div>
</form:form>
</body>
</html>