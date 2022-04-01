package kr.co.unp.micro.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MicroController {

	// 인트로
	@RequestMapping("/micro/micIntro.do")
	public String microIntro(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		String returnURL = "/micro/micIntro";

		return returnURL;
	}
	
    // 메인
	@RequestMapping("/micro/micMain.do")
	public String microMain(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		String returnURL = "/micro/micMain";

		return returnURL;
	}
	
	// 창의인재동반
	@RequestMapping("/micro/micOriginality.do")
	public String microOriginality(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		String returnURL = "/micro/micOriginality";

		return returnURL;
	}
	
	// 실감형콘텐츠 창작자 양성
	@RequestMapping("/micro/micRealContents.do")
	public String microRealContents(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		String returnURL = "/micro/micRealContents";

		return returnURL;
	}
	
	// 콘텐츠원캠퍼스
	@RequestMapping("/micro/micContentsCampus.do")
	public String microContentsCampus(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		String returnURL = "/micro/micContentsCampus";

		return returnURL;
	}
	
	// 콘텐츠임팩트
	@RequestMapping("/micro/micContentsImpact.do")
	public String microContentsImpact(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		String returnURL = "/micro/micContentsImpact";

		return returnURL;
	}
	
	// 리플렛 
		@RequestMapping("/micro/micLeaflet.do")
		public String microLeaflet(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

			String returnURL = "/micro/micLeaflet";

			return returnURL;
		}
	/*
	@Override
	protected String getProgramId(ParameterContext<ZValue> paramCtx){
		return "microContents";
	}
	*/
	
}

