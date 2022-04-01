<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head>
        <title>*** KCP [AX-HUB Version] ***</title>
        <script type="text/javascript">
            function goResult()
            {
                var openwin = window.open( 'proc_win.html', 'proc_win', '' )
                document.pay_info.submit();
                openwin.close();
            }

            // 결제 중 새로고침 방지 샘플 스크립트
            function noRefresh()
            {
                /* CTRL + N키 막음. */
                if ((event.keyCode == 78) && (event.ctrlKey == true))
                {
                    event.keyCode = 0;
                    return false;
                }
                /* F5 번키 막음. */
                if(event.keyCode == 116)
                {
                    event.keyCode = 0;
                    return false;
                }
            }
            document.onkeydown = noRefresh ;
        </script>
    </head>

    <body onload="goResult()">
    <form name="pay_info" method="post" action="${resultPage}">
		<input type="hidden" name="site_cd"         value="${result.g_conf_site_cd}">    <!-- 사이트 코드 -->
		<input type="hidden" name="req_tx"          value="${result.req_tx}">    <!-- 요청 구분 -->
        <input type="hidden" name="use_pay_method"  value="${result.use_pay_method}">    <!-- 사용한 결제 수단 -->
        <input type="hidden" name="bSucc"           value="${result.bSucc}">    <!-- 쇼핑몰 DB 처리 성공 여부 -->

        <input type="hidden" name="res_cd"          value="${result.res_cd}">    <!-- 결과 코드 -->
        <input type="hidden" name="res_msg"         value="${result.res_msg}">    <!-- 결과 메세지 -->
        <input type="hidden" name="ordr_idxx"       value="${result.ordr_idxx}">    <!-- 주문번호 -->
        <input type="hidden" name="tno"             value="${result.tno}">    <!-- KCP 거래번호 -->
        <input type="hidden" name="good_mny"        value="${result.good_mny}">    <!-- 결제금액 -->
        <input type="hidden" name="good_name"       value="${result.good_name}">    <!-- 상품명 -->
        <input type="hidden" name="buyr_name"       value="${result.buyr_name}">    <!-- 주문자명 -->
        <input type="hidden" name="buyr_tel1"       value="${result.buyr_tel1}">    <!-- 주문자 전화번호 -->
        <input type="hidden" name="buyr_tel2"       value="${result.buyr_tel2}">    <!-- 주문자 휴대폰번호 -->
        <input type="hidden" name="buyr_mail"       value="${result.buyr_mail}">    <!-- 주문자 E-mail -->

		<input type="hidden" name="app_time"        value="${result.app_time}">	<!-- 승인시간 -->
		<!-- 신용카드 정보 -->
        <input type="hidden" name="card_cd"         value="${result.card_cd}">    <!-- 카드코드 -->
        <input type="hidden" name="card_name"       value="${result.card_name}">    <!-- 카드이름 -->
        <input type="hidden" name="app_no"          value="${result.app_no}">    <!-- 승인번호 -->
		<input type="hidden" name="noinf"			value="${result.noinf}">    <!-- 무이자여부 -->
        <input type="hidden" name="quota"           value="${result.quota}">    <!-- 할부개월 -->
        <input type="hidden" name="partcanc_yn"     value="${result.partcanc_yn}">    <!-- 부분취소가능유무 -->
        <input type="hidden" name="card_bin_type_01" value="${result.card_bin_type_01}">   <!-- 카드구분1 -->
        <input type="hidden" name="card_bin_type_02" value="${result.card_bin_type_02}">   <!-- 카드구분2 -->
		<!-- 계좌이체 정보 -->
        <input type="hidden" name="bank_name"       value="${result.bank_name}">    <!-- 은행명 -->
        <input type="hidden" name="bank_code"       value="${result.bank_code}">    <!-- 은행코드 -->
		<!-- 가상계좌 정보 -->
        <input type="hidden" name="bankname"        value="${result.bankname}">    <!-- 입금 은행 -->
        <input type="hidden" name="depositor"       value="${result.depositor}">    <!-- 입금계좌 예금주 -->
        <input type="hidden" name="account"         value="${result.account}">    <!-- 입금계좌 번호 -->
		<input type="hidden" name="va_date"         value="${result.va_date}">    <!-- 가상계좌 입금마감시간 -->
		<!-- 포인트 정보 -->
		<input type="hidden" name="pnt_issue"		value="${result.pnt_issue}">	<!-- 포인트 서비스사 -->
		<input type="hidden" name="pt_idno"			value="${result.pt_idno}">	<!-- 결제 및 인증 아이디 -->
		<input type="hidden" name="pnt_app_time"	value="${result.pnt_app_time}">	<!-- 승인시간 -->
        <input type="hidden" name="pnt_app_no"      value="${result.pnt_app_no}">	<!-- 승인번호 -->
        <input type="hidden" name="pnt_amount"      value="${result.pnt_amount}">	<!-- 적립금액 or 사용금액 -->
        <input type="hidden" name="add_pnt"         value="${result.add_pnt}">	<!-- 발생 포인트 -->
        <input type="hidden" name="use_pnt"         value="${result.use_pnt}">	<!-- 사용가능 포인트 -->
        <input type="hidden" name="rsv_pnt"         value="${result.rsv_pnt}">	<!-- 총 누적 포인트 -->
		<!-- 휴대폰 정보 -->
        <input type="hidden" name="commid"          value="${result.commid}">	<!-- 통신사 코드 -->
        <input type="hidden" name="mobile_no"       value="${result.mobile_no}">	<!-- 휴대폰 번호 -->
        <!-- 상품권 정보 -->
        <input type="hidden" name="tk_van_code"     value="${result.tk_van_code}">	<!-- 발급사 코드 -->
        <input type="hidden" name="tk_app_no"       value="${result.tk_app_no}">	<!-- 승인 번호 -->
        <!-- 현금영수증 정보 -->
        <input type="hidden" name="cash_yn"         value="${result.cash_yn}">	<!-- 현금영수증 등록 여부 -->
        <input type="hidden" name="cash_authno"     value="${result.cash_authno}">	<!-- 현금 영수증 승인 번호 -->
        <input type="hidden" name="cash_tr_code"    value="${result.cash_tr_code}">	<!-- 현금 영수증 발행 구분 -->
        <input type="hidden" name="cash_id_info"    value="${result.cash_id_info}">	<!-- 현금 영수증 등록 번호 -->
    </form>
	</body>
</html>