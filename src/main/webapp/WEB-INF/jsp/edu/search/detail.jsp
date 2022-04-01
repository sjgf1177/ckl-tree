<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript">

	var rangeView = "<c:out value='${paramVO.rangeView}'/>";
	var codeIdVal = "<c:out value='${codeId0}'/>";
	var prgSeVal = "<c:out value='${param.prgSe}'/>";
	var prgClVal = "<c:out value='${param.prgCl}'/>";

	$(function() {

		// 프로그램 분류
		if (prgSeVal != "") getCodeList("prgCl", codeIdVal, $("#prgSe").val(), 2, prgClVal);

		$("select[name=prgSe]").change(function(){
			var val = $(this).val();
			getCodeList("prgCl", codeIdVal, val, 2);
		});


		// 교육/강좌 분류
		$("select[name=gubun]").change(function(){
			var val = $(this).val();
			getOnlineEduCodeList(val, "category"+$(':radio[name="gubunSe"]:checked').val());
		});

		if ($(':radio[name="gubunSe"]:checked').val() == '01') {
			$("#gubunSeDl01").show();
			$("#gubunSeDl02").hide();
			
		}
		else if ($(':radio[name="gubunSe"]:checked').val() == '02') {
			$("#gubunSeDl02").show();
			$("#gubunSeDl01").hide();
		}
		else {
			$("#gubunSeDl01").hide();
			$("#gubunSeDl02").hide();
		}

		$("input[name=gubunSe]").click(function(){
			var val = $(this).val();
			if (val == "01") {
				$("#gubunSeDl01").show();
				$("#gubunSeDl02").hide();
				$("#category02").val('');
			}
			else {
				$("#gubunSeDl02").show();
				$("#gubunSeDl01").hide();
				$("#gubun").val('');
				$("#category01").val('');
			}
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

	// 교육/강좌 분류 목록
	function getOnlineEduCodeList(gubun, elemntId) {
		var gubunSe = $(':radio[name="gubunSe"]:checked').val();
		var categoryVal = "<c:out value='${param.category01}'/>";
		if (gubunSe == "02") categoryVal = "<c:out value='${param.category02}'/>";

		var $obj = $("#"+elemntId);
		var url = "/edu/onlineEdu/occp/occpTabList.json";
		if (gubun == "realm") url = "/edu/onlineEdu/realm/realmTabList.json";

		var params = {grcode : 'N000001'};
		$.get(url, params, function(data) {
			if (data) {
				$obj.empty();
				$("<option>").text("선택").attr("value","").appendTo($obj);
				$.each(data.tabList, function(key,item) {
					if (item.code != "A") {
						var $codeItem = $("<option>").attr("value", item.code).text(item.codenm);
						if (categoryVal == item.code) $codeItem.attr("selected",true);
						$codeItem.appendTo($obj);
					}
				});
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
		$.post("/edu/search/list.json", data, function(data) {
			var html = "";
			var cnt = data.resultList.length;
			var pageNav = data.pageNav;

			if (cnt > 0) {
				$.each(data.resultList, function(i, item) {
					if (rangeView == "progrm") {
						html += getProgrmHtml(item.fullMenuLink, item.progrsSttus, item.prgSeNm, item.prgClNm, item.prgNm, item.reqstMthdNm, item.psncpa, item.beginDt, item.endDt, item.hl);
					}
					else if (rangeView == "onlineEdu") {
						html += getOnlineEduHtml(item.fullMenuLink, item.gubunSe, item.gubun, item.categoryNm, item.title, item.hl);
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
			if (rangeView == "onlineEdu") rangeNm = "교육/강좌 (검색결과 "+cnt+"건)";
			if (rangeView == "bbs") rangeNm = "게시물 (검색결과 "+cnt+"건)";
			if (rangeView == "file") rangeNm = "첨부파일 (검색결과 "+cnt+"건)";

			$("#searchCnt").html(cnt);
			$(".searchCntTxt").html(rangeNm);
			$(".paging").html(pageNav);
			$("#detailHtml").html(html);
		});
	}

	function getOnlineEduHtml(fullMenuLink, gubunSe, gubun, categoryNm, title, hl) {
		var gubunSeVal = '온라인교육';
		var categoryNmVal = "";

		if (gubunSe == "02") gubunSeVal = "열린강좌";
		if (gubunSe == '01') {
			if (gubun == "realm") {
				categoryNmVal = "[분야별 - "+categoryNm+"]";
			}
			else {
				categoryNmVal = "[직업별 - "+categoryNm+"]";
			}
		}
		else {
			categoryNmVal = "["+categoryNm+"]";
		}

		html =
			'<li class="statSet">'+
				'<a href="'+fullMenuLink+'" target="_blank" title="새창열림">'+
					'<span class="tit"><span class="status">'+gubunSeVal+'</span><span class="fcBlue">'+categoryNmVal+'</span> '+title+'</span>'+
					'<span class="txt">'+hl+'</span>'+
				'</a>'+
			'</li>';

		return html;
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
					'<span class="tit"><span class="status">'+progrsSttusVal+'</span><span class="fcBlue">['+prgSeNm+'-'+prgClNm+']</span> '+prgNm+'</span>'+
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
				'<a href="/edu/bbs/'+bbsId+'/view.do?nttId='+nttId+'&amp;menuNo='+menuNo+'" target="_blank" title="새창열림">'+
					'<span class="tit"><span class="fcBlue uline">'+relateMenuNmListVal+'</span> '+nttSj+' <span class="date">'+regDate+'</span></span>'+
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
				'<a href="/edu/cmm/fms/FileDown.do?atchFileId='+atchFileId+'&amp;fileSn='+fileSn+'" class="'+fileType+'">'+
					'<span class="tit">'+orignlFileNm+' <span class="date">'+regDate+'</span></span>'+
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
					<c:when test="${paramVO.rangeView eq 'onlineEdu'}">
						<dl>
							<dt>구분</dt>
							<dd>
								<input name="gubunSe" id="gubunSe01" type="radio" value="01">
								<label for="gubunSe01">정규과정</label>
								<input name="gubunSe" id="gubunSe02" type="radio" value="02">
								<label for="gubunSe02">열린강좌</label>
								<input name="gubunSe" id="gubunSe03" type="radio" value="03">
								<label for="gubunSe03">테마과정</label>
							</dd>
							<dt style="width:80px;">기간</dt>
							<dd style="width:430px;" class="tar">
								<span class="i">
									<input name="sdate" title="검색기간 시작 날짜 예) 2015-01-11" class="input_txt sdate" id="sdate" type="text" value="${paramVO.sdate}">
								</span>
								<span class="t">~</span>
								<span class="i">
									<input name="edate" title="검색기간 종료 날짜 예) 2015-12-11" class="input_txt edate" id="edate" type="text" value="${paramVO.edate}">
								</span>
							</dd>
						</dl>
						<dl id="gubunSeDl01">
							<dt>분류</dt>
							<dd style="width:500px">
								<select name="gubun" id="gubun" title="분류를 선택해 주세요.">
									<option value="">분류 선택</option>
									<option value="realm" <c:if test="${paramVO.gubun eq 'realm'}">selected="selected"</c:if>>분야별 교육</option>
									<option value="occp" <c:if test="${paramVO.gubun eq 'occp'}">selected="selected"</c:if>>직업별 교육</option>
								</select>
								<select name="category01" id="category01" title="분류를 선택해 주세요.">
									<option value="">선택</option>
								</select>
							</dd>
						</dl>
						<dl id="gubunSeDl02">
							<dt>분류별</dt>
							<dd style="width:380px">
								<select name="category02" id="category02" title="분류를 선택해 주세요.">
									<option value="">분류 선택</option>
									<option value="GC01" <c:if test="${paramVO.category eq 'GC01'}">selected="selected"</c:if>>방송영상</option>
									<option value="GC02" <c:if test="${paramVO.category eq 'GC02'}">selected="selected"</c:if>>게임</option>
									<option value="GC03" <c:if test="${paramVO.category eq 'GC03'}">selected="selected"</c:if>>만화/애니/캐릭터</option>
									<option value="GC04" <c:if test="${paramVO.category eq 'GC04'}">selected="selected"</c:if>>문화일반</option>
									<option value="GC05" <c:if test="${paramVO.category eq 'GC05'}">selected="selected"</c:if>>인문/경영/교양</option>
									<%-- <option value="GC06" <c:if test="${paramVO.category eq 'GC06'}">selected="selected"</c:if>>콘텐츠 인사이드</option>
									<option value="GC07" <c:if test="${paramVO.category eq 'GC07'}">selected="selected"</c:if>>미스터 클래스</option>
									<option value="GC08" <c:if test="${paramVO.category eq 'GC08'}">selected="selected"</c:if>>휴넷열린강좌</option> --%>
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
							<dd style="width:430px;" class="tar">
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
					<a href="javascript:checkDetailForm();" id="detailBtn" class="btn btn-sm btn-black icoZoom">상세검색</a>
				</div>
			</div>
		</div>
	</form>

	<ul class="bull" id="detailHtml"></ul>
</c:if>
