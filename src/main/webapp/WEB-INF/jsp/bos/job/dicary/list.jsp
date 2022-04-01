
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<script type="text/javascript">

var codeIdVal = "COM083";
var ctgrySe1Val = "<c:out value="${ param.ctgrySe1 }" />";
var ctgrySe2Val = "<c:out value="${ param.ctgrySe2 }" />";

$(function(){
	//init
	getCodeList("ctgrySe1", codeIdVal, "0", 1, ctgrySe1Val);

	//지역선택 event
	$("#ctgrySe1").change(function() {
		getCodeList("ctgrySe2", codeIdVal, $(this).val(), 2);
	});

});

//공통 코드목록 화면처리
function getCodeList(elemntId, codeId, upperCode, depth, code) {
	var $obj = $("#"+ elemntId);
	var url = "/cmmn/cmmncode/codeListJson.do";
	var params = {
		codeId : codeId,
		upperCode : upperCode
	};
	$.get(url, params, function(data) {
		if (data) {
			$obj.empty();
			if (depth == 1) $("<option>").text("카테고리구분1 선택").attr("value","").appendTo($obj);
			else if (depth == 2) $("<option>").text("카테고리구분2 선택").attr("value","").appendTo($obj);
			$.each(data.list, function(key,item) {
				var $codeItem = $("<option>").attr("value", item.code).text(item.codeNm);
				if (code == item.code) $codeItem.attr("selected",true);
				$codeItem.appendTo($obj);
			});

			if ("ctgrySe1" == elemntId && "" !=  code) {
				getCodeList("ctgrySe2", codeIdVal, $obj.val(), 2, ctgrySe2Val);
			}
			else if ("ctgrySe2" == elemntId && "" == upperCode) {
				$("<option>").text("카테고리구분2 선택").attr("value","").appendTo($("#ctgrySe2").empty());
			}
		}
	},"json");
}
<%--
function del(){
	var act = "/bos/job/${paramVO.bbsId}/delete.json";
	if( "${paramVO.delcode}" == "1" ){
		act = "/bos/job/${paramVO.bbsId}/delPermanently.json";
	}
	if($(":checkbox:checked").length == 0)
	{
		alert("삭제할 게시물을 선택하세요.");
		return;
	}
	if( !confirm("정말로 삭제하시겠습니까?") ){
		return;
	}
	var inData = $("#frm").serialize();
	$.post(
		act,
		inData,
		function(data){
			var resultCode = data.resultCode;
			var resultMsg = data.msg;
			alert(resultMsg);
			if(resultCode == "success") location.reload();
		}
	);
}

	$(function() {
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$("#sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
		$("#edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});

		var strKey = '${paramVO.searchWrd}'; // 하이라이트를 적용할 스트링

		 if(strKey != ''){

			$('.tit').highlight(strKey); //line class에 해당하는 요소들에서 strKey 값들을 하이라이트 처리

		 }

		$( '.check-all' ).click( function() {
	          $( '.input_check' ).prop( 'checked', this.checked );
	    } );
	});
--%>

</script>
<%-- <c:out value="${COM083CodeList }" /> --%>
<title>${masterVO.bbsNm}</title>
</head>
<form id="frm" name="frm" action ="/bos/job/${paramVO.programId}/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>" method="post">
<input type="hidden" name="pageQueryString" id="pageQueryString" value="<c:out value="${pageQueryString }"/>">
<input type="hidden" name="cnslSn" value="${empty result.cnslSn ? 0 : result.cnslSn }" />
	<div id="content">
<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<span style="float:left;">
				<select name="ctgrySe1" id="ctgrySe1">
					<option value="">카테고리구분1 선택</option>

				</select>
				<select name="ctgrySe2" id="ctgrySe2">
						<option value="">카테고리구분2 선택</option>
				</select>
				</span>
				<span>
				<label for="stributary" class="blind"></label>
				<select id="stributary" name="searchCnd" title="검색조건">
				   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >제목</option>
<%-- 				   <option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >내용</option> --%>
				</select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchWrd" value="${paramVO.searchWrd}" />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
				</span>
			</fieldset>
		</div>
		<!-- 게시판 게시물검색 end -->



		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>${masterVO.bbsNm} 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="*" />
				<col width="20%" />
				<col width="18%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">직업</th>
					<th scope="col">분야</th>
					<th scope="col">작성일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td class="output">${(resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}</td>

					<td class="tit">
						<c:url var="url" value="/bos/job/${paramVO.programId}/view.do?dicarySn=${result.dicarySn}&${pageQueryString}" />
						<a href="${url}">
							<span >${result.dicarySj}</span>
						</a>
					</td>

			    	 <td class="output">
			    	 <c:if test="${not empty result.ctgrySe1Nm and not empty result.ctgrySe2Nm }" >
			    	 	<c:out value="${result.ctgrySe1Nm }"/> > <c:out value="${result.ctgrySe2Nm }"/>
			    	 </c:if>
			    	 </td>
					<td class="output"><fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/></td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="10">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
	</form>

	<div class="btn_set">
<c:if test="${empty paramVO.delcode or paramVO.delcode eq '0'}">
		<a class="btn btn-primary" href="/bos/job/${paramVO.programId}/forInsert.do?${pageQueryString}"><span>글쓰기</span></a>
</c:if>
<c:if test="${paramVO.delcode eq '1'}">
		<a class="btn btn-primary" href="/bos/job/${paramVO.programId}/list.do?delcode=0"><span>돌아가기</span></a>
</c:if>
	</div>

		<!-- board list end //-->
	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
	</c:if>


</div>


