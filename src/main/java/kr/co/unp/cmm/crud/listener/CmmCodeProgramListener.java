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

public class CmmCodeProgramListener extends CmmProgramListenerSupport<ZValue> implements InitializingBean {

	Logger log = Logger.getLogger(this.getClass());

    @Resource(name="CmmnCodeDetailDAO")
    private CmmnCodeDetailDAO cmmnCodeDetailDAO;
    private List<String> codeIdData;
    private List<String> propertyNames;
    private List<String> targetPropertyNames;

    public CmmCodeProgramListener(){
    }

    public CmmCodeProgramListener(String codeId, String propertyName, String targetPropertyName){
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
		String targetMethod = paramCtx.getTargetMethod();
		if( "list".equals(targetMethod) || "listPop".equals(targetMethod) || "listMy".equals(targetMethod)){
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
		}
		else if( "forInsert".equals(targetMethod) || "entJoin03".equals(targetMethod)){
			for(int i=0; i<codeIdData.size(); i++){
				List<ZValue> codeList = getCodeList(codeIdData.get(i));
				model.addAttribute(codeIdData.get(i) + "CodeList", codeList);
			}
		}
		else if( "view".equals(targetMethod) || "forUpdate".equals(targetMethod) || "forUpdateAppInfo".equals(targetMethod) ){
			ZValue result = (ZValue)model.get("result");
			for(int i=0; i<codeIdData.size(); i++){
				List<ZValue> codeList = getCodeList(codeIdData.get(i));
				String codeName = cmmnCodeDetailDAO.getCodeName(result, codeList, propertyNames.get(i));
				PropertyUtils.setProperty(result, targetPropertyNames.get(i), codeName);

				model.addAttribute(codeIdData.get(i) + "CodeList", codeList);
			}
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
