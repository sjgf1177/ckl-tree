
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<script type="text/javascript">

	function del(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	}


	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delPermanently.do";
		form.submit();
	}

	$(function() {
		var nttType = "${result.nttType}";
		if( nttType == '${BoardVO.BASIC_NTT_TYPE}' )
	    {
			$("#ntcrDeTr").hide();
	    }
	});

	function checkForm2() {
		var form = document.replyFrm;
		var v = new MiyaValidator(form);
	    v.add("nttSj", {
	        required: true
	    });
	    v.add("ntcrNm", {
	        required: true
	    });
	    v.add("nttCn", {
	        required: true
	    });
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (confirm('등록하시겠습니까?')) {
			form.submit();
		}
	}

	function del(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	}

	function restore(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/restore.do";
		form.submit();
	}

	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delPermanently.do";
		form.submit();
	}

	function replyInsertRe(){
		var form = $("#board")[0];

		form.action = "/bos/bbs/${paramVO.bbsId}/forInsertRe.do?parnts=${result.nttId}&menuNo=${param.menuNo}";
		form.submit();
	}

	function fncSelectDeptAuthorPop() {
		var retVal;
		var url = "/bos/member/listPop.do";
		var varParam = new Object();
		// IE
		//var openParam = "dialogWidth:500px;dialogHeight:325px;scroll:no;status:no;center:yes;resizable:yes;";
		// FIREFOX
		var openParam = "dialogWidth:1000px;dialogHeight:900px;scroll:no;status:no;center:yes;resizable:no;";
		//retVal = window.showModalDialog(url, varParam, openParam, 'showModalDialogDeptAuthorCallback');
		window.open(url,"authorPop","width=1000, hegiht=1200");
		/*
		if (retVal) {
	        document.board.deptId.value = retVal.deptId;
	        document.board.userId.value = retVal.userId;
	        document.board.userName.value = retVal.userName;
		}
		*/
	}

	function showModalDialogDeptAuthorCallback(retVal) {
		if (retVal) {
	        document.board.deptId.value = retVal.deptId;
	        document.board.userId.value = retVal.userId;
	        document.board.userName.value = retVal.userName;
		}
	}

    function chargerChange() {
		if ($("#userId").val() == "") {
			alert("담당자를 지정해주세요.");
			return;
		}
		if (!confirm('담당자를 지정겠습니까?')) {
			return;
		}
		$.post(
			"/bos/bbs/${masterVO.bbsId}/chargerChange.json",
			{nttId : '${param.nttId}', option10 : $("#userId").val()},
			function(data)
			{
				if (data.resultCode == "success") {
					alert("담당자가 지정되었습니다.");
					location.reload();
				}
			},"json"
		);
    }
 
</script>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}" />

	<div class="bdView">
		<table summary="제목,내용,첨부파일,<c:if test="${not empty result}">등록일,</c:if><c:if test="${not empty result}">조회수,</c:if> 포함">
			<caption>${result.nttSj} (읽기)</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>


				<tr>
					<th scope="row">제목</th>
					<td>
						${fn:trim(result.nttSj) eq '' or empty result.nttSj ? '제목 없음' : result.nttSj}
					</td>
				</tr>
				
				<tr>
					<th scope="row">작성자</th>
					<td>
						${result.ntcrNm}
					</td>
				</tr>

				<tr>
					<th scope="row">내용</th>
					<td>
						<div class="outputEditor" id="dbdata">
							<c:choose>
								<c:when test="${result.htmlYn=='Y'}">${result.nttCn}</c:when>
								<c:otherwise>
									<% pageContext.setAttribute("crlf", "\n"); %>
									${fn:replace(result.nttCn, crlf, "<br/>")}
								</c:otherwise>
							</c:choose>
						</div>
					</td>
				</tr>

			<c:if test="${result.atchFileId ne ''}">
				<tr>
					<th scope="row">첨부파일</th>
					<td>
						<jsp:include page="/WEB-INF/jsp/bos/share/EgovFileList.jsp" flush="true" />
					</td>
				</tr>
			</c:if>

			<c:if test="${not empty result}">
				<tr>
					<th scope="row">등록일</th>
					<td>${result.regDate}</td>
				</tr>
			</c:if>

			<c:if test="${not empty result}">
				<tr>
					<th scope="row">최종수정일</th>
					<td>${result.uptDate}</td>
				</tr>
			</c:if>


			</tbody>
		</table>
	</div>
</form>

<c:set var="reply" value="${replyList[0]}" />
<c:if test="${not empty result}">
<div class="fl">
	<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
</div>
</c:if>
<div class="fr" >
	<c:choose>
	<c:when test="${empty reply}">
	<a class="btn btn-primary" href="javascript:replyInsertRe();"><span>답변등록</span></a><%--
	<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/forInsertRe.do?parnts=${result.nttId}&${pageQueryString}"><span>답변등록</span></a> --%>
	</c:when>
	<c:otherwise>
	<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/forUpdateRe.do?nttId=${reply.nttId}&parnts=${reply.parnts}&${pageQueryString}"><span>답변수정</span></a>
	<a class="btn btn-danger" href="/bos/bbs/${paramVO.bbsId}/delete.do?nttId=${reply.nttId}&parnts=${reply.parnts}&${pageQueryString}" onclick="return confirm('정말로 삭제하시겠습니까?');" ><span>답변삭제</span></a>
	</c:otherwise>
	</c:choose>
	<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/forUpdate.do?nttId=${result.nttId}&bbsId=${result.bbsId}&${pageQueryString}&${result.delcode}"><span>수정</span></a>
	<c:if test="${result.delcode eq '0' }" >
		<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:if>
	<c:if test="${result.delcode eq '1' }" >
		<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>원글복구</span></a>
	</c:if>
	<c:url var="url" value="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" />
	<a class="btn btn-primary" href="${url}"><span>목록</span></a>
</div>

<%-- 
<div class="btnSet">
	<div class="fl">
		<c:if test="${not empty result}">
<!-- 		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a> -->
		</c:if>

		<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
		<a class="btn btn-default" href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap['PREV'].prevNttId}&${pageQueryString}"><span>이전글</span></a>
	    </c:if>
		<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
		<a class="btn btn-default" href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap['NEXT'].nextNttId}&${pageQueryString}"><span>다음글</span></a>
	    </c:if>
	</div>
	<div class="fr" >
		<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/forUpdate.do?nttId=${result.nttId}&${pageQueryString}&${result.delcode}"><span>수정</span></a>
		<c:if test="${result.delcode eq '0' }" >
		<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
		</c:if>
		<c:if test="${result.delcode eq '1' }" >
		<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>원글복구</span></a>
		</c:if>
		<c:url var="url" value="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" />
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>
</div>
 --%>