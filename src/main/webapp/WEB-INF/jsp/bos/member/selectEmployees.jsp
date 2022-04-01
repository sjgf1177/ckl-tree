<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />


<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">
$(function(){

	$("#checkAll").click(function(){
		if(this.checked)
			$("input[id^=chk]").attr("checked", true);
		else
			$("input[id^=chk]").attr("checked", false);
	});

	$("#btn").click(function(){
		if($(":checked").length == 0)
		{
			alert("발송리스트추가할 항목을 선택하세요.");
			return;
		}
		var f = $("#mailListFrm")[0];
		var groupidVal = "";
		var eMailVal = "";
		var eNameVal = "";
		var hpNoVal = "";
		var groupNameVal = "";
		$("input[id^=chk]").each(function(index){
			if(this.checked){
				var idx = index+1;
				groupidVal += $("#groupid"+idx).val() + "|";
				eMailVal += $("#eMail"+idx).val() + "|";
				eNameVal += $("#eName"+idx).val() + "|";
				hpNoVal += $("#hpNo"+idx).val() + "|";
				groupNameVal += $("#groupName"+idx).val() + "|";
			}
		});
		groupidVal = groupidVal.substring(0,groupidVal.length-1);
		eMailVal = eMailVal.substring(0,eMailVal.length-1);
		eMailVal = eMailVal.substring(0,eMailVal.length-1);
		eNameVal = eNameVal.substring(0,eNameVal.length-1);
		hpNoVal = hpNoVal.substring(0,hpNoVal.length-1);
		groupNameVal = groupNameVal.substring(0,groupNameVal.length-1);
		$("#groupid").val(groupidVal);
		$("#eMail").val(eMailVal);
		$("#eName").val(eNameVal);
		$("#hpNo").val(hpNoVal);
		$("#groupName").val(groupNameVal);

		f.submit();
	});

});

function search() {
	var form = $("#searchFrm")[0];
	var v = new MiyaValidator(form);
    v.add("searchTxt", {
        required: true
    });
	result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	form.submit();
}

</script>
</head>
<title>발송리스트관리</title>
</head>
<body>

<div id="content">
	<div class="hgroup">
		<h3 >발송리스트관리</h3>
	</div>

	<form id="searchFrm" action="/bos/portal/poll/send/webMailList.do" method="post">
		<input type="hidden" name="masterCd" value="${param.masterCd}"/>
		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchTxt" value="${param.searchTxt}" />
				</label>
				<label for="input2">
					<a href="javascript:search();" class="btn btn-seach">검색</a>
				</label>
			</fieldset>
		</div>
	</form>
<!-- 게시판 게시물검색 end -->

	<form id="mailListFrm" action="/bos/portal/poll/send/addPollMail.do" method="post">
		<input type="hidden" name="masterCd" value="${param.masterCd}"/>
		<input type="hidden" id="groupid" name="groupid" value=""/>
		<input type="hidden" id="eMail" name="eMail" value=""/>
		<input type="hidden" id="eName" name="eName" value=""/>
		<input type="hidden" id="hpNo" name="hpNo" value=""/>
		<input type="hidden" id="groupName" name="groupName" value=""/>
		<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>발송리스트</caption>
			<colgroup>
				<col width="8%" />
				<col width="12%" />
				<col width="20%" />
				<col width="20%" />
				<col width="20%" />
				<col width="20%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">부서</th>
					<th scope="col">사번</th>
					<th scope="col">이름</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${resultList}" var="result" varStatus="status">
				<tr>
					<td>
						${item.groupid}<input id="groupid${status.count}" name="_groupid" type="hidden" value="${item.groupid}" />
					</td>
					<td>
						${item.eMail}<input id="eMail${status.count}" name="_eMail" type="hidden" value="${item.eMail}" />
					</td>
					<td>
						${item.eName}<input id="eName${status.count}" name="_eName" type="hidden" value="${item.eName}" />
					</td>
					<td>
						${item.hpNo}<input id="hpNo${status.count}" name="_hpNo" type="hidden" value="${item.hpNo}" />
					</td>
					<td>
						${item.groupName}<input id="groupName${status.count}" name="_groupName" type="hidden" value="${item.groupName}" />
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(mailList) == 0}">
				<tr><td colspan="6">&nbsp;</td></tr>
			</c:if>
			</tbody>
		</table>
		</div>
	</form>

	<div class="btn_set">
		<a class="btn btn-primary" id="btn" href="#btn"><span>발송리스트에추가</span></a>
		<a class="btn btn-primary" href="#btn" onclick="window.close();event.returnValue=false;"><span>닫기</span></a>
	</div>

</div>
</body>
</html>