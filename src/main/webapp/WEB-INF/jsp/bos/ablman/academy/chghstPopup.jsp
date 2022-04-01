<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<script type="text/javascript">

$(function() {
});

function del(histSn) {
	if(!confirm("삭제하시겠습니까?")) {
		return;
	}
	$.post(
		"/bos/ablman/academy/delete.json",
		{histSn : histSn},
		function(data)
		{
			if (data.resultCode == "success") {
				alert("삭제가 완료되었습니다.");
				location.reload();
			}
		},"json"
	);
  	return;
}

</script>

<title>${masterVO.bbsNm}</title>
</head>

<div class="col-md-12">
	<h1>이력보기</h1>
		<div class="panel panel-default">
			<div class="panel-body">
				<h4>■ 인재정보</h4>
				<!-- boardView -->
				<div class="bdList pt10">
					<table class="table table-bordered table-hover table-striped" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="15%" />
							<col width="*" />
							<col width="8%" />
							<col width="20%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">아이디</th>
								<th scope="col">이름</th>
								<th scope="col">성별</th>
								<th scope="col">생년월일</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><c:out value="${user.userId}"/></td>
								<td><c:out value="${user.nm}"/></td>
								<td>
									<c:choose>
										<c:when test="${user.sex eq 'M'}">남</c:when>
										<c:when test="${user.sex eq 'W'}">여</c:when>
									</c:choose>
								<td><c:out value="${user.brthdy}"/></td>
							</tr>
						</tbody>
					</table>
				</div>

				<h4>■ 변경이력</h4>
				<!-- boardView -->
				<div class="bdList pt10">
					<table class="table table-bordered tac">
						<caption>
						</caption>
						<colgroup>
							<col style="width:10%" />
							<col  />
							<col style="width:25%" />
							<col style="width:15%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">이름</th>
								<th scope="col">등록일</th>
								<th scope="col">사후관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="chghst" items="${chghstList}" varStatus="status">
								<c:url var="url" value="/bos/ablman/academy/chghstPopup.do?prgSn=${param.prgSn}&userSn=${param.userSn}&histSn=${chghst.histSn}&viewType=BODY"/>
								<tr>
									<td>${chghst.rnum}</td>
									<td>
										<a href="${url}">${chghst.userNm}</a>
									</td>
									<td>
										<a href="${url}">${chghst.frstRegistPnttm}</a>
									</td>
									<td>
										<a href="javascript:del('${chghst.histSn}')"  class="btn btn-sm btn-default">삭제</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<c:if test="${not empty result}">
					<h4>■ 변경내용</h4>
					<div class="bdInView form-inline pt10">
					<fieldset>
						<div class="shView">
							<table class="table">
								<caption>
								</caption>
								<colgroup>
								<col style="width:3%"  />
								<col style="width:47%" />
								<col style="width:3%" />
								<col style="width:47%" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row" >상태</th>
										<td><c:out value="${result.ablmanSttusNm }" /></td>
										<th scope="row" >취/창업 일자</th>
										<td><c:out value="${result.fntnDt }"/></td>
									</tr>
									<tr>
										<th scope="row" >회사구분</th>
										<td><c:out value="${result.copnySeNm }" /></td>
										<th scope="row">회사명</th>
										<td><c:out value="${result.copnyNm }" /></td>
									</tr>
									<tr>
										<th scope="row" >담당자명</th>
										<td><c:out value="${result.chargerNm }"/></td>
										<th scope="row" >연락처</th>
										<td><c:out value="${result.telno }"/></td>
									</tr>
									<tr>
										<th scope="row" >팩스</th>
										<td><c:out value="${result.faxnum }"/></td>
										<th scope="row" >이메일</th>
										<td><c:out value="${result.email }"/></td>
									</tr>
									<tr>
										<th scope="row" ><label for="etc"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 기타</label></th>
										<td colspan="3">${result.etc}</td>
									</tr>
								</tbody>
							</table>
						</div>
					</fieldset>
				</div>
			</c:if>

		</div>
	</div>
</div>
