<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="egovframework.com.cmm.service.FileVO"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="fileList" items="${fileList}" varStatus="status">
	<c:if test="${fileList.fileFieldName eq 'file1' }">
		<c:set var="fileVO" value="${fileList }"/>
	</c:if>
</c:forEach>
<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<!-- 벨리데이션 체크 -->
<script type="text/javascript">

	function checkAndSubmit() {
		var contentLength = $('#projectNm').val().length;

		if(contentLength > 50){
			alert('프로젝트명은 50자까지 입력 할 수 있습니다.');
		return;
		}
		
		var form = $("#fm")[0];
		var f    = document.fm; 
		var v    = new MiyaValidator(form);
		
		  v.add("projectNm", {
		        required: true
		    });
		    v.add("expert", {
		        required: true
		    });
		    v.add("students", {
		        required: true
		    });
		   /*  v.add("projectSummary", {
		        required: true
		    }); */
		
		result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}
		
		var $usrtAt= $("input[type=radio][name=useAt1]:checked").val();
		$("#publish").val($usrtAt); 
	
		if (!confirm("${empty result ? '등록' : '수정'}하시겠습니까?")) {
		    return;
		}
		
		var cont = CrossEditor.GetBodyValue();
		document.getElementById("projectSummary").value= cont;
		form.submit();
		
	
	function delFile(atchFileId, fileSn){
		if (!confirm('삭제 하시겠습니까?')) {
			return false;
		}
		
		$.getJSON(
				"/bos/cmm/fms/deleteFileInfs.json",
				{atchFileId : atchFileId, fileSn : fileSn},
				function(data){
					var jdata = data.resultCode;
		            if( jdata == 'success' ) {
		            	alert("성공적으로 삭제하였습니다.");
		            	location.reload();
		            	//$("#realfile_"+fileSn).html("");
		            }else 
		            	alert("삭제에 실패하였습니다.");
				}
			);
		}
	}
	
	function del(){
		var form = $("#fm")[0];
		form.action = "/bos/archive/deptListDelete.do";
		
		form.submit();
	}

</script>

<!-- 프로젝트 등록인지 수정인지 -->
<c:set var="action" value="${empty result ? '/bos/archive/deptListInsert.do' : '/bos/archive/deptListUpdate.do'}" />

<form id="fm" name="fm" method="post" action="${action}" enctype="multipart/form-data">
	<input type="hidden" name="atchFileId"    id="atchFileId"    value="${result.atchFileId}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}">
	<input type="hidden" id="menuNo" name="menuNo" value="${param.menuNo}" />
	<input type="hidden" name="archiveTaskSeq" value="${param.taskSeq}">
	<input type="hidden" id="publish" name="publish" value="" />
	
	<c:if test="${not empty result}">
		<input type="hidden" name="archiveProjectSeq" value="${result.archiveProjectSeq}" />
	</c:if>
	
	<input type="hidden" name="lastUpdusrId" value="${user.userId}" />
	
	<div class="bdView">
		<table>
			<caption>아카이브 프로젝트 수정/등록</caption>
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="35%"/>
			</colgroup>
			<tbody>
				
				<tr>
					<th scope="row"><label for="projectNm">*프로젝트명</label></th>
					<td class="output" colspan="3">
						<input type="text" id="projectNm" name="projectNm" value="${result.projectNm}" style="width:500px" class="board1" />
					</td>
				</tr>
				
				<tr>
					<th scope="row"><label for="expert">*전문가</label></th>
					<td class="output" colspan="3">
						<input type="text" id="expert" name="expert" value="${result.expert}" style="width:500px" class="board1" />
					</td>
				</tr>
			
				<tr>
					<th scope="row"><label for="students">*교육생</label></th>
					<td class="output" colspan="3">
						<input type="text" id="students" name="students" value="${result.students}" style="width:500px" class="board1"/>
					</td>
				</tr>
				<tr>
					<th scope="row" class="con_tit"><label for="projectSummary">*프로젝트 개요</label></th>
					<td class="outputEditor" colspan="3">
						<span style="color:red;">* 아래의 작성하시는 내용 (첨부파일 포함)중에 개인정보에 관한 내용이 있다면 개인정보가 타인에게 노출되어 침해 받을 수 있으므로 삭제 후 등록하여 주시기 바랍니다.
						(개인정보내용 : 주민등록번호, 계좌번호, 핸드폰번호 등)
						</span><br/>
						<textarea id="projectSummary" name="projectSummary" cols="120" rows="4" style="display:none;" class="textarea">${result.projectSummary}</textarea>
						<script type="text/javascript">
						//<![CDATA[
							var CrossEditor = new NamoSE("crosseditor");
							CrossEditor.params.Font = {"Nanum Gothic":"나눔고딕", "Dotum":"돋움", "Gulim":"굴림", "Batang":"바탕", "Gungsuh":"궁서"};
							CrossEditor.EditorStart();

							var contentValue = document.getElementById("projectSummary").value; // Hidden 값 참조
							function OnInitCompleted(){

								//contentValue = contentValue.replace(/#script#/gi, "script");
								CrossEditor.SetBodyValue(contentValue); // 컨텐츠 내용 에디터 삽입
							}
						//]]>
						</script>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="resultVideo">성과물 동영상</label></th>
					<td class="output" colspan="3">
						<input type="text" id="resultVideo" name="resultVideo" value="${result.resultVideo}" style="width:500px" class="board1"/>
					</td>
				</tr>
				
				<tr>
					<th scope="row"><label for="resultUrl">성과물 URL</label></th>
					<td class="output" colspan="3">
						<input type="text" id="resultUrl" name="resultUrl" value="${result.resultUrl}" style="width:500px" class="board1"/>
					</td>
				</tr>
				
				<!-- ######## 첨부파일 관련 ######### -->	
				<tr>
				    <th scope="row">프로젝트썸네일</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType"      value="img"/>
							<c:param name="fileFieldName" value="projectImg"/>
							<c:param name="updateFlag"    value="Y"/>
						</c:import>
						<input type="file" name="projectImg" id="projectImg" title="프로젝트 썸네일" class="col-md-8">
						<br/><br/>※ 올리시는 파일명을 모두 다르게 입력하여 주십시오.※
					</td>
				</tr>
				
				<tr>
					<th scope="row">성과물 이미지</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType"      value="img"/>
							<c:param name="fileFieldName" value="resultImg"/>
							<c:param name="updateFlag"    value="Y"/>
						</c:import>
						<input type="file" name="resultImg" id="resultImg" title="성과물 이미지" class="col-md-8">
						<br/><br/>※ 올리시는 파일명을 모두 다르게 입력하여 주십시오.※
					</td>
				</tr>
				<%-- 
				<c:if test="${not empty fileList}">
				<tr>
					<th scope="row">첨부된 첨부파일</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="noImg"/>
							<c:param name="updateFlag" value="Y"/>
						</c:import>
					</td>
				</tr>
				</c:if>
				<tr>
					<th scope="row">성과물기타파일</th>
					<td colspan="3">
						<jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" />
					</td>
				</tr>
				--%>
				
				
				<%-- 
				<tr>
					<th scope="row">첨부파일</th>
					<td colspan="3">
						<c:forEach var="fileVO" items="${fileList}" varStatus="status">
							<c:if test="${fileVO.fileFieldName ne 'mainImg'}">
								<a href="/edu/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${param.bbsId}" class="${icn}">
									<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
								</a>
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(fileList) == 0}">등록된 첨부파일이 없습니다.</c:if>
					</td>
				</tr>
				--%>
 				<%-- 
				<tr>
					<th scope="row">성과물기타파일</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType"      value="noImg"/>
							<c:param name="fileFieldName" value="resultEtcFile"/>
							<c:param name="updateFlag"    value="Y"/>
						</c:import>
						<input type="file" name="resultEtcFile" id="resultEtcFile" title="성과물기타파일" class="col-md-8">
						<br/><br/>※ 올리시는 파일명을 모두 다르게 입력하여 주십시오.※					
					</td>
				</tr> 
				--%>
				
				<!-- 
				<tr>
					<th scope="row">성과물기타파일</th>
					<td colspan="3">
						<jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" />
					</td>
				</tr>
				-->
				
				<!-- ######## 첨부파일 관련 ######### -->	
				
				<tr>
					<th scope="row">*주요성과여부</th>
					<td class="output" colspan="3">
						<input type="radio" id="mainResultAt1" name="mainResultAt" value="Y" class="ra" <c:if test="${result.mainResultAt eq 'Y'}">checked</c:if> /> 사용
						<label for="publish_N">
						<input type="radio" id="mainResultAt2" name="mainResultAt" value="N" class="ra" <c:if test="${empty result or result.mainResultAt eq 'N'}">checked</c:if> /> 미사용
						</label>
					</td>
				</tr> 
				
				<tr>
					<th scope="row">*사용 여부</th>
					<td class="output" colspan="1">
							<input type="radio" id="useAt1" name="projectUseAt" value="Y" class="ra" <c:if test="${result.projectUseAt eq 'Y'}">checked</c:if> /> 사용
						<label for="publish_N">
							<input type="radio" id="useAt2" name="projectUseAt" value="N" class="ra" <c:if test="${empty result or result.projectUseAt eq 'N'}">checked</c:if> /> 미사용
						</label>
					</td>
					<th scope="row">*공개 여부</th>
					<td class="output" colspan="1">
							<input type="radio" id="openAt1" name="openAt" value="Y" class="ra" <c:if test="${result.openAt eq 'Y'}">checked</c:if> /> 공개
						<label for="publish_N">
							<input type="radio" id="openAt2" name="openAt" value="N" class="ra" <c:if test="${empty result or result.openAt eq 'N'}">checked</c:if> /> 비공개
						</label>
					</td>
				</tr> 
					
				<c:if test="${not empty result}">
					<tr>
						<th scope="row">등록자</th>
						<td>${result.userNm}</td>
						<th scope="row">등록일</th>
						<td>${result.projectFirstDate}</td>
					</tr>
				</c:if>
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
			<a href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');" class="btn btn-danger">삭제</a>
		</c:otherwise>
	</c:choose>
	
	<c:url value="/bos/archive/deptList.do?taskSeq=${param.taskSeq}&menuNo=${param.menuNo}" var="list_url" />
	<a class="btn btn-primary" href="${list_url}"><span>목록</span></a>
</div>
	
