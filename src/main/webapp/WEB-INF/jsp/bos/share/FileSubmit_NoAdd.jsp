<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:choose>
<c:when test="${boardVO.bbsId eq 'B0000268'}">
	<c:forEach var="x" begin="1" end="100">
		<div class="file_set">
			<input name="file_${x}" type="file" id="file_${x}" class="input_file" title="첨부파일 ${x}" />
			<a href="#" id="btn_file_del_${x}" class="btn_file_del"><img src="/health/images/common/btn_X.jpg" alt="삭제"/></a>
		</div>
	</c:forEach>
</c:when>
<c:otherwise>
	<c:forEach var="x" begin="1" end="5">
		<div class="file_set">
			<input name="file_${x}" type="file" id="file_${x}" class="input_file" title="첨부파일 ${x}" />
			<a href="#" id="btn_file_del_${x}" class="btn_file_del"><img src="/health/images/common/btn_X.jpg" alt="삭제"/></a>
		</div>
	</c:forEach>
</c:otherwise>
</c:choose>
<script type="text/javascript">
//<![CDATA[     
    var f=document.board;
	var file_number = 0;
	var fileCnt = '${fn:length(fileList)}';
	file_number = eval(fileCnt);

	$('.file_set:not(:first)').hide();
	$('.btnFileAdd').click(function() {
		if (f.bbsId.value == 'B0000268'){
			file_number+=1;
			$('.file_set:eq('+file_number+')').show();
		}else{
			if (file_number <4 ){
				file_number+=1;
				$('.file_set:eq('+file_number+')').show();
			}else{
				alert('첨부파일은 최대 5개입니다.');
			}
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
		  $('.input_fileText:eq('+index+')').text(f_name)
		});
	});
	$(".btn_file_del").click(function(){
		if( this.id == 'btn_file_del_0' ) return false;
		if( file_number >= 1 ){
			$('.file_set:eq('+file_number+')').hide();
			file_number = file_number -1;
			console.log(file_number);
		}
	});
//]]>
</script>