<%@ page contentType="application/vnd.ms-excel; charset=utf-8" pageEncoding="utf-8"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename=reserveList.xls");
    response.setHeader("Content-Description", "JSP Generated Data");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>엑셀다운로드</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<style type="text/css">
table {width:100%; border:0; border-spacing:0; table-layout:fixed; background:#fff;}
table+table {margin-top:30px;}
table th, table td {border:0;}
table {border-collapse:separate; border-top:1px solid #0d97a1; border-bottom:1px solid #0d97a1; border-left:1px solid #0d97a1; border-right:hidden;}
table td, table th {height:32px; padding:6px 10px; border-top:1px solid #0d97a1; border-right:1px solid #0d97a1;}
table th {background:#ecf4f9;}

</style>
</head>

<body>
<fmt:parseDate value="${paramVO.resveDt}" var="dateFmt" pattern="yyyy-MM-dd"/>
<h3>일자 : <fmt:formatDate value="${dateFmt}" pattern="yyyy년 MM월 dd일"/></h3>


	<table class="table table-bordered table-striped table-hover" id="tbDalyList">
		<caption>

		</caption>
		<colgroup>
		<col />
		<col />
		<col />
		<col />
		<col  />
		<col  />
		<col  />
		<col  />
		<col  />
		<col  />
		<col  />
		<col  />
		<col  />
		<col  />
		<col  />
		<col  />
		<col  />
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
						<c:out value="${result.sumcnt9.ntssAt eq 'Y' ? '●' : '' }"/>
						<c:out value="${result.sumcnt9.eqpmnCnt > 0 ? '★' : '' }"/><c:out value="${result.sumcnt9.resveNm }${result.sumcnt9.useNmpr }" /> / <c:out value="${result.sumcnt9.usePurposeCn }" />
					</c:if>
				</td>
				<c:if test="${result.sumcnt10.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt10.colspan ne '0'}">colspan="${result.sumcnt10.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt10.resveNm }">
							<c:out value="${result.sumcnt10.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt10.eqpmnCnt > 0 ? '★' : '' }"/><c:out value="${result.sumcnt10.resveNm }${result.sumcnt10.useNmpr }" /> / <c:out value="${result.sumcnt10.usePurposeCn }" />
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt11.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt11.colspan ne '0'}">colspan="${result.sumcnt11.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt11.resveNm }">
							<c:out value="${result.sumcnt11.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt11.eqpmnCnt > 0 ? '★' : '' }"/><c:out value="${result.sumcnt11.resveNm }${result.sumcnt11.useNmpr }" /> / <c:out value="${result.sumcnt11.usePurposeCn }" />
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt12.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt12.colspan ne '0'}">colspan="${result.sumcnt12.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt12.resveNm }">
							<c:out value="${result.sumcnt12.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt12.eqpmnCnt > 0 ? '★' : '' }"/><c:out value="${result.sumcnt12.resveNm }${result.sumcnt12.useNmpr }" /> / <c:out value="${result.sumcnt12.usePurposeCn }" />
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt13.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt13.colspan ne '0'}">colspan="${result.sumcnt13.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt13.resveNm }">
							<c:out value="${result.sumcnt13.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt13.eqpmnCnt > 0 ? '★' : '' }"/><c:out value="${result.sumcnt13.resveNm }${result.sumcnt13.useNmpr }" /> / <c:out value="${result.sumcnt13.usePurposeCn }" />
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt14.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt14.colspan ne '0'}">colspan="${result.sumcnt14.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt14.resveNm }">
							<c:out value="${result.sumcnt14.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt14.eqpmnCnt > 0 ? '★' : '' }"/><c:out value="${result.sumcnt14.resveNm }${result.sumcnt14.useNmpr }" /> / <c:out value="${result.sumcnt14.usePurposeCn }" />
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt15.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt15.colspan ne '0'}">colspan="${result.sumcnt15.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt15.resveNm }">
							<c:out value="${result.sumcnt15.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt15.eqpmnCnt > 0 ? '★' : '' }"/><c:out value="${result.sumcnt15.resveNm }${result.sumcnt15.useNmpr }" /> / <c:out value="${result.sumcnt15.usePurposeCn }" />
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt16.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt16.colspan ne '0'}">colspan="${result.sumcnt16.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt16.resveNm }">
							<c:out value="${result.sumcnt16.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt16.eqpmnCnt > 0 ? '★' : '' }"/><c:out value="${result.sumcnt16.resveNm }${result.sumcnt16.useNmpr }" /> / <c:out value="${result.sumcnt16.usePurposeCn }" />
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt17.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt17.colspan ne '0'}">colspan="${result.sumcnt17.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt17.resveNm }">
							<c:out value="${result.sumcnt17.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt17.eqpmnCnt > 0 ? '★' : '' }"/><c:out value="${result.sumcnt17.resveNm }${result.sumcnt17.useNmpr }" /> / <c:out value="${result.sumcnt17.usePurposeCn }" />
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt18.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt18.colspan ne '0'}">colspan="${result.sumcnt18.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt18.resveNm }">
							<c:out value="${result.sumcnt18.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt18.eqpmnCnt > 0 ? '★' : '' }"/><c:out value="${result.sumcnt18.resveNm }${result.sumcnt18.useNmpr }" /> / <c:out value="${result.sumcnt18.usePurposeCn }" />
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt19.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt19.colspan ne '0'}">colspan="${result.sumcnt19.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt19.resveNm }">
							<c:out value="${result.sumcnt19.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt19.eqpmnCnt > 0 ? '★' : '' }"/><c:out value="${result.sumcnt19.resveNm }${result.sumcnt19.useNmpr }" /> / <c:out value="${result.sumcnt19.usePurposeCn }" />
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt20.colspan ne 'none'}">
					<td <c:if test="${result.sumcnt20.colspan ne '0'}">colspan="${result.sumcnt20.colspan }"</c:if>>
						<c:if test="${not empty result.sumcnt20.resveNm }">
							<c:out value="${result.sumcnt20.ntssAt eq 'Y' ? '●' : '' }"/>
							<c:out value="${result.sumcnt20.eqpmnCnt > 0 ? '★' : '' }"/><c:out value="${result.sumcnt20.resveNm }${result.sumcnt20.useNmpr }" /> / <c:out value="${result.sumcnt20.usePurposeCn }" />
						</c:if>
					</td>
				</c:if>
				<c:if test="${result.sumcnt21.colspan ne 'none'}">
					<td>
					<c:if test="${not empty result.sumcnt21.resveNm }">
						<c:out value="${result.sumcnt21.ntssAt eq 'Y' ? '●' : '' }"/>
						<c:out value="${result.sumcnt21.eqpmnCnt > 0 ? '★' : '' }"/><c:out value="${result.sumcnt21.resveNm }${result.sumcnt21.useNmpr }" /> / <c:out value="${result.sumcnt21.usePurposeCn }" />
					</c:if>
					</td>
				</c:if>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>

