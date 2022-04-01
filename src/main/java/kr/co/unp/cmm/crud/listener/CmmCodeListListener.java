package kr.co.unp.cmm.crud.listener;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmmncode.dao.CmmnCodeDetailDAO;
import kr.co.unp.util.ZValue;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;

public class CmmCodeListListener extends CmmProgramListenerSupport<ZValue> implements InitializingBean {

	Logger log = Logger.getLogger(this.getClass());

    @Resource(name="CmmnCodeDetailDAO")
    protected CmmnCodeDetailDAO cmmnCodeDetailDAO;
    protected List<String> codeIdData;
    protected List<String> propertyNames;
    protected List<String> targetPropertyNames;

    public CmmCodeListListener(){
    }

    public CmmCodeListListener(String codeId, String propertyName, String targetPropertyName){
    	codeIdData = new ArrayList<String>();
    	propertyNames = new ArrayList<String>();
    	targetPropertyNames = new ArrayList<String>();
    	codeIdData.add(codeId);
    	propertyNames.add(propertyName);
    	targetPropertyNames.add(targetPropertyName);
    }

	@Override
	public boolean doAfter(ParameterContext<ZValue> paramCtx) throws Exception {

		ModelMap model = paramCtx.getModel();
		@SuppressWarnings("unchecked")
		List<ZValue> resultList = (List<ZValue>)model.get("resultList");
		for(int i=0; i<codeIdData.size(); i++){
			List<ZValue> codeList = getCodeList(codeIdData.get(i));
			for(ZValue vo : resultList)
			{
				String codeName = cmmnCodeDetailDAO.getCodeName(vo, codeList, propertyNames.get(i));
				PropertyUtils.setProperty(vo, targetPropertyNames.get(i), codeName);
			}
			model.addAttribute(codeIdData.get(i) + "CodeList", codeList);
		}
		return CONTINUE;
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		Assert.notEmpty(codeIdData);
		Assert.notEmpty(propertyNames);
		Assert.notEmpty(targetPropertyNames);

		int codeIdDataSize = codeIdData.size();
		int propertyNameSize = propertyNames.size();
		int targetPropertyNameSize = targetPropertyNames.size();
		if( !(codeIdDataSize == propertyNameSize && propertyNameSize == targetPropertyNameSize) )
			throw new IllegalArgumentException("codeIdData 크기와 property 크기와 targetProperty 크기가 같지않습니다.");
	}

	public List<ZValue> getCodeList(String codeId) throws Exception
	{
		Assert.hasText(codeId);

		ZValue zvl = new ZValue();
		zvl.put("codeId", codeId);
		List<ZValue> codeResult = cmmnCodeDetailDAO.getDetailCodeList(zvl);
		return codeResult;
	}

	public List<ZValue> getCodeDepthList(String codeId, String upperCode) throws Exception
	{
		Assert.hasText(codeId);

		ZValue zvl = new ZValue();
		zvl.put("codeId", codeId);
		zvl.put("upperCode", upperCode);

		List<ZValue> codeResult = cmmnCodeDetailDAO.getDetailCodeList(zvl);
		return codeResult;
	}

	public CmmnCodeDetailDAO getCmmnCodeDetailDAO() {
		return cmmnCodeDetailDAO;
	}

	public void setCmmnCodeDetailDAO(CmmnCodeDetailDAO cmmnCodeDetailDAO) {
		this.cmmnCodeDetailDAO = cmmnCodeDetailDAO;
	}

	public List<String> getCodeIdData() {
		return codeIdData;
	}

	public List<String> getPropertyNames() {
		return propertyNames;
	}

	public List<String> getTargetPropertyNames() {
		return targetPropertyNames;
	}

	public void setCodeIdData(List<String> codeIdData) {
		this.codeIdData = codeIdData;
	}

	public void setPropertyNames(List<String> propertyNames) {
		this.propertyNames = propertyNames;
	}

	public void setTargetPropertyNames(List<String> targetPropertyNames) {
		this.targetPropertyNames = targetPropertyNames;
	}
}
