<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${fn:length(fileList) gt 0}">
	<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
		<c:if test="${fileList[x].fileFieldName eq 'file_1'}">
			<c:set var="fileVO" value="${fileList[x]}"/>
		</c:if>
	</c:forEach>
</c:if>


<div>
	<h3>개인정보</h3>
</div>
<div class="mb25 sub_board_body">
	<table cellspacing="0" cellpadding="0" class="contents_insight_view style_0" summary="아이디, 이름/성별, 생년월일, 이메일, 휴대폰, 거주지">
		<caption>개인정보 상세</caption>
		<colgroup>
		<col style="width:17%"  />
		<col  />
		<col style="width:15%"  />
		<col  />
		</colgroup>
		<tbody>
			<tr>
				<th scope="col">아이디</th>
				<td colspan="3"><c:out value="${result.userId }" /></td>
			</tr>
			<tr>
				<th scope="col">이름 / 성별</th>
				<td><c:out value="${result.userNm }"/> / <c:out value="${result.sexNm }" /></td>
				<th scope="col">생년월일</th>
				<td><c:out value="${result.brthdy }" /></td>
			</tr>
			<tr>
				<th scope="col">이메일</th>
				<td><c:out value="${result.email }"/></td>
				<th scope="col">휴대폰</th>
				<td><c:out value="${result.mbtlnum }" /></td>
			</tr>
			<tr>
				<th scope="col">거주지</th>
				<td colspan="3">
					국적 : <c:if test="${result.resdncSe eq '01'}">국내 </c:if>
					<c:if test="${result.resdncSe eq '02'}">해외 </c:if><br />
					주소 : <c:out value="${result.sidoNm }" />
					<c:out value="${result.gugunNm }"/>
					<c:out value="${result.resdncOvsea }"/>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<div>
	<h3>추가정보</h3>
</div>
<div class="mb25 sub_board_body">
	<table cellspacing="0" cellpadding="0" class="contents_insight_view style_0" summary="학교, 학과, 학년, 희망직무(공통), 상담신청내용">
		<caption>추가정보 상세</caption>
		<colgroup>
		<col style="width:17%"  />
		<col  />
		<col style="width:15%"  />
		<col  />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">학교</th>
				<td colspan="3"><c:out value="${result.schul }"/></td>
			</tr>
			<tr>
				<th scope="row">학과</th>
				<td colspan="3"><c:out value="${result.subjct }" /></td>
			</tr>
			<tr>
				<th scope="row">학년</th>
				<td colspan="3">
					<c:out value="${result.grade }" />
				</td>
			</tr>
			<tr>
				<th scope="row">희망직무(공통)</th>
				<td colspan="3"><c:out value="${result.hopeJssfc }" /></td>
			</tr>
			<tr>
				<th scope="row">상담신청내용</th>
				<td colspan="3">
				<c:forEach var="code" items="${COM070CodeList}" varStatus="status">
					<c:if test="${fn:indexOf(result.cnsltReqCnSe, code.code) ne -1}">${code.codeNm}</c:if>
				</c:forEach>
				<c:out value="${result.cnsltReqCnEtc }" />
				</td>
			</tr>

			<tr>
				<th scope="row">첨부화일</th>
				<td colspan="3">
				<c:if test="${not empty fileVO }">
				<a href="/edu/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"><span class="icoHwp"></span> <c:out value="${fileVO.orignlFileNm}"/></a>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
				</c:if>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<div>
	<h3>상담내역</h3>
</div>
<div class="mb25 sub_board_body">
	<table cellspacing="0" cellpadding="0" class="contents_insight_view style_0" summary="상담 등록일시, 상담신청내용, 상담자, 상담내용">
		<caption>상담내역 상세</caption>
		<colgroup>
		<col style="width:17%"  />
		<col  />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">상담 등록일시</th>
				<td><c:out value="${result.frstRegistPnttm }" /></td>
			</tr>
			<tr>
				<th scope="row">상담신청내용</th>
				<td>
				<c:forEach var="code" items="${COM070CodeList}" varStatus="status">
					<c:if test="${fn:indexOf(result.cnsltReqCnSe , code.code) ne -1}">${code.codeNm}</c:if>
				</c:forEach>
				</td>
			</tr>
			<tr>
				<th scope="row">상담자</th>
				<td><c:out value="${result.cnsltNm }" /></td>
			</tr>
			<tr>
				<th scope="row">상담내역</th>
				<td>상세 상담내역은 온라인상에서 제공되지 않습니다.</td>
			</tr>
		</tbody>
	</table>
</div>

	<div class="board_util_btn_con center">
	<c:url value="/edu/job/empymnCnsl/empymnCnslListMypage.do" var="empymnCnslUrl">
		<c:param name="menuNo" value="${param.menuNo }"/>
	</c:url>
		<a href="<c:out value="${empymnCnslUrl }" />" class="btn_style_0 radius green">목록으로</a>
	</div>
