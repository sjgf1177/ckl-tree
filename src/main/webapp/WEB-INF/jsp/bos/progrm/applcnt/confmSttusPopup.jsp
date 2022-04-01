<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
//<![CDATA[

    function confmSttusChange() {
		if($("input[name=confmSttusChk]:checked").length == 0) {
			alert("승인상태를 선택하신 후 클랙해 주세요.");
			return false;
		}
		if (!confirm("승인상태를 변경하시겠습니까?")) {
			return false;
		}
		$.post(
			"/bos/progrm/applcnt/confmSttusChange.json",
			{userSnArr : $("#userSnArr").val(), confmSttus : $("input[name=confmSttusChk]:checked").val(), prgSn : "${param.prgSn}"},
			function(data)
			{
				if(data.resultCode == "success"){
					alert("승인상태변경이 완료되었습니다.");
					location.reload();
				}
			},"json"
		);
	  	return false;
    }

//]]>
</script>

<div id="wrap" class="popupWrap">
	<div class="row">
		<div class="col-md-12">
			<h1>승인상태 변경</h1>
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="bdList">
							<form id="confmSttusFrm" name="confmSttusFrm" method="post" action="/bos/progrm/applcnt/confmSttusChange.do" class="form-inline">
								<table class="table table-bordered">
									<caption></caption>
									<colgroup>
										<col  style="width:10%" />
										<col  />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">선택</th>
											<th scope="col">분류명</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="code" items="${COM054CodeList}" varStatus="status">
										<tr>
											<td><input type="radio" name="confmSttusChk" id="confmSttus${status.count}" value="${code.code}" title="선택${status.count}" /></td>
											<td><label for="confmSttus${status.count}">${code.codeNm}</label></td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</form>
						</div>

					<div class="btnSet">
						<input type="button" class="btn btn-primary" onclick="confmSttusChange();" title="확인" value="확인" />
						<!-- <a href="#" id="confmSttusChangeBtn" class="btn btn-primary">확인</a> -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>