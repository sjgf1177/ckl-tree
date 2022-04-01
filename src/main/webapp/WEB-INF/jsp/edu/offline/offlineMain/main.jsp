<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>

<%!
public String removeTag(String html) throws Exception {
	return html.replaceAll("<(/)?([a-zA-Z0-9]*)(\\s[a-zA-Z0-9]*=[^>]*)?(\\s)*(/)?>", "").replaceAll("&nbsp;"," ");
}

public int menuNoPrg(int prgCl)  { // 프로그램 메뉴넘버 반환
						/*인사이트*//*스탭업*//*플러스*//* 밸류업 */
	int menuNo [] = { 500215, 500216, 500217, 500105 };
	int prgNo [] = 		{ 13, 12, 10, 15 };
	
	for ( int p=0; p<prgNo.length; p++ )
		if ( prgNo[p] == prgCl )
			return menuNo[p];
	return -1;
}
%>

<div class="colGoup mt30">
	<!-- 본문 컨텐츠 시작-->
	<!--section1-->
	
	<h2>오프라인교육 핫이슈</h2>
	<ul>
	    <c:forEach var="result" items="${issueList}" varStatus="status">
	    <c:set var='content' value='${result.content}'/>
	    <c:set var='imgDesc' value='${result.imgDesc}'/>
	    <c:set var='prgCl' value='${result.prgCl}'/>
		<%
			String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
			content = removeTag(content);
			if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

			int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
		%>
		<li style="border:1px solid blue;">
 			<a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}">
				<span style="font-size:15px;font-weight:bold;">
					<!--제목-->${result.title}
				</span>
			</a>
			<div style="float:right;">
				<span style="border:1px solid gray;">
					<!--프로그램이름-->${result.prgClNm}
				</span>
			</div>
			<div>
				<!--내용--><%= content %>
			</div>
			<br>
			<div style="text-align:right;">
				<!--날짜-->${result.registDate}
			</div>
		</li>
		</c:forEach>
	</ul>
	
	<h2>콘텐츠 인사이트</h2>
	<ul>
	    <c:forEach var="result" items="${insightList}" varStatus="status">
	    <c:set var='content' value='${result.prgNm}'/>
	    <c:set var='imgDesc' value='${result.imgDescCn}'/>
	    <c:set var='prgCl' value='${result.prgCl}'/>
		<%
			String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
			content = removeTag(content);
			if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

			int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
			
			
		%>
		<li style="border:1px solid blue;">
			<span style="border:1px solid gray;margin-right:10px;">
				<!--진행정보-->
				<c:choose>
					<c:when test="${result.progrsSttus == 'W'}">대기</c:when>
					<c:when test="${result.progrsSttus == 'P'}">진행</c:when>
					<c:when test="${result.progrsSttus == 'FP'}">진행</c:when>
					<c:when test="${result.progrsSttus == 'F'}">마감</c:when>
				</c:choose>
				<!--//진행정보-->
			</span>
			<a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}">
				<span style="font-size:15px;font-weight:bold;">
					<!--제목-->${result.prgNm}
				</span>
			</a>
			<div>
				<!--신청방식-->${result.reqstMthdNm}
			</div>
	    </li>
	    
	    <!-- 
		 -->
		</c:forEach>
		<c:if test="${fn:length(insightList) == 0}" >
			<li>데이터가 없습니다.</li>
		</c:if>
	</ul>
	
	<h2>콘텐츠 스텝업</h2>
	<ul>
	    <c:forEach var="result" items="${stepList}" varStatus="status">
	    <c:set var='content' value='${result.prgNm}'/>
	    <c:set var='imgDesc' value='${result.imgDescCn}'/>
	    <c:set var='prgCl' value='${result.prgCl}'/>
		<%
			String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
			content = removeTag(content);
			if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

			int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
			
			
		%>
		<li style="border:1px solid blue;">
			<span style="border:1px solid gray;margin-right:10px;">
				<!--진행정보-->
				<c:choose>
					<c:when test="${result.progrsSttus == 'W'}">대기</c:when>
					<c:when test="${result.progrsSttus == 'P'}">진행</c:when>
					<c:when test="${result.progrsSttus == 'FP'}">진행</c:when>
					<c:when test="${result.progrsSttus == 'F'}">마감</c:when>
				</c:choose>
				<!--//진행정보-->
			</span>
			<a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}">
				<span style="font-size:15px;font-weight:bold;">
					<!--제목-->${result.prgNm}
				</span>
			</a>
			<div>
				<!--신청방식-->${result.reqstMthdNm}
			</div>
	    </li>
	    
	    <!-- 
		 -->
		</c:forEach>
		<c:if test="${fn:length(insightList) == 0}" >
			<li>데이터가 없습니다.</li>
		</c:if>
	</ul>
	
	<h2>콘텐츠 플러스</h2>
	<ul>
	    <c:forEach var="result" items="${plusList}" varStatus="status">
	    <c:set var='content' value='${result.prgNm}'/>
	    <c:set var='imgDesc' value='${result.imgDescCn}'/>
	    <c:set var='prgCl' value='${result.prgCl}'/>
		<%
			String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
			content = removeTag(content);
			if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

			int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
			
			
		%>
		<li style="border:1px solid blue;">
			<span style="border:1px solid gray;margin-right:10px;">
				<!--진행정보-->
				<c:choose>
					<c:when test="${result.progrsSttus == 'W'}">대기</c:when>
					<c:when test="${result.progrsSttus == 'P'}">진행</c:when>
					<c:when test="${result.progrsSttus == 'FP'}">진행</c:when>
					<c:when test="${result.progrsSttus == 'F'}">마감</c:when>
				</c:choose>
				<!--//진행정보-->
			</span>
			<a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}">
				<span style="font-size:15px;font-weight:bold;">
					<!--제목-->${result.prgNm}
				</span>
			</a>
			<div>
				<!--신청방식-->${result.reqstMthdNm}
			</div>
	    </li>
	    
	    <!-- 
		 -->
		</c:forEach>
		<c:if test="${fn:length(insightList) == 0}" >
			<li>데이터가 없습니다.</li>
		</c:if>
	</ul>
	
	<h2>콘텐츠 밸류업</h2>
	<ul>
	    <c:forEach var="result" items="${valueUpList}" varStatus="status">
	    <c:set var='content' value='${result.prgNm}'/>
	    <c:set var='imgDesc' value='${result.imgDescCn}'/>
	    <c:set var='prgCl' value='${result.prgCl}'/>
		<%
			String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
			content = removeTag(content);
			if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

			int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
			
			
		%>
		<li style="border:1px solid blue;">
			<span style="border:1px solid gray;margin-right:10px;">
				<!--진행정보-->
				<c:choose>
					<c:when test="${result.progrsSttus == 'W'}">대기</c:when>
					<c:when test="${result.progrsSttus == 'P'}">진행</c:when>
					<c:when test="${result.progrsSttus == 'FP'}">진행</c:when>
					<c:when test="${result.progrsSttus == 'F'}">마감</c:when>
				</c:choose>
				<!--//진행정보-->
			</span>
			<a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}">
				<span style="font-size:15px;font-weight:bold;">
					<!--제목-->${result.prgNm}
				</span>
			</a>
			<div>
				<!--신청방식-->${result.reqstMthdNm}
			</div>
	    </li>
	    
	    <!-- 
		 -->
		</c:forEach>
		<c:if test="${fn:length(insightList) == 0}" >
			<li>데이터가 없습니다.</li>
		</c:if>
	</ul>

	<!-- 본문 컨텐츠 끝-->
</div>