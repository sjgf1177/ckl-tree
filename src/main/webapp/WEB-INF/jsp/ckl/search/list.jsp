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

<script type="text/javascript" src="/js/jquery-ui-1.9.2.custom.min.js"></script>
<script type="text/javascript">

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
	        	$.getJSON("/ckl/search/suggest.json",
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
			alert("???????????? ???????????????.");
			$("#q")[0].focus();
			return false;
		}
		return true;
	}

</script>

<!-- ???????????? ????????? -->
<form name="frmSearch" class="form-inline" method="post" action="/ckl/search/list.do?menuNo=${param.menuNo}" onsubmit="return checkForm(this);">
	<input type="hidden" id="prevQ" name="prevQ" value="${paramVO.q}" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${paramVO.pageIndex}" />
	<div class="formLine1">
		<fieldset>
			<legend>???????????? ?????????</legend>
			<div class="fr" style="width:500px">
				<label for="rangeView" class="tac hidden"><strong>????????????</strong></label>
				<select name="rangeView" id="rangeView" title="????????? ????????? ?????????."  class="mr30">
					<option value="">????????????</option>
					<option value="progrm" <c:if test="${paramVO.rangeView eq 'progrm'}">selected="selected"</c:if>>????????????</option>
					<option value="webpage" <c:if test="${paramVO.rangeView eq 'webpage'}">selected="selected"</c:if>>????????????</option>
					<option value="bbs" <c:if test="${paramVO.rangeView eq 'bbs'}">selected="selected"</c:if>>?????????</option>
					<option value="menu" <c:if test="${paramVO.rangeView eq 'menu'}">selected="selected"</c:if>>??????</option>
					<option value="files" <c:if test="${paramVO.rangeView eq 'files'}">selected="selected"</c:if>>????????????</option>
				</select>
				<input type="text" name="q" id="q" title="???????????? ????????? ?????????." value="${param.q}" />
				<!-- <a href="#self" class="btn btn-primary mr50">??????</a> -->
				<input type="submit" value="??????" class="btn btn-primary mr20"/>
				<input type="checkbox" stystyle="width:25px;" class="vm mr5" name="re" id="re" value="Y" <c:if test="${paramVO.re eq 'Y'}">checked="checked"</c:if>/><label for="re">?????? ??? ???????? </label>
			</div>
		</fieldset>
	</div>
</form>

	<div class="stepInline stepInlineSm  mb10">
		<ol>
			<li <c:if test="${empty paramVO.rangeView}">class="on"</c:if>><a href="javascript:detailView('');">????????????(${totalCount})</a><c:if test="${empty paramVO.rangeView}"><span class="sr-only">(????????????)</span></c:if></li>
			<li <c:if test="${paramVO.rangeView eq 'progrm'}">class="on"</c:if>><a href="javascript:detailView('progrm');">????????????(${empty progrmResultList[0] ? 0 : progrmResultList[0].numFound})</a><c:if test="${paramVO.rangeView eq 'progrm'}"><span class="sr-only">(????????????)</span></c:if></li>
			<li <c:if test="${paramVO.rangeView eq 'webpage'}">class="on"</c:if>><a href="javascript:detailView('webpage');">????????????(${empty webpageResultList[0] ? 0 : webpageResultList[0].numFound})</a><c:if test="${paramVO.rangeView eq 'webpage'}"><span class="sr-only">(????????????)</span></c:if></li>
			<li <c:if test="${paramVO.rangeView eq 'bbs'}">class="on"</c:if>><a href="javascript:detailView('bbs');">?????????(${empty bbsResultList[0] ? 0 : bbsResultList[0].numFound})</a><c:if test="${paramVO.rangeView eq 'bbs'}"><span class="sr-only">(????????????)</span></c:if></li>
			<li <c:if test="${paramVO.rangeView eq 'menu'}">class="on"</c:if>><a href="javascript:detailView('menu');">??????(${empty menuResultList[0] ? 0 : menuResultList[0].numFound})</a><c:if test="${paramVO.rangeView eq 'menu'}"><span class="sr-only">(????????????)</span></c:if></li>
			<li <c:if test="${paramVO.rangeView eq 'files'}">class="on"</c:if>><a href="javascript:detailView('files');">????????????(${empty filesResultList[0] ? 0 : filesResultList[0].numFound})</a><c:if test="${paramVO.rangeView eq 'files'}"><span class="sr-only">(????????????)</span></c:if></li>
		</ol>
	</div>

	<!-- ??????????????? -->
	<div class="tar">
		<div class="hotkeyword">
			<h2 class="dib mb0 fs1 fl mr10 ml10">???????????????</h2>
			<ol class="clearfix fl">
				<c:forEach var="result" items="${psList}" varStatus="status">
					<li class="ico_${status.count}"><a href="javascript:search('${result.srchwrd}');"><span class="num">${status.count}</span><span class="txt">${result.srchwrd}</span></a></li>
				</c:forEach>
			</ol>
		</div>
	</div>

	<c:choose>
		<c:when test="${paramVO.rangeView eq 'progrm'}"><c:set var="rangeNm" value="????????????"/><c:set var="cnt" value="${empty progrmResultList[0] ? 0 : progrmResultList[0].numFound}"/></c:when>
		<c:when test="${paramVO.rangeView eq 'webpage'}"><c:set var="rangeNm" value="????????????"/><c:set var="cnt" value="${empty webpageResultList[0] ? 0 : webpageResultList[0].numFound}"/></c:when>
		<c:when test="${paramVO.rangeView eq 'bbs'}"><c:set var="rangeNm" value="?????????"/><c:set var="cnt" value="${empty bbsResultList[0] ? 0 : bbsResultList[0].numFound}"/></c:when>
		<c:when test="${paramVO.rangeView eq 'menu'}"><c:set var="rangeNm" value="??????"/><c:set var="cnt" value="${empty menuResultList[0] ? 0 : menuResultList[0].numFound}"/></c:when>
		<c:when test="${paramVO.rangeView eq 'files'}"><c:set var="rangeNm" value="????????????"/><c:set var="cnt" value="${empty filesResultList[0] ? 0 : filesResultList[0].numFound}"/></c:when>
		<c:otherwise><c:set var="rangeNm" value="??????"/><c:set var="cnt" value="${totalCount}"/></c:otherwise>
	</c:choose>
	<p>????????? <strong class="text-danger">"${paramVO.q}"</strong>??? ?????? ${rangeNm} <strong class="text-danger" id="searchCnt">"${cnt}"</strong>?????? ?????? ????????? ???????????????.</p>

	<div class="searchSet">

	<!-- ???????????? -->
	<c:if test="${rangeAll or paramVO.rangeView eq 'progrm'}">

		<div class="hgroup">
			<h2 class="searchCntTxt"> ???????????? (???????????? ${empty progrmResultList[0] ? 0 : progrmResultList[0].numFound}???)</h2>
			<c:if test="${fn:length(progrmResultList)>0}">
				<div class="moreBtn">
					<c:if test="${paramVO.rangeView eq 'progrm'}">
						<a href="#self" class="more" id="more_${paramVO.rangeView}"> <span><i class="fa fa-search-plus"></i> ????????????</span></a>
					</c:if>
					<c:if test="${paramVO.rangeView ne 'progrm'}">
						<a href="javascript:detailView('progrm');" class="more"> <span>??? ?????? +</span></a>
					</c:if>
				</div>
			</c:if>
		</div>
		<!-- ???????????? -->
		<jsp:include page="/WEB-INF/jsp/ckl/search/detail.jsp" flush="true" />

		<ul class="bull" id="ul_progrm">
			<c:forEach var="result" items="${progrmResultList}" varStatus="status">
				<c:if test="${status.count <= progrmCnt}">
					<li class="statSet">
						<a href="<c:out value="${result.fullMenuLink}"/>" target="_blank" title="????????????">
							<span class="tit">
								<span class="status">
									<c:choose>
										<c:when test="${result.progrsSttus eq 'W'}">??????</c:when>
										<c:when test="${result.progrsSttus eq 'P'}">?????????</c:when>
										<c:when test="${result.progrsSttus eq 'F'}">??????</c:when>
									</c:choose>
								</span>
								<span class="fcBlue">[${result.prgSeNm}-${result.prgClNm}]</span> <c:out value="${result.prgNm}" escapeXml="false" />
								<span class="dib newWin"><span class="sr-only">(????????????)</span></span>
							</span>
							<span class="txt">
								(???????????? : ${result.reqstMthdNm} / ?????? : ${empty result.psncpa ? '-' : result.psncpa} ??? / ???????????? : ${result.beginDt}~${result.endDt}) ??
								${result.hl}
							</span>
				  		</a>
			  		</li>
		  		</c:if>
		  	</c:forEach>
			<c:if test="${fn:length(progrmResultList) == 0}"><li class="statSet">?????? ????????? ????????????.</li></c:if>
		</ul>
	</c:if>

	<!-- ???????????? -->
	<c:if test="${rangeAll or paramVO.rangeView eq 'webpage'}">
		<div class="hgroup">
			<h2> ???????????? (???????????? ${empty webpageResultList[0] ? 0 : webpageResultList[0].numFound}???)</h2>
			<c:if test="${fn:length(webpageResultList)>0}">
				<div class="moreBtn">
					<c:if test="${paramVO.rangeView ne 'webpage'}">
						<a href="javascript:detailView('webpage');" class="more"> <span>??? ?????? +</span></a>
					</c:if>
				</div>
			</c:if>
		</div>
		<ul class="bull" >
			<c:forEach var="result" items="${webpageResultList}" varStatus="status">
				<c:if test="${status.count <= webpageCnt}">
					<li>
						<a href="http://<c:out value="${result.fullMenuLink}"/>" target="_blank" title="????????????">
						<span class="tit">
							<span class="fcBlue uline">[${fn:replace(result.relateMenuNmList,'|', ' > ')}]</span>
							<span class="dib newWin"><span class="sr-only">(????????????)</span></span>
						</span>
						<span class="txt">${result.hl}</span>
				  		</a>
			  		</li>
		  		</c:if>
		  	</c:forEach>
			<c:if test="${fn:length(webpageResultList) == 0}"><li>?????? ????????? ????????????.</li></c:if>
		</ul>
	</c:if>

	<!-- ????????? -->
	<c:if test="${rangeAll or paramVO.rangeView eq 'bbs'}">
		<div class="hgroup">
			<h2 class="searchCntTxt"> ????????? (???????????? ${empty bbsResultList[0] ? 0 : bbsResultList[0].numFound}???)</h2>
			<c:if test="${fn:length(bbsResultList)>0}">
				<div class="moreBtn">
					<c:if test="${paramVO.rangeView eq 'bbs'}">
						<a href="#self" class="more" id="more_${paramVO.rangeView}"> <span><i class="fa fa-search-plus"></i> ????????????</span></a>
					</c:if>
					<c:if test="${paramVO.rangeView ne 'bbs'}">
						<a href="javascript:detailView('bbs');" class="more"> <span>??? ?????? +</span></a>
					</c:if>
				</div>
			</c:if>
		</div>
		<!-- ???????????? -->
		<jsp:include page="/WEB-INF/jsp/ckl/search/detail.jsp" flush="true" />

		<ul class="bull" id="ul_bbs">
			<c:forEach var="result" items="${bbsResultList}" varStatus="status">
				<c:if test="${status.count <= bbsCnt}">
					<li>
						<a href="/ckl/bbs/${result.bbsId}/view.do?nttId=${result.nttId}&amp;menuNo=${result.menuNo}" target="_blank" title="????????????">
						<span class="tit">
							<span class="fcBlue uline">[${fn:replace(result.relateMenuNmList,'|', ' > ')}]</span> <c:out value="${result.nttSj}" escapeXml="false" /><span class="date"> <fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/></span>
							<span class="dib newWin"><span class="sr-only">(????????????)</span></span>
						</span>
						<span class="txt"><c:out value="${result.hl}" /></span>
				  		</a>
			  		</li>
		  		</c:if>
		  	</c:forEach>
			<c:if test="${fn:length(bbsResultList) == 0}"><li>?????? ????????? ????????????.</li></c:if>
		</ul>
	</c:if>

	<!-- ?????? -->
	<c:if test="${rangeAll or paramVO.rangeView eq 'menu'}">
		<div class="hgroup first">
			<h2>?????? (???????????? ${empty menuResultList[0] ? 0 : menuResultList[0].numFound}???)</h2>
			<c:if test="${fn:length(menuResultList)>0}">
				<div class="moreBtn">
					<c:if test="${paramVO.rangeView ne 'menu'}">
						<a href="javascript:detailView('menu');" class="more"> <span>??? ?????? +</span></a>
					</c:if>
				</div>
			</c:if>
		</div>
		<ul class="bull">
			<c:forEach var="result" items="${menuResultList}" varStatus="status">
				<li>
					<a href="<c:out value="${result.fullMenuLink}"/>" target="_blank" title="????????????" class="tit">
						${fn:replace(empty result.hl ? result.relateMenuNmList : result.hl,'|',' > ')}<span class="dib newWin"><span class="sr-only">(????????????)</span></span>
					</a>
				</li>
			</c:forEach>
			<c:if test="${fn:length(menuResultList) == 0}"><li>?????? ????????? ????????????.</li></c:if>
		</ul>
	</c:if>

	<!-- ???????????? -->
	<c:if test="${rangeAll or paramVO.rangeView eq 'files'}">
		<div class="hgroup">
			<h2 class="searchCntTxt"> ???????????? (???????????? ${empty filesResultList[0] ? 0 : filesResultList[0].numFound}???)</h2>
			<c:if test="${fn:length(filesResultList)>0}">
				<div class="moreBtn">
					<c:if test="${paramVO.rangeView eq 'files'}">
						<a href="#self" class="more" id="more_${paramVO.rangeView}"> <span><i class="fa fa-search-plus"></i> ????????????</span></a>
					</c:if>
					<c:if test="${paramVO.rangeView ne 'files'}">
						<a href="javascript:detailView('files');" class="more"> <span>??? ?????? +</span></a>
					</c:if>
				</div>
			</c:if>
		</div>
		<!-- ???????????? -->
		<jsp:include page="/WEB-INF/jsp/ckl/search/detail.jsp" flush="true" />

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
					<a href="/ckl/cmm/fms/FileDown.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" class="${fileType}">
						<span class="tit">${result.orignlFileNm} <span class="date"> <fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/></span><span class="dib newWin"><span class="sr-only">(????????????)</span></span></span>
						<span class="db">
							<span class="fcBlue">[${fn:replace(result.relateMenuNmList,'|', ' > ')}]</span>${result.nttSj}<br/>${result.hl}
						</span>
					</a>
				</li>
			</c:forEach>
			<c:if test="${fn:length(filesResultList) == 0}"><li>?????? ????????? ????????????.</li></c:if>
		</ul>
	</c:if>

	</div>

	<c:if test="${not empty paramVO.rangeView}">
		<div class="paging">${pageNav}</div>
	</c:if>


