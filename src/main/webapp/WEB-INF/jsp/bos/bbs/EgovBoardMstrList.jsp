<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_brdMstr('1');
		}
	}

	function fn_egov_insert_addBrdMstr(){
		document.frm.action = "<c:url value='/bos/bbs/addBBSMaster.do?menuNo=${param.menuNo}'/>";
		document.frm.submit();
	}

	function fn_egov_select_brdMstr(pageNo){
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/bos/bbs/SelectBBSMasterInfs.do?menuNo=${param.menuNo}'/>";
		document.frm.submit();
	}

	function fn_egov_inqire_brdMstr(bbsId){
		document.frm.bbsId.value = bbsId;
		document.frm.action = "/bos/bbs/SelectBBSMasterInf/" + bbsId + ".do?menuNo=${param.menuNo}";
		document.frm.submit();
	}
</script>
	<form name="frm" method="post">
		<input type="hidden" name="menuNo" value="${param.menuNo}">
		<input type="hidden" name="bbsId">
		<input type="hidden" name="trgetId">
		<input name="pageIndex" type="hidden" value="${searchVO.pageIndex}"/>
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
		   		<select id="bbsAttrbCode" name="bbsAttrbCode" class="select">
    	  		<option value='' label="--속성선택" />
				<c:forEach var="attrb" items="${attrbList}" varStatus="status">
		      		<option value="${attrb.pageCode}" <c:if test="${attrb.pageCode==param.bbsAttrbCode}">selected</c:if> >${attrb.pageName}(${attrb.pageCode})</option>
		      	</c:forEach>
			   </select>
				<label for="searchCnd" class="blind">구분</label>
		   		<select id="searchCnd" name="searchCnd" class="select">
				   <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >게시판명</option>
				   <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >게시판유형</option>
			   </select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchWrd" value='${searchVO.searchWrd}' onkeypress="press(event);" />
				</label>
				<label for="input2">
					<a href="javascript:fn_egov_select_brdMstr('1')" class="btn btn-seach">검색</a>
				</label>
			</fieldset>
		</div>
	</form>
<!-- 게시판 게시물검색 end -->

		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="*" />
				<col width="12%" />
				<col width="20%" />
				<col width="10%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">게시판명</th>
					<th scope="col">게시판유형</th>
					<th scope="col">게시판속성</th>
					<th scope="col">생성일</th>
					<th scope="col" class="last">사용여부</th>
				</tr>
			</thead>
			<tbody>
		 <c:forEach var="result" items="${resultList}" varStatus="status">
			  <tr>
			    <td>${(resultCnt) - (searchVO.pageSize * (searchVO.pageIndex-1))}</td>
			    <td class="tal">
			    	<a href="javascript:fn_egov_inqire_brdMstr('<c:out value="${result.bbsId}"/>')">
			    		${result.bbsNm}(${result.bbsId})
			    	</a>
			    </td>
			    <td><c:out value="${result.bbsTyCodeNm}"/></td>
			    <td><a href="/bos/pg/readPage.do?pageCode=${result.bbsAttrbCode}&menuNo=${param.menuNo}" onclick="window.open(this.href, 'readPage', 'resizable=1,scrollbars=1, width=896,height=860'); return false;"><c:out value="${result.bbsAttrbCodeNm}"/>(${result.bbsAttrbCode})</a></td>
			    <td><c:out value="${result.frstRegisterPnttm}"/></td>
			    <td>
			    	<c:if test="${result.useAt == 'N'}"><spring:message code="button.notUsed" /></c:if>
			    	<c:if test="${result.useAt == 'Y'}"><spring:message code="button.use" /></c:if>
			    </td>
			  </tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			 </c:forEach>
			 <c:if test="${fn:length(resultList) == 0}">
			  <tr>
			    <td colspan="6"><spring:message code="common.nodata.msg" /></td>
			  </tr>
			 </c:if>
	 		</tbody>
		</table>
	</div>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:fn_egov_insert_addBrdMstr();"><span>등록</span></a>
	</div>

	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->

