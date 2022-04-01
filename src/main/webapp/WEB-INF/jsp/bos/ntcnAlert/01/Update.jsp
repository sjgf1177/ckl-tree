<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript">
$(function() {
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#pub_sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#pub_edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
});
function checkAndSubmit() {

	var form = $("#fm")[0];
	var v = new MiyaValidator(form);
	var regFlag = "${empty result ? 'Y' : 'N'}";
    v.add("ntcnNm", {
		required: true
    });
	if(regFlag == "Y"){
	    v.add("file1", {
			required: true
	    });
	}
    v.add("ntcnUrl", {
    	required: true
    });
    v.add("bgnde", {
    	required: true
    });
    v.add("endde", {
    	required: true
    });
    v.add("sortOrdr", {
    	required: true
    });

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	if (confirm('등록하시겠습니까?')) {
		form.submit();
	}
}

function check_txt(value) {
    if (isNaN(value)) {
		alert("숫자로만 입력하셔야 합니다.");
		return "";
	}
    else {
    	return value;
    }
}

</script>

<c:set var="action" value="${empty result ? '/bos/ntcnAlert/insert.do' : '/bos/ntcnAlert/update.do'}" />
<form id="fm" name="fm" method="post" action="${action}" enctype="multipart/form-data">
	<input type="hidden" id="menuNo" name="menuNo" value="${param.menuNo}" />
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}" />
	<input type="hidden" name="type" value="01" />
	<input type="hidden" name="siteId" value="${param.siteId}" />
	<c:if test="${not empty result}">
		<input type="hidden" name="ntcnNo" value="${result.ntcnNo}" />
	</c:if>

<div class="bdView">
<table>
	<caption>팝업존관리 수정/등록</caption>
	<colgroup>
		<col width="15%"/>
		<col width="85%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="nttCn">타이틀</label></th>
			<td class="output">
			<textarea rows="5" cols="120" id="nttCn" name="nttCn"><c:out value="${result.nttCn}" escapeXml="false"/></textarea>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="ntcnNm">대체텍스트</label></th>
			<td class="output">
				<input type="text" id="ntcnNm" name="ntcnNm" value="${result.ntcnNm}" style="width: 600px" class="board1" />
			</td>
		</tr>
		<tr id="trImg">
			<th scope="row"><label for="file1">웹 이미지</label></th>
			<td class="output">
				<c:import url="/bos/cmm/fms/fileList.do">
					<c:param name="listType" value="img"/>
					<c:param name="updateFlag" value="Y"/>
				</c:import>
				<input id="file1" name="file1" type="file" title="첨부파일1" class="board1" size="50" style="width:90%" />
				<br/>
				이미지 권장사이즈 : 350 * 300<br/>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="ntcnUrl">링크 URL</label></th>
			<td class="output">
				<input type="text" id="ntcnUrl" name="ntcnUrl" value="${result.ntcnUrl}" style="width: 600px" class="board1" />
			</td>
		</tr>

		<tr>
			<th scope="row">노출 기간</th>
			<td colspan="3" class="output">
				<input type="text" id="bgnde" name="bgnde" title="노출시작일"value="<fmt:formatDate value="${result.bgnde}" pattern="yyyy-MM-dd"/>" class="sdate"/>
    			~
				<input type="text" id="endde" name="endde" title="노출종료일"value="<fmt:formatDate value="${result.endde}" pattern="yyyy-MM-dd"/>" class="edate"/>
			</td>
		</tr>

		<tr>
			<th scope="row">링크 방식</th>
			<td class="output">
				<label for="popupAtY">
					<input type="radio" id="popupAtY" name="popupAt" value="Y" class="ra" title="링크방식" <c:if test="${empty result or result.popupAt == 'Y'}">checked</c:if> /> 새창 (Y)
				</label>
				<label for="popupAtN">
					<input type="radio" id="popupAtN" name="popupAt" value="N" class="ra" <c:if test="${result.popupAt == 'N'}">checked</c:if> /> 현재창 (N)
				</label>
			</td>
		</tr>

		<tr>
			<th scope="row">사용 여부</th>
			<td class="output">
				<label for="useAtY">
					<input type="radio" id="useAtY" name="useAt" value="Y" class="ra" title="사용여부"<c:if test="${empty result or result.useAt == 'Y'}">checked</c:if> /> 사용 (Y)
				</label>
				<label for="useAtN">
					<input type="radio" id="useAtN" name="useAt" value="N" class="ra" <c:if test="${result.useAt == 'N'}">checked</c:if> /> 미사용 (N)
				</label>
			</td>
		</tr>

		<tr>
			<th scope="row"><label for="sortOrdr">노출 순서</label></th>
			<td>
				<input type="text" id="sortOrdr" name="sortOrdr" style="width: 250px" class="board1" value="${result.sortOrdr}" onkeyup="this.value=check_txt(this.value)"/>
			</td>
		</tr>
	</tbody>
</table>
</div>
</form>

	<div class="btn_set">
	<c:choose>
	<c:when test="${empty result}" >
		<a class="btn btn-primary" href="javascript:checkAndSubmit();"><span>등록</span></a>
	</c:when>
	<c:otherwise>
		<a class="btn btn-info" href="javascript:checkAndSubmit();"><span>수정</span></a>
		<c:url value="/bos/ntcnAlert/delete.do?ntcnNo=${result.ntcnNo}&${pageQueryString}" var="del_url" />
		<a class="btn btn-danger"  href="${del_url}" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:otherwise>
	</c:choose>
		<c:url value="/bos/ntcnAlert/list.do?${pageQueryString}" var="list_url" />
		<a class="btn btn-primary" href="${list_url}"><span>목록</span></a>
	</div>

