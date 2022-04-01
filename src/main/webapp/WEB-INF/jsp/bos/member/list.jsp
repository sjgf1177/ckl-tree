<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
	$(function() {
		$("#chkAll").click(function(){
			if (this.checked) {
				$(":checkbox").prop("checked", true);
			}
			else {
				$(":checkbox").prop("checked", false);
			}
		});
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$("#sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
		$("#edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	});

	function modify(id){
		location.href = "/bos/member/forUpdate.do?menuNo=${param.menuNo}&userId=" + id;
	}

	function del(){
		if($(":checkbox:checked").length == 0)
		{
			alert("삭제할 관리자를 선택하세요.");
			return;
		}
		if( !confirm("정말로 삭제하시겠습니까?") ){
			return;
		}
		var inData = $("#frm2").serialize();
		$.post(
			"/bos/member/delete.json",
			inData,
			function(data){
				var resultCode = data.resultCode;
				var resultMsg = data.msg;
				alert(resultMsg);
				if(resultCode == "success") location.reload();
			}
		);
	}

	function deptPop()
	{
		url = "/bos/memberDept/list.do";
		window.open(url, "deptName", "resizable=no, status=no, scrollbars=no, toolbar=no, menubar=no, width=1000, height=900");
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

<form id="frm2" name="frm2" method="post" action="/bos/member/list.do?menuNo=${param.menuNo}" onsubmit="return goSearch(this);">
		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<input type="text" id="sdate" name="sdate" value="${param.sdate}" size="10" /> ~
			    <input type="text" id="edate" name="edate" value="${param.edate}" size="10" />

				<label for="stributary" class="blind">검색조건</label>
				<select id="stributary" name="searchCnd" title="검색조건">
				   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >아이디</option>
				   <option value="4" <c:if test="${paramVO.searchCnd == '4'}">selected="selected"</c:if> >이름</option>
				   <option value="3" <c:if test="${paramVO.searchCnd == '3'}">selected="selected"</c:if> >부서명</option>
				</select>
						<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchWrd" value="${paramVO.searchWrd}" />
						<input id="input2" type="submit" class="btn btn-default" value="검색" />

			</fieldset>
		</div>
		<!-- 게시판 게시물검색 end -->


<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>직원관리 목록</caption>
			<colgroup>
				<col width="6%" />
				<col width="8%" />
				<col width="20%" />
				<col width="12%" />
				<col width="18%" />
				<col width="*" />
				<col width="12%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input type="checkbox" name="chkAll" id="chkAll" /></th>
					<th scope="col" class="fir">번호</th>
					<th scope="col">권한</th>
					<th scope="col">아이디</th>
					<th scope="col">부서명</th>
					<th scope="col">관리자명</th>
					<th scope="col">등록일</th>
					<th scope="col">상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><input type="checkbox" name="userIdData" value="${result.userId}" /></td>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td>${result.authorNm}</td>
					<td><a href="/bos/member/forUpdate.do?userId=${result.userId}&menuNo=${param.menuNo}">${result.userId}</a></td>
					<td>${result.deptNmKor}</td>
					<td><a href="/bos/member/forUpdate.do?userId=${result.userId}&menuNo=${param.menuNo}">${result.userNm}</a></td>
					<td>${result.regDate}</td>
					<td>
						<c:choose>
							<c:when test="${result.status eq 'N'}">정상</c:when>
							<c:when test="${result.status eq 'H'}">중지</c:when>
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
		<div class="col-md-6"><a class="btn btn-primary" href="javascript:del();"><span>삭제</span></a></div>
		<div class="col-md-6 tar">
			<a class="btn btn-primary" href="javascript:deptPop();"><span>부서관리</span></a>
			<a class="btn btn-primary" href="/bos/member/forInsert.do?${pageQueryString}"><span>등록</span></a>
		</div>
	</div>

