<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript">

	var rangeView = "<c:out value='${paramVO.rangeView}'/>";
	var codeIdVal = "<c:out value='${codeId0}'/>";
	var prgSeVal = "<c:out value='${param.prgSe}'/>";
	var prgClVal = "<c:out value='${param.prgCl}'/>";

	$(function() {

		if (prgSeVal != "") getCodeList("prgCl", codeIdVal, $("#prgSe").val(), 2, prgClVal);

		$("select[name=prgSe]").change(function(){
			var val = $(this).val();
			getCodeList("prgCl", codeIdVal, val, 2);
		});

	});

	//공통 코드목록 화면처리
	function getCodeList(elemntId, codeId, upperCode, depth, code) {
		var $obj = $("#"+ elemntId);
		var url = "/cmmn/cmmncode/codeListJson.do";
		var params = {
			codeId : codeId,
			upperCode : upperCode
		};
		$.get(url, params, function(data) {
			if (data) {
				$obj.empty();
				$("<option>").text("분류 선택").attr("value","").appendTo($obj);
				$.each(data.list, function(key,item) {
					var $codeItem = $("<option>").attr("value", item.code).text(item.codeNm);
					if (code == item.code) $codeItem.attr("selected",true);
					$codeItem.appendTo($obj);
				});
				if ("prgCl" == elemntId && "" == upperCode) {
					$("<option>").text("분류 선택").attr("value","").appendTo($("#prgCl").empty());
				}
			}
		},"json");
	}

	function checkDetailForm(){
		if ($("#q").val() == "") {
			alert("검색어를 입력하세요.");
			$("#q").focus();
			return;
		}

		var data = $("#frmDetailSearch").serialize();
		$.post("/ckl/search/list.json", data, function(data) {
			var html = "";
			var cnt = data.resultList.length;
			var pageNav = data.pageNav;

			if (cnt > 0) {
				$.each(data.resultList, function(i, item) {
					if (rangeView == "progrm") {
						html += getProgrmHtml(item.fullMenuLink, item.progrsSttus, item.prgSeNm, item.prgClNm, item.prgNm, item.reqstMthdNm, item.psncpa, item.beginDt, item.endDt, item.hl);
					}
					else if (rangeView == "bbs") {
						html += getBbsHtml(item.bbsId, item.nttId, item.menuNo, item.relateMenuNmList, item.nttSj, item.regDate, item.hl);
					}
					else if (rangeView == "files") {
						html += getFilesHtml(item.fileExtsn, item.atchFileId, item.fileSn, item.orignlFileNm, item.regDate, item.relateMenuNmList, item.nttSj, item.hl);
					}
				});
			}
			else {
				html = '<li class="statSet">검색 결과가 없습니다.</li>';
			}

			var rangeNm = "";
			if (rangeView == "progrm") rangeNm = "프로그램 (검색결과 "+cnt+"건)";
			if (rangeView == "bbs") rangeNm = "게시물 (검색결과 "+cnt+"건)";
			if (rangeView == "file") rangeNm = "첨부파일 (검색결과 "+cnt+"건)";

			$("#searchCnt").html(cnt);
			$(".searchCntTxt").html(rangeNm);
			$(".paging").html(pageNav);
			$("#detailHtml").html(html);
		});
	}

	function getProgrmHtml(fullMenuLink, progrsSttus, prgSeNm, prgClNm, prgNm, reqstMthdNm, psncpa, beginDt, endDt, hl, cnt) {
		var psncpaVal = psncpa;
		var progrsSttusVal = '';

		if (progrsSttus == "W") progrsSttusVal = "대기";
		if (progrsSttus == "P") progrsSttusVal = "진행중";
		if (progrsSttus == "F") progrsSttusVal = "마감";
		if (psncpa == null) psncpaVal = "-";

		html =
			'<li class="statSet">'+
				'<a href="'+fullMenuLink+'" target="_blank" title="새창열림">'+
					'<span class="tit"><span class="status">'+progrsSttusVal+'</span><span class="fcBlue">['+prgSeNm+'-'+prgClNm+']</span> '+prgNm+'<span class="dib newWin"><span class="sr-only">(새창열림)</span></span></span>'+
					'<span class="txt">(신청방식 : '+reqstMthdNm+' / 정원 : '+psncpaVal+' 명 / 신청접수 : '+beginDt+'~'+endDt+')'+hl+'</span>'+
				'</a>'+
			'</li>';

		return html;
	}

	function getBbsHtml(bbsId, nttId, menuNo, relateMenuNmList, nttSj, regDate, hl) {
		var html = '';
		var relateMenuNmListVal = relateMenuNmList.replace('|', ' > ');

		html =
			'<li>'+
				'<a href="/ckl/bbs/'+bbsId+'/view.do?nttId='+nttId+'&amp;menuNo='+menuNo+'" target="_blank" title="새창열림">'+
					'<span class="tit"><span class="fcBlue uline">'+relateMenuNmListVal+'</span> '+nttSj+' <span class="date">'+regDate+'</span><span class="dib newWin"><span class="sr-only">(새창열림)</span></span></span>'+
					'<span class="txt">'+hl+'</span>'+
				'</a>'+
			'</li>';
		return html;
	}

	function getFilesHtml(fileExtsn, atchFileId, fileSn, orignlFileNm, regDate, relateMenuNmList, nttSj, hl) {
		var html = '';
		var relateMenuNmListVal = relateMenuNmList.replace('|', ' > ');
		var fileType = "";
		if (fileExtsn == "doc" || fileExtsn == "docx") {
			fileType = "icoWord";
		}
		else if (fileExtsn == "ppt" || fileExtsn == "pptx") {
			fileType = "icoPpt";
		}
		else if (fileExtsn == "xls" || fileExtsn == "xlsx") {
			fileType = "icoXls";
		}
		else if (fileExtsn == "pdf") {
			fileType = "icoPdf";
		}
		else {
			fileType = "icoFile";
		}

		html =
			'<li>'+
				'<a href="/ckl/cmm/fms/FileDown.do?atchFileId='+atchFileId+'&amp;fileSn='+fileSn+'" class="'+fileType+'">'+
					'<span class="tit">'+orignlFileNm+' <span class="date">'+regDate+'</span><span class="dib newWin"><span class="sr-only">(새창열림)</span></span></span>'+
					'<span class="db"><span class="fcBlue">'+relateMenuNmListVal+'</span> '+nttSj+'<br/>'+hl+'</span>'+
				'</a>'+
			'</li>';
		return html;
	}

</script>

<!-- 상세검색 -->
<c:if test="${not empty paramVO.rangeView}">
	<form name="frmDetailSearch" id="frmDetailSearch" class="form-inline" method="post" action="#">
	<input type="hidden" name="menuNo" value="${param.menuNo}"/>
	<input type="hidden" name="rangeView" value="${paramVO.rangeView}"/>
	<input type="hidden" name="range" value="${paramVO.rangeView}"/>
	<input type="hidden" name="pageIndex" value="${paramVO.pageIndex}" />
	<input type="hidden" name="q" value="${paramVO.q}"/>
		<div class="con_sh_more" id="con_more_${paramVO.rangeView}" style="display: block;">
			<div class="set">
				<c:choose>
					<c:when test="${paramVO.rangeView eq 'progrm'}">
						<dl>
							<dt>진행상태</dt>
							<dd>
								<select name="progrsSttus" id="progrsSttus" title="진행상태 선택">
									<option value="">진행상태 선택</option>
									<c:forEach var="code" items="${COM052CodeList}" varStatus="status">
										<option value="${code.code}" <c:if test="${paramVO.progrsSttus eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
									 </c:forEach>
								</select>
							</dd>
							<dt>신청기간</dt>
							<dd style="width:420px;" class="tar">
								<span class="i">
									<input name="beginDt" title="검색기간 시작 날짜 예) 2015-01-11" class="input_txt sdate" id="beginDt" type="text" value="${paramVO.beginDt}">
								</span>
								<span class="t">~</span>
								<span class="i">
									<input name="endDt" title="검색기간 종료 날짜 예) 2015-12-11" class="input_txt edate" id="endDt" type="text" value="${paramVO.endDt}">
								</span>
							</dd>
						</dl>
						<dl>
							<dt>구분</dt>
							<dd class="w50p">
								<select name="prgSe" id="prgSe" title="구분 선택">
									<option value="">구분 선택</option>
									<c:forEach var="code" items="${COM050CodeList}" varStatus="status">
										<option value="${code.code}" <c:if test="${paramVO.prgSe eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
									 </c:forEach>
								</select>
								<select name="prgCl" id="prgCl" title="분류 선택">
									<option value="">분류 선택</option>
								</select>
							</dd>
						</dl>
					</c:when>
					<c:when test="${paramVO.rangeView eq 'bbs' or paramVO.rangeView eq 'files'}">
						<dl>
							<dt>구분</dt>
							<dd style="width:280px">
								<input name="s" id="s1" type="radio" value="" <c:if test="${empty paramVO.s}">checked="checked"</c:if>>
								<label for="s1">정확도순</label>
								<input name="s" id="s2" type="radio" value="frstRegistPnttm" <c:if test="${paramVO.s eq 'frstRegistPnttm'}">checked="checked"</c:if>>
								<label for="s2">최신순</label>
							</dd>
							<dt style="width:80px;">기간</dt>
							<dd style="width:420px;" class="tar">
								<span class="i">
									<input name="sdate" title="검색기간 시작 날짜 예) 2015-01-11" class="input_txt sdate" id="sdate" type="text" value="${paramVO.sdate}">
								</span>
								<span class="t">~</span>
								<span class="i">
									<input name="edate" title="검색기간 종료 날짜 예) 2015-12-11" class="input_txt edate" id="edate" type="text" value="${paramVO.edate}">
								</span>
							</dd>
						</dl>
					</c:when>
				</c:choose>

				<div class="btn_set tar mt5">
					<a href="javascript:checkDetailForm();" id="detailBtn" class="btn btn-sm btn-black">상세검색</a>
				</div>
			</div>
		</div>
	</form>

	<ul class="bull" id="detailHtml"></ul>
</c:if>
