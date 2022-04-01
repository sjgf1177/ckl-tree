<%@page import="egovframework.com.cmm.service.FileVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<c:set var="action" value="" />
<c:set var="actTp" value="" />
<c:if test="${empty result}">
<%-- 	<c:set var="action" value="/bos/fcltyResve/eqpmn/insert.do" /> --%>
	<c:set var="actTp" value="insert" />
</c:if>
<c:if test="${not empty result}">
<%-- 	<c:set var="action" value="/bos/fcltyResve/eqpmn/update.do" /> --%>
	<c:set var="actTp" value="update" />
</c:if>

<script type="text/javascript">
/* package define */ // bm library 를 사용하기 위한 기초만 만들어 둠. 
var bm = {};
</script>

<link rel="stylesheet" type="text/css" href="/edu/css/bm/wevenResponsive.css" />
<link rel="stylesheet" type="text/css" href="/edu/css/admin_reservation_style.css" />

<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/showModalDialog.js'/>" ></script>
<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>


<script type="text/javascript" src="/edu/js/concert/Dom.js"></script>
<script type="text/javascript" src="/edu/js/concert/ProgressBar.js"></script>
<script type="text/javascript" src="/edu/js/concert/Form.js"></script>
<script type="text/javascript" src="/edu/js/concert/Number.js"></script>
<script type="text/javascript" src="/edu/js/concert/String.js"></script>
<script type="text/javascript" src="/edu/js/concert/Calendar.js"></script>

<script type="text/javascript" src="/edu/js/concert/reservationAdmin.js"></script>

<script type="text/javascript">

$(function(){
	
	// 1인이 예약 가능한 좌석  
	reservationAdmin.setReservLimitCnt( <c:out value="${concertInfo.reservLimitCnt}"/> );
	
	// 좌석 픽스/선택가능 여부
 	reservationAdmin.setSitChoiceMode( <c:out value="${concertInfo.reservSitFix}"/> );
})



var actTp = "<c:out value="${actTp}" />";


$(function(){
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#brthday").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});

});
	function checkForm() {
		var form = document.frm;
		var v = new MiyaValidator(form);
		
		if( !$("#viewPeopleNum").text() && !$("#sitIdList").text() ){
			alert( "관람인원 및 예약 좌석을 선택해주세요." );
			return;
		}else{
			$("[name=viewPeopleNum]").val( $("#viewPeopleNum").text() );
			if( reservationAdmin.reservSitFix == 1 ){
				$("[name=sitIdList]").val( -1 );
			}else{
				$("[name=sitIdList]").val( $("#sitIdList").text() );
			}
		}
		
	    v.add("reservPath", {
	        required: true
	    });
	    v.add("memberName", {
	        required: true
	    });
	    v.add("agreeSms", {
	        required: true
	    });
		$("#memberTel").val($("#memberTel1").val()+"-"+$("#memberTel2").val()+"-"+$("#memberTel3").val());
	    v.add("memberTel", {
	        required: true
	    });

		
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}
		
		if (!confirm("${empty result ? '등록' : '수정'}하시겠습니까?")) {
		    return;
		}
	
		form.submit();
	}

    function check_txt(value) {
	    if (isNaN(value)) {
	  	  alert("숫자만 입력가능합니다.");
	    return "";
		}
	    else {
	    	return value;
	    }
	}

	function del(){
		var form = document.f_regi;
		if (confirm("정말로 삭제하시겠습니까?")) {
			form.action="/bos/concert/reserv/delete.do";
			form.submit();
		}
	}

	function fnSelectTch(){
		window.open("/bos/progrm/instrctr/instrctrPopup.do?viewType=BODY", "instrctrPopup", "width=940px, height=550px, scrollbars=no");
	}
	
</script>



<form name="frm" method="post" action="/bos/concert/reserv/${empty result ? 'insert' : 'update'}.do" enctype="multipart/form-data">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}">
	<input type="hidden" name="atchFileId" id="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="siteSe" value="${empty result ? param.siteSe : result.siteSe}">
	<input type="hidden" name="concertId" value="${param.concertId}">
	<input type="hidden" name="menuNo" value="${param.menuNo}">
	<input type="hidden" name="concertTimeId" value="${param.concertTimeId}">
	<input type="hidden" name="reservMasterCode" value="${result.reservMasterCode}">
	
	<!-- 좌석관련 -->
	<input type="hidden" name="sitIdList" value="${result.sitIdList}">
	<input type="hidden" name="viewPeopleNum" value="${result.viewPeopleNum}">

	<h4>예약정보</h4>
	<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>예약정보</caption>
			<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="reservPath1">예약구분</label></th>
					<td colspan="3">
						<label><input type="radio" name="reservPath" value="1" id="reservPath2" <c:if test="${result.reservPath ne '2'}">checked="checked"</c:if>> 현장 </label>
						<label><input type="radio" name="reservPath" value="2" id="reservPath2" <c:if test="${result.reservPath eq '2'}">checked="checked"</c:if>> 전화 </label>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="concertType">예약좌석</label></th>
					<td colspan="3">
						<a class="btn btn-default btn-sm" href="javascript:reservationAdmin.open( ${param.concertId}, ${param.concertTimeId })" id="updtReservStatusBtn">
							<span>
								좌석선택
							</span>
						</a>
						&nbsp;&nbsp;
						관람인원 : <span id="viewPeopleNum">${result.sitCount }</span>명 / 좌석 : <span id="sitIdList">${result.sitIdList }</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>


	<h4>개인정보</h4>
	<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>개인정보</caption>
			<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="memberName">이름</label></th>
					<td colspan="3"><input type="text" name="memberName" id="memberName" value="<c:out value="${result.memberName}" />" class="w100" ></td>
				</tr>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="memberTel1">휴대폰</label></th>
					<td colspan="3">
						<input type="hidden" name="memberTel" id="memberTel" value="${result.memberTel}">
						<c:set var="data" value="${fn:split(result.memberTel,'-')}" />
						<c:choose>
							<c:when test="${fn:length(data) >= 3}">
								<select name="memberTel1" id="memberTel1" title="연락처 앞자리를 선택해 주세요." >
									<option value="">선택</option>
									<option value="010" <c:if test="${data[0] eq '010'}"> selected="selected"</c:if>>010</option>
									<option value="02" <c:if test="${data[0] eq '02'}"> selected="selected"</c:if>>02</option>
									<option value="0505" <c:if test="${data[0] eq '0505'}"> selected="selected"</c:if>>0505</option>
									<option value="0606" <c:if test="${data[0] eq '0606'}"> selected="selected"</c:if>>0606</option>
									<option value="070" <c:if test="${data[0] eq '070'}"> selected="selected"</c:if>>070</option>
									<option value="051" <c:if test="${data[0] eq '051'}"> selected="selected"</c:if>>051</option>
									<option value="053" <c:if test="${data[0] eq '053'}"> selected="selected"</c:if>>053</option>
									<option value="032" <c:if test="${data[0] eq '032'}"> selected="selected"</c:if>>032</option>
									<option value="062" <c:if test="${data[0] eq '062'}"> selected="selected"</c:if>>062</option>
									<option value="042" <c:if test="${data[0] eq '042'}"> selected="selected"</c:if>>042</option>
									<option value="052" <c:if test="${data[0] eq '052'}"> selected="selected"</c:if>>052</option>
									<option value="044" <c:if test="${data[0] eq '044'}"> selected="selected"</c:if>>044</option>
									<option value="031" <c:if test="${data[0] eq '031'}"> selected="selected"</c:if>>031</option>
									<option value="033" <c:if test="${data[0] eq '033'}"> selected="selected"</c:if>>033</option>
									<option value="043" <c:if test="${data[0] eq '043'}"> selected="selected"</c:if>>043</option>
									<option value="041" <c:if test="${data[0] eq '041'}"> selected="selected"</c:if>>041</option>
									<option value="063" <c:if test="${data[0] eq '063'}"> selected="selected"</c:if>>063</option>
									<option value="061" <c:if test="${data[0] eq '061'}"> selected="selected"</c:if>>061</option>
									<option value="054" <c:if test="${data[0] eq '054'}"> selected="selected"</c:if>>054</option>
									<option value="055" <c:if test="${data[0] eq '055'}"> selected="selected"</c:if>>055</option>
									<option value="064" <c:if test="${data[0] eq '064'}"> selected="selected"</c:if>>064</option>
								</select>
								-
								<input type="text" id="memberTel2" name="memberTel2" value="${data[1]}" title="연락처 중간자리를 입력하세요." maxlength="4"  onkeyup="this.value=check_txt(this.value)"/>
								-
								<input type="text" id="memberTel3" name="memberTel3" value="${data[2]}" title="연락처 끝자리를 입력하세요." maxlength="4" onkeyup="this.value=check_txt(this.value)" />
							</c:when>
							<c:otherwise>
								<select name="memberTel1" id="memberTel1" title="연락처 국번 앞 3자리" >
									<option value="">선택</option>
									<option value="010">010</option>
									<option value="02">02</option>
									<option value="0505">0505</option>
									<option value="0606">0606</option>
									<option value="070">070</option>
									<option value="051">051</option>
									<option value="053">053</option>
									<option value="032">032</option>
									<option value="062">062</option>
									<option value="042">042</option>
									<option value="052">052</option>
									<option value="044">044</option>
									<option value="031">031</option>
									<option value="033">033</option>
									<option value="043">043</option>
									<option value="041">041</option>
									<option value="063">063</option>
									<option value="061">061</option>
									<option value="054">054</option>
									<option value="055">055</option>
									<option value="064">064</option>
								</select>
								-
								<input type="text" value="" id="memberTel2" name="memberTel2" title="발신번호 중간자리를 입력하세요." maxlength="4" onkeyup="this.value=check_txt(this.value)" />
								-
								<input type="text" value="" id="memberTel3" name="memberTel3" title="발신번호 끝자리를 입력하세요." maxlength="4" onkeyup="this.value=check_txt(this.value)" />
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="homeArea">거주지역</label></th>
					<td colspan="3"><input type="text" name="homeArea" id="homeArea" value="<c:out value="${result.homeArea}" />" class="w500" ></td>
				</tr>
				<tr>
					<th scope="row"> <label for="job">직업</label></th>
					<td colspan="3"><input type="text" name="job" id="job" value="<c:out value="${result.job}" />" class="w500" ></td>
				</tr>
				<tr>
					<th scope="row"> <label for="dept">소속</label></th>
					<td colspan="3"><input type="text" name="dept" id="dept" value="<c:out value="${result.dept}" />" class="w500" ></td>
				</tr>
			</tbody>
		</table>
	</div>


	<h4>공연예약설정</h4>
	<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
	<div class="bdView">
		<table class="table table-bordered">
			<colgroup>
			<col width="15%">
			<col width="auto">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="agreeSms1">SMS 수신</label></th>
					<td>
						<label for="agreeSms1"><input type="radio" name="agreeSms" value="1" id="agreeSms1" <c:if test="${result.agreeSms ne '0'}">checked="checked"</c:if>> 수신</label>
						<label for="agreeSms2"><input type="radio" name="agreeSms" value="0" id="agreeSms2" <c:if test="${result.agreeSms eq '0'}">checked="checked"</c:if>> 미수신 </label>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="row clear mt20">
		<div class="col-md-11 tac">
			<a href="javascript:checkForm();" class="btn btn-primary">${empty result ? '등록' : '수정'}</a>
			<c:if test="${empty result == false }">
				<a href="javascript:del();" class="btn btn-danger">삭제</a>
			</c:if>
		</div>
		<div class="col-md-1"><a href="/bos/concert/reserv/list.do?concertId=${param.concertId }&concertTimeId=${param.concertTimeId }&${pageQueryString}" class="btn btn-primary">목록</a></div>
	</div>

<!-- 팝업창 -->
	<div id="addTimePopup" title="공연일정등록" style="top:0;">
		<div id="addTimePopupCont"></div>
	</div>
<!-- //팝업창 -->

</form>















<div class="col-12 popup_wrap" style="display: none;" id="reservPopStep1">
	    <div class="col-12 col-md-10 col-center popup_con contents_type_2_popup">
	        <div class="col-12 popup_style_0 type2">
	            <div class="col-12 popup_title_wrap">
	                <div class="popup_title">
	                    콘텐츠문화광장 공연 좌석 선택
	                </div>
	                <div class="popup_close_btn_con">
	                    <a href="javascript:void(0)" class="popup_close_btn">
	                        <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
	                    </a>
	                </div>
	            </div>
	            <div class="col-12 popup_contents_wrap">
	                <div class="col-12 mb35 popup_contents_inner">
	                    <div class="col-12 popup_contents_inner_border">
	                        <ul class="mb25 list_style_2">
	                            <li>관람 인원선택</li>
	                        </ul>
	                        <div class="mb48 select_style_2_wrap">
	                            <div class="select_style_2_con testbed_style">
	                                <select name="view_people_select" id="viewPeopleSelect" class="select_style_2">
	                                    <option value="1">1명</option>
	                                    <option value="2">2명</option>
	                                </select>
	                                <label for=""></label>
	                            </div>
	                        </div>
	                        <ul class="mb35 list_style_2">
	                            <li>좌석 선택</li>
	                        </ul>
	                        <div class="movie_seat_select_wrap">
	                            <div class="movie_seat_select_inner">
	                            	<div id="sit_fix_dim" class="seat_select_dim">
	                            		<div class="seat_dim_text_box_con">
	                            			<div class="seat_dim_text_box">
	                            				<div class="seat_dim_text_inner">
	                            					<div class="seat_dim_text_box_title">
	                            						<span class="img_box">
	                            							<img src="/edu/images/bm/seat_dim_text_dim_alarm.png" alt="알림">
	                            						</span>
	                            						알림
	                            					</div>
	                            					<div class="seat_dim_text_box_desc">
			                            				본 공연의 좌석은 별도로 지정할 수 없습니다.<br>
			                            				현장의 안내에 따라주세요.
	    	                        				</div>
	    	                        			</div>
	                            			</div>
	                            		</div>
	                            	</div>
	                                <div class="movie_screen">
	                                    STAGE
	                                </div>
	                                <div class="movie_seat_list_wrap">

	                                    <!-- movie_seat_top_list 는 콘트롤부스를 제외한 좌석들 -->
	                                    <div class="movie_seat_top_list">
	                                        <div class="side_seat_list_con left">
	
	                                            <!-- vertical_seat_list 는 스크린기준 왼쪽과 오른쪽에 위치한 좌석 -->
	                                            <div class="vertical_seat_list third_floor">
	                                                <div class="seat_item" data-sit-id="K01">
	                                                    K01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K02">
	                                                    K02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K03">
	                                                    K03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K04">
	                                                    K04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K05">
	                                                    K05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K06">
	                                                    K06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K07">
	                                                    K07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K08">
	                                                    K08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K09">
	                                                    K09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K10">
	                                                    K10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K11">
	                                                    K11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K12">
	                                                    K12
	                                                </div>
	                                            </div>
	                                            <div class="vertical_seat_list second_floor">
	                                                <div class="seat_item" data-sit-id="J01">
	                                                    J01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J02">
	                                                    J02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J03">
	                                                    J03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J04">
	                                                    J04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J05">
	                                                    J05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J06">
	                                                    J06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J07">
	                                                    J07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J08">
	                                                    J08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J09">
	                                                    J09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J10">
	                                                    J10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J11">
	                                                    J11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J12">
	                                                    J12
	                                                </div>
	                                            </div>
	                                            <!-- //vertical_seat_list 는 스크린기준 왼쪽과 오른쪽에 위치한 좌석 -->
	
	                                        </div>
	                                        <div class="center_seat_list_con">
	
	                                            <!-- horizon_seat_list 는 스크린기준 가운데에 위치한 좌석 -->
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="A01">
	                                                    A01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A02">
	                                                    A02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A03">
	                                                    A03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A04">
	                                                    A04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A05">
	                                                    A05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A06">
	                                                    A06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A07">
	                                                    A07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A08">
	                                                    A08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A09">
	                                                    A09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A10">
	                                                    A10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A11">
	                                                    A11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A12">
	                                                    A12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A13">
	                                                    A13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A14">
	                                                    A14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A15">
	                                                    A15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="B01">
	                                                    B01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B02">
	                                                    B02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B03">
	                                                    B03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B04">
	                                                    B04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B05">
	                                                    B05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B06">
	                                                    B06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B07">
	                                                    B07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B08">
	                                                    B08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B09">
	                                                    B09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B10">
	                                                    B10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B11">
	                                                    B11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B12">
	                                                    B12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B13">
	                                                    B13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B14">
	                                                    B14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B15">
	                                                    B15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="C01">
	                                                    C01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C02">
	                                                    C02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C03">
	                                                    C03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C04">
	                                                    C04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C05">
	                                                    C05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C06">
	                                                    C06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C07">
	                                                    C07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C08">
	                                                    C08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C09">
	                                                    C09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C10">
	                                                    C10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C11">
	                                                    C11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C12">
	                                                    C12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C13">
	                                                    C13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C14">
	                                                    C14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C15">
	                                                    C15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="D01">
	                                                    D01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D02">
	                                                    D02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D03">
	                                                    D03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D04">
	                                                    D04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D05">
	                                                    D05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D06">
	                                                    D06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D07">
	                                                    D07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D08">
	                                                    D08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D09">
	                                                    D09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D10">
	                                                    D10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D11">
	                                                    D11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D12">
	                                                    D12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D13">
	                                                    D13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D14">
	                                                    D14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D15">
	                                                    D15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="E01">
	                                                    E01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E02">
	                                                    E02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E03">
	                                                    E03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E04">
	                                                    E04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E05">
	                                                    E05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E06">
	                                                    E06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E07">
	                                                    E07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E08">
	                                                    E08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E09">
	                                                    E09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E10">
	                                                    E10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E11">
	                                                    E11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E12">
	                                                    E12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E13">
	                                                    E13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E14">
	                                                    E14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E15">
	                                                    E15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="F01">
	                                                    F01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F02">
	                                                    F02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F03">
	                                                    F03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F04">
	                                                    F04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F05">
	                                                    F05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F06">
	                                                    F06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F07">
	                                                    F07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F08">
	                                                    F08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F09">
	                                                    F09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F10">
	                                                    F10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F11">
	                                                    F11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F12">
	                                                    F12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F13">
	                                                    F13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F14">
	                                                    F14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F15">
	                                                    F15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="G01">
	                                                    G01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G02">
	                                                    G02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G03">
	                                                    G03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G04">
	                                                    G04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G05">
	                                                    G05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G06">
	                                                    G06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G07">
	                                                    G07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G08">
	                                                    G08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G09">
	                                                    G09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G10">
	                                                    G10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G11">
	                                                    G11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G12">
	                                                    G12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G13">
	                                                    G13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G14">
	                                                    G14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G15">
	                                                    G15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="H01">
	                                                    H01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H02">
	                                                    H02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H03">
	                                                    H03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H04">
	                                                    H04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H05">
	                                                    H05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H06">
	                                                    H06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H07">
	                                                    H07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H08">
	                                                    H08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H09">
	                                                    H09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H10">
	                                                    H10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H11">
	                                                    H11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H12">
	                                                    H12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H13">
	                                                    H13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H14">
	                                                    H14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H15">
	                                                    H15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="I01">
	                                                    I01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I02">
	                                                    I02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I03">
	                                                    I03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I04">
	                                                    I04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I05">
	                                                    I05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I06">
	                                                    I06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I07">
	                                                    I07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I08">
	                                                    I08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I09">
	                                                    I09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I10">
	                                                    I10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I11">
	                                                    I11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I12">
	                                                    I12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I13">
	                                                    I13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I14">
	                                                    I14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I15">
	                                                    I15
	                                                </div>
	                                            </div>
	                                            <!-- //horizon_seat_list 는 스크린기준 가운데에 위치한 좌석 -->
	
	                                        </div>
	                                        <div class="side_seat_list_con right">
	
	                                            <!-- vertical_seat_list 는 스크린기준 왼쪽과 오른쪽에 위치한 좌석 -->
	                                            <div class="vertical_seat_list second_floor">
	                                                <div class="seat_item" data-sit-id="J13">
	                                                    J13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J14">
	                                                    J14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J15">
	                                                    J15
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J16">
	                                                    J16
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J17">
	                                                    J17
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J18">
	                                                    J18
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J19">
	                                                    J19
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J20">
	                                                    J20
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J21">
	                                                    J21
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J22">
	                                                    J22
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J23">
	                                                    J23
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J24">
	                                                    J24
	                                                </div>
	                                            </div>
	                                            <div class="vertical_seat_list third_floor">
	                                                <div class="seat_item" data-sit-id="K21">
	                                                    K21
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K22">
	                                                    K22
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K23">
	                                                    K23
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K24">
	                                                    K24
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K25">
	                                                    K25
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K26">
	                                                    K26
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K27">
	                                                    K27
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K28">
	                                                    K28
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K29">
	                                                    K29
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K30">
	                                                    K30
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K31">
	                                                    K31
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K32">
	                                                    K32
	                                                </div>
	                                            </div>
	                                            <!-- //vertical_seat_list 는 스크린기준 왼쪽과 오른쪽에 위치한 좌석 -->
	
	                                        </div>
	                                    </div>
	                                    <!-- //movie_seat_top_list 는 콘트롤부스를 제외한 좌석들 -->
	
	                                    <!-- movie_seat_bottom_list 는 콘트롤부스 라인 -->
	                                    <div class="movie_seat_bottom_list">
	                                        <div class="side_seat_list_con left">
	                                            <div class="movie_door_icon">
	                                                <img src="/edu/images/bm/movie_enter_icon.png" alt="입구">
	                                            </div>
	                                        </div>
	                                        <div class="center_seat_list_con">
	
	                                            <!-- horizon_seat_list 는 스크린기준 가운데에 위치한 좌석 -->
	                                            <div class="horizon_seat_list second_floor">
	                                                <div class="movie_control_room control_room_top">
	                                                    콘트롤부스
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list third_floor">
	                                                <div class="seat_item disabled_seat" data-sit-id="Z01">
	                                                    <img src="/edu/images/bm/disabled_seat_img.png" alt="휠체어석">
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K13">
	                                                    K13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K14">
	                                                    K14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K15">
	                                                    K15
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K16">
	                                                    K16
	                                                </div>
	                                                <div class="movie_control_room control_room_bottom">
	                                                    콘트롤룸
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K17">
	                                                    K17
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K18">
	                                                    K18
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K19">
	                                                    K19
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K20">
	                                                    K20
	                                                </div>
	                                                <div class="seat_item disabled_seat" data-sit-id="Z02">
	                                                    <img src="/edu/images/bm/disabled_seat_img.png" alt="휠체어석">
	                                                </div>
	                                            </div>
	                                            <!-- //horizon_seat_list 는 스크린기준 가운데에 위치한 좌석 -->
	
	                                        </div>
	                                        <div class="side_seat_list_con right">
	
	                                            <div class="movie_door_icon">
	                                                <img src="/edu/images/bm/movie_exit_icon.png" alt="입구">
	                                            </div>
	
	                                        </div>
	                                    </div>
	                                    <!-- //movie_seat_bottom_list 는 콘트롤부스 라인 -->
	
	                                </div>
	                            </div>
	                        </div>
	                        <div class="movie_seat_info_con">
	                            <div class="movie_seat_info_list">
	                                <div class="movie_seat_color_box select"></div>
	                                <div class="movie_seat_info_text">선택</div>
	                            </div>
	                            <div class="movie_seat_info_list">
	                                <div class="movie_seat_color_box"></div>
	                                <div class="movie_seat_info_text">선택가능</div>
	                            </div>
	                            <div class="movie_seat_info_list">
	                                <div class="movie_seat_color_box selected"></div>
	                                <div class="movie_seat_info_text">예매완료</div>
	                            </div>
	                            <div class="movie_seat_info_list">
	                                <div class="movie_seat_color_box second_floor"></div>
	                                <div class="movie_seat_info_text">2F</div>
	                            </div>
	                            <div class="movie_seat_info_list">
	                                <div class="movie_seat_color_box third_floor"></div>
	                                <div class="movie_seat_info_text">3F</div>
	                            </div>
	                            <div class="movie_seat_info_list">
	                                <div class="movie_seat_color_box disabled_floor"></div>
	                                <div class="movie_seat_info_text">휠체어석</div>
	                            </div>
	                        </div>
	                        <ul class="mb25 list_style_2">
	                            <li>좌석입력확인</li>
	                        </ul>
	                        <div class="my_selected_movie_seat_check">
	                            <div class="selected_movie_seat_item">
	                                R13
	                            </div>
	                            <div class="selected_movie_seat_item_comma">
	                                ,
	                            </div>
	                            <div class="selected_movie_seat_item">
	                                R14
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="popup_util_btn_con">
	                    <a href="javascript:void(0)" class="popup_util_btn_style" id="confirmBtn">
	                        선택좌석입력
	                    </a>
	                </div>
	            </div>
	        </div>
	    </div>
	    <div class="col-12 popup_dim"></div>
	</div>
