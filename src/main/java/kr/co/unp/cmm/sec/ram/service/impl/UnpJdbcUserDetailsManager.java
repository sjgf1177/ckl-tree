package kr.co.unp.cmm.sec.ram.service.impl;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.StrUtils;

import org.springframework.security.access.hierarchicalroles.RoleHierarchyImpl;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.JdbcUserDetailsManager;

public class UnpJdbcUserDetailsManager extends JdbcUserDetailsManager {
	public static final String USER_PREFIX = "@@USER@@";
	public static final String BOS_PREFIX = "@@BOS@@";
	private String hierarchicalRolesQuery;
	private String bosUsersByUsernameQuery;

    private RoleHierarchyImpl roleHierarchy = new RoleHierarchyImpl();

    private UserMapping userMapping = new UserMapping();
    private AuthorityMapping authorityMapping = new AuthorityMapping();

    public String getBosUsersByUsernameQuery() {
		return bosUsersByUsernameQuery;
	}

	public void setBosUsersByUsernameQuery(String bosUsersByUsernameQuery) {
		this.bosUsersByUsernameQuery = bosUsersByUsernameQuery;
	}

	public void setHierarchicalRolesQuery(String hierarchicalRolesQuery) {
		this.hierarchicalRolesQuery = hierarchicalRolesQuery;
	}

	@Override
    protected List<UserDetails> loadUsersByUsername(String username) {
		String __username = null;
		String query = null;
		if( username.startsWith(USER_PREFIX) ){
			query = getUsersByUsernameQuery();
			__username = StrUtils.replace(username, USER_PREFIX, "");
		}
		else if( username.startsWith(BOS_PREFIX) ){
			query = getBosUsersByUsernameQuery();
			__username = StrUtils.replace(username, BOS_PREFIX, "");
		}
		else{
			query = getUsersByUsernameQuery();
			__username = username;
		}

        return getJdbcTemplate().query(query, new String[] {__username}, userMapping);
    }

	@Override
    protected List<GrantedAuthority> loadUserAuthorities(String username) {
		List<GrantedAuthority> authorities = getJdbcTemplate().query(getAuthoritiesByUsernameQuery(), new String[] {username}, authorityMapping);
		if( authorities != null ){
			authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
		}
		return authorities;
    }

	@Override
    protected UserDetails createUserDetails(String username, UserDetails userFromUserQuery,
            List<GrantedAuthority> combinedAuthorities) {
        String returnUsername = userFromUserQuery.getUsername();
        UnpUserDetails userDetails = (UnpUserDetails)userFromUserQuery;
        UsersVO usersVO = userDetails.getUsersVO();

        return new UnpUserDetails(returnUsername, userFromUserQuery.getPassword(), userFromUserQuery.isEnabled(),
                true, true, true, combinedAuthorities, usersVO);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public void addCustomAuthorities(String username, List<GrantedAuthority> authorities) {
        List resultList = getJdbcTemplate().queryForList(hierarchicalRolesQuery);
        Iterator itr = resultList.iterator();
        StringBuffer concatedRoles = new StringBuffer();
        Map tempMap;
        while (itr.hasNext()) {
            tempMap = (Map) itr.next();
            concatedRoles.append(tempMap.get("child"));
            concatedRoles.append(" > ");
            concatedRoles.append(tempMap.get("parent"));
            concatedRoles.append("\n");
        }

        String roleHierarchyStringRepresentation = concatedRoles.toString();
		roleHierarchy.setHierarchy(roleHierarchyStringRepresentation);
		List<GrantedAuthority> reachableRoleList = (List<GrantedAuthority>)roleHierarchy.getReachableGrantedAuthorities(authorities);

		authorities.clear();
		authorities.addAll(reachableRoleList);
	}
}
