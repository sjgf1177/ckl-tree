<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
//<![CDATA[
	$(document).ready(function(){
		var now = new Date();
		 $(document).on("click", ".delCreateInfo", function(){
			var newAt = $(this).parent().parent().parent().parent().parent().attr("class");
			if (newAt == "newCreateInfo"){
				$(this).parent().parent().parent().parent().parent().parent().parent().remove();
			} else {
				var createSn = $(this).parent().parent().parent().parent().parent().find("input[name=createSn]").val();
				 $.ajax({
					type:"POST",
					url:"/bos/careerManage/stuCareerMng/createDelete.json?menuNo=100245",
					data:{"createSn":createSn},
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
	
	function addCreate(){
		if ($("#createListTable tbody").find("td").length < 2){
			$("#createListTable tbody .createInfoTr").empty();
		}
		$("#createListTable>tbody").append($("#createTemp tbody").html());
	}
	
	function saveCreateList(stuSn){
		var createDataList = new Array();
		var fieldCreateYn = $("input[name=fieldCreateYn]:checked").val();
		var fieldCreatePeriod = $("input[name=fieldCreatePeriod]:checked").val();
		if ($(".createInfo").length > 0){
			for(var i=0; i<$(".createInfo").length; i++){
				var data = new Object();
				data.data="old";
				data.createSn=$(".createInfo")[i].getElementsByClassName("createSn")[0].value;
				data.stuSn="<c:out value='${stuInfo.stuSn}'/>";
				data.createNm=$(".createInfo")[i].getElementsByClassName("createNm")[0].value;
				data.createYear=$(".createInfo")[i].getElementsByClassName("createYear")[0].value;
				data.contractGroup=$(".createInfo")[i].getElementsByClassName("contractGroup")[0].value;
				
				createDataList.push(data);
			}
		}
		
		if ($(".newCreateInfo").length > 0){
			for(var i=0; i<$("#createListTable .newCreateInfo").length; i++){
				var data = new Object();
				data.data="new";
				data.createSn=$(".newCreateInfo")[i].getElementsByClassName("createSn")[0].value;
				data.stuSn="<c:out value='${stuInfo.stuSn}'/>";
				data.createNm=$(".newCreateInfo")[i].getElementsByClassName("createNm")[0].value;
				data.createYear=$(".newCreateInfo")[i].getElementsByClassName("createYear")[0].value;
				data.contractGroup=$(".newCreateInfo")[i].getElementsByClassName("contractGroup")[0].value;
				
				createDataList.push(data);
			}
		}
		
		$.ajax({
			type:"POST",
			url:"/bos/careerManage/stuCareerMng/changeFieldCreate.json?menuNo=100245",
			data:{"stuSn":"<c:out value='${stuInfo.stuSn}'/>", fieldCreateYn:fieldCreateYn, fieldCreatePeriod:fieldCreatePeriod},
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
			url:"/bos/careerManage/stuCareerMng/createUpdate.json?menuNo=100245",
			data:{"createDataList":JSON.stringify(createDataList)},
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
	<table class="table table-bordered" id="createListTable">
		<tbody>
			<tr>
				<th colspan="2" style="text-align: left;padding-left: 20px;">작품활동 경력 <a href="javaScript:addCreate();" class="btn btn-default thin">+ 추가</a></th>
			</tr>
			<tr>
				<th width="15%">관련분야 작품활동 경력 유무</th>
				<td width="85%">
					<label for=""><input type="radio" name="fieldCreateYn" value="Y" <c:if test="${stuInfo.fieldCreateYn eq 'Y'}">checked</c:if>>예</label>
					<label for=""><input type="radio" name="fieldCreateYn" value="N" <c:if test="${stuInfo.fieldCreateYn eq 'N'}">checked</c:if>>아니오</label>
				</td>
			</tr>
			<tr>
				<th width="15%">활동 기간</th>
				<td width="85%">
					<c:forEach var="periodList" items="${COM167CodeList}">
						<label for=""><input type="radio" name="fieldCreatePeriod" value="<c:out value='${periodList.code}'/>" <c:if test="${stuInfo.fieldCreatePeriod eq periodList.code}">checked</c:if>><c:out value='${periodList.codeNm}'/></label>
					</c:forEach>
				</td>
			</tr>
			<c:if test="${not empty createList}">
				<c:forEach var="createList" items="${createList}" varStatus="status">
					<tr class="createInfoTr">
						<td colspan="2" style="padding:0;">
							<div class="createInfo">
								<input type="hidden" name="createSn" class="createSn" value="<c:out value='${createList.createSn}'/>">
								<table class="table table-bordered">
									<colgroup>
										<col width="15%"/>
										<col />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row" style="vertical-align: middle;">년도</th>
											<td>
												<select class="createYear" name="createYear">
													<option value="">진행년도</option>
													<option value='2020' <c:if test="${createList.createYear eq '2020'}">selected</c:if>>2020</option>
													<option value='2019' <c:if test="${createList.createYear eq '2019'}">selected</c:if>>2019</option>
													<option value='2018' <c:if test="${createList.createYear eq '2018'}">selected</c:if>>2018</option>
													<option value='2017' <c:if test="${createList.createYear eq '2017'}">selected</c:if>>2017</option>
													<option value='2016' <c:if test="${createList.createYear eq '2016'}">selected</c:if>>2016</option>
													<option value='2015' <c:if test="${createList.createYear eq '2015'}">selected</c:if>>2015</option>
													<option value='2014' <c:if test="${createList.createYear eq '2014'}">selected</c:if>>2014</option>
													<option value='2013' <c:if test="${createList.createYear eq '2013'}">selected</c:if>>2013</option>
													<option value='2012' <c:if test="${createList.createYear eq '2012'}">selected</c:if>>2012</option>
													<option value='2011' <c:if test="${createList.createYear eq '2011'}">selected</c:if>>2011</option>
													<option value='2010' <c:if test="${createList.createYear eq '2010'}">selected</c:if>>2010</option>
													<option value='2009' <c:if test="${createList.createYear eq '2009'}">selected</c:if>>2009</option>
													<option value='2008' <c:if test="${createList.createYear eq '2008'}">selected</c:if>>2008</option>
													<option value='2007' <c:if test="${createList.createYear eq '2007'}">selected</c:if>>2007</option>
													<option value='2006' <c:if test="${createList.createYear eq '2006'}">selected</c:if>>2006</option>
													<option value='2005' <c:if test="${createList.createYear eq '2005'}">selected</c:if>>2005</option>
													<option value='2004' <c:if test="${createList.createYear eq '2004'}">selected</c:if>>2004</option>
													<option value='2003' <c:if test="${createList.createYear eq '2003'}">selected</c:if>>2003</option>
													<option value='2002' <c:if test="${createList.createYear eq '2002'}">selected</c:if>>2002</option>
													<option value='2001' <c:if test="${createList.createYear eq '2001'}">selected</c:if>>2001</option>
													<option value='2000' <c:if test="${createList.createYear eq '2000'}">selected</c:if>>2000</option>
													<option value='1999' <c:if test="${createList.createYear eq '1999'}">selected</c:if>>1999</option>
													<option value='1998' <c:if test="${createList.createYear eq '1998'}">selected</c:if>>1998</option>
													<option value='1997' <c:if test="${createList.createYear eq '1997'}">selected</c:if>>1997</option>
													<option value='1996' <c:if test="${createList.createYear eq '1996'}">selected</c:if>>1996</option>
													<option value='1995' <c:if test="${createList.createYear eq '1995'}">selected</c:if>>1995</option>
													<option value='1994' <c:if test="${createList.createYear eq '1994'}">selected</c:if>>1994</option>
													<option value='1993' <c:if test="${createList.createYear eq '1993'}">selected</c:if>>1993</option>
													<option value='1992' <c:if test="${createList.createYear eq '1992'}">selected</c:if>>1992</option>
													<option value='1991' <c:if test="${createList.createYear eq '1991'}">selected</c:if>>1991</option>
												</select>
											</td>
											<td rowspan="3" style="text-align: center;">
												<button class="btn btn-default thin delCreateInfo" >삭제</button>
											</td>
										</tr>
										<tr>
											<th scope="row" style="vertical-align: middle;">계약회사/계약단체</th>
											<td>
												<input type="text" name="contractGroup" class="contractGroup" value="<c:out value='${createList.contract}'/>"/>
											</td>
										</tr>
										<tr>
											<th scope="row" style="vertical-align: middle;">계약 작품명</th>
											<td>
												<input type="text" name="createNm" class="createNm" value="<c:out value='${createList.createNm}'/>"/>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty createList}">
				<tr class="createInfoTr">
					<td colspan="2" style="text-align: center;">등록된 작품활동 정보가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>

<div class="btnSet clear mt20">
	<div class="row">
		<div class="col-md-12 tac">
			<a class="btn btn-primary" href="javaScript:saveCreateList(<c:out value="${stuInfo.stuSn }"/>);"><span>저장</span></a>
			<a class="btn btn-info" href="/bos/careerManage/stuCareerMng/list.do?menuNo=100245${pageQueryString }"><span>목록</span></a>
		</div>
	</div>
</div>

<div id="temp">
	<table class="table table-bordered" id="createTemp">
		<tr>
			<td colspan="2" style="padding:0;">
				<div class="newCreateInfo">
					<input type="hidden" name="createSn" class="createSn" value="">
					<table class="table table-bordered">
						<colgroup>
							<col width="15%"/>
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row" style="vertical-align: middle;">연도</th>
								<td>
									<select name="createYear" class="createYear">
										<option value="">진행년도</option>
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
								</td>
								<td rowspan="3" style="text-align: center;">
									<button class="btn btn-default thin delCreateInfo" >삭제</button>
								</td>
							</tr>
							<tr>
								<th scope="row" style="vertical-align: middle;">계약회사/계약단체</th>
								<td>
									<input type="text" name="contractGroup" class="contractGroup" value=""/>
								</td>
							</tr>
							<tr>
								<th scope="row" style="vertical-align: middle;">계약 작품명</th>
								<td>
									<input type="text" name="createNm" class="createNm" value=""/>
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
	.createNm{
		width:300px;
		padding-left:5px;
	}
	.contractGroup{
		width:300px;
		padding-left:5px;
	}
	#createListTable td{
		padding:6px 5px 6px 5px;
		line-height:35px;
		vertical-align: middle;
	}
	label{
		margin-right: 20px;
	}
</style>