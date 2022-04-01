<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="ko">
<head>
<title>수료증 출력 | 에듀코카 (${gadmin })</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<style type="text/css">
	.text1  {
	font-family:굴림;
	font-size:10pt;
	color: #000000;
	line-height: 120%;
	}
	.text1  A:link {color:#3366cc; text-decoration: none}
	.text1  A:visited {color:#009999; text-decoration: none}
	.text1  A:hover {color:#33ccff; text-decoration: none}
	
	.text2  {
	font-family:궁서;
	font-size:12pt;
	color: #000000;
	line-height: 140%;
	}
	.text2  A:link {color:#000000; text-decoration: none}
	.text2  A:visited {color:#000000; text-decoration: none}
	.text2  A:hover {color:#33ccff; text-decoration: none}
	
	.blacktext {FONT-FAMILY:굴림,Arial; font-size: 11pt; font-weight:normal; color:#000000; line-height: 140%; text-decoration: bold}
	
	/* 수료증 번호 */
	.certi_no           {font-family: "돋움"; font-size: 9pt; color: #000000;	text-decoration: none; line-height:18px ;}
	/* 수료증 타이틀 */
	.certi_title           {font-family: "돋움"; font-size: 33pt; 	color: #000000;	font-weight:bold; text-decoration: none; line-height:50px ;}
	/* 수료증 분류 */
	.certi_sbj           {font-family: "돋움"; font-size: 20pt; 	color: #000000;	font-weight:bold; text-decoration: none; line-height:30px ;}
	/* 수료증 분류2 */
	.certi_sbj2           {font-family: "돋움"; font-size: 14pt; 	color: #000000;	font-weight:bold; text-decoration: none; line-height:30px ;}
	/* 이수기간 */
	.certi_day           {font-family: "바탕"; font-size: 11pt; 	color: #000000;	text-decoration: none; line-height:20px ;}
	/* 수료자名 */
	.certi_name           {font-family: "돋움"; font-size: 25pt; 	color: #000000;	font-weight:bold; text-decoration: none; line-height:40px ;}
	/* 수료자 주민번호 */
	.certi_JUno           {font-family: "돋움"; font-size: 12pt; 	color: #000000;	 text-decoration: none; font-weight:bold;line-height:20px ;}
	/* 수료내용 */
	.certi_con           {font-family: "바탕"; font-size: 12pt; 	color: #000000;	 font-weight:bold; text-decoration: none; line-height:40px ;}
	/* 수료증 발행일 */
	.certi_day2           {font-family: "바탕"; font-size: 12pt; 	color: #000000;	text-decoration: none; line-height:20px ;}
	/* 한국방송영상산업진흥원 원장 직인란 */
	.certi           {font-family: "바탕"; font-size: 16pt; 	color: #000000;	font-weight:bold; text-decoration: none; line-height:30px ;}
	
</style>
</head>


<body topmargin="0" leftmargin="0" onload="this.print()">

<div id="ctfhvArea">

	<!-- left line -->
	<div style="position:absolute; top:10px; left:4px; width:39px; height:30px; z-index:1;"> <img src="/edu/images/onlineEdu/polity/cert_BgLeftLine01.gif" border="0" width="39px;" height="30px;" /></div>
	<div style="position:absolute; top:73px; left:4px; width:39px; height:1005px; z-index:3;"> <img src="/edu/images/onlineEdu/polity/cert_BgLeftLine02.gif" border="0" width="39px;" height="1005px;" /></div>
	
	
	<!-- CENTER IMAGE (백그라운드 로고)-->  
	<div STYLE='position:absolute; top:430px; left:220px; width:420px;  z-index:4;'> <img src="/edu/images/onlineEdu/polity/cert_BgLogo.png" style="filter:alpha(opacity=20, style=2, finishopacity=0)" border=0 width=420  /></div>
	<!-- CENTER LINE -->
	<div STYLE='position:absolute; top:458px; left:332px; width:3px; height:366px; z-index:5;'> <img src="/edu/images/onlineEdu/polity/cert_BgcenterLine.gif" border=0 width=3 height=366 /></div>
	
	
	<table width="798" border="0" cellspacing="0" cellpadding="0" height="1022" >
		<tr>
			<td width="10" rowspan="14">&nbsp;</td>
			<td width="20" height="30">&nbsp;</td>
			<td height="30" colspan="2">&nbsp;</td>
		</tr>
		
		<tr>
			<td height="29">&nbsp;</td>
			<td height="29" colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3" height="34" valign="top">
				<table width="765" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="6" height="34" valign="top">&nbsp;</td>
						<td width="759" height="34" valign="middle">&nbsp;
							<div style='position:absolute; top:47px; left:19px; width:460px; height:26px; z-index:300;'>제 ${ctfhvInfo.serno } 호</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td rowspan="10">&nbsp;</td>
			<td height="150" colspan="2">
				<table width="728" border="0" cellspacing="0" cellpadding="0" height="150">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="certi_title">&nbsp;
							<div style='position:absolute; top:136px; left:59px; width:367px; height:61px; z-index:301;'>
							수 료 증
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="20" colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td height="30" colspan="2">
				<table width="728" border="0" cellspacing="0" cellpadding="0" height="30">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="certi_sbj2">&nbsp;
							<div style='position:absolute; top:245px; left:63px; width:691px; height:24px; z-index:301;'>
							<!-- KOCCA · Avid Korea 공동인증  -->
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="35" colspan="2">
				<table width="728" border="0" cellspacing="0" cellpadding="0" height="35">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="certi_sbj">&nbsp;
							<div style='position:absolute; top:277px; left:63px; width:686px; height:37px; z-index:301;'>
							${ctfhvInfo.subjnm }
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="35" colspan="2">
				<table width="728" border="0" cellspacing="0" cellpadding="0" height="35">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="certi_day">&nbsp;
							<div style='position:absolute; top:318px; left:62px; width:514px; height:25px; z-index:301;'>
								${ctfhvInfo.edustart }&nbsp;~&nbsp;
								${ctfhvInfo.eduend }
								&nbsp;
								<c:if test="${ctfhvInfo.grseq ne ''}">
									(${ctfhvInfo.grseq }시간)
								</c:if>
								
								<!-- 학점인증과정인 경우 -->
								<c:if test="${ctfhvInfo.yeunsuno ne '' and ctfhvInfo.isunit eq 'Y'}">
									<c:set var="grtime" value="${ctfhvInfo.grseq * 2 + 1 }"></c:set>
									(${grtime }시간)(${ctfhvInfo.degree }학점)
								</c:if>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="100" colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td height="400" colspan="2">
				<table border="0" cellspacing="0" cellpadding="0" height="400" width="728">
					<tr>
						<td width="275" height="400">&nbsp;</td>
						<td width="453" height="400">
							<table width="431" border="0" cellspacing="0" cellpadding="0" height="400">
								<tr>
									<td height="50" width="4">&nbsp;</td>
									<td colspan="3" class="certi_name" height="50">&nbsp;
										<div style='position:absolute; top:454px; left:342px; width:227px; height:34px; z-index:301;'>
										<c:out value="${ctfhvInfo.name }" />
										</div>
									</td>
								</tr>
								<%-- 
								<tr>
									<td height="30">&nbsp;</td>
									<td colspan="3" class="certi_JUno" height="30">&nbsp;
										<div style='position:absolute; top:498px; left:342px; width:350px; height:17px; z-index:301;'>
											<c:out value="${ctfhvInfo.resno }" />
											<span style="font-size:10pt"><c:out value="${ctfhvInfo.yeunsuno }" /></span>
										</div>
										<br />
									</td>
								</tr>
								 --%>
								<tr>
									<td height="40" colspan="4">&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td colspan="3" class="certi_con" valign="top" height="140"> &nbsp;
										<div style='position:absolute; top:544px; left:342px; width:407px; height:50px; z-index:301;'>
											위 사람은 한국콘텐츠진흥원<br />
											에듀코카의 상기 교육과정을<br />
											이수하였으므로 이 증서를 수여합니다.
										</div>
									</td>
								</tr>
								<tr align="center">
									<td valign="middle" colspan="4">&nbsp;
										<div style='position:absolute; top:754px; left:428px; width:133px; height:27px; z-index:301;'>
											<jsp:useBean id="toDay" class="java.util.Date" />
											<fmt:formatDate value="${toDay}" pattern="yyyy년 MM월 dd일" />
										</div>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td colspan="3" class="certi">&nbsp;
									
										<!-- 직인 -->
										<c:choose>
											<c:when test="${gadmin eq 'ZZ' }">
												<div style='position:absolute; top:799px; left:342px; width:406px; height:46px; z-index:301;'>
													&nbsp;&nbsp;&nbsp;&nbsp;한국콘텐츠진흥원 원장 &nbsp;(인)
												</div>
												<div style='position:absolute; top:758px; left:600px; width:50px; height:50px; z-index:301;'>
													<img src="/edu/images/onlineEdu/polity/kbistamp.gif" border=0 width=108 height=106 />
												</div>
											</c:when>
											
											<c:otherwise>
								                <div style='position:absolute; top:849px; left:342px; width:406px; height:46px; z-index:301;'>
													&nbsp;&nbsp;&nbsp;&nbsp;한국콘텐츠진흥원 원장 &nbsp;(인)
								                </div>
								                <div style='position:absolute; top:808px; left:600px; width:50px; height:50px; z-index:301;'>
								                    <img src="/edu/images/onlineEdu/polity/kbistamp.gif" border=0 width=108 height=106 />
								                </div>
											</c:otherwise>
										</c:choose>
										<!-- 직인 끝 -->
									</td>
								</tr>
								<tr>
									<td height="1"></td>
									<td width="9"></td>
									<td></td>
									<td></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr>
			<td height="80." colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td height="100" width="404">&nbsp;
				<div style='position:absolute; top:950px; left:81px; width:284px; height:82px; z-index:301;'>
				
				<!-- FPT01 프로툴즈 , FAV01 아비드 -->
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!--img src="/images/admin/polity/avid.bmp" border=0-->
				
				</div>
			</td>
			<td height="100" width="364">&nbsp;
				<div style='position:absolute; top:935px; left:423px; width:50px; height:50px; z-index:301;'>
					<img src="/edu/images/onlineEdu/polity/kocca_logo.png" width="165"/>
				</div>
			</td>
		</tr>
		<tr>
			<td height="20" colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td height="10">&nbsp;</td>
			<td height="10" colspan="2">&nbsp;</td>
		</tr>
	</table>

</div>

</body>
</html>

