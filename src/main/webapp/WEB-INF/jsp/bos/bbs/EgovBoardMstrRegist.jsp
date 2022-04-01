<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>


<jsp:include page="/WEB-INF/jsp/bos/bbs/com/bbsHead.jsp" flush="true" />

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardMaster" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	function fn_egov_regist_brdMstr(){
		if (!validateBoardMaster(document.boardMaster)){
			return;
		}

		//----------------------------
		// 2009.06.26 : 2단계 기능 추가
		//----------------------------
		var theForm = document.boardMaster;
		if (theForm.bbsTyCode.options[theForm.bbsTyCode.selectedIndex].value == 'BBST04' &&
				theForm.option.options[theForm.option.selectedIndex].value != '') {
			alert('방명록의 경우는 추가 선택사항을 지원하지 않습니다.');
			theForm.option.focus();
			return;
		}
		////--------------------------

		if (confirm('<spring:message code="common.regist.msg" />')) {
			form = document.boardMaster;
			form.action = "<c:url value='/bos/bbs/insertBBSMasterInf.do'/>";
			form.submit();
		}
	}

	function fn_egov_select_brdMstrList(){
		form = document.boardMaster;
		form.action = "<c:url value='/bos/bbs/SelectBBSMasterInfs.do'/>";
		form.submit();
	}

	function fn_egov_inqire_tmplatInqire(){
		form = document.boardMaster;
		var retVal;
		var url = "<c:url value='/cop/com/openPopup.do?requestUrl=/cop/com/selectTemplateInfsPop&typeFlag=BBS&width=850&height=360'/>";
		var openParam = "dialogWidth: 850px; dialogHeight: 360px; resizable: 0, scroll: 1, center: 1";

		retVal = window.showModalDialog(url,"p_tmplatInqire", openParam);
		if(retVal != null){
			var tmp = retVal.split("|");
			form.tmplatId.value = tmp[0];
			form.tmplatNm.value = tmp[1];
		}
	}



</script>

<title>게시판 생성</title>
</head>
<body>
<div id="content">
	<div class="hgroup">
		<h3 >게시판 생성</h3>
	</div>

<form:form commandName="boardMaster" enctype="multipart/form-data" name="boardMaster" method="post">
<input type="hidden" name="pageIndex"  value="<c:out value='${searchVO.pageIndex}'/>"/>

<input type="hidden" name="proBbsAttrbCode"  />
<input type="hidden" name="proUseAt"  />
<input type="hidden" name="proReplyPosblAt"  />
<input type="hidden" name="proFileAtchPosblAt"  />

<div class="bdView">
<table>
	<caption>게시판 쓰기</caption>
	<colgroup>
		<col width="17%"/>
		<col width="83%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="bbsNm">게시판명 <span class="req"><span>필수입력</span></span></label></th>
			<td>
				<input name="bbsNm" type="text" size="60" value='<c:out value="${result.bbsNm}"/>' maxlength="60" class="input_txt wr"/>
	      		<br/><form:errors path="bbsNm" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="bbsIntrcn">게시판 소개 <span class="req"><span>필수입력</span></span></label></th>
			<td>
		      <textarea name="bbsIntrcn" class="textarea"  cols="75" rows="15"  ><c:out value="${result.bbsIntrcn}" escapeXml="true" /></textarea>
		      <form:errors path="bbsIntrcn" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="bbsIntrcn">추가컨텐츠 <span class="req"><span>필수입력</span></span></label></th>
			<td>
		      <textarea name="addCon" class="addCon"  cols="75" rows="15"  ><c:out value="${result.addCon}" escapeXml="true" /></textarea>
		      <form:errors path="addCon" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="bbsTyCode">게시판 유형 <span class="req"><span>필수입력</span></span></label></th>
			<td>
	    	<select name="bbsTyCode">
    	  		<option value='' label="--선택하세요--" />
    	  	<c:forEach var="type" items="${typeList}">
	      		<option value="${type.code}" <c:if test="${type.code==result.bbsTyCode}">selected</c:if> >${type.codeNm}(${type.code})</option>
	      	</c:forEach>
      		<select>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="bbsAttrbCode">게시판 속성 <span class="req"><span>필수입력</span></span></label></th>
			<td>
	    	<select name="bbsAttrbCode">
    	  		<option value='' label="--선택하세요--" />
			<c:forEach var="attrb" items="${attrbList}" varStatus="status">
	      		<option value="${attrb.pageCode}" <c:if test="${attrb.pageCode==result.bbsAttrbCode}">selected</c:if> >${attrb.pageName}(${attrb.pageCode})</option>
	      	</c:forEach>
      		<select>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="replyPosblAt">답장가능여부 <span class="req"><span>필수입력</span></span></label></th>
			<td>
	    	<spring:message code="button.possible" /> : <input type="radio" name="replyPosblAt" class="radio2" value="Y" >&nbsp;
	     	<spring:message code="button.impossible" /> : <input type="radio" name="replyPosblAt" class="radio2" value="N" checked="checked">
	     	<br/><form:errors path="replyPosblAt" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="cmmntPosblAt">커멘트사용여부 <span class="req"><span>필수입력</span></span></label></th>
			<td>
	    	<spring:message code="button.possible" /> : <input type="radio" name="cmmntPosblAt" class="radio2" value="Y" >&nbsp;
	     	<spring:message code="button.impossible" /> : <input type="radio" name="cmmntPosblAt" class="radio2" value="N" checked="checked">
	     	<br/><form:errors path="replyPosblAt" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="bbsIntrcn">파일첨부가능여부 <span class="req"><span>필수입력</span></span></label></th>
			<td>
	     	<spring:message code="button.possible" /> : <input type="radio" name="fileAtchPosblAt" class="radio2" value="Y" checked="checked">&nbsp;
	     	<spring:message code="button.impossible" /> : <input type="radio" name="fileAtchPosblAt" class="radio2" value="N" >
	     	<br/><form:errors path="fileAtchPosblAt" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="preNextPosblAt">이전글다음글가능여부 <span class="req"><span>필수입력</span></span></label></th>
			<td>
	    	<spring:message code="button.possible" /> : <input type="radio" name="preNextPosblAt" class="radio2" value="Y" >&nbsp;
	     	<spring:message code="button.impossible" /> : <input type="radio" name="preNextPosblAt" class="radio2" value="N" checked="checked">
	     	<br/><form:errors path="preNextPosblAt" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="pageUnit">PageUnit <span class="req"><span>필수입력</span></span></label></th>
			<td>
				<input name="pageUnit" type="text" size="20" value='10' maxlength="20" style="width:20%" >
	      		<br/><form:errors path="pageUnit" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="pageSize">pageSize <span class="req"><span>필수입력</span></span></label></th>
			<td>
				<input name="pageSize" type="text" size="20" value='10' maxlength="20" style="width:20%" >
	      		<br/><form:errors path="pageSize" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="tableNm">테이블명<span class="req"><span>필수입력</span></span></label></th>
			<td>
				<input name="tableNm" type="text" size="60" value="TB_BBS_ESTN" maxlength="60" style="width:30%" >
	      		<br/><form:errors path="tableNm" />
			</td>
		</tr>
	</tbody>
</table>
</div>
</form:form>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:fn_egov_regist_brdMstr();"><span>등록</span></a>
		<a class="btn btn-primary" href="javascript:fn_egov_select_brdMstrList();"><span>목록</span></a>
	</div>

</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>
