<%@page contentType="text/html;charset=utf-8" %>
<!-- 설명 -->
<!-- <div class="col-12 contents_insight_header">
	<div class="col-12 text_box">
		<h5 class="fontup_24 white"><span>INTERVIEW</span>온라인모의면접</h5>
		<hr class="h_line5">
		<ul>
			<li>이용절차 : 온라인모의면접 내용1</li>
			<li>이용안내 : 온라인모의면접 내용2</li>
		</ul>
	</div>
	<div class="col-0 img_box"></div>
</div> -->
<!-- //설명 -->

<div class="col-12 popup_wrap" id="selfviewAuthPopup" style="left: 0;">
    <div class="col-10 col-center popup_con">
        <div class="col-12 popup_style_0 type_2" style="max-width: 600px;">
            <div class="col-12 popup_title_wrap">
                <div class="popup_title">
                    알림
                </div>
                <div class="popup_close_btn_con">
                    <a href="javascript:closeSelfviewPopup();" class="popup_close_btn">
                        <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                    </a>
                </div>
            </div>
            <div class="col-12 popup_contents_wrap">
                <p class="popup_desc" style="text-align: left;">
                    에듀코카는 온라인 모의면접 서비스를 제공하기 위해서 <br/>
                    아래와 같이 개인정보를 제3자에게 제공함에 있어 사용자의 동의를 얻어야 합니다.<br/><br/>
 
					제공하는 개인정보 항목: 아이디,이름<br/>
					제공 받는 자: (주)인핸스유<br/>
					개인정보 이용 목적: 온라인 모의면접 서비스 회원 가입 및 개인화된 서비스 제공<br/>
					보유 및 이용기간: 회원탈퇴 또는 에듀코카에서 온라인 모의면접 서비스 제공 종료 시 까지<br/><br/>
					 
					관계 법령에 따라 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있으며, <br/>
					개인의 동의 및 법률에 정하여진 경우를 제외하고는 개인정보가 타인에게 제공되지 않습니다.<br/><br/>
					 
					본인은 에듀코카 시스템의 상기 개인정보를 <br/>
					(주)인핸스유에 제공하여 서비스이용에 활용하도록 하는데 동의합니다.
                </p>
					<hr class="popup_seperate_line"/>
                <p class="popup_desc">
					<input type="checkbox" name="etc" id="authCheck" value="1" style="" class="chckbox_style_bold" />
					<label for="authCheck">
						동의합니다.
					</label>
					<br>
					( 위 사항에 동의하셔야만 서비스의 제공이 가능합니다. ) 
                </p>
                <div class="popup_btn_con">
                    <a href="javascript:authSelfview()" class="btn_style_popup">OK</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>

<div class="col-12 recruit_online_header">
    <div class="recruit_online_img_box">
        <img src="/edu/images/bm/sub_recruit_online_img.png" alt="실전!! 면접준비 어떻게 하면 좋을까요?">
    </div>
    <div class="recruit_online_text_box">
        <p class="recruit_online_title">
            실전!! 면접준비 어떻게 하면 좋을까요?
        </p>
        <p class="recruit_online_desc">
            이용자가 면접유형과 면접질문을 선택하면, 가상 면접관이 실제면접처럼 체험하도록
            질문을 하고, 자동 녹화된 응답영상 결과를 스스로 또는 전문가와 평가 및 분석할 수 있도록 지원하는 면접체험학습 프로그램 입니다.
        </p>
    </div>
</div>
<hr class="recruit_online_seperate_line">
<ul class="list_style_2 big_style">
    <li>이용 절차</li>
</ul>
<div class="recruit_online_step_wrap">
    <div class="recruit_online_step_con">
        <div class="step_style_0_con">
            <div class="step_list">
                01
                <p class="step_desc">회원가입</p>
            </div>
            <div class="step_list step_line"></div>
            <div class="step_list">
                02
                <p class="step_desc">모의면접<br/>항목선택</p>
            </div>
            <div class="step_list step_line"></div>
            <div class="step_list">
                03
                <p class="step_desc">모의면접 응시</p>
            </div>
            <div class="step_list step_line"></div>
            <div class="step_list">
                04
                <p class="step_desc">취업상담사<br/>맞춤코칭</p>
            </div>
        </div>
    </div>
</div>
<ul class="list_style_2 big_style">
    <li>이용 안내</li>
</ul>
<ul class="mb40 list_style_9">
    <li>실제와 똑같은 상황을 연출하여 면접을 체험해 볼 수 있습니다. </li>
    <li>자신의 모습을 녹화/저장해 스스로 자신의 장단점 파악이 가능합니다.<br/>(녹화된 영상파일 다운로드 하세요 - 연습영상 무한저장 가능)</li>
    <li>녹화된 영상에 대한 전문취업상담사의 피드백을 받아보세요.</li>
    <li>카메라 기능이 있는 PC 또는 스마트 폰만 있으면 원하는 시간에 언제든지 이용 가능합니다.</li>
    <li>모의면접을 이용하기 위해서는 최신 웹브라우저인 크롬을 사용하여야 합니다.</li>
</ul>
<div class="board_util_btn_con center">
    <a href="javascript:openTestInterviewPopup();" class="btn_style_0 radius blue">
        모의면접 체험해보기
    </a>
    <a href="javascript:openSelfviewPopup();" class="btn_style_0 radius green">
        모의면접시작
    </a>
</div>
<!-- 버튼 -->
<!-- <a href="javascript:openTestInterviewPopup();">
	<button style="padding:20px;border:1px solid gray;">모의면접 체험해보기 -> </button>
</a>
<a href="javascript:openSelfviewPopup();">
	<button style="padding:20px;border:1px solid gray;">모의면접 시작 -> </button>
</a> -->
<!-- //버튼  -->


<script type="text/javascript">
function closeSelfviewPopup(){
	$("#selfviewAuthPopup").hide();
}

function openSelfviewPopup(){
	$("#selfviewAuthPopup").show();
}

function openTestInterviewPopup(){
	//rsg20171012 비로그인 오류 수정
	if ( 'anonymousUser' == '${userVO.userId}' ) //비로그인
		window.open("http://kocca.selfview.co.kr/member/logout_post.html?redirect=%2Fouter%2Fdream1.html%3Fr%3D9707", "모의면접 체험해보기", "width=1180, height=760, menubar=no, status=no, toolbar=no")
	else
		window.open("http://me2.do/5ks9xGtl", "모의면접 체험해보기", "width=1180, height=760, menubar=no, status=no, toolbar=no")
}


function authSelfview(){
	if( $("#authCheck").is(":checked") ){
		window.location.href = "/edu/bbs/B0000060/listSec.do?menuNo=500139";
	}else{
		alert("제 3자 정보제공에 동의하셔야 합니다.");
	}
}
</script>