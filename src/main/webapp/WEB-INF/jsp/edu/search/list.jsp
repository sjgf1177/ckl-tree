<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="rangeAll" value="${empty paramVO.rangeView or paramVO.rangeView eq 'all'}" />
<c:set var="progrmCnt" value="${rangeAll ? 5 : fn:length(progrmResultList)}" />
<c:set var="menuCnt" value="${rangeAll ? 5 : fn:length(menuResultList)}" />
<c:set var="bbsCnt" value="${rangeAll ? 5 : fn:length(bbsResultList)}" />
<c:set var="webpageCnt" value="${rangeAll ? 5 : fn:length(webpageResultList)}" />
<c:set var="filesCnt" value="${rangeAll ? 5 : fn:length(filesResultList)}" />
<c:set var="onlineEduCnt" value="${rangeAll ? 5 : fn:length(onlineEduResultList)}" />

<script type="text/javascript" src="/js/jquery-ui-1.9.2.custom.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.lnb_wrap').addClass('dn');
});

	$(function() {
		$(":checkbox[name=category]").click(function(){
			if(this.value == "all" && this.checked){
				$(":checkbox[name=category]").attr("checked", true);
			}
			else if(this.value == "all" && !this.checked){
				$(":checkbox[name=category]").attr("checked", false);
			}
			else{
				if(!this.checked){
					$("#sr_chk0").attr("checked", false);
				}
				else{
					if( $(":checkbox:checked:not(#sr_chk0)").length == 8 ){
						$("#sr_chk0").attr("checked", true);
					}
				}
			}
		});
		$(":radio[name=range]").click(function(){
			$(":checkbox[name=category]").attr("disabled", false);
		});
		$("#sr_radio_4").click(function(){
			$(":checkbox[name=category]").attr("checked", false);
			$(":checkbox[name=category]").attr("disabled", true);
		});

	    $('#q').autocomplete({
	        source: function(request, response) {
	        	$.getJSON("/edu/search/suggest.json",
	        	{
	        		q: encodeURIComponent(request.term)
	        	},
	        	function(data) {
		        	response(
		            	$.map(data.resultList, function(item) {
		                	return {
		                    	label: item,
		                        value: item
		                    }
		                })
		        	);
	        	});
	        },
	        minLength: 1,
	        select: function( event, ui ) {
	        	console.log( ui.item ?
	            "Selected: " + ui.item.label :
	            "Nothing selected, input was " + this.value);
	        },
	        open: function() {
	          	$( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
	        },
	        close: function() {
	          	$( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
	        }
	    });

		$('#con_more_${paramVO.rangeView}').hide();
		$('#more_${paramVO.rangeView}').click(function() {
			$('#con_more_${paramVO.rangeView}').toggle();
		});

		jQuery.fn.extend({
			toggle: function() {
			    return this.each(function() {
				    var el = jQuery(this);
				    if (el.css('display') == 'none') {
						$('#con_more_${paramVO.rangeView}').show();
				    }
				    else {
						$('#con_more_${paramVO.rangeView}').hide();
					}
				});
			}
		});

		$('#detailBtn').click(function() {
			$('#ul_${paramVO.rangeView}').hide();
		});

	});

	function detail(range){
		$(":input[name=range]").each(function(){
			if( $(this).val() == range ){
				$(this).attr("checked", true);
			}
			else{
				$(this).attr("checked", false);
			}
		});
		document.frmSearch.submit();
	}

	function detailView(v){
		if( !checkForm(document.frmSearch) ){
			return;
		}
		document.frmSearch.rangeView.value = v;
		document.frmSearch.submit();
	}

	function search(q){
		$("#q").val(q);
		document.frmSearch.submit();
	}

	function paging(pageIndex){
		$("#pageIndex").val(pageIndex);
		document.frmSearch.submit();
	}

	function checkForm(form){
		if(!form.q.value){
			alert("검색어를 입력하세요.");
			$("#q")[0].focus();
			return false;
		}
		return true;
	}

</script>
<style>
.sub_contents_wrap .sub_contents {padding-left:0 !important;}
</style>
<!-- 통합검색 입력폼 -->
<div class="over-hidden mb20">
	<form name="frmSearch" class="col-12 board_sorting_con alert formLine1 searchSetTp" method="post" action="/edu/search/list.do?menuNo=${param.menuNo}" onsubmit="return checkForm(this);">
		<input type="hidden" id="prevQ" name="prevQ" value="${paramVO.q}" />
		<input type="hidden" id="pageIndex" name="pageIndex" value="${paramVO.pageIndex}" />
		<div>
			<fieldset>
				<legend>통합검색 입력폼</legend>
				<span class="tl select_box">
					<label for="rangeView" class="hidden"><strong>통합검색</strong></label>
					<select name="rangeView" id="rangeView" title="구분을 선택해 주세요."  class="select_style_0">
						<option value="">통합검색</option>
						<option value="progrm" <c:if test="${paramVO.rangeView eq 'progrm'}">selected="selected"</c:if>>프로그램</option>
						<option value="onlineEdu" <c:if test="${paramVO.rangeView eq 'onlineEdu'}">selected="selected"</c:if>>교육/강좌</option>
						<option value="webpage" <c:if test="${paramVO.rangeView eq 'webpage'}">selected="selected"</c:if>>웹페이지</option>
						<option value="bbs" <c:if test="${paramVO.rangeView eq 'bbs'}">selected="selected"</c:if>>게시물</option>
						<option value="menu" <c:if test="${paramVO.rangeView eq 'menu'}">selected="selected"</c:if>>메뉴</option>
						<option value="files" <c:if test="${paramVO.rangeView eq 'files'}">selected="selected"</c:if>>첨부파일</option>
					</select>
				</span>
				<span class="tl input_search_con">
					<input type="text" class="board_search" name="q" id="q" title="검색어를 입력해 주세요." value="${param.q}" />
					<!-- <a href="#self" class="btn btn-primary mr50">검색</a> -->
					<input type="submit" value="" class="search_summit" title="검색">
				</span>
				<span class="check_style_0_con">
					<input type="checkbox" name="re" class="check_style_0" id="re" value="Y" <c:if test="${paramVO.re eq 'Y'}">checked="checked"</c:if>/>
					<label for="re">결과 내 검색</label>
				</span>
			</fieldset>
		</div>
	</form>
</div>

<!-- 인기검색어 -->
<div class="mb20">
	<div class="hotkeyword">
		<h2 class="fl">인기검색어</h2>
		<div class="over-hidden hotkeyword_list_con">
			<ul>
				<c:forEach var="result" items="${psList}" varStatus="status">
					<li class="ico_${status.count}"><a href="javascript:search('${result.srchwrd}');"><span class="num">${status.count}</span><span class="txt">${result.srchwrd}</span></a></li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>

	<ul class="photoTab photoTab-size5 online_edu_tab_style">
		<li <c:if test="${empty paramVO.rangeView}">class="active"</c:if>><a href="javascript:detailView('');" <c:if test="${empty paramVO.rangeView}">title="현재탭"</c:if>>통합검색(${totalCount})</a><c:if test="${empty paramVO.rangeView}"></c:if></li>
		<li <c:if test="${paramVO.rangeView eq 'progrm'}">class="active"</c:if>><a href="javascript:detailView('progrm');" <c:if test="${paramVO.rangeView eq 'progrm'}">title="현재탭"</c:if>>프로그램(${empty progrmResultList[0] ? 0 : progrmResultList[0].numFound})</a><c:if test="${paramVO.rangeView eq 'progrm'}"></c:if></li>
		<li <c:if test="${paramVO.rangeView eq 'onlineEdu'}">class="active"</c:if>><a href="javascript:detailView('onlineEdu');" <c:if test="${paramVO.rangeView eq 'onlineEdu'}">title="현재탭"</c:if>>교육/강좌(${empty onlineEduResultList[0] ? 0 : onlineEduResultList[0].numFound})</a><c:if test="${paramVO.rangeView eq 'onlineEdu'}"></c:if></li>
		<li <c:if test="${paramVO.rangeView eq 'webpage'}">class="active"</c:if>><a href="javascript:detailView('webpage');" <c:if test="${paramVO.rangeView eq 'webpage'}">title="현재탭"</c:if>>웹페이지(${empty webpageResultList[0] ? 0 : webpageResultList[0].numFound})</a><c:if test="${paramVO.rangeView eq 'webpage'}"></c:if></li>
		<li <c:if test="${paramVO.rangeView eq 'bbs'}">class="active"</c:if>><a href="javascript:detailView('bbs');" <c:if test="${paramVO.rangeView eq 'bbs'}">title="현재탭"</c:if>>게시물(${empty bbsResultList[0] ? 0 : bbsResultList[0].numFound})</a><c:if test="${paramVO.rangeView eq 'bbs'}"></c:if></li>
		<li <c:if test="${paramVO.rangeView eq 'menu'}">class="active"</c:if>><a href="javascript:detailView('menu');" <c:if test="${paramVO.rangeView eq 'menu'}">title="현재탭"</c:if>>메뉴(${empty menuResultList[0] ? 0 : menuResultList[0].numFound})</a><c:if test="${paramVO.rangeView eq 'menu'}"></c:if></li>
		<li <c:if test="${paramVO.rangeView eq 'files'}">class="active"</c:if>><a href="javascript:detailView('files');" <c:if test="${paramVO.rangeView eq 'files'}">title="현재탭"</c:if>>첨부파일(${empty filesResultList[0] ? 0 : filesResultList[0].numFound})</a><c:if test="${paramVO.rangeView eq 'files'}"></c:if></li>
	</ul>

	<c:choose>
		<c:when test="${paramVO.rangeView eq 'progrm'}"><c:set var="rangeNm" value="프로그램"/><c:set var="cnt" value="${empty progrmResultList[0] ? 0 : progrmResultList[0].numFound}"/></c:when>
		<c:when test="${paramVO.rangeView eq 'onlineEdu'}"><c:set var="rangeNm" value="교육/강좌"/><c:set var="cnt" value="${empty onlineEduResultList[0] ? 0 : onlineEduResultList[0].numFound}"/></c:when>
		<c:when test="${paramVO.rangeView eq 'webpage'}"><c:set var="rangeNm" value="웹페이지"/><c:set var="cnt" value="${empty webpageResultList[0] ? 0 : webpageResultList[0].numFound}"/></c:when>
		<c:when test="${paramVO.rangeView eq 'bbs'}"><c:set var="rangeNm" value="게시물"/><c:set var="cnt" value="${empty bbsResultList[0] ? 0 : bbsResultList[0].numFound}"/></c:when>
		<c:when test="${paramVO.rangeView eq 'menu'}"><c:set var="rangeNm" value="메뉴"/><c:set var="cnt" value="${empty menuResultList[0] ? 0 : menuResultList[0].numFound}"/></c:when>
		<c:when test="${paramVO.rangeView eq 'files'}"><c:set var="rangeNm" value="첨부파일"/><c:set var="cnt" value="${empty filesResultList[0] ? 0 : filesResultList[0].numFound}"/></c:when>
		<c:otherwise><c:set var="rangeNm" value="전체"/><c:set var="cnt" value="${totalCount}"/></c:otherwise>
	</c:choose>
	<p class="mb10 alert_highlight_title">검색어 <span class="point0">"${paramVO.q}"</span>에 대한 ${rangeNm} <span class="point0" id="searchCnt">"${cnt}"</span>개의 검색 결과를 찾았습니다.</p>

	<div class="searchSet">

	<!-- 프로그램 -->
	<c:if test="${rangeAll or paramVO.rangeView eq 'progrm'}">

		<div class="alert">
			<p class="alert_design_text"> 프로그램 (검색결과 ${empty progrmResultList[0] ? 0 : progrmResultList[0].numFound}건)</p>
			<c:if test="${fn:length(progrmResultList)>0}">
				<div class="moreBtn">
					<c:if test="${paramVO.rangeView eq 'progrm'}">
						<a href="#self" class="more" id="more_${paramVO.rangeView}"> <span><i class="fa fa-search-plus"></i> 상세검색</span></a>
					</c:if>
					<c:if test="${paramVO.rangeView ne 'progrm'}">
						<a href="javascript:detailView('progrm');" class="more"> <span>더 보기 +</span></a>
					</c:if>
				</div>
			</c:if>
		</div>
		<!-- 상세검색 -->
		<jsp:include page="/WEB-INF/jsp/edu/search/detail.jsp" flush="true" />

		<ul class="bull" id="ul_progrm">
			<c:forEach var="result" items="${progrmResultList}" varStatus="status">
				<c:if test="${status.count <= progrmCnt}">
					<li class="statSet">
						<a href="<c:out value="${result.fullMenuLink}"/>" target="_blank" title="새창열림">
							<span class="tit">
								<span class="status">
									<c:choose>
										<c:when test="${result.progrsSttus eq 'W'}">대기</c:when>
										<c:when test="${result.progrsSttus eq 'P'}">진행중</c:when>
										<c:when test="${result.progrsSttus eq 'F'}">마감</c:when>
									</c:choose>
								</span>
								<span class="fcBlue">[${result.prgSeNm}-${result.prgClNm}]</span> ${result.prgNm}
							</span>
							<span class="txt">
								(신청방식 : ${result.reqstMthdNm} / 정원 : ${empty result.psncpa ? '-' : result.psncpa} 명 / 신청접수 : ${result.beginDt}~${result.endDt})  
								${result.hl}
							</span>
				  		</a>
			  		</li>
		  		</c:if>
		  	</c:forEach>
			<c:if test="${fn:length(progrmResultList) == 0}"><li class="statSet">검색 결과가 없습니다.</li></c:if>
		</ul>
	</c:if>

	<!-- 교육/강좌 -->
	<c:if test="${rangeAll or paramVO.rangeView eq 'onlineEdu'}">
		<div class="alert">
			<p class="alert_design_text"> 교육/강좌 (검색결과 ${empty onlineEduResultList[0] ? 0 : onlineEduResultList[0].numFound}건)</p>
			<c:if test="${fn:length(onlineEduResultList)>0}">
				<div class="moreBtn">
					<c:if test="${paramVO.rangeView eq 'onlineEdu'}">
						<a href="#self" class="more" id="more_${paramVO.rangeView}"> <span><i class="fa fa-search-plus"></i> 상세검색</span></a>
					</c:if>
					<c:if test="${paramVO.rangeView ne 'onlineEdu'}">
						<a href="javascript:detailView('onlineEdu');" class="more"> <span>더 보기 +</span></a>
					</c:if>
				</div>
			</c:if>
		</div>
		<!-- 상세검색 -->
		<jsp:include page="/WEB-INF/jsp/edu/search/detail.jsp" flush="true" />

		<ul class="bull" id="ul_onlineEdu">
			<c:forEach var="result" items="${onlineEduResultList}" varStatus="status">
				<c:if test="${status.count <= onlineEduCnt}">
					<li class="statSet">
						<a href="<c:out value="${result.fullMenuLink}"/>" target="_blank" title="새창열림">
						<span class="tit">
							<span class="status">
								<c:choose>
									<c:when test="${result.gubunSe eq '01'}">정규과정</c:when>
									<c:when test="${result.gubunSe eq '02'}">열린강좌</c:when>
									<c:when test="${result.gubunSe eq '03'}">테마과정</c:when>
								</c:choose>
							</span>
							<span class="fcBlue">
								<c:choose>
									<c:when test="${result.gubunSe eq '01'}">
										<c:choose>
											<c:when test="${result.gubun eq 'realm'}">[분야별</c:when>
											<c:when test="${result.gubun eq 'occp'}">[직업별</c:when>
										</c:choose>
										- ${result.categoryNm}]
									</c:when>
									<c:otherwise>[${result.categoryNm}]</c:otherwise>
								</c:choose>
							</span> ${result.title}
						</span>
						<span class="txt">${result.hl}</span>
				  		</a>
			  		</li>
			  	</c:if>
			</c:forEach>
			<c:if test="${fn:length(onlineEduResultList) == 0}"><li class="statSet">검색 결과가 없습니다.</li></c:if>
		</ul>
	</c:if>

	<!-- 웹페이지 -->
	<c:if test="${rangeAll or paramVO.rangeView eq 'webpage'}">
		<div class="alert">
			<p class="alert_design_text"> 웹페이지 (검색결과 ${empty webpageResultList[0] ? 0 : webpageResultList[0].numFound}건)</p>
			<c:if test="${fn:length(webpageResultList)>0}">
				<div class="moreBtn">
					<c:if test="${paramVO.rangeView ne 'webpage'}">
						<a href="javascript:detailView('webpage');" class="more"> <span>더 보기 +</span></a>
					</c:if>
				</div>
			</c:if>
		</div>
		<ul class="bull">
			<c:forEach var="result" items="${webpageResultList}" varStatus="status">
				<c:if test="${status.count <= webpageCnt}">
					<li>
						<a href="http://<c:out value="${result.fullMenuLink}"/>" target="_blank" title="새창열림">
						<span class="tit">
							<span class="fcBlue uline">[${fn:replace(result.relateMenuNmList,'|', ' > ')}]</span>
						</span>
						<span class="txt">${result.hl}</span>
				  		</a>
			  		</li>
		  		</c:if>
		  	</c:forEach>
			<c:if test="${fn:length(webpageResultList) == 0}"><li>검색 결과가 없습니다.</li></c:if>
		</ul>
	</c:if>

	<!-- 게시물 -->
	<c:if test="${rangeAll or paramVO.rangeView eq 'bbs'}">
		<div class="alert">
			<p class="alert_design_text"> 게시물 (검색결과 ${empty bbsResultList[0] ? 0 : bbsResultList[0].numFound}건)</p>
			<c:if test="${fn:length(bbsResultList)>0}">
				<div class="moreBtn">
					<c:if test="${paramVO.rangeView eq 'bbs'}">
						<a href="#self" class="more" id="more_${paramVO.rangeView}"> <span><i class="fa fa-search-plus"></i> 상세검색</span></a>
					</c:if>
					<c:if test="${paramVO.rangeView ne 'bbs'}">
						<a href="javascript:detailView('bbs');" class="more"> <span>더 보기 +</span></a>
					</c:if>
				</div>
			</c:if>
		</div>
		<!-- 상세검색 -->
		<jsp:include page="/WEB-INF/jsp/edu/search/detail.jsp" flush="true" />

		<ul class="bull" id="ul_bbs">
			<c:forEach var="result" items="${bbsResultList}" varStatus="status">
				<c:if test="${status.count <= bbsCnt}">
					<li>
						<a href="/edu/bbs/${result.bbsId}/view.do?nttId=${result.nttId}&amp;menuNo=${result.menuNo}" target="_blank" title="새창열림">
						<span class="tit">
							<span class="fcBlue uline">[${fn:replace(result.relateMenuNmList,'|', ' > ')}]</span> <c:out value="${result.nttSj}"  /><span class="date"> <fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/></span>
						</span>
						<span class="txt"><c:out value="${result.hl}" /></span>
				  		</a>
			  		</li>
		  		</c:if>
		  	</c:forEach>
			<c:if test="${fn:length(bbsResultList) == 0}"><li>검색 결과가 없습니다.</li></c:if>
		</ul>
	</c:if>

	<!-- 메뉴 -->
	<c:if test="${rangeAll or paramVO.rangeView eq 'menu'}">
		<div class="alert">
			<p class="alert_design_text">메뉴 (검색결과 ${empty menuResultList[0] ? 0 : menuResultList[0].numFound}건)</p>
			<c:if test="${fn:length(menuResultList)>0}">
				<div class="moreBtn">
					<c:if test="${paramVO.rangeView ne 'menu'}">
						<a href="javascript:detailView('menu');" class="more"> <span>더 보기 +</span></a>
					</c:if>
				</div>
			</c:if>
		</div>
		<ul class="bull">
			<c:forEach var="result" items="${menuResultList}" varStatus="status">
				<li>
					<a href="${result.fullMenuLink}" target="_blank" title="새창열림" class="tit">
						${fn:replace(empty result.hl ? result.relateMenuNmList : result.hl,'|',' > ')}
					</a>
				</li>
			</c:forEach>
			<c:if test="${fn:length(menuResultList) == 0}"><li>검색 결과가 없습니다.</li></c:if>
		</ul>
	</c:if>

	<!-- 첨부파일 -->
	<c:if test="${rangeAll or paramVO.rangeView eq 'files'}">
		<div class="alert">
			<p class="alert_design_text"> 첨부파일 (검색결과 ${empty filesResultList[0] ? 0 : filesResultList[0].numFound}건)</p>
			<c:if test="${fn:length(filesResultList)>0}">
				<div class="moreBtn">
					<c:if test="${paramVO.rangeView eq 'files'}">
						<a href="#self" class="more" id="more_${paramVO.rangeView}"> <span><i class="fa fa-search-plus"></i> 상세검색</span></a>
					</c:if>
					<c:if test="${paramVO.rangeView ne 'files'}">
						<a href="javascript:detailView('files');" class="more"> <span>더 보기 +</span></a>
					</c:if>
				</div>
			</c:if>
		</div>
		<!-- 상세검색 -->
		<jsp:include page="/WEB-INF/jsp/edu/search/detail.jsp" flush="true" />

		<ul class="bull" id="ul_files">
			<c:forEach var="result" items="${filesResultList}" varStatus="status">
				<li>
					<c:choose>
						<c:when test="${result.fileExtsn eq 'doc' or result.fileExtsn eq 'docx'}"><c:set var="fileType" value="icoWord"/></c:when>
						<c:when test="${result.fileExtsn eq 'ppt' or result.fileExtsn eq 'pptx'}"><c:set var="fileType" value="icoPpt"/></c:when>
						<c:when test="${result.fileExtsn eq 'xls' or result.fileExtsn eq 'xlsx'}"><c:set var="fileType" value="icoXls"/></c:when>
						<c:when test="${result.fileExtsn eq 'pdf'}"><c:set var="fileType" value="icoPdf"/></c:when>
						<c:otherwise><c:set var="fileType" value="icoFile"/></c:otherwise>
					</c:choose>
					<a href="/edu/cmm/fms/FileDown.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" class="${fileType}">
						<span class="tit">${result.orignlFileNm} <span class="date"> <fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/></span></span>
						<span class="db">
							<span class="fcBlue">[${fn:replace(result.relateMenuNmList,'|', ' > ')}]</span>${result.nttSj}<br/>${result.hl}
						</span>
					</a>
				</li>
			</c:forEach>
			<c:if test="${fn:length(filesResultList) == 0}"><li>검색 결과가 없습니다.</li></c:if>
		</ul>
	</c:if>

	</div>

	<c:if test="${not empty paramVO.rangeView}">
		<div class="paging">${pageNav}</div>
	</c:if>


