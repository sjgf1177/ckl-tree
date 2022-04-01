
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />
<%--
임시 주석처리 Start
<script type="text/javascript" src="/js/jquery.carouFredSel-6.2.1-packed.js"></script>

<script type="text/javascript">
	//<![CDATA[
	$(function() {

		$("#B0000020List").carouFredSel({
			responsive	: true,
			prev        : ".bdLastLeft",
		    next        : ".bdLastRight",
		    auto : {
				play : false
		    }
		});
	});
	//]]>
</script>

	<div class="bdLastest">
		<div class="bdLitestCtrl">
			<button class="bdLastLeft">
				<span class="sr-only">이전 게시물 보기</span>
			</button>
			<button class="bdLastRight">
				<span class="sr-only">다음 게시물 보기</span>
			</button>
		</div>

		<div class="lastestUl">
			<ul id="B0000020List">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:set var="files" value="${fileMap[result.atchFileId]}" />
				<li>
					<dl>
						<dt>
							<c:set var="file" value="${files }" />
							<c:forEach var="fileList" items="${file }">
								<c:if test="${fileList.fileFieldName eq 'main_image' }">
								 	<c:set var ="fileVO" value="${fileList }" />
								</c:if>
							</c:forEach>

							<div class="imageBg" <c:if test="${not empty fileVO}">style="background: url(/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}) no-repeat;"</c:if>>

								<!-- db Background Image -->
								<img src="/edu/images/sub/bdLastest01.png" alt="<c:out value="${not empty fileVO ? fileVO.orignlFileNm  : ''}" />" />
							</div>
							<c:set var ="fileVO" value="" />
							<util:head length="30" value="${result.nttSj}"/>
						</dt>
						<dd>
							<% pageContext.setAttribute("crlf", "\n");	%>
							<util:noTagStr length="250" value="${result.nttCn}" brTp="true" />
						</dd>
					</dl>
				</li>
				</c:forEach>
			</ul>
		</div>
	</div>
임시 주석처리 End
 --%>
	<c:url value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/list.do?menuNo=${param.menuNo }" var="searchUrl" />
	<!-- bdList -->

	<div class="tar alert formLine1">
		<form action="${searchUrl }" class="form-inline">
		<input type="hidden" name="menuNo" value="${param.menuNo }">
			<fieldset>
				<legend></legend>
				<div class="clearfix">
					<select name="searchCnd" id="searchCnd" title="구분을 선택해 주세요.">
						<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if>>제목</option>
						<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if>>내용</option>
					</select> 
					<input type="text" name="searchWrd" id="searchWrd" title="검색어를 입력해 주세요." value="<c:out value="${paramVO.searchWrd}" />" /> 
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-primary" title="검색"/>
					<c:if test="${not empty paramVO.searchWrd }">
						<a href="/edu/bbs/<c:out value="${paramVO.bbsId}" />/list.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm ml10">전체목록</a>
					</c:if>
				</div>
			</fieldset>
		</form>
	</div>




	<div class="row mt10 mb5">
		<div class="col-md-12">
			총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${paginationInfo.totalPageCount }" /> </strong> Page
		</div>
	</div>
	<div class="bdList">
		<table class="table">
			<caption>${masterVO.bbsNm} 목록</caption>
			<colgroup>
				<col style="width: 8%;" />
				<col />
				<col style="width: 10%;" />
				<col style="width: 8%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성일</th>
					<th scope="col">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${result.nttType=='1' ? '공지' : (resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}" /></td>
						<td class="tal">
						<c:url var="url" value="/edu/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}${pageQueryString}" />
						<a href="<c:out value='${url}' escapeXml='false'/>">
						<c:out value="${result.nttSj}" escapeXml='false'/>
						</a></td>
						<td><c:out value="${result.frstRegisterPnttm}" /></td>
						<td class="brn"><c:out value="${result.inqireCo}" /></td>
					</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="4">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>


	<!-- <div class="btnSet"><a class="btn btn-primary" href="#self"><span>등록</span></a> <a class="btn btn-default" href="#self"><span>비밀번호 초기화</span></a> <a class="btn btn-danger" href="#self"><span>삭제</span></a> <a class="btn btn-success" href="javascript:void(0);"><span>엑셀저장</span></a></div> -->



	<!-- board list end //-->
	<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">${pageNav}</div>
		<!-- paging end //-->
	</c:if>
	<!-- //bdList -->

