
	var time;
	$(function() {

		$("#down").hide();
		
		var options = {
				beforeSubmit: readyForSubmit,
				success: responseCtl,
				dataType: "xml"
		};
		$("form[id^=pbFrm]").ajaxForm(options);
	
	});

	function readyForSubmit(formData, jqForm, options){

		var form = $("#pbFrm")[0];
		if( !form.datafile.value ){
			alert("첨부파일을 선택하세요.");
			return;
		}
		

		$("#fileDownNum").html("0%");
		 $("#fileDown").attr("style", "width:0%");
		$("#down").show();
		time = setInterval(function(){
			$.get("/bos/bbs/uploadFile.progress",{}, function showProgress(data){
				console.log("data : " + data);
				 var _data = data.split("/");
				 if( _data[0] && _data[1] ){
					 var percent = Math.round(_data[0] / _data[1] * 100);
					 console.log("percent : " + percent);
					 $("#fileDown").attr("style", "width:"+percent+"%");
					 $("#fileDownNum").html(percent+"%");
				 }
			});
		}, 200);
	}
	
	function responseCtl(data){
		clearInterval(time);
		var orignlFileNm = $(data).find("orignlFileNm").text();
		var fileMg = $(data).find("fileMg").text();
		var atchFileId = $(data).find("atchFileId").text();
		var fileSn = $(data).find("fileSn").text();
		var sortOrdr = $(data).find("sortOrdr").text();
		if( !sortOrdr ) sortOrdr = "0";
		var bbsId = $(data).find("bbsId").text();
		var url = "/bos/cmm/fms/FileDown?atchFileId="+atchFileId+"&amp;fileSn="+fileSn;
		if( bbsId ){
			url += "&bbsId="+bbsId;
		}
		var htmlData = 
			"<tr id=\"tr_"+sortOrdr+"_"+fileSn+"\">"+
			"<th scope=\"row\"><label for=\"nttType\">파일첨부</label></th>" +
			"<td colspan=\"3\" class=\"output\">" +
			"<a  id=\"linkA_"+fileSn+"\"  href=\""+url+"\">" +
				orignlFileNm+"&nbsp;["+fileMg+"&nbsp;byte]" +
			"</a>" +
			"<a href=\"javascript:deleteFile('"+atchFileId+"','"+fileSn+"','"+sortOrdr+"','"+bbsId+"');\">" +
				"<img src=\"/images/egovframework/cmm/fms/icon/bu5_close.gif\" />" +
			"</a><input type=\"button\" id=\"btnCopy_"+fileSn+"\" value=\"경로복사\" />";
		htmlData += 
			"</td>" +
		"</tr>";
		$("#tbl"+sortOrdr+" tr:last").after(htmlData);
		
		$("#atchFileId"+sortOrdr).val(atchFileId);
		$("#_atchFileId"+sortOrdr).val(atchFileId);

		$("#fileDown").attr("style", "width:100%");
		 $("#fileDownNum").html("100%");
		$("#down").hide();
	}

	function deleteFile(_atchFileId, _fileSn, sortOrdr, bbsId)
	{
		$.getJSON( 
			"/bos/cmm/fms/deleteFileInfs.json",
			{atchFileId : _atchFileId, fileSn : _fileSn, bbsId : bbsId},
			function(data){
				var jdata = data.resultCode;
				if( jdata == "error" ){
					alert("상태변경에 실패하였습니다.");
				}
				else{
					alert("성공적으로 삭제되였습니다.");
					$("#tr_"+sortOrdr+"_"+_fileSn).remove();
				}
			}
		);
	}
