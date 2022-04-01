
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />
					<div class="alert alert-info">
						<ul class="bull">
							<li>문화콘텐츠산업의 장르 및 직업 분류 체계에 따라 직업의 직무내용, 자격요건, 직업전망 등의 상세한 정보를 제공합니다.</li>
						</ul>
					</div>
					<h2 class="point"><c:out value="${result.ctgrySe1Nm }"/> - <c:out value="${result.ctgrySe2Nm }"/></h2>
					<div class="categoryBox">
						<ul class="list-inline">
						<c:forEach var="subResult" items="${subResults }" varStatus="status">
							<li><a href="#sub<c:out value="${status.index }" />"><span class="icoBullLg"></span> <c:out value="${subResult.subSj}" /></a></li>
						</c:forEach>
						</ul>
					</div>

					<h2 class="bgBlackRound"><c:out value="${result.dicarySj}" /> </h2>
					<c:forEach var="subResult" items="${subResults }" varStatus="status">
						<div class="subTxt">
						<a style="text-decoration: none; color: black;" name="sub<c:out value="${status.index }" />"><h3 class="bull"><c:out value="${subResult.subSj}" /></h3></a>

							<ul>
									<%
									pageContext.setAttribute("crlf", "\n");
									%>
									<li><c:out value='${fn:replace(subResult.subCn, crlf, "<br/>")}' escapeXml='false' /><li>
							</ul>
						</div>
					</c:forEach>


					<div class="btnSet tar">
							<c:url var="url" value="/${paramVO.siteName}/job/${paramVO.programId }/list.do?${pageQueryString}" />
							<a class="btn btn-primary" href="<c:out value='${url}' escapeXml='false'/>"><span>목록</span></a>
					</div>
