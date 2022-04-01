<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>

<script type="text/javascript">
	$(function() {
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$("#sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
		$("#edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	});
</script>

	<form name="frm" action ="/bos/popupMng/list.do" method="post">
		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>

				<select id="siteId" name="siteId" class="input_select">
				    	<option value="">사이트선택</option>
					 <c:forEach var="site" items="${siteList}" varStatus="status">
					 	<c:set var="data"><util:fz source="${site.siteId}" resultLen="2" isFront="true" /></c:set>
					    <option value="${data}" <c:if test="${fn:indexOf(data,param.siteId) ne -1 and not empty param.siteId}">selected="selected"</c:if> >${site.siteDesc}</option>
					 </c:forEach>
				</select>

				<input type="text" id="sdate" name="sdate" value="${param.sdate}" size="10" /> ~ <input type="text" id="edate" name="edate" value="${param.edate}" size="10" />

				<label for="stributary" class="blind">게시물 분류 선택</label>
					<select id="stributary" name="searchType" title="검색조건">
				   <option value="1" <c:if test="${param.searchType == '1'}">selected="selected"</c:if> >제목</option>
				   <option value="2" <c:if test="${param.searchType == '2'}">selected="selected"</c:if> >내용</option>
					</select>
				<label for="input1">
					<input id="input1" type="text" class="searchinput" title="검색어입력" style="width:130px" name="searchTxt" value='${param.searchTxt}' />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn" />
				</label>
		</fieldset>
		</div>
		<!-- 게시판 게시물검색 end -->
	</form>

		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="*" />
				<col width="15%" />
				<col width="15%" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">기간</th>
					<th scope="col">등록사이트</th>
					<th scope="col">이미지</th>
					<th scope="col" class="last">사용여부</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:set var="files" value="${fileMap[result.atchFileId]}" />
				<c:url var="url" value="/bos/popupMng/forUpdate.do?pno=${result.pno}&menuNo=${param.menuNo}"/>
				<tr>
			    	<td>
					${result.pno}
			    	</td>
					<td>
						<a href="${url}">${result.title}</a>
					</td>
			    	<td>
						${result.sdate}~<br/>${result.edate}
					</td>
					<td>
					<c:forEach var="site" items="${siteList}" varStatus="status">
						<c:set var="_siteId"><util:fz source="${site.siteId}" resultLen="2" isFront="true" /></c:set>
						<c:if test="${fn:indexOf(result.siteId, _siteId) ne -1}">${site.siteDesc}<br/></c:if>
					</c:forEach>
					</td>
					<td>
					<img src="/bos/cmm/fms/FileDown.do?atchFileId=${result.atchFileId}&amp;fileSn=${files[0].fileSn}" style="border: 0px;" width="40" height="55"/>
					</td>
					<td>
					<c:choose>
					<c:when test="${result.useflag eq 'Y'}">
					<b><font color="blue">사용</font></b>
					</c:when>
					<c:otherwise>
					<b><font color="red">미사용</font></b>
					</c:otherwise>
					</c:choose>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="8">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

	<div class="btn_set">
		<a class="btn btn-primary" href="/bos/popupMng/forInsert.do?menuNo=${param.menuNo}"><span>등록</span></a>
	</div>

	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>
