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
	var type = '${result.type}';
	if( "01" == type ) {
		$('#trImg').show();
		$('#trImg2').show();
	}
	else {
		$('#trImg').hide();
		$('#trImg2').hide();
	}

	$(':radio[name=type]').click(function(){
		var val = this.value;
		if( "01" == val ) {
			$('#trImg').show();
			$('#trImg2').show();
		}
		else {
			$('#trImg').hide();
			$('#trImg2').hide();
		}
	});
});
function checkAndSubmit() {

	var form = $("#fm")[0];
	var v = new MiyaValidator(form);
	var regFlag = "${empty result ? 'Y' : 'N'}";
    v.add("ntcnNm", {
		required: true
    });
    v.add("sortOrdr", {
    	required: true,
    	option: "number"
    });
    v.add("useAt", {
    	required: true
    });
	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	var cont = CrossEditor.GetBodyValue();
	document.getElementById("nttCn").value= cont;

	if (confirm('등록하시겠습니까?')) {
		form.submit();
	}
}

</script>

<c:set var="action" value="${empty result ? '/bos/ntcnAlert/insert.do' : '/bos/ntcnAlert/update.do'}" />
<form id="fm" name="fm" method="post" action="${action}" enctype="multipart/form-data">
	<input type="hidden" id="pageQueryString" name="pageQueryString" value="${pageQueryString}" />
	<input type="hidden" id="menuNo" name="menuNo" value="${param.menuNo}" />
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}" />
	<input type="hidden" name="siteId" value="01" />
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
			<th scope="row"><label for="ntcnNm">제목</label></th>
			<td>
				<input type="text" id="ntcnNm" name="ntcnNm" value="${result.ntcnNm}" style="width: 600px" class="board1" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="type1">배경선택</label></th>
			<td class="mainVisualSetup">
				<label><input type="radio" id="type1" name="type" value="01" ${result.type eq '01' ? 'checked="checked"' : ''} /> 직접등록</label>
				<label><input type="radio" id="type2" name="type" value="02" ${result.type eq '02' ? 'checked="checked"' : ''} /> 배경1 </label>
				<button type="button" data-souce="/portal/images/main/mainvisual1.jpg">미리보기</button><span class="mainSampleVisual1"><img src="/portal/images/main/mainvisual1.jpg" alt="" /></span>
				<label><input type="radio" id="type3" name="type" value="03" ${result.type eq '03' ? 'checked="checked"' : ''} /> 배경2 </label>
				<button type="button" data-souce="/portal/images/main/mainvisual2.jpg">미리보기</button><span class="mainSampleVisual2"><img src="/portal/images/main/mainvisual2.jpg" alt="" /></span>
				<label><input type="radio" id="type4" name="type" value="04" ${result.type eq '04' ? 'checked="checked"' : ''} /> 배경3 </label>
				<button type="button" data-souce="/portal/images/main/mainvisual3.jpg">미리보기</button><span class="mainSampleVisual3"><img src="/portal/images/main/mainvisual3.jpg" alt="" /></span>
				<label><input type="radio" id="type5" name="type" value="05" ${result.type eq '05' ? 'checked="checked"' : ''} /> 배경4 </label>
				<button type="button" data-souce="/portal/images/main/mainvisual4.jpg">미리보기</button><span class="mainSampleVisual4"><img src="/portal/images/main/mainvisual4.jpg" alt="" /></span>
				<script>
					$('.mainVisualSetup button').each(function(index, el) {
						$(this).click(function(event) {
							var src = $(this).attr('data-souce');
							popupW(src, 'mainvisualPreview', 800, 120, 0, 1, 3)
						})
						// $(this).next().css('background-image', 'url('+ $(this).attr('data-souce')+')');;
					});
				</script>
				<style>
				.mainVisualSetup span{display: inline-block;width: 55px;height: 30px;background:  0 0 no-repeat;background-size:100% 100%;vertical-align: middle;}
				.mainVisualSetup span img{width: 100%;height: 100%;}
				</style>
			</td>
		</tr>
		<tr id="trImg">
			<th scope="row"><label for="file1">웹 이미지</label></th>
			<td>
				<c:import url="/bos/cmm/fms/fileList.do">
					<c:param name="fileFieldName" value="file1"/>
					<c:param name="listType" value="img"/>
					<c:param name="updateFlag" value="Y"/>
				</c:import>
				<input id="file1" name="file1" type="file" title="첨부파일1" class="board1" size="50" style="width:90%" />
				<br/>
				이미지 권장사이즈(최적) : 1980 * 300 (비율 = 6.6 : 1 )<br/>
			</td>
		</tr>
		<tr id="trImg2">
			<th scope="row"><label for="file2">모바일 이미지</label></th>
			<td>
				<c:import url="/bos/cmm/fms/fileList.do">
					<c:param name="fileFieldName" value="file2"/>
					<c:param name="listType" value="img"/>
					<c:param name="updateFlag" value="Y"/>
				</c:import>
				<input id="file2" name="file2" type="file" title="첨부파일2" class="board1" size="50" style="width:90%" />
				<br/>
				이미지 권장사이즈(최적) : 640 * 327 (비율 = 2 : 1)<br/>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="nttCn">본문내용</label></th>
			<td class="outputEditor">
				<div>줄내림(=br 삽입) : shift + enter (※엔터용시 화면이 밀릴 수 있습니다.)</div>
				<textarea id="nttCn" name="nttCn" cols="30" rows="10" style="display:none;" class="textarea">${empty result ? initNttCn : result.nttCn}</textarea>
				<script type="text/javascript">
				//<![CDATA[
					var CrossEditor = new NamoSE("crosseditor");
					CrossEditor.params.Font = {"Nanum Gothic":"나눔고딕", "Dotum":"돋움", "Gulim":"굴림", "Batang":"바탕", "Gungsuh":"궁서"};
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
			<th scope="row"><label for="sortOrdr">노출 순서</label></th>
			<td>
				<input type="text" id="sortOrdr" name="sortOrdr" style="width: 250px" class="board1" value="${result.sortOrdr}" />
			</td>
		</tr>
		<tr>
			<th scope="row">사용 여부</th>
			<td>
				<label for="useAt"></label>
					<input type="radio" id="useAt1" name="useAt" value="Y" class="ra" title="사용여부"<c:if test="${empty result or result.useAt == 'Y'}">checked</c:if> />사용 (Y)
				<label for="publish_N">
					<input type="radio" id="useAt2" name="useAt" value="N" class="ra" <c:if test="${result.useAt == 'N'}">checked</c:if> /> 미사용 (N)
				</label>
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

