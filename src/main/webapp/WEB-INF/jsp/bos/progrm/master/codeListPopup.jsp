<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
//<![CDATA[

	function selectCode(codeId, codeNm){

		var frm = document.forms['tchFrm'];
		if(!frm) frm = document.tchFrm;

		$("#codeId", opener.document).val(codeId);
		$("#codeNm", opener.document).val(codeNm);

		self.close();
	}

//]]>
</script>

<div id="content">
		<div id="wrap" class="popupWrap">
            <div class="row">
                <div class="col-md-12">
                    <h1>코드 찾기</h1>
                    <div class="panel panel-default">
                        <div class="panel-body">
							<div class="bdList">

						  		<form id="tchFrm" name="tchFrm" method="post" action="/bos/progrm/master/codeList.do?viewType=BODY" onsubmit="return goSearch(this);">
								<table class="table table-bordered">
									<caption>
									</caption>
									<colgroup>
									<col  style="width:30%" />
									<col  style="width:*" />
									<col  style="width:8%" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">분류명</th>
											<th scope="col">상세 코드 항목</th>
											<th scope="col">선택</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="result" items="${resultList}" varStatus="status">
											<tr>
												<td>${result.codeIdNm}</td>
												<td>${result.codeNmData}</td>
												<td><a href="#" onclick="javascript:selectCode('${result.codeId}', '${result.codeIdNm}');return false;" class="button post"><span>선택</span></a></td>
											</tr>
										<c:set var="resultCnt" value="${resultCnt-1}" />
										</c:forEach>
										<c:if test="${fn:length(resultList) == 0}" >
											<tr><td colspan="3">데이터가 없습니다.</td></tr>
										</c:if>
									</tbody>
								</table>
								</form>
							</div>

							<!-- paging -->
							<c:if test="${fn:length(resultList) > 0}">
								${pageNav}
							</c:if>
							<!-- //paging -->

							<!-- <div class="btnSet"><a href="#self" class="btn btn-primary">확인</a></div> -->
                        </div>
                    </div>
				</div>
			</div>
		</div>
</div>