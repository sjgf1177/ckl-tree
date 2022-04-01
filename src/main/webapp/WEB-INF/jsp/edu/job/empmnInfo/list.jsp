<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>
<%
	String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");

	request.setAttribute("keyword", java.net.URLDecoder.decode(keyword,"UTF-8"));

%>

<script type="text/javascript">
//<![CDATA[
$(function() {
	$("#empmnForm").submit(function() {
		if ($("#career2").is(":checked")) {

			if ($("#minCareerM").val() == "") {
				alert("경력 최소 개월수를 입력해 주세요.");
               	$("#minCareerM").focus();
               	return false;
			}
			else if ($("#maxCareerM").val() == "") {
				alert("경력 최대 개월수를 입력해 주세요.");
               	$("#maxCareerM").focus();
               	return false;

			}


			var re = /^[0-9]+$/;
	        if(!re.test($("#minCareerM").val())) {
               	alert("숫자값을 입력하시기 바랍니다.");
               	$("#minCareerM").val("");
               	$("#minCareerM").focus();
               	return false;
	        }
	        else if(!re.test($("#maxCareerM").val())) {
				alert("숫자값을 입력하시기 바랍니다.");
               	$("#maxCareerM").val("");
               	$("#maxCareerM").focus();
               	return false;
        	}
		}

		var regionArr = [];
		$("input[name=regionChk]:checked").each(function(n) {
			regionArr.push($(this).val());
		});
		$("#region").val(regionArr.join("|"));

		var educationArr = [];
		$("input[name=educationChk]:checked").each(function(n) {
			educationArr.push($(this).val());
		});
		$("#education").val(educationArr.join("|"));

		var careerArr = [];
		$("input[name=careerChk]:checked").each(function(n) {
			careerArr.push($(this).val());
		});
		$("#career").val(careerArr.join("|"));

		var empTpArr = [];
		$("input[name=empTpChk]:checked").each(function(n) {
			empTpArr.push($(this).val());
		});
		$("#empTp").val(empTpArr.join("|"));

        $("#keyword").val(encodeURIComponent($("#keywordStr").val()));
	});

	$("input[name=regionChk]").click(function() {
		if ($(this).val() == "00000") {
			$("input[name=regionChk]").not(this).attr("checked",false);
			$(this).attr("checked",true);
		}
		else {
			$("#region0").attr("checked",false);
		}
	});

	$("input[name=educationChk]").click(function() {
		if ($(this).val() == "") {
			$("input[name=educationChk]").not(this).attr("checked",false);
			$(this).attr("checked",true);
		}
		else {
			$("#education0").attr("checked",false);
		}
	});

	$("input[name=careerChk]").click(function() {
		if ($(this).val() == "") {
			$("input[name=careerChk]").not(this).attr("checked",false);
			$(this).attr("checked",true);
		}
		else {
			$("#career0").attr("checked",false);
		}

		if ($(this).val() == "E") {
			if ($(this).is(":checked")) {
				$("#minCareerM").removeAttr("readonly");
				$("#maxCareerM").removeAttr("readonly");
			}
			else {
				$("#minCareerM").attr("readonly",true).val("");
				$("#maxCareerM").attr("readonly",true).val("");
			}
		}

	});
});
//]]>
</script>
<%--
<div class="alert">
	<ul class="bull">
		<li>해당 채용정보는 <a href="http://www.work.go.kr" target="_blank">워크넷(www.work.go.kr - 새창이동)</a>에서 제공된 정보입니다.<br />
			(게재된 채용정보에 대해서 한국콘텐츠아카데미에서는 책임지지 않습니다.)</li>
	</ul>
</div>

	<div class="tar mb10"><a href="/edu/job/empmnPblanc/list.do?menuNo=500093" class="btn btnBlack icoDown">한국콘텐츠아카데미에서 제공되는 채용정보 바로가기</a></div>
 --%>
<div class="mt30 mb30 tac">
	<a href="http://www.work.go.kr" target="_blank" title="워크넷 바로가기(새창열림)"><img src="/edu/images/sub5/info_source.gif" alt="정보출처 : 워크넷(Worknet)  본 자료는 고용노동부 워크넷(www.work.go.kr)에서 제공된 정보이며, 무단복제 및 배포를 금지합니다." /></a>
</div>

	<!-- search Panel -->
	<div class="schPanel">
		<form action="/edu/job/empmnInfo/list.do" name="empmnForm" id="empmnForm" method="get">
			<input type="hidden" name="region" id="region" value="" />
			<input type="hidden" name="education" id="education" value="" />
			<input type="hidden" name="career" id="career" value="" />
			<input type="hidden" name="empTp" id="empTp" value="" />
			<input type="hidden" name="keyword" id="keyword" value="" />
			<input type="hidden" name="menuNo" value="<c:out value="${param.menuNo }" />" />

			<fieldset>
				<legend>채용정보 검색 입력</legend>
				<div class="mb20">
					<table class="contents_insight_view contact_us_view" summary="contact_us info search">
						<caption>채용정보 검색</caption>
						<colgroup>
							<col style="width:20%;" />
							<col />
						</colgroup>
					<tbody>
						<tr>
							<th scope="row">근무지역</th>
							<td class="labelRow3">
							    <span class="check_style_0_con">
                                    <input type="checkbox"  id="region0"  name="regionChk"  value="00000" <c:if test="${fn:indexOf(param.region, '00000') > -1 }">checked="checked"</c:if> />
                                    <label for="region0" >지역무관</label>
                                </span>
							    <c:forEach items="${COM063CodeList }" var="code" varStatus="status">
							        <span class="check_style_0_con">
                                        <input type="checkbox"  id="region${status.count }"  name="regionChk"  value="${code.code }" <c:if test="${fn:indexOf(param.region, code.code) > -1 }">checked="checked"</c:if> />
                                        <label for="region${status.count }" ><c:out value="${code.codeNm }" /></label>
                                    </span>
                                </c:forEach>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="keywordStr">검색키워드</label></th>
							<td>
							    <div class="input_style_2_con">
							        <input type="text" name="keywordStr" id="keywordStr" value="<c:out value="${keyword }" />" class="input_style_2"/>
							    </div>
                            </td>
						</tr>
						<tr>
							<th scope="row">학력</th>
							<td>
							    <span class="check_style_0_con">
                                    <input type="checkbox" name="educationChk" id="education0" value="" <c:if test="${empty param.education }">checked="checked"</c:if> />
                                    <label for="education0">전체</label>
								</span>
								<span class="check_style_0_con">
                                    <input type="checkbox" name="educationChk" id="education2" value="01" <c:if test="${fn:indexOf(param.education, '01') > -1 }">checked="checked"</c:if> />
                                    <label for="education2">초졸이하</label>
                                </span>
								<span class="check_style_0_con">
                                    <input type="checkbox" name="educationChk" id="education3" value="02" <c:if test="${fn:indexOf(param.education, '02') > -1 }">checked="checked"</c:if> />
                                    <label for="education3">중졸</label>
                                </span>
								<span class="check_style_0_con">
                                    <input type="checkbox" name="educationChk" id="education4" value="03" <c:if test="${fn:indexOf(param.education, '03') > -1 }">checked="checked"</c:if> />
                                    <label for="education4">고졸</label>
                                </span>
								<span class="check_style_0_con">
                                    <input type="checkbox" name="educationChk" id="education5" value="04" <c:if test="${fn:indexOf(param.education, '04') > -1 }">checked="checked"</c:if> />
                                    <label for="education5">대졸(2~3년)</label>
                                </span>
								<span class="check_style_0_con">
                                    <input type="checkbox" name="educationChk" id="education6" value="05" <c:if test="${fn:indexOf(param.education, '05') > -1 }">checked="checked"</c:if> />
                                    <label for="education6">대졸(4년)</label>
                                </span>
								<span class="check_style_0_con">
                                    <input type="checkbox" name="educationChk" id="education7" value="06" <c:if test="${fn:indexOf(param.education, '06') > -1 }">checked="checked"</c:if> />
                                    <label for="education7">석사</label>
                                </span>
								<span class="check_style_0_con">
                                    <input type="checkbox" name="educationChk" id="education8" value="07" <c:if test="${fn:indexOf(param.education, '07') > -1 }">checked="checked"</c:if> />
                                    <label for="education8">박사</label>
                                </span>
								<span class="check_style_0_con">
                                    <input type="checkbox" name="educationChk" id="education1" value="00" <c:if test="${fn:indexOf(param.education, '00') > -1 }">checked="checked"</c:if> />
                                    <label for="education1">학력무관</label>
                                </span>
							</td>
						</tr>
						<tr>
							<th scope="row">경력</th>
							<td>
							    <span class="check_style_0_con">
                                    <input type="checkbox" name="careerChk" id="career0" value="" <c:if test="${empty param.career }">checked="checked"</c:if> />
                                    <label for="career0">전체</label>
                                </span>
                                <span class="check_style_0_con">
                                    <input type="checkbox" name="careerChk" id="career1" value="N" <c:if test="${fn:indexOf(param.career, 'N') > -1 }">checked="checked"</c:if> />
                                    <label for="career1">신입</label>
								</span>
								<span class="check_style_0_con">
                                    <input type="checkbox" name="careerChk" id="career2" value="E" <c:if test="${fn:indexOf(param.career, 'E') > -1 }">checked="checked"</c:if> />
                                    <label for="career2">경력</label>
                                        [ <input type="text" id="minCareerM" class="input_style_3" name="minCareerM" title="경력 최소개월 수 입력" style="width:50px" value="<c:out value="${param.minCareerM }" />" <c:if test="${empty param.minCareerM }">readonly="readonly"</c:if> />개월
                                        ~
                                        <input type="text" id="maxCareerM" class="input_style_3" name="maxCareerM" title="경력 최대개월 수 입력" style="width:50px" value="<c:out value="${param.maxCareerM }" />" <c:if test="${empty param.maxCareerM }">readonly="readonly"</c:if> />개월 ]
                                </span>
                                <span class="check_style_0_con">
                                    <input type="checkbox" name="careerChk" id="career3" value="Z" <c:if test="${fn:indexOf(param.career, 'Z') > -1 }">checked="checked"</c:if> />
                                    <label for="career3">경력무관</label>
								</span>
							</td>
						</tr>
						<tr>
							<th scope="row">고용형태</th>
							<td>
							    <div class="row">
							        <span class="check_style_0_con">
                                        <input type="checkbox" name="empTpChk" id="empTp1" value="10" <c:if test="${fn:indexOf(param.empTp, '10') > -1 }">checked="checked"</c:if> />
                                        <label for="empTp1" class="col-md-4">기간의 정함이 없는 근로계약 </label>
                                    </span>
                                    <span class="check_style_0_con">
                                        <input type="checkbox" name="empTpChk" id="empTp2" value="11" <c:if test="${fn:indexOf(param.empTp, '11') > -1 }">checked="checked"</c:if> />
                                        <label for="empTp2" class="col-md-8">기간의 정함이 없는 근로계약(시간(선택)제)</label>
                                    </span>
                                    <span class="check_style_0_con">
                                        <input type="checkbox" name="empTpChk" id="empTp3" value="20" <c:if test="${fn:indexOf(param.empTp, '20') > -1 }">checked="checked"</c:if> />
                                        <label for="empTp3" class="col-md-4">기간의 정함이 있는 근로계약</label>
                                    </span>
                                    <span class="check_style_0_con">
                                        <input type="checkbox" name="empTpChk" id="empTp4" value="21" <c:if test="${fn:indexOf(param.empTp, '21') > -1 }">checked="checked"</c:if> />
                                        <label for="empTp4" class="col-md-8">기간의 정함이 있는 근로계약(시간(선택)제)</label>
                                    </span>
                                    <span class="check_style_0_con">
                                        <input type="checkbox" name="empTpChk" id="empTp5" value="4" <c:if test="${fn:indexOf(param.empTp, '4') > -1 }">checked="checked"</c:if> />
                                        <label for="empTp5" class="col-md-4">파견근로 </label>
                                    </span>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				</div>
				<div class="board_util_btn_con center"><input type="submit" value="검색" class="btn_style_0 full img_none" title="검색"/></div>
			</fieldset>
		</form>
	</div>
	<!-- //search Panel -->

    <div class="col-12 sub_board_header">
        <div class="board_title">
            <h4>총 <span class="board_count"><fmt:formatNumber value="${resultCnt }" /></span>건의 검색 결과가 있습니다.</h4>
        </div>
    </div>

	<div class="col-12 sub_board_body">
		<table class="board_type_0 small" summary="job_dictionary list" style="word-break:break-all;">
			<caption>직업사전 목록</caption>
			<colgroup>
			<col style="width:13%;" />
			<col  />
			<col style="width:13%;" />
			<col style="width:10%;" />
			<col style="width:13%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">회사명</th>
					<th scope="col">채용제목 / 근무형태 / 근무지역</th>
					<th scope="col">학력 / 경력</th>
					<th scope="col">등록일</th>
					<th scope="col">마감일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${list}" varStatus="status">
				<tr>
					<td><c:out value="${result.company }" /></td>
					<td class="tal"><a href="/edu/job/empmnInfo/view.do?wantedAuthNo=${result.wantedAuthNo }&${pageQueryString}"><c:out value="${result.title }" /> / <c:out value="${result.holidayTpNm }" />  / <c:out value="${result.region }" /></a></td>
					<td>
						<span class="db"><c:out value="${result.minEdubg }" /></span>
						<span class="db"><c:out value="${result.career }" /></span>
					</td>
					<td><c:out value="${result.regDt }" /></td>
					<td><span class="db"><c:out value="${fn:replace(result.closeDt,'채용시까지','채용시까지<br/>') }" escapeXml="false" /></span></td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(list) == 0}" >
				<tr><td colspan="5" class="text-danger">- 검색결과가 없습니다. -</td></tr>
			</c:if>
			</tbody>
		</table>
	</div>


	<!-- <div class="btnSet"><a class="btn btn-primary" href="#self"><span>등록</span></a> <a class="btn btn-default" href="#self"><span>비밀번호 초기화</span></a> <a class="btn btn-danger" href="#self"><span>삭제</span></a> <a class="btn btn-success" href="javascript:void(0);"><span>엑셀저장</span></a></div> -->


	<!-- paging -->
	<c:if test="${fn:length(list) > 0}">
		<div class="paging">${pageNav}</div>
		<!-- paging end //-->
	</c:if>
	<!-- //paging -->
	<!-- //bdList -->
