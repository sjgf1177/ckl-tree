<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<%
		int year = egovframework.com.utl.DateUtil.getYear();
		pageContext.setAttribute("year", year);
%>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<%-- <c:set var="action" value="/${paramVO.siteName }/job/${paramVO.programId }/insert.do" /> --%>
<script type="text/javascript">
$(window).ready(function() {
	listView();

	$("#delBtn").click(function() {
		if (confirm("삭제 하시겠습니까?")) {
			location.href =  $(this).attr("href");
		}
		return false;
	});
});

function listView() {
	var tableInBox = $(".tbInsertBox");
	tableInBox.hide();
	$(".btnInTable").click(function(e) {
		$(".btnInTable").removeClass("btn-primary").addClass("btn-default");
		$(this).removeClass("btn-default").addClass("btn-primary");
		tableInBox.hide();
		$(this).parent().parent().next(".tbInsertBox").show();

	});
}

function del(){
	var act = "/bos/job/${paramVO.bbsId}/delete.json";
	if( !confirm("정말로 삭제하시겠습니까?") ){
		location.href =  $(this).attr("href");
		return;
	}
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
							<td><c:out value="${resultList[0].userId }"/></td>
							<td><c:out value="${resultList[0].userNm }"/></td>
							<td>
								<c:forEach var="code" items="${COM079CodeList}" varStatus="status">
											 <c:if test="${fn:indexOf(resultList[0].sex, code.code) != -1}">${code.codeNm}</c:if>
								</c:forEach>

							</td>
							<td><fmt:formatDate value="${resultList[0].brthdy }" pattern="yyyy-MM-dd"/></td>
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
								<th scope="col">최종수정일</th>
								<th scope="col">사후관리</th>
							</tr>
						</thead>
						<tbody>
					<c:choose>
					<c:when test="${not empty resultList[0].histSn }">
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td>${result.nttType=='1' ? '공지' : (resultCnt) - (pageInfo.pageSize * (paramVO.pageIndex-1))}</td>
									<td>
									<a href="/bos/job/empymnCnslList/empymnCnslHistPopup.do?viewType=BODY&amp;pageUnit=5&amp;cnslSn=<c:out value="${result.cnslSn }" />&histSn=<c:out value="${result.histSn }" />">
									${result.userNm }
									</a>
									</td>
									<td>	<a href="/bos/job/empymnCnslList/empymnCnslHistPopup.do?viewType=BODY&cnslSn=<c:out value="${result.cnslSn }" />&histSn=<c:out value="${result.histSn }" />">
									<fmt:formatDate value="${result.lastUpdtPnttm }" pattern="yyyy-MM-dd"/></a></td>
									<td>
									<c:if test="${not empty result.histSn }">
									<a href="/bos/job/empymnCnslList/delete.do?histSn=<c:out value="${result.histSn }"/>&amp;cnslSn=<c:out value='${result.cnslSn }'/>"  class="btn btn-sm btn-default">삭제</a>
									</c:if>
									</td>
								</tr>
								<c:set var="resultCnt" value="${resultCnt-1}" />
							</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4">
							 데이터가 존재하지않습니다.
							</td>
						</tr>
					</c:otherwise>
					</c:choose>

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
									<th scope="row" ><label for="ablmanSttus"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 상태</label></th>
									<td>
											<c:forEach var="code" items="${COM080CodeList }" varStatus="status" >
												<c:if test="${code.code eq result.ablmanSttus}"><c:out value="${code.codeNm}"/></c:if>
											</c:forEach>


									</td>
									<th scope="row" ><label for="JBDAY">취/창업 일자</label></th>
									<td>
									<fmt:formatDate value="${result.fntnDt }" pattern="yyyy-MM-dd"/>
									</td>
								</tr>
								<tr>
									<th scope="row" ><label for="copnySe">회사구분</label></th>
									<td>
									<c:forEach var="code" items="${COM082CodeList }" varStatus="status" >
											<c:if test="${code.code eq result.copnySe}"><c:out value="${code.codeNm}" /></c:if>
										</c:forEach>
									</td>
									<th scope="row"><label for="copnyNm">회사명</label></th>
									<td><c:out value="${result.copnyNm }" /></td>
								</tr>
								<tr>
									<th scope="row" ><label for="chargerNm">담당자명</label></th>
									<td><c:out value="${result.chargerNm }"/></td>
									<th scope="row" ><label for="telno">연락처</label></th>
									<td>
										<c:out value="${result.telno}" />
									</td>
								</tr>
								<tr>
									<th scope="row" ><label for="faxnum">팩스</label></th>
									<td>
									<c:out value="${result.faxnum }"></c:out>
									</td>
									<th>이메일</th>
									<td>
											${result.email }
									</td>
								</tr>
								<tr>
									<th scope="row" ><label for="etc"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 기타</label></th>
									<td colspan="3"><textarea name="etc" id="etc" cols="120" rows="12" class="col-md-12" readonly="readonly" ><c:out value="${result.etc }"></c:out></textarea>
									</td>
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
