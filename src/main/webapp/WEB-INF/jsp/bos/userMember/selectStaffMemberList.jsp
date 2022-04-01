<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:include page="/WEB-INF/jsp/bos/bbs/com/bbsHead.jsp" flush="true" />
<script type="text/javascript">


	function goSearch(staffPopFrm){

		if(staffPopFrm.searchWrd.value == ""){

			alert("찾으시는 업체명을 입력해 주세요.");
			frm2.searchWrd.focus();
			return false;
		}
	}

	function selectEntMember(userIdx, userNm, intrcn){
		var memIdx = $("#memIdx").val();

		$("#memUserIdx"+memIdx, opener.document).val(userIdx);
		$("#memNm"+memIdx, opener.document).val(userNm);
		$("#memIntrcn"+memIdx, opener.document).val(intrcn);

		window.close();
	}

</script>

</head>
<body>
	<div id="content">
		<div class="hgroup">
			<h3>회원목록</h3>
		</div>

<form id="staffPopFrm" name="staffPopFrm" method="post" action="/bos/userMember/selectStaffMemberList.do" onsubmit="return goSearch(this);">
		<input type="hidden" id="entrprsNo" name="entrprsNo" value="${param.entrprsNo}"/>
		<input type="hidden" id="gubun" name="gubun" value="${param.gubun}"/>
		<input type="hidden" id="memIdx" name="memIdx" value="${param.memIdx}"/>
		<!-- 회원 검색 start -->
		<div class="sh">
			<fieldset>
			<legend>회원 검색</legend>
				<input id="searchWrd" type="text" title="검색어입력" style="width:130px" name="searchWrd" value="${paramVO.searchWrd}" />
				<input id="input2" type="submit" class="btn btn-default" value="검색" />
			</fieldset>
			* 찾으시는 직원명을 입력해 주세요.
		</div>
		<!-- 회원 검색 end -->


<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>회원 목록</caption>
			<colgroup>
				<col width="10%" />
				<col width="15%" />
				<col width="20%" />
				<col width="*" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="fir">번호</th>
					<th scope="col">이름</th>
					<th scope="col">아이디</th>
					<th scope="col">이메일</th>
					<th scope="col">선택</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td>${result.userNm}</td>
					<td>${result.userId}</td>
					<td>${result.email}</td>
					<td><a href="#setStaffId" id="setStaffId_${status.count}" onclick="javascript:selectEntMember('${result.userIdx}','${result.userNm}','${result.intrcn}');return false;" class="button post"><span>선택</span></a></td>
				</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="5">데이터가없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
<!-- board list end //-->

	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>

</form>

</div>

</form>
</body>
</html>