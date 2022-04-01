<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>

<%!
public String removeTag(String html) throws Exception {
	return html.replaceAll("<(/)?([a-zA-Z0-9]*)(\\s[a-zA-Z0-9]*=[^>]*)?(\\s)*(/)?>", "").replaceAll("&nbsp;"," ");
}
%>

	<!-- 본문 컨텐츠 시작-->
	<!--section1-->

	<h2>교육지원사업</h2>
	<ul>
		<c:forEach items="${creList}" var="result" varStatus="status">
		<c:set var='content' value='${result.nttCn}'/>
		<c:set var='imgDesc' value='${result.imgDesc}'/>
		<%
			String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
			content = removeTag(content);
			if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";
		%>
		<li style="border:1px solid blue;">
			<a href="/edu/bbs/${result.bbsId}/view.do?nttId=${result.nttId}&menuNo=500036">
				<span style="font-size:15px;font-weight:bold;">
					<!--제목-->${result.nttSj}
				</span>
			</a>
			<div style="float:right;">
				<span style="border:1px solid gray;font-size:15px;color:blue;">
					<!--메뉴,게시판이름-->${result.menuName}
				</span>
			</div>
			<div>
				<!--이미지--><img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" alt="<c:out value="${result.nttSj}"/>">
			</div>
			<div>
				<!--내용--><%= content.substring(0,300) %>
			</div>
			<div style="text-align:right;">
				<!--날짜-->${result.regDate}
			</div>
		</li>
		</c:forEach>
	</ul>

	<h2>창의현장</h2>
	<ul>
		<c:forEach items="${B0000041List}" var="result" varStatus="status">
		<c:set var='content' value='${result.nttCn}'/>
		<c:set var='imgDesc' value='${result.imgDesc}'/>
		<%
			String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
			content = removeTag(content);
			if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";
		%>
		<li style="border:1px solid blue;">
			<a href="/edu/bbs/${result.bbsId}/view.do?nttId=${result.nttId}&menuNo=500036">
				<span style="font-size:15px;font-weight:bold;">
					<!--제목-->${result.nttSj}
				</span>
			</a>
			<div>
				<!--이미지--><img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" alt="<c:out value="${result.nttSj}"/>">
			</div>
			<div>
				<!--내용--><%= content.substring(0,300) %>
			</div>
			<div style="text-align:right;">
				<!--날짜-->${result.regDate}
			</div>
		</li>
		</c:forEach>
	</ul>

	<h2>미디어존</h2>
	<ul>
		<c:forEach items="${B0000040List}" var="result" varStatus="status">
		<c:set var='content' value='${result.nttCn}'/>
		<c:set var='imgDesc' value='${result.imgDesc}'/>
		<%
			String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
			content = removeTag(content);
			if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";
		%>
		<li style="border:1px solid blue;">
			<a href="/edu/bbs/${result.bbsId}/view.do?nttId=${result.nttId}&menuNo=500044">
				<span style="font-size:15px;font-weight:bold;">
					<!--제목-->${result.nttSj}
				</span>
			</a>
			<div>
				<!--이미지--><img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" alt="<c:out value="${result.nttSj}"/>">
			</div>
			<div>
				<!--내용--><%= content.substring(0,300) %>
			</div>
			<div style="text-align:right;">
				<!--날짜-->${result.regDate}
			</div>
		</li>
		</c:forEach>
	</ul>

	<h2>창의클럽커뮤니티</h2>
	<ul>
		<c:forEach items="${B0000043List}" var="result" varStatus="status">
		<c:set var='content' value='${result.nttCn}'/>
		<c:set var='imgDesc' value='${result.imgDesc}'/>
		<%
			String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
			content = removeTag(content);
			if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";
		%>
		<li style="border:1px solid blue;">
			<a href="/edu/bbs/${result.bbsId}/view.do?nttId=${result.nttId}&menuNo=500045">
				<span style="font-size:15px;font-weight:bold;">
					<!--제목-->${result.nttSj}
				</span>
			</a>
			<div style="text-align:right;">
				<!--날짜-->${result.regDate}
			</div>
		</li>
		</c:forEach>
	</ul>

	<!-- 본문 컨텐츠 끝-->