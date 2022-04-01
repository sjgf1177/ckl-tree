<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>부서장 관리(구청장에게 바란다)</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/cross/js/namo_scripteditor.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/bos/pb/js/jquery.form.js"></script>
<script type="text/javascript" src="/bos/pb/js/pb.js"></script>
<script type="text/javascript">

</script>
<script type="text/javascript">

	$(function(){

		var link = "/bos/member/mayorYnMemberList.do?programId=adminMember";

		$("#assignDeptY").click(function(){

			//var deptId = $("#deptId option:selected").val();
			var userId = $("#option2 option:selected").val();
			$.post(
					"/bos/member/updateMayorYn.json",
					{userId : userId, mayorYn : 'Y'},
					function(data)
					{
						var resultCode = data.resultCode;
						var resultMsg = data.msg;
						alert(resultMsg);
						if(resultCode == "success") location.href = link;
					}
				);
		});


		$("#deptNo").change(function(){
			getKwaCodeList();
		});

 		$("#deptId").change(function(){
			getDamCodeList();
		});

	});

	function getKwaCodeList(deptNo){
		var deptNo = $("#deptNo option:selected").val();
		$.getJSON(
				"/bos/member/getDeptKwaList.do",
				{deptNo : deptNo, lv : 2, viewType : "JSON"},
				function(data)
				{
		        	$('#deptId').children().remove().end().append('<option selected value="">--과선택</option>') ;
					var jdata = data.deptKwaList;
		            $.each(jdata, function(index, itemData) {
		            	$("#deptId").append("<option value='"+itemData.deptId+"'>"+itemData.deptName+"</option>");
		            });
				}
			);
	}

	function getDamCodeList(option30){
		var deptNo = $("#deptNo option:selected").val();
		var option30 = $("#deptId").find('option:selected').val();
		$.getJSON(
				"/bos/member/getDeptDamList.do",
				{deptNo : deptNo, option30 : option30, viewType : "JSON"},
				function(data)
				{
		        	$('#option2').children().remove().end().append('<option selected value="">--담당자선택</option>') ;
					var jdata = data.deptDamList;
		            $.each(jdata, function(index, itemData) {
		            	$("#option2").append("<option value='"+itemData.option2+"'>"+itemData.adminNm+"</option>");
		            });
				}
			);
	}

	function checkAssignDept() {
		var form = document.receiptFrm;
		var v = new MiyaValidator(form);
	    v.add("deptNo", {
	        required: true
	    });
	    v.add("deptId", {
	        required: true
	    });
	    v.add("option2", {
	        required: true
	    });

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return false;
		}
		return true;
	}

	function delCmmnt(userId){
		var link = "/bos/member/mayorYnMemberList.do?programId=adminMember";

		$.post(
			"/bos/member/updateMayorYn.json",
			{userId : userId, mayorYn : 'N'},
			function(data)
			{
				var resultCode = data.resultCode;
				var resultMsg = data.msg;
				alert(resultMsg);
				if(resultCode == "success") location.href = link;
			}
		);
	}

</script>
</head>
<body>

	<div id="content">
		<div class="hgroup">
			<h3>부서담당관리(구청장에게 바란다)</h3>
		</div>

	<form method="post" name="frm" action="/bos/member/mayorYnMemberList.do?programId=adminMember">
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<select id="deptId2" name="deptId" title="소속과선택" style="width:150px">
				   <option value=''>--소속과선택</option>
					<c:forEach var="sm" items="${deptList2}" varStatus="status">
					<option value="${sm.deptId}" <c:if test="${sm.deptId eq param.deptId}">selected="selected"</c:if>>${sm.deptName2}</option>
					</c:forEach>
				</select>
				<select id="stributary" name="searchCnd" title="검색조건">
				   <option value="4" <c:if test="${param.searchCnd == '4'}">selected="selected"</c:if> >이름</option>
				</select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchWrd" value="${param.searchWrd}" />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
			</fieldset>
		</div>
	</form>
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="12%" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="8%" />
				<col width="*" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="fir">번호</th>
					<th scope="col">이름</th>
					<th scope="col">소속국</th>
					<th scope="col">소속과</th>
					<th scope="col">소속팀</th>
					<th scope="col">직급</th>
					<th scope="col">전화번호</th>
					<th scope="col">해제</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${fn:length(resultList) > 0}" >
			<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">
				<tr>
					<td>${resultCnt - zvl.pageSize * (zvl.pageIndex-1)}</td>
					<td>${resultList[x].userName}</td>
					<td>${resultList[x].gookName}</td>
					<td>${resultList[x].gwaName}</td>
					<td>${resultList[x].teamName}</td>
					<td>${resultList[x].staffOffice}</td>
					<td>${resultList[x].userPhone}</td>
					<td><a id="deleteIcon_${resultList[x].userId}" href="javascript:delCmmnt('${resultList[x].userId}')"  class="btn btn-primary" onclick="return confirm('정말로 삭제하시겠습니까?');">해제</a></td>

				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			</c:if>
			<c:choose>
				<c:when test="${param.flag == 1}"><tr><td colspan="6">검색버튼을 눌러주세요</td></tr></c:when>
				<c:otherwise>
					<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="6">데이터가 없습니다.</td></tr></c:if>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>
<br /><br />
<form id="receiptFrm" name="receiptFrm" method="post" action="#" >
<input type="hidden" name="userId" id="userId" value=""/>
	<h3 class="tit_03">부서담당 지정하기</h3>
	<div id="test"></div>
	<div class="bdView">
	<table>
		<colgroup>
			<col width="15%"/>
			<col width="85%"/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><label for="type">담당부서</label></th>
				<td colspan="3">
					<select id="deptNo" name="deptNo" title="국선택">
					   <option value=''>--국선택</option>
						<c:forEach var="kook" items="${deptList}" varStatus="status">
						<option value="${kook.deptId}" >${kook.deptName}</option>
						</c:forEach>
					</select>
					<select id="deptId" name="deptId" title="과선택" style="width:150px">
					   <option value=''>--과선택</option>
						<c:forEach var="kwa" items="${deptKwaList}" varStatus="status">
						<option value="${kwa.deptId}" >${kwa.deptName}</option>
						</c:forEach>
					</select>
					<select id="option2" name="userId" title="담당자선택" style="width:150px">
					   <option value=''>--담당자선택</option>
						<c:forEach var="dam" items="${deptDamList}" varStatus="status">
						<option value="${dam.option2}" >${dam.adminNm}</option>
						</c:forEach>
					</select>
					<span class="button sky"><a id="assignDeptY" href="javascript:void(0)">부서담당 지정하기</a></span>
					<br />
				</td>
			</tr>
		</tbody>
	</table>
</div>


</form>
</div>

<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>
