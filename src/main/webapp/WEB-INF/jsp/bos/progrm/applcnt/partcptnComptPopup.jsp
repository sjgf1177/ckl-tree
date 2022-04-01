<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
//<![CDATA[

    function partcptnComptChange() {
		if($("input[name=partcptnComptChk]:checked").length == 0) {
			alert("참여여부를 선택하신 후 클랙해 주세요.");
			return false;
		}
		if (!confirm("참여여부를 변경하시겠습니까?")) {
			return false;
		}
		$.post(
			"/bos/progrm/applcnt/partcptnComptChange.json",
			{userSnArr : $("#userSnArr").val(), partcptnComptAt : $("input[name=partcptnComptChk]:checked").val(), prgSn : "${param.prgSn}"},
			function(data)
			{
				if(data.resultCode == "success"){
					alert("참여여부변경이 완료되었습니다.");
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
            <h1>참여여부 변경</h1>
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="bdList">
							<form id="partcptnComptFrm" name="partcptnComptFrm" method="post" action="/bos/progrm/applcnt/partcptnComptChange.do" class="form-inline">
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
										<tr>
											<td><input type="radio" name="partcptnComptChk" id="partcptnComptChk1" title="참여" value="01"/></td>
											<td><label for="partcptnComptChk1"> ● (참여)</label></td>
										</tr>
										<tr>
											<td><input type="radio" name="partcptnComptChk" id="partcptnComptChk2" title="미참여" value="02"/></td>
											<td><label for="partcptnComptChk2"> X (미참여)</label></td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>

					<div class="btnSet">
						<input type="button" class="btn btn-primary" onclick="partcptnComptChange();" title="확인" value="확인" />
						<!-- <a href="#" id="confmSttusChangeBtn" class="btn btn-primary">확인</a> -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>