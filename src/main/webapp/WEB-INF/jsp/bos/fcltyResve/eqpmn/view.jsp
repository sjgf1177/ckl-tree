<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript">
//<![CDATA[
$(function() {
	$("#delBtn").click(function() {
		if (confirm("삭제 하시겠습니까?")) {
			location.href =  $(this).attr("href");
		}
		return false;
	});
});
//]]>
</script>

<div class="bdView">
	<table class="table table-bordered">
		<caption>

		</caption>
		<colgroup>
		<col />
		<col />
		<col />
		<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">장비구분</th>
				<td colspan="3"><c:out value="${result.eqpmnSeNm }" /></td>
			</tr>
			<tr>
				<th scope="row">장비명</th>
				<td colspan="3"><c:out value="${result.eqpmnNm }" /></td>
			</tr>
			<tr>
				<th scope="row">장비명(영문)</th>
				<td colspan="3"><c:out value="${result.eqpmnNmEn }" /></td>
			</tr>
			<tr>
				<th scope="row">예약구분</th>
				<td colspan="3"><c:out value="${result.resveSeNm }" /></td>
			</tr>
			<tr>
				<th scope="row">예약가능여부</th>
				<td>
					<c:choose>
						<c:when test="${result.resvePosblAt eq 'Y' }">예약가능</c:when>
						<c:when test="${result.resvePosblAt eq 'N' }">예약불가</c:when>
						<c:when test="${result.resvePosblAt eq 'I' }">개별예약가능</c:when>
					</c:choose>
					(토/일 <c:out value="${result.wkendResvePolsblAt eq 'Y' ? '예약가능' : '예약불가' }" />)
				</td>
				<th scope="row">사용여부</th>
				<td><c:out value="${result.useAt eq 'Y' ? '사용' : '사용안함' }" /></td>
			</tr>
			<tr>
				<th scope="row">세부내역</th>
				<td colspan="3">
					<% pageContext.setAttribute("crlf", "\n"); %>
					${fn:replace(result.dtlsInfo, crlf, "<br/>")}
				</td>
			</tr>
			<tr>
				<th scope="row">세부내역(영문)</th>
				<td colspan="3">
					<% pageContext.setAttribute("crlf", "\n"); %>
					${fn:replace(result.dtlsInfoEn, crlf, "<br/>")}
				</td>
			</tr>
			<tr>
				<th scope="row">수량</th>
				<td colspan="3"><c:out value="${result.eqpmnQy }" /> EA</td>
			</tr>
			<tr>
				<th scope="row">예약불가사유</th>
				<td colspan="3"><c:out value="${result.resveImprtyResn }" /></td>
			</tr>
		</tbody>
	</table>
</div>


<!-- visualSet -->

<script type="text/javascript" src="/js/jquery.carouFredSel-6.2.1-packed.js"></script>

<div class="visualSet">
	<div class="visual">
		<div class="thumbs" id="vsThumbs">
		<c:forEach var="fileVO" items="${fileList}" varStatus="status">
			<div> <a href="#self"><img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}" width="635" height="380"  alt="<c:out value="${fileVo.orignlFileNm }" />" /></a></div>
		</c:forEach>
		</div>
		<div class="thumbsList" id="thumbsList">
			<ul>
				<c:forEach var="fileVO" items="${fileList}" varStatus="status">
					<li> <a href="#self"><img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}"  alt="<c:out value="${fileVo.orignlFileNm }" />" /></a></li>
				</c:forEach>
		</ul>
	</div>
	<!-- <div class="visualCtrl"><a href="#self" class="nextVs"><img src="/images/mains/m_44.gif" width="211" height="40" alt="다음 배너 보기" /></a></div> -->
	</div>
</div>

<script type="text/javascript">
//<![CDATA[
$(function() {
	 $('#thumbsList ul').carouFredSel({
		items		:{
			visible : <c:out value="${fn:length(fileList)}" />
		},
		direction: 'up',
		scroll      :{
			items		:1,
			pauseOnHover	: true
		},
		auto: {
			play: false,
			duration: 750,
			timeoutDuration: 2000,
			easing: 'quadratic',
			onBefore: function() {
				var index = $(this).triggerHandler( 'currentPosition' );
				if ( index == 0 ) {
					index = $(this).children().length;
				}
				$('#vsThumbs').trigger('slideTo', [ index, {
					fx: 'directscroll'
				}, 'prev' ]);
				 $('#thumbsList ul').find( 'li' ).eq(index).addClass( 'selected' );
			}

		},
		next : ".nextVs"
	 });

	var thumbsList = $('#thumbsList ul li');
	thumbsList.bind("click", function(){
		var index =  thumbsList.index(this);
		$('#vsThumbs').trigger('slideTo', [ index, {
			fx: 'directscroll'
		}, 'prev' ]);
	});

	 $('#vsThumbs').carouFredSel({
		items: 1,
		direction: 'left',
		width:635,
		height:380,
		scroll :{
			items : 1
		},
		auto: {
			play: false,
			duration: 750,
			easing: 'directscroll'
		}
	 });
});
//]]>
</script>
<!-- //visualSet -->


<div class="btnSet clear mt20">

	<div class="row">
		<div class="col-md-10 tac"><a class="btn btn-primary" href="/bos/fcltyResve/eqpmn/forUpdate.do?eqpmnSn=<c:out value="${result.eqpmnSn }" />&amp;${pageQueryString }"><span>수정</span></a>
			<a class="btn btn-default" href="/bos/fcltyResve/eqpmn/delete.do?eqpmnSn=<c:out value="${result.eqpmnSn }" />&amp;${pageQueryString }" id="delBtn"><span>삭제</span></a>
		</div>
		<div class="col-md-2 tac"><a class="btn btn-primary" href="/bos/fcltyResve/eqpmn/list.do?${pageQueryString }"><span>목록</span></a></div>
	</div>
</div>