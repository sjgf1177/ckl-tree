<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>

<ccc:constantsMap className="kr.co.unp.siteMng.service.SiteMngService" var="SiteMngService"/>

<c:set var="ImgUrl" value="/images/egovframework/sym/mpm/"/>
<c:set var="CssUrl" value="/css/egovframework/sym/mpm/"/>

<c:set var="siteId" value="${siteId}" />
<c:if test="${empty siteId}" >
	<c:set var="siteId" value="1" />
</c:if>

<%
String imagePath_icon   = "/bos/images/common/";
String imagePath_button = "/images/egovframework/sym/mpm/button/";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />
<meta name="keywords" content="<spring:message code='site.korName' text=''/>" />
<meta name="description" content="<spring:message code='site.korName' text=''/>" />
<meta name="author" content="<spring:message code='site.korName' text=''/>" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />


<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.css">

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/jquery-ui/jquery-ui.js"></script>

<title>메뉴정보등록</title>
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="<c:url value="/validator.do" />"></script>
<script type="text/javascript">
$(function(){
	$("#pageUnit").change(function(){
		var size = $(this).val();
		$("#frm")[0].submit();
	});

	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
});
</script>
</head>
<body>
	<div id="content">
		<div class="hgroup"><h3>페이지만족도</h3></div>

		<!-- 게시판 게시물검색 start -->
		<form method="post" name="frm" action="/bos/satisfaction/menuStatusView.do">
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>사이트선택
				<select id="siteId" name="siteId" class="input_select">
				     <c:forEach var="site" items="${siteList}" varStatus="status">
					 	<c:set var="data"><util:fz source="${site.siteId}" resultLen="2" isFront="true" /></c:set>
					    <c:if test="${site.siteId ne '1' }"><option value='${data}' <c:if test='${fn:indexOf(data,param.siteId) ne -1 and not empty param.siteId}'>selected='selected'</c:if> >${site.siteDesc}</option></c:if>
					 </c:forEach>
				</select>
				<span class="boardsearch">
					<input type="text" id="sdate" name="sdate" value="${param.sdate}" class="board1" style="width:70px;" title="검색 시작날싸입력 예 2011-10-24" readonly />
					~
					<input type="text" id="edate" name="edate" value="${param.edate}" class="board1" style="width:70px;" title="검색 종료날짜 입력 예 2011-10-24" readonly />

				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
				</span>
			</fieldset>
		</div>
		</form>

<form name="menuListForm" action ="/bos/sym/mpm/MenuListSelect.do" method="post">
<input type="hidden" name="req_RetrunPath" value="/bos/sym/mpm/MenuList" />
<input type="hidden" name="siteId" value="${siteId}" />
<DIV id="main" style="display:">

<link rel="StyleSheet" href="/common/dtree/dtree.css" type="text/css" />
<script type="text/javascript" src="/common/dtree/dtree.js"></script>

<p><img src="<%=imagePath_icon %>tit_icon.gif" width="16" height="16" hspace="3" align="absmiddle"/>&nbsp;메뉴 목록</td></p>
<!-- 메뉴사용 여부 표시 -->
<c:set var="deleteRedTagSt" value="<font color=red>"/>
<c:set var="deleteRedTagEn" value="</font>"/>
<table width="780" cellpadding="8" class="table-search" border="0">
  <tr>
   <td width="240" height="800"  class="title_left" rowspan='2'>
	<div class="tree" style="position:absolute; left:0px; top:180px; width:228px; z-index:10; BORDER : #EEEEEE 0.5pt solid;">

	<script type="text/javascript">
		//<!CDATA[
		d = new dTree('d');
		d.add(0,-1,'메뉴 관리');
		<c:forEach var="result" items="${list_menulist}" varStatus="status" ><c:if test="${result.useYn eq 'Y'}"><c:out value="d.add(${result.menuNo},${result.upperMenuNo},'${result.menuNm}','/bos/satisfaction/menuStatusView.do?siteId=${result.siteId}&cMenuNo=${result.menuNo}');" escapeXml="false"/></c:if>
		<c:if test="${result.useYn eq 'N'}"><c:out value="d.add(${result.menuNo},${result.upperMenuNo},'${result.menuNm}${deleteRedTagSt}(x)${deleteRedTagEn}','/bos/satisfaction/menuStatusView.do?siteId=${result.siteId}&cMenuNo=${result.menuNo}');" escapeXml="false"/></c:if>
		<c:if test="${result.menuNo eq cMenuNo}"><c:set var="cMenu" value="${result}"/></c:if></c:forEach>
		document.write(d);
		//]]>
	</script>
	</div>
   </td>

   <td width="540" valign="top" style="margin:0; padding:0">
   <div>
	<table class="table table-bordered table-striped table-hover" cellpadding="0" cellspacing="0" width="100%">
   		<caption>게시판 목록</caption>
			<colgroup>
				<col width="15%" />
				<col width="15%" />
				<col width="*" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">만족도</th>
					<th scope="col">비율</th>
					<th scope="col">그래프</th>
					<th scope="col" class="last">참여수</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="item" items="${resultMap}" varStatus="status">
				<tr>
					<td class="output"><a href="/bos/satisfaction/opinionList/${item.value.status}.do?siteId=${param.siteId}&sdate=${param.sdate}&edate=${param.edate}"><strong style="color: drakgray;">${item.value.statusName}</strong></a>
					</td>
					<td class="output">${item.value.statusCnt}/${item.value.totCnt}(${item.value.statusPercent}%)</td>
					<td class="output tal">
						 <img src="/images/grp1.gif" style="width:${item.value.statusPercent}%; height:8px" alt="" />
					</td>
					<td class="output"><a href="/bos/satisfaction/opinionList.do?siteId=${param.siteId}&status=${item.value.status}&sdate=${param.sdate}&edate=${param.edate}"><strong style="color: drakgray;">${item.value.statusCnt}</strong></a></td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultMap) == 0}"><tr><td colspan="9">데이터가 없습니다.</td></tr></c:if>
			</tbody>
   	</table>
   </div>
   </td>
 </tr>

</table>
<br/>

<div>
    <input type="hidden" name="tmp_SearchElementName" value="">
    <input type="hidden" name="tmp_SearchElementVal" value="">
    <input type="hidden" name="tmp_CheckVal" value="">
</DIV>

</form>
</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>