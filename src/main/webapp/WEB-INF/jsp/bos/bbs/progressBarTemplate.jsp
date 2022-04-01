<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script language="Javascript"> 

$(document).ready(function()
{
    $(":input[id^=btnCopy_]").click(function()
    {
    	var sn = (this.id).replace("btnCopy_", "");
    	var text = $("#linkA_"+sn).attr("href");
    	window.clipboardData.setData('Text',text);
    	alert("복사되었습니다");
    });
});

</script>
<div id="down" style="display: none; ">
	<h1><img src="/bos/images/down_tit.gif" alt="파일업로드" /></h1>
	<div class="box">
		<div id="fileDown" class="percent" style="width:0%"></div>
	</div>
	<span id="fileDownNum">0%</span>
	<p>* 파일업로드 완료시 자동으로 창이 닫힘니다. <input type="image" src="/bos/images/down_btn.gif" alt="닫기" class="btn_close"></p>
</div>
<br/>
<form id="pbFrm" enctype="multipart/form-data" name="fileUploadForm" method="post" action="/bos/bbs/uploadFile">
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="_atchFileId${empty param.sortOrdr ? '0' : param.sortOrdr}" name="atchFileId" value="${result.atchFileId}">
<c:if test="${not empty param.sortOrdr}">
	<input type="hidden" name="sortOrdr" value="${param.sortOrdr}" />
</c:if>
<div class="bdView">
<table class="view_type01" id="tbl${empty param.sortOrdr ? '0' : param.sortOrdr}">
	<caption>파일첨부</caption>
	<colgroup>
		<col width="15%"/>
		<col width="85%"/>
	</colgroup>
	<tbody>	
		<tr>
			<th scope="row" class="con_tit">파일첨부</th>
			<td>
				<label for="file1" class="blind">첫번째첨부파일</label>
				<input name="datafile" id="file1" type="file" class="b_text" size="60" style="width:50%"  />
				<!-- <input type="checkbox" id="viewYn" name="viewYn" value="Y"> 메인노출유무 -->
				<input id="submitButton" type="submit" value="파일전송" class="input_upload" />
				<br/>
* 찾아보기로 이미지를 등록 후 반드시 <font color="red">파일업로드 버튼</font>을 클릭 해 주세요.<br/>
* 여러개 이미지를 등록 할 경우 첫 번째 등록 방식과 동일하게 계속 추가하면 됩니다.<br/>
			</td>
		</tr>
	<c:forEach var="fileVO" items="${fileList}" varStatus="status">
		<tr id="tr_${empty param.sortOrdr ? '0' : param.sortOrdr}_${fileVO.fileSn}">
			<th scope="row" class="con_tit">파일첨부</th>
			<td>		
				<a id="linkA_${fileVO.fileSn}" href="/bos/cmm/fms/FileDown?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${param.bbsId}">
					${fileVO.orignlFileNm}&nbsp;[${fileVO.fileMg}&nbsp;byte]
				</a>							
				<a href="javascript:deleteFile('${fileVO.atchFileId}','${fileVO.fileSn}','${empty param.sortOrdr ? '0' : param.sortOrdr}', '${param.bbsId}');">
					<img id="deleteIcon" src="/bos/images/common/bu5_close.gif" />
				</a>
				<input type="button" id="btnCopy_${fileVO.fileSn}" value="경로복사" />
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
</div>
</form>
