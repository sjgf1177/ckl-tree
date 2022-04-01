/*---------------------------------------------------------------------------
    Description   : 상단 검색
-----------------------------------------------------------------------------*/
function goTopSearch(){
	var searchKeyword=document.formTop.globalSch.value;
    searchKeyword = trim(searchKeyword);
  
   //검색어가 없을때
   if (searchKeyword == "") {
       alert("검색어가 입력되지 않았습니다.");
       document.formTop.globalSch.focus();
       return;
       //검색어가 있을때    
   }else{ 
	   document.formTop.searchQuery.value = document.formTop.globalSch.value;
	   document.formTop.submit();
   }
}
/*---------------------------------------------------------------------------
    Description   : 통합 검색
-----------------------------------------------------------------------------*/
function goSearch(){
	var searchKeyword=document.formSearch.searchQuery.value;
    searchKeyword = trim(searchKeyword);
  
   //검색어가 없을때
   if (searchKeyword == "") {
       alert("검색어가 입력되지 않았습니다.");
       document.formSearch.searchQuery.focus();
       return;
       //검색어가 있을때    
   }else{ 
	   document.formSearch.researchQuery.value = "";
	   document.formSearch.submit();
   }
}

/*---------------------------------------------------------------------------
Description   : 재 검색
-----------------------------------------------------------------------------*/
function goReSearch(){
	var mKeyword=document.formMove.searchQuery.value;
	mKeyword = trim(mKeyword);
    
    var sKeyword=document.formSearch.searchQuery.value;
    sKeyword = trim(sKeyword);
    
  //검색어가 없을때
	if (mKeyword == "" && sKeyword == "") {
		alert("검색어가 입력되지 않았습니다.");
	    document.formSearch.searchQuery.focus();
	    return;
	}else{
		
		var researchKeyword=document.formSearch.researchQuery.value;
		researchKeyword = trim(researchKeyword);	
		
		//검색어가 없을때
		if (researchKeyword == "") {
		   alert("재검색어가 입력되지 않았습니다.");
		   document.formSearch.researchQuery.focus();
		   return;
		   //검색어가 있을때    
		}else{ 
			
			if (sKeyword == "") {
				document.formSearch.searchQuery.value = document.formMove.searchQuery.value;
			}else{
				document.formSearch.allsearchQuery.value = document.formSearch.searchQuery.value;
			}
		    document.formSearch.submit();
		}
	}
	
}

/*---------------------------------------------------------------------------
    Description   : 인기/관련검색어 검색
-----------------------------------------------------------------------------*/
function goDirectSearch(keyword){
	var re = /[~!@\#$%^&*\()\=+|\\/:;?"<>']/gi;
	keyword = keyword.replace(re, "");

	document.formSearch.searchQuery.value = keyword;
	document.formSearch.searchCategory.value = "total";
	document.formSearch.submit();
	
}

/*---------------------------------------------------------------------------
    Description   : 상세 검색
-----------------------------------------------------------------------------*/
function goDetailSearch(){
	var searchKeyword=document.formDetail.searchQuery.value;
    searchKeyword = trim(searchKeyword);
  
   //검색어가 없을때
   if (searchKeyword == "") {
       alert("검색어가 입력되지 않았습니다.");
       return;
       //검색어가 있을때    
   }else{    
	   var start = document.formDetail.searchStartDate.value;
	   start = start.replace("-","");
	   var end = document.formDetail.searchEndDate.value;
	   end = end.replace("-","");
	   var period = document.formDetail.searchPeriod[3].checked;

	   if(period && start == "" && end == ""){
		   alert("기간이 선택되지 않았습니다.");
		   return;
	   }else{
		   if(start > end){
				alert("기간 설정이 잘못되었습니다.");
				return;
		   }else{
			   var crDate = new Date();
			   var preDate = new Date();

			   if(document.formDetail.searchPeriod[0].checked){
					document.formDetail.searchStartDate.value = "";
					document.formDetail.searchEndDate.value = "";
			   }else if(document.formDetail.searchPeriod[1].checked){
					preDate = preDate.setDate(crDate.getDate() - 7); 
					preDate = new Date(preDate);

					preDate = preDate.getFullYear() + "-" + (preDate.getMonth() + 1) + "-" + preDate.getDate();
					crDate = crDate.getFullYear() + "-" + (crDate.getMonth() + 1) + "-" + crDate.getDate();

					document.formDetail.searchStartDate.value = preDate;
					document.formDetail.searchEndDate.value = crDate;
			   }else if(document.formDetail.searchPeriod[2].checked){
					preDate = crDate.getFullYear() + "-" + (crDate.getMonth()) + "-" + crDate.getDate();
					crDate = crDate.getFullYear() + "-" + (crDate.getMonth() + 1) + "-" + crDate.getDate();

					document.formDetail.searchStartDate.value = preDate;
					document.formDetail.searchEndDate.value = crDate;
			   }
			   document.formDetail.submit();
		   }
	   }
   }
}

/*---------------------------------------------------------------------------
    Description   : 특수문자 제거
-----------------------------------------------------------------------------*/
function trim(str) {   
	return str.replace(/^\s+/,"");      
}

/*---------------------------------------------------------------------------
    Description   : 카테고리 셋팅
-----------------------------------------------------------------------------*/
function setCateGory(cate){
	document.formSearch.searchCategory.value = cate;
}

/*---------------------------------------------------------------------------
    Description   : 카테고리 이동
-----------------------------------------------------------------------------*/
function goCategory(cate){
	document.formMove.searchCategory.value = cate;
	document.formMove.PageNumber.value = 1;
	document.formMove.submit();
}


/*---------------------------------------------------------------------------
    Description   : 기간 셋팅
-----------------------------------------------------------------------------*/
function setPeriod(type){
	var crDate = new Date();
    var preDate = new Date();

	if(type == "week"){
		preDate = preDate.setDate(crDate.getDate() - 7); 
		preDate = new Date(preDate);

		preDate = preDate.getFullYear() + "-" + (preDate.getMonth() + 1) + "-" + preDate.getDate();
		crDate = crDate.getFullYear() + "-" + (crDate.getMonth() + 1) + "-" + crDate.getDate();

		document.formDetail.searchStartDate.value = preDate;
		document.formDetail.searchEndDate.value = crDate;
	}else if(type == "month"){
		preDate = crDate.getFullYear() + "-" + (crDate.getMonth()) + "-" + crDate.getDate();
		crDate = crDate.getFullYear() + "-" + (crDate.getMonth() + 1) + "-" + crDate.getDate();

		document.formDetail.searchStartDate.value = preDate;
		document.formDetail.searchEndDate.value = crDate;
	}else{
		document.formDetail.searchStartDate.value = "";
		document.formDetail.searchEndDate.value = "";

	}
}

/*---------------------------------------------------------------------------
    Description   : 정렬
-----------------------------------------------------------------------------*/
function goSort(sort){
	document.formMove.searchSort.value = sort;
	document.formMove.PageNumber.value = 1;
	document.formMove.submit();
}

/*---------------------------------------------------------------------------
    Description   : 페이지 네비게이션 이동
-----------------------------------------------------------------------------*/
function pageLink(tmp){
	document.formMove.PageNumber.value = tmp; 
	document.formMove.submit();
}