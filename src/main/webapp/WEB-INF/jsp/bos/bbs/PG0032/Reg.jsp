
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

$(function() {
	$(".sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});

	//첨부이미지 검사
	$(".file_images_td input[type='file']").focus(function(){
	});
});


	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);

	    v.add("nttSj", {
	        required: true
	    });

	    v.add("option1", {
	        required: true
	    });

	    v.add("option2", {
	        required: true
	    });
	    
	    v.add("ntceBgnde", {
	        required: true
	    });
	    
	    //파일
		if ( $("#main_image").length > 0 )
		    v.add("main_image", {
		        required: true
		    });
	    /* 
		if ( $("#realfile_1").length == 0 )
			v.add("file_1", {
		        required: true
		    });
		 */

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
		form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	}

	function delFile2(atchFileId, fileSn, bbsId, fileId){
		$.getJSON(
				"/bos/cmm/fms/deleteFileInfs.json",
				{atchFileId : atchFileId, fileSn : fileSn, bbsId : bbsId},
				function(data)
				{
					var jdata = data.resultCode;
		            if( jdata == 'success' ) {
		            	alert("성공적으로 삭제하였습니다.");
		            	$("#"+fileId).html("<input type=\"file\" name=\""+fileId+"\" id=\""+fileId+"\" class=\"input_file form-control\"/> 이미지 권장사이즈 : 335*245");
		            }
		            else alert("삭제에 실패하였습니다.");
				}
			);
	}

</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
</head>

<div id="content">

	<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
		<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
		<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
		<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
		<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}">
		<input type="hidden" name="htmlYn" value="${result.htmlYn}" />
		<input type="hidden" name="nttType" value="1" />

		<div class="bdView">
			<table summary="<c:if test="${roleSuper eq 'Y'}">게시구분,게시기간,</c:if>제목,담당부서,내용<c:if test="${not empty result}">등록일,</c:if><c:if test="${not empty result}">조회수,</c:if> 포함">
				<caption>${masterVO.bbsNm} - ${empty result ? '쓰기' : '수정'}</caption>
				<colgroup>
					<col style="width: 15%" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="useAt">메인노출</label></th>
						<td>
							<label>
								<input type="radio" name="useAt" id="useAt" value="Y" ${result.useAt eq 'Y' || result.parent eq null?'checked':''} />
								허용
							</label>
							<label>
								<input type="radio" name="useAt" id="useAt" value="N" ${result.useAt eq 'N'?'checked':''} />
								비허용
							</label>
						</td>
					</tr>
					
					<tr>
						<th scope="row"><label for="nttSj">업체명</label></th>
						<td><input type="text" name="nttSj" id="nttSj" class="w500" value="<c:out value="${result.nttSj}" />" /></td>
					</tr>
					
					<tr>
						<th scope="row"><label for="option1">콘텐츠분류</label></th>
						<td><input type="text" name="option1" id="option1" class="w500" value="<c:out value="${result.option1}" />" /></td>
					</tr>
					
					<tr>
						<th scope="row"><label for="option2">대표자</label></th>
						<td><input type="text" name="option2" id="option2" class="w100" value="<c:out value="${result.option2}" />" /></td>
					</tr>
					
					<tr>
						<th scope="row">
							<label for="ntceBgnde">설립일</label>
						</th>
						<td>
							<input id="ntceBgnde" name="ntceBgnde" value="${result.ntceBgnde}" readonly="readonly" type="text" class="board1 sdate" title="설립일" />
						</td>
					</tr>
					
					<tr>
						<th scope="row" class="con_tit"><label for="nttCn">내용</label></th>
						<td class="outputEditor"><span style="color: red;">* 아래의 작성하시는 내용 (첨부파일 포함)중에 개인정보에 관한 내용이 있다면 개인정보가 타인에게 노출되어 침해 받을 수 있으므로 삭제 후 등록하여 주시기 바랍니다. (개인정보내용 : 주민등록번호, 계좌번호, 핸드폰번호 등) </span><br /> <textarea id="nttCn" name="nttCn" cols="150" rows="30" style="display: none;" class="textarea">${result.nttCn}</textarea> <script type="text/javascript">
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
						</script></td>
					</tr>
					
					<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
		<%--########################### MAIN_IMAGE 시작 --%>
			<%--이미지 탐색 main_image 처리 --%>
					<c:if test="${fn:length(fileList) gt 0}">
						<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
							<c:if test="${fileList[x].fileFieldName eq 'main_image'}">
								<c:set var="fileVO" value="${fileList[x]}"/>
							</c:if>
						</c:forEach>
					</c:if>
			<%--이미지 탐색 main_image 끝 --%>
			<tr>
				<th scope="row">썸네일 이미지 파일</th>
				<td>
					<div style="margin:3px 0;font-weight:bold;">※모든 파일 이름을 다르게 입력해주세요.</div>
			<c:if test="${not empty fileVO}">
			<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
					<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
					</a>
					<a href="#" onclick="javascript:delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','main_image');">
				<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileVO.fileCn}"/> 삭제" />
			</a>
			</c:if>

			<%-- #main_image 파일이 없을시  처리  --%>
			<c:if test="${empty fileVO}">
						<input name="main_image" type="file" id="main_image" class="input_file form-control" title="메인이미지" />
						이미지 권장사이즈 : 335*245
			</c:if>
			<c:set var="fileVO" value=""/>
				</td>
			</tr>
<%--########################### MAIN_IMAGE 끝 --%>

<%--########################### SUB_IMG1 시작 --%>
						<%--이미지 탐색 sub_image1 처리 --%>
					<c:if test="${fn:length(fileList) gt 0}">
						<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
							<c:if test="${fileList[x].fileFieldName eq 'sub_image1' or fileList[x].fileCn eq 'sub_image1'}">
								<c:set var="fileVO" value="${fileList[x]}"/>
							</c:if>
						</c:forEach>
					</c:if>
			<tr>
				<th scope="row">내용이미지 파일1</th>
				<td>
					<%-- #sub_image1 파일이 있을시 처리  --%>
					<c:if test="${not empty fileVO}">
					<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
							<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
							</a>
							<a href="#" onclick="javascript:delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','sub_image1');">
						<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileVO.fileCn}"/> 삭제" />
					</a>
					</c:if>

					<%-- #sub_image1 파일이 없을시  처리  --%>
					<c:if test="${empty fileVO}">
								<input name=sub_image1 type="file" id="sub_image1" class="input_file form-control" title="서브이미지1" />
					</c:if>
					<c:set var="fileVO" value=""/>
				</td>
			</tr>
<%--########################### SUB_IMG1 끝 --%>

<%--########################### SUB_IMG2 시작 --%>
					<%--이미지 탐색 sub_image2 처리 --%>
					<c:if test="${fn:length(fileList) gt 0}">
						<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
							<c:if test="${fileList[x].fileFieldName eq 'sub_image2' or fileList[x].fileCn eq 'sub_image2' }">
								<c:set var="fileVO" value="${fileList[x]}"/>
							</c:if>
						</c:forEach>
					</c:if>
					<%--이미지 탐색 sub_image2 끝 --%>
			<tr>
				<th scope="row">내용이미지 파일2</th>
				<td>
				<%-- #main_image 파일이 있을시 처리  --%>
					<c:if test="${not empty fileVO}">
					<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
							<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
							</a>
							<a href="#" onclick="javascript:delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','sub_image2');">
						<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileVO.fileCn}"/> 삭제" />
					</a>
					</c:if>

					<%-- #main_image 파일이 없을시  처리  --%>
					<c:if test="${empty fileVO}">
								<input name=sub_image2 type="file" id="sub_image2" class="input_file form-control" title="서브이미지2" />
					</c:if>
					<c:set var="fileVO" value=""/>
				</td>
			</tr>
<%--########################### SUB_IMG2 끝 --%>

<%--########################### SUB_IMG3 시작 --%>
					<%--이미지 탐색 sub_image3 처리 --%>
					<c:if test="${fn:length(fileList) gt 0}">
						<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
							<c:if test="${fileList[x].fileFieldName eq 'sub_image3' or fileList[x].fileCn eq 'sub_image3'}">
								<c:set var="fileVO" value="${fileList[x]}"/>
							</c:if>
						</c:forEach>
					</c:if>
					<%--이미지 탐색 sub_image3 끝 --%>
			<tr>
				<th scope="row">내용이미지 파일3</th>
				<td>
					<%-- #main_image 파일이 있을시 처리  --%>
					<c:if test="${not empty fileVO}">
					<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
							<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
							</a>
							<a href="#" onclick="javascript:delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','sub_image3');">
						<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileVO.fileCn}"/> 삭제" />
					</a>
					</c:if>

					<%-- #main_image 파일이 없을시  처리  --%>
					<c:if test="${empty fileVO}">
								<input name=sub_image3 type="file" id="sub_image3" class="input_file form-control" title="서브이미지3" />
	<%-- 						이미지설명 : <input type="text" id="main_image_cn" name="mainImg" title="메인이미지 설명" class="Input_file_infor"/> --%>
					</c:if>
					<c:set var="fileVO" value=""/>
				</td>
			</tr>
<%--########################### SUB_IMG3 끝 --%>

		</c:if>
  					<%--
					<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
						<tr class="file_images_td">
							<th scope="row">관련이미지<br>첨부</th>
							<td>
								<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
								<c:if test="${not empty fileList}">
									<div style="border:1px solid lightgray;padding:10px;margin-bottom:20px;">
										<div>
											첨부된 관련이미지 : 
										</div>
										<div>
											<jsp:include page="/WEB-INF/jsp/bos/share/EgovFileList.jsp" flush="true" />
										</div>
									</div>
								</c:if>
								</c:if>
								<jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" />
							</td>
						</tr>
					</c:if>
					--%> 

					<c:if test="${not empty result}">
						<tr>
							<th scope="row">등록일</th>
							<td>${result.regDate}</td>
						</tr>
					</c:if>

					<c:if test="${not empty result}">
						<tr>
							<th scope="row">조회수</th>
							<td>${result.inqireCo}</td>
						</tr>
					</c:if>


				</tbody>
			</table>
		</div>
	</form>
	<c:if test="${not empty result}">
		<div class="fl">
			<%--	<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>  --%>
		</div>
	</c:if>



	<div class="fr" >
	<c:choose>
	<c:when test="${empty result}" >
		<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
	</c:when>
	<c:otherwise>
		<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
	<c:if test="${result.delcode eq '0' }" >
		<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:if>
	</c:otherwise>
	</c:choose>
		<c:url var="url" value="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}"/>
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
</div>

