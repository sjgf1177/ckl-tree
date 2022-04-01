package kr.co.unp.cmm.sec.ram.service.impl;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.WebFactory;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.access.AccessDeniedHandler;

public class UnpAccessDeniedHandler implements AccessDeniedHandler {

	private String defaultErrorPage;
	private String siteName;

	@Resource(name="webFactory")
	private WebFactory webFactory;

	@Override
	public void handle(HttpServletRequest request,	HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {

		// Ajax를 통해 들어온것인지 파악한다
		String ajaxHeader = request.getHeader("X-Ajax-call");
		String result = "";

		response.setStatus(HttpServletResponse.SC_FORBIDDEN);
		response.setCharacterEncoding("UTF-8");

		if (ajaxHeader == null || "".equals(ajaxHeader)) {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			Object principal = auth.getPrincipal();
			if (principal instanceof UnpUserDetails) {
				String username = ((UnpUserDetails) principal).getUsername();
				UsersVO user = ((UnpUserDetails) principal).getUsersVO();

				if ("portal".equals(siteName) && "Y".equals(user.getAdminTp())) {
					try {
						webFactory.printHtmlBack(response, "관리자 로그인 접속중 입니다.\\n관리자를 로그아웃하시고 접속해주시기 바랍니다.");
						return;
					} catch (Exception e) {
						e.printStackTrace();
					}

				}
				else if ("eng".equals(siteName) && "Y".equals(user.getAdminTp())) {
					try {
						webFactory.printHtmlBack(response, "관리자 로그인 접속중 입니다.\\n관리자를 로그아웃하시고 접속해주시기 바랍니다.");
						return;
					} catch (Exception e) {
						e.printStackTrace();
					}

				}
				else if ("bos".equals(siteName) && !"Y".equals(user.getAdminTp())) {
					try {
						webFactory.printHtmlBack(response, "사용자 로그인 접속중 입니다.\\n사용자를 로그아웃하시고 접속해주시기 바랍니다.");
						return;
					} catch (Exception e) {
						e.printStackTrace();
					}

				}

				request.setAttribute("username", username);
			}
			request.setAttribute("errormsg", accessDeniedException);
			request.getRequestDispatcher(defaultErrorPage).forward(request, response);
		}
		else {
			if ("true".equals(ajaxHeader)) {
				result = "{\"result\" : \"fail\", \"msg\" : \"" + accessDeniedException.getMessage() + "\"}";
			}
			else {
				result = "{\"result\" : \"fail\", \"msg\" : \"Access Denied\"}";
			}
			response.getWriter().print(result);
			response.getWriter().flush();
		}
	}

	public void setDefaultErrorPage(String defaultErrorPage) {
        if ((defaultErrorPage != null) && !defaultErrorPage.startsWith("/")) {
            throw new IllegalArgumentException("errorPage must begin with '/'");
        }

        this.defaultErrorPage = defaultErrorPage;
    }

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}

}