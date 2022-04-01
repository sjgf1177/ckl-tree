<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript">
//<![CDATA[
$(function() {
	$('#tbDalyList').rowspan(0);
	$('#tbDalyList').rowspan(1);
	$('#tbDalyList').rowspan(2);

});
//]]>
</script>

<form name="resveSttusForm" id="resveSttusForm" method="get" action="/bos/hkFcltyResve/resveSttus/listDaly.do">
	<input type="hidden" name="menuNo" value="<c:out value="${param.menuNo }" />" />
<!-- 게시판 게시물검색 start -->
<div class="sh">

	<fieldset>
		<legend>게시판 게시물검색</legend>
		<label for="input1" class="blind">일자</label>
		<input type="text" id="resveDt" name="resveDt"  class="sdate" title="검색어입력" readonly="readonly" style="width:130px "value="<c:out value="${paramVO.resveDt }" />" />
		<input type="submit" id="input2" class="btn btn-default" value="검색" />
	</fieldset>
</div>
<!-- 게시판 게시물검색 end -->
</form>

<fmt:parseDate value="${paramVO.resveDt}" var="dateFmt" pattern="yyyy-MM-dd"/>
<h3>일자 : <fmt:formatDate value="${dateFmt}" pattern="yyyy년 MM월 dd일"/></h3>


<!-- boardView -->

<p class="tar">장비 : [*]  <strong>/</strong> 체크인 : [●]  <!-- <strong>/</strong> 행사일정등록 : [★] --></p>
<div>
	<table class="table table-bordered table-striped table-hover" id="tbDalyList">
		<caption>

		</caption>
		<colgroup>
		<col />
		<col />
		<col />
		<col />
		<col style="width:50px" />
		<col style="width:50px" />
		<col style="width:50px" />
		<col style="width:50px" />
		<col style="width:50px" />
		<col style="width:50px" />
		<col style="width:50px" />
		<col style="width:50px" />
		<col style="width:50px" />
		<col style="width:50px" />
		<col style="width:50px" />
		<col style="width:50px" />
		<col style="width:50px" />
		</colgroup>
		<thead>
			<tr>
				<th>지역</th>
				<th>위치</th>
				<th>시설구분</th>
				<th>공간명</th>
				<th>9</th>
				<th>10</th>
				<th>11</th>
				<th>12</th>
				<th>13</th>
				<th>14</th>
				<th>15</th>
				<th>16</th>
				<th>17</th>
				<th>18</th>
				<th>19</th>
				<th>20</th>
				<th>21</th>
			</tr>

		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><c:out value="${result.areaSeNm }" /></td>
				<td><c:out value="${result.lcSeNm }" /></td>
				<td><c:out value="${result.fcltySeNm }" /></td>
				<td><c:out value="${result.spceNm }" /></td>
				<td <c:if test="${result.sumcnt9.colspan > 0}">colspan="${result.sumcnt9.colspan }"</c:if>>
					<c:if test="${not empty result.sumcnt9.resveNm }">
						<a href="/bos/hkFcltyResve/resveSttus/view.do?resveSn=${result.sumcnt9.resveSn }&menuNo=100205">
						<c:out value="${result.sumcnt9.ntssAt eq 'Y' ? '●' : '' }"/>
						<c:out value="${result.sumcnt9.schdulCnt > 0 ? '★' : '' }"/>
						<c:out value="${result.sumcnt9.eqpmnCnt > 0 ? '*' : '' }"/><c:out value="${result.sumcnt9.resveNm }${result.sumcnt9.useNmpr }" /> / <c:out value="${result.sumcnt9.usePurposeCn }" />
						</a>
					</c:if>
				</td>
				<c:if test="${result.sumcnt10.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt10.colspan ne '0'}">colspan="${result.sumcnt10.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt10.resveNm }">
							<a href="/bos/hkFcltyResve/resveSttus/view.do?resveSn=${result.sumcnt10.resveSn }&menuNo=100205">
							<c:out value="${result.sumcnt10.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt10.schdulCnt > 0 ? '★' : '' }"/>
							<c:out value="${result.sumcnt10.eqpmnCnt > 0 ? '*' : '' }"/><c:out value="${result.sumcnt10.resveNm }${result.sumcnt10.useNmpr }" /> / <c:out value="${result.sumcnt10.usePurposeCn }" />
							</a>
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt11.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt11.colspan ne '0'}">colspan="${result.sumcnt11.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt11.resveNm }">
							<a href="/bos/hkFcltyResve/resveSttus/view.do?resveSn=${result.sumcnt11.resveSn }&menuNo=100205">
							<c:out value="${result.sumcnt11.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt11.schdulCnt > 0 ? '★' : '' }"/>
							<c:out value="${result.sumcnt11.eqpmnCnt > 0 ? '*' : '' }"/><c:out value="${result.sumcnt11.resveNm }${result.sumcnt11.useNmpr }" /> / <c:out value="${result.sumcnt11.usePurposeCn }" />
							</a>
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt12.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt12.colspan ne '0'}">colspan="${result.sumcnt12.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt12.resveNm }">
							<a href="/bos/hkFcltyResve/resveSttus/view.do?resveSn=${result.sumcnt12.resveSn }&menuNo=100205">
							<c:out value="${result.sumcnt12.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt12.schdulCnt > 0 ? '★' : '' }"/>
							<c:out value="${result.sumcnt12.eqpmnCnt > 0 ? '*' : '' }"/><c:out value="${result.sumcnt12.resveNm }${result.sumcnt12.useNmpr }" /> / <c:out value="${result.sumcnt12.usePurposeCn }" />
							</a>
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt13.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt13.colspan ne '0'}">colspan="${result.sumcnt13.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt13.resveNm }">
							<a href="/bos/hkFcltyResve/resveSttus/view.do?resveSn=${result.sumcnt13.resveSn }&menuNo=100205">
							<c:out value="${result.sumcnt13.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt13.schdulCnt > 0 ? '★' : '' }"/>
							<c:out value="${result.sumcnt13.eqpmnCnt > 0 ? '*' : '' }"/><c:out value="${result.sumcnt13.resveNm }${result.sumcnt13.useNmpr }" /> / <c:out value="${result.sumcnt13.usePurposeCn }" />
							</a>
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt14.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt14.colspan ne '0'}">colspan="${result.sumcnt14.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt14.resveNm }">
							<a href="/bos/hkFcltyResve/resveSttus/view.do?resveSn=${result.sumcnt14.resveSn }&menuNo=100205">
							<c:out value="${result.sumcnt14.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt14.schdulCnt > 0 ? '★' : '' }"/>
							<c:out value="${result.sumcnt14.eqpmnCnt > 0 ? '*' : '' }"/><c:out value="${result.sumcnt14.resveNm }${result.sumcnt14.useNmpr }" /> / <c:out value="${result.sumcnt14.usePurposeCn }" />
							</a>
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt15.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt15.colspan ne '0'}">colspan="${result.sumcnt15.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt15.resveNm }">
							<a href="/bos/hkFcltyResve/resveSttus/view.do?resveSn=${result.sumcnt15.resveSn }&menuNo=100205">
							<c:out value="${result.sumcnt15.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt15.schdulCnt > 0 ? '★' : '' }"/>
							<c:out value="${result.sumcnt15.eqpmnCnt > 0 ? '*' : '' }"/><c:out value="${result.sumcnt15.resveNm }${result.sumcnt15.useNmpr }" /> / <c:out value="${result.sumcnt15.usePurposeCn }" />
							</a>
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt16.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt16.colspan ne '0'}">colspan="${result.sumcnt16.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt16.resveNm }">
							<a href="/bos/hkFcltyResve/resveSttus/view.do?resveSn=${result.sumcnt16.resveSn }&menuNo=100205">
							<c:out value="${result.sumcnt16.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt16.schdulCnt > 0 ? '★' : '' }"/>
							<c:out value="${result.sumcnt16.eqpmnCnt > 0 ? '*' : '' }"/><c:out value="${result.sumcnt16.resveNm }${result.sumcnt16.useNmpr }" /> / <c:out value="${result.sumcnt16.usePurposeCn }" />
							</a>
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt17.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt17.colspan ne '0'}">colspan="${result.sumcnt17.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt17.resveNm }">
							<a href="/bos/hkFcltyResve/resveSttus/view.do?resveSn=${result.sumcnt17.resveSn }&menuNo=100205">
							<c:out value="${result.sumcnt17.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt17.schdulCnt > 0 ? '★' : '' }"/>
							<c:out value="${result.sumcnt17.eqpmnCnt > 0 ? '*' : '' }"/><c:out value="${result.sumcnt17.resveNm }${result.sumcnt17.useNmpr }" /> / <c:out value="${result.sumcnt17.usePurposeCn }" />
							</a>
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt18.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt18.colspan ne '0'}">colspan="${result.sumcnt18.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt18.resveNm }">
							<a href="/bos/hkFcltyResve/resveSttus/view.do?resveSn=${result.sumcnt18.resveSn }&menuNo=100205">
							<c:out value="${result.sumcnt18.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt18.schdulCnt > 0 ? '★' : '' }"/>
							<c:out value="${result.sumcnt18.eqpmnCnt > 0 ? '*' : '' }"/><c:out value="${result.sumcnt18.resveNm }${result.sumcnt18.useNmpr }" /> / <c:out value="${result.sumcnt18.usePurposeCn }" />
							</a>
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt19.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt19.colspan ne '0'}">colspan="${result.sumcnt19.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt19.resveNm }">
							<a href="/bos/hkFcltyResve/resveSttus/view.do?resveSn=${result.sumcnt19.resveSn }&menuNo=100205">
							<c:out value="${result.sumcnt19.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt19.schdulCnt > 0 ? '★' : '' }"/>
							<c:out value="${result.sumcnt19.eqpmnCnt > 0 ? '*' : '' }"/><c:out value="${result.sumcnt19.resveNm }${result.sumcnt19.useNmpr }" /> / <c:out value="${result.sumcnt19.usePurposeCn }" />
							</a>
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt20.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt20.colspan ne '0'}">colspan="${result.sumcnt20.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt20.resveNm }">
							<a href="/bos/hkFcltyResve/resveSttus/view.do?resveSn=${result.sumcnt20.resveSn }&menuNo=100205">
							<c:out value="${result.sumcnt20.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt20.schdulCnt > 0 ? '★' : '' }"/>
							<c:out value="${result.sumcnt20.eqpmnCnt > 0 ? '*' : '' }"/><c:out value="${result.sumcnt20.resveNm }${result.sumcnt20.useNmpr }" /> / <c:out value="${result.sumcnt20.usePurposeCn }" />
							</a>
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt21.colspan ne 'none'}">
					<td>
					<c:if test="${not empty result.sumcnt21.resveNm }">
						<a href="/bos/hkFcltyResve/resveSttus/view.do?resveSn=${result.sumcnt21.resveSn }&menuNo=100205">
						<c:out value="${result.sumcnt21.ntssAt eq 'Y' ? '●' : '' }"/>
						<c:out value="${result.sumcnt21.schdulCnt > 0 ? '★' : '' }"/>
						<c:out value="${result.sumcnt21.eqpmnCnt > 0 ? '*' : '' }"/><c:out value="${result.sumcnt21.resveNm }${result.sumcnt21.useNmpr }" /> / <c:out value="${result.sumcnt21.usePurposeCn }" />
						</a>
					</c:if>
					</td>
				</c:if>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
<!-- //boardView -->


<div class="row">
	<div class="col-md-6"><a class="btn btn-success" href="/bos/hkFcltyResve/resveSttus/listDalyExcel.do?viewType=CONTBODY&amp;resveDt=<c:out value="${paramVO.resveDt }" />"><span>엑셀저장</span></a></div>
	<div class="col-md-6 tar"> </div>
</div>