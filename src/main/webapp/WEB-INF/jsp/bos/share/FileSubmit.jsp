<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="fileAddSet row">
	<c:if test="${param.menuNo ne '100081'}">
		<div class="col-sm-2 board_util_btn_con left"><a class="btn_style_0 full small btnFileAdd" href="#">첨부파일추가</a></div>
	</c:if>
	<div class="col-sm-10">
		<c:forEach var="x" begin="1" end="5">
			<div class="file_set">
				<div class="form-inline board_util_btn_con">
					<input name="file_${x}" type="file" id="file_${x}" class="input_file form-control" title="첨부파일 ${x}" style="width:100%; max-width:500px; height:calc(2.25rem + 7px);"/>
					<a href="#contents" id="btn_file_del_${x}" class="btn_style_0 full small btn_file_del" style="margin-top:2px !important; margin-bottom:5px;">첨부파일 삭제</a>
				</div>
				<%-- 이미지설명 : <input type="text" id="file_${x}_cn" name="file_${x}_cn" title="첨부파일 ${x} 설명" class="Input_file_infor"/> --%>
			</div>
		</c:forEach>
	</div>
</div>
<script type="text/javascript">
//<![CDATA[
    var f=document.board;
	var file_number = 0;
	var fileCnt = '0';
	//file_number = eval(fileCnt);

	$('.file_set:not(:first)').hide();
	$('.btnFileAdd').click(function() {
		if (file_number < 4) {
			file_number+=1;
			$('.file_set:eq('+file_number+')').show();
		}
		else {
			alert('첨부파일은 최대 5개입니다.');
		}
	  return false;
	});
	$('.btnFileSearch').each(function(index) {
		$(this).click(function() {
		  $('.input_file')[index].click();
		  return false;
		});
	});
	$('.input_file').each(function(index) {
		$(this).change(function() {
			val = $(this).val().split("\\");
	    	f_name = val[val.length-1];
		  	$('.input_fileText:eq('+index+')').text(f_name);
		});
	});
	$(".btn_file_del").click(function(){
		if (this.id == 'btn_file_del_0') return false;
		if (file_number == 0) {
			$(this).closest("div.form-inline").find("input[type=file]").val("");
		}
		else if (file_number >= 1) {
			//$(".input_file").val('');
			if (file_number >= 1) {
				$('.file_set:eq('+file_number+')').remove();
				file_number = file_number -1;
				console.log(file_number);
			}
		}
	});
//]]>
</script>