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
	<c:set var="action" value="/bos/concert/concertUser/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/concert/concertUser/update.do" />
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


	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);


	    v.add("userId", {
	        required: true
	    });
	    v.add("concertUserNm", {
	        required: true
	    });
	    v.add("compNm", {
	        required: true
	    });
	    v.add("concertEmail", {
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


	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/concert/concertUser/delPermanently.do";
		form.submit();
	}

	function del(){
		var form = $("#board")[0];
		form.action = "/bos/concert/concertUser/delete.do";
		form.submit();
	}

</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
</head>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}">

	<div class="bdView">
		<table>
			<caption>${masterVO.bbsNm} - ${empty result ? '등록' : '수정'}</caption>
			<colgroup>
				<col style="width:20%" />
				<col />
			</colgroup>
			<tr>
				<th scope="row"><label for="userId">아이디</label></th>
				<td>
					<input type="text" name="userId" id="userId" class="form-control w200" value="<c:out value="${result.userId}" />" />
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="concertconcertUserNm">이름</label></th>
				<td>
					<input type="text" name="concertUserNm" id="concertUserNm" class="form-control w100" value="<c:out value="${result.concertUserNm}" />" />
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="compNm">기업명</label></th>
				<td>
					<input type="text" name="compNm" id="compNm" class="form-control w300" value="<c:out value="${result.compNm}" />" />
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="concertEmail">이메일</label></th>
				<td>
					<input type="text" name="concertEmail" id="concertEmail" class="form-control w300" value="<c:out value="${result.concertEmail}" />" />
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

		<c:if test="${not empty result}">
			<tr>
				<th scope="row">등록일</th>
				<td>${result.regDate}</td>
			</tr>
		</c:if>

		</table>
	</div>


</form>
	<c:if test="${not empty result}">
	<div class="fl">
<!-- 		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a> -->
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
		<c:url var="url" value="/bos/concert/concertUser/list.do?${pageQueryString}"/>
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>
