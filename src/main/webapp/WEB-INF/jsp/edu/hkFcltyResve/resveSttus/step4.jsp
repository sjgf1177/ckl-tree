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
.bdView table{
	width: 100%;
	font-size: 1.5rem;
	color: black;
}
.bdView > table > tbody > tr > th{
	color: black;
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
@media (min-width: 800px) {
	.tabs{
		min-width: 750px;
	}
}

@media (max-width: 800px) {
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
}
</style>

<div class="tabs child4 noLink">
	<ol>
		<li>개인정보 동의</li>
		<li>공간 및 일자/시간 선택</li>
		<li>예약자 정보 입력</li>
		<li class="on">예약완료<span class="sr-only bgn">(현재단계)</span></li>
	</ol>
</div>

<div class="tac">
	<p><img src="/ckl/images/sub/rr05.gif" alt="" /></p>
	<p class="fs36">시설예약이 정상적으로 <span class="text-danger">완료</span>되었습니다.</p>
</div>

<div class="well well-danger mt35" style="padding-top: 10px;padding-bottom: 10px;margin-top: 5px;font-size: 1.5rem">

	<ul class="bull">
		<li>예약 신청한 정보에 대해 담당자가 확인 및 승인을 거친 후 이용하실 수 있으며, 예약 신청한 내용에 대해서는 마이페이지 [ <strong class="text-danger">예약신청현황</strong> ] 메뉴에서
			승인상태 및 예약번호 확인과 예약취소를 하실 수 있습니다.</li>
		<li><strong class="text-danger">예약취소</strong>를 원하실 경우에는 예약일자 <strong class="text-danger">전일 오후 12:00</strong>까지 취소가 가능하며, 예약 승인 후 이용하지 않으시면 패널티 운영정책에 따라 향후 이용이
			제한되실 수 있습니다.</li>
		<li class="mb0">예약번호는 시설 이용하실 때 꼭 필요한 정보이므로, 사전에 정보를 확인하시어 이용에 불편 없으시기 바랍니다.</li>
	</ul>

</div>



<h2>예약정보<c:if test="${result.resveSttus eq '03' }"><span class="btn btn-sm btn-danger ml10"><span class="icons icoTime"></span>대기</span></c:if></h2>
<div class="bdView">
	<table class="table table-bordered">
		<caption>예약정보(예약번호, 시설공간, 예약일자, 예약시간, 등록일시로 구분되는 표)</caption>
		<colgroup>
			<col style="width:118px"/>
		  	<col>
		  	<col style="width:118px"/>
		  	<col>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">예약번호</th>
				<td colspan="3"><c:out value="${result.resveNo }" /></td>
			</tr>
			<tr>
				<th scope="row" >시설공간</th>
				<td colspan="3"><c:out value="${result.areaSeNm }" /> &gt; <c:out value="${result.lcSeNm }" /> &gt; <c:out value="${result.fcltySeNm }" /> &gt; <c:out value="${result.spceNm }" /></td>
			</tr>
			<tr>
				<th scope="row" >예약일자</th>
				<td>
					<fmt:parseDate value="${result.resveDt}" var="dateFmt" pattern="yyyy-MM-dd"/>
                	<fmt:formatDate value="${dateFmt}" pattern="yyyy년 MM월 dd일"/>
				</td>
				<th scope="row" >예약시간</th>
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
		<caption>장비 신청정보(장비구분, 신청수량으로 구분되는 표)</caption>
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

<h2>예약자 정보</h2>
<div class="bdView">
	<table class="table table-bordered">
		<caption>예약자 정보(이름, 휴대폰, 이메일, 나이, 직업, 거주지역, 사용인원, 사용목적, 예약정보 수신방법으로 구분되는 표)</caption>
		<colgroup>
			<col style="width:168px"/>
		  	<col>
		  	<col style="width:118px"/>
		  	<col>
		</colgroup>
		<tbody>
			<tr>
	  	  		<th scope="row">이름</th>
	  	  		<td colspan="3">
	  	  			<input type="hidden" name="userSn" id="userSn" value="<c:out value="${result.userSn }" />" />
	  	  			<c:out value="${result.resveNm }" />
	  	  		</td>
	  		</tr>
	  		<tr>
	  	  		<th scope="row">휴대폰</th>
	  	  		<td><c:out value="${result.mbtlnum }" /></td>
	  	  		<th scope="row">이메일</th>
	  	  		<td><c:out value="${result.email }" /></td>
	  		</tr>
			<tr>
				<th scope="row">나이</th>
				<td><c:out value="${result.ageSeNm }" /></td>
				<th scope="row">직업</th>
				<td><c:out value="${result.jobSeNm }" /></td>
			</tr>
			<tr>
				<th scope="row" >거주지역</th>
				<td><c:out value="${result.resdncSeNm }" /></td>
				<th scope="row" >사용인원</th>
				<td><c:out value="${result.useNmpr }" /> 명</td>
			</tr>
			<tr>
				<th scope="row" >사용목적</th>
				<td colspan="3"><c:out value="${result.usePurposeCn }" /></td>
			</tr>
			<tr>
				<th scope="row" >예약정보 수신방법</th>
				<td colspan="3"><c:out value="${result.resveRecptnSeNm }" /></td>
			</tr>
		</tbody>
	</table>
</div>

<div class="btnSet board_util_btn_con">
	<a href="/edu/hkFcltyResve/resveSttus/step0.do?menuNo=<c:out value="${param.menuNo}" />" class="btn_style_0 green radius">확인</a>
</div>
