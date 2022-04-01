/** 팝업 */
$(function(){	
	$(".layer_close_btn").on("click", function(){
        $(".layer_box").css('display','none');
        $("html").css('overflow-y','scroll');
        
        location.reload();
        
        return false;
    });
	
	$(".btn-add").on("click", function(){
	    $("#cdNm").val("");
	    $("#ordr").val("");
	    $("#rady").prop('checked', true);
	    
	    $(".btn_mode_ins").css('display','block');
	    $(".btn_mode_upt").css('display','none'); 
	    
	    setMaxResult($("#cdId").val());
	});
	
	$(".btn-Ins").on("click", function(){
		if (!checkField("cdNm")) {
			alert("설문보기명을 입력하세요.");
			$("#cdNm").focus();
			return;
		}
		
		if (!checkField("ordr")) {
			alert("정렬순서를 입력하세요.");
			$("#ordr").focus();
			return;
		}
		
		if (confirm("저장하시겠습니까?")) {
			$.ajax({
				type:"POST",
				url:"/bos/progrm/master/insertCodeDetail.json",
				data:{
						"codeId" 	:	$("#cdId").val()
					 , 	"code" 	 	:	$("#p_code").val()
					 , 	"codeNm" 	:	$("#cdNm").val()
					 , 	"useAt"  	:	$('input[name="radUse"]:checked').val()
				     ,  "upperCode" : 	0
				     ,  "sortOrdr" 	: 	$("#ordr").val()
				     ,  "sort" 		: 	$("#p_sort").val()
				     ,  "depth" 	: 	1
					 },
				dataType:"JSON",
				success:function(data){
					alert("저장되었습니다.");
				    $("#cdNm").val("");
				    $("#ordr").val("");
				    $("#rady").prop('checked', true);					
					setList($("#cdId").val());
					setMaxResult($("#cdId").val());
				},
				error:function(){
					alert("서버와 통신 실패");
				}
			});
		}
	});
	
	$(".btn-Upt").on("click", function(){
		if (!checkField("cdNm")) {
			alert("설문보기명을 입력하세요.");
			$("#cdNm").focus();
			return;
		}
		
		if (!checkField("ordr")) {
			alert("정렬순서를 입력하세요.");
			$("#ordr").focus();
			return;
		}
		
		if (confirm("수정하시겠습니까?")) {
			$.ajax({
				type:"POST",
				url:"/bos/progrm/master/updateCodeDetail.json",
				data:{
						"codeId" 	:	$("#cdId").val()
					 , 	"code" 	 	:	$("#p_code").val()
					 , 	"codeNm" 	:	$("#cdNm").val()
					 , 	"useAt"  	:	$('input[name="radUse"]:checked').val()
				     ,  "upperCode" : 	0
				     ,  "sortOrdr" 	: 	$("#ordr").val()
				     ,  "sort" 		: 	$("#p_sort").val()
				     ,  "depth" 	: 	1
					 },
				dataType:"JSON",
				success:function(data){
					alert("수정되었습니다.");
				    $("#cdNm").val("");
				    $("#ordr").val("");
				    $("#rady").prop('checked', true);					
					setList($("#cdId").val());
					setMaxResult($("#cdId").val());
				},
				error:function(){
					alert("서버와 통신 실패");
				}
			});
		}
	});
	
	$(".btn-Del").on("click", function(){
		if (confirm("삭제하시겠습니까?")) {
			$.ajax({
				type:"POST",
				url:"/bos/progrm/master/deleteCodeDetail.json",
				data:{
						"codeId" 	:	$("#cdId").val()
					 , 	"code" 	 	:	$("#p_code").val()
					 ,  "sortOrdr"	:	$("#p_sort").val()
					 },
				dataType:"JSON",
				success:function(data){
					alert("삭제되었습니다.");
				    $("#cdNm").val("");
				    $("#ordr").val("");
				    $("#rady").prop('checked', true);					
					setList($("#cdId").val());
					setMaxResult($("#cdId").val());
				},
				error:function(){
					alert("서버와 통신 실패");
				}
			});
		}
	});
});

function codePopOpen(cd, idx){
	$(".layer_box").css('display','block');
    $("html").css('overflow-y','hidden');
    
    $(".pup_box .pup_title_txt").text("[설문명] " + $("#iemNm" + idx).text());	 
    
    $("#cdNm").val("");
    $("#ordr").val("");
    $("#rady").prop('checked', true);
    
    setList(cd);
	setMaxResult(cd);
}

function setList(cd){
	var itemTr = "";
    
	$.ajax({
		type:"POST",
		url:"/bos/progrm/master/ajaxCodeDetailList.json",
		data:{"codeId":cd},
		dataType:"JSON",
		success:function(data){
     		$.each(data.codeDetailList, function(idx, item) {
     			if(item.codeNm != ""){
	     			itemTr += "<tr style='cursor:pointer' onclick='ontable($(this))'>";
	     			itemTr += "	<td class='td1'>" + (idx + 1) + "</td>";
	     			itemTr += "	<td class='td2'>" + item.codeNm + "</td>";
	     			itemTr += "	<td class='td3'>" + item.sortOrdr + "</td>";
	     			
	     			if(item.useAt == 'Y'){
	     				itemTr += "	<td class='td4'>사용</td>";
	     			}else{
	     				itemTr += "	<td class='td4'>미사용</td>";
	     			}
	     			
	     			itemTr += "	<td class='tdx'>" + item.codeId + "</td>";
	     			itemTr += "	<td class='tdx'>" + item.code + "</td>";
	     			
	     			itemTr += "</tr>";
     			}
        	});
     		
     		$("#itemTr").empty();
     		$("#itemTr").append(itemTr);
     		$("#cdId").val(cd);
		},
		error:function(){
			alert("서버와 통신 실패");
		}
	}); 
}

function setMaxResult(cd){
	$.ajax({
		type:"POST",
		url:"/bos/progrm/master/ajaxMaxCode.json",
		data:{"codeId":cd},
		dataType:"JSON",
		success:function(data){
			if(data.maxCode != null){
				$("#p_code").val(cd + data.maxCode.code);
				$("#p_sort").val(data.maxCode.sort);
				$("#ordr").val(data.maxCode.sort);
			}
		},
		error:function(){
			alert("서버와 통신 실패");
		}
	});
}

// 테이블  click시 해당 테이블 색상부여 및 데이터 출력
function ontable($this){
	$(".hover_table table tr").css('background-color','');
	$this.css('background-color','#E6E6E6');
	
	var tr = $this;
	var td = tr.children();
	var tdArr = new Array();
	
	td.each(function(i){
		tdArr.push(td.eq(i).text());
	});
	
    $("#cdNm").val(tdArr[1]);
    $("#ordr").val(tdArr[2]);
	$("#p_code").val(tdArr[5]);
	$("#p_sort").val(tdArr[2]);
    
    if(tdArr[3] == '사용'){
    	$("#rady").prop('checked', true);
    }else{
    	$("#radn").prop('checked', true);
    }
    
    $(".btn_mode_ins").css('display','none');
    $(".btn_mode_upt").css('display','block');
}
