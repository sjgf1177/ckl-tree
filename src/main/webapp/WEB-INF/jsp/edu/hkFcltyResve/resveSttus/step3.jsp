<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>

<!-- <link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css">-->
 <link rel="stylesheet" type="text/css" href="/ckl/css/bootstrap.reset.css"> 
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/animate.min.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/common.css"> -->
<link rel="stylesheet" type="text/css" href="/ckl/css/layout.css">
<link rel="stylesheet" type="text/css" href="/ckl/css/sub.css"> 

<style>
.child4 li{
	width: 22%;
}
.noLink li.on{
	border: 1px solid #40abd4;
	border-bottom-color: transparent;
	color: #40abd4;
	font-size: 1.45rem;
	font-weight: 400;
	text-decoration: unset;
}
.noLink li{
	border-bottom-color: #40abd4;
	font-size: 1.45rem;
	font-weight: 400;
}
h2{
	font-weight: 500;
}
.bdView{
	font-size: 1.45rem;
}
.bdView table{
	width: 100%;
	font-size: 11px;
	color: black;
	font-size: 1.45rem;
}
.bdView > table > tbody > tr > th{
	color: black;
}
.hide_star{
	display: table-cell;
	font-size: 11px;
}
#relation_site{
background-image:url('/edu/new_image/relation_site_arrow.png')!important;
background-repeat:no-repeat!important;
border:none!important;
border-bottom:2px solid white!important;
background-position:right 7px!important;
background-size:8px!important;
line-height:2.0rem!important;
}
@media (min-width: 992px) {
	.tabs{
		min-width: 750px;
	}
	.bdView ul{
		height: 50px;
	}
	.bkgray, .texts{
		padding: 8px 15px;
	}
}

@media (max-width: 992px) {
.tabs{
		min-width: none;
}
 .tabs ol li{
 	display: none;
 }
 .tabs ol li.on{
 	display:block;
 	width: 100%;
 }
 .bdView ul{
 	padding: 8px;
 }
 .bkgray{
	padding: 0px 0px 0px 5px!important;
 }
}

.bdView ol{
	line-height: 28px;
}

.bdView ul{
	display: table;
	border-bottom:1px solid #ddd;
}
.bkgray{
	background-color: #eee;
	border:1px solid #ddd;
	font-weight:500;
	vertical-align:middle;
}
</style>

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
		<caption>예약정보 상세정보(시설공간, 예약일자, 예약시간으로 구분되는 표)</caption>
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
		<caption>장비 신청정보 목록(장비구분, 신청수량으로 구분되는 표)</caption>
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

<h2>인적사항</h2>
<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
<p class="bull text-primary" style="font-size: 1.2rem">휴대폰 및 이메일 정보가 다른 경우에는 마이페이지 [회원정보수정]을 통해 정보를 수정하여 주시기 바랍니다.</p>

<fieldset>
	<legend>인적사항 입력정보</legend>
	<form action="/<c:out value="${paramVO.siteName }" />/hkFcltyResve/resveSttus/stepSave.do" name="resveForm" id="resveForm" method="post" class="form-inline">
	<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
	<input type="hidden" name="resveSn" id="resveSn" value="<c:out value="${result.resveSn }" />" />
		<div class="bdView">
			<ol>
				<ul class="col-12 col-md-3 bkgray" >이름</ul>
				<ul class="col-12 col-md-9 texts"><c:out value="${result.resveNm }" />
				<input type="hidden" name="userSn" id="userSn" value="<c:out value="${result.userSn }" />" />
			  	<input type="hidden" name="resveNm" id="resveNm" value="<c:out value="${result.resveNm }" />" />
			  	</ul>
			</ol>
			<ol>
				<ul class="col-12 col-md-3 bkgray" >휴대폰</ul>
				<ul class="col-12 col-md-3 texts">
					<input type="hidden" name="mbtlnum" id="mbtlnum" value="<c:out value="${result.mbtlnum }" />" />
					<c:out value="${result.mbtlnum }" />
				</ul>
				<ul class="col-12 col-md-3 bkgray" >이메일</ul>
				<ul class="col-12 col-md-3 texts">
					<input type="hidden" name="email" id="email" value="<c:out value="${result.email }" />" />
					<c:out value="${result.email }" />
				</ul>
			</ol>
			<ol>
				<ul class="col-12 col-md-3 bkgray" ><span class="hide_star">(필수입력)</span>나이</ul>
				<ul class="col-12 col-md-3 board_sorting_con">
					<span class="select_box">
							<select class="select_style_0" name="ageSe" id="ageSe" title="나이를 선택해 주세요.">
								<option value="">나이선택</option>
					 			<c:forEach var="item" items="${COM081CodeList }">
								<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.ageSe or item.code eq userVO.ageSe}">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
					</span>
				</ul>
				<ul class="col-12 col-md-3 bkgray" ><span class="hide_star">(필수입력)</span>직업</ul>
				<ul class="col-12 col-md-3 board_sorting_con">
					<span class="select_box">
							<select class="select_style_0" name="jobSe" id="jobSe" title="직업를 선택해 주세요.">
								<option value="">직업선택</option>
								<c:forEach var="item" items="${COM056CodeList }">
								<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.jobSe or item.code eq userVO.jobSe}">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
					</span>
				</ul>
			</ol>
			<ol>
				<ul class="col-12 col-md-3 bkgray" ><span class="hide_star">(필수입력)</span>거주지역</ul>
				<ul class="col-12 col-md-3 board_sorting_con">
					<span class="select_box">
							<select class="select_style_0" name="resdncSe" id="resdncSe" title="지역를 선택해 주세요.">
								<option value="">지역선택</option>
								<c:forEach var="item" items="${COM063CodeList }">
									<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.resdncSe or item.code eq userVO.resdncSe }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
					</span>
				</ul>
				<ul class="col-12 col-md-3 bkgray" ><span class="hide_star">(필수입력)</span>사용인원</ul>
				<ul class="col-12 col-md-3">
					<input style="margin-top: 7px;width: 50%;" title="사용인원을 입력해 주세요." type="text" name="useNmpr" id="useNmpr" value="<c:out value="${result.useNmpr }" />" /> 명
				</ul>
			</ol>
			<ol>
				<ul class="col-12 col-md-3 bkgray" ><span class="hide_star">(필수입력)</span>사용목적구분</ul>
				<ul class="col-12 col-md-9 board_sorting_con">
					<span class="select_box">
							<span class="select_box">
							<select class="select_style_0" name="usePurposeSe" id="usePurposeSe" title="사용목적구분을 선택해 주세요." style="width: 150px;">
								<option value="">사용목적구분 선택</option>
								<c:forEach var="item" items="${COM145CodeList }">
									<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.usePurposeSe }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
							</span>
					</span>
				</ul>
			</ol>
			<ol>
				<ul class="col-12 col-md-3 bkgray" ><span class="hide_star">(필수입력)</span>사용목적상세</ul>
				<ul class="col-12 col-md-9 ">
					<textarea name="usePurposeCn" id="usePurposeCn" cols="30" rows="10" style="width:100%;height:49px" title="사용목적 상세"><c:out value="${result.usePurposeCn }" /></textarea>
				</ul>
			</ol>
			<ol>
				<ul class="col-12 col-md-3 bkgray" ><span class="hide_star">(필수입력)</span>예약정보 수신방법</ul>
				<ul class="col-12 col-md-9 ">
					<p style="margin-bottom: -7px;"><span class="icons icoAlert"></span> <span class="text-danger">예약번호</span> 및 <span class="text-danger">기본 예약정보</span>를 선택하신 SMS 및 E-mail로 발송해드립니다.</p>

			  	  	<c:forEach var="item2" items="${COM146CodeList }" varStatus="status">
						<label for="resveRecptnSe${status.index }"><input type="radio" name="resveRecptnSe" id="resveRecptnSe${status.index }" value="<c:out value="${item2.code }" />" <c:if test="${item2.code eq result.resveRecptnSe }">checked="checked"</c:if> />
						<c:out value="${item2.codeNm }" />  </label>
					</c:forEach>
				</ul>
			</ol>
			
			<!-- ////////////////////////////////// -->
			<%-- <table class="table table-bordered">
				<caption>인적사항 입력정보 이름, 휴대폰, 이메일, 나이, 직업, 거주지역, 사용인원, 사용목적, 사용목적 상세, 예약정보 수신방법으로 구분되는 표</caption>
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
			  	  		<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 나이</th>
			  	  		<td class="board_sorting_con">
			  	  			<span class="select_box">
							<select class="select_style_0" name="ageSe" id="ageSe" title="나이를 선택해 주세요.">
								<option value="">나이선택</option>
					 			<c:forEach var="item" items="${COM081CodeList }">
								<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.ageSe or item.code eq userVO.ageSe}">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
							</span>
			  	  		</td>
						<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span><label for="jobSe">직업</label></th>
						<td class="board_sorting_con">
							<span class="select_box">
							<select class="select_style_0" name="jobSe" id="jobSe" title="직업를 선택해 주세요.">
								<option value="">직업선택</option>
								<c:forEach var="item" items="${COM056CodeList }">
								<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.jobSe or item.code eq userVO.jobSe}">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
							</span>
						</td>
			  		</tr>
			  		<tr>
						<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span><label for="resdncSe">거주지역</label></th>
						<td class="board_sorting_con">
							<span class="select_box">
							<select class="select_style_0" name="resdncSe" id="resdncSe" title="지역를 선택해 주세요.">
								<option value="">지역선택</option>
								<c:forEach var="item" items="${COM063CodeList }">
									<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.resdncSe or item.code eq userVO.resdncSe }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
							</span>
						</td>
						<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span><label for="useNmpr"> 사용인원</label></th>
						<td><input type="text" name="useNmpr" id="useNmpr" value="<c:out value="${result.useNmpr }" />" /> 명</td>
					</tr>
				  	<tr>
						<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span><label for="usePurposeSe"> 사용목적구분</label></th>
						<td colspan="3" class="board_sorting_con">
							<span class="select_box">
							<select class="select_style_0" name="usePurposeSe" id="usePurposeSe" title="사용목적구분을 선택해 주세요." style="width: 150px;">
								<option value="">사용목적구분 선택</option>
								<c:forEach var="item" items="${COM145CodeList }">
									<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.usePurposeSe }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
							</span>
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

			  	  	<c:forEach var="item2" items="${COM146CodeList }" varStatus="status">
						<label for="resveRecptnSe${status.index }"><input type="radio" name="resveRecptnSe" id="resveRecptnSe${status.index }" value="<c:out value="${item2.code }" />" <c:if test="${item2.code eq result.resveRecptnSe }">checked="checked"</c:if> />
						<c:out value="${item2.codeNm }" />로 수신하겠습니다.  </label>
					</c:forEach>
			  	   	</td>
			  	</tr>
			  </tbody>
			</table> --%>
		</div>

		<div class="btnSet row">
			<%-- <div class="col-md-6 tal">
				<a href="/<c:out value="${paramVO.siteName }" />/hkFcltyResve/resveSttus/step2.do?menuNo=<c:out value="${param.menuNo }" />&amp;locationTp=prev" class="btn btn-gray">이전</a>
			</div> --%>
			<div class="col-md-12 tar">
				<button type="submit" class="btn btn-black" id="resveRegBtn">저장</button>
				<%-- <a href="/<c:out value="${paramVO.siteName }" />/hkFcltyResve/resveSttus/step1.do?menuNo=<c:out value="${param.menuNo }" />" class="btn btn-gray">취소</a> --%>
				<button type="button" class="btn btn-gray" onclick="location.href='/<c:out value="${paramVO.siteName }" />/hkFcltyResve/resveSttus/step1.do?menuNo=<c:out value="${param.menuNo }" />'">취소</button>
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

