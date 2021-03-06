<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<script type="text/javascript">

var idx = "${fn:length(listTmplatAddInfo)}";

	$(function(){
		$("#idxs").val(idx);

		$("#codeNm").hide();
		$("#codeA").hide();

		$("select[name=attrb]").change(function(){
			var vals=$(this).val();
			var val=vals.split('_')[0];
			if (val=="06" || val=="07" || val=="08" || val=="09") {
				$("#codeNm").show();
				$("#codeA").show();
			}
			else {
				$("#codeNm").hide();
				$("#codeA").hide();
			}
		});

		$("#nmUseAt").click(function(){
			if ($(":input[name=nmUseAt]:checkbox:checked").length == 0) {
				$("#nmEssntlAt").attr("checked", false);
				$("#nmSortOrdr").val("");
			}
		});
		$("#brthdyUseAt").click(function(){
			if ($(":input[name=brthdyUseAt]:checkbox:checked").length == 0) {
				$("#brthdyEssntlAt").attr("checked", false);
				$("#brthdySortOrdr").val("");
			}
		});
		$("#sexUseAt").click(function(){
			if ($(":input[name=sexUseAt]:checkbox:checked").length == 0) {
				$("#sexEssntlAt").attr("checked", false);
				$("#sexSortOrdr").val("");
			}
		});
		$("#emailUseAt").click(function(){
			if ($(":input[name=emailUseAt]:checkbox:checked").length == 0) {
				$("#emailEssntlAt").attr("checked", false);
				$("#emailSortOrdr").val("");
			}
		});
		$("#addEmailUseAt").click(function(){
			if ($(":input[name=addEmailUseAt]:checkbox:checked").length == 0) {
				$("#addEmailEssntlAt").attr("checked", false);
				$("#addEmailSortOrdr").val("");
			}
		});
		$("#ownhomTelnoUseAt").click(function(){
			if ($(":input[name=ownhomTelnoUseAt]:checkbox:checked").length == 0) {
				$("#ownhomTelnoEssntlAt").attr("checked", false);
				$("#ownhomTelnoSortOrdr").val("");
			}
		});
		$("#mbtlnumUseAt").click(function(){
			if ($(":input[name=mbtlnumUseAt]:checkbox:checked").length == 0) {
				$("#mbtlnumEssntlAt").attr("checked", false);
				$("#mbtlnumSortOrdr").val("");
			}
		});
		$("#cmpnyTelnoUseAt").click(function(){
			if ($(":input[name=cmpnyTelnoUseAt]:checkbox:checked").length == 0) {
				$("#cmpnyTelnoEssntlAt").attr("checked", false);
				$("#cmpnyTelnoSortOrdr").val("");
			}
		});
		$("#telnoUseAt").click(function(){
			if ($(":input[name=telnoUseAt]:checkbox:checked").length == 0) {
				$("#telnoEssntlAt").attr("checked", false);
				$("#telnoSortOrdr").val("");
			}
		});
		$("#adresUseAt").click(function(){
			if ($(":input[name=adresUseAt]:checkbox:checked").length == 0) {
				$("#adresEssntlAt").attr("checked", false);
				$("#adresSortOrdr").val("");
			}
		});
		$("#resdncUseAt").click(function(){
			if ($(":input[name=resdncUseAt]:checkbox:checked").length == 0) {
				$("#resdncEssntlAt").attr("checked", false);
				$("#resdncSortOrdr").val("");
			}
		});
		$("#jobUseAt").click(function(){
			if ($(":input[name=jobUseAt]:checkbox:checked").length == 0) {
				$("#jobEssntlAt").attr("checked", false);
				$("#jobSortOrdr").val("");
			}
		});
		$("#psitnUseAt").click(function(){
			if ($(":input[name=psitnUseAt]:checkbox:checked").length == 0) {
				$("#psitnEssntlAt").attr("checked", false);
				$("#psitnSortOrdr").val("");
			}
		});

	});

	function checkForm() {
		var form = document.frm;
		var v = new MiyaValidator(form);


		v.add("nmUseAt", {
			required : true,
			message : "????????? ????????? ????????????????????????."
		});

		if ($('input[name="nmUseAt"]:checked').val() == 'Y') {
			v.add("nmSortOrdr", {
				required : true
			});
		}
		if ($('input[name="brthdyUseAt"]:checked').val() == 'Y') {
			v.add("brthdySortOrdr", {
				required : true
			});
		}
		if ($('input[name="sexUseAt"]:checked').val() == 'Y') {
			v.add("sexSortOrdr", {
				required : true
			});
		}
		if ($('input[name="emailUseAt"]:checked').val() == 'Y') {
			v.add("emailSortOrdr", {
				required : true
			});
		}
		if ($('input[name="addEmailUseAt"]:checked').val() == 'Y') {
			v.add("addEmailSortOrdr", {
				required : true
			});
		}
		if ($('input[name="ownhomTelnoUseAt"]:checked').val() == 'Y') {
			v.add("ownhomTelnoSortOrdr", {
				required : true
			});
		}
		if ($('input[name="mbtlnumUseAt"]:checked').val() == 'Y') {
			v.add("mbtlnumSortOrdr", {
				required : true
			});
		}
		if ($('input[name="cmpnyTelnoUseAt"]:checked').val() == 'Y') {
			v.add("cmpnyTelnoSortOrdr", {
				required : true
			});
		}
		if ($('input[name="telnoUseAt"]:checked').val() == 'Y') {
			v.add("telnoSortOrdr", {
				required : true
			});
		}
		if ($('input[name="adresUseAt"]:checked').val() == 'Y') {
			v.add("adresSortOrdr", {
				required : true
			});
		}
		if ($('input[name="resdncUseAt"]:checked').val() == 'Y') {
			v.add("resdncSortOrdr", {
				required : true
			});
		}
		if ($('input[name="jobUseAt"]:checked').val() == 'Y') {
			v.add("jobSortOrdr", {
				required : true
			});
		}
		if ($('input[name="psitnUseAt"]:checked').val() == 'Y') {
			v.add("psitnSortOrdr", {
				required : true
			});
		}

		if (!checkField("iemNm")) {
			alert("???????????? ???????????????.");
			return;
		}
		if (!checkField("sortOrdr")) {
			alert("??????????????? ???????????????.");
			return;
		}

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (confirm("${empty result ? '??????' : '??????'}???????????????????")) {
			form.submit();
		}

	}

	function checkField(name) {
		var condition = true;
		$(":input[name^=" + name + "]").each(function(i, ele) {
			if (!this.value) {
				condition = false;
				return;
			}
		});
		return condition;
	}

    function check_txt(value) {
	    if (isNaN(value)) {
	  	  alert("????????? ?????????????????????.");
	    return "";
		}
	    else {
	    	return value;
	    }
	}

	//?????????????????? ?????? ??????
	function addField() {
		var attrbs = $("#attrb").val();
		var attrb = attrbs.split('_');
		var iemCodeId = $("#codeId").val();
		if (attrbs == "") {
			alert("???????????? ????????? ????????? ?????????.");
			$("#attrb").focus();
			return;
		}
		if (attrb[0]=="06" || attrb[0]=="07" || attrb[0]=="08" || attrb[0]=="09") {
			if ($("#codeNm").val() == "") {
				alert("??????????????? ????????? ?????????.");
				$("#codeA").focus();
				return;
			}
		}
		else {
			codeIds = "";
		}
		idx++;
		$("#idxs").val(idx);
		$.post( "/bos/progrm/master/tmplatAddinfo.do?mode=i&viewType=CONTBODY&attrb="+attrb[0]+"&iemCodeId="+iemCodeId, function(data) {
			var html = data.replace(/{idx}/gi, idx);
			html = html.replace(/{iemNm}/gi, '');
			html = html.replace(/{essntlAt}/gi, '');
			html = html.replace(/{sortOrdr}/gi, '');
			html = html.replace(/{attrb}/gi, attrb[0]);
			html = html.replace(/{attrbNm}/gi, attrb[1]);
			html = html.replace(/{iemCodeId}/gi, iemCodeId);
			$("#addFieldTr").append(html);
		});
	}

	//?????????????????? ?????? ??????
	function delField(obj, addinfoSn, idxs, type) {
		// type = Y ???????????? ???????????? ????????????
		if (type == "Y") {
			if (confirm("?????????????????????????")) {
				$.getJSON("/bos/progrm/master/deleteTmplatAddInfo.json", {
					addinfoSn : addinfoSn
				}, function(data) {
					var jdata = data.resultCode;
					if (jdata == 'success') {
						alert("??????????????? ?????????????????????.");
						/* idx--;
						$(".trT"+idxs).remove();
						$("#idxs").val(idx); */
						location.reload();
					}
					else {
						alert("????????? ?????????????????????.");
					}
				});
			}
		}
		else {
			//$(obj).parents('tr').remove();
			$(".trT"+idxs).remove();
		}
	}

	//?????? ?????? ??????
	function codeListPopup() {
		window.open("/bos/progrm/master/codeListPopup.do?viewType=BODY", "tmplatPopup", "width=990px, height=700px, scrollbars=no");
	}

	//???????????? ??????
	function fnPopup() {
		window.open("/bos/progrm/master/tmplatPopup.do?viewType=BODY", "tmplatPopup", "width=1030px, height=800px, scrollbars=yes");
	}

	//???????????? ??????
	function fnPrevewPopup() {
		var params = $("#frm").serialize();
		//var params = encodeURIComponent($("#frm").serialize());
		window.open("/bos/progrm/master/prevewTmplatPopup.do?viewType=BODY&"+params, "prevewTmplatPopup", "width=1030px, height=800px, scrollbars=yes");
	}

</script>

<form name="frm" id="frm" method="post" action="/bos/progrm/master/${empty result ? 'insertTmplat' : 'updateTmplat'}.do" enctype="multipart/form-data">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}">
	<input type="hidden" name="idxs" id="idxs" >
	<input type="hidden" name="atchFileId" id="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="prgSn" value="${empty result ? param.prgSn : result.prgSn}" >

	<h4>????????????</h4>
	<div class="bdList">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
				<col width="8%" />
				<col width="30%" />
				<col width="*" />
				<col width="8%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt_ct vt_md"><input type="checkbox" name="nmUseAt" id="nmUseAt" value="Y" title="??????1" <c:if test="${result.nmUseAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td class="vt_md">??????</td>
					<td class="vt_md">????????? ?????? 10???</td>
					<td class="txt_ct vt_md"><input type="checkbox" name="nmEssntlAt" id="nmEssntlAt" value="Y" title="??????1" <c:if test="${result.nmEssntlAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td><input type="text" class="txt_ct" name="nmSortOrdr" id="nmSortOrdr" value="${result.nmSortOrdr}" maxlength="2" onkeyup="this.value=check_txt(this.value)" title="????????????" /></td>
				</tr>
				<tr>
					<td class="txt_ct vt_md"><input type="checkbox" name="brthdyUseAt" id="brthdyUseAt" value="Y" title="??????1" <c:if test="${result.brthdyUseAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td class="vt_md">????????????</td>
					<td class="vt_md">??????</td>
					<td class="txt_ct vt_md"><input type="checkbox" name="brthdyEssntlAt" id="brthdyEssntlAt" value="Y" title="??????1" <c:if test="${result.brthdyEssntlAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td><input type="text" class="txt_ct" name="brthdySortOrdr" id="brthdySortOrdr" value="${result.brthdySortOrdr}" maxlength="2" onkeyup="this.value=check_txt(this.value)" title="????????????" /></td>
				</tr>
				<tr>
					<td class="txt_ct vt_md"><input type="checkbox" name="sexUseAt" id="sexUseAt" value="Y" title="??????1" <c:if test="${result.sexUseAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td class="vt_md">??????</td>
					<td class="vt_md">????????????</td>
					<td class="txt_ct vt_md"><input type="checkbox" name="sexEssntlAt" id="sexEssntlAt" value="Y" title="??????1" <c:if test="${result.sexEssntlAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td><input type="text" class="txt_ct" name="sexSortOrdr" id="sexSortOrdr" value="${result.sexSortOrdr}" maxlength="2" onkeyup="this.value=check_txt(this.value)" title="????????????" /></td>
				</tr>
				<tr>
					<td class="txt_ct vt_md"><input type="checkbox" name="emailUseAt" id="emailUseAt" value="Y" title="??????1" <c:if test="${result.emailUseAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td class="vt_md">?????????</td>
					<td class="vt_md">?????????</td>
					<td class="txt_ct vt_md"><input type="checkbox" name="emailEssntlAt" id="emailEssntlAt" value="Y" title="??????1" <c:if test="${result.emailEssntlAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td><input type="text" class="txt_ct" name="emailSortOrdr" id="emailSortOrdr" value="${result.emailSortOrdr}" maxlength="2" onkeyup="this.value=check_txt(this.value)" title="????????????" /></td>
				</tr>
				<tr>
					<td class="txt_ct vt_md"><input type="checkbox" name="addEmailUseAt" id="addEmailUseAt" value="Y" title="??????1" <c:if test="${result.addEmailUseAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td class="vt_md">?????? ?????????</td>
					<td class="vt_md">?????????</td>
					<td class="txt_ct vt_md"><input type="checkbox" name="addEmailEssntlAt" id="addEmailEssntlAt" value="Y" title="??????1" <c:if test="${result.addEmailEssntlAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td><input type="text" class="txt_ct" name="addEmailSortOrdr" id="addEmailSortOrdr" value="${result.addEmailSortOrdr}" maxlength="2" onkeyup="this.value=check_txt(this.value)" title="????????????" /></td>
				</tr>
				<tr>
					<td class="txt_ct vt_md"><input type="checkbox" name="ownhomTelnoUseAt" id="ownhomTelnoUseAt" value="Y" title="??????1" <c:if test="${result.ownhomTelnoUseAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td class="vt_md">??????</td>
					<td class="vt_md">????????????(??????)</td>
					<td class="txt_ct vt_md"><input type="checkbox" name="ownhomTelnoEssntlAt" id="ownhomTelnoEssntlAt" value="Y" title="??????1" <c:if test="${result.ownhomTelnoEssntlAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td><input type="text" class="txt_ct" name="ownhomTelnoSortOrdr" id="ownhomTelnoSortOrdr" value="${result.ownhomTelnoSortOrdr}" maxlength="2" onkeyup="this.value=check_txt(this.value)" title="????????????" /></td>
				</tr>
				<tr>
					<td class="txt_ct vt_md"><input type="checkbox" name="mbtlnumUseAt" id="mbtlnumUseAt" value="Y" title="??????1" <c:if test="${result.mbtlnumUseAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td class="vt_md">?????????</td>
					<td class="vt_md">????????????(?????????)</td>
					<td class="txt_ct vt_md"><input type="checkbox" name="mbtlnumEssntlAt" id="mbtlnumEssntlAt" value="Y" title="??????1" <c:if test="${result.mbtlnumEssntlAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td><input type="text" class="txt_ct" name="mbtlnumSortOrdr" id="mbtlnumSortOrdr" value="${result.mbtlnumSortOrdr}" maxlength="2" onkeyup="this.value=check_txt(this.value)" title="????????????" /></td>
				</tr>
				<tr>
					<td class="txt_ct vt_md"><input type="checkbox" name="cmpnyTelnoUseAt" id="cmpnyTelnoUseAt" value="Y" title="??????1" <c:if test="${result.cmpnyTelnoUseAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td class="vt_md">????????????</td>
					<td class="vt_md">????????????(??????)</td>
					<td class="txt_ct vt_md"><input type="checkbox" name="cmpnyTelnoEssntlAt" id="cmpnyTelnoEssntlAt" value="Y" title="??????1" <c:if test="${result.cmpnyTelnoEssntlAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td><input type="text" class="txt_ct" name="cmpnyTelnoSortOrdr" id="cmpnyTelnoSortOrdr" value="${result.cmpnyTelnoSortOrdr}" maxlength="2" onkeyup="this.value=check_txt(this.value)" title="????????????" /></td>
				</tr>
				<tr>
					<td class="txt_ct vt_md"><input type="checkbox" name="telnoUseAt" id="telnoUseAt" value="Y" title="??????1" <c:if test="${result.telnoUseAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td class="vt_md">????????????</td>
					<td class="vt_md">????????????(??????)</td>
					<td class="txt_ct vt_md"><input type="checkbox" name="telnoEssntlAt" id="telnoEssntlAt" value="Y" title="??????1" <c:if test="${result.telnoEssntlAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td><input type="text" class="txt_ct" name="telnoSortOrdr" id="telnoSortOrdr" value="${result.telnoSortOrdr}" maxlength="2" onkeyup="this.value=check_txt(this.value)" title="????????????" /></td>
				</tr>
				<tr>
					<td class="txt_ct vt_md"><input type="checkbox" name="adresUseAt" id="adresUseAt" value="Y" title="??????1" <c:if test="${result.adresUseAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td class="vt_md">??????</td>
					<td class="vt_md">????????? ?????? 30???</td>
					<td class="txt_ct vt_md"><input type="checkbox" name="adresEssntlAt" id="adresEssntlAt" value="Y" title="??????1" <c:if test="${result.adresEssntlAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td><input type="text" class="txt_ct" name="adresSortOrdr" id="adresSortOrdr" value="${result.adresSortOrdr}" maxlength="2" onkeyup="this.value=check_txt(this.value)" title="????????????" /></td>
				</tr>
				<tr>
					<td class="txt_ct vt_md"><input type="checkbox" name="resdncUseAt" id="resdncUseAt" value="Y" title="??????1" <c:if test="${result.resdncUseAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td class="vt_md">????????????</td>
					<td class="vt_md">????????? ??????</td>
					<td class="txt_ct vt_md"><input type="checkbox" name="resdncEssntlAt" id="resdncEssntlAt" value="Y" title="??????1" <c:if test="${result.resdncEssntlAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td><input type="text" class="txt_ct" name="resdncSortOrdr" id="resdncSortOrdr" value="${result.resdncSortOrdr}" maxlength="2" onkeyup="this.value=check_txt(this.value)" title="????????????" /></td>
				</tr>
				<tr>
					<td class="txt_ct vt_md"><input type="checkbox" name="jobUseAt" id="jobUseAt" value="Y" title="??????1" <c:if test="${result.jobUseAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td class="vt_md">??????</td>
					<td class="vt_md">????????????</td>
					<td class="txt_ct vt_md"><input type="checkbox" name="jobEssntlAt" id="jobEssntlAt" value="Y" title="??????1" <c:if test="${result.jobEssntlAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td><input type="text" class="txt_ct" name="jobSortOrdr" id="jobSortOrdr" value="${result.jobSortOrdr}" maxlength="2" onkeyup="this.value=check_txt(this.value)" title="????????????" /></td>
				</tr>
				<tr>
					<td class="txt_ct vt_md"><input type="checkbox" name="psitnUseAt" id="psitnUseAt" value="Y" title="??????1" <c:if test="${result.psitnUseAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td class="vt_md">??????</td>
					<td class="vt_md">????????? ?????? 10???</td>
					<td class="txt_ct vt_md"><input type="checkbox" name="psitnEssntlAt" id="psitnEssntlAt" value="Y" title="??????1" <c:if test="${result.psitnEssntlAt eq 'Y'}">checked="checked"</c:if> /></td>
					<td><input type="text" class="txt_ct" name="psitnSortOrdr" id="psitnSortOrdr" value="${result.psitnSortOrdr}" maxlength="2" onkeyup="this.value=check_txt(this.value)" title="????????????" /></td>
				</tr>
			</tbody>
		</table>
	</div>

	<h4>??????????????????</h4>
	<div class="tbrinfo clear">
		<a class="btn btn-primary" href="javascript:fnPopup();"><span>????????????</span></a>
	</div>
	<p class="fl">??? ???????????? ?????? ?????? ??????</p>

	<div class="mb20 fl clear w100p">
		<textarea name="gudanceWords" id="gudanceWords" cols="120" rows="5" class="col-md-12" onfocus="if(this.value=='????????? ???????????? ?????????.')this.value='';" onkeyup="if(this.value=='????????? ???????????? ?????????.')this.value='';" title="???????????? ????????? ?????? ??????" >${result.gudanceWords}</textarea>
	</div>

	<h3>
		<a class="btn btn-default btn-sm" href="#" onclick="addField();return false;" ><span>+ ??????</span></a>
		<select name="attrb" id="attrb" title="??????" style="font-size:12px">
			<option value="">?????? ??????</option>
			<c:forEach var="code" items="${COM057CodeList}" varStatus="status">
				<option value="${code.code}_${code.codeNm}" >${code.codeNm}</option>
			</c:forEach>
		</select>
		<input type="hidden" name="codeId" id="codeId" />
		<input type="text" name="codeNm" id="codeNm" value="" title="?????? ???????????? ???????????????." style="font-size:12px" readonly="readonly"/>
		<a class="btn btn-default btn-sm" href="javascript:codeListPopup();" id="codeA"><span>??????</span></a>
	</h3>

	<div class="bdList clear">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
				<col width="35%" />
				<col width="*" />
				<col width="4%" />
				<col width="4%" />
				<col width="4%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" style="vertical-align:middle;">?????????</th>
					<th scope="col" style="vertical-align:middle;">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th></th>
				</tr>
			</thead>
			<tbody id="addFieldTr" class="addFieldTr">
				<c:forEach var="item" items="${listTmplatAddInfo}" varStatus="status">
					<jsp:include page="/bos/progrm/master/tmplatAddinfo.do">
						<jsp:param name="viewType" value="CONTBODY" />
						<jsp:param name="idx" value="${status.count}" />
						<jsp:param name="addinfoSn" value="${item.addinfoSn}" />
						<jsp:param name="iemNm" value="${item.iemNm}" />
						<jsp:param name="attrb" value="${item.attrb}" />
						<jsp:param name="essntlAt" value="${item.essntlAt}" />
						<jsp:param name="sortOrdr" value="${item.sortOrdr}" />
						<jsp:param name="attrbNm" value="${item.attrbNm}" />
						<jsp:param name="iemCodeId" value="${item.iemCodeId}" />
					</jsp:include>
				</c:forEach>
			</tbody>
		</table>
	</div>

</form>

<div class="row clear mt20">
	<div class="fl">
		<a href="javascript:fnPrevewPopup();" class="btn btn-primary">????????????</a>
	</div>
	<div class="fr">
		<a href="javascript:checkForm();" class="btn btn-primary">${empty result ? '??????' : '??????'}</a>
		
		<c:choose>
			<c:when test="${param.prgCl eq 19}">
				<a href="/bos/progrm/applcnt/list.do?prgSn=<c:out value="${param.prgSn}"/>&${pageQueryString}" class="btn btn-primary">??????</a>
			</c:when>
			<c:otherwise>
				<a href="/bos/progrm/master/list.do?${pageQueryString}" class="btn btn-primary">??????</a>
			</c:otherwise>
		</c:choose>
		
	</div>
</div>
	
<div class="layer_box"">
    <div class="pup_box">
        <h5>
        	<p class="pup_title_txt"></p>
        	<span><button type="button" class="layer_close_btn">X</button></span>
        </h5>
        <div class="pup_container">
            <div class="left">
                <div class="bdList">
					<table class="table table-bordered table_head">
						<caption>
						</caption>
						<thead>
							<tr>
								<th scope="col" class="th1">??????</th>
								<th scope="col" class="th2">???????????????</th>
								<th scope="col" class="th3">????????????</th>
								<th scope="col" class="th4">????????????</th>
							</tr>
						</thead>
					</table>
  					<div class="tbody_box hover_table">
	  					<table class="table table-bordered layer_table">
							<caption>
							</caption>
							<colgroup>
								<col width="10%">
								<col width="*">
								<col width="13%">
								<col width="10%">		
							</colgroup>
							<tbody id="itemTr">
							</tbody>
						</table>
  					</div>
				</div>
				<div class="pup_btn_box">
                    <button type="button" class="btn btn-primary btn-add">???????????? ??????</button>
                    <input id="cdId" name="cdId" type="hidden">
                    <input id="p_code" name="p_code" type="hidden">
                    <input id="p_sort" name="p_sort" type="hidden">
				</div>
            </div>
            <div class="right">
	            <div class="bdView">
	                <table>
	                    <tbody>
		                    <tr>
		                        <th>???????????????(??????)</th>
		                        <td class="td1">
		                            <div><input id="cdNm" name="cdNm" type="text" class="col-md-12" placeholder="???????????????(??????)??? ???????????????."></div>
		                        </td>
		                    </tr>
		                    <tr>
		                        <th>????????????</th>
		                        <td class="td1">
		                            <div><input id="ordr" name="ordr" type="text" maxlength="2" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" class="col-md-12" placeholder="??????????????? ???????????????."></div>
		                        </td>
		                    </tr>
		                    <tr>
		                        <th>???????????????(??????)</th>
		                        <td class="td1">
		                            <div>
		                                <span>
		                                	<input type="radio" name="radUse" id="rady" value="Y">
		                                	<label for="rady">??????</label>
		                                </span>
		                                &nbsp;&nbsp;
		                            	<span>
		                            		<input type="radio" name="radUse" id="radn" value="N">
		                            		<label for="radn">?????????</label>
		                            	</span>
		                            </div>
		                        </td>
		                    </tr>
		                </tbody>
                	</table>
                </div>
                <div class="pup_btn_box">
                	<div class="btn_mode_ins">
                    	<button type="button" class="btn btn-primary btn-mode btn-Ins">??????</button>
                    </div>

                    <button type="button" class="btn btn-primary btn-mode btn-Upt btn_mode_upt" style="display:none;">??????</button>
                    <button type="button" class="btn btn-primary btn-mode btn-Del btn_mode_upt" style="display:none;">??????</button>         
      
                    <button type="button" class="btn btn-primary layer_close_btn">??????</button>
				</div>
           	</div>
        </div>
    </div>
</div>

<script>
    var txtArea = $(".iemTi");
    if (txtArea) {
        txtArea.each(function(){
            $(this).height(this.scrollHeight);
        });
    }
</script>

<style>
.addbtn {
    padding: 0px 10px;
    font-size: 12px;
    line-height: 1.5;
    border-radius: 3px;
	color: rgb(255, 255, 255); 
	margin-left: 5px; 
	vertical-align: top; 
	box-sizing: border-box; 
 }
</style>
