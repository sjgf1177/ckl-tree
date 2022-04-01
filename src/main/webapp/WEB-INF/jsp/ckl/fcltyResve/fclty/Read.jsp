
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<script type="text/javascript" src="/bos/js/miya_validator.js"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/showModalDialog.js'/>" ></script>
<script type="text/javascript">

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

		if ('${result.option10}' == "") {
			alert("담당자를 지정해주세요.");
			return;
		}

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
		retVal = window.showModalDialog(url, varParam, openParam, 'showModalDialogDeptAuthorCallback');
		if (retVal) {
	        document.board.deptId.value = retVal.deptId;
	        document.board.userId.value = retVal.userId;
	        document.board.userName.value = retVal.userName;
		}
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

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
</head>

<div id="content">

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}">

	<div class="bdView">
		<table summary="게시구분,게시기간,제목,사업부,작성자,전화번호,이메일,내용,첨부,등록일,조회수,답변상태  포함">
			<caption>${masterVO.bbsNm} - 쓰기</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">접수일시</th>
					<td>${result.regDate}</td>
				</tr>
				<tr>
					<th scope="row"><label for="replyAt">답변상태</label></th>
					<td>
						${result.replyAt eq 'Y' ? '완료' : '미완료'}
					</td>
				</tr>
				<tr>
					<th scope="row">작성자</th>
					<td>
						${result.ntcrNm} (${result.option20 })
					</td>
				</tr>
				<tr>
					<th scope="row">연락처</th>
					<td>
						${result.ntcrTel}
					</td>
				</tr>
				<tr>
					<th scope="row">이메일</th>
					<td>
						${result.ntcrEmail}
					</td>
				</tr>
				<tr>
					<th scope="row">답변자 지정</th>
					<td>
				      <input type="text" id="userName" name="userName" value="${empty result.option10 ? cMenu.userName : result.userNm}" size="30" class="txaIpt" maxlength="30" readonly="readonly"  style="width:100px"/>
				      <input type="hidden" id="deptId" name="deptId" value="${cMenu.deptId}" class="board1 w100" readonly="readonly" />
				      <input type="hidden" id="userId" name="option10" value="${empty result.option10 ? cMenu.userId : result.option10}" class="board1 w100" readonly="readonly" />
					  <a class="btn btn-default btn-sm" href="javascript:fncSelectDeptAuthorPop();" ><span>조회</span></a>
					  <a class="btn btn-default btn-sm" href="javascript:chargerChange();" ><span>지정하기</span></a>
					</td>
				</tr>

			<c:if test="${result.bbsId eq 'B0000038'}">
				<tr>
					<th scope="row">질문분류</th>
					<td>
						<c:choose>
							<c:when test="${result.option1 eq '01'}">현장교육</c:when>
							<c:when test="${result.option1 eq '02'}">온라인교육</c:when>
							<c:when test="${result.option1 eq '03'}">창의인재동반</c:when>
							<c:when test="${result.option1 eq '04'}">취업정보</c:when>
						</c:choose>
					</td>
				</tr>
			</c:if>

				<tr>
					<th scope="row">제목</th>
					<td>
						${result.nttSj}
					</td>
				</tr>
				<tr>
					<th scope="row" class="con_tit">내용</th>
					<td class="outputEditor">
<%-- 						<c:choose>
							<c:when test="${result.htmlYn eq 'Y'}">${result.nttCn}</c:when>
							<c:otherwise>
								<% pageContext.setAttribute("crlf", "\n"); %>
								${fn:replace(result.nttCn, crlf, "<br/>")}
							</c:otherwise>
						</c:choose> --%>
						<% pageContext.setAttribute("crlf","\r\n"); %>
						${fn:replace(fn:replace(fn:escapeXml(result.nttCn), crlf, '<br/>') , ' ', '&nbsp;')}
					</td>
				</tr>

		<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
			<tr>
				<th scope="row">첨부파일</th>
				<td>
					<jsp:include page="/WEB-INF/jsp/bos/share/EgovFileList.jsp" flush="true" />
				</td>
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
<c:if test="${masterVO.replyPosblAt eq 'Y' and result.parnts eq 0 and not empty reply}">
<br/>
<br/>
<br/>


<h3 id="answerH3" class="tit_03">답변</h3>
<div class="bdView">
<table>
	<caption>답변</caption>
	<colgroup>
		<col width="15%"/>
		<col width="85%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="ntcrNm2">담당자</label></th>
			<td>${reply.ntcrNm}</td>
		</tr>
		<%-- <tr>
			<th scope="row"><label for="nttSj">제목</label></th>
			<td>${reply.nttSj}</td>
		</tr> --%>
		<tr>
			<th scope="row" class="con_tit"><label for="nttCn2">답변내용</label></th>
			<td class="outputEditor">
				<c:choose>
					<c:when test="${result.htmlYn=='Y'}">${reply.nttCn}</c:when>
					<c:otherwise>
						<% pageContext.setAttribute("crlf", "\n"); %>
						${fn:replace(reply.nttCn, crlf, "<br/>")}
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</tbody>
</table>
</div>

</c:if>

</div>
