<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<title>설문</title>
</head>
<body>

	<div id="content">
		<div class="hgroup">
			<h3>이벤트</h3>
		</div>

		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>이벤트 목록</caption>
			<colgroup>
				<col width="5%" />
				<col width="10%" />
				<col width="*" />
				<col width="10%" />
				<col width="22%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">썸네일이미지</th>
					<th scope="col">제목</th>
					<th scope="col">진행상태</th>
					<th scope="col">기간</th>
					<th scope="col">조회</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(resultList) > 0}">
					<c:set var="resultListSize" value="${fn:length(resultList)}" />
					<c:forEach items="${resultList}" var="item" varStatus="status">
						<c:set var="files" value="${fileMap[item.atchFileId]}" />
						<c:forEach items="${files}" var="file" varStatus="_status">
							<c:if test="${file.fileFieldName eq 'thumbImage'}">
								<c:set var="thumbImage" value="${file}" />
							</c:if>
						</c:forEach>
						<tr>
							<td>
								${resultListSize - status.count + 1}
							</td>
							<td>
								<img src='/cmm/fms/getImage.do?atchFileId=${thumbImage.atchFileId}&fileSn=${thumbImage.fileSn}'  width="140" height="120" alt="${thumbImage.orignlFileNm}" />
							</td>
							<td class="tal">
								<c:url var="actionUrl" value="/bos/poll/forUpdate.do">
									<c:param name="masterCd" value="${item.masterCd}"/>
								</c:url>
								<a href="${actionUrl}">${item.title}</a><label></label>
							</td>
							<td>
				  <c:choose>
					<c:when test="${item.pollStatus eq 1}">시작전</c:when>
					<c:when test="${item.pollStatus eq 2}">진행중</c:when>
					<c:when test="${item.pollStatus eq 3}">종료</c:when>
				  </c:choose>
							</td>
							<td>
								<fmt:formatDate value="${item.startDt}" pattern="yyyy-MM-dd"/>
								 ~ <fmt:formatDate value="${item.endDt}" pattern="yyyy-MM-dd"/>
							</td>

							<td>
								${item.inqireCo}
							</td>
						</tr>
					</c:forEach>
				</c:if>

				<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="8">검색된 리스트가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

	<div class="btn_set">
		<a class="btn btn-primary" href="/bos/poll/forInsert.do"><span>등록</span></a>
	</div>

</form>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>
