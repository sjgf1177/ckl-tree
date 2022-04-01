
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<%
	int year = egovframework.com.utl.DateUtil.getYear();
	pageContext.setAttribute("year", year);
%>

<%-- <ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/> --%>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/dream/${paramVO.programId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/dream/${paramVO.programId}/update.do" />
</c:if>

<sec:authorize ifAnyGranted="ROLE_SUPER">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>
<%-- bdtExpsrImage 처리 --%>
<c:if test="${fn:length(fileList) gt 0}">
	<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
		<c:if test="${fileList[x].fileFieldName eq 'bdtExpsrImage'}">
			<c:set var="bdtExpsrImage" value="${fileList[x]}" />
		</c:if>
	</c:forEach>
</c:if>

<%-- mainExpsrImage 처리 --%>
<c:if test="${fn:length(fileList) gt 0}">
	<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
		<c:if test="${fileList[x].fileFieldName eq 'mainExpsrImage'}">
			<c:set var="mainExpsrImage" value="${fileList[x]}" />
		</c:if>
	</c:forEach>
</c:if>




<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript">
	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);

		v.add("year", {
	        required: true
	    });

		v.add("rsltSe", {
	        required: true
	    });

		v.add("prdctNm", {
	        required: true
	    });

		v.add("mentiNm", {
	        required: true
	    });

		v.add("mentoNm", {
	        required: true
	    });

		if($("input[name='bdtExpsrImage']").length > 0){
		v.add("bdtExpsrImage", {
	        required: true,
	        message : "이미지를 등록해주세요"

	    });
		}

		v.add("mainExpsrAt", {
	        required: true
	    });
		v.add("sortOrdr", {
	        required: true
	    });
		if($("#mainExpsrAt1").is(":checked")){
			if($("input[name='mainExpsrImage']").length > 0){
			v.add("mainExpsrImage", {
		        required: true,
		        message : "이미지를 등록해주세요"
		    });
			}
		}


		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}



		if (!confirm('등록하시겠습니까?')) {
			return;
		}


		if (CrossEditor.GetBodyValue() == "") {
			alert('내용을 입력해 주세요.');
		    CrossEditor.SetFocusEditor(); // 크로스에디터 Focus 이동
		    return;
		}

		var cont = CrossEditor.GetBodyValue();
		document.getElementById("detailCn").value= cont;

		form.submit();
	}

	function del() {
		var form = $("#board")[0];
		form.action = "/bos/dream/${paramVO.programId}/delete.do";
		form.submit();
	}

	function delFile2(atchFileId, fileSn, programId, fileId) {
		$.getJSON("/bos/cmm/fms/deleteFileInfs.json", {
			atchFileId : atchFileId,
			fileSn : fileSn,
			programId : programId
		}, function(data) {
			var jdata = data.resultCode;
			if (jdata == 'success') {
				alert("성공적으로 삭제하였습니다.");
				if(fileId == 'bdtExpsrImage'){
					$("#" + fileId).html("<input type=\"file\" name=\""+fileId+"\" id=\""+fileId+"\"  class=\"input_file form-control\"/> 이미지 권장사이즈 : 150*140");
				}else{
					$("#" + fileId).html("<input type=\"file\" name=\""+fileId+"\" id=\""+fileId+"\"  class=\"input_file form-control\"/> 이미지 권장사이즈 : 350*120");
				}
			} else
				alert("삭제에 실패하였습니다.");
		});
	}
</script>
<title><c:out value='${masterVO.bbsNm}' /> - 게시글쓰기</title>
</head>

<div id="content">
	<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
		<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
		<input type="hidden" name="frstRegisterId" id="frstRegisterId" value="<c:out value="${result.userId }" />" />
		<input type="hidden" name="LastUpdusrId" id="LastUpdusrId" value="<c:out value="${result.userId }" />" />
		<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}">
		<input type="hidden" name="rsltSn" value="<c:out value='${result.rsltSn }' />">
		<h4>■ 주요성과- ${empty result ? '등록' : '수정'}</h4>

		<div class="bdView">
			<table>
				<caption>주요성과 - ${empty result ? '등록' : '수정'}</caption>
				<colgroup>
					<col style="width: 15%" />
					<col style="width: 35%" />
					<col style="width: 15%" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">년도</th>
						<td colspan="3" >

						<select name="year" title="년도">
								<option value="">선택</option>
								<c:forEach var="code" items="${COM087CodeList}" varStatus="status">
									<option value="${code.code}" <c:if test="${result.year eq code.code }">selected="selected"</c:if>>
										<c:out value="${code.codeNm}" />
									</option>
								</c:forEach>

						</select>
						</td>
					</tr>
					<tr>
						<th scope="row">구분</th>
						<td colspan="3">
						<select name="rsltSe" title="구분">
								<option value="" >선택</option>
								<c:forEach var="code" items="${COM085CodeList}" varStatus="status">
									<option value="${code.code}"  <c:if test="${result.rsltSe eq code.code }">selected='selected'</c:if>>
										<c:out value="${code.codeNm}" />
									</option>
								</c:forEach>

						</select>
						</td>
					</tr>
					<tr>
						<th scope="row" >작품명</th>
						<td colspan="3"><input type="text" name="prdctNm" value="<c:out value='${result.prdctNm }' />"  title="작품명" class="w500"></td>
					</tr>
					<tr>
						<th scope="row">멘티</th>
						<td colspan="3"><input type="text" name="mentiNm" value="<c:out value='${result.mentiNm }' />" title="멘티" class="w500"></td>
					</tr>
					<tr>
						<th scope="row">멘토</th>
						<td colspan="3"><input type="text" name="mentoNm"  value="<c:out value='${result.mentoNm }' />" title="멘토" class="w500"></td>
					</tr>
					<tr>
						<th scope="row"><label for="bdtExpsrImage">본문 노출 </label> <br /> 포스터 </th>
						<td colspan="3" id="bdtExpsrImage">
						<c:if test="${not empty bdtExpsrImage}">
								<a href="/bos/cmm/fms/FileDown.do?atchFileId=${bdtExpsrImage.atchFileId}&amp;fileSn=${bdtExpsrImage.fileSn}&amp;bbsId=${masterVO.bbsId}" class="${icn}"> <c:out value="${bdtExpsrImage.orignlFileNm}" />&nbsp;[<c:out value="${bdtExpsrImage.fileMg}" />&nbsp;byte]
								</a>
								<a href="#" onclick="javascript:delFile2('<c:out value ='${bdtExpsrImage.atchFileId}'/>', '<c:out value ='${bdtExpsrImage.fileSn}'/>', '${masterVO.bbsId}','<c:out value='${bdtExpsrImage.fileFieldName }'/>');"> <img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${bdtExpsrImage.fileCn}"/> 삭제" />
								</a>
						</c:if> <%-- #main_image 파일이 없을시  처리  --%>
						<c:if test="${empty bdtExpsrImage}">
								<input name="bdtExpsrImage" type="file" id="bdtExpsrImage" class="input_file form-control" />
								이미지 권장사이즈 : 150*140
						</c:if> <c:set var="bdtExpsrImage" value="" />

						</td>
					</tr>
					<tr>
						<th scope="row">상세내용</th>
						<td colspan="3">
						<span style="color: red;">* 아래의 작성하시는 내용 (첨부파일 포함)중에 개인정보에 관한 내용이 있다면 개인정보가 타인에게 노출되어 침해 받을 수 있으므로 삭제 후 등록하여 주시기 바랍니다. (개인정보내용 : 주민등록번호, 계좌번호, 핸드폰번호 등) </span><br />
						 <textarea id="detailCn" name="detailCn" cols="150" rows="30" style="display: none;" class="textarea">${result.detailCn}</textarea>
						 <script type="text/javascript">
							//<![CDATA[
							var CrossEditor = new NamoSE("crosseditor");
							CrossEditor.params.Font = {"Nanum Gothic":"나눔고딕", "Dotum":"돋움", "Gulim":"굴림", "Batang":"바탕", "Gungsuh":"궁서"};
							CrossEditor.EditorStart();

							var contentValue = document.getElementById("detailCn").value; // Hidden 값 참조
							function OnInitCompleted() {

								//contentValue = contentValue.replace(/#script#/gi, "script");
								CrossEditor.SetBodyValue(contentValue); // 컨텐츠 내용 에디터 삽입
							}
							//]]>
						</script>

						</td>
					</tr>
					<tr>
						<th scope="row">메인노출</th>
						<td colspan="1"><label><input name="mainExpsrAt" id="mainExpsrAt1" value="Y" <c:if test="${result.mainExpsrAt eq 'Y'}">checked="checked"</c:if>  type="radio">노출</label>  <label><input name="mainExpsrAt" id="mainExpsrAt2" value="N" <c:if test="${result.mainExpsrAt eq 'N'}">checked="checked"</c:if> type="radio">노출안함</label></td>
						<th scope="row">순번</th>
						<td colspan="1"><select name="sortOrdr" id="sortOrdr" title="순번">
								<option value="">순번 선택</option>
								<c:forEach begin="1" end="50" varStatus="status">
									<option value="<c:out value='${status.count }'/>" <c:if test="${status.count eq result.sortOrdr}">selected='selected'</c:if>>${status.count}</option>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<th scope="row"><label for="mainExpsrImage">메인노출 </label><br />이미지
						</th>
						<td colspan="3" id="mainExpsrImage">
						<c:if test="${not empty mainExpsrImage}">
								<a href="/bos/cmm/fms/FileDown.do?atchFileId=${mainExpsrImage.atchFileId}&amp;fileSn=${mainExpsrImage.fileSn}&amp;bbsId=${masterVO.bbsId}" class="${icn}"> <c:out value="${mainExpsrImage.orignlFileNm}" />&nbsp;[<c:out value="${mainExpsrImage.fileMg}" />&nbsp;byte]
								</a>
								<a href="#" onclick="javascript:delFile2('<c:out value ='${mainExpsrImage.atchFileId}'/>', '<c:out value ='${mainExpsrImage.fileSn}'/>', '${masterVO.bbsId}','<c:out value='${mainExpsrImage.fileFieldName }'/>');"> <img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${mainExpsrImage.fileCn}"/> 삭제" />
								</a>
						</c:if> <%-- #main_image 파일이 없을시  처리  --%>
						<c:if test="${empty mainExpsrImage}">
								<input name="mainExpsrImage" type="file" id="mainExpsrImage" class="input_file form-control"  />
								이미지 권장사이즈 : 350*120
						</c:if> <c:set var="mainExpsrImage" value="" />

						</td>
					</tr>
				</tbody>
			</table>
		</div>


	</form>
	<c:if test="${not empty result}">
		<%-- <div class="fl">
		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
	</div>--%>
	</c:if>
</div>

<div class="fr">
	<c:choose>
		<c:when test="${empty result}">
			<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
		</c:when>
		<c:otherwise>
			<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
			<%-- 	<c:if test="${result.delcode eq '0' }" > --%>
			<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
			<%-- 	</c:if> --%>
			<c:if test="${result.delcode eq '1' }">
				<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>복구</span></a>
			</c:if>
		</c:otherwise>
	</c:choose>
	<c:url var="url" value="/bos/dream/${paramVO.programId}/list.do?${pageQueryString}" />
	<a class="btn btn-primary" href="${url}"><span>목록</span></a>
</div>




