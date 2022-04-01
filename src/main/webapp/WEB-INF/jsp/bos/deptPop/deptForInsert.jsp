
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.deptPop.service.DeptMngProgramService" var="DeptMngProgramService"/>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/deptPop/deptMng/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/deptPop/deptMng/update.do" />
</c:if>

<sec:authorize ifAnyGranted="ROLE_SUPER">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>
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

function deptInsert()
{

	var f = document.frmtu;
	var v = new MiyaValidator(f);
	v.add("upperDeptId", {
        required : true
    });
	v.add("deptName", {
        required : true
    });
	v.add("useYn", {
        required : true
    });
	v.add("deptRank", {
        required : true,
        pattern: "^[0-9]{1,12}$",
        message: "0보다 큰 숫자만 입력가능합니다."
    });
    var result = v.validate();
    if (!result) {
        alert(v.getErrorMessage());
        v.getErrorElement().focus();
		return;
    }

   	if( $("#deptRank").val() < 1 ){
   		alert("0보다 큰 숫자만 입력가능합니다.");
   		$("#deptRank")[0].focus();
   		return;
   	}

	if (!confirm('등록하시겠습니까?')) {
		return;
	}

    f.submit();
    //벨리데이션체크할것
}

</script>
</head>
<body>
	<div id="content">
		<div class="hgroup">
			<h3>부서정보 입력</h3>
		</div>
			<form name="frmtu" method="post" enctype="multipart/form-data" action="${action}">
				<input type="hidden" name="programId" value="deptMng" />
				<input type="hidden" name="deptId" value="${param.deptId}" />
			<div class="bdView">
				<table>
						<caption>팀정보 입력</caption>
						<colgroup>
							<col width="15%"/>
							<col width="85%"/>
						</colgroup>
						<tbody>
						<tr>
							<th scope="row"><label for="upperDeptId">상위부서선택</label></th>
							<td>
								<select id="upperDeptId" name="upperDeptId" title="검색조건">
								   <option value=''>--상위부서선택--</option>
								   <option value='${DeptMngProgramService.ROOT_DEPT_ID}' <c:if test="${DeptMngProgramService.ROOT_DEPT_ID == result.upperDeptId}">selected="selected"</c:if>><spring:message code='site.korName' text=''/></option>
								<c:forEach var="dept" items="${deptList}" varStatus="status">
								<option value="${dept.deptId}" <c:if test="${dept.deptId == result.upperDeptId}">selected="selected"</c:if>>- ${dept.deptName2}</option>
								</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">부서명</th>
							<td class="output">
							<input type="text" id="deptName" name="deptName" class="board1" value="${result.deptName}" style="width:125px"/>
							</td>
						</tr>
						<tr>
							<th scope="row">부서업무</th>
							<td class="output">
							<textarea id="deptInfo" name="deptInfo" class="textarea" cols="35" rows="7"  style="width:620px;">${result.deptInfo}</textarea>
							</td>
						</tr>
						<tr>
							<th scope="row">표시여부</th>
							<td class="output">
				    			<select id="useYn" name="useYn" title="검색조건">
									<option value="Y" ${result.useYn eq 'Y' ? 'selected="selected"' : ''}>표시</option>
									<option value="N" ${result.useYn eq 'N' ? 'selected="selected"' : ''}>표시안함</option>
								</select>
				    		</td>
						</tr>
						<tr>
							<th scope="row">정렬순서</th>
							<td class="output">
							<input type="text" id="deptRank" name="deptRank" class="board1" value="${empty result ? '1' : result.deptRank}" style="width:50px"/>(0보다큰 숫자로만 입력)</td>
						</tr>
						</tbody>
					</table>
				</div>
				</form>
				<div class="btn_set">
					<a href="#" onClick="deptInsert()"  class="btn btn-primary">등록</a>
				<c:if test="${not empty result}">
		<a class="btn btn-danger" href="/bos/deptPop/deptMng/delete.do?programId=${param.programId}&deptId=${param.deptId}" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
				</c:if>
					<a class="btn btn-primary"><a href="/bos/deptPop/deptMng/list.do?${pageQueryString}">목록</a></span>
				</div>


		</div>
	</body>
</html>

<br/>
<input type="text" name="" value="/WebContent${pageContext.request.requestURI}" class="input_txt file_socueurl" style="color:red;width:100%"/>