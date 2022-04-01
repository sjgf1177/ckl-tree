
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/bbs/${paramVO.bbsId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/bbs/${paramVO.bbsId}/update.do" />
</c:if>
<sec:authorize ifAnyGranted="ROLE_SUPER">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>

<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>

<script type="text/javascript">

	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);
	    v.add("ntcrNm", {
	        required: true
	    });
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (CrossEditor.GetBodyValue() == "") {
			alert('내용을 입력해 주세요.');
		    CrossEditor.SetFocusEditor(); // 크로스에디터 Focus 이동
		    return;
		}
		if (!confirm("${empty result ? '등록' : '수정'}하시겠습니까?")) {
			return;
		}

		var cont = CrossEditor.GetBodyValue();
		document.getElementById("nttCn").value= cont;

		form.submit();
	}

</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
</head>

<div id="content">

<h3 id="answerH3" class="tit_03">답변 ${empty result ? '등록' : '수정'}</h3>
<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="replyAt" value="Y" />
	<input type="hidden" name="parnts" value="<c:out value='${paramVO.parnts}'/>" />
	<input type="hidden" name="replyLc" value="<c:out value='${paramVO.replyLc}'/>" />

	<div class="bdView">
		<table>
			<caption>${masterVO.bbsNm} - 쓰기</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>

				<tr>
					<th scope="row"><label for="ntcrNm">담당자</label></th>
					<td>
						<input type="text" name="ntcrNm" id="ntcrNm" class="input_txt wi100per" value="${empty result.ntcrNm ? user.userNm : result.ntcrNm}" />
					</td>
				</tr>

				<tr>
					<th scope="row" class="con_tit"><label for="nttCn1">내용</label></th>
					<td class="outputEditor">
						<textarea id="nttCn" name="nttCn" cols="150" rows="30" style="display:none;" class="textarea">${result.nttCn}</textarea>
						<script type="text/javascript">
						//<![CDATA[
							var CrossEditor = new NamoSE("crosseditor");
							CrossEditor.EditorStart();

							var contentValue = document.getElementById("nttCn").value; // Hidden 값 참조
							function OnInitCompleted(){
								//contentValue = contentValue.replace(/#script#/gi, "script");
								CrossEditor.SetBodyValue(contentValue); // 컨텐츠 내용 에디터 삽입
							}
						//]]>
						</script>
					</td>
				</tr>
				<tr>
					<th scope="row" class="con_tit"><label>문의내용</label> </th>
					<td><c:out value="${orgResult.nttCn }" /></td>

				</tr>
			</tbody>
		</table>
	</div>
</form>

	<div class="fr">
	<c:choose>
	<c:when test="${empty result}" >
		<a class="btn btn-primary" href="javascript:checkForm();"><span>등록</span></a>
	</c:when>
	<c:otherwise>
		<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
		<a class="btn btn-danger" href="/bos/bbs/${paramVO.bbsId}/delete.do?nttId=${result.nttId}&parnts=${result.parnts}&${pageQueryString}" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:otherwise>
	</c:choose>
		<c:url var="url" value="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${param.parnts}&menuNo=${param.menuNo}" />
		<a class="btn btn-primary" href="${url}"><span>이전화면</span></a>
	</div>

</div>
