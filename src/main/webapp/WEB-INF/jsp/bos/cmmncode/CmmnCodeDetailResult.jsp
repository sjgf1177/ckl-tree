<%@page contentType="text/html;charset=utf-8" errorPage="/WEB-INF/error/404.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:choose>
<c:when test="${detailCodeZvl.viewType=='view'}">
	<c:forEach items="${selectCodeVO}" var="subItem" varStatus="status">
		<c:out value="${status.first ? '' : ', '}${subItem.codeNm}" />
	</c:forEach>
</c:when>
<c:otherwise>
	<c:choose>
	<c:when test="${detailCodeZvl.inputType=='radio'}">
		<c:set var="objNum" value="1"/>
		<c:forEach items="${detailCodeList}" var="subItem" varStatus="status">
			<c:set var="objId" value="${name}_${objNum}"/>
			<input type="radio" name="${name}" id="${objId}" value="${subItem.code}" ${subItem.code eq detailCodeZvl.selectCode || (detailCodeZvl.viewType eq 'regist' && status.first) ? 'checked="checked"' : ''} <c:if test="${not empty detailCodeZvl.validation && status.first}">class='${detailCodeZvl.validation}'</c:if>/><label for="${objId}">${subItem.codeNm}</label>
			<c:set var="objNum" value="${objNum+1}"/>
		</c:forEach>
	</c:when>
	<c:when test="${detailCodeZvl.inputType=='checkbox'}">
		<c:set var="objNum" value="1"/>
		<c:forEach items="${detailCodeList}" var="subItem" varStatus="status">
			<c:set var="objId" value="${name}_${objNum}"/>
			<input type="checkbox" name="${name}" id="${objId}" value="${subItem.code}" ${fn:indexOf(detailCodeZvl.selectCode, subItem.code)>-1  ? 'checked="checked"' : ''} <c:if test="${not empty detailCodeZvl.validation && status.first}">class='${detailCodeZvl.validation}'</c:if>/><label for="${objId}">${subItem.codeNm}</label>
			<c:set var="objNum" value="${objNum+1}"/>
		</c:forEach>
	</c:when>
	<c:when test="${detailCodeZvl.inputType=='view'}">
		<c:set var="objNum" value="1"/>
		<ul class="box_tab_style_1">
		<c:forEach items="${detailCodeList}" var="subItem" varStatus="status">
			<c:if test="${param.select_code eq subItem.code}">
	        <li><c:if test="${not status.first}"> |&nbsp;</c:if><a href="/global/cts/list.do?pcode=${param.pcode}&amp;menuNo=${param.menuNo}&amp;lang=${lang}&amp;scode=${subItem.code}"><b>${subItem.codeNm}</b></a></li>
	        </c:if>
			<c:if test="${param.select_code != subItem.code}">
	        <li><c:if test="${not status.first}"> |&nbsp;</c:if><a href="/global/cts/list.do?pcode=${param.pcode}&amp;menuNo=${param.menuNo}&amp;lang=${lang}&amp;scode=${subItem.code}">${subItem.codeNm}</a></li>
			</c:if>
		</c:forEach>
		</ul>
	</c:when>
	<c:otherwise>
		<c:forEach items="${detailCodeList}" var="subItem" varStatus="status">
			<option value="${subItem.code}" ${detailCodeZvl.selectCode eq subItem.code ? 'selected="selected"' : ''}>${subItem.codeNm}</option>
		</c:forEach>
	</c:otherwise>
	</c:choose>
</c:otherwise>
</c:choose>