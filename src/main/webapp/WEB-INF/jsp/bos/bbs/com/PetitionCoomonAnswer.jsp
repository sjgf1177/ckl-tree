
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<ccc:constantsMap className="kr.co.unp.petition.status.PetitionStatus" var="PetitionStatus"/>
<ccc:constantsMap className="kr.co.unp.bbs.vo.BoardVO" var="BoardVO"/>
<%-- 부서지정필요시
	<form id="receiptFrm" name="receiptFrm" method="post" action="#" >
		<input type="hidden" name="pageIndex" value="${boardVO.pageIndex}"/>
		<input type="hidden" name="nttId" value="${result.nttId}" />
		<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />

	<h3 class="tit_03">부서지정하기</h3>
	<div class="bdView">
	<table>
		<caption>답변쓰기</caption>
		<colgroup>
			<col width="15%"/>
			<col width="85%"/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><label for="deptId">담당부서</label></th>
				<td>
					<select id="deptId" name="deptId" title="부서선택">
					   <option value=''>--부서선택</option>
						<c:forEach var="dept" items="${deptList}" varStatus="status">
						<option value="${dept.deptId}" <c:if test="${dept.deptId eq result.deptId}">selected="selected"</c:if>>${dept.deptNm}</option>
						</c:forEach>
					</select>
					<a class="btn btn-primary" id="assignDeptA" href="javascript:void(0)"><span>부서지정하기</span></a>
				</td>
			</tr>
		</tbody>
	</table>
	</div>


	</form>
 --%>
<script type="text/javascript">
function openPopup(patName1,patName2)
	{
		url = "/bos/deptPop/list.do?patName1="+patName1+"&amp;patName2="+patName2+"&amp;board=Y";
		window.open(url, "deptName", "resizable=no, status=no, scrollbars=no, toolbar=no, menubar=no, width=800, height=700");
	}
</script>
<c:if test="${boardVO.type eq PetitionStatus.ANSWERING}" >
<br/>
<br/>
<form id="answeringFrm" name="answeringFrm" method="post" enctype="multipart/form-data" action="/bos/appStatus/answeringWithFile.do" >
	<input type="hidden" name="pageIndex" value="${boardVO.pageIndex}"/>
	<input type="hidden" name="nttId" value="${empty answeringVO ? 0 : answeringVO.nttId}" />
	<input type="hidden" name="parnts" value="${result.nttId}" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId1" name="atchFileId" value="${answeringVO.atchFileId }">
	<input type="hidden" id="answerType" name="answerType" value="1">

<h3 id="answerH3" class="tit_03">중간답변</h3>
<div class="bdView">
<table>
	<caption>중간답변쓰기</caption>
	<colgroup>
		<col width="15%"/>
		<col width="85%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="ntcrNm1">이름</label></th>
			<td>
				<input type="text" name="ntcrNm" id="ntcrNm1" value="${empty answeringVO ? user.userName : answeringVO.ntcrNm}" style="width:300px" class="board1" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="ntcrDept1">소속</label></th>
			<td>
				<input type="text" class="w230" name="ntcrDept" value="${empty answeringVO ? user.deptName : answeringVO.ntcrDept}" id="ntcrDept1" readonly="readonly"/>
				<input type="hidden" class="btn btn-default" name="deptId" value="${empty result.deptId ? user.deptId : result.deptId}" id="deptId1"/>
				<input type="button" class="btn btn-default" name="user" value="소속과 찾기" onclick="openPopup('ntcrDept1', 'deptId1')" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="ntcrMobile1">전화번호</label></th>
			<td>
				<input type="text" name="ntcrMobile" id="ntcrMobile" value="${empty answeringVO ? user.userPhone : answeringVO.ntcrMobile}" style="width:300px" class="board1" />
			</td>
		</tr>
		<tr>
			<th scope="row" class="con_tit"><label for="nttCn1">답변</label></th>
			<td class="outputEditor">
					<textarea id="nttCn1" name="nttCn" cols="150" rows="50">${answeringVO.nttCn}</textarea>
						 <script type="text/javascript">
						var contentValue = document.getElementById("nttCn1").value;
						var CrossEditor = new NamoSE("nttCn1");
						CrossEditor.SetBodyStyle('background-color','#fff');
						//CrossEditor.SetBodyStyle('background-image','none');
						CrossEditor.SetBodyStyle('font-size','12px');
						CrossEditor.SetBodyStyle('Font-Family','돋움');

						CrossEditor.params.UserToolbar = true ;
						CrossEditor.params.CreateToolbar = "fontname|fontsize|lineheight|word_style|spacebar|word_color|spacebar|word_justify|spacebar|word_indentset|word_listset|enter|undo|redo|spacebar|search|replace|hyperlink|inserthorizontalrule|spacebar|image|backgroundimage|specialchars|emoticon|tableinsert";
						CrossEditor.params.Font = ["고딕","굴림","궁서","나눔명조","맑은 고딕","바탕","신명조","휴먼고딕","Arial","Courier New","Tahoma","Tahoma","Times New Roman","Verdana"];
						CrossEditor.editorStart();
						function OnInitCompleted(){
		                  CrossEditor.SetValue(contentValue); // 컨텐츠 내용 에디터 삽입
		                }
						</script>
			</td>
		</tr>
		<tr>
			<th scope="row">등록된 첨부파일</th>
			<td>
				<jsp:include page="/WEB-INF/jsp/bos/share/PetitionFileList.jsp" flush="false" >
					<jsp:param name="fileStatus" value="answering"/>
				</jsp:include>
			</td>
		</tr>
		<tr>
			<th scope="row">첨부파일</th>
			<td>
				<jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" />
			</td>
		</tr>
	</tbody>
</table>
</div>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:answeringFrm(document.answeringFrm);"><span>중간답변등록</span></a>
	</div>
</form>
</c:if>

<c:if test="${boardVO.type eq PetitionStatus.COMPLETE_ANSWER}" >
<br/>
<br/>
<form id="completeAnswerFrm" name="completeAnswerFrm" method="post" enctype="multipart/form-data" action="/bos/appStatus/completeAnswerWithFile.do" >
	<input type="hidden" name="pageIndex" value="${boardVO.pageIndex}"/>
	<input type="hidden" name="nttId" value="${empty completeAnswerVO ? 0 : completeAnswerVO.nttId}" />
	<input type="hidden" name="parnts" value="${result.nttId}" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId2" name="atchFileId" value="${completeAnswerVO.atchFileId}">
	<input type="hidden" id="answerType" name="answerType" value="2">

<h3 id="answerH3" class="tit_03">최종답변</h3>
<div class="bdView">
<table>
	<caption>답변쓰기</caption>
	<colgroup>
		<col width="15%"/>
		<col width="85%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="ntcrNm2">이름</label></th>
			<td>
				<input type="text" name="ntcrNm" id="ntcrNm2" value="${empty completeAnswerVO ? user.userName : completeAnswerVO.ntcrNm}" style="width:300px" class="board1" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="ntcrDept2">소속</label></th>
			<td>
				<input type="text" class="w230" name="ntcrDept" value="${empty completeAnswerVO ? user.deptName : completeAnswerVO.ntcrDept}" id="ntcrDept2" readonly="readonly"/>
				<input type="hidden" class="btn btn-default" name="deptId" value="${empty result.deptId ? user.deptId : result.deptId}" id="deptId2"/>
				<input type="button" class="btn btn-default" name="user" value="소속과 찾기" onclick="openPopup('ntcrDept2', 'deptId2')" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="ntcrMobile2">전화번호</label></th>
			<td>
				<input type="text" name="ntcrMobile" id="ntcrMobile2" value="${empty completeAnswerVO ? user.userPhone :  completeAnswerVO.ntcrMobile}" style="width:300px" class="board1" />
			</td>
		</tr>
		<tr>
			<th scope="row" class="con_tit"><label for="nttCn2">답변</label></th>
			<td class="outputEditor">
				<textarea id="nttCn2" name="nttCn" cols="150" rows="50"></textarea>
						 <script type="text/javascript">
						var contentValue = document.getElementById("nttCn2").value;
						var CrossEditor = new NamoSE("nttCn2");
						CrossEditor.SetBodyStyle('background-color','#fff');
						//CrossEditor.SetBodyStyle('background-image','none');
						CrossEditor.SetBodyStyle('font-size','12px');
						CrossEditor.SetBodyStyle('Font-Family','돋움');

						CrossEditor.params.UserToolbar = true ;
						CrossEditor.params.CreateToolbar = "fontname|fontsize|lineheight|word_style|spacebar|word_color|spacebar|word_justify|spacebar|word_indentset|word_listset|enter|undo|redo|spacebar|search|replace|hyperlink|inserthorizontalrule|spacebar|image|backgroundimage|specialchars|emoticon|tableinsert";
						CrossEditor.params.Font = ["고딕","굴림","궁서","나눔명조","맑은 고딕","바탕","신명조","휴먼고딕","Arial","Courier New","Tahoma","Tahoma","Times New Roman","Verdana"];
						CrossEditor.editorStart();
						function OnInitCompleted(){
		                  CrossEditor.SetValue(contentValue); // 컨텐츠 내용 에디터 삽입
		                }
						</script>
			</td>
		</tr>
		<tr>
			<th scope="row">등록된 첨부파일</th>
			<td>
				<jsp:include page="/WEB-INF/jsp/bos/share/PetitionFileList.jsp" flush="false" >
					<jsp:param name="fileStatus" value="completeAnswer"/>
				</jsp:include>
			</td>
		</tr>
		<tr>
			<th scope="row">첨부파일</th>
			<td>
				<jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" />
			</td>
		</tr>
	</tbody>
</table>
</div>
</form>
	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:completeAnswerFrm(this);"><span>최종답변</span></a>
	</div>
</c:if>