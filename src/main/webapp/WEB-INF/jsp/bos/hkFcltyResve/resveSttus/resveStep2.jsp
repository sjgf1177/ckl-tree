<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>


<script type="text/javascript">
//<![CDATA[
$(function() {
	//회원찾기
	$("#mberPoPBtn").click(function() {
		$("#memSelctTp2").click();
		var url = $(this).attr("href");
		window.open(url,"memberPopup","width=800, height= 700");
		return false;
	});

	$("input[name=memSelctTp]").click(function() {
		if ($(this).val() == "0") {
			$("#resveNm").attr("readonly",false);
			$("#userSn").val("");
		}
		else {
			$("#resveNm").attr("readonly",true);
		}
	});

	$("#resveRegBtn").click(function() {
		checkForm();
		return false;
	});
});


function checkForm() {
	var form = $("#resveForm")[0];
	var v = new MiyaValidator(form);

    v.add("resveNm", {
        required: true
    });

    v.add("mbtlnum", {
        required: true
    });

    v.add("email", {
        required: true
    });

    v.add("ageSe", {
        required: true
    });

    v.add("jobSe", {
        required: true
    });

    v.add("resdncSe", {
        required: true
    });

    v.add("useNmpr", {
    	required: true ,
        option: "number"
    });


    v.add("usePurposeCn", {
        required: true,
        minbyte : 4,
        maxbyte : 400
    });


	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	if ($("input[name=resveRecptnSe]:checked").size() == 0) {
		alert("예약정보 수신방법을 선택해 주세요.");
		return false;
	}


	if (confirm("저장 하시겠습니까?")) form.submit();
}
//]]>
</script>

<ul class="navWizard">
	<li><span>공간 및 일자/시간 선택</span></li>
	<li class="active"><span class="sr-only">(현재 페이지)</span><span>예약자 정보 입력</span></li>
	<li class="last"><span>예약완료</span></li>
</ul>

<h4 class="clear">예약정보</h4>

<div class="bdView">
	<table class="table table-bordered">
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
				<th scope="row" >시설공간</th>
				<td colspan="3"><c:out value="${resultStep1.vwSpceAllNm }" escapeXml="false" /></td>
			</tr>
			<tr>
				<th scope="row" >예약일자</th>
				<td>
					<fmt:parseDate value="${resultStep1.resveDt}" var="dateFmt" pattern="yyyy-MM-dd"/>
                	<fmt:formatDate value="${dateFmt}" pattern="yyyy년 MM월 dd일"/>
				</td>
				<th scope="row" >예약시간</th>
				<td>
					${result.resveBeginTime }:00
					 ~ ${result.resveEndTime }:59 (<c:out value="${(result.resveEndTime-result.resveBeginTime+1) }" />시간)
				</td>
			</tr>
		</tbody>
	</table>
</div>


<h4>장비 신청정보</h4>
<div class="bdView">
	<table class="table table-bordered">
		<caption>

		</caption>
		<colgroup>
		<col />
		<col />
		</colgroup>
		<thead>
			<tr>
				<th scope="row" >장비구분</th>
				<th>신청수량</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="eqpmnItem" items="${result.eqpmnList }" varStatus="status">
			<tr>
				<td scope="row" ><c:out value="${eqpmnItem.eqpmnNm }" /></td>
				<td><c:out value="${eqpmnItem.eqpmnQy }" /></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(result.eqpmnList) == 0 }">
			<tr><td class="tac" colspan="2">신청장비가 존재하지 않습니다.</td></tr>
		</c:if>
		</tbody>
	</table>
</div>



<h4>예약자 정보</h4>
<div class="tbrinfo text-danger"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
<form action="/bos/hkFcltyResve/resveSttus/resveSave.do" name="resveForm" id="resveForm" method="post" class="form-inline">
	<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
	<input type="hidden" name="resveSn" id="resveSn" value="<c:out value="${result.resveSn }" />" />
<fieldset>
	<legend>예약자 정보 입력</legend>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>예약자 정보</caption>
			<colgroup>
			<col />
			<col />
			<col />
			<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" >이름</th>
					<td colspan="3"><div><label for="memSelctTp1">
							<input type="radio" name="memSelctTp" value="0" id="memSelctTp1" <c:if test="${empty result.resveSn }">checked="checked"</c:if> />
							직접입력</label>
						<label for="memSelctTp2">
							<input type="radio" name="memSelctTp" value="1" id="memSelctTp2" <c:if test="${not empty result.resveSn }">checked="checked"</c:if> />
							회원선택</label></div>
						<div class="clear">
							<input type="text" name="resveNm" id="resveNm" title="이름을 입력해 주세요." value="<c:out value="${result.resveNm }" />" />
							<input type="hidden" name="userSn" id="userSn" value="<c:out value="${result.userSn }" />" />
							<a href="/bos/userMember/memberPopup.do?viewType=BODY&amp;objUserSn=userSn&amp;objUserNm=resveNm&amp;objMbtlnum=mbtlnum&amp;objEmail=email" class="btn btn-primary" id="mberPoPBtn">찾기</a>
						</div>

					</td>
				</tr>
				<tr>
					<th scope="row" ><label for="mbtlnum"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 휴대폰</label></th>
					<td><input type="text" name="mbtlnum" id="mbtlnum" value="<c:out value="${result.mbtlnum }" />" /></td>
					<th scope="row" ><label for="email"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 이메일</label></th>
					<td><input type="text" name="email" id="email" value="<c:out value="${result.email }" />" />　</td>
				</tr>
				<tr>
					<th scope="row" ><label for="ageSe"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 나이</label></th>
					<td><select name="ageSe" id="ageSe" title="나이를 선택해 주세요.">
						 <option value="">나이선택</option>
						 <c:forEach var="item" items="${COM081CodeList }">
							<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.ageSe}">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
						</c:forEach>

						</select></td>
					<th scope="row" ><label for="jobSe"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 직업</label></th>
					<td>
						<select name="jobSe" id="jobSe" title="직업를 선택해 주세요.">
							<option value="">직업선택</option>
							<c:forEach var="item" items="${COM056CodeList }">
								<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.jobSe}">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row" ><label for="resdncSe"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 거주지역</label></th>
					<td>
						<select name="resdncSe" id="resdncSe" title="지역를 선택해 주세요.">
							<option value="">지역선택</option>
							<c:forEach var="item" items="${COM063CodeList }">
								<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.resdncSe }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
							</c:forEach>
						</select>
					</td>
					<th scope="row" ><label for="useNmpr"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 사용인원</label></th>
					<td><input type="text" name="useNmpr" id="useNmpr" value="<c:out value="${result.useNmpr }" />" /> 명</td>
				</tr>
				<tr>
					<th scope="row" ><label for="usePurposeSe"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 사용목적구분</label></th>
					<td colspan="3">
						<select name="usePurposeSe" id="usePurposeSe" title="사용목적구분을 선택해 주세요.">
							<option value="">사용목적구분 선택</option>
							<c:forEach var="item" items="${COM145CodeList }">
								<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.usePurposeSe }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="usePurposeCn"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 사용목적(200자이내)</label></th>
					<td colspan="3"><textarea name="usePurposeCn" id="usePurposeCn" cols="120" rows="12" class="span12" title="내용을 입력하여 주세요."><c:out value="${result.usePurposeCn }" /></textarea>　</td>
				</tr>
				<tr>
					<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 예약정보 수신방법</th>
					<td colspan="3">

						<c:forEach var="item2" items="${COM146CodeList }" varStatus="status">
							<input type="radio" name="resveRecptnSe" id="resveRecptnSe${status.index }" value="<c:out value="${item2.code }" />" <c:if test="${item2.code eq result.resveRecptnSe }">checked="checked"</c:if> />
							<label for="resveRecptnSe${status.index }"> <c:out value="${item2.codeNm }" />로 수신하겠습니다.  </label>
						</c:forEach>

						<div class="clear"><span class="text-danger">※ 예약번호 및 기본 예약정보를 선택하신 SMS 및 E-mail로 발송해드립니다.</span></div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</fieldset>


<div class="row clear mt20 tac">
	<div class="col-md-2"><a href="/bos/hkFcltyResve/resveSttus/resveStep1.do?menuNo=<c:out value="${param.menuNo }" />&amp;locationTp=prev" class="btn btn-default">이전</a></div>
	<div class="col-md-10">
		<a href="#self" class="btn btn-primary" id="resveRegBtn">다음</a>
		<a href="/bos/hkFcltyResve/resveSttus/list.do?menuNo=<c:out value="${param.menuNo }" />" class="btn btn-default">취소</a>
	</div>
</div>
</form>

