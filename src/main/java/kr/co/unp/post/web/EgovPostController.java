package kr.co.unp.post.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.unp.post.service.EgovPostService;
import kr.co.unp.post.service.EgovPostVO;

@Controller
public class EgovPostController {

	@Resource(name="egovPostService")
	EgovPostService egovPostService;
	
	/**
	 * 시군구 목록 조회
	 * @param searchVO
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/post/popup_search_siGunGu.do")
	public String getSiGunGuList(@ModelAttribute("searchVO")EgovPostVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		
		List resultList = null;
		if(searchVO.getSearchSido() != null && !"".equals(searchVO.getSearchSido())){
			
			resultList = egovPostService.getSiGunguList(searchVO);
		}
		model.addAttribute("siGunGuList", resultList);
		model.addAttribute("searchGubun", searchVO.getSearchGubun());
		
		return "portal/post/popup_search_siGunGu";
	}
	
	/**
	 * 읍면동 목록 조회
	 * @param searchVO
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/post/popup_search_dong.do")
	public String getDongList(@ModelAttribute("searchVO")EgovPostVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		
		List resultList = null;
		if(searchVO.getSearchSido() != null && !"".equals(searchVO.getSearchSido())){
			
			resultList = egovPostService.getDongList(searchVO);
		}
		model.addAttribute("dongList", resultList);
		model.addAttribute("searchGubun", searchVO.getSearchGubun());
		return "portal/post/popup_search_dong";
	}
	
	/**
	 * 리 목록 조회
	 * @param searchVO
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/post/popup_search_ri.do")
	public String getRiList(@ModelAttribute("searchVO")EgovPostVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		
		List resultList = null;
		if(searchVO.getSearchSido() != null && !"".equals(searchVO.getSearchSido())){
			
			resultList = egovPostService.getRiList(searchVO);
		}
		model.addAttribute("riList", resultList);
		model.addAttribute("searchGubun", searchVO.getSearchGubun());
		return "portal/post/popup_search_ri";
	}
	
	/**
	 * 목록 조회
	 * @param searchVO
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/post/popup_add_search.do")
	public String getPostList(@ModelAttribute("searchVO")EgovPostVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		
		List resultList = null;
		if(searchVO.getSearchSido() != null && !"".equals(searchVO.getSearchSido())){
		
			resultList = egovPostService.getPostList(searchVO);
		}
		model.addAttribute("resultList", resultList);
		model.addAttribute("searchGubun", searchVO.getSearchGubun());
		model.addAttribute("search", searchVO.getSearch());
		return "portal/post/popup_add_search";
		
		
	}
	
	/**
	 * 목록 조회
	 * @param searchVO
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/post/google_add_search.do")
	public String getGooglePostList(@ModelAttribute("searchVO")EgovPostVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		
		List resultList = null;
		if(searchVO.getSearchSido() != null && !"".equals(searchVO.getSearchSido())){
		
			resultList = egovPostService.getPostList(searchVO);
		}
		model.addAttribute("resultList", resultList);
		model.addAttribute("searchGubun", searchVO.getSearchGubun());
		model.addAttribute("search", searchVO.getSearch());
		return "portal/post/google_add_search";
		
		
	}
}
