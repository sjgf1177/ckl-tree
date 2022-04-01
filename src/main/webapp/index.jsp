<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String requestUri = request.getRequestURL().toString();
	String host = request.getRemoteHost();
	
	System.out.println("================================= requestUri : " + requestUri);
	System.out.println("================================= host : " + host);

	if(requestUri.indexOf("www.ckl.or.kr") != -1){
		response.sendRedirect("http://venture.ckl.or.kr/intro.do");
	} else if(requestUri.indexOf("m.ckl.or.kr") != -1){
		response.sendRedirect("http://m.ckl.or.kr/cklmobile/main/main.do");
	} else if(requestUri.indexOf("ckl.or.kr") != -1){
		response.sendRedirect("https://www.ckl.or.kr/intro.html");
	} else if(requestUri.indexOf("medu.kocca.kr") != -1){
		response.sendRedirect("http://m.edu.kocca.kr");
	} else if(requestUri.indexOf("lab.ckl.or.kr") != -1){
		response.sendRedirect("https://www.ckl.or.kr/ckl/main/main.do");
	} else if(requestUri.indexOf("edu.kocca.kr") != -1){
		response.sendRedirect("http://edu.kocca.kr/edu/main/main.do");
	} else if(requestUri.indexOf("culturist.or.kr") != -1){
		response.sendRedirect("http://edu.kocca.kr/edu/job/cultureMain/main.do?menuNo=500046");
	} else if(requestUri.indexOf("edu.kocca.or.kr") != -1){
		response.sendRedirect("http://edu.kocca.kr/edu/main/main.do");
	} else if(requestUri.indexOf("testbed.kocca.kr") != -1 && requestUri.indexOf("edumobile") == -1){
		String mobileCheck = "";
		String userAgent = request.getHeader("user-agent");
		String[] browser = {"iPhone", "iPod","Android"};
		for (int i = 0; i < browser.length; i++) {
			if(userAgent.matches(".*"+browser[i]+".*")){
				mobileCheck = "1";
				break;
			}
		}
		
		if("1".equals(mobileCheck) ){
			response.sendRedirect("https://edu.kocca.kr/edumobile/main/main.do?siteName=testbed");
		}else{
			response.sendRedirect("https://edu.kocca.kr/testbed/main/main.do");
		}
	} else if(requestUri.indexOf("dream.kocca.or.kr") != -1){
		response.sendRedirect("http://edu.kocca.kr/edu/dream/dreamMain/main.do?menuNo=500034");
	} else if(requestUri.indexOf("dream.kocca.kr") != -1){
		response.sendRedirect("http://edu.kocca.kr/edu/dream/dreamMain/main.do?menuNo=500034");
	} else if(requestUri.indexOf("wtest.ckl.or.kr") != -1){
		response.sendRedirect("http://wtest.ckl.or.kr/ckl/main/main.do");
	} else if(requestUri.indexOf("mtest.ckl.or.kr") != -1){
		response.sendRedirect("http://mtest.ckl.or.kr/cklmobile/main/main.do");
	} else if(requestUri.indexOf("edutest.kocca.kr") != -1){
		response.sendRedirect("http://edutest.kocca.kr/edu/main/main.do");
	} else if(requestUri.indexOf("medu.kocca.dev.kr") != -1){
		response.sendRedirect("http://edu.kocca.dev.kr/edu/main/main.do");
	}  else if(requestUri.indexOf("edu.kocca.dev.kr") != -1){
		response.sendRedirect("http://edu.kocca.dev.kr/edu/main/main.do");
	}
%>
