<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="java.util.*" %>
<%@ page import="kr.co.unp.member.vo.*" %>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper" %>
<%@ page import="kr.co.unp.mpm.vo.MenuManageVO"%>
<%@ page import="kr.co.unp.mpm.service.MasterMenuManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%!

public String removeTag(String html) throws Exception {
    return html.replaceAll("<(/)?([a-zA-Z0-9]*)(\\s[a-zA-Z0-9]*=[^>]*)?(\\s)*(/)?>", "").replaceAll("&nbsp;"," ");
}
public int menuNoPrg(int prgCl)  { // 프로그램 메뉴넘버 반환
					/*인사이트*/		/*스탭업*/		/*플러스*/		/*게임리터러시*/   /* 콘텐츠 밸류업 */
    int menuNo [] = { 500215, 		500216, 	500217,		500218,		500219 };
    int prgNo [] = 		{ 13, 		12, 		10,			14,		15 };

    for ( int p=0; p<prgNo.length; p++ )
	    if ( prgNo[p] == prgCl )
		return menuNo[p];
    return -1;
}

%>