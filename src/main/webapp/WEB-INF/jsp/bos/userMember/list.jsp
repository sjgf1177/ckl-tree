<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
	$(function() {
		//SMS
		$("#smsSndngBtn").click(function() {
			var params = $("#frm2").serialize();
			window.open("/bos/userMember/smsSndngPopup.do?viewType=BODY&"+params, "smsSndngPopup", "width=500px, height=380px, scrollbars=no");
	  	});
		
		// 문화광장 rsg20170926 
		$("#mberSe").change(function(){
			$("#frm2").submit();
		});
		if ( $("#mberSe").val() == '03' )
			$("#smsSndngBtn").show();

		$("#mbtlnum").mask("999-999?9-9999").on("change", function() {
		    var last = $(this).val().substr( $(this).val().lastIndexOf("-") + 1 );

		    if( last.length == 3 ) {
		        var move = $(this).val().substr( $(this).val().lastIndexOf("-") - 1, 1 );
		        var lastfour = move + last;
		        var first = $(this).val().substr( 0, 7 ); // Change 9 to 8 if you prefer mask without space: (99)9999?9-9999

		        $(this).val( first + '-' + lastfour );
		    }
		});


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

	function del(){
		if($(":checkbox:checked").length == 0)
		{
			alert("삭제할 회원을 선택하세요.");
			return;
		}
		if( !confirm("정말로 삭제하시겠습니까?") ){
			return;
		}
		var inData = $("#frm2").serialize();
		$.post(
			"/bos/userMember/delete.json",
			inData,
			function(data){
				var resultCode = data.resultCode;
				var resultMsg = data.msg;
				alert(resultMsg);
				if(resultCode == "success") location.reload();
			}
		);
	}

	function goSearch(frm2){
		/*
		if(frm2.sdate.value > frm2.edate.value){

			alert("기간을 올바르게 선택해주세요.");
			frm2.sdate.value = "";
			frm2.edate.value = "";
			return false;
		}
		*/
	}

</script>

<form id="frm2" name="frm2" method="post" action="/bos/userMember/list.do?menuNo=${param.menuNo}" onsubmit="return goSearch(this);" class="form-inline">
		<!-- 게시판 게시물검색 start -->
	<fieldset>
		<legend></legend>
			<div class="bdView mb0">
				<table class="table table-bordered">
				<caption></caption>
				<colgroup>
					<col />
					<col />
					<col />
					<col />
				</colgroup>
					<tbody>
						<tr>
							<th scope="row" ><label for="GUBUN1">구분</label></th>
								<td>
									<select name="mberSe" id="mberSe" title="구분을 선택해 주세요.">
										<option value="">전체 회원 SNS</option>
									   	<option value="01" <c:if test="${paramVO.mberSe == '01'}">selected="selected"</c:if> >일반</option>
									   	<option value="02" <c:if test="${paramVO.mberSe == '02'}">selected="selected"</c:if> >SNS</option>
									   	<option value="03" <c:if test="${paramVO.mberSe == '03'}">selected="selected"</c:if> >문화광장 회원</option>
									</select>
								</td>
							<th scope="row" ><label for="SCHWD1">검색어</label></th>
								<td>
									<select id="stributary2" name="searchCnd" title="검색조건">
									   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >아이디</option>
									   <option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >이름</option>
									</select>
									<input type="text" name="searchWrd" id="searchWrd" value="${paramVO.searchWrd}" />
									<input type="submit" class="btn btn-primary" value="검색" />
								</td>
						</tr>
						<tr>
							<th scope="row" ><label for="mbtlnum">휴대폰</label></th>
							<td><input type="text" name="mbtlnum" id="mbtlnum" value="<c:out value="${param.mbtlnum }" />" /></td>
							<th scope="row" ><label for="email">이메일</label></th>
							<td><input type="text" name="email" id="email" value="<c:out value="${param.email }" />" /></td>
						</tr>
					</tbody>
				</table>
			</div>
	</fieldset>
		<!-- 게시판 게시물검색 end -->

	<div class="row mt10 mb5">
		<div class="col-md-12"> 
			총 : 
			<strong class="text-danger">
				<c:out value="${resultCnt }" />
			</strong>건 | 
			<strong class="text-danger">
				<c:out value="${paramVO.pageIndex }" /> / 
				<c:out value="${totalPage }" />
			</strong> Page 
		</div>
	</div>


<!-- board list start -->
	<div class="bdList">
		<table class="table table-bordered">
			<caption>회원관리 목록</caption>
			<colgroup>
				<col  />
				<col  />
				<col  />
				<col  span="2" />
				<col  />
				<col  />
				<col  />
			</colgroup>
			<thead>
				<tr>
					<th>선택</th>
					<th>번호</th>
					<th>구분</th>
					<th>성명</th>
					<th>아이디</th>
					<th>인증방식</th>
					<th>가입일시</th>
					<th>휴면전환예정일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:url var="viewUrl" value="/bos/userMember/view.do">
					<c:param name="menuNo" value="${param.menuNo}" ></c:param>
					<c:param name="userSn" value="${result.userSn}" ></c:param>
					<c:param name="searchType" value="${param.searchType}" ></c:param>
					<c:param name="searchTxt" value="${param.searchTxt}" ></c:param>
					<c:param name="pageIndex" value="${empty param.pageIndex ? '1' : param.pageIndex}" ></c:param>
				</c:url>

				<tr>
					<td><input type="checkbox" name="userSnData" value="${result.userSn}" /></td>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td>${result.mberSe eq '01' ? '일반' : (result.mberSe eq '02' ?'SNS':'문화광장') }</td>
					<td><a href="${viewUrl}">${result.userNm}</a></td>
					<td><a href="${viewUrl}">${result.userId}</a></td>
					<td>${result.authSeNm}</td>
					<td>${result.sbscrbDt}</td>
					<td>${result.drmncyCnvrsDt}</td>
				</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}" >
					<tr><td colspan="8">데이터가 없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
<!-- board list end //-->
</form>
	<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">
				${pageNav}
		</div>
	</c:if>
	<br/>
	<div class="btn_set">
		<a class="btn btn-inverse" href="#self" id="smsSndngBtn" style="display:none;"><span>전체 SMS발송</span></a>
		<a class="btn btn-primary" href="/bos/userMember/forInsert.do?${pageQueryString}"><span>등록</span></a>
		<a class="btn btn-primary" href="/bos/userMember/forBatchExcel.do?${pageQueryString}"><span>회원일괄등록</span></a>
		<!-- <a class="btn btn-inverse" href="#self"><span>비밀번호 초기화</span></a> -->
		<a class="btn btn-danger" href="javascript:del();"><span>삭제</span></a>
		<a class="btn btn-success" href="/bos/userMember/downloadExcel.xls?${pageQueryString}"><span>엑셀저장</span></a>
	</div>
