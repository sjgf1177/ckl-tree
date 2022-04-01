package kr.co.unp.auth.web;

import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AuthoDeptMenuController
{    
	protected Log log = LogFactory.getLog(this.getClass());

    @Resource(name = "webFactory")
    protected WebFactory WebFactory;

	/**
     * 부서장이 담당자별 권한주기
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/admin/portal/deptMenuCreatSelect.do")
    public String EgovDeptMenuCreatSelect(
			HttpServletRequest request,
    		ModelMap model)
            throws Exception { 

    	UsersVO adminUser = UnpUserDetailsHelper.getAuthenticatedUser();	
        model.addAttribute("adminUser", adminUser);
      	return "sym/mpm/EgovDeptMenuCreat";  
    }

    @RequestMapping("/admin/portal/deptMenuCreatInsert.do")
    public void EgovDeptMenuCreatInsert(
			HttpServletRequest request,
            HttpServletResponse response,
            ModelMap model)
            throws Exception {
    	
    	ZValue zvl = WebFactory.getAttributes(request);
    	
    	Set<String> menuNoSet = new HashSet<String>();
    	String[] checkFieldes = request.getParameterValues("checkField");
    	if(checkFieldes != null)
    	{
    		String checkField = null;
    		String[] menuNoData = null;
    		for(int i=0; i<checkFieldes.length; i++)
    		{
    			checkField = checkFieldes[i];
    			menuNoData = checkField.split("_");
    			for(int j=0; j<menuNoData.length; j++)
    			{
    				menuNoSet.add(menuNoData[j]);
    			}
    		}
    	}
    	
    	Object[] menuNoDataA = menuNoSet.toArray();
    	String checkedMenuNoForInsert = "";
    	if(menuNoDataA != null)
    	{
    		for(int i=0; i<menuNoDataA.length; i++)
    		{
    			checkedMenuNoForInsert += menuNoDataA[i] + ",";
    		}
    	}
    	
    	zvl.put("checkedMenuNoForInsert", checkedMenuNoForInsert);
    	
    	String resultMsg = "성공적으로 등록되었습니다.";
    	log.debug("###############zvl : " + zvl);
    	WebFactory.printHtml(response, resultMsg, "javascript:history.back();");
    }

}
