<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div id="wrap" class="popupWrap">

   <div class="row">
       <div class="col-md-12">
           <h1>현황정보</h1>
           <div class="panel panel-default">
               <div class="panel-body">
					<div class="bdList">
						<table class="table table-bordered">
							<caption>
							</caption>
							<colgroup>
							<col  span="3" />
							<col  />
							<col  />
							<col  />
							<col  span="3" />
							</colgroup>
							<thead>
								<tr>
									<th scope="row">번호</th>
									<th scope="row">아이디</th>
									<th scope="row">이름</th>
									<th scope="row">성별</th>
									<th scope="row">생년월일</th>
									<th scope="row">신청/접수일시</th>
									<th scope="row">상태</th>
									<th scope="row">취소일시</th>
									<th scope="row">참여여부</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td>${result.resveNo}</td>
										<td>${result.userId}</td>
										<td>${result.nm}</td>
										<td>${result.sex eq 'M' ? '남' : '여'}</td>
										<td>${result.brthdy}</td>
										<td>${result.rDt}</td>
										<td>${result.rceptSttusNm}</td>
										<td>${empty result.cDt ? '-' : result.cDt}</td>
										<td>${result.partcptnComptAt eq '01' ? '●' : 'X'}</td>
									</tr>
								<c:set var="resultCnt" value="${resultCnt-1}" />
								</c:forEach>
								<c:if test="${fn:length(resultList) == 0}" >
									<tr><td colspan="9">데이터가 없습니다.</td></tr>
								</c:if>
							</tbody>
						</table>
					</div>
				
					<div class="btnSet">
						<!-- <div class="fl"><a class="btn btn-success" href="javascript:void(0);"><span>엑셀저장</span></a></div> -->
				<c:if test="${fn:length(resultList) > 0}">
						<a class="btn btn-info" href="/bos/progrm/applcnt/downloadExcelStatsUser.xls?${pageQueryString}"><span>엑셀저장</span></a>
				</c:if>						
						<a href="javascript:window.close();" class="btn btn-primary">창닫기</a>
					</div>
				<c:if test="${fn:length(resultList) > 0}">
					<div class="paging">
						<div class="paginationSet">
							${pageNav}
						</div>
					</div>
				</c:if>						
                </div>
            </div>
		</div>
	</div>
</div>
