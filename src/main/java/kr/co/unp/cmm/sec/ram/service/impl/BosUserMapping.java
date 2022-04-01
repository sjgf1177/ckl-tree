package kr.co.unp.cmm.sec.ram.service.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.unp.member.vo.UsersVO;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;

public class BosUserMapping implements RowMapper<UserDetails> {
	@Override
	public UserDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
    	String userId = rs.getString("USER_ID");
    	String password = rs.getString("password");
    	UsersVO usersVO = new UsersVO();
    	usersVO.setAdminTp("Y");
    	usersVO.setUserIdx(rs.getLong("USER_IDX"));
    	usersVO.setUserId(userId);    	
    	usersVO.setUserKey(userId);
    	usersVO.setDupInfo(userId);
    	usersVO.setCiInfo(userId);
    	usersVO.setPassword(password);
    	//usersVO.setUserIp(rs.getString("USER_IP"));
    	usersVO.setTelno(rs.getString("TEL_NO"));
    	usersVO.setUserNm(rs.getString("USER_NM"));
    	usersVO.setDeptId(rs.getString("DEPT_ID"));
    	usersVO.setDeptNm(rs.getString("DEPT_NM"));
    	usersVO.setEmail(rs.getString("EMAIL"));
    	usersVO.setAuthorCode(rs.getString("AUTHOR_CODE"));
    	usersVO.setPwdChangeDt(rs.getDate("PWD_CHANGE_DT"));
        return new UnpUserDetails(userId, password, true, true, true, true, AuthorityUtils.NO_AUTHORITIES, usersVO);
    }

}
