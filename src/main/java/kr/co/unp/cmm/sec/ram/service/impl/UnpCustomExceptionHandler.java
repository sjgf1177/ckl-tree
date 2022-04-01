package kr.co.unp.cmm.sec.ram.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

public class UnpCustomExceptionHandler extends SimpleMappingExceptionResolver {

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(UnpCustomExceptionHandler.class);

	/**
	* Log the exception.
	*
	* @see org.springframework.web.servlet.handler.SimpleMappingExceptionResolver#doResolveException(javax.servlet.http.HttpServletRequest,
	*      javax.servlet.http.HttpServletResponse, java.lang.Object,
	*      java.lang.Exception)
	 */
	@Override
	protected ModelAndView doResolveException(HttpServletRequest request, HttpServletResponse response, Object handler,Exception ex) {
		logger.error("A " + ex.getClass().getSimpleName() + " has occured in the application", ex);
	    return super.doResolveException(request, response, handler, ex);
	}
}
