package kr.co.unp.cmm.crud.service;

import java.util.List;

import javax.annotation.Resource;

import com.siren24.Base64;

import net.sf.json.JSONArray;

import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.cmmncode.dao.CmmnCodeDetailDAO;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.ZValue;

public class DefaultCmmProgramService extends AbstractCmmProgramService<ZValue> {

	//공통상세코드 dao
    @Resource(name="CmmnCodeDetailDAO")
    private CmmnCodeDetailDAO cmmnCodeDetailDAO;

    @Resource(name = "lmsSqlDAO")
	protected ISqlDAO<ZValue> lmsSqlDao;

	public void initCmmnParam(ZValue param) throws Exception {
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();

		if (UnpUserDetailsHelper.isAuthenticated()) {
			param.put("frstRegisterId", user.getUserIdx());
			param.put("lastUpdusrId", user.getUserIdx());
			//param.put("userSn", user.getUserIdx());
		}

		if ("".equals(param.getString("pageUnit",""))) {
			param.put("pageUnit", "10");
		}
		if ("".equals(param.getString("pageSize",""))) {
			param.put("pageSize", "10");
		}
		if ((SiteMngService.CKLMOBILE_SITE_NAME).equals(param.getString("siteName")) || (SiteMngService.EDUMOBILE_SITE_NAME).equals(param.getString("siteName"))) {
			param.put("pageSize", "3");
			if ( (SiteMngService.EDUMOBILE_SITE_NAME).equals(param.getString("siteName")) )
				param.put("pageSize", "10");//현장교육 rsg20171214pm0635
		}
	}

	/**
	 * jsondata String => List
	 * @description base64 encode 처리하여 넘겨야함..
	 * @param jsonStr
	 * @return
	 * @throws Exception
	 */
	public List<ZValue> getJsonConvertZValueList(String jsonStr)  throws Exception {

		List<ZValue> list = null;
		if (jsonStr != null && !"".equals(jsonStr)) {
			jsonStr = new String(Base64.base64Decode(jsonStr.getBytes("UTF-8")), "UTF-8");
			JSONArray jsonArray = JSONArray.fromObject(jsonStr);
			list = JSONArray.toList(jsonArray,ZValue.class);
		}
		return list;
	}

	public List<ZValue> codeList(String codeId,String upperCode) throws Exception {
		ZValue zvl = new ZValue();
		zvl.put("codeId", codeId);
		zvl.put("upperCode", upperCode);
		List<ZValue> codeResult = cmmnCodeDetailDAO.getDetailCodeList(zvl);
		return codeResult;
	}

	public List<ZValue> codeList(String codeId) throws Exception {
		return this.codeList(codeId,null);
	}

}
