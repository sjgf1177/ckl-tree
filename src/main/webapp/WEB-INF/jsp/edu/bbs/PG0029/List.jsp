<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="kocca" uri="http://edu.kocca.kr/fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ page import="java.util.*" %>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper"%>
<%@ page import="kr.co.unp.member.vo.UsersVO"%>
<%
UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
%>

<c:if test='${not empty user.userId && !"".equals(user.userId) && !"anonymousUser".equals(user.userId) && !"anonymousUser".equals(user.userNm) }'>
   	<c:url value="/edu/html/selfview/ajaxLogin.html" var="url">
	  <c:param name="id" value="${user.userId}" />
	  <c:param name="name" value="${user.userNm}" />
	</c:url>
	<iframe src="${url}" style="display: none;"></iframe>
</c:if>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>
<div class="col-12 sub_board_header">
	<ul class="mb20 list_style_2 color_black">
		<li>
			면접 유형을 확인 하시고 면접실 "입장" 버튼을 클릭해 주세요.
			<!-- <p class="sub_text">설명</p>  -->
		</li>
	</ul>
	<div class="text_border_box corner">
		<p class="alert_desc small_text">
			크롬 웹브라우저에서 모의면접을 이용하는 경우 플래시(Adobe Flash)를 실행하도록 허용해 주셔야 합니다.<br/>
			 1.크롬 주소창에 chrome://settings/content/flash 입력<br/>
			 2.상단에 있는 "사이트에서 Flash를 실행하도록 허용"을 클릭<br/>
			   (파란색 버튼이 오른쪽으로 향하고 있으면 됨)<br/>
			 이렇게 하면, 크롬에서 플래시 차단문제가 해결됩니다. <span class="point0">감사합니다.</span>
		</p>
	</div>
</div>

<!-- bdList -->
<div class="col-12 show-table sub_board_header">
	<div class="col-12 show-tablecell fn vm board_title">
		<h4>총 <span class="board_count"><c:out value="${resultCnt }" />개</span>의 면접유형 등록</h4>
	</div>
	<!-- 
	<form id="frm" name="frm" action ="/edu/bbs/${paramVO.bbsId}/list.do?menuNo=${paramVO.menuNo}" method="post" class="form-inline">
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" /> <input type="hidden" name="pageQueryString" value="<c:out value="${pageQueryString }" />" /> <input type="hidden" name="menuNo" value="<c:out value="${paramVO.menuNo }" />" />
		<fieldset>
		<legend></legend>
			<div class="col-8 show-tablecell fn vm tr board_sorting_con">
				<span class="tl select_box">
					<select class="select_style_0" name="option1" id="option1" title="질문분류를 선택해 주세요." onchange="">
						<option value="">전체</option>
						<option value="01" <c:if test="${paramVO.option1 eq '01'}">selected="selected"</c:if>>현장교육</option>
						<option value="02" <c:if test="${paramVO.option1 eq '02'}">selected="selected"</c:if>>온라인교육</option>
						<option value="03" <c:if test="${paramVO.option1 eq '03'}">selected="selected"</c:if>>창의인재동반</option>
						<option value="04" <c:if test="${paramVO.option1 eq '04'}">selected="selected"</c:if>>취업정보</option>
					</select>
				</span>
				<span class="tl select_box">
					<select class="select_style_0" name="searchCnd" id="searchCnd" title="구분을 선택해 주세요.">
						<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >제목</option>
						<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >내용</option>
						<option value="3" <c:if test="${paramVO.searchCnd == '3'}">selected="selected"</c:if> >제목+내용</option>
					</select>
				</span>
				<span class="tl input_search_con">
					<input type="text" class="board_search" name="searchWrd" id="searchWrd" title="검색어를 입력해 주세요." value="${paramVO.searchWrd}" />
					<input type="submit" class="search_summit" value="" class="btn btn-primary" />
				</span>
			<c:if test="${not empty paramVO.searchWrd }">
				<a href="/edu/bbs/<c:out value="${paramVO.bbsId}" />/list.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm ml10">전체목록</a>
			</c:if>
			</div>
		</fieldset>
	</form>
	 -->
</div>

<div class="col-12 sub_board_body">
	<table class="board_type_0">
		<caption>${masterVO.bbsNm} 목록</caption>
		<colgroup>
			<col width="auto" class="count_column">
			<col width="auto" class="name_column"> 
			<col width="auto">
			<col width="auto" class="condition_column">
			<col width="auto" class="write_date_column">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>분야</th>
				<th>면접유형</th>
				<th>문항수</th>
				<th>면접실 입장</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:url var="url" value="/edu/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&amp;${pageQueryString}" />
		<tr>
			<td><%--번호--%>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
			<td class="text_center"><!--분야-->
				<c:if test="${not empty COM113CodeList }">
					<c:forEach var="code" items="${COM113CodeList}" varStatus="status">
						<c:if test="${code.code eq result.option1}">${code.codeNm}</c:if>
					</c:forEach>
				</c:if>
			</td>
			<td class="text_left" style="color:#313131">
				<c:url var="url" value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&amp;${pageQueryString}" />
				<a href="<c:out value='${url}' escapeXml='false'/>">
					<!--면접유형-->${result.nttSj}
				</a>
			</td>
			<td style="color:#313131"><!--문항수-->${result.option2}</td>
			<td><!--면접실 입장-->
				<a href="javascript:openInterviewPopup('${result.option3}');" style="padding:5px 10px;background-color:#40abd4;color:#fff;border-radius:3px;">입장</a>
			</td>
		</tr>
		<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="5">데이터가 없습니다.</td></tr></c:if>
		</tbody>
	</table>
</div>

<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
</c:if>

<!-- 
<div class="board_util_btn_con">
	<a href="/edu/bbs/${paramVO.bbsId}/forInsert.do?${pageQueryString}" class="btn_style_0 full add">
		글쓰기
	</a>
</div>
 -->
<script type="text/javascript">
	$(document).ready(function(){
		$('#option1').change(changeOption);
	});
	
	function openInterviewPopup(url){
		window.open(url, "모의면접", "width=1180, height=760, menubar=no, status=no, toolbar=no")
	}


	function changeOption(){
		$('#frm').attr({
			target : '_self'
		}).submit();
	}
</script>
