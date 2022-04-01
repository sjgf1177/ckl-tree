<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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

	function checkForm() {
		var form = document.f_regi;
		var pwdNew = form.pwdNew;
		var v = new MiyaValidator(form);
	    v.add("deptNmKor", {
	        required: true
	    });
	    v.add("deptNmEng", {
	        required: true
	    });
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (confirm("등록하시겠습니까?")) {
			form.submit();
		}

	}

</script>
</head>
<body>
<div id="content">
	<div class="hgroup">
		<h3 >사업부 등록</h3>
	</div>

<form name="f_regi" method="post" action="/bos/member/regDept.do">
	<input type=hidden name="pageQueryString" value='${pageQueryString}'>
	<div class="bdView">
		<table>
			<caption>회원가입필수정보 입력</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th tabindex="0"><larbel for="deptNmKor">사업부명</larbel></th>
					<td tabindex="0">
						<input type="text" name="deptNmKor" id="deptNmKor" value="" style="width:200px" />
					</td>
				</tr>
				<tr>
					<th tabindex="0"><larbel for="deptNmEng">영문사업부명</larbel></th>
					<td tabindex="0">
						<input type="text" name="deptNmEng" id="deptNmEng" value="" style="width:200px" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>

</form>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:checkForm();"><span>등록</span></a>
		<a class="btn btn-primary" onclick="self.close();"><span>취소</span></a>
	</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>