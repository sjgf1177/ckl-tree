<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
//<![CDATA[
	$(document).ready(function(){
		var now = new Date();
		$(document).on("change", "input[name=employmentYn]", function(){	
			if($(this).is(":checked")){
				$(this).parent().parent().find(".resignYear").hide();
				$(this).parent().parent().find(".resignYear").empty();
				$(this).parent().parent().find(".resignYear").append("<option value=''>퇴사년도</option>");
				for (var i=now.getFullYear(); i>1990; i--){
					$(this).parent().parent().find(".resignYear").append("<option value='" + i + "'>" + i + "</option>");
				}
			} else {
				$(this).parent().parent().find(".resignYear").show();
			}	
		});
		
		$(document).on("click", ".delCareersInfo", function(){
			var newAt = $(this).parent().parent().parent().parent().parent().attr("class");
			if (newAt == "newCareerInfo"){
				$(this).parent().parent().parent().parent().parent().parent().parent().remove();
			} else {
				var careerSn = $(this).parent().parent().parent().parent().parent().find("input[name=careerSn]").val();
				 $.ajax({
					type:"POST",
					url:"/bos/careerManage/stuCareerMng/careerDelete.json?menuNo=100245",
					data:{"careerSn":careerSn},
					cache:false,
					async:false,
					dataType:"JSON",
					success:function(data){
						alert("삭제되었습니다.");
						location.reload();
					},
					error:function(){
						alert("서버와 통신 실패");
					}
				});
			}
		});
	});
	
	function addCareer(){
		if($("#careerListTable tbody").find("td").length < 2){
			$("#careerListTable tbody .careerInfoTr").empty();
		}
		for(var i=0; i<$("#careerTemp .newCareerInfo").find(".workerType").length; i++){
			var j = Math.floor(Math.random() * 100);
			$("#careerTemp .newCareerInfo").find(".workerType").attr("name", "newWorkerType" + j);
		}
		$("#careerListTable>tbody").append($("#careerTemp tbody").html());
	}
	
	function saveCareerList(stuSn){
		var careerDataList = new Array();
		var fieldCareerYn =  $("input[name=fieldCareerYn]:checked").val();
		if ($(".careerInfo").length > 0){
			for(var i=0; i<$(".careerInfo").length; i++){
				var data = new Object();
				data.data="old";
				data.careerSn=$(".careerInfo")[i].getElementsByClassName("careerSn")[0].value;
				data.stuSn="<c:out value='${stuInfo.stuSn}'/>";
				data.compNm=$(".careerInfo")[i].getElementsByClassName("compNm")[0].value;
				data.joinYear=$(".careerInfo")[i].getElementsByClassName("joinYear")[0].value;
				data.resignYear=$(".careerInfo")[i].getElementsByClassName("resignYear")[0].value;
				if($(".careerInfo")[i].getElementsByClassName("employmentYn")[0].checked){
					data.employmentYn="Y";
				} else {
					data.employmentYn="N";
				}
				for(var j=0; j<$(".careerInfo")[i].getElementsByClassName("workerType").length; j++){
					if($(".careerInfo")[i].getElementsByClassName("workerType")[j].checked){
						data.workerType=$(".careerInfo")[i].getElementsByClassName("workerType")[j].value;
					}
				}
				
				for(var k=0; k<$(".careerInfo")[i].getElementsByClassName("rank").length; k++){
					if($(".careerInfo")[i].getElementsByClassName("rank")[k].checked){
						data.rank=$(".careerInfo")[i].getElementsByClassName("rank")[k].value;
					}
				}
				
				careerDataList.push(data);
			}
		}
		
		if ($(".newCareerInfo").length > 0){
			for(var i=0; i<$("#careerListTable .newCareerInfo").length; i++){
				var data = new Object();
				data.data="new";
				data.careerSn=$(".newCareerInfo")[i].getElementsByClassName("careerSn")[0].value;
				data.stuSn="<c:out value='${stuInfo.stuSn}'/>";
				data.compNm=$(".newCareerInfo")[i].getElementsByClassName("compNm")[0].value;
				data.joinYear=$(".newCareerInfo")[i].getElementsByClassName("joinYear")[0].value;
				data.resignYear=$(".newCareerInfo")[i].getElementsByClassName("resignYear")[0].value;
				if($(".newCareerInfo")[i].getElementsByClassName("employmentYn")[0].checked){
					data.employmentYn="Y";
				} else {
					data.employmentYn="N";
				}
				for(var j=0; j<$(".newCareerInfo")[i].getElementsByClassName("workerType").length; j++){
					if($(".newCareerInfo")[i].getElementsByClassName("workerType")[j].checked){
						data.workerType=$(".newCareerInfo")[i].getElementsByClassName("workerType")[j].value;
					}
				}
				
				for(var k=0; k<$(".newCareerInfo")[i].getElementsByClassName("rank").length; k++){
					if($(".newCareerInfo")[i].getElementsByClassName("rank")[k].checked){
						data.rank=$(".newCareerInfo")[i].getElementsByClassName("rank")[k].value;
					}
				}
				
				careerDataList.push(data);
			}
		}
		$.ajax({
			type:"POST",
			url:"/bos/careerManage/stuCareerMng/changeFieldCareerYn.json?menuNo=100245",
			data:{"stuSn":"<c:out value='${stuInfo.stuSn}'/>", fieldCareerYn:fieldCareerYn},
			cache:false,
			async:false,
			dataType:"JSON",
			success:function(data){},
			error:function(){
				alert("서버와 통신 실패");
			}
		});
		
		$.ajax({
			type:"POST",
			url:"/bos/careerManage/stuCareerMng/careerUpdate.json?menuNo=100245",
			data:{"careerDataList":JSON.stringify(careerDataList)},
			cache:false,
			async:false,
			dataType:"JSON",
			success:function(data){
				alert("저장되었습니다.");
				location.reload();
			},
			error:function(){
				alert("서버와 통신 실패");
			}
		});
		
	}
//]]>
</script>

<div class="bdView">
	<table class="table table-bordered" id="careerListTable">
		<tbody>
			<tr>
				<th colspan="2" style="text-align: left;padding-left: 20px;">근무경력 <a href="javaScript:addCareer();" class="btn btn-default thin">+ 추가</a></th>
			</tr>
			<tr>
				<th width="12%">
					관련분야 근무 경력 유무
				</th>
				<td width="88%">
					<label for=""><input type="radio" name="fieldCareerYn" value="Y" <c:if test="${stuInfo.fieldCareerYn eq 'Y'}">checked</c:if>>예</label>
					<label for=""><input type="radio" name="fieldCareerYn" value="N" <c:if test="${stuInfo.fieldCareerYn eq 'N'}">checked</c:if>>아니오</label>
				</td>
			</tr>
			<c:if test="${not empty careerList}">
				<c:forEach var="careerList" items="${careerList}" varStatus="status">
					<tr class="careerInfoTr">
						<td colspan="2" style="padding:0;">
							<div class="careerInfo">
								<input type="hidden" name="careerSn" class="careerSn" value="<c:out value='${careerList.careerSn}'/>">
								
								<table class="table table-bordered">
									<colgroup>
										<col width="12%"/>
										<col width="32%"/>
										<col width="12%"/>
										<col width="32%"/>
										<col width="12%"/>
									</colgroup>
									<tbody>
										<tr>
											<th scope="row" style="vertical-align: middle;">회사명</th>
											<td>
												<input type="text" name="compNm" class="compNm" value="<c:out value='${careerList.compNm}'/>">
											</td>
											<th scope="row" style="vertical-align: middle;">근무기간</th>
											<td>
												<select class="joinYear" name="joinYear">
													<option value="">입사년도</option>
													<option value='2020' <c:if test="${careerList.joinYear eq '2020'}">selected</c:if>>2020</option>
													<option value='2019' <c:if test="${careerList.joinYear eq '2019'}">selected</c:if>>2019</option>
													<option value='2018' <c:if test="${careerList.joinYear eq '2018'}">selected</c:if>>2018</option>
													<option value='2017' <c:if test="${careerList.joinYear eq '2017'}">selected</c:if>>2017</option>
													<option value='2016' <c:if test="${careerList.joinYear eq '2016'}">selected</c:if>>2016</option>
													<option value='2015' <c:if test="${careerList.joinYear eq '2015'}">selected</c:if>>2015</option>
													<option value='2014' <c:if test="${careerList.joinYear eq '2014'}">selected</c:if>>2014</option>
													<option value='2013' <c:if test="${careerList.joinYear eq '2013'}">selected</c:if>>2013</option>
													<option value='2012' <c:if test="${careerList.joinYear eq '2012'}">selected</c:if>>2012</option>
													<option value='2011' <c:if test="${careerList.joinYear eq '2011'}">selected</c:if>>2011</option>
													<option value='2010' <c:if test="${careerList.joinYear eq '2010'}">selected</c:if>>2010</option>
													<option value='2009' <c:if test="${careerList.joinYear eq '2009'}">selected</c:if>>2009</option>
													<option value='2008' <c:if test="${careerList.joinYear eq '2008'}">selected</c:if>>2008</option>
													<option value='2007' <c:if test="${careerList.joinYear eq '2007'}">selected</c:if>>2007</option>
													<option value='2006' <c:if test="${careerList.joinYear eq '2006'}">selected</c:if>>2006</option>
													<option value='2005' <c:if test="${careerList.joinYear eq '2005'}">selected</c:if>>2005</option>
													<option value='2004' <c:if test="${careerList.joinYear eq '2004'}">selected</c:if>>2004</option>
													<option value='2003' <c:if test="${careerList.joinYear eq '2003'}">selected</c:if>>2003</option>
													<option value='2002' <c:if test="${careerList.joinYear eq '2002'}">selected</c:if>>2002</option>
													<option value='2001' <c:if test="${careerList.joinYear eq '2001'}">selected</c:if>>2001</option>
													<option value='2000' <c:if test="${careerList.joinYear eq '2000'}">selected</c:if>>2000</option>
													<option value='1999' <c:if test="${careerList.joinYear eq '1999'}">selected</c:if>>1999</option>
													<option value='1998' <c:if test="${careerList.joinYear eq '1998'}">selected</c:if>>1998</option>
													<option value='1997' <c:if test="${careerList.joinYear eq '1997'}">selected</c:if>>1997</option>
													<option value='1996' <c:if test="${careerList.joinYear eq '1996'}">selected</c:if>>1996</option>
													<option value='1995' <c:if test="${careerList.joinYear eq '1995'}">selected</c:if>>1995</option>
													<option value='1994' <c:if test="${careerList.joinYear eq '1994'}">selected</c:if>>1994</option>
													<option value='1993' <c:if test="${careerList.joinYear eq '1993'}">selected</c:if>>1993</option>
													<option value='1992' <c:if test="${careerList.joinYear eq '1992'}">selected</c:if>>1992</option>
													<option value='1991' <c:if test="${careerList.joinYear eq '1991'}">selected</c:if>>1991</option>
												</select>
												&nbsp;&nbsp;~&nbsp;&nbsp;
												<select class="resignYear" name="resignYear" <c:if test="${careerList.employmentYn eq 'Y'}">style="display:none;"</c:if>>
													<option value="">퇴사년도</option>
													<option value='2020' <c:if test="${careerList.resignYear eq '2020'}">selected</c:if>>2020</option>
													<option value='2019' <c:if test="${careerList.resignYear eq '2019'}">selected</c:if>>2019</option>
													<option value='2018' <c:if test="${careerList.resignYear eq '2018'}">selected</c:if>>2018</option>
													<option value='2017' <c:if test="${careerList.resignYear eq '2017'}">selected</c:if>>2017</option>
													<option value='2016' <c:if test="${careerList.resignYear eq '2016'}">selected</c:if>>2016</option>
													<option value='2015' <c:if test="${careerList.resignYear eq '2015'}">selected</c:if>>2015</option>
													<option value='2014' <c:if test="${careerList.resignYear eq '2014'}">selected</c:if>>2014</option>
													<option value='2013' <c:if test="${careerList.resignYear eq '2013'}">selected</c:if>>2013</option>
													<option value='2012' <c:if test="${careerList.resignYear eq '2012'}">selected</c:if>>2012</option>
													<option value='2011' <c:if test="${careerList.resignYear eq '2011'}">selected</c:if>>2011</option>
													<option value='2010' <c:if test="${careerList.resignYear eq '2010'}">selected</c:if>>2010</option>
													<option value='2009' <c:if test="${careerList.resignYear eq '2009'}">selected</c:if>>2009</option>
													<option value='2008' <c:if test="${careerList.resignYear eq '2008'}">selected</c:if>>2008</option>
													<option value='2007' <c:if test="${careerList.resignYear eq '2007'}">selected</c:if>>2007</option>
													<option value='2006' <c:if test="${careerList.resignYear eq '2006'}">selected</c:if>>2006</option>
													<option value='2005' <c:if test="${careerList.resignYear eq '2005'}">selected</c:if>>2005</option>
													<option value='2004' <c:if test="${careerList.resignYear eq '2004'}">selected</c:if>>2004</option>
													<option value='2003' <c:if test="${careerList.resignYear eq '2003'}">selected</c:if>>2003</option>
													<option value='2002' <c:if test="${careerList.resignYear eq '2002'}">selected</c:if>>2002</option>
													<option value='2001' <c:if test="${careerList.resignYear eq '2001'}">selected</c:if>>2001</option>
													<option value='2000' <c:if test="${careerList.resignYear eq '2000'}">selected</c:if>>2000</option>
													<option value='1999' <c:if test="${careerList.resignYear eq '1999'}">selected</c:if>>1999</option>
													<option value='1998' <c:if test="${careerList.resignYear eq '1998'}">selected</c:if>>1998</option>
													<option value='1997' <c:if test="${careerList.resignYear eq '1997'}">selected</c:if>>1997</option>
													<option value='1996' <c:if test="${careerList.resignYear eq '1996'}">selected</c:if>>1996</option>
													<option value='1995' <c:if test="${careerList.resignYear eq '1995'}">selected</c:if>>1995</option>
													<option value='1994' <c:if test="${careerList.resignYear eq '1994'}">selected</c:if>>1994</option>
													<option value='1993' <c:if test="${careerList.resignYear eq '1993'}">selected</c:if>>1993</option>
													<option value='1992' <c:if test="${careerList.resignYear eq '1992'}">selected</c:if>>1992</option>
													<option value='1991' <c:if test="${careerList.resignYear eq '1991'}">selected</c:if>>1991</option>
												</select>
												&nbsp;&nbsp;
												<label><input type="checkbox" name="employmentYn" class="employmentYn" <c:if test="${careerList.employmentYn eq 'Y'}">checked</c:if>/>재직여부</label>
											</td>
											<td rowspan="3" style="text-align: center;">
												<button class="btn btn-default thin delCareersInfo" >삭제</button>
											</td>
										</tr>
										<tr>
											<th scope="row" style="vertical-align: middle;">근무형태</th>
											<td colspan="3">
												<label>
													<input type="radio" name="workerType<c:out value='${careerList.careerSn}'/>" class="workerType" value="01" <c:if test="${careerList.workerType eq '01'}">checked</c:if>/>
													상근 정규직(의료보험, 산재보험 등 4대보험 적용)
												</label>
												<label>
													<input type="radio" name="workerType<c:out value='${careerList.careerSn}'/>" class="workerType" value="02" <c:if test="${careerList.workerType eq '02'}">checked</c:if>/>
													 상근 계약직(단기적 스텝, 위촉직, 시간제 게약직 등 비정규직)
												</label>
											</td>
										</tr>
										<tr>
											<th scope="row" style="vertical-align: middle;">직급</th>
											<td colspan="3">
												<c:forEach var="rankList" items="${COM164CodeList}">
													<label><input type="radio" name="rank<c:out value='${careerList.careerSn}'/>" class="rank" value="<c:out value='${rankList.code}'/>" <c:if test="${rankList.code eq careerList.rank}">checked</c:if>/><c:out value='${rankList.codeNm}'/></label>
												</c:forEach>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty careerList}">
				<tr class="careerInfoTr">
					<td colspan="2" style="text-align: center;">등록된 경력 정보가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>

<div class="btnSet clear mt20">
	<div class="row">
		<div class="col-md-12 tac">
			<a class="btn btn-primary" href="javaScript:saveCareerList(<c:out value="${stuInfo.stuSn }"/>);"><span>저장</span></a>
			<a class="btn btn-info" href="/bos/careerManage/stuCareerMng/list.do?menuNo=100245${pageQueryString }"><span>목록</span></a>
		</div>
	</div>
</div>

<div id="temp">
	<table class="table table-bordered" id="careerTemp">
		<tr>
			<td colspan="2" style="padding:0;">
				<div class="newCareerInfo">
					<input type="hidden" name="careerSn" class="careerSn" value="">
					<table class="table table-bordered">
						<colgroup>
							<col width="12%"/>
							<col width="32%"/>
							<col width="12%"/>
							<col width="32%"/>
							<col width="12%"/>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row" style="vertical-align: middle;">회사명</th>
								<td>
									<input type="text" name="compNm" class="compNm" value="">
								</td>
								<th scope="row" style="vertical-align: middle;">근무기간</th>
								<td>
									<select name="joinYear" class="joinYear">
										<option value="">입사년도</option>
										<option value='2020'>2020</option>
										<option value='2019'>2019</option>
										<option value='2018'>2018</option>
										<option value='2017'>2017</option>
										<option value='2016'>2016</option>
										<option value='2015'>2015</option>
										<option value='2014'>2014</option>
										<option value='2013'>2013</option>
										<option value='2012'>2012</option>
										<option value='2011'>2011</option>
										<option value='2010'>2010</option>
										<option value='2009'>2009</option>
										<option value='2008'>2008</option>
										<option value='2007'>2007</option>
										<option value='2006'>2006</option>
										<option value='2005'>2005</option>
										<option value='2004'>2004</option>
										<option value='2003'>2003</option>
										<option value='2002'>2002</option>
										<option value='2001'>2001</option>
										<option value='2000'>2000</option>
										<option value='1999'>1999</option>
										<option value='1998'>1998</option>
										<option value='1997'>1997</option>
										<option value='1996'>1996</option>
										<option value='1995'>1995</option>
										<option value='1994'>1994</option>
										<option value='1993'>1993</option>
										<option value='1992'>1992</option>
										<option value='1991'>1991</option>
									</select>
									&nbsp;&nbsp;~&nbsp;&nbsp;
									<select name="resignYear" class="resignYear">
										<option value="">입사년도</option>
										<option value='2020'>2020</option>
										<option value='2019'>2019</option>
										<option value='2018'>2018</option>
										<option value='2017'>2017</option>
										<option value='2016'>2016</option>
										<option value='2015'>2015</option>
										<option value='2014'>2014</option>
										<option value='2013'>2013</option>
										<option value='2012'>2012</option>
										<option value='2011'>2011</option>
										<option value='2010'>2010</option>
										<option value='2009'>2009</option>
										<option value='2008'>2008</option>
										<option value='2007'>2007</option>
										<option value='2006'>2006</option>
										<option value='2005'>2005</option>
										<option value='2004'>2004</option>
										<option value='2003'>2003</option>
										<option value='2002'>2002</option>
										<option value='2001'>2001</option>
										<option value='2000'>2000</option>
										<option value='1999'>1999</option>
										<option value='1998'>1998</option>
										<option value='1997'>1997</option>
										<option value='1996'>1996</option>
										<option value='1995'>1995</option>
										<option value='1994'>1994</option>
										<option value='1993'>1993</option>
										<option value='1992'>1992</option>
										<option value='1991'>1991</option>
									</select>
									&nbsp;&nbsp;
									<label><input type="checkbox" name="employmentYn" class="employmentYn"/>재직여부</label>
								</td>
								<td rowspan="3" style="text-align: center;">
									<button class="btn btn-default thin delCareersInfo" >삭제</button>
								</td>
							</tr>
							<tr>
								<th scope="row" style="vertical-align: middle;">근무형태</th>
								<td colspan="3">
									<label>
										<input type="radio" class="workerType" value="01"/>
										상근 정규직(의료보험, 산재보험 등 4대보험 적용)
									</label>
									<label>
										<input type="radio" class="workerType" value="02"/>
										 상근 계약직(단기적 스텝, 위촉직, 시간제 게약직 등 비정규직)
									</label>
								</td>
							</tr>
							<tr>
								<th scope="row" style="vertical-align: middle;">직급</th>
								<td colspan="3">
									<c:forEach var="rankList" items="${COM164CodeList}">
										<label><input type="radio" class="rank" value="<c:out value='${rankList.code}'/>"/><c:out value='${rankList.codeNm}'/></label>
									</c:forEach>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</td>
		</tr>
	</table>
</div>

<style>
	#temp {
		display:none;
	}
	.btn.thin{
		hieght:20px;
		padding:0px 10px 0px 10px;
	}
	label{
		margin: 0px 10px 0px 10px;
	}
	.compNm{
		width:200px;
		padding-left:5px;
	}
	#careerListTable td{
		padding:6px 5px 6px 5px;
		line-height:35px;
		vertical-align: middle;
	}
	
</style>