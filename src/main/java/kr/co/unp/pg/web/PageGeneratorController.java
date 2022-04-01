package kr.co.unp.pg.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.pg.service.PageGenerator;
import kr.co.unp.pg.vo.PageVO;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.HttpUtil;

@Controller
public class PageGeneratorController
{
	@Resource(name = "pageGenerator")
	private PageGenerator pageGenerator;

	@RequestMapping("/bos/pg/pageAttrList")
	public String getPageAttrList(@ModelAttribute("pageVO") PageVO pageVO, ModelMap model) throws Exception
	{
		pageGenerator.getPageAttrList(pageVO, model);
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/pg/pageAttrList.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
	}

	@RequestMapping("/bos/pg/regPage")
	public String writePage(ModelMap model) throws Exception
	{
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/pg/Reg.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
	}

	@RequestMapping("/bos/pg/addPageAttr")
	public void addPageAttr(@ModelAttribute("pageVO") PageVO pageVO, HttpServletResponse response, ModelMap model) throws Exception
	{
		pageGenerator.addPageAttribute(pageVO, model);
		HttpUtil.goUrl(response, "/bos/pg/pageAttrList.do?menuNo="+pageVO.getMenuNo(), null);
	}

	@RequestMapping("/bos/pg/updatePageAttr")
	public void updatePageAttr(@ModelAttribute("pageVO") PageVO pageVO, HttpServletResponse response, ModelMap model) throws Exception
	{
		pageGenerator.updatePageAttribute(pageVO, model);
		HttpUtil.goUrl(response, "/bos/pg/pageAttrList.do?menuNo="+pageVO.getMenuNo()+"&bbsId="+pageVO.getBbsId(), null);
	}

	@RequestMapping("/bos/pg/deletePageAttr")
	public void deletePageAttr(@ModelAttribute("pageVO") PageVO pageVO, HttpServletResponse response, ModelMap model) throws Exception
	{
		pageGenerator.deletePageAttribute(pageVO, model);
		HttpUtil.goUrl(response, "/bos/pg/pageAttrList.do?menuNo="+pageVO.getMenuNo()+"&bbsId="+pageVO.getBbsId(), null);
	}

	@RequestMapping("/bos/pg/readPage")
	public String readPage(@ModelAttribute("pageVO") PageVO pageVO, ModelMap model) throws Exception
	{
		pageGenerator.readPageInfo(pageVO, model);
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/pg/Reg.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
	}

	@RequestMapping("/bos/pg/selectAllFieldList")
	public String getFieldAttributes(@ModelAttribute("pageVO") PageVO pageVO, ModelMap model) throws Exception
	{
		pageGenerator.selectAllFieldList(pageVO, model);
		return "bos/pg/fieldAttributeList";
	}

	@RequestMapping("/bos/pg/addFieldAttr")
	public void addFieldAttr(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception
	{
		ZValue zvl = WebFactory.getAttributes(request);
		pageGenerator.addFieldAttribute(zvl, model);
		HttpUtil.winCloseLocation(response, "/bos/pg/readPage.do?menuNo="+request.getParameter("menuNo")+"&pageCode="+zvl.getString("pageCode")+"&pageType="+zvl.getString("pageType")+"&bbsId="+zvl.getString("bbsId"), null);
	}

	@RequestMapping("/bos/pg/createPage")
	public void createPage(@ModelAttribute("pageVO") PageVO pageVO, HttpServletResponse response, ModelMap model) throws Exception
	{
		pageGenerator.createPage(pageVO, model);
		HttpUtil.goUrl(response, "/bos/pg/readPage.do?menuNo="+pageVO.getMenuNo()+"&pageCode="+pageVO.getPageCode()+"&pageType="+pageVO.getPageType()+"&bbsId="+pageVO.getBbsId(), "성공적으로 생성되었습니다.");
	}

	@RequestMapping("/bos/pg/sortFieldAttr")
	public void sortFieldAttr(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception
	{
		ZValue zvl = WebFactory.getAttributes(request);
		pageGenerator.updateFieldAttributeOrdr(zvl, model);
		HttpUtil.goUrl(response, "/bos/pg/readPage.do?menuNo="+request.getParameter("menuNo")+"&pageCode="+zvl.getString("pageCode")+"&pageType="+zvl.getString("pageType")+"&bbsId="+zvl.getString("bbsId"), null);
	}

}
