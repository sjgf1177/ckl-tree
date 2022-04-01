
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<script type="text/javascript">
	function del(){
		var form = $("#board")[0];
		form.action = "/bos/concert/concertUser/delete.do";
		form.submit();
	}

	function restore(){
		var form = $("#board")[0];
		form.action = "/bos/concert/concertUser/restore.do";
		form.submit();
	}
	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/concert/concertUser/delete.do";
		form.submit();
	}
	

</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>


<div id="content">
<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}">

<div class="bdView">

		<table summary="">
			<caption>${result.compNm} (읽기)</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>

				<tr>
					<th scope="row">아이디</th>
					<td>
						${result.userId}
					</td>
				</tr>

				<tr>
					<th scope="row">이름</th>
					<td>
						${result.concertUserNm}
					</td>
				</tr>

				<tr>
					<th scope="row">기업명</th>
					<td>
						${result.compNm}
					</td>
				</tr>

				<tr>
					<th scope="row">이메일</th>
					<td>
						${result.email}
					</td>
				</tr>

				<tr>
					<th scope="row">내용</th>
					<td>
						<div class="outputEditor" id="dbdata">
						<c:choose>
								<c:when test="${result.htmlYn=='Y'}">${result.compCn}</c:when>
								<c:otherwise>
									<% pageContext.setAttribute("crlf", "\n"); %>
									${fn:replace(result.compCn, crlf, "<br/>")}
								</c:otherwise>
							</c:choose>
						</div>
					</td>
				</tr>
				
			<c:if test="${not empty result}">
				<tr>
					<th scope="row">등록일</th>
					<td>${result.regDate}</td>
				</tr>
			</c:if>

			<c:if test="${not empty result}">
				<tr>
					<th scope="row">최종수정일</th>
					<td>${result.uptDate}</td>
				</tr>
			</c:if>


			</tbody>
		</table>
	</div>

</form>

	<c:if test="${result.delcode eq '1'}">
	<div class="fl">
	</div>
	</c:if>



<div class="btnSet">
	<div class="fl">
		<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
		<a class="btn btn-default" href="/bos/concert/concertUser/view.do?nttId=${prevNextMap['PREV'].prevNttId}&${pageQueryString}"><span>이전글</span></a>
	    </c:if>
		<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
		<a class="btn btn-default" href="/bos/concert/concertUser/view.do?nttId=${prevNextMap['NEXT'].nextNttId}&${pageQueryString}"><span>다음글</span></a>
	    </c:if> 
	</div>
	<div class="fr" >
		<a class="btn btn-primary" href="/bos/concert/concertUser/forUpdate.do?userId=${result.userId}&${pageQueryString}"><span>수정</span></a>
		<a class="btn btn-primary" href="/bos/concert/concertUser/list.do?${pageQueryString}"><span>목록</span></a>
	</div>
</div>

</div>
