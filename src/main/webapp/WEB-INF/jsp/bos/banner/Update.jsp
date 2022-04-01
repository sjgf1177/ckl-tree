<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:forEach var="fileList" items="${fileList}" varStatus="status">
	<c:if test="${fileList.fileFieldName eq 'file1' }">
		<c:set var="fileVO" value="${fileList }"/>
	</c:if>
</c:forEach>
<script type="text/javascript">
$(function() {
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#bgnde").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#endde").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});

	$("#chkAll").click(function(){
		if(this.checked)
			$(":checkbox").attr("checked", true);
		else
			$(":checkbox").attr("checked", false);
	});
});

function checkAndSubmit() {

	var form = $("#fm")[0];
	var v = new MiyaValidator(form);
	var regFlag = "${empty result ? 'Y' : 'N'}";
	if(regFlag == "Y"){
	    v.add("file1", {
			required: true
	    });
	  <%--  v.add("file2", {
			required: true
	    }); --%>
	}

    v.add("bannerNm", {
		required: true
    });
    v.add("bannerUrl", {
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
	result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}
	var $usrtAt= $("input[type=radio][name=useAt]:checked").val();
	$("#publish").val($usrtAt);


	if (confirm('등록하시겠습니까?')) {
		form.submit();
	}


	function delFile(atchFileId, fileSn){
		if (!confirm('삭제 하시겠습니까?')) {
			return false;
		}
		$.getJSON(
				"/bos/cmm/fms/deleteFileInfs.json",
				{atchFileId : atchFileId, fileSn : fileSn},
				function(data)
				{
					var jdata = data.resultCode;
		            if( jdata == 'success' ) {
		            	alert("성공적으로 삭제하였습니다.");
		            	location.reload();
		            	//$("#realfile_"+fileSn).html("");
		            }
		            else alert("삭제에 실패하였습니다.");
				}
			);
	}
}

</script>
<c:set var="action" value="${empty result ? '/bos/banner/insert.do' : '/bos/banner/update.do'}" />
<form id="fm" name="fm" method="post" action="${action}" enctype="multipart/form-data">
	<input type="hidden" id="menuNo" name="menuNo" value="${param.menuNo}" />
	<input type="hidden" id="publish" name="publish" value="" />
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}" />
	<c:if test="${not empty result}">
		<input type="hidden" name="bnrCd" value="${result.bnrCd}" />
	</c:if>
	<input type="hidden" name="type" value="01" />
	<input type="hidden" name="category" value="01" />
	<input type="hidden" name="lastUpdusrId" value="${user.userId}" />
	<input type="hidden" name="gubun" value="01" />
<div class="bdView">
<table>
	<caption>배너관리 수정/등록</caption>
	<colgroup>
		<col width="15%"/>
		<col width="85%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="file1">웹 배너 이미지</label></th>
			<td class="output">
					<c:if test="${not empty fileVO }">
						<img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}" style="border: 0px;" width="200px" />
						<a href="#" onclick="javascript:delFile('${fileVO.atchFileId}', '${fileVO.fileSn}', '${param.bbsId}');">
								<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileVO.fileCn}"/> 삭제" />
						</a>
					</c:if>
				<input id="file1" name="file1" type="file" title="첨부파일1" class="board1" size="50" style="width:90%" />
				<br/>
				이미지 권장사이즈 : 153*38
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="file2">모바일 배너 이미지</label></th>
			<td class="output">
				<c:import url="/bos/cmm/fms/fileList.do">
					<c:param name="fileFieldName" value="file2"/>
					<c:param name="listType" value="img"/>
					<c:param name="updateFlag" value="Y"/>
				</c:import>
				<input id="file2" name="file2" type="file" title="첨부파일2" class="board1" size="50" style="width:90%" />
				<br/>
				이미지 권장사이즈 : 153*38
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="bannerNm">제목</label></th>
			<td class="output">
				<input type="text" id="bannerNm" name="bannerNm" value="${result.bnrNm}" style="width: 600px" class="board1" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="bannerUrl">링크 URL</label></th>
			<td class="output">
				<input type="text" id="bannerUrl" name="bannerUrl" value="${result.bnrUrl}" style="width: 600px" class="board1" />
			</td>
		</tr>
		<tr>
			<th scope="row">사용 여부</th>
			<td class="output">
				<label for="useAt1">사용 여부</label>
					<input type="radio" id="useAt1" name="useAt" value="Y" class="ra" <c:if test="${empty result or result.publish eq 'Y'}">checked</c:if> /> 사용
				<label for="publish_N">
					<input type="radio" id="useAt2" name="useAt" value="N" class="ra" <c:if test="${result.publish eq 'N'}">checked</c:if> /> 미사용
				</label>
			</td>
		</tr>
		<tr>
			<th scope="row">링크 방식</th>
			<td class="output">
				<label for="popup_Y">링크 방식</label>
					<input type="radio" id="popup_Y" name="popupAt" value="Y" class="ra" <c:if test="${empty result or result.popup eq 'Y'}">checked</c:if> /> 새창
				<label for="popup_N">
					<input type="radio" id="popup_N" name="popupAt" value="N" class="ra" <c:if test="${result.popup eq 'N'}">checked</c:if> /> 현재페이지
				</label>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="bgnde">노출기간</label></th>
			<td>
				<input type="text" id="bgnde" name="bgnde" style="width: 125px" class="board1" value="${result.startDt}" />
				~
				<input type="text" id="endde" name="endde" style="width: 125px" class="board1" value="${result.endDt}" />
			</td>
		</tr>

		<tr>
			<th scope="row"><label for="sortOrdr">노출 순서</label></th>
			<td>
				<input type="text" id="sortOrdr" name="sortOrdr" style="width: 250px" class="board1" value="${result.orderly}" />
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
		<a class="btn btn-danger"  href="/bos/banner/delete.do?bnr_cd=${result.bnrCd}&menuNo=${param.menuNo}" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:otherwise>
	</c:choose>
		<c:url value="/bos/banner/list.do?${pageQueryString}" var="list_url" />
		<a class="btn btn-primary" href="${list_url}"><span>목록</span></a>
	</div>

