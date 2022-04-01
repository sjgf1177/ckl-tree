<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="kocca" uri="http://edu.kocca.kr/fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<!-- bdList -->

<div class="col-12 mb70 sub_board_header">
	<ul class="list_style_2 small_style">
		<li>
			<p class="small_title point0">유실물의 보관 및 처리</p>
			<p class="small_desc">
				콘텐츠문화광장 내에서 습득한 유실물은 1층에 위치한 운영지원실에서 보관합니다.
				습득일자로부터 2개월간은 운영지원실에서 보관하고, 그 이후에는 민법 제253조(유실물의 소유권취득)에 따라 
				유실물법 제1조(습득물의 조치), 유실물법 시행령 제1조(습득물의 제출)에 따라 동대문경찰서로 이관조치합니다.
			</p>
		</li>
		<li>
			<p class="small_title point0">운영안내</p>
		</li>
	</ul>
	<div class="contents_box_con">
		<span class="contents_list">
			<span class="contents_title">
				운영시간
			</span>
			<span class="contents_desc">
				09:00~18:00 평일만 운영
			</span>
			<hr class="contents_seperate_line"/>
		</span>
		<span class="contents_list">
			<span class="contents_title">
				보관장소
			</span>
			<span class="contents_desc">
				콘텐츠문화광장 1층 운영지원실
			</span>
			<hr class="contents_seperate_line"/>
		</span>
		<span class="contents_list">
			<span class="contents_title">
				전화안내
			</span>
			<span class="contents_desc">
				02-6310-0776
			</span>
		</span>
	</div>
</div>

<%-- <div class="col-12 show-table sub_board_header control_board_header">
	<div class="col-4 show-tablecell fn vm board_title">
		<h4>총 <span class="board_count"><c:out value="${resultCnt }" />개</span>의 게시글 등록</h4>
	</div>
	<div class="col-8 show-tablecell fn vm tr board_sorting_con">
		<form id="frm" name="frm" action ="/${paramVO.siteName}/bbs/${paramVO.bbsId}/list.do?menuNo=${paramVO.menuNo}" method="post" class="form-inline">
		<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" /> <input type="hidden" name="pageQueryString" value="<c:out value="${pageQueryString }" />" /> <input type="hidden" name="menuNo" value="<c:out value="${paramVO.menuNo }" />" />
			<fieldset>
			<legend></legend>
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
					<a href="/${paramVO.siteName}/bbs/<c:out value="${paramVO.bbsId}" />/list.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm ml10">전체목록</a>
				</c:if>
			</fieldset>
		</form>
	</div>
</div> --%>

<!-- faq -->
<ul class="col-12 faq_con style_2">
	<c:forEach var="result" items="${resultList}" varStatus="status">
	<li>
		<button class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
			<div class="faq_numbering"><!--넘버링-->${result.nttType=='1' ? ' ' : (resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}</div>
			<h5>
				<!-- 말머리 -->
				<c:if test="${not empty COM127CodeList }">
					<span class="point0">
						<c:forEach var="code" items="${COM127CodeList}" varStatus="status" >
							<c:if test="${code.code eq result.option1 }">
								&nbsp;[ ${code.codeNm} ]&nbsp;
							</c:if>
						</c:forEach>
					</span>
				</c:if>
				<!-- //말머리 -->
				<c:out value="${result.nttSj}" />
			</h5>
			<p>
				<img class="direc_off" src="/edu/images/bm/faq_direc_off.png" alt="faq 화살표 off 이미지">
				<img class="direc_on" src="/edu/images/bm/faq_direc_on.png" alt="faq 화살표 on 이미지">
			</p>
		</button>
		<div class="faq_reply_con">
			<div>
				<div class="answer"> 
				<c:out value="${result.nttCn }" escapeXml="false"/>
				</div>
			</div>
		</div>
	</li>
	</c:forEach>
	<c:if test="${fn:length(resultList) == 0}">
		<div class="faq_reply_con">
			<div class="no_answer">
				<p>
				데이터가 없습니다.
				</p>
			</div>
		</div>
	</c:if>
</ul>
<!-- //faq -->

<%-- 
<div class="col-12 sub_board_body">
	<table class="board_type_0">
		<caption>${masterVO.bbsNm} 목록</caption>
		<colgroup>
			<col width="auto" class="count_column">
			<col width="auto">
			<col width="auto" class="name_column">
			<col width="auto" class="write_date_column">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:url var="url" value="/${paramVO.siteName}/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&amp;${pageQueryString}" />
		<tr class="${result.nttType=='1'?'notice_title':''}">
			<td>${result.nttType=='1' ? ' ' : (resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}</td>
			<td>
				<a href="${url}">
					<c:if test="${result.nttType=='1'}"><span>[공지]</span></c:if>
					${fn:trim(result.nttSj) eq '' or empty result.nttSj ? '제목 없음' : result.nttSj}
				</a>
			</td>
			<td>${kocca:maskingTag(result.ntcrNm)}</td>
			<td><c:out value="${result.frstRegisterPnttm}"/></td>
		</tr>
		<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="4">데이터가 없습니다.</td></tr></c:if>
		</tbody>
	</table>
</div>
 --%>

<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
</c:if>

<%-- <div class="board_util_btn_con">
	<a href="/${paramVO.siteName}/bbs/${paramVO.bbsId}/forInsert.do?${pageQueryString}" class="btn_style_0 full add">
		글쓰기
	</a>
</div> --%>
<script type="text/javascript">
	$(document).ready(function(){
		$('#option1').change(changeOption);
	});

	function changeOption(){
		$('#frm').attr({
			target : '_self'
		}).submit();
	}
</script>
