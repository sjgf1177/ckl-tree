<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- <link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css">-->
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/bootstrap.reset.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/animate.min.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/common.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/layout.css"> -->
<link rel="stylesheet" type="text/css" href="/ckl/css/sub.css"> 

<style>
.photoRev .box1{
	width: 100%;
}
.tabs li.on a{
	border: 1px solid #40abd4;
	border-bottom-color: transparent;
	color: #40abd4;
	font-size: 1.45rem;
	font-weight: 400;
	text-decoration: unset;
}
.tabs li a{
	border-bottom-color: #40abd4;
	font-size: 1.45rem;
	font-weight: 400;
}
.photoRev .box1 a.btn{
	background-color: #5ac9b7;
}
.formLine1 input[type=text]{
	width: 130px;
}
@media (min-width: 845px) {
	.photoRev li{
		width: 30%;
		margin-left: 2%;
	}
}
@media (max-width: 845px) {
	.photoRev li{
		width: 45%;
		margin-left: 2%;
	}
}
@media (max-width: 530px) {
	.photoRev li{
		width: 95%;
		margin-left: 3%;
	}
	.formLine1{
		width: 98%;
	}
}
</style>

<script type="text/javascript">
//<![CDATA[
var codeIdVal = "<c:out value="${ codeId0 }" />";
var areaSeVal = "01";
var lcSeVal = "<c:out value="${ param.lcSe }" />";


$(function(){
	//init
	getCodeList("lcList", codeIdVal, areaSeVal, lcSeVal);

	/*
	$(".resveBtn").click(function() {
		var chkTpNum = $(this).attr("data-value");
		if (Number(chkTpNum) >= 2) {
			alert("오늘날짜 기준으로 90일동안 미사용이 2회일 경우, 최종 미사용일로 부터 30일간 예약 불가합니다.");
			return false;
		}
	});
	*/

});

// 공통 코드목록 화면처리
function getCodeList(elemntId, codeId, upperCode,code) {
	var menuNo = "<c:out value="${paramVO.menuNo}" />";
	var $obj = $("#"+ elemntId);
	var url = "/cmmn/cmmncode/codeListJson.do";
	var params = {
		codeId : codeId,
		upperCode : upperCode
	};
	$.get(url, params, function(data) {
		if (data) {
			$obj.empty();
			var $li = $("<li>");
			if (code == "") $li.addClass("on");
			var $a = $("<a>").text("전체").attr("href","/edu/hkFcltyResve/fclty/list.do?menuNo="+menuNo);
			$a.appendTo($li);
			$li.appendTo($obj);

			$.each(data.list, function(key,item) {
				$li = $("<li>");
				if (code == item.code ) $li.addClass("on");
				$a = $("<a>").text(item.codeNm).attr("href","/edu/hkFcltyResve/fclty/list.do?menuNo="+menuNo+"&lcSe="+item.code);
				$a.appendTo($li);
				$li.appendTo($obj);
			});
		}
	},"json");
}

//]]>
</script>



<!-- bdList -->

<div class="formLine1">
	<form id="fcltyForm" name="fcltyForm" method="get" action="/edu/hkFcltyResve/fclty/list.do">
	<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
	<input type="hidden" name="lcSe" id="lcSe" value="<c:out value="${param.lcSe }" />" />
		<fieldset>
			<legend>시설 검색</legend>
			<div class="clearfix board_util_btn_con board_sorting_con">
			<span class="select_box">
			<select class="select_style_0" name="gubun1" id="gubun1" title="구분을 선택해 주세요.">
				<option selected>시설명</option>
			</select>
			</span>
			<!-- <input type="text" value="시설명"  readonly="readonly" style="width: 50px;"> -->
			<input type="text" name="spceNm" id="spceNm" class="mr5" title="검색어를 입력해 주세요." value="<c:out value="${param.spceNm }" />" />
			<a href="#self" class="btn_style_0 green small" onclick="document.fcltyForm.submit();return false;">검색</a>
			</div>
		</fieldset>
	</form>
</div>
<!-- //boardSearch -->


<%-- <c:choose>
<c:when test="${paramVO.lcSe eq '0101' }">
<div class="facilities_gallery">
<div class="g_img"><img alt="2층 구조(2F Synergy Ocean)-중회의실,라커품,프로젝트룸,폰부스,사무실, 모형설계실,취.창업지원실,공작실.페인팅랩, 작품보관실,안내데스크,라이브러리,라운지,소회의실" src="/ckl/images/sub3/fclty_2f.gif" />
<!-- <a class="gof2_1" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=20&amp;searchCnd=&amp;areaSe=&amp;lcSe=0101&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">콘텐츠 코리아 랩 사무실</a> -->
<a class="gof2_2" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=8&amp;searchCnd=&amp;areaSe=&amp;lcSe=0101&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">프로젝트룸Ⅰ-Ⅲ</a>
<a class="gof2_3" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=23&searchCnd=&areaSe=&lcSe=0101&fcltySe=&spceNm=&prpos=&pageUnit=9&menuNo=200019&pageIndex=1">콘텐츠 창작소Ⅰ</a>
<a class="gof2_4" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=24&searchCnd=&areaSe=&lcSe=0101&fcltySe=&spceNm=&prpos=&pageUnit=9&menuNo=200019&pageIndex=2">콘텐츠 창작소 Ⅱ</a>
<a class="gof2_5" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=25&searchCnd=&areaSe=&lcSe=0101&fcltySe=&spceNm=&prpos=&pageUnit=9&menuNo=200019&pageIndex=2">콘텐츠 창작소 Ⅲ</a>
<a class="gof2_6" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=11&amp;searchCnd=&amp;areaSe=&amp;lcSe=0101&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">라이브러리</a>
<a class="gof2_6_2" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=11&amp;searchCnd=&amp;areaSe=&amp;lcSe=0101&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">라운지</a>
<a class="gof2_7" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=12&amp;searchCnd=&amp;areaSe=&amp;lcSe=0101&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">소회의실Ⅰ-Ⅲ</a>
<!-- <a class="gof2_8" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=21&amp;searchCnd=&amp;areaSe=&amp;lcSe=0101&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=2">라커룸</a> -->
<a class="gof2_9" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=19&amp;searchCnd=&amp;areaSe=&amp;lcSe=0101&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">자료열람실</a>
</div></div>
<br/><br/>
</c:when>

<c:when test="${paramVO.lcSe eq '0102' }">
<div class="facilities_gallery">
<div class="g_img"><img alt="10층 구조(10F Idea Village) - 카카오상생센터, 파크, 엘레베이터, 안내데스크,아이디어빌리지, 컨퍼런스룸" src="/ckl/images/sub3/fclty_10f.gif" />
<a class="gof10_1" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=16&amp;searchCnd=&amp;areaSe=&amp;lcSe=0102&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">컨퍼런스룸</a>
<a class="gof10_2" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=17&amp;searchCnd=&amp;areaSe=&amp;lcSe=0102&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">카카오 상생센터</a>
<a class="gof10_3" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=15&amp;searchCnd=&amp;areaSe=&amp;lcSe=0102&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">아이디어 빌리지</a>
<a class="gof10_4" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=15&amp;searchCnd=&amp;areaSe=&amp;lcSe=0102&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">파크</a>
</div>
</div>
<br/><br/>
</c:when>

<c:when test="${paramVO.lcSe eq '0103' }">
<div class="facilities_gallery">
<div class="g_img"><img alt="14층 구조(14F Floating Sky)-영상편집실,녹음실,음향편집실,피칭박스,로비,메이크업.드레스룸, 스린스튜디오,엘레베이터,오픈스튜디오,중앙조정실,세트스튜디오" src="/ckl/images/sub3/fclty_14f.gif" />

<a class="gof14_1" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=32&amp;searchCnd=&amp;areaSe=&amp;lcSe=0103&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">녹음실</a>
<a class="gof14_2" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=31&amp;searchCnd=&amp;areaSe=&amp;lcSe=0103&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">음향편집실Ⅰ-Ⅱ</a>
<a class="gof14_3" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=33&amp;searchCnd=&amp;areaSe=&amp;lcSe=0103&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">피칭박스</a>
<a class="gof14_4" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=30&amp;searchCnd=&amp;areaSe=&amp;lcSe=0103&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">영상편집실</a>
<a class="gof14_5" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=28&amp;searchCnd=&amp;areaSe=&amp;lcSe=0103&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">그린스튜디오</a>
<a class="gof14_6" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=27&amp;searchCnd=&amp;areaSe=&amp;lcSe=0103&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">오픈스튜디오</a>
<a class="gof14_7" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=26&amp;searchCnd=&amp;areaSe=&amp;lcSe=0103&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">세트스튜디오</a>
<a class="gof14_8" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=29&amp;searchCnd=&amp;areaSe=&amp;lcSe=0103&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">분장실</a>
<!--<a class="gof14_9" href="#gof14_9">중앙조정실</a>-->

</div>
</div>
<br/><br/>
</c:when>


<c:when test="${paramVO.lcSe eq '0104' }">
<div class="facilities_gallery">
<div class="g_img"><img alt="15층 구조(15F Floating Sky)-갤러리, 카페테리아.스마트오피스, 계단, 렉처룸, 라운지" src="/ckl/images/sub3/fclty_15f.gif" />

<a class="gof15_1" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=34&amp;searchCnd=&amp;areaSe=&amp;lcSe=0104&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">카페테리아&amp;스마트오피스</a>
<a class="gof15_2" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=36&amp;searchCnd=&amp;areaSe=&amp;lcSe=0104&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">렉처룸Ⅰ-Ⅱ</a>
<a class="gof15_3" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=37&amp;searchCnd=&amp;areaSe=&amp;lcSe=0104&amp;fcltySe=&amp;spceNm=&amp;prpos=&amp;pageUnit=9&amp;menuNo=200019&amp;pageIndex=1">라운지</a>
<!--<a class="gof15_4" href="#gof15_4">갤러리</a>-->

</div></div>
<br/><br/>
</c:when>
</c:choose> --%>

<!-- board table -->
<div class="photoGallery4 photoRev" style="display: flex;">
	<c:if test="${fn:length(resultList) > 0}">
	<ul>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<li>
			<div class="box1">

				<img src="/cmm/fms/getImage.do?atchFileId=<c:out value="${result.atchFileId }" />&amp;fileFieldNm=mainImg" style="width:296px;height:210px;" alt="<c:out value="${result.spceNm }" /> 전경 사진" /><br />
				<strong class="db" style="padding-top: 0px;"><a style="width:200px;" href="/edu/hkFcltyResve/fclty/view.do?fcltySn=<c:out value="${result.fcltySn }" />&amp;${pageQueryString}"><c:out value="${result.spceNm }" />(<c:out value="${result.spceNmEn }" />)</a></strong>
				<span><span class="icons ico1"></span>위치 : <c:out value="${result.lcSeNm }" /></span>
				<span><span class="icons ico2"></span>면적 : <c:out value="${result.ar }" />㎡</span>
				<span><span class="icons ico3"></span>인원 : <c:out value="${result.nmpr }" />명</span>

				<%-- 원본<c:if test="${result.resvePosblAt eq 'Y' and result.resveSe ne 'I'}">
					<a href="/edu/hkFcltyResve/resveSttus/step0.do?fcltySn=<c:out value="${result.fcltySn }" />&amp;menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm btn-danger resveBtn"><span><span class="icons ico4"></span>예약가능</span></a>
					</c:if>
					<c:if test="${result.resvePosblAt eq 'I' and result.resveSe ne 'I'}">
					<a href="/edu/hkFcltyResve/resveSttus/step0.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm btn-success resveBtn"><span><span class="icons ico4"></span>개별예약</span></a>
					</c:if>
					<c:if test="${result.resvePosblAt eq 'N' or result.resveSe eq 'I'}">
					<a href="#self" onclick="return false;" class="btn btn-sm btn-gray"><span><span class="icons ico5"></span>예약불가</span></a>
				</c:if> 원본--%>

				<!-- 추가 -->
					<c:if test="${result.resvePosblAt eq 'Y' and result.resveSe ne 'I'}">
					<a href="/edu/hkFcltyResve/resveSttus/step0.do?fcltySn=<c:out value="${result.fcltySn }" />&amp;menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm btn-success resveBtn"><span><span class="icons ico4"></span>예약가능</span></a>
					</c:if>
					<c:if test="${result.resvePosblAt eq 'I' and result.resveSe ne 'I'}">
					<a href="/edu/hkFcltyResve/resveSttus/step0.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm btn-success resveBtn"><span><span class="icons ico4"></span>개별예약</span></a>
					</c:if>
					<c:if test="${result.resvePosblAt eq 'N' or result.resveSe eq 'I'}">
					<a href="#self" onclick="return false;" class="btn btn-sm btn-gray"><span><span class="icons ico5"></span>예약불가</span></a>
					</c:if>

			</div>
		</li>
		</c:forEach>

	</ul>
	</c:if>
</div>

<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
</c:if>
<!-- //paging -->
<!-- //board table -->

<!-- //bdList -->

