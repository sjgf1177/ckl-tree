<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%
org.springframework.context.ApplicationContext context = org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
egovframework.rte.fdl.property.EgovPropertyService propertiesService = (egovframework.rte.fdl.property.EgovPropertyService)context.getBean("propertiesService");
request.setAttribute("facebookAppKey", propertiesService.getString("Sns.facebookAppKey"));

%>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/bbs/${paramVO.bbsId}/insert.xml" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/bbs/${paramVO.bbsId}/update.xml" />
</c:if>

<sec:authorize ifAnyGranted="ROLE_SUPER">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>

<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<!-- <script type="text/javascript" src="https://connect.facebook.net/ko_KR/all.js"></script>
<script type="text/javascript" src="/js/sns/facebook.js"></script> -->
<script type="text/javascript">

$(function() {

	// 페이스북 초기화
	 $.sFacebook.initialize({
		appId : '<c:out value="${facebookAppKey}" />', // 페이스북 App Id 입력.
		me_photo_target : '#profile_photo',
		me_name_target : '#profile_name',
		me_id_target : '#fbSnsId',
		me_image_url : '#image',
		me_fb_login_target : '#fbLoginImg',
		me_sns_name : '#snsName'
	});

	// facebook 로그인
	$("#fbLoginBtn").click(function() {

		$.sFacebook.login();

		return false;
	});

	//글조회
	$("#searchSnsBtn").click(function(){

		// 페이스북로그인 여부
		var fbLoginTp = false;
		if ($("#fbSnsId").val() != "")  {
			fbLoginTp = true;
		}

		if (!fbLoginTp)  {

			// 페이스북 글조회
			if (fbLoginTp) {
				window.open('/facebookListPop.jsp', 'snsListPop', 'width=1000, height=600, scrollbars=yes');
				//jQuery.sFacebook.getPersonalFeed();
			}

		}
		else {
			alert("페이스북 계정 로그인 후 이용해 주시기 바랍니다.");

			$.sFacebook.login();

			return false;
		}
		return false;
	});


	$("#submitAct").click(function(){

		var options = {
			beforeSubmit: checkForm,
			success: responseCtl,
			url: "${action}",
			dataType: "xml"
		};
		$("#board").ajaxSubmit(options);

	});

});

	function responseCtl(data) {

		<c:if test="${empty result}">
			if ($("#option3").val() == "Y") {

				var url = "";
				var shortUrl = $("#cmmShortUrl").val();
				var fbLoginTp = false;
				if ($("#fbSnsId").val() != "") fbLoginTp = true;

				// 페이스북 등록
				if (fbLoginTp) {
					url = '${site.siteUrl}'+"/portal/bbs/${paramVO.bbsId}/view.do?nttId="+$(data).find("nttId").text()+"&menuNo=${paramVO.menuNo}";
					//if ('${user.crtfcSe}' == "F")
					jQuery.sFacebook.post_feed('#nttSj', '#nttSj', url, shortUrl);
				}
			}

		</c:if>
		location.href = "/bos/bbs/${paramVO.bbsId}/list.do?menuNo=${paramVO.menuNo}";
	}

	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);

	    v.add("option1", {
	        required: true
	    });

	    v.add("nttSj", {
	        required: true
	    });

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (CrossEditor.GetBodyValue() == "") {
			alert('내용을 입력해 주세요.');
		    CrossEditor.SetFocusEditor(); // 크로스에디터 Focus 이동
		    return;
		}

		if (!confirm('등록하시겠습니까?')) {
			return;
		}

		var cont = CrossEditor.GetBodyValue();
		document.getElementById("nttCn").value= cont;
		form.submit();
	}

	function del(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	}

	function restore(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/restore.do";
		form.submit();
	}

	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delPermanently.do";
		form.submit();
	}

	function openPopup()
	{
		url = "/bos/deptPop/list.do?board=Y";
		window.open(url, "deptName", "resizable=no, status=no, scrollbars=no, toolbar=no, menubar=no, width=800, height=700");
	}

	//페이스북 내용 에디터에 넣기
	function popupVal(message)
	{
		CrossEditor.SetBodyValue(message);
		//$("#nttCn").val(message);
	}

</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
</head>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="htmlYn" value="${result.htmlYn}" />
	<input type="hidden" name="fbSnsId" id="fbSnsId" value="" />
	<input type="hidden" name="shortUrl" id="shortUrl" value="" />
	<input type="hidden" id="cmmShortUrl" name="cmmShortUrl" value="" />

	<div class="bdView">
		<table>
			<caption>${masterVO.bbsNm} - ${empty result ? '등록' : '수정'}</caption>
			<colgroup>
				<col style="width:20%" />
				<col />
			</colgroup>
			<tr>
				<th scope="row"><label for="option1">분야</label></th>
				<td>
					<select name="option1" id="option1">
						<option value="">-분야선택</option>
					<c:forEach var="code" items="${COM050CodeList}" varStatus="status">
						<option value="${code.code}" <c:if test="${code.code eq result.option1}">selected="selected"</c:if>>${code.codeNm}</option>
					</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="nttSj">제목</label></th>
				<td>
					<input type="text" name="nttSj" id="nttSj" class="form-control" value="${result.nttSj}" />
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="representationImg">대표이미지</label></th>
				<td>
					<div>권장 사이즈 : 480*660</div>
					<jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" />
				</td>
			</tr>

			<c:if test="${not empty result.atchFileId}">
				<tr>
					<th scope="row">첨부파일</th>
					<td>
						<jsp:include page="/WEB-INF/jsp/bos/share/EgovFileList.jsp" flush="true" />
					</td>
				</tr>
			</c:if>
			<tr>
				<th scope="row">사이트 링크</th>
				<td>
					<input type="text" id="option2" name="option2" class="form-control" value="${result.option2}" />
				</td>
			</tr>
			<tr>
				<th scope="row" ><label for="nttCn">내용</label></th>
				<td>
					<span style="color:red;">* 아래의 작성하시는 내용 (첨부파일 포함)중에 개인정보에 관한 내용이 있다면 개인정보가 타인에게 노출되어 침해 받을 수 있으므로 삭제 후 등록하여 주시기 바랍니다.
					(개인정보내용 : 주민등록번호, 계좌번호, 핸드폰번호 등)
					</span><br/>
					<%--
					<textarea id="nttCn" name="nttCn" cols="150" rows="30" class="textarea">${result.nttCn}</textarea>
					 --%>
					<textarea id="nttCn" name="nttCn" cols="150" rows="30" style="display:none;" class="textarea">${result.nttCn}</textarea>
				 	<script type="text/javascript">
					//<![CDATA[
						var CrossEditor = new NamoSE("crosseditor");
						CrossEditor.params.Font = {"Nanum Gothic":"나눔고딕", "Dotum":"돋움", "Gulim":"굴림", "Batang":"바탕", "Gungsuh":"궁서"};
						CrossEditor.EditorStart();
						var contentValue = document.getElementById("nttCn").value; // Hidden 값 참조
						function OnInitCompleted(){
							//contentValue = contentValue.replace(/#script#/gi, "script");
							CrossEditor.SetBodyValue(contentValue); // 컨텐츠 내용 에디터 삽입
						}
					//]]>
					</script>

				</td>
			</tr>
			<tr>
				<th scope="row" ><label for="option">페이스북 연계여부</label></th>
				<td>
					<%-- <div class="snsInputSet">
						<label>
							<span class="labels"><span class="ico-f"></span>Facebook</span>
							<div><input type="text" id="option2" name="option2" value="${result.option2}" placeholder="Facebook url"/></div>
						</label>
					</div> --%>
					<label><input type="radio" name="option3" id="option31" value="Y" <c:if test="${result.option3 eq 'Y'}">checked="checked"</c:if>>예 </label>
					<label><input type="radio" name="option3" id="option32" value="N" <c:if test="${empty result or result.option3 eq 'N'}">checked="checked"</c:if> >아니오</label>
					<!-- <img id="fbLoginImg" src="/portal/images/facebook.png" alt="Facebook Login" width="45px" height="45px"/> -->
					<button class="btn btn-t btn-default" id="fbLoginBtn" >페이스북 연계하기</button>
				</td>
			</tr>

		</table>
	</div>


</form>
	<c:if test="${not empty result}">
	<div class="fl">
		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
	</div>
	</c:if>
	<div class="fr" >
	<c:choose>
	<c:when test="${empty result}" >
		<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
	</c:when>
	<c:otherwise>
		<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
	<c:if test="${result.delcode eq '0' }" >
		<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:if>
	<c:if test="${result.delcode eq '1' }" >
		<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>복구</span></a>
	</c:if>
	</c:otherwise>
	</c:choose>
		<c:url var="url" value="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}"/>
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>
