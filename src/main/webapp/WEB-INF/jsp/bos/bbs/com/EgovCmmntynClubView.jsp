<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovCmmntyView.jsp
  * @Description : 커뮤니티 목록 초기화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.04.08   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.04.08
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

<title>커뮤니티 및 동호회 목록</title>
</head>
<body>

<div id="border" style="width:730px">
	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%"class="title_left">
	   <img src="<c:url value='/images/egovframework/cop/cmy/icon/tit_icon.gif' />" width="16" height="16" hspace="3" alt="title icon">
	   &nbsp;커뮤니티 목록</td>
	 </tr>
	 <tr>
	 	<td><c:import url="/cop/cus/CmmntyListPortlet.do" charEncoding="utf-8" />
	 	</td>
	 </tr>
	</table>
	<br/>
	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%"class="title_left">
	   <img src="<c:url value='/images/egovframework/cop/cmy/icon/tit_icon.gif' />" width="16" height="16" hspace="3" alt="title icon">
	   &nbsp;동호회 목록</td>
	 </tr>
	 <tr>
	 	<td><c:import url="/cop/cus/ClubListPortlet.do" charEncoding="utf-8" />
	 	</td>
	 </tr>
	</table>
</div>
</body>
</html>