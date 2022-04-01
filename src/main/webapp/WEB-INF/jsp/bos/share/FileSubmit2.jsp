<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class=br><a class="btn btn-inverse btnFileAdd2" href="#"><span>첨부파일추가</span></a></div>
<div class="fl">
	<c:forEach var="x" begin="1" end="5">
		<div class="file_set2">
			<input name="file2_${x}" type="file" id="file2_${x}" class="input_file2" title="첨부파일 ${x}" />
			<a href="#contents" id="btn_file_del2_${x}" class="btn_file_del"><img src="/bos/images/btn_X.jpg" alt="삭제"/></a>
		</div>
	</c:forEach>
</div>
<br /><br />
<script type="text/javascript">
//<![CDATA[
    var f=document.board;
	var file2_number = 0;
	var fileCnt = '0';
	file2_number = eval(fileCnt);

	$('.file_set2:not(:first)').hide();
	$('.btnFileAdd2').click(function() {
			if (file2_number <4 ){
				file2_number+=1;
				$('.file_set2:eq('+file2_number+')').show();
			}else{
				alert('첨부파일은 최대 5개입니다.');
			}
	  return false;
	});
	$('.btnFileSearch').each(function(index) {
		$(this).click(function() {
		  $('.input_file2')[index].click();
		  return false;
		});
	});
	$('.input_file2').each(function(index) {
		$(this).change(function() {
			val = $(this).val().split("\\");
	    f_name = val[val.length-1];
		  $('.input_fileText:eq('+index+')').text(f_name);
		});
	});
	$(".btn_file_del2").click(function(){
		if( this.id == 'btn_file_del2_0' ) return false;
		if( file2_number >= 0 ){
			$(".input_file2").val('');
			if( file2_number >= 1 ){
				$('.file_set2:eq('+file2_number+')').remove();
			file2_number = file2_number -1;
			console.log(file2_number);
			}
		}
	});
//]]>
</script>