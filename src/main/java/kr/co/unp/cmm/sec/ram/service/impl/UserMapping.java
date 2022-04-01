package kr.co.unp.cmm.sec.ram.service.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.CookieUtil;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;

import com.siren24.Base64;

public class UserMapping implements RowMapper<UserDetails> {

	@Override
	public UserDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
    	String userId = rs.getString("USER_ID");
    	String password = rs.getString("PASSWORD");

    	String username = rs.getString("username");

    	UsersVO usersVO = new UsersVO();
    	usersVO.setUserIdx(rs.getInt("USER_SN"));
    	usersVO.setUserId(userId);
    	usersVO.setPassword(password);
    	usersVO.setUserKey(Base64.base64Encode(userId));
    	usersVO.setMberSe(rs.getString("MBER_SE"));
    	usersVO.setUserNm(rs.getString("USER_NM"));
    	usersVO.setEmail(rs.getString("EMAIL"));
    	usersVO.setMoblphon(rs.getString("MBTLNUM"));
    	usersVO.setBrthdy(rs.getString("BRTHDY"));
    	usersVO.setSex(rs.getString("SEX"));
    	usersVO.setEmailAt(rs.getString("EMAIL_AT"));
    	usersVO.setSmsAt(rs.getString("SMS_AT"));
    	usersVO.setAddress(rs.getString("SIDO")+"|"+rs.getString("GUGUN"));
    	usersVO.setLastLoginDt(rs.getDate("LAST_LOGIN_DT"));
    	usersVO.setPwdChangeDt(rs.getDate("PWD_CHANGE_DT"));
    	usersVO.setPwdChangeAt(rs.getString("PWD_CHANGE_AT"));
    	usersVO.setAuthAt(rs.getString("AUTH_EMAIL_AT"));
    	usersVO.setAuthSe(rs.getString("AUTH_SE"));
    	usersVO.setStatus(rs.getString("USER_STTUS"));
    	usersVO.setUserIp(rs.getString("USER_IP"));
    	usersVO.setAgreAt(rs.getString("AGRE_AT"));
    	usersVO.setAgreDt(rs.getDate("AGRE_DT"));
    	usersVO.setOtherDt(rs.getDate("AGRE_CHK_DT"));
    	usersVO.setJobSe(rs.getString("JOB_SE"));

    	if (rs.getString("AGE_SE") != null) {
    		if (rs.getInt("AGE_SE") >= 60) {
    			usersVO.setAgeSe("60");
    		}
    		else {
    			usersVO.setAgeSe(rs.getString("AGE_SE"));
    		}
    	}

    	usersVO.setResdncSe(rs.getString("RESDNC_SE"));
    	usersVO.setConfirmKey(rs.getString("CONFIRM_KEY"));
    	int mentoYn = rs.getInt("MENTO_CNT");
    	usersVO.setMentoYn(mentoYn > 0 ? "Y" : "N");
    	int testbedYn = rs.getInt("TESTBED_CNT");
    	usersVO.setTestbedYn(testbedYn > 0 ? "Y" : "N");
    	usersVO.setTestbedCompAuth(rs.getString("TESTBED_COMP_AUTH"));
    	try {
			usersVO.setSsotoken(CookieUtil.encodeAccount(rs.getString("EMAIL"), rs.getString("USER_NM"), ""));
		} catch (Exception e) {
			e.printStackTrace();
		}



        return new UnpUserDetails(username, password, true, true, true, true, AuthorityUtils.NO_AUTHORITIES, usersVO);
    }

}
