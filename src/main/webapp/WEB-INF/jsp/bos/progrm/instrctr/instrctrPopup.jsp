<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
//<![CDATA[

    function goSearch(tchFrm){

		if(tchFrm.searchWrd.value == ""){

			alert("찾으시는 강사명을 입력해 주세요.");
			tchFrm.searchWrd.focus();
			return false;
		}
	}

	function selectInstrctr(tchSn, tchNm){

		var frm = document.forms['tchFrm'];
		if(!frm) frm = document.tchFrm;

		$("#tchSn", opener.document).val(tchSn);
		$("#tchNm", opener.document).val(tchNm);

		self.close();
	}

//]]>
</script>

	<div id="wrap" class="popupWrap">

          <div class="row">
              <div class="col-md-12">
                  <h1>강사 선택</h1>
                  <div class="panel panel-default">
                      <div class="panel-body">
						  <div class="bdList">

						  <form id="tchFrm" name="tchFrm" method="post" action="/bos/progrm/instrctr/instrctrPopup.do" onsubmit="return goSearch(this);">
						  <table class="table table-bordered">
								<caption></caption>
								<colgroup>
									<col span="3">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">강사명</th>
										<th scope="col">현소속</th>
										<th scope="col">선택</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>
											<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
											<td>${result.tchNm}</td>
											<td>${result.psitn}</td>
											<td><a href="#" onclick="javascript:selectInstrctr('${result.tchSn}', '${result.tchNm}');return false;" class="button post"><span>선택</span></a></td>
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

						<!-- <div class="btnSet"><a href="#self" class="btn btn-primary">확인</a></div> -->

							<!-- paging -->
							<div class="paging">
								<div class="paginationSet">
									<c:if test="${fn:length(resultList) > 0}">
										${pageNav}
									</c:if>
								</div>
							</div>
							<!-- //paging -->

                </div>
            </div>
		</div>
	</div>

</div>