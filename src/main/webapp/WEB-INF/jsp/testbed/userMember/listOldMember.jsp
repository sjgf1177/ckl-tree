<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
//<![CDATA[

	function unity() {
		var form = $("#frm")[0];

	    var userData = $(":input[name=userData]:radio:checked");

		if (userData.length == 0) {
			alert("아이디를 선택하세요.");
			return;
		}

		form.submit();
	}

//]]>
</script>

	<div>
		<div class="boxGray">
			<p class="fs1 mt10 mb10">한국콘텐츠진흥원에서 운영 중인 웹사이트에 <strong class="fcBlack"><c:out value="${user.userNm}"/>님</strong>의 정보로 추정되는 <strong class="fcBlack">회원정보가 존재합니다.</strong><br/>
				창의인재양성 웹사이트(콘텐츠코리아 랩, 에듀코카)에서는 아래의 3개 사이트를 통합하면서 중복 회원정보를 정리하고 있습니다. </p>
		</div>

		<h3 class="mt30">대상 사이트</h3>
		<ul class="bull ml20">
			<li>(구) 창의드림 : http://dream.kocca.or.kr</li>
			<li>(구) 콘텐츠아카데미 : http://edu.kocca.or.kr</li>
			<li>(구) 콘텐츠코리아랩 : http://www.ckl.or.kr</li>
		</ul>


		<div class="alert mt30 mb50">
			<ul class="bull">
				<li>아래의 목록 중에서 선택하신 계정을 제외하고 회원 정보를 정리합니다. (정리된 아이디는 특정기간 보관 후 삭제할 계획입니다. )</li>
				<li>통합 시 이메일로 된 아이디는 사용하실 수 없습니다. (이메일로 된 아이디를 선택한 경우 다음 단계에서 아이디를 변경할 수 있습니다.)</li>
			</ul>
		</div>
	</div>

<form id="frm" name="frm" method="post" action="/testbed/userMember/oldMember.do?menuNo=<c:out value="${param.menuNo}"/>" >
	<input type="hidden" name="rm" value='<c:out value="${rm}"/>'/>
	<div class="bdList">
		<table class="table mb0">
			<caption><strong>

					회원조회 정보 목록
					선택, 번호 사이트 구분, 아이디(이메일), 성명, 가입일시, 현재상태, 결과로 구분되는 표

			</strong><details><summary>설명</summary> <p>선택, 번호, 사이트 구분, 아이디(이메일), 성명, 가입일시, 현재상태, 결과 정보를 포함하는 표</p></details></caption>
			<colgroup>
			<col style="width:8%;">
			<col style="width:8%;">
			<col style="width:12%;">
			<col>
			<col style="width:12%;">
			<col style="width:10%;">
			<col style="width:10%;">
			<col style="width:8%;">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">선택</th>
					<th scope="col">번호</th>
					<th scope="col">사이트 구분</th>
					<th scope="col">아이디(이메일)</th>
					<th scope="col">휴대폰</th>
					<th scope="col">성명</th>
					<th scope="col">가입일</th>
					<th scope="col">현재상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${listOldMember}" varStatus="status">
					<tr>
						<td><input type="radio" name="userData" id="userData_${status.count}" value="<c:out value="${result.siteSe}"/>|<c:out value="${result.userId}"/>|<c:out value="${result.userNm}"/>|<c:out value="${result.email}"/>|<c:out value="${result.moblphon}"/>|<c:out value="${result.userSn}"/>" /></td>
						<td><c:out value="${result.rnum}"/></td>
						<td>
							<c:choose>
								<c:when test="${result.siteSe eq 'kocca'}">에듀코카</c:when>
								<c:when test="${result.siteSe eq 'ckl'}">콘텐츠코리아랩</c:when>
								<c:when test="${result.siteSe eq 'dream'}">창의드림</c:when>
							</c:choose>
						</td>
						<td><label for="userData_${status.count}"><c:out value="${result.userId}"/>(<c:out value="${result.email}"/>)</label></td>
						<td><c:out value="${result.moblphon}"/></td>
						<td><c:out value="${result.userNm}"/></td>
						<td><fmt:formatDate value="${result.sbscrbDt}" pattern="yyyy-MM-dd"/></td>
						<td>정상</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</form>

	<div class="btnSet tar">
		<a class="btn btn-primary" href="javascript:unity();"><span>회원정보 정리</span></a>
	<!--
		<a class="btn btn-gray" href="javascript:del();"><span>삭제</span></a>
	 -->
	</div>
