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
	/*
	$(function(){
		$("#attrPop").click(function(){
			$.getJSON(
					"/bos/pg/pageAttrList.json",
					{},
					function(data)
					{
			        	$('#bbsAttrbCode').children().remove().end().append('<option value="">--선택하세요--</option>') ;
						var jdata = data.resultList;
			            $.each(jdata, function(index, itemData) {
			            	$("#bbsAttrbCode").append("<option value='"+itemData.pageCode+"'>"+itemData.pageName+"</option>");
			            });
					}
				);
		});
	});
	 */
	function fn_egov_validateForm(obj){
		return true;
	}

	function fn_egov_update_brdMstr(){
		if (!validateBoardMaster(document.boardMaster)){
			return;
		}

		if(confirm('<spring:message code="common.update.msg" />')){
			document.boardMaster.action = "<c:url value='/bos/bbs/UpdateBBSMasterInf.do?menuNo=${param.menuNo}'/>";
			document.boardMaster.submit();
		}
	}

	function fn_egov_select_brdMstrList(){
		document.boardMaster.action = "<c:url value='/bos/bbs/SelectBBSMasterInfs.do?menuNo=${param.menuNo}'/>";
		document.boardMaster.submit();
	}

	function fn_egov_delete_brdMstr(){
		if(confirm('<spring:message code="common.delete.msg" />')){
			document.boardMaster.action = "<c:url value='/bos/bbs/DeleteBBSMasterInf.do?menuNo=${param.menuNo}'/>";
			document.boardMaster.submit();
		}
	}

	function pop()
	{
		var PopWindow = "pop_win";
		var win = window.open( "/bos/pg/pageAttrList.do?bbsId=${result.bbsId}",
		     PopWindow,
		     "toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=800,height=900,left=50,top=50"
		);
	}

/*	function fn_egov_inqire_tmplatInqire(){
		var retVal;
		var url = "<c:url value='/cop/com/openPopup?requestUrl=/cop/com/selectTemplateInfsPop&typeFlag=BBS&width=850&height=360'/>";
		var openParam = "dialogWidth: 850px; dialogHeight: 360px; resizable: 0, scroll: 1, center: 1";

		retVal = window.showModalDialog(url,"p_tmplatInqire", openParam);
		if(retVal != null){
			var tmp = retVal.split("|");
			document.boardMaster.tmplatId.value = tmp[0];
			document.boardMaster.tmplatNm.value = tmp[1];
		}
	}
*/
</script>

<form id="boardMaster" name="boardMaster" action="/bos/bbs/addBBSMaster.do?menuNo=${param.menuNo}" enctype="multipart/form-data" method="post">
<input name="pageIndex" type="hidden" value="${searchVO.pageIndex}"/>
<input name="bbsId" type="hidden" value="<c:out value='${result.bbsId}'/>" />
<!-- <input name="replyPosblAt" type="hidden" value="<c:out value='${result.replyPosblAt}'/>" />  -->
<input type="hidden" name="tmplatId">
<input type="hidden" name="tmplatNm">

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
				<input name="bbsNm" type="text" size="60" value='<c:out value="${result.bbsNm}"/>' maxlength="60" />
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
			<th scope="row">게시판URL</th>
			<td><a href="/bos/bbs/${result.bbsId}/list.do" title="새창열림" target="_blank">/bos/bbs/${result.bbsId}/list.do</a></td>
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
	    	<label><spring:message code="button.possible" /> : <input type="radio" name="replyPosblAt" class="radio2" value="Y" <c:if test="${result.replyPosblAt == 'Y'}"> checked="checked"</c:if>>&nbsp;</label>
	     	<label><spring:message code="button.impossible" /> : <input type="radio" name="replyPosblAt" class="radio2" value="N" <c:if test="${result.replyPosblAt == 'N'}"> checked="checked"</c:if>></label>
	     	<br/><form:errors path="replyPosblAt" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="cmmntPosblAt">커멘트사용여부 <span class="req"><span>필수입력</span></span></label></th>
			<td>
	    	<label><spring:message code="button.possible" /> : <input type="radio" name="cmmntPosblAt" class="radio2" value="Y" <c:if test="${result.cmmntPosblAt == 'Y'}"> checked="checked"</c:if>>&nbsp;</label>
	     	<label><spring:message code="button.impossible" /> : <input type="radio" name="cmmntPosblAt" class="radio2" value="N" <c:if test="${result.cmmntPosblAt == 'N'}"> checked="checked"</c:if>></label>
	     	<br/><form:errors path="cmmntPosblAt" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="bbsIntrcn">파일첨부가능여부 <span class="req"><span>필수입력</span></span></label></th>
			<td>
	     	<label><spring:message code="button.possible" /> : <input type="radio" name="fileAtchPosblAt" class="radio2" value="Y" <c:if test="${result.fileAtchPosblAt == 'Y'}"> checked="checked"</c:if>>&nbsp;</label>
	     	<label><spring:message code="button.impossible" /> : <input type="radio" name="fileAtchPosblAt" class="radio2" value="N" <c:if test="${result.fileAtchPosblAt == 'N'}"> checked="checked"</c:if>></label>
	     	<br/><form:errors path="fileAtchPosblAt" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="preNextPosblAt">이전글다음글가능여부 <span class="req"><span>필수입력</span></span></label></th>
			<td>
	    	<label><spring:message code="button.possible" /> : <input type="radio" name="preNextPosblAt" class="radio2" value="Y" <c:if test="${result.preNextPosblAt == 'Y'}"> checked="checked"</c:if>>&nbsp;</label>
	     	<label><spring:message code="button.impossible" /> : <input type="radio" name="preNextPosblAt" class="radio2" value="N" <c:if test="${result.preNextPosblAt == 'N'}"> checked="checked"</c:if>></label>
	     	<br/><form:errors path="preNextPosblAt" />
			</td>
		</tr>

		<%-- <tr id="posblAtchFileNumberLayer" ${result.fileAtchPosblAt == "Y" ? "style='display:block;'" : "style='display:none;'" }>
			<th scope="row"><label for="bbsIntrcn">첨부가능파일 숫자 <span class="req"><span>필수입력</span></span></label></th>
			<td>
	     	<select name="posblAtchFileNumber" class="select">
	  		   <option selected="selected" value"0">--선택하세요--</option>
	  		   <option value='1' <c:if test="${result.posblAtchFileNumber == '1'}">selected="selected"</c:if>>1개</option>
	  		   <option value='2' <c:if test="${result.posblAtchFileNumber == '2'}">selected="selected"</c:if>>2개</option>
	  		   <option value='3' <c:if test="${result.posblAtchFileNumber == '3'}">selected="selected"</c:if>>3개</option>
	  	   </select>
	  	   <br/><form:errors path="posblAtchFileNumber" />
			</td>
		</tr> --%>
		<tr>
			<th scope="row"><label for="pageUnit">PageUnit <span class="req"><span>필수입력</span></span></label></th>
			<td>
				<input name="pageUnit" type="text" size="20" value='<c:out value="${result.pageUnit}"/>' maxlength="20" style="width:20%" >
	      		<br/><form:errors path="pageUnit" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="pageSize">pageSize <span class="req"><span>필수입력</span></span></label></th>
			<td>
				<input name="pageSize" type="text" size="20" value='<c:out value="${result.pageSize}"/>' maxlength="20" style="width:20%" >
	      		<br/><form:errors path="pageSize" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="tableNm">테이블명<span class="req"><span>필수입력</span></span></label></th>
			<td>
				<input name="tableNm" type="text" size="60" value="${empty result ? 'COMTNBBS_BASIC' : result.tableNm}" maxlength="60" style="width:30%" >
	      		<br/><form:errors path="tableNm" />
			</td>
		</tr>
	</tbody>
</table>
</div>
</form>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:fn_egov_update_brdMstr();"><span>수정</span></a>
		<a class="btn btn-danger" href="javascript:fn_egov_delete_brdMstr();"><span>삭제</span></a>
		<a class="btn btn-primary" href="javascript:fn_egov_select_brdMstrList();"><span>목록</span></a>
	</div>

