<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:include page="/WEB-INF/jsp/bos/bbs/com/bbsHead.jsp" flush="true" />
<script type="text/javascript">
	$(function() {
		$("#chkAll").click(function(){
			if(this.checked)
				$(":checkbox").attr("checked", true);
			else
				$(":checkbox").attr("checked", false);
		});
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$("#sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
		$("#edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	});

	function modify(id){
		location.href = "/bos/member/forUpdateUser.do?userId=" + id;
	}

	function goSearch(frm2){

		if(frm2.sdate.value > frm2.edate.value){

			alert("기간을 올바르게 선택해주세요.");
			frm2.sdate.value = "";
			frm2.edate.value = "";
			return false;
		}
	}
</script>

<title>일반회원관리</title>
</head>
<body>
	<div id="content">
		<div class="hgroup">
			<h3>관리자정보</h3>
		</div>

<form id="frm2" name="frm2" method="post" action="/bos/member/userList.do" onsubmit="return goSearch(this);">
		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>일반회원관리 검색</legend>
				<input type="text" id="sdate" name="sdate" value="${param.sdate}" size="10" /> ~
			    <input type="text" id="edate" name="edate" value="${param.edate}" size="10" />

				<label for="stributary" class="blind">검색조건</label>
				<select id="stributary" name="searchCnd" title="검색조건">
				   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >아이디</option>
				   <option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >이름</option>
				</select>
						<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchWrd" value="${paramVO.searchWrd}" />
						<input id="input2" type="submit" class="btn btn-default" value="검색" />

			</fieldset>
		</div>
		<!-- 게시판 게시물검색 end -->


<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>일반회원관리 목록</caption>
			<colgroup>
				<col width="6%" />
				<col width="10%" />
				<col width="13%" />
				<col width="20%" />
				<col width="20%" />
				<col width="*" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input type="checkbox" name="chkAll" id="chkAll" /></th>
					<th scope="col" class="fir">번호</th>
					<th scope="col">회원분류</th>
					<th scope="col">아이디</th>
					<th scope="col">이름</th>
					<th scope="col">등록일</th>
					<th scope="col">비밀번호</th>
					<th scope="col">상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><input type="checkbox" name="userIdData" value="${result.userId}" /></td>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td>
						<c:choose>
							<c:when test="${result.mType eq '1'}">일반</c:when>
							<c:when test="${result.mType eq '2'}">멤버</c:when>
						</c:choose>
					</td>
					<td>${result.userId}</td>
					<td><a href="/bos/member/forUpdateUser.do?userId=${result.userId}">${result.userNm}</a></td>
					<td>${result.regDate}</td>
					<td>초기화</td>
					<td>
						<c:choose>
							<c:when test="${result.status eq 'Y'}">승인</c:when>
							<c:when test="${result.status eq 'N'}">중지</c:when>
						</c:choose>
					</td>
				</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="8">데이터가없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
<!-- board list end //-->
</form>

	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>

	<div class="row">
		<div class="col-md-6 tar">
			<a class="btn btn-primary" href="/bos/member/forInsert.do?${pageQueryString}"><span>등록</span></a>
		</div>
	</div>

</div>

</form>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>