
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>
<c:set var="action" value="/${paramVO.siteName }/job/${paramVO.programId }/insert.do" />
<script type="text/javascript">
$(window).ready(function() {
	listView();
	$(".histPopup").click(function() {
		var url = $(this).attr("href");
		console.log(url);
		window.open(url,"histList","scrollbars=yes,width=800, height=700");
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





	$(function() {

		var strKey = '${paramVO.searchWrd}'; // 하이라이트를 적용할 스트링

		 if(strKey != ''){

			$('.tit').highlight(strKey); //line class에 해당하는 요소들에서 strKey 값들을 하이라이트 처리

		 }




	$('select.email_addr').change(function() {
			if ($(this).val() == 'emaildomain_false') {
				$('.email_addr:text[name=emailAddr]').val('');
				$('.email_addr').attr('readonly', false).focus();
			} else {
				$('.email_addr:text[name=emailAddr]').val('');
				$('.email_addr:text[name=emailAddr]').val($(this).val());
				$('.email_addr').attr('readonly', true);
			}
		});

	});

	function checkForm(frm) {
		var v = new MiyaValidator(frm);
		v.add("ablmanSttus", {
			required : true
		});
		v.add("fntnDt", {
			required : true
		});
		v.add("copnySe", {
			required : true
		});
		v.add("copnyNm", {
			required : true
		});
		v.add("chargerNm", {
			required : true
		});
		v.add("telno1", {
			required : true
		});
		v.add("telno2", {
			required : true
		});
		v.add("telno3", {
			required : true
		});
		v.add("faxnum1", {
			required : true
		});
		v.add("faxnm2", {
			required : true
		});
		v.add("faxnm3", {
			required : true
		});
		v.add("emailId", {
			required : true
		});
		v.add("emailAddr", {
			required : true
		});
		v.add("etc", {
			required : true
		});

		var result = v.validate();

		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return false;
		}

		if (!confirm('등록하시겠습니까?')) {
			return false;
		} else {
			frm.submit();
		}

	}
</script>

<title>${masterVO.bbsNm}</title>
</head>


<form id="frm2" name="frm2" method="post" action="/bos/job/${paramVO.programId}/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>">
<input type="hidden" name="pageQueryString" id="pageQueryString" value="<c:out value="${pageQueryString }"/>">
	<!-- 게시판 게시물검색 start -->
	<div class="sh form-inline pr10">
		<fieldset>
			<legend>인재관리 - 융합아카데미 검색</legend>
			<div class="shView">
				<table class="table">
					<caption>
					</caption>
					<colgroup>
					<col />
					<col />
					<col />
					<col />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row" ><label for="userId">아이디</label></th>
							<td><input type="text" name="userId" id="userId"></td>
							<th scope="row"><label for="userNm">이름</label></th>
							<td><input type="text" name="userNm" id="userNm"></td>
						</tr>
						<tr>
							<th scope="row" ><label for="ablmanSttus">상태</label></th>
							<td>
							<select name="ablmanSttus"  title="상태를선택해 주세요.">
								<option value="" >상태 선택</option>
									<c:forEach var="code" items="${COM080CodeList }" varStatus="status" >
										<option value="${code.code }"<c:if test="${code.code eq paramVO.ablmanSttus}">selected="selected"</c:if>><c:out value="${code.codeNm}" /></option>
									</c:forEach>
							</select>

							</td>
							<th scope="row"><label>상담기간</label></th>
							<td> <input type="text" class="sdate" >~ <input type="text" class="edate"> </td>
						</tr>
					</tbody>
				</table>
					<input type="submit" style="right: " class="btn btn-primary" value="검색" />
			</div>
		</fieldset>
	</div>
</form>

<!-- 게시판 게시물검색 end -->
<div class="row mt10 mb5">
<div class="col-md-6"> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${paginationInfo.totalPageCount }" /></strong> Page </div>
	<div class="col-md-6 tar"><c:out value="" />
		<label for="pageUnit">표시수 :</label>
		<select name="pageUnit" id="pageUnit" onchange="window.location.href=this.value;">
			<c:forEach var="pageSize" begin="10" end="50" step="10">
			<option value="list.do?pageUnit=<c:out value="${pageSize }" />&<c:out value='${pageQueryString }' escapeXml="false" />" <c:if test="${paramVO.pageUnit eq pageSize }">selected="selected"</c:if>><c:out value="${pageSize }" />개</option>
			</c:forEach>
		</select>
	</div>
</div>

<!-- boardView -->
<div class="bdList">
	<table class="table table-bordered tac">
<caption>
</caption>
<colgroup>
<col style="width:50px" />
<col style="width:80px"/>
<col style="width:80px" />
<col style="width:50px" />
<col style="width:80px" />
<col  />
<col style="width:80px" />
<col style="width:80px" />
<col style="width:120px" />
<col style="width:130px" />
</colgroup>
<thead>
	<tr>
		<th scope="col">번호</th>
		<th scope="col">회원여부</th>
		<th scope="col">이름</th>
		<th scope="col">성별</th>
		<th scope="col">생년월일</th>
		<th scope="col">학교/학과</th>
		<th scope="col">상담일</th>
		<th scope="col">상태</th>
		<th scope="col">최종수정일</th>
		<th scope="col">사후관리</th>
	</tr>
</thead>
<tbody>

<c:forEach var="result" items="${resultList}" varStatus="status">
	<tr>
		<td>${result.nttType=='1' ? '공지' : (resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}</td>
		<td>
		 <c:out value="${not empty result.userId ? '회원' : '비회원' }" />
		</td>
		<td>${result.userNm }</td>
		<td>

		<c:forEach var="code" items="${COM079CodeList}" varStatus="status">
			 <c:if test="${fn:indexOf(result.sex, code.code) != -1}">${code.codeNm}</c:if>
		</c:forEach>
		</td>
		<td><fmt:formatDate value="${result.brthdy }" pattern="yyyy-MM-dd"/></td>
		<td>${result.schul }/${result.subjct }</td>
		<td><fmt:formatDate value="${result.hopeEra }" pattern="yyyy-MM-dd"/></td>
		<td>
		<c:forEach var="code" items="${COM080CodeList }" varStatus="status" >
			<c:if test="${code.code eq result.ablmanSttus}"><c:out value="${code.codeNm}" /></c:if>
		</c:forEach>
		</td>
		<td><fmt:formatDate value="${result.lastUpdtPnttm }" pattern="yyyy-MM-dd"/></td>
		<td><a href="#self" class="btn btnInTable btn-sm btn-default"><i class="fa fa-sort-desc"></i> 등록</a>
		<c:choose>
				<c:when test="${empty result.ablmanSttus}">
					<a href="#" onclick="alert('등록된 이력이 없습니다.');return false;" class="btn btn-sm btn-default">이력</a>
				</c:when>
				<c:otherwise>
					 <a href="/bos/job/empymnCnslList/empymnCnslHistPopup.do?viewType=BODY&amp;cnslSn=<c:out value='${result.cnslSn }' />&amp;pageUnit=5" class="btn histPopup btn-sm btn-default">이력</a></td>
				</c:otherwise>
		</c:choose>
<%-- ${sessionScope } --%>
	</tr>
		<tr  class="tbInsertBox">
			<td colspan="11">
				<form id="frm3" name="frm3" method="post" action="<c:out value='${action }'/>" onsubmit="return checkForm(this);" >
				<input type="hidden" id="userSn" value="<c:out value="${result.userSn }" />" name="userSn" >
				<input type="hidden" id="cnslSn" value="<c:out value="${result.cnslSn }" />" name="cnslSn" >
				<input type="hidden" id="menuNo" value="<c:out value="${paramVO.menuNo }" />"  name="menuNo" >
				<input type="hidden" name="pageQueryString" value='<c:out value="${pageQueryString }" escapeXml="false"/>'  >
				<input type="hidden" name="frstRegisterId" value="<c:out value="frstRegisterId" />" >
				<input type="hidden" name=lastUpdusrId value="<c:out value="lastUpdusrId" />">
					<div class="bdInView form-inline ">
						<fieldset>
							<legend>인재관리 - 취업컨설팅 검색</legend>
							<div class="shView">
								<table class="table">
									<caption>
									</caption>
									<colgroup>
									<col />
									<col />
									<col />
									<col />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row" ><label for="ablmanSttus"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 상태</label></th>
											<td><select name="ablmanSttus"  title="상태를 선택해 주세요.">
													<option value="" >상태 선택</option>
													<c:forEach var="code" items="${COM080CodeList }" varStatus="status" >
														<option value="${code.code }"<c:if test="${code.code eq result.ablmanSttus}">selected="selected"</c:if>><c:out value="${code.codeNm}" /></option>
													</c:forEach>


												</select>
											</td>
											<th scope="row" ><label for="JBDAY">취/창업 일자</label></th>
											<td>	<input type="text" class="sdate" name="fntnDt"  title="기간 시작일 입력" style="width:130px" value="<c:out value="${result.fntnDt }"/>" /></td>
										</tr>
										<tr>
											<th scope="row" ><label for="copnySe">회사구분</label></th>
											<td><select name="copnySe" id="copnySe" title="회사구분을 선택해 주세요.">
											<option value="" >구분 선택</option>
											<c:forEach var="code" items="${COM082CodeList }" varStatus="status" >
														<option value="${code.code }"<c:if test="${code.code eq result.copnySeNm}">selected="selected"</c:if>><c:out value="${code.codeNm}" /></option>
											</c:forEach>
											</select>
											</td>
											<th scope="row"><label for="copnyNm">회사명</label></th>
											<td><input type="text" name="copnyNm" id="copnyNm" value="<c:out value="${result.copnyNm }"/>"></td>
										</tr>
										<tr>
											<th scope="row" ><label for="chargerNm">담당자명</label></th>
											<td><input type="text" name="chargerNm" id="chargerNm" value="<c:out value="${result.chargerNm }"/>" /></td>
											<th scope="row" ><label for="telno">연락처</label></th>
											<td><input type="text" name="telno1" id="telno1" value="" style="width:80px" maxlength="4" title="연락처 시작자리를 입력하세요." />
											- <input type="text" name="telno2" id="telno2" value="" style="width:80px" maxlength="4" title="연락처 중간자리를 입력하세요." />
											- <input type="text" name="telno3" id="telno3" value="" style="width:80px" maxlength="4" title="연락처 끝자리를 입력하세요." /></td>
										</tr>
										<tr>
											<th scope="row" ><label for="faxnum">팩스</label></th>
											<td><input type="text" name="faxnum1" id="faxnum1" value="" style="width:80px" maxlength="3" title="팩스 시작자리를 입력하세요." />
											- <input type="text" name="faxnum2" id="faxnm2" value="" style="width:80px" maxlength="4" title="팩스 중간자리를 입력하세요." />
											- <input type="text" name="faxnum3" id="faxnm3" value="" style="width:80px" maxlength="4" title="팩스 끝자리를 입력하세요." /></td>
											<th>이메일</th>
											<td><input type="text" class="w20p" name="emailId" id="emailId" value="" title="이메일 아이디를 입력하세요." />
												@ <input type="text" class="w30p email_addr" name=emailAddr id="emailAddr" value="" readonly="readonly" required="required" title="이메일 도메인 주소를 입력하세요." />
												<select name="sr_email_more" style="width: auto;" class="input_select email_addr" id="emilin" title="이메일 도메인을 선택해 주세요.">
												<option value="">이메일선택</option>
												<option value="gmail.com">gmail.com</option>
												<option value="naver.com">naver.com</option>
												<option value="hanmail.net">hanmail.net</option>
												<option value="daum.net">daum.net</option>
												<option value="hotmail.com">hotmail.com</option>
												<option value="nate.com">nate.com</option>
												<option value="yahoo.co.kr">yahoo.co.kr</option>
												<option value="emaildomain_false">직접입력</option>
												</select>
												<p>※ 관리자 등록 시 별도 승인 없이 인증됩니다.</p>
											</td>
										</tr>
										<tr>
											<th scope="row" ><label for="etc"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 기타</label></th>
											<td colspan="3"><textarea name="etc" id="etc" cols="120" rows="12" class="col-md-12" onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';" >내용을 입력하여 주세요.</textarea>
											</td>
										</tr>
									</tbody>

								</table>

							</div>
						</fieldset>
					</div>

					<input type="submit"  class="btn btn-primary" value="등록" >
				</form>

			</td>
		</tr>
										<c:set var="resultCnt" value="${resultCnt-1}" />
										</c:forEach>
	<%-- 클릭이벤트시 보여질 내용 --%>
								</tbody>
							</table>
																<a class="btn btn-info" href="/bos/job/${paramVO.programId}/downloadExcelEmpymnCnslList.xls?${pageQueryString}"><span>Excel</span></a>

						</div>
					</fieldset>

				</div>
			</form>
		</td>
	</tr>
	<c:if test="$[empty result]" >
	<tr>
		<td colspan="10">- 검색 결과가 없습니다 -</td>
		<td>　</td>
	</tr>
	</c:if>
		</tbody>
	</table>

</div>


	<!-- //boardView -->
<%-- 	<div class="fl"><a class="btn btn-primary" href="javascript:del();"><span>삭제</span></a></div>
	<div class="btn_set">
<c:if test="${empty paramVO.delcode or paramVO.delcode eq '0'}">
   <sec:authorize ifAnyGranted="ROLE_SUPER">
		<a class="btn btn-primary" href="/bos/job/${paramVO.programId}/list.do?delcode=1"><span>삭제글보기</span></a>
   </sec:authorize>
		<a class="btn btn-primary" href="/bos/job/${paramVO.programId}/forInsert.do?${pageQueryString}"><span>글쓰기</span></a>>
			<a class="btn btn-info" href="/bos/job/${paramVO.programId}/downloadExcelEmpymnCnslList.xls?${pageQueryString}&amp;fieldList=Y"><span>Excel</span></a>
</c:if>
<c:if test="${paramVO.delcode eq '1'}">
		<a class="btn btn-primary" href="/bos/job/${paramVO.programId}/list.do?delcode=0"><span>돌아가기</span></a>
</c:if>
	</div>
 --%>
		<!-- board list end //-->
	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
	</c:if>


