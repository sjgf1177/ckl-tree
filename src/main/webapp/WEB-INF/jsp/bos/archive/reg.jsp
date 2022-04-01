<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="egovframework.com.cmm.service.FileVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>

<c:forEach var="fileList" items="${fileList}" varStatus="status">
	<c:if test="${fileList.fileFieldName eq 'file1' }">
		<c:set var="fileVO" value="${fileList }"/>
	</c:if>
</c:forEach>

<!-- 이미지 validation 체크 위한 세팅 -->
<c:set var="action" value="" />
<c:set var="actTp" value="" />
<c:if test="${empty result}">
	<c:set var="actTp" value="insert" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="actTp" value="update" />
</c:if>
<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript">

	var actTp = "<c:out value="${actTp}" />";

	$(function() {
		
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$("#bgnde").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
		$("#endde").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	
		$("#chkAll").click(function(){
			if(this.checked)
				$(":checkbox").attr("checked", true);
			else
				$(":checkbox").attr("checked", false);
		});
	});

	
	// 필수값 체크
	function checkAndSubmit() {
		
		var contentLength = $('#organNm').val().length;

		if(contentLength > 50){
			alert('주관기관명은 50자까지 입력 할 수 있습니다.');
		return;
		}

		var form = $("#fm")[0];
		var f    = document.fm; 
		var v    = new MiyaValidator(form);
		
		v.add("taskNm"       , {required: true});
		v.add("organNm"      , {required: true});
		/* v.add("taskSummary"  , {required: true}); */
		v.add("year"         , {required: true});
		v.add("workField"    , {required: true});
		
		/* insert 시에만 이미지 삽입 체크 */
		/* 과제 썸네일 이미지 벨리데이션 체크 잠시 주석처리
		if ( actTp == "insert" && $("#taskThumbnail").length > 0 ){
			v.add("taskThumbnail", {
				required : true
			});
		} 
		 */
		v.add("archiveField1", {required: true});
		
		/* 분야 2, 3 잠시 주석처리
		v.add("archiveField2", {required: true});
		v.add("archiveField3", {required: true});
		*/
		
		result = v.validate();
		
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}
		
		var $usrtAt= $("input[type=radio][name=useAt]:checked").val();
		
		$("#publish").val($usrtAt); 
	
		if (!confirm("${empty result ? '등록' : '수정'}하시겠습니까?")) {
		    return;
		}
		var cont = CrossEditor.GetBodyValue();
		document.getElementById("taskSummary").value= cont;
		form.submit();
	
		// 
		function delFile(atchFileId, fileSn){
			
			if (!confirm('삭제 하시겠습니까?')) {
				return false;
			}
			
			$.getJSON(
				"/bos/cmm/fms/deleteFileInfs.json",
				{atchFileId : atchFileId, fileSn : fileSn},
				function(data)
				{
					var jdata = data.resultCode;
		            if( jdata == 'success' ) {
		            	alert("성공적으로 삭제하였습니다.");
		            	location.reload();
		            	//$("#realfile_"+fileSn).html("");
		            }
		            else alert("삭제에 실패하였습니다.");
				}
			);
		}
	}

</script>

<c:set var="action" value="${empty result ? '/bos/archive/insert.do' : '/bos/archive/update.do'}" />

<form id="fm" name="fm" method="post" action="${action}" enctype="multipart/form-data">
	<input type="hidden" name="menuNo"        id="menuNo"        value="${param.menuNo}" />
	<input type="hidden" name="publish"       id="publish"       value="" />
	<input type="hidden" name="atchFileId"    id="atchFileId"    value="${result.atchFileId}">
	 <input type="hidden" name="pageIndex"  id="pageIndex"  value="<c:out value='${param.pageIndex }' />" />
	 
	<c:if test="${not empty result}">
		<input type="hidden" name="archiveTaskSeq" value="${result.archiveTaskSeq}" />
	</c:if>
	<input type="hidden" name="lastUpdusrId" value="${user.userId}" />
	<div class="bdView">
		<table>
			<caption>과제 수정/등록</caption>
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="35%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="option1">*연도</label></th>
					
					<td>
						<select id="year" name="year" title="연도" style="width:100px" class="required">
					    	<option value="" <c:if test="${result.year eq ''}">selected</c:if>>선택</option>
						    
						    <!-- 현재년도를 가져온다 -->
						    <c:set var="today" value="<%=new java.util.Date()%>" />
						    <!-- 형병환 : date to String -->
						    <fmt:formatDate value="${today}" pattern="yyyy" var="nowY"/> 
						    <!-- 시작년도  -->
					        <c:set var="sYear" value="${nowY - 3}" />
					        <!-- 반복문 개수 -->
					        <c:set var="endNum" value="${nowY + 3 - sYear}" />
						   <!-- 년도를 노출시킨다. -->
						    <c:forEach var="i" begin="0" end="${endNum}">
						    	<c:set var="yearOption" value="${sYear + i}" />
						    	<option value="${yearOption}" <c:if test="${result.year eq yearOption}">selected</c:if>>${yearOption}</option>
							</c:forEach>
							
						</select>
					</td>
					
					<th scope="row"><label for="option2">*사업구분</label></th>
					<td>
						<select id="workField" name="workField" title="사업구분" style="width:120px">
					 		<option value="" <c:if test="${result.workField eq ''}">selected</c:if>>선택</option>
					   		<option value="1" <c:if test="${result.workField eq '1'}">selected</c:if>>창의인재동반</option>
					    	<option value="2" <c:if test="${result.workField eq '2'}">selected</c:if>>실감콘텐츠창작</option>
					    	<option value="3" <c:if test="${result.workField eq '3'}">selected</c:if>>콘텐츠원캠퍼스</option>
					    	<option value="4" <c:if test="${result.workField eq '4'}">selected</c:if>>콘텐츠임팩트</option>
					    	<option value="5" <c:if test="${result.workField eq '5'}">selected</c:if>>AI연계콘텐츠창작</option>
						</select>
					</td>
				</tr>
		
				<tr>
					<th scope="row"><label for="organNm">*주관기관명</label></th>
					<td class="output" colspan="3">
						<input type="text" id="organNm" name="organNm" value="${result.organNm}" style="width:500px" class="board1" required="required"/>
					</td>
				</tr>
		
				<tr>
					<th scope="row"><label for="taskNm">*과제명</label></th>
					<td class="output" colspan="3" required>
						<input type="text" id="taskNm" name="taskNm" value="${result.taskNm}" style="width:500px" class="board1" required />
					</td>
				</tr>
				
				<tr>
					<th scope="row" rowspan="3"><label for="option3" >*분야</label></th>
					<td colspan="3">
						<select id="archiveField1" name="archiveField1" title="분야1">
					 		<option value="" <c:if test="${result.archiveField1 eq ''}">selected</c:if>>선택</option>
					   		<option value="1" <c:if test="${result.archiveField1 eq '1'}">selected</c:if>>영화</option>
					    	<option value="2" <c:if test="${result.archiveField1 eq '2'}">selected</c:if>>애니메이션</option>
					    	<option value="3" <c:if test="${result.archiveField1 eq '3'}">selected</c:if>>음악</option>
					    	<option value="4" <c:if test="${result.archiveField1 eq '4'}">selected</c:if>>게임</option>
					    	<option value="5" <c:if test="${result.archiveField1 eq '5'}">selected</c:if>>캐릭터</option>
					    	<option value="6" <c:if test="${result.archiveField1 eq '6'}">selected</c:if>>만화/웹툰</option>
					    	<option value="7" <c:if test="${result.archiveField1 eq '7'}">selected</c:if>>출판/웹소설</option>
					    	<option value="8" <c:if test="${result.archiveField1 eq '8'}">selected</c:if>>방송/영상</option>
					    	<option value="9" <c:if test="${result.archiveField1 eq '9'}">selected</c:if>>스토리</option>
					    	<option value="10" <c:if test="${result.archiveField1 eq '10'}">selected</c:if>>공연</option>
					    	<option value="11" <c:if test="${result.archiveField1 eq '11'}">selected</c:if>>VR · AR</option>
					    	<option value="12" <c:if test="${result.archiveField1 eq '12'}">selected</c:if>>인공지능</option>
					    	<c:choose>
					    		<c:when test="${result.archiveField1 eq '13'}">
					    			<option value="13" selected >기타(입력)</option>
									<input type="text" style="margin-left:10px;" id="archiveFieldEtc1" name="archiveFieldEtc1" value="${result.archiveFieldEtc1}" />
					    		</c:when>
 								<c:otherwise>
					    			<option value="13" <c:if test="${result.archiveField1 eq '13'}">selected</c:if>>기타(입력)</option>
					    			<input type="text" style="margin-left:10px;" id="archiveFieldEtc1" name="archiveFieldEtc1"/>
					    		</c:otherwise>
					    	</c:choose>	
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<select id="archiveField2" name="archiveField2" title="분야2" >
					 		<option value="" <c:if test="${result.archiveField2 eq ''}">selected</c:if>>선택</option>
					   		<option value="1" <c:if test="${result.archiveField2 eq '1'}">selected</c:if>>영화</option>
					    	<option value="2" <c:if test="${result.archiveField2 eq '2'}">selected</c:if>>애니메이션</option>
					    	<option value="3" <c:if test="${result.archiveField2 eq '3'}">selected</c:if>>음악</option>
					    	<option value="4" <c:if test="${result.archiveField2 eq '4'}">selected</c:if>>게임</option>
					    	<option value="5" <c:if test="${result.archiveField2 eq '5'}">selected</c:if>>캐릭터</option>
					    	<option value="6" <c:if test="${result.archiveField2 eq '6'}">selected</c:if>>만화/웹툰</option>
					    	<option value="7" <c:if test="${result.archiveField2 eq '7'}">selected</c:if>>출판/웹소설</option>
					    	<option value="8" <c:if test="${result.archiveField2 eq '8'}">selected</c:if>>방송/영상</option>
					    	<option value="9" <c:if test="${result.archiveField2 eq '9'}">selected</c:if>>스토리</option>
					    	<option value="10" <c:if test="${result.archiveField2 eq '10'}">selected</c:if>>공연</option>
					    	<option value="11" <c:if test="${result.archiveField2 eq '11'}">selected</c:if>>VR · AR</option>
					    	<option value="12" <c:if test="${result.archiveField2 eq '12'}">selected</c:if>>인공지능</option>
					    	 <c:choose>
					    		<c:when test="${result.archiveField2 eq '13'}">
					    			<option value="13" selected >기타(입력)</option>
									<input type="text" style="margin-left:10px;" id="archiveFieldEtc2" name="archiveFieldEtc2" value="${result.archiveFieldEtc2}" />
					    		</c:when>
					    		<c:otherwise>
					    			<option value="13" <c:if test="${result.archiveField2 eq '13'}">selected</c:if>>기타(입력)</option>
					    			<input type="text" style="margin-left:10px;" id="archiveFieldEtc2" name="archiveFieldEtc2"/>
					    		</c:otherwise>
					    	</c:choose>	 
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<select id="archiveField3" name="archiveField3" title="분야3">
					 		<option value="" <c:if test="${result.archiveField3 eq ''}">selected</c:if>>선택</option>
					   		<option value="1" <c:if test="${result.archiveField3 eq '1'}">selected</c:if>>영화</option>
					    	<option value="2" <c:if test="${result.archiveField3 eq '2'}">selected</c:if>>애니메이션</option>
					    	<option value="3" <c:if test="${result.archiveField3 eq '3'}">selected</c:if>>음악</option>
					    	<option value="4" <c:if test="${result.archiveField3 eq '4'}">selected</c:if>>게임</option>
					    	<option value="5" <c:if test="${result.archiveField3 eq '5'}">selected</c:if>>캐릭터</option>
					    	<option value="6" <c:if test="${result.archiveField3 eq '6'}">selected</c:if>>만화/웹툰</option>
					    	<option value="7" <c:if test="${result.archiveField3 eq '7'}">selected</c:if>>출판/웹소설</option>
					    	<option value="8" <c:if test="${result.archiveField3 eq '8'}">selected</c:if>>방송/영상</option>
					    	<option value="9" <c:if test="${result.archiveField3 eq '9'}">selected</c:if>>스토리</option>
					    	<option value="10" <c:if test="${result.archiveField3 eq '10'}">selected</c:if>>공연</option>
					    	<option value="11" <c:if test="${result.archiveField3 eq '11'}">selected</c:if>>VR · AR</option>
					    	<option value="12" <c:if test="${result.archiveField3 eq '12'}">selected</c:if>>인공지능</option>
					    	<c:choose>
					    		<c:when test="${result.archiveField3 eq '13'}">
					    			<option value="13" selected >기타(입력)</option>
									<input type="text" style="margin-left:10px;" id="archiveFieldEtc3" name="archiveFieldEtc3" value="${result.archiveFieldEtc3}" />
					    		</c:when>
					    		<c:otherwise>
					    			<option value="13" <c:if test="${result.archiveField3 eq '13'}">selected</c:if>>기타(입력)</option>
					    			<input type="text" style="margin-left:10px;" id="archiveFieldEtc3" name="archiveFieldEtc3"/>
					    		</c:otherwise>
					    	</c:choose>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row" class="con_tit"><label for="taskSummary">*과제 개요</label></th>
					<td class="outputEditor" colspan="3">
						<span style="color:red;">* 아래의 작성하시는 내용 (첨부파일 포함)중에 개인정보에 관한 내용이 있다면 개인정보가 타인에게 노출되어 침해 받을 수 있으므로 삭제 후 등록하여 주시기 바랍니다.
						(개인정보내용 : 주민등록번호, 계좌번호, 핸드폰번호 등)
						</span><br/>
						<textarea id="taskSummary" name="taskSummary" cols="150" rows="30" style="display:none;" class="textarea">${result.taskSummary}</textarea>
						<script type="text/javascript">
						//<![CDATA[
							var CrossEditor = new NamoSE("crosseditor");
							CrossEditor.params.Font = {"Nanum Gothic":"나눔고딕", "Dotum":"돋움", "Gulim":"굴림", "Batang":"바탕", "Gungsuh":"궁서"};
							CrossEditor.EditorStart();

							var contentValue = document.getElementById("taskSummary").value; // Hidden 값 참조
							function OnInitCompleted(){

								//contentValue = contentValue.replace(/#script#/gi, "script");
								CrossEditor.SetBodyValue(contentValue); // 컨텐츠 내용 에디터 삽입
							}
						//]]>
						</script>
					</td>
				</tr>
				<tr>
					<th scope="row">*과제 썸네일</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType"      value="img"/>
							<c:param name="fileFieldName" value="taskThumbnail"/>
							<c:param name="updateFlag"    value="Y"/>
						</c:import>
						<input type="file" name="taskThumbnail" id="taskThumbnail" title="과제 썸네일" class="col-md-8">
						<br/><br/>※ 올리시는 파일명을 모두 다르게 입력하여 주십시오.※
					</td>
				</tr>
				
				<tr>
					<th scope="row">*사용 여부</th>
					<td class="output" colspan="3">
						<input type="radio" id="useAt1" name="useAt" value="Y" class="ra" <c:if test="${result.useAt eq 'Y'}">checked</c:if> /> 사용
						<label for="publish_N">
							<input type="radio" id="useAt2" name="useAt" value="N" class="ra" <c:if test="${empty result or result.useAt eq 'N'}">checked</c:if> /> 미사용
						</label>
					</td>
				</tr> 
				
				<c:if test="${not empty result}">
				<tr>
					<th scope="row">등록자</th>
					<td>${result.userNm}</td>
					<th scope="row">등록일</th>
					<td>${result.firstDate}</td>
				</tr>
				</c:if>
				
			</tbody>
		</table>
	</div>
</form>

<div class="btn_set">
	<c:choose>
		<c:when test="${empty result}" >
			<a class="btn btn-primary" href="javascript:checkAndSubmit();"><span>등록</span></a>
		</c:when>
		
		<c:otherwise>
			<a class="btn btn-info"  href="javascript:checkAndSubmit();"><span>수정</span></a>
		<a href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');" class="btn btn-danger">삭제</a>
		</c:otherwise>
	</c:choose>
	<c:url value="/bos/archive/list.do?menuNo=${param.menuNo}" var="list_url" />
	<a class="btn btn-primary" href="${list_url}"><span>목록</span></a>
</div>

<script>
	// 과제일련번호 : 등록인지, 수정인지 확인을 위한 값
	var v_taskSeq = "${paramVO.taskSeq}";

	function del(){
		var count = "${param.projectCnt}";
		if(count == '0'){
			var form = $("#fm")[0];
			form.action = "/bos/archive/delete.do";
			form.submit(); 
		}else{
			alert("프로젝트가 등록 되어있습니다.");
			return;
		}
	}

	// 분야 select box 설정
	$(function(){
		
		// 1. 등록 화면 - 분야 inputBox를 비활성화한다.
		if(v_taskSeq == '' || v_taskSeq == null){
			// 입력박스 숨어있다가
			$("#archiveFieldEtc1").hide();
			$("#archiveFieldEtc2").hide();
			$("#archiveFieldEtc3").hide();			
		} else {
			
		// 2. 수정 화면 - 분야 inputBox는 선택 값이 기타가 아닐경우 비활성환다.
			if($("#archiveField1").val() != '13') {
				$("#archiveFieldEtc1").hide();
	        }
			if($("#archiveField2").val() != '13') {
				$("#archiveFieldEtc2").hide();
	        }
			if($("#archiveField3").val() != '13') {
				$("#archiveFieldEtc3").hide();
	        }
		}
		
		// 3-1. 분야1 선택 값이 바뀔때마다 inpuBox 활성/비활성 한다.
		$("#archiveField1").change(function() {
			// 기타를 선택하면 등장
	        if($("#archiveField1").val() == '13') {
	        	$("#archiveFieldEtc1").show();
	        } else {
	        	$("#archiveFieldEtc1").val('');
	            $("#archiveFieldEtc1").hide();
	        }
	 	}) 
		 	
	 	// 3-2. 분야1 선택 값이 바뀔때마다 inpuBox 활성/비활성 한다.
		$("#archiveField2").change(function() {
	        // 기타를 선택하면 등장
			if($("#archiveField2").val() == '13') {
			    $("#archiveFieldEtc2").show();
			} else {
				$("#archiveFieldEtc2").val('');
			    $("#archiveFieldEtc2").hide();
			}
		}) 
	
		// 3-3. 분야1 선택 값이 바뀔때마다 inpuBox 활성/비활성 한다.
		$("#archiveField3").change(function() {
		    // 기타를 선택하면 등장
			if($("#archiveField3").val() == '13') {
				$("#archiveFieldEtc3").show();
			} else {
				$("#archiveFieldEtc3").val('');
				$("#archiveFieldEtc3").hide();
			}
		})  
		
		// 첨부파일 삭제 - 메인이미지
		$(".delFileBtn").click(function() {
			if (!confirm('파일을 삭제하시겠습니까?')) {
				return;
			}
			
			var atchFileId = $("input[name=atchFileId]").val();
			var fileSn     = $(this).closest("div").find("input[name=fileSn]").val();
			var $this      = $(this);
			
			$.getJSON(
				"/bos/cmm/fms/deleteFileInfs.json",
				{atchFileId : atchFileId, fileSn : fileSn},
				function(data)
				{
					var jdata = data.resultCode;
		            if( jdata == 'success' ) {
		            	alert("성공적으로 삭제하였습니다.");
		            	$("#inputFile").html("<input name=\"taskThumbnail\" id=\"taskThumbnail\" type=\"file\" class=\"input_file form-control\" title=\"메인이미지\" /> 이미지 권장사이즈 : 335*245");
		            	$this.closest("div").remove();
		            }
		            else alert("삭제에 실패하였습니다.");
				}
			);
			return false;
		});
	});
 
 
	// 1.	 2번분야 선택  (onclick)
	$("#archiveField2").on('click',function(){

		// 1-1.  1번 null (null일경우 alert return)
		if($("select[name=archiveField1]").val() == null || $("select[name=archiveField1]").val() == '' ){
	 		alert("상위 분야를 선택해주세요");
	 		return
		};
	});
	
	// 1.	 3번분야 선택  (onclick)
	$("#archiveField3").on('click',function(){

		// 1-1.  2번 null (null일경우  alert return)
		if($("select[name=archiveField2]").val() == null || $("select[name=archiveField2]").val() == '' ){
	 		alert("상위 분야를 선택해주세요");
	 		return
		};
	});
	
</script>

