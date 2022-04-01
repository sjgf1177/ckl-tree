
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

</script>

		<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
			<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
			<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
			<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
			<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}">
			<input type="hidden" name="htmlYn" value="${result.htmlYn}" />
			<h4>기본정보입력</h4>
			<div class="bdView">

				<table class="table table-bordered">
					<caption>기본정보입력</caption>
					<colgroup>
					<col style="width:15%" />
					<col style="width:15%" />
					<col style="width:25%" />
					<col style="width:15%" />
					<col  />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><label for="nttSj">기관명</label></th>
							<td colspan="4" >
								${result.nttSj }
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="ntcrAddr1">주소</label></th>
							<td colspan="4" >
								${result.ntcrAddr1 }
							</td>
						</tr>
						<tr>
							<th scope="row" rowspan="2">
							<label>담당자</label></th>
							<th>부서/직급	</th>
							<td>${result.option1 } </td>
							<th scope="row">유선전화</td>
							<td>
								${result.ntcrTel }
							</td>
						</tr>
						<tr>
							<th>성명</th>
							<td>${result.ntcrNm }</td>
							<th scope="row">이메일</th>
							<td>${result.ntcrEmail }</td>
						</tr>
						<tr>
						 	<th>기관구분</th>
						 	<td colspan="2" >
						 		<c:forEach items="${COM161CodeList }" var="code" >
									<c:if test="${result.option12 eq code.code }">${code.codeNm }</c:if>
								</c:forEach>
						 	 </td>
							<th>홈페이지</th>
						 	<td>${result.option2 }</td>
						</tr>
						<tr>
							<th scope="row"><label for="nttSj">운영목적</label></th>
							<td colspan="4" >
								${result.option13 }
							</td>
						</tr>
						<tr>
							<th scope="row">기관소개</th>
							<td colspan="4" >
								 <div class="outputEditor" id="dbdata">
									<% pageContext.setAttribute("crlf","\r\n"); %>
									${fn:replace(fn:replace(fn:escapeXml(result.option14), crlf, '<br/>') , ' ', '&nbsp;')}
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>


			<h4>학습정보입력</h4>
			<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
			<div class="bdView">
				<table class="table table-bordered">
					<caption>
					</caption>
					<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col  />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 운영계획</th>
							<td colspan="3">${result.option15 }</td>
						</tr>
						<tr>
							<th scope="row">수강신청기간</th> <!-- option3 ~ option4 -->
							<td>
								${result.option3 } ~ ${result.option4 }
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 학습기간</th>
							<td>
								${result.option16 } ~ ${result.option17 }
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 신청분야</th>
							<td colspan="3">
								<c:forEach items="${COM074CodeList }" var="code" varStatus="status" >
									 <c:if test="${fn:indexOf(result.option18, code.code) != -1}">${code.codeNm } </c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th scope="row">신청과정</th>
							<td colspan="3">${result.option9 }</td>
						</tr>
						<tr>
							<th scope="row">수료기준</th>
							<td colspan="3">진도 ${result.option20 }% 이상</td>
						</tr>
						<tr>
							<th scope="row">예상입과인원</th>
							<td>
								${result.option7 } 명
							</td>
						</tr>
						<tr>
							<th scope="row">요청도메인</th>
							<td colspan="3">
								http://${result.option11 }.edukocca.kr
							</td>
						</tr>
						<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
						<tr>
							<th scope="row">LOGO 파일</th>
							<td colspan="3">
								<c:if test="${not empty fileList}">
									<img src='/cmm/fms/getImage.do?atchFileId=${fileList[0].atchFileId}&fileSn=${fileList[0].fileSn}'  style="height: 60px;" alt="${fileList[0].fileCn}" />
									<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileList[0].atchFileId}&amp;fileSn=${fileList[0].fileSn}&amp;bbsId=${param.bbsId}" class="${icn}">
									<br />	<c:out value="${fileList[0].orignlFileNm}"/>&nbsp;[<c:out value="${fileList[0].fileMg}"/>&nbsp;byte]
									</a>
								</c:if>


							</td>
						</tr>
						</c:if>
						
						<c:if test="${not empty result}">
						<tr>
							<th scope="row">등록일</th>
							<td colspan="3">${result.regDate}</td>
						</tr>
						</c:if>

						<c:if test="${not empty result}">
						<tr>
							<th scope="row">최종수정일</th>
							<td colspan="3">${result.uptDate}</td>
						</tr>
						</c:if>
					</tbody>
				</table>
			</div>
</form>

<div class="btnSet">
	<div class="fl">
		<c:if test="${not empty result}">
<%-- 		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a> --%>
		</c:if>

		<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
		<a class="btn btn-default" href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap['PREV'].prevNttId}&${pageQueryString}"><span>이전글</span></a>
	    </c:if>
		<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
		<a class="btn btn-default" href="/bos/bbs/${paramVO.bbsId}/view.do?${prevNextMap['NEXT'].nextNttId}.do&${pageQueryString}"><span>다음글</span></a>
	    </c:if>
	</div>
	<div class="fr" >
		<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/forUpdate.do?nttId=${result.nttId}&${pageQueryString}&${result.delcode}"><span>수정</span></a>
		<c:if test="${result.delcode eq '0' }" >
		<a class="btn btn-danger" href="javascript:del()" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
		</c:if>
		<c:if test="${result.delcode eq '1' }" >
		<%--<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>원글복구</span></a> --%>
		</c:if>
		<c:url var="url" value="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" />
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>
</div>
