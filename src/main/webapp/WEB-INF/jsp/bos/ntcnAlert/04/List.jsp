<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />




<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/bos/js/jslb_ajax.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<title>포탈메인화면관리</title>
</head>
<body>
	<div id="content">
		<div class="hgroup">
			<h3 class="tit_03">
				하단배너관리
			</h3>
		</div>

		<!-- 게시판 게시물검색 start -->
	<form action="/bos/ntcnAlert/List.do?type=04" method="post">
		<div class="sh">
			<fieldset>
				<select name="publish" id="publish">
					<option value=''>보임/숨김선택</option>
					<option value='Y' <c:if test="${param.publish == 'Y'}">selected="selected"</c:if>>보임</option>
					<option value='N' <c:if test="${param.publish == 'N'}">selected="selected"</c:if>>숨김</option>
				</select>
				<legend>게시판 게시물검색</legend>
				<label for="input1"> 배너명
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchKeyword" value='${Bean.searchKeyword}' />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
		    </fieldset>
		</div>
	</form>

</fieldset>

	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>알림 관리 목록</caption>
			<colgroup>
				<col width="6%" />
				<col width="*" />
				<col width="22%" />
				<col width="15%" />
				<col width="13%" />
				<col width="6%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">알림명</th>
					<th scope="col">알림 URL</th>
					<th scope="col">알림 이미지</th>
					<th scope="col">게시기간</th>
					<th scope="col">표시</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${resultList}" var="item" varStatus="status">
					<tr>
						<!-- 번호 -->
						<td>
							${(resultListSize + 1) - ((Bean.pageIndex - 1) * Bean.pageSize + status.count)}
						</td>

						<!-- 알림명-->
						<td class="tal">
							<c:url value='/bos/ntcnAlert/forUpdate/${item.alert_cd}.do' var="read_url">
								<c:param name="type" value="04"/>
							</c:url>
							<a href="${read_url}">${item.alert_nm}</a>
						</td>

						<!-- 알림 URL -->
						<td class="tal" style="word-break:break-all; ">
							<a href="${item.alert_url}" target="_blank" title="새창열림"><util:head value="${item.alert_url}" length="100" /></a>
						</td>

						<!-- 알림 이미지 -->
						<td>
							<img src="/files/ntcnAlert/${item.img_nm}" style="border: 0px;" width="126" height="73"/>
						</td>
						<!-- 게시기간 -->
						<td>
							${item.pub_sdate}<br/>
		    			~
							${item.pub_edate}
						</td>

						<!-- 표시 여부 -->
						<td>
							<c:choose>
								<c:when test="${item.publish == 'Y' && item.status == '2'}">보임</c:when>
								<c:otherwise>숨김</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="6">데이터가없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
<!-- board list end //-->

	<div class="btn_set">
		<a class="btn btn-primary" href="/bos/ntcnAlert/forInsert.do?type=${param.type}&category=${param.category}"><span>등록</span></a>
	</div>

		<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">
			<div class="paging_con">
				${pagingInfoString}
			</div>
		</div><!-- paging end //-->
		</c:if>
</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>