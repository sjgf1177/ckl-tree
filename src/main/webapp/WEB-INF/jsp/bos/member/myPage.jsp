<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.BoardVO" var="BoardVO"/>

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
	<script type="text/javascript" src="/bos/js/jquery.cookie.js"></script>
<script type="text/javascript">
$(function(){
	var popCnt = $.cookie('popCnt');
	if( !popCnt ){
		window.open("/portal/popup/pop_mng.html", 'popwin', 'left=20,top=20,width=616,height=700');
	}
});
</script>
<title>마이페이지</title>
</head>
<body>
	<div id="content">
		<div class="hgroup">
			<h3>마이페이지</h3>
		</div>
		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>


				<col width="*" />



				<col width="30%" />



				<col width="30%" />

			</colgroup>
			<thead>
				<tr>
					<th scope="col">일반민원 답변처리</th>


					<th scope="col">진행중</th>



					<th scope="col">미처리</th>


				</tr>
			</thead>
			<tbody>
<%-- 				<tr>
					<td class="output">
						<a href="/bos/main/main.do?menuNo=100026" target="_top">자유게시판</a>
					</td>


					<td class="output">
						${freeBoardProcessingCnt}
					</td>



					<td class="output">${freeBoardNonProcessingCnt}</td>


				</tr> --%>
				<tr>
					<td class="output">
						<a href="/bos/main/main.do?menuNo=100100" target="_top">청장과의대화</a>
					</td>


					<td class="output">
						${gvrnTalkProcessingCnt}
					</td>



					<td class="output">${gvrnTalkNonProcessingCnt}</td>


				</tr>
<%-- 				<tr>
					<td class="output">
						<a href="/bos/main/main.do?menuNo=100181" target="_top">국관과의대화</a>
					</td>


					<td class="output">
						${communictionProcessingCnt}
					</td>



					<td class="output">${communictionNonProcessingCnt}</td>


				</tr>  --%>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->
</div>











<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>
