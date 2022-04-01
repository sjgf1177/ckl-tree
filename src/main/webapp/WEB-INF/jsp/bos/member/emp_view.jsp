<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<link rel="stylesheet" type="text/css" href="/admin/common/css/common_style.css">
<link rel="stylesheet" type="text/css" href="/admin/common/css/board.css">
			<!-- title -->
			<h3 class="tit_03">직원관리</h3>			
			
			<!-- text_area start -->
			<div class="text_area">				
				부서정보	
				<!-- //board_view start -->
				<div class="board_view">
				<table class="view_type01">
					<caption>일반게시판 보기 페이지</caption>
					<colgroup>
						<col width="12%" />
						<col width="*" />
						<col width="12%" />
						<col width="30%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">부서명</th>
							<td>${empView.deptName}</td>
							<th scope="row">부서코드</th>
							<td>${empView.deptId}</td>
							</tr>
						<tr>
							<th scope="row">팀명</th>
							<td>${empView.teamName}</td>
							<th scope="row">팀코드</th>
							<td>${empView.teamSeq}</td>
						</tr>
						<tr>
							<th scope="row">전화번호</th>
							<td>${empView.deptTel}</td>
							<th scope="row">팩스번호</th>
							<td>${empView.deptFax}</td>
						</tr>
						<tr>
							<th scope="row" class="con_tit">직책</th>
							<td colspan="3">${empView.positionName}</td>
						</tr>
						<tr>
							<th scope="row" class="con_tit">담당업무</th>
							<td colspan="3">${empView.mainService}</td>
						</tr>
					</tbody>
				</table>
				</div>
				기본정보
				<!-- //board_view start -->
				<div class="board_view">
				<table class="view_type01">
					<caption>일반게시판 보기 페이지</caption>
					<colgroup>
						<col width="12%" />
						<col width="*" />
						<col width="12%" />
						<col width="30%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">아이디</th>
							<td>${empView.userId}</td>
							<th scope="row">이름</th>
							<td>${empView.userName}</td>
							</tr>
						<tr>
							<th scope="row">입사일</th>
							<td>${empView.joinDqy}</td>
							<th scope="row">상태</th>
							<td>${empView.userStatName}</td>
						</tr>
						<tr>
							<th scope="row" class="con_tit">퇴사일</th>
							<td colspan="3">${empView.retireDay}</td>
						</tr>
					</tbody>
				</table>
				</div>
				부가정보
				<!-- //board_view start -->
				<div class="board_view">
				<table class="view_type01">
					<caption>일반게시판 보기 페이지</caption>
					<colgroup>
						<col width="12%" />
						<col width="*" />
						<col width="12%" />
						<col width="30%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">전화번호</th>
							<td>${empView.tel}</td>
							<th scope="row">핸드폰번호</th>
							<td>${empView.mobile}</td>
							</tr>
						<tr>
							<th scope="row" class="con_tit">E-MAIL</th>
							<td colspan="3">${empView.email}</td>
						</tr>
						<tr>
							<th scope="row" class="con_tit">주소</th>
							<td colspan="3">우)${empView.zipNo1}-${empView.zipNo2} ${empView.addr1} ${empView.addr2}</td>
						</tr>
					</tbody>
				</table>
				</div>
				
				<div id="btn_area">
					<div class="btn_right_fr">
						<a href="/admin/user/EmpList.do"><img src="/admin/images/common/btn/btn_list.gif" alt="목록" /></a>	
					</div>
					
				</div><!-- btn end -->
			</div>
			<!-- text_area end -->
			