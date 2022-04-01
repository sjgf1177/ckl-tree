<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />
<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.css">

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/jquery-ui/jquery-ui.js"></script>

<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/bos/pb/js/jquery.form.js"></script>
<script type="text/javascript" src="/bos/pb/js/pb.js"></script>
<script type="text/javascript">
$(function() {
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#start_dt").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#end_dt").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
});

function setNum(obj) {
    var val=obj.value;
    var re=/[^0-9]/gi;
    obj.value=val.replace(re,"");
};

function checkAndSubmit() {

	var f = document.fm;
	var v = new MiyaValidator(f);

    v.add("title", {
		required: true
    });
    v.add("startDt", {
		required: true
    });
    v.add("endDt", {
		required: true
    });

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	var cont = CrossEditor.GetBodyValue("XHTML");
	document.getElementById("contents").value= cont;

	f.submit();
};

function openPopup(patName1,patName2)
{
	url = "/bos/deptPop/list.do?patName1="+patName1+"&amp;patName2="+patName2;
	window.open(url, "deptName", "resizable=no, status=no, scrollbars=no, toolbar=no, menubar=no, width=800, height=700");
}

</script>
<title>이벤트</title>
</head>
<body>

	<div id="content">
		<div class="hgroup">
			<h3>이벤트</h3>
		</div>
<!-- 첨부파일 업로드 부분 수정해야하는데 설문조사 다른로직 덮은후에 작업해야함 -->
<form name="fm" method="post" enctype="multipart/form-data" action="${empty result ? '/bos/poll/insert.do' : '/bos/poll/update.do'}">
	<input type="hidden" id="masterCd" name="masterCd" value="${result.masterCd}">
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}">

	<div class="bdView">
		<table>
			<caption>이벤트 수정</caption>
				<colgroup>
				<col width="15%"/>
				<col width="85%"/>
				</colgroup>
				<tbody>


					<tr>
						<th scope="row">이벤트기간</th>
						<td class="output">
							<input value="<fmt:formatDate value="${result.startDt}" pattern="yyyy-MM-dd"/>" type="text" name="startDt" id="start_dt" title="응모기간 (시작일자)" style="width: 80px; padding-left: 5px;" class="board1" readonly="readonly"/>
							<span style="width: 5px;"></span> ~ <span style="width: 5px;"></span>
							<input value="<fmt:formatDate value="${result.endDt}" pattern="yyyy-MM-dd"/>" type="text" name="endDt" id="end_dt" title="응모기간 (종료일자)" style="width: 80px; padding-left: 5px;" class="board1" readonly="readonly"/>
						</td>
					</tr>

					<tr>
						<th scope="row"><label for="deptNm">사업부</label></th>
						<td class="output">
							<input type="text" name="deptNm" id="deptNm" style="width: 300px; padding-left: 5px;" class="board1" value="${empty result ? user.deptNmKor : result.deptNm}" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="title">제목</label></th>
						<td class="output">
							<input type="text" name="title" id="title" class="board1 input_txt wi100per" value="${result.title}"/>
						</td>
					</tr>
					<tr>
						<th scope="row" class="con_tit"><label for="nttCn">내용</label></th>
						<td class="outputEditor">
							<span style="color:red;">* 아래의 작성하시는 내용 (첨부파일 포함)중에 개인정보에 관한 내용이 있다면 개인정보가 타인에게 노출되어 침해 받을 수 있으므로 삭제 후 등록하여 주시기 바랍니다.
							(개인정보내용 : 주민등록번호, 계좌번호, 핸드폰번호 등)
							</span><br/>
							<textarea id="contents" name="contents" cols="150" rows="30" style="display:none;" class="textarea">${result.contents}</textarea>
							<script type="text/javascript">
							//<![CDATA[
								var CrossEditor = new NamoSE("crosseditor");
								CrossEditor.params.Font = {"Nanum Gothic":"나눔고딕", "Dotum":"돋움", "Gulim":"굴림", "Batang":"바탕", "Gungsuh":"궁서"};
								CrossEditor.EditorStart();

								var contentValue = document.getElementById("contents").value; // Hidden 값 참조
								function OnInitCompleted(){

									//contentValue = contentValue.replace(/#script#/gi, "script");
									CrossEditor.SetBodyValue(contentValue); // 컨텐츠 내용 에디터 삽입
								}
							//]]>
							</script>
						</td>
					</tr>
					<tr>
						<th scope="row">섬네일이미지</th>
						<td>
							<input name="thumbImage" type="file" id="thumbImage" class="input_file" title="섬네일이미지 ${x}" /><br/>
							이미지설명 : <input name="thumbImage_cn" type="text" id="thumbImage_cn" class="Input_file_infor" title="섬네일이미지 ${x} 설명" />
							<jsp:include page="/WEB-INF/jsp/bos/share/thumbImageFileList.jsp" flush="true" />
						</td>
					</tr>

					<tr>
					<th scope="row">이미지</th>
						<td>
							<jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" />
							<jsp:include page="/WEB-INF/jsp/bos/share/ImageFileList.jsp" flush="true" />
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
	<c:url var="del_action" value="/bos/poll/delete.do">
		<c:param name="masterCd" value="${result.masterCd}"/>
	</c:url>
		<a class="btn btn-danger"  href="${del_action}" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:otherwise>
	</c:choose>
		<c:url var="url" value="/bos/poll/list.do" />
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>

</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>