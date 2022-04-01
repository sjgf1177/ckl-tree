<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:if test="${empty result}">
	<c:set var="action" value="/bos/job/${paramVO.programId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/job/${paramVO.programId}/update.do" />
</c:if>

<c:forEach var="fileList" items="${fileList}" varStatus="status">
	<c:if test="${fileList.fileFieldName eq 'file1' }">
		<c:set var="fileVO" value="${fileList }"/>
	</c:if>
</c:forEach>

<c:choose>
	<c:when test="${empty fileVO.atchFileId and empty result.logoUrl}">
		<c:set value="/edu/images/common/company_noimg.jpg"  var="imgUrl"/>
	</c:when>
	<c:when test="${not empty fileVO.atchFileId and empty result.logoUrl}">
		<c:set value="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}"  var="imgUrl"/>
	</c:when>
	<c:when test="${empty fileVO.atchFileId and not empty result.logoUrl }">
		<c:set value="${result.logoUrl }"  var="imgUrl"/>
	</c:when>
</c:choose>

<script type="text/javascript">
//<![CDATA[
     function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);

		var result = v.validate();

		v.add("entrprsNm", {
			required : true
		});



		var result = v.validate();

		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}


		if (!confirm('등록하시겠습니까?')) {
			return;
		}
		var cksw = $('input:checkbox[name="lstAtNm"]').is(":checked");
		if (cksw == true) {
			$('#lstAt').val('Y');
			$('#useAt').val('Y');
		} else {

			$('#lstAt').val('N');
			$('#useAt').val('N');

		}

		form.submit();
	}

	function del(){
		var form = $("#board")[0];
		form.action = "/bos/job/${paramVO.programId}/delete.do";
		form.submit();
	}

	function restore(){
		var form = $("#board")[0];
		form.action = "/bos/job/${paramVO.programId}/restor.do";
		form.submit();
	}

	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/job/${paramVO.programId}/delPermanently.do";
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
//]]>
</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시물 <c:out value="${empty result ? '쓰기' : '수정' }" /> </title>
</head>
<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
<input type="hidden" name="entrprsSn" value="${empty result.entrprsSn ? 0 : result.entrprsSn }" />
<input type="hidden" name="lstAt" id="lstAt" value=""  />
<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}">
<input type="hidden" id="telno" name="telno" value="${telno }">
<input type="hidden" id="useAt" name="useAt" value="${useAt }">
	<h4>■ 기업정보</h4>

	<div class="bdView">
		<table>
			<caption>
			기업정보
			</caption>
			<colgroup>
			<col style="width:15%" />
			<col style="width:35%" />
			<col style="width:15%" />
			<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="file1">업체로고</label></th>
					<td colspan="3">
						<c:if test="${not empty imgUrl }">
							<img src="${imgUrl }" style="border: 0px;" width="200px" />
							<c:if test="${not empty fileVO.atchFileId }">
							<a href="#" onclick="javascript:delFile('${fileVO.atchFileId}', '${fileVO.fileSn}', '${param.bbsId}');">
								<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileVO.fileCn}"/> 삭제" />
							</a>
							</c:if>
						</c:if>

						<input id="file1" name="file1" type="file" title="첨부파일1" class="board1" size="50" style="width:90%" />
					 </td>
				</tr>

				<tr>
					<th>기업명</th>
					<td colspan="3">
						<input type="text" name="entrprsNm" id="entrprsNm" value="<c:out value="${result.entrprsNm }" />"  title="기업명" >
						<label> <input type="checkbox" name="lstAtNm" id="lstAtNm"  value="Y" <c:if test="${result.lstAt eq 'Y' }">checked="checked"</c:if> > 상장여부 </label>

					</td>
				</tr>
				<tr>
					<th>대표자명</th>
					<td colspan="3"> <input type="text" name="rprsntv" id="rprsntv" value="<c:out value="${result.rprsntv }"/>" title="대표자명" > </td>
				</tr>
				<tr>
					<th>사원수 </th>
					<td> <input type="text" name="emplCo" id="emplCo" value="<c:out value="${result.emplCo }"/>" title="사원수" > </td>
					<th>설립연도</th>
					<td> <input type="text" name="fondYear" id="fondYear" maxlength="4" value="<c:out value="${result.fondYear }" />" title="설립연도" > </td>
				</tr>
				<tr>
					<th>홈페이지</th>
					<td colspan="3">http://<input type="text" name="hmpg" id="hmpg" value="<c:out value="${result.hmpg }"/>" class="w500" title="홈페이지" ></td>
				</tr>
				<tr>
					<th>자본금</th>
					<td><input type="text" name="capl" id="capl" value="<c:out value="${result.capl }"/>" title="자본금" ></td>
					<th><label  for="entrprsStle" >분야</label></th>
					<td>
						<select id="entrprsStle" name="entrprsStle" >
							<label>
								<option value="<c:out value="" />" >분야</option>
								<c:forEach var="code" items="${COM099CodeList }" varStatus="status" >
									<option value="${code.code }"<c:if test="${fn:indexOf(result.entrprsStle, code.code) != -1}">selected="selected"</c:if>><c:out value="${code.codeNm}" /></option>
								</c:forEach>
							</label>
						</select>
					</td>
				</tr>

			</tbody>
		</table>
	</div>
	<h4>■ 담당자 정보</h4>

	<div class="bdView">
		<table>
			<caption>
			담당자 정보
			</caption>
			<colgroup>
			<col style="width:15%" />
			<col style="width:35%" />
			<col style="width:15%" />
			<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="">담당자명</label></th>
					<td colspan="3"> <input type="text" name="charger" id="charger" value="<c:out value="${result.charger }"/>" title="담당자명" ></td>
				</tr>
				<tr>
					<th scope="row">연락처</th>
					<td>
					<c:set var="data" value="${fn:split(result.telno,'-')}" />
					<select name="telno1" id="telno1" class="input_select" title="연락처 앞 자리">
						<option value="">선택</option>
						<option value="02" <c:if test="${data[0] eq '02'}"> selected="selected"</c:if>>02</option>
						<option value="010" <c:if test="${data[0] eq '010'}"> selected="selected"</c:if>>010</option>
						<option value="070" <c:if test="${data[0] eq '070'}"> selected="selected"</c:if>>070</option>
						<option value="051" <c:if test="${data[0] eq '051'}"> selected="selected"</c:if>>051</option>
						<option value="053" <c:if test="${data[0] eq '053'}"> selected="selected"</c:if>>053</option>
						<option value="032" <c:if test="${data[0] eq '032'}"> selected="selected"</c:if>>032</option>
						<option value="062" <c:if test="${data[0] eq '062'}"> selected="selected"</c:if>>062</option>
						<option value="042" <c:if test="${data[0] eq '042'}"> selected="selected"</c:if>>042</option>
						<option value="052" <c:if test="${data[0] eq '052'}"> selected="selected"</c:if>>052</option>
						<option value="044" <c:if test="${data[0] eq '044'}"> selected="selected"</c:if>>044</option>
						<option value="031" <c:if test="${data[0] eq '031'}"> selected="selected"</c:if>>031</option>
						<option value="033" <c:if test="${data[0] eq '033'}"> selected="selected"</c:if>>033</option>
						<option value="043" <c:if test="${data[0] eq '043'}"> selected="selected"</c:if>>043</option>
						<option value="041" <c:if test="${data[0] eq '041'}"> selected="selected"</c:if>>041</option>
						<option value="063" <c:if test="${data[0] eq '063'}"> selected="selected"</c:if>>063</option>
						<option value="061" <c:if test="${data[0] eq '061'}"> selected="selected"</c:if>>061</option>
						<option value="054" <c:if test="${data[0] eq '054'}"> selected="selected"</c:if>>054</option>
						<option value="055" <c:if test="${data[0] eq '055'}"> selected="selected"</c:if>>055</option>
						<option value="064" <c:if test="${data[0] eq '064'}"> selected="selected"</c:if>>064</option>
					</select>
					 -
					<input type="text" name="telno2" id="telno2" style="width: 80px;"  maxlength="4" value="<c:out value="${data[1] }"/>" title="연락처" > -
					<input type="text" name="telno3" id="telno3" style="width: 80px;"  maxlength="4" value="<c:out value="${data[2] }"/>" title="연락처" >
					</td>
					<th>이메일</th>
					<td><input type="text" name="email" id="email" value="<c:out value="${result.email }"/>" title="이메일" > </td>
				</tr>
			</tbody>
		</table>
	</div>



</form>
</div>



<div class="fr" >
	<c:choose>
	<c:when test="${empty result}" >
		<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
	</c:when>
	<c:otherwise>
		<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
		<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	<c:if test="${result.delcode eq '1' }" >
		<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>복구</span></a>
	</c:if>
	</c:otherwise>
	</c:choose>
		<c:url var="url" value="/bos/job/${paramVO.programId}/list.do?${pageQueryString}"/>
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
</div>
