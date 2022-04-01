
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />

<c:if test="${empty result}">
	<c:set var="action" value="/edu/bbs/${paramVO.bbsId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/edu/bbs/${paramVO.bbsId}/update.do" />
</c:if>
<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js" ></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
<!--

function checkForm() {
	var form = $("#board")[0];
	var v = new MiyaValidator(form);
    v.add("nttSj", {
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

	if (!confirm('등록하시겠습니까?')) {
		return;
	}

	var cont = CrossEditor.GetBodyValue();
	document.getElementById("nttCn").value= cont;
	form.submit();
}

function del(){
	var form = $("#board")[0];
	form.action = "/edu/bbs/${paramVO.bbsId}/delete.do?menuNo=<c:out value="${param.menuNo }"/>";
	form.submit();
}


//-->
</script>




<div class="tar alert alert-info noticeAc0201">
	<p>
		<strong>한국콘텐츠 진흥원에서 지원하는  <c:out value="${param.menuNm }" /> 입니다.</strong>
	</p>
	<p>
	에듀코카와 관련된
	<c:out value="${param.menuNm }" />
		를 확인하실 수 있습니다.
	</p>
</div>

<div class="tbrinfo text-danger clear">
	<span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.
</div>
<%-- <c:out value="${empty result ? '등록' : '수정'}"/> --%>

	<form id="board" action="<c:out value="${action }" />" method="post" enctype="multipart/form-data" >
	<input type="hidden" name="pageQueryString" value="<c:out value='${pageQueryString}'  escapeXml='false'/>" >
	<input type="hidden" name="nttId" value="<c:out value='${empty result.nttId ? 0 : result.nttId }' />" />
	<input type="hidden" name="bbsId" value="<c:out value='${masterVO.bbsId}' />" />
	<div class="bdView">
	<table class="table table-bordered">
		<caption>창의클럽 커뮤니티</caption>
		<colgroup>
			<col style="width: 15%" />
			<col />
			<col style="width: 15%" />
			<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 제목</th>
				<td colspan="3"> <input type="text" name="nttSj" title="제목" style="width: 100%;" value="<c:out value="${result.nttSj }"/>"> </td>
			</tr>
			<tr>
				<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 내용</th>
				<td colspan="3" class="outputEditor">

				<textarea name="nttCn" style="display: none;" id="nttCn" cols="120" rows="12" onfocus="if(this.value=='텍스트를 입력하세요.')this.value='';" onkeyup="if(this.value=='텍스트를 입력하세요.')this.value='';" title="텍스트를 입력하세요.">
				<c:out value='${result.nttCn}'/></textarea>
					<script type="text/javascript">
								//<![CDATA[
								var CrossEditor = new NamoSE("crosseditor");
								CrossEditor.params.Font = {"Nanum Gothic":"나눔고딕", "Dotum":"돋움", "Gulim":"굴림", "Batang":"바탕", "Gungsuh":"궁서"};
								CrossEditor.EditorStart();

								var contentValue = document.getElementById("nttCn").value; // Hidden 값 참조
								function OnInitCompleted() {
									//contentValue = contentValue.replace(/#script#/gi, "script");
									CrossEditor.SetBodyValue(contentValue); // 컨텐츠 내용 에디터 삽입
								}
								//]]>
					</script>
				</td>
			</tr>

			<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
			<c:if test="${not empty fileList}">
				<tr>
					<th scope="row">첨부된 첨부파일</th>
					<td>
						<jsp:include page="/WEB-INF/jsp/bos/share/EgovFileList.jsp" flush="true" />
					</td>
				</tr>
			</c:if>
			<tr>
				<th scope="row">첨부파일</th>
				<td>
					<jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" />
				</td>
			</tr>
		</c:if>


		</tbody>
	</table>
	</div>
	</form>



	<div class="btnSet tac pb20">
	<c:choose>
	<c:when test="${empty result}" >
		<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
	</c:when>
	<c:otherwise>
		<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
		<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:otherwise>
	</c:choose>
	</div>


