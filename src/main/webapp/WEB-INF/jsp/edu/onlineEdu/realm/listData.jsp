<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>


<!-- step 영역 s -->
<jsp:include page="/WEB-INF/jsp/edu/onlineEdu/realm/eduStep.jsp" flush="true" />
<!-- step 영역 e -->

<!-- bdList -->
<div class="col-12">
	
	<form id="frm" name="frm" action="/edu/onlineEdu/${paramVO.programId}/listData.do?menuNo=<c:out value='${paramVO.menuNo }'/>" method="post" class="form-inline">
	
		<input type="hidden" name="pageQueryString" value='<c:out value="${pageQueryString }" escapeXml="false"/>' >

		<input type="hidden" name="pGubun1" id="pGubun1" value="${param.pGubun1 }" />
		<input type="hidden" name="pGubun2" id="pGubun2" value="${param.pGubun2 }" />
		<input type="hidden" name="pGubun3" id="pGubun3" value="${param.pGubun3 }" />
		
		<input type="hidden" name="p_subj" id="p_subj" value="${param.p_subj }" />
		<input type="hidden" name="p_subjnm" id="p_subjnm" value="${param.p_subjnm }" />
		<input type="hidden" name="p_isonoff" id="p_isonoff" value="${param.p_isonoff }" />
		<input type="hidden" name="p_scupperclass" id="p_scupperclass" value="${param.p_scupperclass }" />
		<input type="hidden" name="p_uclassnm" id="p_uclassnm" value="${param.p_uclassnm }" />
		<input type="hidden" name="p_year" id="p_year" value="${param.p_year }" />
		<input type="hidden" name="p_subjseq" id="p_subjseq" value="${param.p_subjseq }" />
		
		<input type="hidden" name="p_searchtext" id="p_searchtext" value="${param.p_searchtext }" />
		<input type="hidden" name="p_orders" id="p_orders" value="<c:out value="${param.p_orders }"/>" />
		<input type="hidden" name="p_ordersnm" id="p_ordersnm" value="<c:out value="${param.p_ordersnm }"/>" />
		
		<input type="hidden" name="p_tabselect" id="p_tabselect" value="<c:out value="${param.p_tabselect }"/>" />
		<input type="hidden" name="pTabseq" id="pTabseq" value="<c:out value="${param.pTabseq }"/>" />
		<input type="hidden" name="pSeq" id="pSeq" value="" />
		
		<!-- paging s -->
		<input type="hidden" name="gubun" id="gubun" value="<c:out value='${param.gubun }' />" />
		<input type="hidden" name="option1" id="option1" value="<c:out value='${param.option1 }' />" />
		<input type="hidden" name="option5" id="option5" value="<c:out value='${param.option5 }' />" />
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value='${param.pageIndex }' />" />
		<!-- paging e -->
		
	
		<!-- 학습하기 파라미터 s -->
		<input type="hidden" name="s_year" id="s_year" value="${param.s_year }" />
		<input type="hidden" name="s_cpsubj" id="s_cpsubj" value="${param.s_cpsubj }" />
		<input type="hidden" name="s_cpsubjseq" id="s_cpsubjseq" value="${param.s_cpsubjseq }" />
		<input type="hidden" name="s_company" id="s_company" value="${param.s_company }" />
		<input type="hidden" name="s_contenttype" id="s_contenttype" value="${param.s_contenttype }" />
		<input type="hidden" name="s_subj" id="s_subj" value="${param.s_subj }" />
		<input type="hidden" name="s_subjseq" id="s_subjseq" value="${param.s_subjseq }" />
		<input type="hidden" name="s_lesson" id="s_lesson" value="${param.s_lesson }" />
		<!-- 학습하기 파라미터 e -->
		
	
		<fieldset>
			<legend></legend>
			<div class="col-12 mt30 show-table sub_board_header control_board_header">
			<div class="col-4 show-tablecell fn vm board_title">
				<h4>
					총 <span class="board_count"><c:out value="${resultCnt }" /></span>개의 게시글 등록<%--  | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${paginationInfo.totalPageCount }" /></strong> Page --%>
				</h4>
			</div>
			<div class="col-8 show-tablecell fn vm tr board_sorting_con">
				<span class="tl select_box">
					<select class="select_style_0" name="pDataSearch" id="pDataSearch" title="구분을 선택해 주세요.">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="name">작성자</option>
					</select>
				</span>
				<span class="tl input_search_con">
					<input class="board_search" type="text" name="pDataSearchtext" id="pDataSearchtext" title="검색어를 입력해 주세요." value="${param.pDataSearchtext }" />
					<a href="javascript:void(0);" onclick="fnCmdSearchList(); return false;" class="search_summit">검색</a>
				</span>
			</div>
			</div>
		</fieldset>
		
		
	</form>
</div>


<div class="col-12 sub_board_body">
	<table class="board_type_0 small">
		<caption>자료실 목록</caption>
		<colgroup>
		<col style="width:8%;" />
		<col  />
		<col style="width:10%;" />
		<col style="width:10%;" />
		<col style="width:10%;" />
		<col style="width:8%;" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">첨부파일</th>
				<th scope="col">조회수</th>
			</tr>
		</thead>
		<tbody>
		
			<c:forEach items="${resultList }" var="item" varStatus="status">
				<tr>
					<td>${(resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}</td>
					<td class="tal"><a href="javascript:void(0);" onclick="fnCmdDataViewPage('${item.tabseq}', '${item.seq }'); return false;"><c:out value="${item.title }" /></a></td>
					<td><c:out value="${item.name }" /></td>
					<td>
						<fmt:parseDate var="dateString" value="${item.indate}" pattern="yyyyMMddHHmmss" />
					 	<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" />
					</td>
					<td>
						<div class="table_info_header">
							<span class="table_upload_file_icon"></span>
						</div>
					</td>
					<td><c:out value="${item.cnt }" /></td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			
			<c:if test="${empty resultList }">
				<tr><td colspan="6">해당 목록이 없습니다</td></tr>
			</c:if>
			
		</tbody>
	</table>
</div>

<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">${pageNav}</div>
	<!-- paging end //-->
</c:if>


<script type="text/javascript">
//<![CDATA[

	$(document).ready(function(){
		
		//자료 조회 enter key
		$("#pSearchtext").keydown(function(e) {
		    if (e.keyCode == 13) fnCmdSearchList();
		    
		});
	});
	
	
	//자료 조회
	function fnCmdSearchList(tabseq, seq){
		
		$("#pageIndex").val("1");
		$("#frm").attr({
					action:"/edu/onlineEdu/realm/listData.do?menuNo=<c:out value='${paramVO.menuNo }'/>",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}
	
	
	//상세화면
	function fnCmdDataViewPage(tabseq, seq){
		
		$("#pTabseq").val(tabseq);
		$("#pSeq").val(seq);
		$("#frm").attr({
					action:"/edu/onlineEdu/realm/viewData.do?menuNo=<c:out value='${paramVO.menuNo }'/>",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}
	
//]]>
</script>

