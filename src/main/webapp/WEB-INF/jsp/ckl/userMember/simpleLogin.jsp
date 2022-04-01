<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<iframe name="ssoLoginFrame" id="ssoLoginFrame" style="width:1100px;height:600px;" src="<c:out value="${ssoDomain }" />/sso/member/incSimpleLogin.do?service=ckl&amp;menuNo=<c:out value="${paramVO.menuNo }" />" title="간편로그인 설정 frame입니다." frameborder="0" scrolling="no" ></iframe>