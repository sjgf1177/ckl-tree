
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.BoardVO" var="BoardVO"/>


<jsp:include page="/WEB-INF/jsp/bos/bbs/com/bbsHead.jsp" flush="true" />

<title>${masterVO.bbsNm}</title>
</head>
<body>
<form id="frm" name="frm" action ="/bos/bbs/list/${boardVO.bbsId}.do" method="post">
	<div id="content">
		<div class="hgroup">
			<h3>${masterVO.bbsNm}</h3>
			<a class="btn btn-success" href="/bos/forprint.jsp" id="print" title="새창" onclick="window.open(this.href, 'printPage', 'width=800,height=550,scrollbars,toolbar,status');return false;" alt="인쇄하기 (자바스크립트 미지원시 브라우저은 인쇄기능을 이용하세요)"><i class="fa fa-hover fa-print"></i> <span>인쇄하기</span></a>
		</div>

		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<input type="text" id="sdate" name="sdate" value="${param.sdate}" size="10" /> ~
			    <input type="text" id="edate" name="edate" value="${param.edate}" size="10" />

			    <c:choose>
					<c:when test="${boardVO.bbsId eq 'B0000127' or boardVO.bbsId eq 'B0000130'
								 or boardVO.bbsId eq 'B0000134' or boardVO.bbsId eq 'B0000136'
								 or boardVO.bbsId eq 'B0000137' or boardVO.bbsId eq 'B0000139'
								 or boardVO.bbsId eq 'B0000140' or boardVO.bbsId eq 'B0000144'}">
						 <label for="stributary" class="blind">검색조건</label>
						 <select id="deptId" name="deptId" title="검색조건">
						 	<option selected value=''>--담당부서선택</option>
						 	<c:forEach var="dept" items="${deptList}" varStatus="status">
						 		<option value="${dept.deptId}" <c:if test="${dept.deptId == boardVO.deptId}">selected="selected"</c:if>>${dept.deptName}</option>
						 	</c:forEach>
						 </select>
					</c:when>
					<c:when test="${boardVO.bbsId eq 'B0000132'}">
						<label for="stributary" class="blind">검색조건</label>
						 <select id="deptId" name="deptId" title="검색조건">
						 	<option selected value=''>--담당부서선택</option>
						 	<c:forEach var="dept" items="${deptList}" varStatus="status">
						 		<option value="${dept.deptId}" <c:if test="${dept.deptId == boardVO.deptId}">selected="selected"</c:if>>${dept.deptName}</option>
						 	</c:forEach>
						 </select>
						 <select id="gubun" name="gubun" class="input_select w100" title="분야선택">
						    <option value="">분야선택</option>
						 <c:forEach var="code" items="${COM068CodeList}" varStatus="status">
							<option value="${code.code}" <c:if test="${code.code eq boardVO.gubun }">selected="selected"</c:if>>${code.codeNm}</option>
						 </c:forEach>
						</select>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>

				<select id="stributary" name="searchCnd" title="검색조건">
				   <option value="1" <c:if test="${boardVO.searchCnd == '1'}">selected="selected"</c:if> >제목</option>
				   <option value="4" <c:if test="${boardVO.searchCnd == '4'}">selected="selected"</c:if> >작성자</option>
				   <option value="2" <c:if test="${boardVO.searchCnd == '2'}">selected="selected"</c:if> >내용</option>
				   <option value="3" <c:if test="${boardVO.searchCnd == '3'}">selected="selected"</c:if> >제목+내용</option>
				</select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchWrd" value="${boardVO.searchWrd}" />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
			</fieldset>
		</div>
		<!-- 게시판 게시물검색 end -->

		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>${masterVO.bbsNm} 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="20%" />
				<col width="10%" />
				<col width="12%" />
				<col width="10%" />
				<col width="*" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">파일이름</th>
					<th scope="col">작성자</th>
					<th scope="col">첨부파일</th>
					<th scope="col">등록일</th>
					<th scope="col">URL</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td class="output">${result.nttType eq BoardVO.NOTICE_NTT_TYPE ? '공지' : (resultCnt) - (boardVO.pageSize * (boardVO.pageIndex-1))}</td>
					<td class="tit">
						<c:url var="url" value="/bos/bbs/view/${boardVO.bbsId}/${result.nttId}?${pageQueryString}" />
						<a href="${url}">
							${result.nttSj}
						</a>
					</td>
					<td class="output">${result.ntcrNm}</td>
			    	<td class="output">
			    		<c:if test="${not empty result.atchFileId and result.fileCount > 0}">
			    		<a href="/bos/cmm/fms/FileDown.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}">
			    			<img src="/bos/images/common/disk.gif" alt="${result.orignlFileNm}"/>
			    		</a>
			    		</c:if>
			    	</td>
					<td class="output">${result.frstRegisterPnttm}</td>
					<td class="output"> <input type="text" id="copyUrl"  name="copyUrl" value="/bos/cmm/fms/FileDown.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" class="input_txt" />
					</td>

				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="7">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>

	<div class="btn_set">
<c:if test="${boardVO.delCode eq '0'}">
   <sec:authorize ifAnyGranted="ROLE_SUPER">
		<a class="btn btn-primary" href="/bos/bbs/list/${boardVO.bbsId}.do?delCode=1"><span>삭제글보기</span></a>
   </sec:authorize>
		<a  class="button btn_write" href="/bos/bbs/forInsert/${boardVO.bbsId}.do?${pageQueryString}"><span>글쓰기</span></a>
</c:if>
<c:if test="${boardVO.delCode eq '1'}">
		<a class="btn btn-default" href="/bos/bbs/list/${boardVO.bbsId}.do?delCode=0"><span>돌아가기</span></a>
</c:if>
	</div>

	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>
</div>

</form>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>
