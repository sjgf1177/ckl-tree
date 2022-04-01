<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<c:set var="registerFlag" value="${empty authorManageVO.authorCode ? 'INSERT' : 'UPDATE'}"/>
<c:set var="registerFlagName" value="${empty authorManageVO.authorCode ? '권한 등록' : '권한 수정'}"/>

<script type="text/javaScript" language="javascript">

function fncSelectAuthorList() {
	var varFrom = document.getElementById("authorManage");
	varFrom.action = "<c:url value='/bos/cmm/sec/ram/AuthorList.do?menuNo=${param.menuNo}'/>";
	varFrom.submit();
}

function fncAuthorInsert() {

    var varFrom = document.getElementById("authorManage");
	var v = new MiyaValidator(varFrom);
    v.add("authorCode", {
        required: true
    });
    v.add("authorNm", {
        required: true
    });
	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}
	
	if(isInHangeul(varFrom.authorCode.value)){
		alert("한글은 허용하지 않습니다.");
		varFrom.authorCode.focus();
		return;
	}

	if (!confirm("저장 하시겠습니까?")) {
		return;
	}
    varFrom.action = "<c:url value='/bos/cmm/sec/ram/AuthorInsert.do?menuNo=${param.menuNo}'/>";
    varFrom.submit();
}

function fncAuthorDelete() {
	var varFrom = document.getElementById("authorManage");
	varFrom.action = "<c:url value='/bos/cmm/sec/ram/AuthorDelete.do?menuNo=${param.menuNo}'/>";
	if(confirm("삭제 하시겠습니까?")){
	    varFrom.submit();
	}
}
function isInHangeul(input_s) {
	var pattern = /[\u3131-\u314e|\u314f-\u3163|\uac00-\ud7a3]/g;
	return (pattern.test(input_s)) ? true : false;
}
</script>

<form:form commandName="authorManage" method="post" >
<c:if test="${registerFlag == 'UPDATE'}">
	<input type="hidden" name="searchCondition" value="<c:out value='${authorManageVO.searchCondition}'/>"/>
	<input type="hidden" name="searchKeyword" value="<c:out value='${authorManageVO.searchKeyword}'/>"/>
	<input type="hidden" name="pageIndex" value="<c:out value='${authorManageVO.pageIndex}'/>"/>
</c:if>
<div class="bdView">
<table>
	<caption>게시판 쓰기</caption>
	<colgroup>
		<col width="15%"/>
		<col width="85%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">권한 코드<img src="/bos/images/common/required.gif" alt="필수"  width="15" height="15"></label></th>
			<td>
				<input name="authorCode" id="authorCode" type="text" <c:if test="${registerFlag == 'UPDATE'}">readonly</c:if> value="<c:out value='${authorManage.authorCode}'/>" size="40" />&nbsp;<form:errors path="authorCode" />
			</td>
		</tr>
		<tr>
			<th scope="row">권한 명<img src="/bos/images/common/required.gif" alt="필수"  width="15" height="15"></label></th>
			<td>
				<input name="authorNm" id="authorNm" type="text" value="<c:out value='${authorManage.authorNm}'/>" required="true" fieldTitle="권한 명" maxLength="50" char="s" size="40" />&nbsp;<form:errors path="authorNm" />
			</td>
		</tr>
		<tr>
			<th scope="row">설명<img src="/bos/images/common/required.gif" alt="필수"  width="15" height="15"></label></th>
			<td>
				<input name="authorDc" id="authorDc" type="text" value="<c:out value="${authorManage.authorDc}"/>" required="true" fieldTitle="설명" maxLength="50" char="s" size="50" />
			</td>
		</tr>
	<c:if test="${not empty authorManage.authorCreatDe}">
		<tr>
			<th scope="row">등록일자<img src="/bos/images/common/required.gif" alt="필수"  width="15" height="15"></label></th>
			<td>
				<c:out value="${authorManage.authorCreatDe}"/>
			</td>
		</tr>
	</c:if>
	</tbody>
</table>
</div>
    <div align="right">
        <c:out value='${message}'/>
    </div>
</form:form>

	<div class="btn_set">
      <c:if test="${registerFlag == 'INSERT'}">
		<a class="btn btn-primary" href="javascript:fncAuthorInsert()"><span>등록</span></a>
	  </c:if>
      <c:if test="${registerFlag == 'UPDATE'}">
		<a class="btn btn-info" href="javascript:fncAuthorInsert()"><span>수정</span></a>
		<a class="btn btn-danger"  href="javascript:fncAuthorDelete()"><span>삭제</span></a>
	  </c:if>
		<a class="btn btn-primary" href="javascript:fncSelectAuthorList()"><span>목록</span></a>
	</div>

