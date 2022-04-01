
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<c:set var="action" value="/bos/ablman/academy/insert.do" />
<script type="text/javascript">

	$(window).ready(function() {
		listView();

		$(".chghstPopup").click(function() {
			var url = $(this).attr("href");
			console.log(url);
			window.open(url,"chghstPopup","scrollbars=yes,width=800,height=700");
			return false;
		});

	});

	var prgClVal = "<c:out value='${param.prgCl}'/>";

	$(function() {

		if (prgClVal != "") getPrgNmList(prgClVal);

		$("select[name=prgCl]").change(function(){
			if ($(this).val() == "") $("<option>").text("프로그램 선택").attr("value","").appendTo($("#prgNm").empty());
			getPrgNmList($(this).val());
		});

	});

	function getPrgNmList(prgCl) {
		var url = "/bos/progrm/master/prgNmList.json";
		var params = {prgCl : prgCl, viewType : 'CONTBODY'};
		$.get(url, params, function(data) {
			if (data) {
				var $obj = $("#prgNm");
				$obj.empty();
				$("<option>").text("프로그램명 선택").attr("value","").appendTo($obj);
				$.each(data.prgNmList, function(key,item) {
					var $item = $("<option>").attr("value", item.prgNm).text(item.prgNm);
					if ('${param.prgNm}' == item.prgNm) $item.attr("selected",true);
					$item.appendTo($obj);
				});
			}
		},"json");
	}

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

	function checkForm() {
		var frm = $("#frm2")[0];
		var v= new MiyaValidator(frm);

		v.add("ablmanSttus", {
	        required: true
	    });
		v.add("fntnDt", {
	        required: true
	    });
		v.add("copnySe", {
	        required: true
	    });
		v.add("copnyNm", {
	        required: true
	    });
		v.add("chargerNm", {
	        required: true
	    });
	    v.add("telno1", {
   	        required: false,
   	     	span : 3,
	        glue : "-",
   	        option : "phone"
   	    });
	    v.add("faxnum1", {
   	        required: false,
   	     	span : 3,
	        glue : "-",
   	        option : "phone"
   	    });
	    v.add("email1", {
   	        required: false,
			span: 2,
	       	glue: "@",
	       	option: "email"
	    });

		var result = v.validate();

		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (!confirm('등록하시겠습니까?')) {
			return;
		}else{
			frm.submit();
		}

	}

    function check_txt(value) {
	    if (isNaN(value)) {
			alert("숫자로만 입력하셔야 합니다.");
			return "";
		}
	    else {
	    	return value;
	    }
	}

</script>

<form id="frm" name="frm" method="post" action="/bos/ablman/academy/list.do?menuNo=${param.menuNo}">
<input type="hidden" name="pageQueryString" id="pageQueryString" value="${pageQueryString}">
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
							<th scope="row" ><label for="prgCl">분류</label></th>
							<td>
								<select name="prgCl" id="prgCl" title="분류">
									<option value="" >분류 선택</option>
									<c:forEach var="code" items="${COM050CodeList}" varStatus="status" >
										<c:if test="${code.upperCode eq '01'}">
											<option value="${code.code}"<c:if test="${code.code eq param.prgCl}">selected="selected"</c:if>><c:out value="${code.codeNm}" /></option>
										</c:if>
									</c:forEach>
								</select>
							</td>
							<th scope="row"><label for="prgNm">프로그램명</label></th>
							<td>
								<select name="prgNm" id="prgNm" title="프로그램명">
									<option value="" >프로그램명 선택</option>
									<c:forEach var="prg" items="${prgNmList}" varStatus="status" >
											<option value="${prg.prgNm}"<c:if test="${prg.prgNm eq param.prgNm}">selected="selected"</c:if>><c:out value="${prg.prgNm}" /></option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" ><label for="userId">아이디</label></th>
							<td><input type="text" name="userId" id="userId" value="${param.userId}"></td>
							<th scope="row"><label for="nm">이름</label></th>
							<td><input type="text" name="nm" id="nm" value="${param.nm}"></td>
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
	<div class="col-md-6 tar">
		<label for="pageUnit">표시수 :</label>
		<select name="pageUnit" id="pageUnit">
			<option value="10" <c:if test="${param.pageUnit eq 10}">selected="selected"</c:if>>10개</option>
			<option value="20" <c:if test="${param.pageUnit eq 20}">selected="selected"</c:if>>20개</option>
			<option value="30" <c:if test="${param.pageUnit eq 30}">selected="selected"</c:if>>30개</option>
			<option value="50" <c:if test="${param.pageUnit eq 50}">selected="selected"</c:if>>50개</option>
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
				<col  />
				<col style="width:80px" />
				<col style="width:80px" />
				<col style="width:50px" />
				<col style="width:80px" />
				<col style="width:50px" />
				<col style="width:60px" />
				<col style="width:100px" />
				<col style="width:130px" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">분류</th>
					<th scope="col">프로그램명</th>
					<th scope="col">아이디</th>
					<th scope="col">이름</th>
					<th scope="col">성별</th>
					<th scope="col">생년월일</th>
					<th scope="col">참여여부</th>
					<th scope="col">상태</th>
					<th scope="col">최종수정일</th>
					<th scope="col">사후관리</th>
				</tr>
			</thead>
			<tbody>

			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:if test="${empty result.ablmanSttusNm}"><c:set var="url" value="javascript:alert('현재 기업체 등록이 되어있습니다.')"/></c:if>
			<c:if test="${not empty result.ablmanSttusNm}"><c:set var="url" value="/bos/ablman/academy/chghstPopup.do?viewType=BODY&prgSn=<c:out value='${result.prgSn}'/>&amp;userSn=<c:out value='${result.userSn}'/>"/></c:if>
				<tr>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td>${result.prgClNm}</td>
					<td>${result.prgNm}</td>
					<td>${result.userId}</td>
					<td>${result.nm}</td>
					<td>${result.sexNm}</td>
					<td>${result.brthdy}</td>
					<td>${result.partcptnComptAt eq '01' ? '●' : 'X'}</td>
					<td>${empty result.ablmanSttusNm ? '-' : result.ablmanSttusNm}</td>
					<td>${result.updde}</td>
					<td>
						<a href="#self" class="btn btnInTable btn-sm btn-default"><i class="fa fa-sort-desc"></i> 등록</a>
						<c:choose>
							<c:when test="${empty result.ablmanSttusNm}">
								<a href="#" onclick="alert('등록된 이력이 없습니다.');return false;" class="btn btn-sm btn-default">이력</a>
							</c:when>
							<c:otherwise>
								<a href="/bos/ablman/academy/chghstPopup.do?viewType=BODY&prgSn=${result.prgSn}&userSn=${result.userSn}" class="btn chghstPopup btn-sm btn-default">이력</a>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>

				<tr class="tbInsertBox">
					<td colspan="11">
						<form id="frm2" name="frm2" method="post" action="${action}">
						<%-- <form id="frm2" name="frm2" method="post" action="${action }" onsubmit="return checkForm(this);" > --%>
						<input type="hidden" name="prgSn" value="${result.prgSn}" >
						<input type="hidden" name="userSn" value="${result.userSn}" >
						<input type="hidden" name="menuNo" value="${paramVO.menuNo}" >
						<input type="hidden" name="pageQueryString" value="${pageQueryString}">
							<div class="bdInView form-inline ">
								<fieldset>
									<legend>인재관리 - 융합아카데미 등록</legend>
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
													<td>
														<select name="ablmanSttus" id="ablmanSttus" title="상태">
															<option value="" >상태 선택</option>
															<c:forEach var="code" items="${COM080CodeList}" varStatus="status" >
																<option value="${code.code}"><c:out value="${code.codeNm}"/></option>
															</c:forEach>
														</select>
													</td>
													<th scope="row" ><label for="fntnDt">취/창업 일자</label></th>
													<td>
														<script type="text/javascript">
															$(function() {
																$(".date${status.count}").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
															});
														</script>
														<input type="text" name="fntnDt" id="fntnDt" class="date${status.count}" title="취/창업 일자" style="width:130px" value="" readonly="readonly"/>
													</td>
												</tr>
												<tr>
													<th scope="row" ><label for="copnySe">회사구분</label></th>
													<td>
														<select name="copnySe" id="copnySe" title="회사구분">
															<option value="" >구분 선택</option>
															<c:forEach var="code" items="${COM082CodeList}" varStatus="status" >
																<option value="${code.code}"><c:out value="${code.codeNm}"/></option>
															</c:forEach>
														</select>
													</td>
													<th scope="row"><label for="copnyNm">회사명</label></th>
													<td><input type="text" name="copnyNm" id="copnyNm" value=""></td>
												</tr>
												<tr>
													<th scope="row" ><label for="chargerNm">담당자명</label></th>
													<td>
														<input type="text" name="chargerNm" id="chargerNm" value="" />
													</td>
													<th scope="row" ><label for="telno1">연락처</label></th>
													<td>
														<select name="telno1" id="telno1" title="지역 국번 앞 3자리"  class="input_select" >
															<option value="">선택</option>
															<option value="02" >02</option>
															<option value="070" >070</option>
															<option value="051" >051</option>
															<option value="053" >053</option>
															<option value="032" >032</option>
															<option value="062" >062</option>
															<option value="042" >042</option>
															<option value="052" >052</option>
															<option value="044" >044</option>
															<option value="031" >031</option>
															<option value="033" >033</option>
															<option value="043" >043</option>
															<option value="041" >041</option>
															<option value="063" >063</option>
															<option value="061" >061</option>
															<option value="054" >054</option>
															<option value="055" >055</option>
															<option value="064" >064</option>
														</select>
														-
														<input type="text" id="telno2" name="telno2" value="" class="tel" title="연락처 중간4자리" maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
														-
														<input type="text" id="telno3" name="telno3" value="" class="tel" title="연락처 끝4자리" maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
													</td>
												</tr>
												<tr>
													<th scope="row" ><label for="faxnum1">팩스</label></th>
													<td>
														<select name="faxnum1" id="faxnum1" title="지역 국번 앞 3자리"  class="input_select" >
															<option value="">선택</option>
															<option value="02" >02</option>
															<option value="070" >070</option>
															<option value="051" >051</option>
															<option value="053" >053</option>
															<option value="032" >032</option>
															<option value="062" >062</option>
															<option value="042" >042</option>
															<option value="052" >052</option>
															<option value="044" >044</option>
															<option value="031" >031</option>
															<option value="033" >033</option>
															<option value="043" >043</option>
															<option value="041" >041</option>
															<option value="063" >063</option>
															<option value="061" >061</option>
															<option value="054" >054</option>
															<option value="055" >055</option>
															<option value="064" >064</option>
														</select>
														-
														<input type="text" id="faxnum2" name="faxnum2" value="" class="tel" title="팩스번호 중간4자리" maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
														-
														<input type="text" id="faxnum3" name=faxnum3 value="" class="tel" title="팩스번호 끝4자리" maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
													</td>
													<th>이메일</th>
													<td>
														<input type="text" id="email1" name="email1" class="emailid" title="이메일 아이디" />
														@
														<input type="text" id="email2" name="email2" readonly="readonly" class="input_txt emaildomain emaildomain_form" title="이메일 도메인 직접입력 - 이메일 도메인 선택 옵션중 직접입력 선택시 자동활성화&amp;포커스" />
															<label for="sr_email_more" class="hidden">이메일 도메인 선택</label>
															<select id="sr_email_more" name="" class="input_select select_email_js" style="width:auto" title="직접입력 선택시 자동활성화&amp;포커스 이동">
																<option selected="selected">메일주소선택</option>
																<option value="gmail.com">gmail.com</option>
																<option value="naver.com">naver.com</option>
											                    <option value="hanmail.net">hanmail.net</option>
											                    <option value="daum.net">daum.net</option>
											                    <option value="hotmail.com">hotmail.com</option>
											                    <option value="nate.com">nate.com</option>
											                    <option value="yahoo.co.kr">yahoo.co.kr</option>
																<option value="emaildomain_false">직접입력</option>
															</select>
															<script type="text/javascript">
															//<![CDATA[
															jQuery(function(){
																$('select.select_email_js').change(function() {
																	if ($(this).val()=='emaildomain_false') {
																		$('.emaildomain_form:text[name=email2]').val('');
																		$('.emaildomain_form').attr('readonly',false).focus();
																	}else{
																		$('.emaildomain_form:text[name=email2]').val('');
																		$('.emaildomain_form:text[name=email2]').val($(this).val());
																		$('.emaildomain_form').attr('readonly',true)
																	}
																});
															});
															//]]>
															</script>
													</td>
												</tr>
												<tr>
													<th scope="row" ><label for="etc"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 기타</label></th>
													<td colspan="3">
														<textarea name="etc" id="etc" cols="120" rows="5" class="col-md-12" onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';" >내용을 입력하여 주세요.</textarea>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</fieldset>
							</div>
							<!-- <input type="submit"  class="btn btn-primary" value="등록" > -->
						</form>

						<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
					</td>
				</tr>

			<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
				<c:if test="${fn:length(resultList) == 0}" ><tr><td colspan="11">- 검색 결과가 없습니다 -</td></tr></c:if>
		</tbody>
	</table>
</div>

<div class="fl">
	<a class="btn btn-info" href="/bos/ablman/academy/downloadExcel.xls?${pageQueryString}"><span>엑셀저장</span></a>
</div>

<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
</c:if>


