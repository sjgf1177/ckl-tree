
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
		form.action = "/bos/job/${paramVO.programId}/delete.do";
		form.submit();
	}

	function restore(){
		var form = $("#board")[0];
		form.action = "/bos/job/${paramVO.programId}/restore.do";
		form.submit();
	}

	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/job/${paramVO.programId}/delPermanently.do";
		form.submit();
	}

</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>


<%-- paramVO : ${paramVO } @@@@@@@@@@@@@@@@@@@@@ <br /> --%>
<%-- result : ${result } --%>
<c:out value="${reuslt.userId }" />
<div id="content">
	<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="dicarySn" value="${result.dicarySn}" />
	<input type="hidden" name="cnSn" value="${result.cnSn}" />
	<input type="hidden" name="cnsl" value="${result.dicarySn}" />
	<input type="hidden" name="userId" value="" />
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}">
			<h4>■ 상담자정보</h4>
		<div class="bdView">
		<table summary="<c:if test="${roleSuper eq 'Y'}">게시구분,게시기간,</c:if>제목,담당부서,내용<c:if test="${not empty result}">등록일,</c:if><c:if test="${not empty result}">조회수,</c:if> 포함">
			<caption>${masterVO.bbsNm} - 읽기</caption>
			<colgroup>
				<col style="width:15%"/>
				<col />
			</colgroup>
			<tbody>


				<tr>
					<th scope="row"><label for="dicarySj">메인 제목</label></th>
					<td>
					<c:out value="${result.dicarySj}"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="dicarySj">카테고리 구분 </label></th>
					<td>
					 <c:if test="${not empty result.ctgrySe1Nm and not empty result.ctgrySe2Nm }" >
			    		 <c:out value="${result.ctgrySe1Nm }"/> > <c:out value="${result.ctgrySe2Nm }"/>
			    	 </c:if>
					</td>
				</tr>

				<tr>
					<th colspan="4">서브 제목 하위 메뉴</th>
				</tr>
			<c:choose>
			<c:when test="${not empty subResults }">

<!-- 				<tr> -->
<!-- 					<th scope="row"><label for="subSj1">서브 제목</label></th> -->
<!-- 					<td> -->
					<c:out value="${subResult.subSj}"/>
<!-- 					</td> -->
<!-- 				</tr> -->

				<tr>
					<th scope="row" class="subCn"><label for="subCn">내용</label></th>
					<td class="outputEditor">
						</span><br/>
						<div class="outputEditor" id="dbdata">
							<c:forEach var="subResult" items="${subResults }" >
								<font style="font-weight: bold;font-size: 15pt;"><c:out value="${subResult.subSj}"/> <br /><br /></font>
<%-- 								<% pageContext.setAttribute("crlf","\r\n"); %> --%>
<%-- 								${fn:replace(fn:replace(fn:escapeXml(subResult.subCn), crlf, '<br/>') , ' ', '&nbsp;')} --%>
									<c:out  value="${subResult.subCn }" escapeXml="false"/>
									<br /><br />
							</c:forEach>
						</div>
					</td>
				</tr>

			</c:when>
			<c:otherwise>
				<tr>
					<th scope="row"><label for="subSj1">서브 제목</label></th>
					<td>
					데이터가 존재하지 않습니다
					</td>
				</tr>

				<tr>
					<th scope="row" class="subCn"><label for="subCn">내용</label></th>
					<td class="outputEditor">
						<span style="color:red;"> * 서브글내용  *
						</span><br/>
						<textarea id="subCn" name="subCn" readonly="readonly" cols="140" rows="5" class="textarea">데이터가 존재하지 않습니다</textarea>
					</td>
				</tr>
			</c:otherwise>

			</c:choose>

			</tbody>
		</table>
	</div>

			</div>
			</form>
<c:if test="${result.delcode eq '1'}">
	<div class="fl">
		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
	</div>
</c:if>

<div class="btnSet">
	<div class="fl">
		<c:if test="${not empty result}">
<!-- 		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a> -->
		</c:if>

		<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
		<a class="btn btn-default" href="/bos/job/${paramVO.programId}/view.do?cnslSn=${prevNextMap['PREV'].prevNttId}&${pageQueryString}"><span>이전글</span></a>
	    </c:if>
		<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
		<a class="btn btn-default" href="/bos/job/${paramVO.programId}/view.do?${prevNextMap['NEXT'].nextNttId}.do&${pageQueryString}"><span>다음글</span></a>
	    </c:if>
	</div>
	<div class="fr" >
		<a class="btn btn-primary" href="/bos/job/${paramVO.programId}/forUpdate.do?dicarySn=${result.dicarySn}&${pageQueryString}&${result.delcode}"><span>수정</span></a>
	<c:if test="${not empty result}" >
		<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:if>
	<c:if test="${result.delcode eq '1' }" >
		<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>원글복구</span></a>
	</c:if>
		<c:url var="url" value="/bos/job/${paramVO.programId}/list.do?${pageQueryString}"/>
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>
</div>


			<!-- board list end //-->




