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

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/jquery.cookies.js"></script>
<script type="text/javascript" src="https://connect.facebook.net/ko_KR/all.js"></script>
<script type="text/javascript">
//<![CDATA[

var start = 0;

$(document).ready(function(){
	FB.init({
		appId : '<c:out value="${facebookAppKey}" />', // 페이스북 App Id 입력.
		cookie : true,
		status : true,
		xfbml : true
	});



	getFacebookData(start);

});

function addDataList(){
	start = start + 5;

	getFacebookAddData(start);
}

 function getFacebookData(num){

	 FB.getLoginStatus(function(response) {

			if (response.authResponse) {

				var snsData = "";
				var addBtn = "";
				FB.api('/me/feed', { offset : num , limit: 10 }, function(response) {

			    	if(response.data.length != null && response.data.length > 0){
						for (var i=0, l= response.data.length; i< l; i++) {

							var info = response.data[i];

							snsData = snsData + "<tr id=\"tr"+info.id+"\">";

		               		// info.id : 게시글 아이디,  info.from.name : 작성자, info.message : 제목, info.description : 글내용, info.picture : 이미지, info.created_time : 작성일, info.updated_time : 갱신일

		               		if (info.picture != '') {

		               			snsData = snsData + "<td><img src=\"" + info.picture + "\" width=\"60px\" height=\"60px\" ></td>";
		               		}else{

		               			snsData = snsData + "<td><img src=\"/ckl/images/facebook.png\" width=\"60px\" height=\"60px\"></td>";
		               		}

		               		// snsData = snsData + "<td><a href=\"#snsData"+i+"\" id=\"snsData"+i+"\" onclick=\"detailSnsData('"+info.id+"');\">"+info.message+"</a></td>"; 상세보기용
		               		if (info.message) {

		               			snsData = snsData + "<td>"+info.message+"</td>";
		               		}else{
		               			snsData = snsData + "<td>내용이 없습니다.</td>";
		               		}
			    			snsData = snsData + "<td>"+info.created_time+"</td>";
		               		for(var j = 0; j < info.actions.length; ++j){

		               			if(j == 0){

		               				snsData = snsData + "<td><a href=\"#snsData"+i+"\" id=\"snsData"+i+"\" onclick=\"javascript:setSnsUrl('"+info.message+"','"+info.actions[j].link+"');\">선택</a></td>";
		               			}
		               		}
			    			snsData = snsData + "</tr>";

			             }

						addBtn = addBtn + "<div class=\"row\">";
						addBtn = addBtn + "<div class=\"col-md-6 tar\">";
						addBtn = addBtn + "<a class=\"btn btn-primary\" href=\"#viewData\" id=\"viewData\" onclick=\"javascript:addDataList();\"><span>더보기</span></a>";
						addBtn = addBtn + "</div>";
			    	}else{
			    		snsData = snsData + "<tr><td colspan=\"4\">데이터가 없습니다.</td></tr>";
			    	}

	    			addBtn = addBtn + "<div class=\"row\">";
	    			addBtn = addBtn + "<div class=\"col-md-6 tar\">";
	    			addBtn = addBtn + "<a class=\"btn btn-primary\" href=\"javascript:self.close();\"><span>닫기</span></a>";
	    			addBtn = addBtn + "</div>";
	    			addBtn = addBtn + "</div>";

	    			$("#snsDiv").html(snsData);
	    			$("#snsAddDiv").html(addBtn);
		          });

			} else {

			}

		});
 }


 function getFacebookAddData(num){


	 FB.getLoginStatus(function(response) {

			if (response.authResponse) {

				var snsData = "";
				var addBtn = "";
				FB.api('/me/feed', { offset : num , limit: 10 }, function(response) {

			    	if(response.data.length != null && response.data.length > 0){
						for (var i=0, l= response.data.length; i< l; i++) {

							var info = response.data[i];


								snsData = snsData + "<tr id=\"tr"+info.id+"\">";

			               		// info.id : 게시글 아이디,  info.from.name : 작성자, info.message : 제목, info.description : 글내용, info.picture : 이미지, info.created_time : 작성일, info.updated_time : 갱신일

			               		if (info.picture != '') {

			               			snsData = snsData + "<td><img src=\"" + info.picture + "\" width=\"60px\" height=\"60px\" ></td>";
			               		}else{

			               			snsData = snsData + "<td><img src=\"/ckl/images/facebook.png\" width=\"60px\" height=\"60px\"></td>";
			               		}

			               		// snsData = snsData + "<td><a href=\"#snsData"+i+"\" id=\"snsData"+i+"\" onclick=\"detailSnsData('"+info.id+"');\">"+info.message+"</a></td>"; 상세보기용
			               		if (info.message) {

			               			snsData = snsData + "<td>"+info.message+"</td>";
			               		}else{
			               			snsData = snsData + "<td>내용이 없습니다.</td>";
			               		}
				    			snsData = snsData + "<td>"+info.created_time+"</td>";
			               		for(var j = 0; j < info.actions.length; ++j){

			               			if(j == 0){

			               				snsData = snsData + "<td><a href=\"#snsData"+i+"\" id=\"snsData"+i+"\" onclick=\"javascript:setSnsUrl('"+info.message+"','"+info.actions[j].link+"');\">선택</a></td>";
			               			}
			               		}
				    			snsData = snsData + "</tr>";
							}



			    	}else{
			    		snsData = snsData + "<tr><td colspan=\"4\">데이터가 없습니다.</td></tr>";

			    		addBtn = addBtn + "<div class=\"row\">";
		    			addBtn = addBtn + "<div class=\"col-md-6 tar\">";
		    			addBtn = addBtn + "<a class=\"btn btn-primary\" href=\"javascript:self.close();\"><span>닫기</span></a>";
		    			addBtn = addBtn + "</div>";
		    			addBtn = addBtn + "</div>";

		    			$("#snsAddDiv").html(addBtn);
			    	}


	    			$("#snsDiv").append(snsData);
		          });

			} else {

			}

		});
 }

function setSnsUrl(message, link){
	$("#option2", opener.document).val(link);
	//$("#nttCn", opener.document).val(message);
	opener.parent.popupVal(message);

	self.close();
}
//]]>
</script>
<body>


<div id="content" class="ml25">
		<div class="hgroup">
			<h3>페이스북 조회</h3>
		</div>

<!-- board list start -->

	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>카카오스토리 데이터</caption>
			<colgroup>
				<col width="20%" />
				<col width="60%" />
				<col width="10%" />
				<col width="*" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="fir">이미지</th>
					<th scope="col">내용</th>
					<th scope="col">작성일</th>
					<th scope="col">비고</th>
				</tr>
			</thead>
			<tbody id="snsDiv">
				<tr><td colspan="4">조회중입니다.</td></tr>
			</tbody>
		</table>
	</div>

	<div id="snsAddDiv">
<!-- board list end //-->



</div>

</form>

</body>
</html>