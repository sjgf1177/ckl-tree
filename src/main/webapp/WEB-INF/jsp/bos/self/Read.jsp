
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.BoardVO" var="BoardVO"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />




<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>

<script type="text/javascript">

	function del(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/delete.do";
		form.submit();
	}

	function restore(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/restore.do";
		form.submit();
	}

	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/delPermanently.do";
		form.submit();
	}

	function doResize(){
		var min_Height = 0;

		if (min_Height < contentFrame.document.body.scrollHeight+10)
		min_Height = contentFrame.document.body.scrollHeight+10;
		document.all.contentFrame.height = min_Height;
	}

</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
</head>
<body>

<div id="content">

		<div class="hgroup">
			<h3>${masterVO.bbsNm}</h3>
			<a class="btn btn-success" href="/bos/forprint.jsp" id="print" title="새창" onclick="window.open(this.href, 'printPage', 'width=800,height=550,scrollbars,toolbar,status');return false;" alt="인쇄하기 (자바스크립트 미지원시 브라우저은 인쇄기능을 이용하세요)"><i class="fa fa-hover fa-print"></i> <span>인쇄하기</span></a>
		</div>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />

	<div class="bdView">
		<table>
			<caption>게시판 쓰기</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">번호</th>
					<td>
						${result.nttId}
					</td>
				</tr>
				<tr>
					<th scope="row">이름</th>
					<td>
						${result.ntcrNm}
					</td>
				</tr>
				<tr>
					<th scope="row">거주지</th>
					<td>
						<c:if test="${result.ntcrAddr1 eq 'A'}">서울시 서초구 </c:if>
						<c:if test="${result.ntcrAddr1 eq 'B'}">서울시</c:if>
						<c:if test="${result.ntcrAddr1 eq 'C'}">타지역</c:if>
						 ${result.ntcrAddr2}
					</td>
				</tr>
				<tr>
					<th scope="row">연락처</th>
					<td>
						${result.ntcrTel}
					</td>
				</tr>

			<c:if test="${result.gubun ne 'D'}">
				<tr>
					<th scope="row">성별</th>
					<td>
						<c:choose>
						<c:when test="${result.sex eq 'M'}">남자</c:when>
						<c:otherwise>여자</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row">나이</th>
					<td>
						${result.age} 세
					</td>
				</tr>
				<tr>
					<th scope="row">지역</th>
					<td>
						<c:choose>
						<c:when test="${result.area eq 'Y'}">서울</c:when>
						<c:otherwise>서울외</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row">결혼여부</th>
					<td>
						<c:choose>
						<c:when test="${result.marsta eq 'Y'}">기혼</c:when>
						<c:otherwise>미혼</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:if>

			<c:if test="${result.gubun eq 'D'}">
				<tr>
					<th scope="row">지역</th>
					<td>
						<c:choose>
						<c:when test="${result.area eq 'Y'}">서울</c:when>
						<c:otherwise>서울외</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row">성별</th>
					<td>
						<c:choose>
						<c:when test="${result.sex eq 'M'}">남자</c:when>
						<c:otherwise>여자</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row">나이</th>
					<td>
						${result.age} 세
					</td>
				</tr>
				<tr>
					<th scope="row">학력</th>
					<td>
						${result.study}
					</td>
				</tr>
				<tr>
					<th scope="row">결혼여부</th>
					<td>
						<c:choose>
						<c:when test="${result.marsta eq 'Y'}">기혼</c:when>
						<c:otherwise>미혼</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row">함께사는가족</th>
					<td>
						${result.family}
					</td>
				</tr>
				<tr>
					<th scope="row">직업</th>
					<td>
						${result.job}
					</td>
				</tr>
				<tr>
					<th scope="row">알코올 치료 유무</th>
					<td>
						${result.alcohol}
					</td>
				</tr>
			</c:if>

				<tr>
					<th scope="row">테스트결과</th>
					<td>
						${sum} 점
					</td>
				</tr>

				<tr>
					<th scope="row">등록일</th>
					<td><fmt:formatDate value="${result.regDate}" pattern="yyyy-MM-dd kk:mm:ss"/></td>
				</tr>

			</tbody>
		</table>
	</div>
</form>


<%-- 	<c:if test="${not empty result}">
	<div class="fl">
		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
	</div>
	</c:if> --%>
	<div class="fl">
		<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
		<a class="btn btn-default" href="/bos/bbs/view/${boardVO.bbsId}/${prevNextMap['PREV'].prevNttId}.do?${pageQueryString}"><span>이전글</span></a>
	    </c:if>
		<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
		<a class="btn btn-default" href="/bos/bbs/view/${boardVO.bbsId}/${prevNextMap['NEXT'].nextNttId}.do?${pageQueryString}"><span>다음글</span></a>
	    </c:if>
	</div>
	<div class="fr" >
	<c:if test="${result.delCode eq '0' }" >
		<a class="btn btn-primary" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>원글삭제</span></a>
	</c:if>
	<c:if test="${result.delCode ne '0' }" >
		<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>원글복구</span></a>
	</c:if>
		<c:url var="url" value="/bos/selfDiagnosis/list.do?programId=selfDiagnosis&gubun=${result.gubun}" />
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>
</div>
</body>
</html>

<c:catch var ="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>