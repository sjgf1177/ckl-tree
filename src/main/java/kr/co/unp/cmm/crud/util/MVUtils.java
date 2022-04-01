package kr.co.unp.cmm.crud.util;

import java.util.Map;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;

import org.springframework.ui.ModelMap;

public abstract class MVUtils {

	public static void goUrl(String goUrl, String msg, ModelMap model){
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, goUrl);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, msg);		
	}
	
	public static void goUrlHidden(Map<String, String> hiddenInput, String goUrl, String msg, ModelMap model){
		model.addAttribute(ModelAndViewResolver.HIDDEN_INPUT_KEY, hiddenInput);
		goUrl(goUrl, msg, model);
	}

	public static void confirmUrl(String goUrl, String msg, ModelMap model){
		model.put(ModelAndViewResolver.WINDOW_MODE, ModelAndViewResolver.CONFIRM_URL_WINDOW_MODE);
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, goUrl);
		model.addAttribute(ModelAndViewResolver.CONFIRM_MSG_KEY, msg);
	}
	
	public static void winClose(String msg, ModelMap model){
		model.put(ModelAndViewResolver.WINDOW_MODE, ModelAndViewResolver.WIN_CLOSE_WINDOW_MODE);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, msg);
	}

	public static void winCloseReload(String msg, ModelMap model){
		model.put(ModelAndViewResolver.WINDOW_MODE, ModelAndViewResolver.WIN_CLOSE_RELOAD_WINDOW_MODE);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, msg);
	}

	public static void winCloseLocation(String goUrl, String msg, ModelMap model){
		model.put(ModelAndViewResolver.WINDOW_MODE, ModelAndViewResolver.WIN_CLOSE_LOCATION_WINDOW_MODE);
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, goUrl);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, msg);
	}
}
