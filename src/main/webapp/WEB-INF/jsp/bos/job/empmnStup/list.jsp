
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>
<c:url  value="/bos/job/empmnStup/list.do" var="urlReset" >
<c:param name="menuNo" value="${param.menuNo }"/>
</c:url>
<script type="text/javascript">
//<![CDATA[
     $(function() {
    	$(".resetButton").click(function() {
     		var urlReset = "<c:out value='${urlReset}' />"
     			window.location.href=urlReset;
		});
	});
function search(from) {
	var acdmcrSe = "";
	$(":input[name^=acdmcrSe]:checked").each(function(){
		acdmcrSe += $(this).val() + "|";
	});
	$("#acdmcrSeSch").val(acdmcrSe);

	var careerSe = "";
	$(":input[name^=careerSe]:checked").each(function(){
		careerSe += $(this).val() + "|";
	});
	$("#careerSeSch").val(careerSe);

	var workStle = "";
	$(":input[name^=workStle]:checked").each(function(){
		workStle += $(this).val() + "|";
	});
	$("#workStleSch").val(workStle);

}

$(function() {
	$( '.check-all' ).click( function() {
        $( '.input_check' ).prop( 'checked', this.checked );
  });
});




function del(){
	var act = "/bos/job/${paramVO.programId}/delete.json";
	if( "${paramVO.delcode}" == "1" ){
		act = "/bos/job/${paramVO.programId}/delPermanently.json";
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
//]]>
</script>
<title>${masterVO.bbsNm}</title>
</head>
<c:url value="/bos/job/empmnStup/list.do" var="searchUrl" >
	<c:param name="menuNo" value="${param.menuNo }"/>
</c:url>
<form id="frm" name="frm" action ="<c:out value="${searchUrl }" />" method="post" onsubmit="return search(this);">
<input type="hidden" name="pageQueryString" value="${pageQueryString }" >
<input type="hidden" id="menuNo"  value="<c:out value="${param.menuNo }"/>"/>
<input type="hidden" name="pblancSn" value="${empty result.pblancSn ? 0 : result.pblancSn }" />
<input type="hidden" name="acdmcrSeSch" id="acdmcrSeSch"  value=""/>
<input type="hidden" name="careerSeSch" id="careerSeSch"  value=""/>
<input type="hidden" name="workStleSch" id="workStleSch"  value=""/>
<div id="content">

<!-- 게시판 게시물검색 start -->
<fieldset>
	<legend>채용공고 검색</legend>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>채용 공고</caption>
			<colgroup>
			<col />
			<col />
			<col />
			<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" ><label for="SPNM">지역</label></th>
					<td colspan="3">
						<select name="wrkprc" id="wrkprc" value="" >
							<option value="">지역선택</option>
							<c:forEach var="code" items="${COM094CodeList }" varStatus="status" >
								<option value="${code.code }"<c:if test="${code.code eq paramVO.wrkprc}">selected="selected"</c:if>><c:out value="${code.codeNm}" /></option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
				<th>검색키워드</th>
					<td colspan="3"><input class='w500' type="text" name="pblancNm" id="pblancNm" value="<c:out value="${param.pblancNm }" />"></td>
				</tr>
				<tr>
					<th>학력</th>
					<td colspan="3">
						<c:forEach var="code" items="${COM096CodeList }" varStatus="status" >
							<label for="acdmcr<c:out value="${status.index }" />" > <input type="checkbox" name="acdmcrSe" value="<c:out value="${code.code }" />" id="acdmcr<c:out value="${status.index }" />" <c:if test="${fn:indexOf(param.acdmcrSeSch, code.code) != -1  }">checked="checked"</c:if> /><c:out value="${code.codeNm }" /></label>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th>경력</th>
					<td colspan="3">
					<c:forEach var="code" items="${COM100CodeList }" varStatus="status">
							<label for="careerSe<c:out value="${status.index }" />" > <input type="checkbox" name="careerSe" value="<c:out value="${code.code }" />" id="careerSe<c:out value="${status.index }" />" <c:if test="${fn:indexOf(param.careerSeSch, code.code) != -1  }">checked="checked"</c:if> /><c:out value="${code.codeNm }" /></label>
							<c:if test="${code.code eq '02' }">
								<input type="text" id="career1" name="careerMin" style="width:50px;" value="${param.careerMin }"  />~
								<input type="text" id="career2" name="careerMax" style="width:50px;" value="${param.careerMax }"  />개월 이하
							</c:if>
					</c:forEach>

					</td>
				</tr>
				<tr>
					<th>근무형태</th>
					<td colspan="3">
						<c:forEach var="code" items="${COM097CodeList }" varStatus="status" >
							<label for="workStle<c:out value="${status.index }"  />"  class="col-md-2" > <input type="checkbox" name="workStle" value="<c:out value="${code.code }" />" id="workStle<c:out value="${status.index }" />" <c:if test="${fn:indexOf(param.workStleSch, code.code) != -1 }">checked="checked"</c:if> /><c:out value="${code.codeNm }" /></label>
						</c:forEach>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<center><input type="submit"  class="btn btn-primary" value="검색" />  <input type="button"  class="btn btn-primary resetButton"  value="초기화" /></center>
</fieldset>
	</div>

<!-- 게시판 게시물검색 end -->

<div>
<div class="col-md-6"> 총 <strong class="text-danger"> <c:out value="${resultCnt }"/> </strong> 개의 데이터가 조회되었습니다 </div>
		<table class="table table-bordered table-striped table-hover">
			<caption>${masterVO.bbsNm} 목록</caption>
			<colgroup>
				<col width="5%" />
				<col width="8%" />
				<col width="10%" />
				<col width="*" />
				<col width="5%" />
				<col width="11%" />
				<col width="18%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input type="checkbox" name="check-all" id="tschLfrcOrgplceCode" value="all" class="check-all" <c:if test="${zvl.check_all == 'all'}">checked="checked"</c:if> /></th>
					<th scope="col">번호</th>
					<th scope="col">기업명</th>
					<th scope="col">모집내용</th>
					<th scope="col">지역</th>
					<th scope="col">경력</th>
					<th scope="col">마감일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td class="output"><input type="checkbox" name="pblancSnData" id="pblancSnData_${result.pblancSn}" class="input_check" value="<c:out value="${result.pblancSn}"/>" /></td>
				<td class="output"><c:out value="${(resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}" /></td>
				<td class="output"><c:out value="${result.entrprsNm }" /></td>
				<td class="tit">
					<c:url var="url" value="/bos/job/${paramVO.programId}/forUpdate.do?pblancSn=${result.pblancSn}&" />
					<a href="<c:out value="${url}" />${pageQueryString}">
					 <c:out value="${result.pblancNm}" escapeXml="false" />
					</a>
				</td>
				<td class="output"> <c:out value="${result.wrkprcNm }"/> </td>
				<td class="output">
					<c:forEach var="code" items="${COM100CodeList }" varStatus="status">
						<c:if test="${code.code eq result.careerSe }"><c:out value="${code.codeNm }" /></c:if>
					</c:forEach>
					<fmt:formatNumber  var="career" value="${result.career/12}" maxFractionDigits="0" />
					<c:choose>
						<c:when test="${result.careerSe eq '02' and result.career > 12}">
							<c:out value="${career }" />년 이상
						 </c:when>
						 <c:when test="${result.careerSe eq '02' and result.career < 12 }">
							<c:out value="${result.career }" />개월 이상
						 </c:when>
					 </c:choose>
				</td>
				<td class="output"> <fmt:formatDate value="${result.rceptBeginDt }" pattern="yyyy-MM-dd"/>~
					<c:choose>
						<c:when test="${result.rceptComptAt eq '2' }">채용시까지</c:when>
						<c:when test="${result.rceptComptAt eq '3' }">상시채용</c:when>
						<c:otherwise><fmt:formatDate value="${result.rceptEndDt }" pattern="yyyy-MM-dd"/></c:otherwise>
					</c:choose>
				</td>
			</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="8">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
</form>
<div class="fl">
	<a class="btn btn-primary" href="javascript:del();"><span>삭제</span></a>
</div>
<c:url value="/bos/job/${paramVO.programId}/forInsert.do?" var="insertUrl">
</c:url>
<div class="btn_set">
	<a class="btn btn-primary" href="<c:out value="${insertUrl }" />${pageQueryString}"><span>글쓰기</span></a>
</div>

<!-- board list end //-->
	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
<!-- paging end //-->
	</c:if>
