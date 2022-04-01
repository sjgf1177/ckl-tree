<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript" src="/js/zclip/jquery.zclip.js"></script>
<style>
	.posr{position: relative;}
</style>
<div class="posr">
	<div class="souceUrl" style="color:#f00">*/WEB-INF/jsp${empty includePage ? currMenu.contentsPath : includePage}</div>
	<div class="check" style="display: none">복사완료</div>
	<div class="souceUrl" style="color:#f00">WEB-INF/jsp${empty includePage ? currMenu.contentsPath : includePage}</div>
	<div class="check" style="display: none">복사완료</div>
	<script type="text/javascript">
		$(document).ready(function(){
		    $(".souceUrl").each(function () {
				$(this).zclip({
				    path: "/js/zclip/ZeroClipboard.swf",
				    copy:$(this).text(),
				    beforeCopy:function(){
				        $(this).css('background','yellow');
				        $(this).css('color','orange');
				    },
				    afterCopy:function(){
				        $(this).css('background','green');
				        $(this).css('color','purple');
				        $(this).next('.check').show();
				        // $(this).width('auto')
				    }
				});
		    })
		});
	</script>
</div>