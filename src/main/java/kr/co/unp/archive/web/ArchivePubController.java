package kr.co.unp.archive.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ArchivePubController {
	
	@RequestMapping("/archive/immersive/Det.do")
	public String immersive(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		String returnURL = "/archive/immersive/Det";
		return returnURL;
	}
	
	@RequestMapping("/archive/creative/Det.do")
	public String creative(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		String returnURL = "/archive/creative/Det";
		return returnURL;
	}
	
	@RequestMapping("/archive/oneCampus/Det.do")
	public String oneCampus(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		String returnURL = "/archive/oneCampus/Det";
		return returnURL;
	}
	
	@RequestMapping("/archive/contentsImpact/Det.do")
	public String contentsImpact(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		String returnURL = "/archive/contentsImpact/Det";
		return returnURL;
	}
}
