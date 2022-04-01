<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
 /**
  * @Class Name : EgovConfirmList.jsp
  * @Description : 승인 목록화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.04.13   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.04.13
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
<link href="<c:url value='/css/egovframework/cop/com.css' />" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_confirmList('1');
		}
	}
	
	function fn_egov_select_confirmList(pageNo) {
		var target = document.frm.trgetId.value; 
		var actionUrl;
		
		if (target == '') {
			actionUrl = "<c:url value='/cop/com/selectConfirmRequest.do'/>";
		} else {
			actionUrl = "<c:url value='/cop/com/selectConfirmRequestByTrget.do'/>";
		}
		
		document.frm.pageIndex.value = pageNo;
		document.frm.action = actionUrl;
		document.frm.submit();
	}
	
	function fn_egov_inqire_confirmInfo(cnfmNo) {
		document.frm.confmNumber.value = cnfmNo;
		document.frm.action = "<c:url value='/cop/com/forUpdateConfirmRequest.do'/>";
		document.frm.submit();		
	}
</script>
<title>승인 목록</title>
</head>
<body>
<form name="frm" action ="" method="post">
<input type="hidden" name="confmNumber" value="0" />
<input type="hidden" name="confmerId" value='<c:out value="${searchVO.confmerId}"/>' />

<input type="hidden" name="trgetId" value="<c:out value="${searchVO.trgetId}"/>" />

<div id="border" style="width:730px">
	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="40%"class="title_left">
	   <img src="<c:url value='/images/egovframework/cop/com/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle" alt="title icon">
	   &nbsp;승인 목록</td>
	  <th >
	  </th>
	  <td width="10%" >
	   		<select name="searchCnd" class="select">
			   <!-- option selected="selected" value''>--선택하세요--</option-->
			   <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >승인유형</option>
			   <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >승인상태</option>	
		   </select>
		</td>
	  <td widht="35%">
	    <input name="searchWrd" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>'  maxlength="35" onkeypress="press(event);"> 
	  </td>
	  <th width="10%">
	   <table border="0" cellspacing="0" cellpadding="0">
	    <tr> 
	      <td><img src="<c:url value='/images/egovframework/cop/com/btn/bu2_left.gif' />" width="8" height="20" alt="button left"></td>
	      <td background="<c:url value='/images/egovframework/cop/com/btn/bu2_bg.gif'/>" class="text_left" nowrap>
	      <a href="javascript:fn_egov_select_confirmList('1')">조회</a> 
	      </td>
	      <td><img src="<c:url value='/images/egovframework/cop/com/btn/bu2_right.gif'/>" width="8" height="20" alt="button right"></td>
	    </tr>
	   </table>
	  </th>  
	 </tr>
	</table>
	<table width="100%" cellpadding="8" class="table-line">
	 <thead>
	  <tr>
	    <!-- th class="title" width="3%" nowrap><input type="checkbox" name="all_check" class="check2"></th-->  
	    <th class="title" width="10%" nowrap>번호</th>
	    <th class="title" width="15%" nowrap>승인유형</th>
	    <th class="title" width="10%" nowrap>승인상태</th>
	    <th class="title" width="22%" nowrap>승인요청자</th>
	    <th class="title" width="20%" nowrap>대상업무유형</th>   
	    <th class="title" width="10%" nowrap>승인일자</th>         
	  </tr>
	 </thead>    
		
	 <tbody>
		 <c:forEach var="result" items="${resultList}" varStatus="status">
		  <tr>
		    <!--td class="lt_text3" nowrap><input type="checkbox" name="check1" class="check2"></td-->
		    <td class="lt_text3" nowrap><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>		    
		    <td class="lt_text3" nowrap>
		    	<c:choose>
		    		<c:when test="${result.confmSttusCode == 'AP01'}">
				    	<a href="javascript:fn_egov_inqire_confirmInfo('<c:out value="${result.confmNumber}"/>')">
				    	<c:out value="${result.confmTyCodeNm}"/></a>		    		
		    		</c:when>
		    		<c:otherwise>
		    			<c:out value="${result.confmTyCodeNm}"/>
		    		</c:otherwise>
		    	</c:choose>

		    </td>
		    <td class="lt_text3" nowrap><c:out value="${result.confmSttusCodeNm}"/></td>
		    <td class="lt_text3" nowrap><c:out value="${result.confmRqesterNm}"/></td>
		    <td class="lt_text3" nowrap><c:out value="${result.opertTyCodeNm}"/></td>  
			<td class="lt_text3" nowrap><c:out value="${result.confmDe}"/></td	>	    
		  </tr>
		 </c:forEach>	  
		 <c:if test="${fn:length(resultList) == 0}">
		  <tr>
		    <td class="lt_text3" nowrap colspan="6" ><spring:message code="common.nodata.msg" /></td>  
		  </tr>		 
		 </c:if>
 
	 </tbody>  

	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr> 
	    <td height="10"></td>
	  </tr>
	</table>
	<div align="center">
		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_confirmList" />
	</div>
	<input name="pageIndex" type="hidden" value="${searchVO.pageIndex}"/>
</div>
</form>
</body>
</html>