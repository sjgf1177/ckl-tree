<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
//<![CDATA[
	$(document).ready(function(){
		var now = new Date();
		var schTemp = ['01', '02', '03'];
		$("input[name=schoolUseAt]").on("change", function(){
			if ($("input[name=schoolUseAt]:checked").val() == 'Y'){
				$("#schoolListTable").parent().parent().show();
			} else {
				$("#schoolListTable").parent().parent().hide();
			}
		});
		
		$("#schoolTemp tbody").find("input[name=schNm]").hide();
		$("#schoolTemp tbody").find("select[name=graduatedYn]").hide();
		$("#schoolTemp tbody").find("select[name=graduatedYear]").hide();
		$("#schoolTemp tbody").find("input[name=qualificationExam]").parent().hide();
		$("#schoolTemp tbody").find("input[name=transferYn]").parent().hide();
		$("#schoolTemp tbody").find("input[name=transferYn]").parent().next().hide();
		$("#schoolTemp tbody").find("select[name=majorField]").hide();
		$("#schoolTemp tbody").find("select[name=majorField]").next().hide();
		
		$(document).on("change", ".schGubun", function(){
			if($.inArray($(this).val(), schTemp) != -1){
				$(this).parent().find("select[name=graduatedYn]").empty();
				$(this).parent().find("select[name=graduatedYn]").append("<option value=''>졸업여부</option>");
				$(this).parent().find("select[name=graduatedYn]").append("<option value='01'>졸업</option>");
				$(this).parent().find("select[name=graduatedYn]").append("<option value='02'>재학중</option>");
				
				$(this).parent().find("input[name=schNm]").show();
				$(this).parent().find("select[name=graduatedYn]").show();
				$(this).parent().find("select[name=graduatedYear]").hide();
				$(this).parent().find("input[name=qualificationExam]").parent().show();
				$(this).parent().find("input[name=transferYn]").parent().hide();
				$(this).parent().find("input[name=transferYn]").parent().next().hide();
				$(this).parent().find("select[name=majorField]").hide();
				$(this).parent().find("select[name=majorField]").next().hide();
			} else {
				$(this).parent().find("select[name=graduatedYn]").empty();
				$(this).parent().find("select[name=graduatedYn]").append("<option value=''>졸업여부</option>");
				$(this).parent().find("select[name=graduatedYn]").append("<option value='01'>졸업</option>");
				$(this).parent().find("select[name=graduatedYn]").append("<option value='02'>재학중</option>");
				$(this).parent().find("select[name=graduatedYn]").append("<option value='03'>수료</option>");
				
				$(this).parent().find("input[name=schNm]").show();
				$(this).parent().find("select[name=graduatedYn]").show();
				$(this).parent().find("select[name=graduatedYear]").hide();
				$(this).parent().find("input[name=qualificationExam]").parent().hide();
				$(this).parent().find("input[name=transferYn]").parent().show();
				$(this).parent().find("input[name=transferYn]").parent().next().show();
				$(this).parent().find("select[name=majorField]").show();
				$(this).parent().find("select[name=majorField]").next().show();
			}
		});
		
		$(document).on("change", ".graduatedYn", function(){
			
			if($(this).val() == '01'){
				$(this).next().empty();
				$(this).next().append("<option value=''>졸업년도</option>");
				for (var i=now.getFullYear(); i>1970; i--){
					$(this).next().append("<option value='" + i + "'>" + i + "</option>");
				}
				$(this).next().show();
			} else if ($(this).val() == '03') {
				$(this).next().empty();
				$(this).next().append("<option value=''>수료년도</option>");
				for (var i=now.getFullYear(); i>1970; i--){
					$(this).next().append("<option value='" + i + "'>" + i + "</option>");
				}
				$(this).next().show();
			} else {
				$(this).next().val("");
				$(this).next().hide();
			}
		});
		
		/* $(document).on("click", ".addMajorBtn", function(){
			if($(this).parent().find("input[name=majorInput]").length < 2){
				var majoraddTemp = "<br/>";
				majoraddTemp += "<select class='major' name='majorInput'>";
				majoraddTemp += $("#schoolTemp .newSchoolInfo .major").html();
				majoraddTemp += "</select>";
				$(this).parent().append(majoraddTemp);
			} else {
				alert("전공은 2개까지만 입력가능합니다.");
			}
		}); */
		
		$(document).on("click", ".delSchInfo", function(){
			if($(this).parent().prev().find("div").attr("class") == "newSchoolInfo"){
				$(this).parent().parent().remove();
			} else {
				var schSn = $(this).parent().parent().find("input[name=schSn]").val();
				$.ajax({
					type:"POST",
					url:"/bos/careerManage/stuCareerMng/schDelete.json?menuNo=100245",
					data:{"schSn":schSn},
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
		
		$(document).on("change", ".qualificationExam", function(){
			if($(this).is(":checked")){
				$(this).parent().parent().find(".schNm").val("대입자격검정고시");
				$(this).parent().parent().find(".graduatedYn").val("01").prop("selected", true);
				$(this).parent().parent().find(".graduatedYn").hide();
				$(this).parent().parent().find(".graduatedYear").empty();
				$(this).parent().parent().find(".graduatedYear").append("<option value=''>합격년도</option>");
				for (var i=now.getFullYear(); i>1970; i--){
					$(this).parent().parent().find(".graduatedYear").append("<option value='" + i + "'>" + i + "</option>");
				}
				$(this).parent().parent().find(".graduatedYear").show();
			} else {
				$(this).parent().parent().find(".schNm").val("");
				$(this).parent().parent().find(".graduatedYn").val("");
				$(this).parent().parent().find(".graduatedYn").show();
				$(this).parent().parent().find(".graduatedYear").empty();
				$(this).parent().parent().find(".graduatedYear").hide();
			}
		});
		
		$(document).on("click", ".delJoinEduInfo", function(){
			 if($(this).parent().prev().find("div").attr("class") == "newJoinEduInfo"){
				$(this).parent().parent().remove();
			} else {
				var joinSn = $(this).parent().parent().find("input[name=joinSn]").val();
				$.ajax({
					type:"POST",
					url:"/bos/careerManage/stuCareerMng/joinEduDelete.json?menuNo=100245",
					data:{"joinSn":joinSn},
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
	
	function addSchool(){
		if($("#schoolListTable tbody").find("td").length < 2){
			$("#schoolListTable tbody").empty();
		}
		$("#schoolListTable tbody").append($("#schoolTemp tbody").html());
	}
	
	
	function saveSchoolList(stuSn){
		var schoolUseAt = $("input[name=schoolUseAt]:checked").val();
		var stuSn = <c:out value='${stuInfo.stuSn}'/>;
		if(schoolUseAt == 'Y'){
			var schoolDataList = new Array();
			
			if ($("#schoolListTable .schoolInfo").length > 0) {
				for(var i=0; i<$("#schoolListTable .schoolInfo").length; i++){
					var data = new Object();
					data.data="old";
					
					if ($("#schoolListTable .schoolInfo")[i].getElementsByClassName("schSn")[0]){
						data.schSn = $("#schoolListTable .schoolInfo")[i].getElementsByClassName("schSn")[0].value;
					} else {
						data.schSn = "";
					}
					
					if ($("#schoolListTable .schoolInfo")[i].getElementsByClassName("stuSn")[0]){
						data.stuSn = $("#schoolListTable .schoolInfo")[i].getElementsByClassName("stuSn")[0].value;
					} else {
						data.stuSn = "";
					}
					
					if ($("#schoolListTable .schoolInfo")[i].getElementsByClassName("schGubun")[0]){
						data.schGubun = $("#schoolListTable .schoolInfo")[i].getElementsByClassName("schGubun")[0].value;
					} else {
						data.schGubun = "";
					}
					
					if ($("#schoolListTable .schoolInfo")[i].getElementsByClassName("schNm")[0]){
						data.schNm = $("#schoolListTable .schoolInfo")[i].getElementsByClassName("schNm")[0].value;
					} else {
						data.schNm = "";
					}
					
					if ($("#schoolListTable .schoolInfo")[i].getElementsByClassName("graduatedYn")[0]){
						data.graduatedYn = $("#schoolListTable .schoolInfo")[i].getElementsByClassName("graduatedYn")[0].value;
					} else {
						data.graduatedYn = "";
					}
					
					if ($("#schoolListTable .schoolInfo")[i].getElementsByClassName("graduatedYear")[0]){
						data.graduatedYear = $("#schoolListTable .schoolInfo")[i].getElementsByClassName("graduatedYear")[0].value;
					} else {
						data.graduatedYear = "";
					}
					
					if ($("#schoolListTable .schoolInfo")[i].getElementsByClassName("qualificationExam")[0]){
						if($("#schoolListTable .schoolInfo")[i].getElementsByClassName("qualificationExam")[0].checked){
							data.qualificationExam = "Y";
						} else {
							data.qualificationExam = "N";
						}
					} else {
						data.qualificationExam = "N";
					}
					
					if ($("#schoolListTable .schoolInfo")[i].getElementsByClassName("transferYn")[0]){
						if($("#schoolListTable .schoolInfo")[i].getElementsByClassName("transferYn")[0].checked){
							data.transferYn = "Y";
						} else {
							data.transferYn = "N";
						}
					} else {
						data.transferYn = "N";
					}
					
					if ($("#schoolListTable .schoolInfo")[i].getElementsByClassName("majorField")[0]){
						data.majorField = $("#schoolListTable .schoolInfo")[i].getElementsByClassName("majorField")[0].value;
					} else {
						data.majorField = "";
					}
					
					if ($("#schoolListTable .schoolInfo")[i].getElementsByClassName("major")[0]){
						data.major = $("#schoolListTable .schoolInfo")[i].getElementsByClassName("major")[0].value;
					} else {
						data.major = "";
					}
					
					schoolDataList.push(data);
				}
			}
			
			if ($("#schoolListTable .newSchoolInfo").length > 0) {
				for(var i=0; i<$("#schoolListTable .newSchoolInfo").length; i++){
					var data = new Object();
					data.data="new";
					
					if ($("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("schSn")[0]){
						data.schSn = $("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("schSn")[0].value;
					} else {
						data.schSn = "";
					}
					
					if ($("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("stuSn")[0]){
						data.stuSn = $("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("stuSn")[0].value;
					} else {
						data.stuSn = "";
					}
					
					if ($("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("schGubun")[0]){
						data.schGubun = $("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("schGubun")[0].value;
					} else {
						data.schGubun = "";
					}
					
					if ($("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("schNm")[0]){
						data.schNm = $("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("schNm")[0].value;
					} else {
						data.schNm = "";
					}
					
					if ($("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("graduatedYn")[0]){
						data.graduatedYn = $("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("graduatedYn")[0].value;
					} else {
						data.graduatedYn = "";
					}
					
					if ($("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("graduatedYear")[0]){
						data.graduatedYear = $("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("graduatedYear")[0].value;
					} else {
						data.graduatedYear = "";
					}
					
					if ($("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("qualificationExam")[0]){
						if($("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("qualificationExam")[0].checked){
							data.qualificationExam = "Y";
						} else {
							data.qualificationExam = "N";
						}
					} else {
						data.qualificationExam = "N";
					}
					
					if ($("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("transferYn")[0]){
						if($("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("transferYn")[0].checked){
							data.transferYn = "Y";
						} else {
							data.transferYn = "N";
						}
					} else {
						data.transferYn = "N";
					}
					
					if ($("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("majorField")[0]){
						data.majorField = $("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("majorField")[0].value;
					} else {
						data.majorField = "";
					}
					
					if ($("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("major")[0]){
						data.major = $("#schoolListTable .newSchoolInfo")[i].getElementsByClassName("major")[0].value;
					} else {
						data.major = "";
					}
					
					schoolDataList.push(data);
				}
			}
			$.ajax({
				type:"POST",
				url:"/bos/careerManage/stuCareerMng/changeSchoolUseAt.json?menuNo=100245",
				data:{"stuSn":stuSn, "schoolUseYn":schoolUseAt},
				cache:false,
				async:false,
				dataType:"JSON",
				success:function(data){
				},
				error:function(){
					alert("서버와 통신 실패");
				}
			});
			
			$.ajax({
				type:"POST",
				url:"/bos/careerManage/stuCareerMng/schUpdate.json?menuNo=100245",
				data:{"schoolDataList":JSON.stringify(schoolDataList)},
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
		} else {
			var schoolUseYn = schoolUseAt;
			
			$.ajax({
				type:"POST",
				url:"/bos/careerManage/stuCareerMng/changeSchoolUseAt.json?menuNo=100245",
				data:{"schoolUseYn":schoolUseYn, "stuSn":stuSn},
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
		
	}
	
	function addEdu(){
		if($("#joinEduListTable tbody").find("td").length < 2){
			$("#joinEduListTable tbody").empty();
		}
		$("#joinEduListTable tbody").append($("#joinEduTemp tbody").html());
	}
	
	function saveJoinEduList(stuSn){
		var joinEduDataList = new Array();
		if ($("#joinEduListTable .joinEduInfo").length > 0) {
			for(var i=0; i<$("#joinEduListTable .joinEduInfo").length; i++){
				var data = new Object();
				data.data="old";
				data.joinSn=$("#joinEduListTable .joinEduInfo")[i].getElementsByClassName("joinSn")[0].value;
				data.eduSn=$("#joinEduListTable .joinEduInfo")[i].getElementsByClassName("eduSn")[0].value;
				data.stuSn=$("#joinEduListTable .joinEduInfo")[i].getElementsByClassName("stuSn")[0].value;
				data.year=$("#joinEduListTable .joinEduInfo")[i].getElementsByClassName("year")[0].value;
				data.graduateYn = "Y";
				data.joineduDtl=$("#joinEduListTable .joinEduInfo")[i].getElementsByClassName("joineduDtl")[0].value;
				joinEduDataList.push(data);
			}
		} 
			
		if ($("#joinEduListTable .newJoinEduInfo").length > 0){
			for(var i=0; i<$("#joinEduListTable .newJoinEduInfo").length; i++){
				var data = new Object();
				data.data="new";
				data.joinSn=$("#joinEduListTable .newJoinEduInfo")[i].getElementsByClassName("joinSn")[0].value;
				data.eduSn=$("#joinEduListTable .newJoinEduInfo")[i].getElementsByClassName("eduSn")[0].value;
				data.stuSn=$("#joinEduListTable .newJoinEduInfo")[i].getElementsByClassName("stuSn")[0].value;
				data.year=$("#joinEduListTable .newJoinEduInfo")[i].getElementsByClassName("year")[0].value;
				data.graduateYn = "Y";
				data.joineduDtl=$("#joinEduListTable .newJoinEduInfo")[i].getElementsByClassName("joineduDtl")[0].value;
				joinEduDataList.push(data);
			}
		}
		
		$.ajax({
			type:"POST",
			url:"/bos/careerManage/stuCareerMng/joinEduUpdate.json?menuNo=100245",
			data:{"joinEduDataList":JSON.stringify(joinEduDataList)},
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
		<table class="table table-bordered">
			<colgroup>
				<col width="15%"/>
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th>학력<c:if test="${stuInfo.schoolUseYn ne 'N'}">  <a href="javaScript:addSchool();" class="btn btn-default thin">+ 추가</a></c:if></th>
					<th colspan="2" style="text-align:left; padding:0px 20px 0px 20px; vertical-align: middle;">
						<label for=""><input type="radio" name="schoolUseAt" value="Y" <c:if test="${stuInfo.schoolUseYn eq 'Y'}">checked</c:if>>사용</label>
						<label for=""><input type="radio" name="schoolUseAt" value="N" <c:if test="${stuInfo.schoolUseYn eq 'N'}">checked</c:if>>미사용</label>
					</th>
				</tr>
				<tr <c:if test="${stuInfo.schoolUseYn eq 'N'}">style="display:none;"</c:if>>
					<th scope="row" style="vertical-align: middle;" >학교</th>
					<td>
						
							<table class="table" style="border:none;" id="schoolListTable">
							<colgroup>
								<col />
								<col width="10%"/>
							</colgroup>
							<tbody>
								<c:if test="${not empty schoolList}">
									<c:forEach var="schoolList" items="${schoolList}" varStatus="status">
									<tr>
										<td>
											<div id="schoolInfo<c:out value='${schoolList.schSn}'/>" class="schoolInfo">
												<input type="hidden" name="schSn" class="schSn"  value="${schoolList.schSn}"/>
												<input type="hidden" name="stuSn" class="stuSn" value="${schoolList.stuSn}"/>
												<select name="schGubun" class="schGubun" style="width:150px;">
													<option value="">학교구분</option>	
													<c:forEach var="schList" items="${COM165CodeList}">
														<option value="<c:out value='${schList.code}'/>" <c:if test="${schList.code eq schoolList.schGubun}">selected</c:if>><c:out value='${schList.codeNm}'/></option>
													</c:forEach>
												</select>
												<input type="text" name="schNm" class="schNm" value="<c:out value='${schoolList.schNm}'/>"/>
												<select name="graduatedYn" class="graduatedYn">
													<option value="">선택</option>
														<c:choose>
															<c:when test="${schoolList.schGubun eq '01'}">
																<option value="01" <c:if test="${schoolList.graduatedYn eq '01'}">selected</c:if>>졸업</option>
																<option value="02" <c:if test="${schoolList.graduatedYn eq '02'}">selected</c:if>>재학중</option>
															</c:when>
															<c:when test="${schoolList.schGubun eq '02'}">
																<option value="01" <c:if test="${schoolList.graduatedYn eq '01'}">selected</c:if>>졸업</option>
																<option value="02" <c:if test="${schoolList.graduatedYn eq '02'}">selected</c:if>>재학중</option>
															</c:when>
															<c:when test="${schoolList.schGubun eq '03'}">
																<option value="01" <c:if test="${schoolList.graduatedYn eq '01'}">selected</c:if>>졸업</option>
																<option value="02" <c:if test="${schoolList.graduatedYn eq '02'}">selected</c:if>>재학중</option>
															</c:when>
															<c:otherwise>
																<option value="01" <c:if test="${schoolList.graduatedYn eq '01'}">selected</c:if>>졸업</option>
																<option value="02" <c:if test="${schoolList.graduatedYn eq '02'}">selected</c:if>>재학중</option>
																<option value="03" <c:if test="${schoolList.graduatedYn eq '03'}">selected</c:if>>수료</option>
															</c:otherwise>
														</c:choose>
													</select>
													<c:choose>
														<c:when test="${schoolList.graduatedYn eq '02'}">
															<select name="graduatedYear" class="graduatedYear" style="display:none;"></select>
														</c:when>
														<c:otherwise>
															<select name="graduatedYear" class="graduatedYear">
																<option value="">${schoolList.graduatedYn eq '03' ? '수료년도' : '졸업년도'}</option>
																<option value='2020' <c:if test="${schoolList.graduatedYear eq '2020'}">selected</c:if>>2020</option>
																<option value='2019' <c:if test="${schoolList.graduatedYear eq '2019'}">selected</c:if>>2019</option>
																<option value='2018' <c:if test="${schoolList.graduatedYear eq '2018'}">selected</c:if>>2018</option>
																<option value='2017' <c:if test="${schoolList.graduatedYear eq '2017'}">selected</c:if>>2017</option>
																<option value='2016' <c:if test="${schoolList.graduatedYear eq '2016'}">selected</c:if>>2016</option>
																<option value='2015' <c:if test="${schoolList.graduatedYear eq '2015'}">selected</c:if>>2015</option>
																<option value='2014' <c:if test="${schoolList.graduatedYear eq '2014'}">selected</c:if>>2014</option>
																<option value='2013' <c:if test="${schoolList.graduatedYear eq '2013'}">selected</c:if>>2013</option>
																<option value='2012' <c:if test="${schoolList.graduatedYear eq '2012'}">selected</c:if>>2012</option>
																<option value='2011' <c:if test="${schoolList.graduatedYear eq '2011'}">selected</c:if>>2011</option>
																<option value='2010' <c:if test="${schoolList.graduatedYear eq '2010'}">selected</c:if>>2010</option>
																<option value='2009' <c:if test="${schoolList.graduatedYear eq '2009'}">selected</c:if>>2009</option>
																<option value='2008' <c:if test="${schoolList.graduatedYear eq '2008'}">selected</c:if>>2008</option>
																<option value='2007' <c:if test="${schoolList.graduatedYear eq '2007'}">selected</c:if>>2007</option>
																<option value='2006' <c:if test="${schoolList.graduatedYear eq '2006'}">selected</c:if>>2006</option>
																<option value='2005' <c:if test="${schoolList.graduatedYear eq '2005'}">selected</c:if>>2005</option>
																<option value='2004' <c:if test="${schoolList.graduatedYear eq '2004'}">selected</c:if>>2004</option>
																<option value='2003' <c:if test="${schoolList.graduatedYear eq '2003'}">selected</c:if>>2003</option>
																<option value='2002' <c:if test="${schoolList.graduatedYear eq '2002'}">selected</c:if>>2002</option>
																<option value='2001' <c:if test="${schoolList.graduatedYear eq '2001'}">selected</c:if>>2001</option>
																<option value='2000' <c:if test="${schoolList.graduatedYear eq '2000'}">selected</c:if>>2000</option>
																<option value='1999' <c:if test="${schoolList.graduatedYear eq '1999'}">selected</c:if>>1999</option>
																<option value='1998' <c:if test="${schoolList.graduatedYear eq '1998'}">selected</c:if>>1998</option>
																<option value='1997' <c:if test="${schoolList.graduatedYear eq '1997'}">selected</c:if>>1997</option>
																<option value='1996' <c:if test="${schoolList.graduatedYear eq '1996'}">selected</c:if>>1996</option>
																<option value='1995' <c:if test="${schoolList.graduatedYear eq '1995'}">selected</c:if>>1995</option>
																<option value='1994' <c:if test="${schoolList.graduatedYear eq '1994'}">selected</c:if>>1994</option>
																<option value='1993' <c:if test="${schoolList.graduatedYear eq '1993'}">selected</c:if>>1993</option>
																<option value='1992' <c:if test="${schoolList.graduatedYear eq '1992'}">selected</c:if>>1992</option>
																<option value='1991' <c:if test="${schoolList.graduatedYear eq '1991'}">selected</c:if>>1991</option>
																<option value='1990' <c:if test="${schoolList.graduatedYear eq '1990'}">selected</c:if>>1990</option>
																<option value='1989' <c:if test="${schoolList.graduatedYear eq '1989'}">selected</c:if>>1989</option>
																<option value='1988' <c:if test="${schoolList.graduatedYear eq '1988'}">selected</c:if>>1988</option>
																<option value='1987' <c:if test="${schoolList.graduatedYear eq '1987'}">selected</c:if>>1987</option>
																<option value='1986' <c:if test="${schoolList.graduatedYear eq '1986'}">selected</c:if>>1986</option>
																<option value='1985' <c:if test="${schoolList.graduatedYear eq '1985'}">selected</c:if>>1985</option>
																<option value='1984' <c:if test="${schoolList.graduatedYear eq '1984'}">selected</c:if>>1984</option>
																<option value='1983' <c:if test="${schoolList.graduatedYear eq '1983'}">selected</c:if>>1983</option>
																<option value='1982' <c:if test="${schoolList.graduatedYear eq '1982'}">selected</c:if>>1982</option>
																<option value='1981' <c:if test="${schoolList.graduatedYear eq '1981'}">selected</c:if>>1981</option>
																<option value='1980' <c:if test="${schoolList.graduatedYear eq '1980'}">selected</c:if>>1980</option>
																<option value='1979' <c:if test="${schoolList.graduatedYear eq '1979'}">selected</c:if>>1979</option>
																<option value='1978' <c:if test="${schoolList.graduatedYear eq '1978'}">selected</c:if>>1978</option>
																<option value='1977' <c:if test="${schoolList.graduatedYear eq '1977'}">selected</c:if>>1977</option>
																<option value='1976' <c:if test="${schoolList.graduatedYear eq '1976'}">selected</c:if>>1976</option>
																<option value='1975' <c:if test="${schoolList.graduatedYear eq '1975'}">selected</c:if>>1975</option>
																<option value='1974' <c:if test="${schoolList.graduatedYear eq '1974'}">selected</c:if>>1974</option>
																<option value='1973' <c:if test="${schoolList.graduatedYear eq '1973'}">selected</c:if>>1973</option>
																<option value='1972' <c:if test="${schoolList.graduatedYear eq '1972'}">selected</c:if>>1972</option>
																<option value='1971' <c:if test="${schoolList.graduatedYear eq '1971'}">selected</c:if>>1971</option>
															</select>
														</c:otherwise>
													</c:choose>
		
													<c:choose>
															<c:when test="${schoolList.schGubun eq '01'}">
																<label><input type="checkbox" class="qualificationExam" name="qualificationExam" <c:if test="${schoolList.qualificationExam eq 'Y'}">checked</c:if>/>검정고시</label>
															</c:when>
															<c:when test="${schoolList.schGubun eq '02'}">
																<label><input type="checkbox" class="qualificationExam" name="qualificationExam" <c:if test="${schoolList.qualificationExam eq 'Y'}">checked</c:if>/>검정고시</label>
															</c:when>
															<c:when test="${schoolList.schGubun eq '03'}">
																<label><input type="checkbox" class="qualificationExam" name="qualificationExam" <c:if test="${schoolList.qualificationExam eq 'Y'}">checked</c:if>/>검정고시</label>
															</c:when>
															<c:otherwise>
																<label><input type="checkbox" class="transferYn" name="transferYn" <c:if test="${schoolList.transferYn eq 'Y'}">checked</c:if>/>편입</label>
																<br/>
																<select class="majorField" name="majorField" style="width:150px;">
																	<option value="">전공계열</option>	
																	<c:forEach var="majorFieldList" items="${COM166CodeList}">
																		<option value="<c:out value='${majorFieldList.code}'/>" <c:if test="${majorFieldList.code eq schoolList.majorField}">selected</c:if>><c:out value='${majorFieldList.codeNm}'/></option>
																	</c:forEach>
																</select>
																<input type="text" class="major" name="major" value="<c:out value='${schoolList.major }' />" placeholder="전공명">
															</c:otherwise>
													</c:choose>
												</div>
											</td>
											<td>
												<button class="btn btn-default thin delSchInfo" >삭제</button>
											</td>
										<tr>
									</c:forEach>
								</c:if>
								<c:if test="${empty schoolList}">
									<tr><td colspan="2">등록된 학력 정보가 없습니다.</td></tr>
								</c:if>
								</tbody>
							</table>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="btnSet clear mt20">
		<div class="row">
			<div class="col-md-12">
				<a class="btn btn-primary" href="javaScript:saveSchoolList(<c:out value="${stuInfo.stuSn }"/>);"><span>저장</span></a>
			</div>
		</div>
	</div>
	<br/>
	<div class="bdView">
		<table class="table table-bordered">
			<colgroup>
				<col width="15%"/>
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th colspan="2" style="text-align: left;padding-left: 20px;">참여 사업 정보 <a href="javaScript:addEdu();" class="btn btn-default thin">+ 추가</a></th>
				</tr>
				<tr>
					<th scope="row" style="vertical-align: middle;">참여사업</th>
					<td>
						<table class="table" style="border:none;" id="joinEduListTable">
							<colgroup>
								<col />
								<col width="10%"/>
							</colgroup>
							<tbody>
								<c:if test="${not empty joinEduList}">
									<c:forEach var="joinEduList" items="${joinEduList}" varStatus="status">
										<tr>
											<td>
												<div class="joinEduInfo">
													<input type="hidden" name="joinSn" class="joinSn"  value="${joinEduList.joinSn}"/>
													<input type="hidden" name="stuSn" class="stuSn" value="${stuInfo.stuSn}"/>
													<select name="eduSn" class="eduSn">
														<option value="">선택</option>
														<c:forEach var="eduList" items="${eduList}" varStatus="status">
															<option value="<c:out value='${eduList.eduSn}'/>" <c:if test="${eduList.eduSn eq joinEduList.eduSn}">selected</c:if>><c:out value='${eduList.eduNm}'/></option>
														</c:forEach>
													</select>
													<select name="year" class="year">
														<option value="">참여년도</option>
														<option value='2020' <c:if test="${joinEduList.year eq '2020'}">selected</c:if>>2020</option>
														<option value='2019' <c:if test="${joinEduList.year eq '2019'}">selected</c:if>>2019</option>
														<option value='2018' <c:if test="${joinEduList.year eq '2018'}">selected</c:if>>2018</option>
														<option value='2017' <c:if test="${joinEduList.year eq '2017'}">selected</c:if>>2017</option>
														<option value='2016' <c:if test="${joinEduList.year eq '2016'}">selected</c:if>>2016</option>
														<option value='2015' <c:if test="${joinEduList.year eq '2015'}">selected</c:if>>2015</option>
														<option value='2014' <c:if test="${joinEduList.year eq '2014'}">selected</c:if>>2014</option>
														<option value='2013' <c:if test="${joinEduList.year eq '2013'}">selected</c:if>>2013</option>
														<option value='2012' <c:if test="${joinEduList.year eq '2012'}">selected</c:if>>2012</option>
														<option value='2011' <c:if test="${joinEduList.year eq '2011'}">selected</c:if>>2011</option>
														<option value='2010' <c:if test="${joinEduList.year eq '2010'}">selected</c:if>>2010</option>
														<option value='2009' <c:if test="${joinEduList.year eq '2009'}">selected</c:if>>2009</option>
														<option value='2008' <c:if test="${joinEduList.year eq '2008'}">selected</c:if>>2008</option>
														<option value='2007' <c:if test="${joinEduList.year eq '2007'}">selected</c:if>>2007</option>
														<option value='2006' <c:if test="${joinEduList.year eq '2006'}">selected</c:if>>2006</option>
														<option value='2005' <c:if test="${joinEduList.year eq '2005'}">selected</c:if>>2005</option>
														<option value='2004' <c:if test="${joinEduList.year eq '2004'}">selected</c:if>>2004</option>
														<option value='2003' <c:if test="${joinEduList.year eq '2003'}">selected</c:if>>2003</option>
														<option value='2002' <c:if test="${joinEduList.year eq '2002'}">selected</c:if>>2002</option>
														<option value='2001' <c:if test="${joinEduList.year eq '2001'}">selected</c:if>>2001</option>
														<option value='2000' <c:if test="${joinEduList.year eq '2000'}">selected</c:if>>2000</option>
													</select>
													<br/>
													<textarea name="joineduDtl" class="joineduDtl"><c:out value='${joinEduList.joineduDtl}'/></textarea>
												</div>
											</td>
											<td>
												<button class="btn btn-default thin delJoinEduInfo" >삭제</button>
											</td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${empty joinEduList}">
									<tr><td colspan="2">등록된 참여 사업 정보가 없습니다.</td></tr>
								</c:if>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="btnSet clear mt20">
		<div class="row">
			<div class="col-md-12">
				<a class="btn btn-primary" href="javaScript:saveJoinEduList(<c:out value="${stuInfo.stuSn }"/>);"><span>저장</span></a>
			</div>
		</div>
	</div>
	<div class="btnSet clear mt20">
		<div class="row">
			<div class="col-md-12 tac">
				<a class="btn btn-info" href="/bos/careerManage/stuCareerMng/list.do?menuNo=100245${pageQueryString }"><span>목록</span></a>
			</div>
		</div>
	</div>
	
	<div id="temp">
		<table id="schoolTemp">
			<colgroup>
				<col />
				<col width="10%"/>
			</colgroup>
			<tbody>
				<tr>
					<td>
						<div class="newSchoolInfo">
							<input type="hidden" class="schSn" name="schSn" value=""/>
							<input type="hidden" class="stuSn" name="stuSn" value="${stuInfo.stuSn}"/>
							<select name="schGubun" class="schGubun">
								<option value="">학교구분</option>	
								<c:forEach var="schList" items="${COM165CodeList}">
									<option value="<c:out value='${schList.code}'/>"><c:out value='${schList.codeNm}'/></option>
								</c:forEach>
							</select>
							<input type="text" name="schNm" class="schNm" value="" placeholder="학교명"/>
							<select name="graduatedYn" class="graduatedYn"></select>
							<select name="graduatedYear" class="graduatedYear">
								<option value="">선택</option>
							</select>
							<label><input type="checkbox" class="qualificationExam" name="qualificationExam" />검정고시</label>
							<label><input type="checkbox" class="transferYn" name="transferYn" />편입</label>
							<br/>
							<select class="majorField" name="majorField">
								<option value="">전공계열</option>	
								<c:forEach var="majorFieldList" items="${COM166CodeList}">
									<option value="<c:out value='${majorFieldList.code}'/>"><c:out value='${majorFieldList.codeNm}'/></option>
								</c:forEach>
							</select>
							<input type="text" name="major" class="major" value="" placeholder="전공명">
						</div>
					</td>
					<td>
						<button class="btn btn-default thin delSchInfo" >삭제</button>
					</td>
				</tr>
			</tbody>
		</table>
		
		<table id="joinEduTemp">
			<colgroup>
				<col />
				<col width="10%"/>
			</colgroup>
			<tbody>
				<tr>
					<td>
						<div class="newJoinEduInfo">
							<input type="hidden" class="joinSn" name="schSn" value=""/>
							<input type="hidden" class="stuSn" name="stuSn" value="${stuInfo.stuSn}"/>
							<select name="eduSn" class="eduSn">
								<option value="">선택</option>
								<c:forEach var="eduList" items="${eduList}" varStatus="status">
									<option value="<c:out value='${eduList.eduSn}'/>"><c:out value='${eduList.eduNm}'/></option>
								</c:forEach>
							</select>
							<select name="year" class="year">
								<option value="">참여년도</option>
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
							</select>
							<br/>
							<textarea name="joineduDtl" class="joineduDtl"></textarea>
						</div>
					</td>
					<td>
						<button class="btn btn-default thin delJoinEduInfo" >삭제</button>
					</td>
				</tr>
			</tbody>
		</table>
		
	</div>

	<style>
		#temp {
			display:none;
		}
		.schGubun{
			width:150px;
			padding-left:5px;
		}
		.schNm{
			width:200px;
			padding-left:5px;
		}
		.graduatedYn{
			width:80px;
			padding-left:5px;
		}
		.graduatedYear{
			width:80px;
			padding-left:5px;
		}
		.majorField{
			width:150px;
			padding-left:5px;
		}
		.major{
			width:200px;
		}
		#schoolListTable td{
			padding:6px 5px 6px 5px;
			line-height:35px;
			vertical-align: middle;
		}
		.btn.thin{
			hieght:20px;
			padding:0px 10px 0px 10px;
		}
		label{
			margin: 0px 10px 0px 10px;
		}
		#joinEduListTable td{
			padding:6px 5px 6px 5px;
			line-height:35px;
			vertical-align: middle;
		}
		.eduSn{
			width:250px;
		}
		.year{
			width:80px;
			padding-left:5px;
		}
		.joineduDtl{
			width: 100%;
			height: 50px;
			padding: 5px;
		}
	</style>