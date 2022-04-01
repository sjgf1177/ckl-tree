<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>회원관리</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />


<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">
<!--
var larCd = "${param.upperDeptId}";
var midCd = "${param.deptId}";
var smCd = "${param.teamId}";

$(function(){
	$("#checkAll").click(function(){
		if(this.checked) $(":checkbox").attr("checked", true);
		else $(":checkbox").attr("checked", false);
	});
	$("#larCd").change(function(){
		var larCd = $("#larCd option:selected").val();
		getMidCodeList(larCd);
	});
	$("#midCd").change(function(){
		var midCd = $("#midCd option:selected").val();
		getSmCodeList(midCd);
	});

	getLarCodeList();
	getMidCodeList(larCd);
	getSmCodeList(midCd);
});

function getLarCodeList(){
	$.getJSON(
			"/bos/deptPop/selectDeptList.json",
			{deptDepth : "1"},
			function(data)
			{
	        	$('#larCd').children().remove().end().append('<option selected="selected" value="">--소속국선택</option>') ;
				var jdata = data.resultList;
	            $.each(jdata, function(index, itemData) {
						if( itemData.deptId == larCd )
			            	$("#larCd").append("<option value='"+itemData.deptId+"' selected='selected'>"+itemData.deptName+"</option>");
						else
			            	$("#larCd").append("<option value='"+itemData.deptId+"'>"+itemData.deptName+"</option>");
	            });
			}
		);
}

function getMidCodeList(larCd){
	if( !larCd ) return;
	$.getJSON(
			"/bos/deptPop/findDeptList.json",
			{upperDeptId : larCd},
			function(data)
			{
	        	$('#midCd').children().remove().end().append('<option selected="selected" value="">--소속과선택</option>') ;
				var jdata = data.resultList;
				if( jdata.length > 0 ){
		            $.each(jdata, function(index, itemData) {
						if( itemData.deptId == midCd )
			            	$("#midCd").append("<option value='"+itemData.deptId+"' selected='selected'>"+itemData.deptName+"</option>");
						else
			            	$("#midCd").append("<option value='"+itemData.deptId+"'>"+itemData.deptName+"</option>");
		            });
				}
				else{
					$("#midCdTr").hide();
					getSmCodeList(larCd);
				}
			}
		);
}

function getSmCodeList(midCd){
	if( !midCd ) return;
	$.getJSON(
			"/bos/deptPop/findTeamList.json",
			{upperDeptId : midCd},
			function(data)
			{
	        	$('#smCd').children().remove().end().append('<option selected="selected" value="">--소속팀선택</option>') ;
				var jdata = data.resultList;
	            $.each(jdata, function(index, itemData) {
					if( itemData.deptId == smCd )
						$("#smCd").append("<option value='"+itemData.deptId+"' selected='selected'>"+itemData.deptName+"</option>");
					else
						$("#smCd").append("<option value='"+itemData.deptId+"'>"+itemData.deptName+"</option>");
	            });
			}
		);
}
function checkForm(form) {
	var v = new MiyaValidator(form);
    v.add("searchType", {
        required: true
    });
    v.add("searchTxt", {
        required: true
    });
	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return false;
	}
	else
	{
		return true;
	}
}

//-->
</script>
</head>
<body>

<form method="post" name="frm" action="/bos/member/list.do?programId=adminMember">
	<div id="content">
		<div class="hgroup">
			<h3>관리자관리</h3>
		</div>

		<!-- 게시판 게시물검색 start -->

		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<select id="larCd" name="upperDeptId" title="소속국선택" style="width:150px">
				   <option value=''>--소속국선택</option>
				</select>
				<select id="midCd" name="deptId" title="소속과선택" style="width:150px">
				   <option value=''>--소속과선택</option>
				</select>
				<select id="smCd" name="teamId" title="소속팀선택" style="width:150px">
				   <option value=''>--소속팀선택</option>
				</select>

				<select id="delState" name="delState" title="사용여부" style="width:150px">
				   <option value=''>--사용여부선택</option>
					<option value="1" <c:if test="${'1' eq param.delState}">selected="selected"</c:if>>사용</option>
					<option value="0" <c:if test="${'0' eq param.delState}">selected="selected"</c:if>>미사용</option>
				</select>

				<select id="printYn" name="printYn" title="표시여부" style="width:150px">
				   <option value=''>--표시여부선택</option>
					<option value="Y" <c:if test="${'Y' eq param.printYn}">selected="selected"</c:if>>표시</option>
					<option value="N" <c:if test="${'N' eq param.printYn}">selected="selected"</c:if>>미표시</option>
				</select>
		</div>
		<div class="sh">
			<legend>게시판 게시물검색</legend>
				<%-- <span class="search_tit"><label for="authorCode" class="blind">권한</label></span>
				<select id="authorCode" name="authorCode" title="검색조건">
					<option value="">권한선택</option>
				<c:forEach var="authorManage" items="${authorManageList}" varStatus="status">
					<option value="${authorManage.authorCode}" <c:if test="${param.authorCode == authorManage.authorCode}">selected="selected"</c:if>>${authorManage.authorNm}</option>
				</c:forEach>
				</select> --%>
				<select id="stributary" name="searchCnd" title="검색조건">
				   <option value="4" <c:if test="${param.searchCnd == '4'}">selected="selected"</c:if> >이름</option>
				   <option value="1" <c:if test="${param.searchCnd == '1'}">selected="selected"</c:if> >아이디</option>
				</select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchWrd" value="${param.searchWrd}" />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
			</fieldset>
		</div>
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="10%" />
				<col width="10%" />
				<col width="12%" />
				<col width="12%" />
				<col width="12%" />
				<col width="*" />
				<col width="9%" />
				<col width="9%" />
				<col width="9%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="fir">번호</th>
					<th scope="col">아이디</th>
					<th scope="col">이름</th>
					<th scope="col">소속국</th>
					<th scope="col">소속과</th>
					<th scope="col">소속팀</th>
					<th scope="col">정렬순서</th>
					<th scope="col">비밀번호</th>
					<th scope="col">사용여부</th>
					<th scope="col">표시여부</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${fn:length(resultList) > 0}" >
			<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">
				<tr>
					<td>${resultCnt - zvl.pageSize * (zvl.pageIndex-1)}</td>
					<td class="tal">
				<c:url var="url" value="/bos/member/forUpdate.do?userId=${resultList[x].userId}&${pageQueryString}" />
				<a href="${url}">${resultList[x].userId}</a>
					</td>
					<td>${resultList[x].userName}</td>
					<td>${resultList[x].gookName} </td>
					<td>${resultList[x].gwaName} </td>
					<td>${resultList[x].teamName} </td>
					<td>${resultList[x].adminRank}</td>

				<c:url var="url" value="/bos/member/pwdReset/${resultList[x].userId}.do">
					<c:param name="programId" value="${param.programId}" ></c:param>
					<c:param name="searchType" value="${param.searchType}" ></c:param>
					<c:param name="searchTxt" value="${param.searchTxt}" ></c:param>
					<c:param name="pageIndex" value="${empty param.pageIndex ? '1' : param.pageIndex}" ></c:param>
				</c:url>
					<td><a href="${url}" >[초기화]</a></td>
					<td>
						${resultList[x].delState eq '1' ? '사용' : '미사용'}
					</td>
					<td>
						${resultList[x].printYn eq 'Y' ? '표시' : '미표시'}
					</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			</c:if>
			<c:choose>
				<c:when test="${param.flag == 1}"><tr><td colspan="7">검색버튼을 눌러주세요</td></tr></c:when>
				<c:otherwise>
					<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="10">데이터가 없습니다.</td></tr></c:if>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

	<div class="btn_set">
		<a class="btn btn-primary" href="/bos/member/forInsert.do?${pageQueryString}"><span>등록</span></a>
	</div>

	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>
</div>

</form>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>
