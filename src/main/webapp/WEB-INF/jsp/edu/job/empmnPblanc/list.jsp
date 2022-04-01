<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>




<!-- search Panel -->
<c:url value="/edu/job/empmnPblanc/list.do" var="searchUrl" >
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

function search(form) {
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
//]]>
</script>

<div class="schPanel">
	<form id="frm" name="frm" action ="<c:out value="${searchUrl }" />" method="post" onsubmit="return search(this);">
	<input type="hidden" name="pageQueryString" value="${pageQueryString }" >
	<input type="hidden" name="menuNo" id="menuNo"  value="<c:out value="${param.menuNo }"/>"/>
	<input type="hidden" name="acdmcrSeSch" id="acdmcrSeSch"  value=""/>
	<input type="hidden" name="careerSeSch" id="careerSeSch"  value=""/>
	<input type="hidden" name="workStleSch" id="workStleSch"  value=""/>
	<input type="hidden" name="pblancSn" value="${empty result.pblancSn ? 0 : result.pblancSn }" />
		<fieldset>
			<legend>채용정보 검색 입력</legend>
			<div class="mb20">
				<table cellspacing="0" cellpadding="0" class="contents_insight_view contact_us_view" summary="contact_us info search">
					<caption>채용정보 검색</caption>
					<colgroup>
						<col style="width:20%;" />
						<col />
					</colgroup>
				<tbody>
					<tr>
						<th scope="row">
						    <!--<label for="wrkprc">-->
						        근무지역
                            <!--</label>-->
                        </th>
						<td>
						<select name="wrkprc" id="wrkprc" >
							<option value="">지역선택</option>
							<c:forEach var="code" items="${COM094CodeList }" varStatus="status" >
								<option value="${code.code }"<c:if test="${code.code eq paramVO.wrkprc}">selected="selected"</c:if>><c:out value="${code.codeNm}" /></option>
							</c:forEach>
						</select>
						</td>
					</tr>
					<tr>
						<th scope="row">
						    <!--<label for="pblancNm">-->
						            검색키워드
                            <!--</label>-->
                        </th>
						<td>
						    <div class="input_style_2_con">
						        <input type="text" name="pblancNm" id="pblancNm" class="input_style_2" value="<c:out value="${param.pblancNm }" />">
                            </div>
                        </td>
					</tr>
					<tr>
						<th scope="row">학력</th>
						<td>
                            <c:forEach var="code" items="${COM096CodeList }" varStatus="status" >
                                <span class="check_style_0_con">
                                    <input type="checkbox" name="acdmcrSe" value="<c:out value="${code.code }" />" id="acdmcr<c:out value="${status.index }" />" <c:if test="${fn:indexOf(param.acdmcrSeSch, code.code) != -1  }">checked="checked"</c:if> />
                                    <label for="acdmcr<c:out value="${status.index }" />" ><c:out value="${code.codeNm }" /></label>
                                </span>
                            </c:forEach>
						</td>
					</tr>
					<tr>
						<th scope="row">경력</th>
						<td>
						<c:forEach var="code" items="${COM100CodeList }" varStatus="status">
						    <span class="check_style_0_con">
						        <input type="checkbox" name="careerSe" value="<c:out value="${code.code }" />" id="careerSe<c:out value="${status.index }" />" <c:if test="${fn:indexOf(param.careerSeSch, code.code) != -1  }">checked="checked"</c:if> />
                                <label for="careerSe<c:out value="${status.index }" />" ><c:out value="${code.codeNm }" /></label>
                                <c:if test="${code.code eq '02' }">
                                    <input type="text" id="careerMin1" title="경력 시작 월을 입력해 주세요." class="input_style_3" name="careerMin" style="width:50px;" value="${param.careerMin }"  />~
                                    <input type="text" id="careerMax1" title="경력 종료 월을 입력해 주세요." class="input_style_3" name="careerMax" style="width:50px;" value="${param.careerMax }"  />
                                    <span class="dib mr15">개월 이하</span>
                                </c:if>
						    </span>
						</c:forEach>
						</td>
					</tr>
					<tr>
						<th scope="row">근무형태</th>
						<td>
						<div>
						<c:forEach var="code" items="${COM097CodeList }" varStatus="status" >
						    <span class="check_style_0_con">
                                <input type="checkbox" name="workStle" value="<c:out value="${code.code }" />" id="workStle<c:out value="${status.index }" />" <c:if test="${fn:indexOf(param.workStleSch, code.code) != -1 }">checked="checked"</c:if> />
                                <label for="workStle<c:out value="${status.index }"  />"><c:out value="${code.codeNm }" /></label>
                            </span>
						</c:forEach>
						</div>
						</td>
					</tr>
				</tbody>
			</table>
			</div>
			<div class="board_util_btn_con center">
				<input type="button" class="btn_style_0 full gray_btn list resetButton"  value="초기화" />
				<input type="submit" class="btn_style_0 full img_none" value="검색" />
			</div>
		</fieldset>
	</form>
</div>
<!-- //search Panel -->


<div class="col-12 sub_board_header">
	<div class="board_title">
	    <h4>총 <span class="board_count"><c:out value="${resultCnt }" /></span>건의 검색 결과가 있습니다.</h4>
    </div>
</div>
<div class="col-12 sub_board_body">
	<table class="board_type_0 small job_recruit" summary="contact_us list" style="word-break:break-all;">
		<caption>채용정보 목록</caption>
		<colgroup>
			<col style="width:8%">
			<col style="width:15%">
			<col>
			<col style="width:8%">
			<col style="width:12%">
			<col style="width:12%">
		</colgroup>
		<thead>

			<tr>
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
				<td><c:out value="${(resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}" /></td>
				<td><c:out value="${result.entrprsNm }" /></td>
				<td class="tal">
					<c:url var="url" value="/edu/job/${paramVO.programId}/view.do?pblancSn=${result.pblancSn}&" />
					<a href="<c:out value="${url}" />${pageQueryString}">
					 <c:out value="${result.pblancNm}" />
					</a>
				</td>
				<td>
				<c:forEach var="code" items="${COM094CodeList }" varStatus="status" >
						<c:if test="${code.code eq fn:trim(result.wrkprc)}"><c:out value="${code.codeNm}" /></c:if>
				</c:forEach>
				</td>
				<td>
					<c:forEach var="code" items="${COM100CodeList }" varStatus="status">
						<c:if test="${code.code eq result.careerSe }"><c:out value="${code.codeNm }" /></c:if>
					</c:forEach>

					<fmt:formatNumber  var="career" value="${result.career/12}" maxFractionDigits="0" />
					<c:choose>
						<c:when test="${result.careerSe eq '02' and result.career >= 12}">
							<c:out value="${career }" />년 이상
						 </c:when>
						 <c:when test="${result.careerSe eq '02' and result.career < 12 }">
							<c:out value="${result.career }" />개월 이상
						 </c:when>
					 </c:choose>
				</td>
				<td>
<%-- 					<c:out value="${result.rceptBeginDt }" /> ~ --%>
					<c:choose>
						<c:when test="${result.rceptComptAt eq '2' }">채용시까지</c:when>
						<c:when test="${result.rceptComptAt eq '3' }">상시채용</c:when>
						<c:otherwise><fmt:formatDate value="${result.rceptEndDt }" pattern="yyyy-MM-dd"/></c:otherwise>

					</c:choose>
				</td>
			</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="6">데이터가 없습니다.</td></tr></c:if>
		</tbody>
	</table>
</div>

<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
	</c:if>
<!-- //paging -->