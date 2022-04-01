<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="/bos/js/Chart.js"></script>
<script>
function searchSubmit(){
	$("#statisSearchForm").submit();	
}
</script>

<form id="statisSearchForm" name="statisSearchForm" method="get" action="/bos/careerManage/statisticsMng/list.do?menuNo=100245" class="form-inline">
	<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
	<fieldset>
		<legend></legend>
		<div class="bdView mb0">
			<table class="table table-bordered">
				<caption></caption>
				<colgroup>
					<col width="10%"/>
					<col width="35%"/>
					<col width="10%"/>
					<col width="45%"/>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" ><label for="eduSn">참여사업</label></th>
						<td>
							<select name="eduSn" id="eduSn" style="width:200px;">
								<option value="">선택</option>
								<c:forEach var="eduList" items="${eduList }">
									<option value="<c:out value='${eduList.eduSn}'/>" <c:if test="${param.eduSn eq eduList.eduSn}">selected</c:if>><c:out value='${eduList.eduNm}'/></option>
								</c:forEach>
							</select>
						</td>
						<th scope="row" ><label for="eduSn">참여년도</label></th>
						<td>
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
						</td>
					</tr>
					<tr>
						<th scope="row" ><label for="stuNm">항 목</label></th>
						<td colspan="3">
							<label><input type="radio" name="gubun" value="01" <c:if test="${param.gubun eq '01'}">checked</c:if>/>성별</label>
							<label><input type="radio" name="gubun" value="02" <c:if test="${param.gubun eq '02'}">checked</c:if>/>연령별</label>
							<label><input type="radio" name="gubun" value="03" <c:if test="${param.gubun eq '03'}">checked</c:if>/>최종학력별</label>
							<label><input type="radio" name="gubun" value="04" <c:if test="${param.gubun eq '04'}">checked</c:if>/>관심분야별</label>
						</td>
					</tr>

				</tbody>
			</table>
		</div>
		<div class="btnSet tar">
			<a href="javaScript:searchSubmit();" class="btn btn-primary">검색</a>
		</div>
	</fieldset>
</form>

<div style="width:100%; padding:20px;">
    <canvas id="myChart"></canvas>
</div>

<script>
var ctx = document.getElementById("myChart").getContext('2d');

var gubun = "<c:out value='${param.gubun}'/>";

if (gubun == '01' || gubun == ''){
	var man = parseInt(<c:out value='${resultList[0].man}'/>);
	var woman = parseInt(<c:out value='${resultList[0].woman}'/>);
	var dataList = [man, woman];
	var labelList = ["남자", "여자"];
		var backgroundColorList = [
	        'rgba(255, 99, 132, 0.2)',
	        'rgba(54, 162, 235, 0.2)'
	    ];
	var borderColorList = [
        'rgba(255,99,132,1)',
        'rgba(54, 162, 235, 1)'
    ];
} else if (gubun == '02'){
	var age10 = parseInt(<c:out value='${resultList[0].age10}'/>);
	var age20 = parseInt(<c:out value='${resultList[0].age20}'/>);
	var age30 = parseInt(<c:out value='${resultList[0].age30}'/>);
	var age40 = parseInt(<c:out value='${resultList[0].age40}'/>);
	var age50 = parseInt(<c:out value='${resultList[0].age50}'/>);
	var dataList = [age10, age20, age30, age40, age50];
	var labelList = ["10대", "20대", "30대", "40대", "50대 이상"];
	var backgroundColorList = [
	        'rgba(255, 99, 132, 0.2)',
	        'rgba(54, 162, 235, 0.2)',
	        'rgba(255, 206, 86, 0.2)',
	        'rgba(75, 192, 192, 0.2)',
	        'rgba(153, 102, 255, 0.2)'
	    ];
	var borderColorList = [
        'rgba(255,99,132,1)',
        'rgba(54, 162, 235, 1)',
        'rgba(255, 206, 86, 1)',
        'rgba(75, 192, 192, 1)',
        'rgba(153, 102, 255, 1)'
    ];
} else if (gubun == '03'){
	var elementary = parseInt(<c:out value='${resultList[0].elementary}'/>);
	var middle = parseInt(<c:out value='${resultList[0].middle}'/>);
	var high = parseInt(<c:out value='${resultList[0].high}'/>);
	var university = parseInt(<c:out value='${resultList[0].university}'/>);
	var graduateSch = parseInt(<c:out value='${resultList[0].graduateSch}'/>);
	var dataList = [elementary, middle, high, university, graduateSch];
	var labelList = ["초등학교", "중학교","고등학교", "대학교", "대학원"];
	var backgroundColorList = [
	        'rgba(255, 99, 132, 0.2)',
	        'rgba(54, 162, 235, 0.2)',
	        'rgba(255, 206, 86, 0.2)',
	        'rgba(75, 192, 192, 0.2)',
	        'rgba(153, 102, 255, 0.2)'
	    ];
	var borderColorList = [
        'rgba(255,99,132,1)',
        'rgba(54, 162, 235, 1)',
        'rgba(255, 206, 86, 1)',
        'rgba(75, 192, 192, 1)',
        'rgba(153, 102, 255, 1)'
    ];
} else if (gubun == '04'){
	var inter01 = parseInt(<c:out value='${resultList[0].inter01}'/>);
	var inter02 = parseInt(<c:out value='${resultList[0].inter02}'/>);
	var inter03 = parseInt(<c:out value='${resultList[0].inter03}'/>);
	var inter04 = parseInt(<c:out value='${resultList[0].inter04}'/>);
	var inter05 = parseInt(<c:out value='${resultList[0].inter05}'/>);
	var inter06 = parseInt(<c:out value='${resultList[0].inter06}'/>);
	var inter07 = parseInt(<c:out value='${resultList[0].inter07}'/>);
	var inter08 = parseInt(<c:out value='${resultList[0].inter08}'/>);
	var inter09 = parseInt(<c:out value='${resultList[0].inter09}'/>);
	var inter10 = parseInt(<c:out value='${resultList[0].inter10}'/>);
	var inter11 = parseInt(<c:out value='${resultList[0].inter11}'/>);
	var inter12 = parseInt(<c:out value='${resultList[0].inter12}'/>);
	var inter13 = parseInt(<c:out value='${resultList[0].inter13}'/>);
	var inter14 = parseInt(<c:out value='${resultList[0].inter14}'/>);
	var inter15 = parseInt(<c:out value='${resultList[0].inter15}'/>);
	var dataList = [inter01, inter02, inter03, inter04, inter05, inter06, inter07, inter08, inter09, inter10, inter11, inter12, inter13, inter14, inter15];
	var labelList = ["스토리", "만화", "음악", "게임", "영화", "애니메이션", "방송", "공연", "캐릭터", "출판", "콘텐츠 솔루션", "지식정보", "광고", "융합콘텐츠", "기타"];
	var backgroundColorList = [
	        'rgba(255, 99, 132, 0.2)',
	        'rgba(54, 162, 235, 0.2)',
	        'rgba(255, 206, 86, 0.2)',
	        'rgba(75, 192, 192, 0.2)',
	        'rgba(153, 102, 255, 0.2)',
	        'rgba(255, 187, 0, 0.2)',
	        'rgba(255, 99, 132, 0.2)',
	        'rgba(54, 162, 235, 0.2)',
	        'rgba(255, 206, 86, 0.2)',
	        'rgba(75, 192, 192, 0.2)',
	        'rgba(153, 102, 255, 0.2)',
	        'rgba(255, 187, 0, 0.2)',
	        'rgba(255, 99, 132, 0.2)',
	        'rgba(54, 162, 235, 0.2)',
	        'rgba(255, 206, 86, 0.2)'
	    ];
	var borderColorList = [
        'rgba(255,99,132,1)',
        'rgba(54, 162, 235, 1)',
        'rgba(255, 206, 86, 1)',
        'rgba(75, 192, 192, 1)',
        'rgba(153, 102, 255, 1)',
        'rgba(255, 187, 0, 1)',
        'rgba(255,99,132,1)',
        'rgba(54, 162, 235, 1)',
        'rgba(255, 206, 86, 1)',
        'rgba(75, 192, 192, 1)',
        'rgba(153, 102, 255, 1)',
        'rgba(255, 187, 0, 1)',
        'rgba(255,99,132,1)',
        'rgba(54, 162, 235, 1)',
        'rgba(255, 206, 86, 1)'
    ];
}



var myChart = new Chart(ctx, {
 type: 'bar',
 data: {
     labels: labelList,
     datasets: [{
         label: '# of Votes',
         data: dataList,
         backgroundColor: backgroundColorList,
         borderColor: borderColorList,
         borderWidth: 1
     }]
 },
 options: {
     maintainAspectRatio: true,
     scales: {
         yAxes: [{
             ticks: {
                 beginAtZero:true
             }
         }]
     }
 }
});
</script>

<style>
	label{
		margin-left:10px;
	}
</style>