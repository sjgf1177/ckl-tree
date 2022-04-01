package kr.co.unp.cmm.crud.interceptor;

import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmmncode.dao.CmmnCodeDetailDAO;
import kr.co.unp.util.ZValue;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;

public class CommonCodeAdvice<T> implements MethodInterceptor, InitializingBean{

    @Resource(name="CmmnCodeDetailDAO")
    private CmmnCodeDetailDAO cmmnCodeDetailDAO;
    private List<String> codeIdData;
    private List<String> propertyNames;
    private List<String> targetPropertyNames;

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

	@SuppressWarnings("unchecked")
	@Override
	public Object invoke(MethodInvocation mi) throws Throwable {
		Object ret = mi.proceed();
		Object[] args = mi.getArguments();
		ParameterContext<ZValue> paramCtx = (ParameterContext<ZValue>)args[0];
		ModelMap model = paramCtx.getModel();
		String methodName = mi.getMethod().getName();
		if( "list".equals(methodName) ){
			List<T> resultList = (List<T>)model.get("resultList");

			for(int i=0; i<codeIdData.size(); i++){
				List<ZValue> codeList = getCodeList(codeIdData.get(i));
				for(T vo : resultList)
				{
					String codeName = cmmnCodeDetailDAO.getCodeName(vo, codeList, propertyNames.get(i));
					PropertyUtils.setProperty(vo, targetPropertyNames.get(i), codeName);
				}
				model.addAttribute(codeIdData.get(i) + "CodeList", codeList);
			}
		}
		else if( "forInsert".equals(methodName) ){
			for(int i=0; i<codeIdData.size(); i++){
				List<ZValue> codeList = getCodeList(codeIdData.get(i));
				model.addAttribute(codeIdData.get(i) + "CodeList", codeList);
			}
		}
		else if( "view".equals(methodName) ){
			T result = (T)model.get("result");
			for(int i=0; i<codeIdData.size(); i++){
				List<ZValue> codeList = getCodeList(codeIdData.get(i));
				String codeName = cmmnCodeDetailDAO.getCodeName(result, codeList, propertyNames.get(i));
				PropertyUtils.setProperty(result, targetPropertyNames.get(i), codeName);

				model.addAttribute(codeIdData.get(i) + "CodeList", codeList);
			}
		}
		else if( "forUpdate".equals(methodName) ){
			for(int i=0; i<codeIdData.size(); i++){
				List<ZValue> codeList = getCodeList(codeIdData.get(i));
				model.addAttribute(codeIdData.get(i) + "CodeList", codeList);
			}
		}
		return ret;
	}

	public List<ZValue> getCodeList(String codeId) throws Exception
	{
		Assert.hasText(codeId);

		ZValue zvl = new ZValue();
		zvl.put("codeId", codeId);
		List<ZValue> codeResult = cmmnCodeDetailDAO.getDetailCodeList(zvl);
		return codeResult;
	}

	public void setCmmnCodeDetailDAO(CmmnCodeDetailDAO cmmnCodeDetailDAO) {
		this.cmmnCodeDetailDAO = cmmnCodeDetailDAO;
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
