
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>
<c:set var="action" value="/bos/job/${paramVO.programId}/cnslInsert.do" />
<script type="text/javascript">
$(function() {
	$(".tbInsertBox").hide();
	$(".cnsltInsert").click(function() {
		$(".tbInsertBox").show();
	})

});

function checkForm() {
	if (!confirm('등록하시겠습니까?')) {
		return false;
	}

	var cont = CrossEditor.GetBodyValue();
	document.getElementById("cnsltReqCn").value= cont;

	var cnsltReqSe = "";
	$(":input[name^=cnsltReqSeData]:checked").each(function(){
		cnsltReqSe += $(this).val() + ",";
	});
	cnsltReqSe = cnsltReqSe.substring(0,cnsltReqSe.length-1);
	$("#cnsltReqSe").val(cnsltReqSe);
	return true;
}

</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>

		<h4>■ 개인정보</h4>
		<div class="bdView">
			<table>
				<caption>
				상담자정보
				</caption>
				<colgroup>
				<col style="width:15%" />
				<col style="width:35%" />
				<col style="width:15%" />
				<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">회원여부</th>
						<td><c:out value="${not empty result.userId ? '회원' : '비회원'}" /></td>
						<th scope="row">아이디</th>
						<td><c:out value="${not empty result.userId ? result.userId : '-'}" /></td>
					</tr>
					<tr>
						<th scope="row" >성명 / 성별</th>
						<td>${result.userNm} /
						<c:forEach var="code" items="${COM079CodeList}" varStatus="status">
								 <c:if test="${fn:indexOf(result.sex, code.code) != -1}">${code.codeNm}</c:if>
						</c:forEach>
						</td>
						<th scope="row">생년월일</th>
						<td><fmt:formatDate value="${result.brthdy}" pattern="yyyy-MM-dd"/></td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td> <c:out value="${result.email}" /></td>
						<th scope="row">휴대폰</th>
						<td>${result.mbtlnum}</td>
					</tr>
					<tr>
					<th scope="row">거주지</th>
					<td colspan="3">
					국적 : <c:if test="${result.resdncSe eq '01'}">국내 </c:if>
						<c:if test="${result.resdncSe eq '02'}">해외 </c:if><br />
						주소 : <c:out value="${result.sidoNm }" />
						<c:out value="${result.gugunNm }"/>
						<c:out value="${result.resdncOvsea }"/>
					</tr>
				</tbody>
			</table>
		</div>

		<h4>■ 추가정보</h4>
		<div class="bdView">
			<table>
				<caption>

				</caption>
				<colgroup>
				<col style="width:15%" />
				<col style="width:35%" />
				<col style="width:15%" />
				<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" >학교</th>
						<td colspan="3"> <c:out value="${result.schul }"/> </td>
					</tr>
					<tr>
						<th scope="row" >학과</th>
						<td colspan="3"> <c:out value="${result.subjct }"/></td>
					</tr>
					<tr>
						<th scope="row" >학년</th>
						<td colspan="3"> <c:out value="${result.grade }"/></td>
					</tr>
					<tr>
						<th>희망직무(공통)</th>
						<td colspan="3"><c:out value="${result.hopeJssfc}" /></td>
					</tr>
					<tr>
						<th>상담신청내용</th>
						<td colspan="3">
						<c:forEach var="code" items="${COM070CodeList}" varStatus="status">
							<c:if test="${fn:indexOf(result.cnsltReqCnSe, code.code) ne -1}">${code.codeNm}</c:if>
						</c:forEach>
						<c:out value="${result.cnsltReqCnEtc }" />
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td colspan="3">
						<jsp:include page="/WEB-INF/jsp/bos/share/EgovFileList.jsp" flush="true" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
<c:if test="${result.delcode eq '1'}">
	<div class="fl">
		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
	</div>
</c:if>

<div class="btnSet">
	<div align="center"  >
		<a class="btn btn-primary" href="/bos/job/${paramVO.programId}/forUpdate.do?cnslSn=${result.cnslSn}&${pageQueryString}&${result.delcode}"><span>수정</span></a>
		<a class="btn btn-primary cnsltInsert" href="#" ><span>상담작성</span></a>
		<c:url var="url" value="/bos/job/${paramVO.programId}/list.do?${pageQueryString}"/>
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>
</div>

<div class="tbInsertBox" >
	<h4>■ 상담내용	</h4>
	<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}" onsubmit="return checkForm(this);">
	<div class="bdView">
			<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
			<input type="hidden" name="cnslSn" value="${result.cnslSn }" />
			<input type="hidden" name="htmlYn" value="${result.htmlYn}" />
			<input type="hidden" name="userSn" id="userSn" value="<c:out value="${result.userSn }" />" />
			<input type="hidden" name="replyAt" value="<c:out value="${not empty result ? 'Y' : 'N' }" />">
			<input type="hidden" name="menuNo" value="${paramVO.menuNo }">
			<input type="hidden" name="cnsltReqSe" id="cnsltReqSe" value="">
			<table>
				<caption>

				</caption>
				<colgroup>
				<col style="width:15%" />
				<col style="width:35%" />
				<col style="width:15%" />
				<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" >희망직종</th>
						<td><input type="text" name="hopeJssfc" id="hopeJssfc" title="희망직종" class="" value="${result.hopeJssfc}" /></td>
						<th scope="row" >희망시기</th>
						<td><input type="text" name="hopeEra" id="hopeEra" title="희망시기" readonly="readonly" class="board1 sdate " value="<fmt:formatDate value="${result.hopeEra}" pattern="yyyy-MM-dd"/>" /></td>
					</tr>
					<tr>
						<th scope="row" ><label for="cnsltReqSeData1" >상담신청구분</label></th>
						<td >
							<c:forEach var="code" items="${COM070CodeList}" varStatus="status">
							<label for="cnsltReqSeData${status.count}">
							<input type="checkbox" name="cnsltReqSeData" id="cnsltReqSeData${status.count}" value="${code.code}" <c:if test="${fn:indexOf(result.cnsltReqSe, code.code) ne -1}">checked="checked"</c:if>>${code.codeNm} </label>
							</c:forEach>
						</td>
						<th> 상담자</th>
						<td><input type="text" name="cnsltNm" value='${result.cnsltNm }'> </td>
					</tr>
					<tr>
						<th scope="row"  colspan="4">상담내용</th>
					</tr>
					<tr>
						<td class="outputEditor" colspan="4">
						<span style="color:red;">* 아래의 작성하시는 내용 (첨부파일 포함)중에 개인정보에 관한 내용이 있다면 개인정보가 타인에게 노출되어 침해 받을 수 있으므로 삭제 후 등록하여 주시기 바랍니다.
						(개인정보내용 : 주민등록번호, 계좌번호, 핸드폰번호 등)
						</span><br/>
							<textarea id="cnsltReqCn" name="cnsltReqCn" cols="150" rows="30" style="display:none;" class="textarea"><c:out value="${result.cnsltReqCn}"/></textarea>
								<script type="text/javascript">
									//<![CDATA[
									var CrossEditor = new NamoSE("crosseditor");
									CrossEditor.params.Font = {"Nanum Gothic":"나눔고딕", "Dotum":"돋움", "Gulim":"굴림", "Batang":"바탕", "Gungsuh":"궁서"};
									CrossEditor.EditorStart();

										var contentValue = document.getElementById("cnsltReqCn").value; // Hidden 값 참조
									function OnInitCompleted(){

									contentValue = contentValue.replace(/#script#/gi, "script");
											CrossEditor.SetBodyValue(contentValue); // 컨텐츠 내용 에디터 삽입
										}
									//]]>
								</script>
						</td>
					</tr>

				</tbody>
			</table>

	</div>
	<input type="submit" value="등록" class="btn btn-primary">
	</form>
</div>