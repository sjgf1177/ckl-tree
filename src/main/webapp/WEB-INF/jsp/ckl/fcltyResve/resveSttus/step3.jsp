<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>

<script type="text/javascript">
//<![CDATA[
$(function() {

	if ($("input[name=resveRecptnSe]:checked").size() == 0) {

		$("input[name=resveRecptnSe]").eq(0).attr("checked",true);
	}

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

    v.add("usePurposeSe", {
    	required: true ,
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

<div class="tabs child4 noLink">
	<ol>
		<li>개인정보 동의</li>
		<li>공간 및 일자/시간 선택</li>
		<li class="on">예약자 정보 입력<span class="sr-only">(현재단계)</span></li>
		<li>예약완료</li>
	</ol>
</div>





<h2>예약정보</h2>
<div class="bdView">
	<table class="table table-bordered">
		<caption>
			<details>
				<p>예약정보 상세정보</p>
				<summary>시설공간, 예약일자, 예약시간으로 구분되는 표</summary>
			</details>
		</caption>
		<colgroup>
			<col style="width:118px"/>
		  	<col>
		  	<col style="width:118px"/>
		  	<col>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">시설공간</th>
				<td colspan="3"><c:out value="${resultStep1.vwSpceAllNm }"
						escapeXml="false" /></td>
			</tr>
			<tr>
				<th scope="row">예약일자</th>
				<td>
					<fmt:parseDate value="${resultStep1.resveDt}" var="dateFmt" pattern="yyyy-MM-dd" />
					<fmt:formatDate value="${dateFmt}" pattern="yyyy년 MM월 dd일" />
				</td>
				<th scope="row">예약시간</th>
				<td>
					<util:fz resultLen="2" source="${result.resveBeginTime }" isFront="true" />:00
					 ~ <util:fz resultLen="2" source="${result.resveEndTime }" isFront="true" />:59 (<c:out value="${(result.resveEndTime-result.resveBeginTime+1) }" />시간)
				</td>
			</tr>
		</tbody>
	</table>
</div>



<h2>장비 신청정보</h2>
<div class="bdView">
	<table class="table table-bordered">
		<caption>
			<details>
				<p>장비 신청정보 목록</p>
				<summary>장비구분, 신청수량으로 구분되는 표</summary>
			</details>
		</caption>
		<colgroup>
	  		<col style="width:70%"/>
	  		<col>
	  	</colgroup>

		<thead>
			<tr>
				<th scope="col" class="th">장비구분</th>
		  	  	<th scope="col" class="th brn">신청수량</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="eqpmnItem" items="${result.eqpmnList }" varStatus="status">
				<tr>
					<td class="tac bdrLine"><c:out value="${eqpmnItem.eqpmnNm }" /></td>
					<td class="tac"><c:out value="${eqpmnItem.eqpmnQy }" /></td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(result.eqpmnList) == 0 }">
				<tr>
					<td class="tac" colspan="2">신청장비가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>

<h3>인적사항</h3>
<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
<p class="bull text-primary">휴대폰 및 이메일 정보가 다른 경우에는 마이페이지 <a href="/ckl/userMember/forUpdate.do?menuNo=200033">[회원정보수정]</a>을 통해 정보를 수정하여 주시기 바랍니다.</p>

<fieldset>
	<legend>인적사항 입력정보</legend>
	<form action="/<c:out value="${paramVO.siteName }" />/fcltyResve/resveSttus/stepSave.do" name="resveForm" id="resveForm" method="post" class="form-inline">
	<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
	<input type="hidden" name="resveSn" id="resveSn" value="<c:out value="${result.resveSn }" />" />
		<div class="bdView">
			<table class="table table-bordered">
				<caption>
					<details>
						<p>인적사항 입력정보</p>
						<summary>이름, 휴대폰, 이메일, 나이, 직업, 거주지역, 사용인원, 사용목적, 사용목적 상세, 예약정보 수신방법으로 구분되는 표</summary>
					</details>
				</caption>
			  	<colgroup>
				  	<col style="width:168px"/>
				  	<col style="width:20%"/>
				  	<col style="width:118px"/>
				  	<col />
			  	</colgroup>

			  	<tbody>
					<tr>
			  	  		<th scope="row"> 이름</th>
			  	  		<td colspan="3">
			  	  			<input type="hidden" name="userSn" id="userSn" value="<c:out value="${result.userSn }" />" />
			  	  			<input type="hidden" name="resveNm" id="resveNm" value="<c:out value="${result.resveNm }" />" />
			  	  			<c:out value="${result.resveNm }" />
			  	  		</td>
			  		</tr>
			  		<tr>
			  	  		<th scope="row">휴대폰</th>
			  	  		<td>
			  	  			<c:out value="${result.mbtlnum }" />
			  	  			<input type="hidden" name="mbtlnum" id="mbtlnum" value="<c:out value="${result.mbtlnum }" />" />
			  	  		</td>
			  	  		<th scope="row">이메일</th>
			  	  		<td>
			  	  			<c:out value="${result.email }" />
			  	  			<input type="hidden" name="email" id="email" value="<c:out value="${result.email }" />" />
			  	  		</td>
			  		</tr>
			  		<tr>
			  	  		<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="ageSe">나이</label></th>
			  	  		<td>
							<select name="ageSe" id="ageSe" title="나이를 선택해 주세요.">
								<option value="">나이선택${userVO.ageSe }</option>
					 			<c:forEach var="item" items="${COM081CodeList }">
								<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.ageSe or item.code eq userVO.ageSe}">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
			  	  		</td>
						<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span><label for="jobSe">직업</label></th>
						<td>
							<select name="jobSe" id="jobSe" title="직업를 선택해 주세요.">
								<option value="">직업선택</option>
								<c:forEach var="item" items="${COM056CodeList }">
								<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.jobSe or item.code eq userVO.jobSe}">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
						</td>
			  		</tr>
			  		<tr>
						<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span><label for="resdncSe">거주지역</label></th>
						<td>
							<select name="resdncSe" id="resdncSe" title="지역를 선택해 주세요.">
								<option value="">지역선택</option>
								<c:forEach var="item" items="${COM063CodeList }">
									<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.resdncSe or item.code eq userVO.resdncSe }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
						</td>
						<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span><label for="useNmpr"> 사용인원</label></th>
						<td><input type="text" name="useNmpr" id="useNmpr" value="<c:out value="${result.useNmpr }" />" /> 명</td>
					</tr>
				  	<tr>
						<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span><label for="usePurposeSe"> 사용목적구분</label></th>
						<td colspan="3">
							<select name="usePurposeSe" id="usePurposeSe" title="사용목적구분을 선택해 주세요.">
								<option value="">사용목적구분 선택</option>
								<c:forEach var="item" items="${COM064CodeList }">
									<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.usePurposeSe }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
						</td>
					</tr>
			  		<tr>
			  	  		<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span>사용목적 상세</th>
			  	  		<td colspan="3"><textarea name="usePurposeCn" id="usePurposeCn" cols="30" rows="10" style="width:100%;height:120px" title="사용목적 상세"><c:out value="${result.usePurposeCn }" /></textarea></td>
			  		</tr>
			  		<tr>
			  	  	<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="INNM06">예약정보</label>
			  	      	수신방법</th>
			  	  	<td colspan="3">
			  	  		<p><span class="icons icoAlert"></span> <span class="text-danger">예약번호</span> 및 <span class="text-danger">기본 예약정보</span>를 선택하신 SMS 및 E-mail로 발송해드립니다.</p>

			  	  	<c:forEach var="item2" items="${COM065CodeList }" varStatus="status">
						<label for="resveRecptnSe${status.index }"><input type="radio" name="resveRecptnSe" id="resveRecptnSe${status.index }" value="<c:out value="${item2.code }" />" <c:if test="${item2.code eq result.resveRecptnSe }">checked="checked"</c:if> />
						<c:out value="${item2.codeNm }" />로 수신하겠습니다.  </label>
					</c:forEach>
			  	   	</td>
			  	</tr>
			  </tbody>
			</table>
		</div>

		<div class="btnSet row">
			<div class="col-md-6 tal">
				<a href="/<c:out value="${paramVO.siteName }" />/fcltyResve/resveSttus/step2.do?menuNo=<c:out value="${param.menuNo }" />&amp;locationTp=prev" class="btnIcPrev">이전</a>
			</div>
			<div class="col-md-6 tar">
				<button type="submit" class="btn btn-primary" id="resveRegBtn">저장</button>
				<a href="/<c:out value="${paramVO.siteName }" />/fcltyResve/resveSttus/stepStart.do?menuNo=<c:out value="${param.menuNo }" />" class="btn btn-gray">취소</a>
			</div>
		</div>
		</form>
</fieldset>

<!-- 필수체크의 배경이미지 이동 -->
<script type="text/javascript">
//<![CDATA[
	$("th .hide_star").removeClass("hide_star").parent().addClass("hide_star");
//]]>
</script>

