package kr.co.unp.cmm.sec.ram.service.impl;

import java.util.Collection;

import kr.co.unp.member.vo.UsersVO;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

public class UnpUserDetails extends User {

	private static final long serialVersionUID = 1L;

	public UnpUserDetails(String username, String password, boolean enabled,
			boolean accountNonExpired, boolean credentialsNonExpired,
			boolean accountNonLocked, Collection<? extends GrantedAuthority> authorities, UsersVO usersVO)
			throws IllegalArgumentException {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		setUsersVO(usersVO);
		
	}
	
	public UnpUserDetails(String username, String password, boolean enabled, UsersVO usersVO)
	    throws IllegalArgumentException {
		this(username, password, enabled, true, true, true, AuthorityUtils.NO_AUTHORITIES, usersVO);
	}

	private UsersVO usersVO;	

	public UsersVO getUsersVO() {
		return usersVO;
	}

	public void setUsersVO(UsersVO usersVO) {
		this.usersVO = usersVO;
	}
}
