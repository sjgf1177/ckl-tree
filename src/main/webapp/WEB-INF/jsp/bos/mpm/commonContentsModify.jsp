<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<ccc:constantsMap className="egovframework.com.cmm.service.Globals" var="Globals"/>
<c:set var="siteStr" value="/${siteInfo.siteName}/cts/preview.do?" />

<!DOCTYPE html>
<html lang="ko">
<head>
<title>콘텐츠관리</title>

<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />
<meta name="keywords" content="<spring:message code='site.korName' text=''/>" />
<meta name="description" content="<spring:message code='site.korName' text=''/>" />
<meta name="author" content="<spring:message code='site.korName' text=''/>" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<!-- <script type="text/javascript" src="/ckeditor/ckeditor.js"></script> -->
<script type="text/javascript">
function contentsSelect(pcode,uid, subject){

	var  url = "";
	if ('${zvl.searchType}'=='c1'){
		url = "/global/cts/view.do";
		url +="?pcode="+pcode;
		url +="&uId="+uid;

   		 }else if ('${zvl.searchType}'=='c2'){
			url = "/global/cts/list.do";
			url +="?pcode="+pcode;
		}

	openercument.getElementById("gcon_pcode").value=pcode;
	openercument.getElementById("gcon_uid").value=uid;
	openercument.getElementById("gcon_subject").value=subject;
	openercument.getElementById("menuLink").value=url;
	self.close();
}

function fnModify(frm){
	//if (CKEDITOR.instances.cvCon.getData() == '') {
	if (CrossEditor.GetBodyValue() == "") {
		alert('내용을 입력해 주세요.');
	    //CKEDITOR.instances.cvCon.focus();
	    CrossEditor.SetFocusEditor(); // 크로스에디터 Focus 이동
	    return;
	}

	if (frm.useYn.value=='Y'){
		if(confirm('사용여부를 Yes로 선택할 경우 사이트에 바로 적용됩니다. 그래도 진행하시겠습니까?')==false){
			return;
		}
	} else {
		if(confirm('새로운 버전으로 등록하시겠습니까?')==false){
			return;
		}
	}

	var cont = CrossEditor.GetBodyValue("XHTML");
	//cont = cont.replace(/script/gi, "#script#");
	document.getElementById("cvCon").value= cont;

	frm.submit();

}

function fnDelete(obj){
	if(confirm('삭제하시겠습니까?')==false){
		return false;
	}
}

function fnPreView(obj) {
	var FormObj = document.modifyForm;
	var PopWindow = "pop_win";
	var win = window.open("",PopWindow,"resizable=1,scrollbars=1,width=900,height=600");
	FormObj.target = PopWindow ; // 팝업윈도우 객체

	if('${Globals.OS_TYPE }' == 'UNIX'){
			FormObj.action = "http://www.jungnang.seoul.kr/${siteMng.siteName}/cts/preview.do"; // target JSP명
	}else{
			FormObj.action ="/${siteMng.siteName}/cts/preview.do"; // target JSP명
	}

	FormObj.submit();
}
</script>
</head>
<form name="modifyForm" enctype="multipart/form-data" action="/bos/mpm/commonContents/modifyProc.do" method="post">
<div id="content">
	<div class="hgroup">
		<h3 >컨텐츠 관리</h3>
	</div>

	<div class="bdView">
	<table>
		<caption>게시판 쓰기</caption>
		<colgroup>
			<col width="15%"/>
			<col width="85%"/>
		</colgroup>
		<tbody>
		  <tr>
		    <th scope="row">버전 번호</th>
		    <td>Ver.${result.cvNo}
		    <input type="hidden" name="menuNo" id="menuNo" value="${zvl.sMenuNo}"/>
		    <input type="hidden" name="sMenuNo" id="sMenuNo" value="${zvl.sMenuNo}"/>
		    <input type="hidden" name="siteId" id="siteId" value="${zvl.siteId}"/>
		    <input type="hidden" name="pageSize" id="pageSize" value="${zvl.pageSize}"/>
		    <input type="hidden" name="sUseYn" id="sUseYn" value="${zvl.sUseYn}"/>
		    </td>
		  </tr>
		  <tr>
		    <th scope="row">콘텐츠 명</th>
		    <td>${result.ph}</td>
		  </tr>
		  <tr>
		    <th scope="row">최종수정일(수정자)</th>
		    <td>${result.modiDate} <c:if test="${not empty result.regId}">(${empty result.modiId ? result.regId : result.modiId})</c:if></td>
		  </tr>
		  <tr>
		    <th scope="row">콘텐츠<img src="/bos/images/common/required.gif" alt="필수"  width="15" height="15"></th>
		    <td>
		    	<textarea id="cvCon" name="cvCon" cols="150" rows="50" style="display:none">${result.cvCon}</textarea>
				<script type="text/javascript">
				//<![CDATA[
					var CrossEditor = new NamoSE("crosseditor");
					CrossEditor.params.Font = {"Nanum Gothic":"나눔고딕", "Dotum":"돋움", "Gulim":"굴림", "Batang":"바탕", "Gungsuh":"궁서"};
					CrossEditor.EditorStart();

					var contentValue = document.getElementById("cvCon").value; // Hidden 값 참조
					function OnInitCompleted(){
						//contentValue = contentValue.replace(/#script#/gi, "script");
						CrossEditor.SetBodyValue(contentValue); // 컨텐츠 내용 에디터 삽입
					}
				//]]>
				</script>
		    </td>
		  </tr>
		  <tr>
		    <th scope="row">사용여부<img src="/bos/images/common/required.gif" alt="필수"  width="15" height="15"></th>
		    <td>
		    	<input type="hidden" name="oldUseYn" id="oldUseYn" value="${result.useYn}"/>
				<select name="useYn">
					<option value="Y" ${result.useYn eq 'Y' ? 'selected="selected"' : ''}>Yes</option>
					<option value="N" ${result.useYn eq 'N' ? 'selected="selected"' : ''}>No</option>
				</select>
		    </td>
		  </tr>
		 </tbody>
	</table>
	</div>
	<div class="btn_set">
		<a class="btn ${empty result ? 'btn-primary' : ' '}" href="javascript:fnModify(document.modifyForm);"><span>${empty result ? '등록' : '새로운 버전으로 수정'}</span></a>
		<a class="btn btn-danger" href="/bos/mpm/commonContents/delete.do?${zvl.paramUrl}&siteId=${zvl.siteId}&sUseYn=${zvl.sUseYn}&useYn=${result.useYn}&sMenuNo=${result.menuNo}&sCvNo=${result.cvNo}" onclick="return confirm('정말로 삭제하시겠습니까?')"><span>삭제</span></a>
		<a class="btn btn-primary" href="javascript:fnPreView();"><span>미리보기</span></a>
	</div>


	<!-- <div class="btn_set">
		<ul>
			<li><a href="javascript:fnModify(document.modifyForm);" class="white" style="width:200px"><span>${empty result ? '등록' : '새로운 버전으로 수정'}</span></a></li>
			<li><a href="delete?${zvl.paramUrl}&siteId=${zvl.siteId}&sUseYn=${zvl.sUseYn}&useYn=${result.useYn}&sMenuNo=${result.menuNo}&sCvNo=${result.cvNo}" onclick="return confirm('정말로 삭제하시겠습니까?')" class="white wd60"><span>삭제</span></a></li>
			<li><a href="javascript:fnPreView();" class="wd100"><span>미리보기</span></a></li>
		</ul>
	</div>
 --></div>

<div id="content">
	<div class="hgroup">
		<h3 >콘텐츠 History</h3>
	</div>
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="10%" />
				<col width="15%" />
				<col width="*" />
				<col width="15%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="fir">번호</th>
					<th scope="col">버전번호</th>
					<th scope="col">매뉴 명</th>
					<th scope="col">사용여부</th>
					<th scope="col">수정일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result2" items="${list}" varStatus="status">
				<tr>
					<td>${zvl.resultCnt-((zvl.pageIndex-1)*zvl.pageSize)-status.index}</td>
					<td>Ver.${result2.cvNo}</td>
					<td><c:if test="${result.cvNo eq result2.cvNo}"><strong></c:if><a href="${zvl.siteId}.do?${zvl.paramUrl}&sUseYn=${zvl.sUseYn}&sMenuNo=${result2.menuNo}&sCvNo=${result2.cvNo}">${result2.ph}</a><c:if test="${result.cvNo eq result2.cvNo}"></strong></c:if></td>
					<td>${result2.useYn eq 'Y' ? '<font color="ff6600"><b>사용</b></font>' : '미사용'}</td>
					<td>${result2.modiDate}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="paging">
		<div class="paging_con">
			${zvl.pageNavi}
		</div>
	</div><!-- paging end //-->
</div>
</form>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>
