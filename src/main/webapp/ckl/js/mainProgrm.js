// JavaScript Document

window.onload = function () {
	mainProgrm('mainProgrm');
};

function mainProgrm(id, more, date) {
	var mainProgrm = document.getElementById(id);

	if( typeof( date ) !== 'undefined' ) {
		date = date.split('-');
		date[1] = date[1] - 1;
		date = new Date(date[0], date[1], date[2]);
	} else {
		var date = new Date();
	}
	var currentYear = date.getFullYear();
	var currentMonth = date.getMonth() + 1;
	var currentDate = date.getDate();

	var prevDate = ""; //이전달 출력.
	if(currentMonth != 1)
		prevDate = currentYear + '-' + ( currentMonth - 1 ) + '-' + currentDate;
	else
		prevDate = ( currentYear - 1 ) + '-' + 12 + '-' + currentDate; //만약 이번달이 1월이라면 1년 전 12월로 출력.

	var nextDate = ""; //다음달 출력.
	if(currentMonth != 12)
		nextDate = currentYear + '-' + ( currentMonth + 1 ) + '-' + currentDate;
	else
		nextDate = ( currentYear + 1 ) + '-' + 1 + '-' + currentDate; //만약 이번달이 12월이라면 1년 후 1월로 출력.

	var moreDate = currentYear + '-' + currentMonth + '-' + currentDate; //더보기 출력.

	var currentMonth2 = currentMonth;
	if( currentMonth2 < 10 ) currentMonth2 = '0' + currentMonth; //10월 이하라면 앞에 0을 붙여준다.

	var html = '';

	$.ajaxSetup({
		async: false
	});
	$.post(
		"/ckl/progrm/master/listCklMain.json",
		{year : currentYear, month : currentMonth2},
		function(data)
		{
			var cnt = data.progrmList.length;
			html += '<div class="proHeading">';
			html += '	<h2>이달의 프로그램 일정</h2>';
			html += '	<div class="calTitle">';
			html += '		<a class="prevMonth" href="#self" onclick="mainProgrm(\''+id+'\', \'\', \''+prevDate+'\')"><span class="sr-only">이전달 보기</span></a>';
			html += '		<h3 class="nowMonth">'+currentYear+'.'+currentMonth2+'</h3>';
			html += '		<a class="nextMonth" href="#self" onclick="mainProgrm(\''+id+'\', \'\', \''+nextDate+'\')"><span class="sr-only">다음달 보기</span></a>';
			html += '	</div>';
			html += '	<div class="todayTitle tar">';
			//html += '		<span class="todayIs fl">'+nowYear+'.'+nowMonth+'.'+nowDay+'</span>';
			html += '		총 <strong>'+cnt+'</strong> 건의 일정이 있습니다.';
			html += '	</div>';
			//html += '	<div class="more"></div>';
			html += '</div>';
			html += '<div class="schejuleList">';

			var num = 3;
			if (more == "Y") num = 999;
			if (cnt == 0) {
				html += '<div class=\"schejuleInner\"> <strong class=\"title\">등록된 일정이 없습니다.</strong><br />창의인재 육성과 스타트업 지원을 위해<br />다양한 프로그램을 준비중입니다. </div>';
			};

			if (cnt > 0) {
				html += '	<ul>';

				$.each(data.progrmList, function(i, item) {
					if (item.rnum <= num) {
						var menuNo = "200024";
						if (item.prgCl == "31") menuNo = "200028";

						html += '	<li>';
						html += '		<span class="date '+item.today+'">'+item.day+'</span>';
						html += '		<dl>';
						html += '			<a href="/ckl/progrm/master/view.do?prgSn='+item.prgSn+'&amp;menuNo='+menuNo+'&amp;prgSe='+item.prgSe+'&amp;prgCl='+item.prgCl+'">';
						html += '				<dt>'+item.prgClNm+'</dt>';
						html += '				<dd class="perDay"><strong>'+item.reqstBeginDt+' ~ '+item.reqstEndDt+'</strong></dd>';
						html += '				<dd class="schejuleDesc">'+item.prgNm+' </dd>';
						html += '			</a>';
						html += '		</dl>';
						html += '		<span class="arrLefts"></span>';
						html += '	</li>';
					}
				});

				html += '	</ul>';
			}

			html += '</div>';

			if (cnt > 3 && num == 3) {
				html += '<div class="listMore clearfix">';
				html += '	<a href="#self" onclick="mainProgrm(\''+id+'\', \'Y\', \''+moreDate+'\')"><span class="icoMore"></span> 더보기</a>';
				html += '</div>';
			}
			html += '<div class="posa">';
			html += '	<a href="/ckl/progrm/master/list.do?prgSe=03&prgCl=30&menuNo=200024"><strong>창작지원 프로그램</strong> 바로가기<span class="mainIcos icoArrB"></span></a>';
			html += '</div>';
		},"json"
	);

	mainProgrm.innerHTML = html;
}
