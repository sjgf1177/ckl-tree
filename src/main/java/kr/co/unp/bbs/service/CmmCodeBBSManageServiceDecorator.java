package kr.co.unp.bbs.service;

import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.service.DefaultFnwBBSManageServiceDecorator;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmmncode.dao.CmmnCodeDetailDAO;
import kr.co.unp.util.ZValue;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;

public class CmmCodeBBSManageServiceDecorator extends DefaultFnwBBSManageServiceDecorator implements InitializingBean {

	@Resource(name = "CmmnCodeDetailDAO")
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
		if (!(codeIdDataSize == propertyNameSize && propertyNameSize == targetPropertyNameSize))
			throw new IllegalArgumentException("codeIdData 크기와 property 크기와 targetProperty 크기가 같지않습니다.");
	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {

		super.list(paramCtx);

		ModelMap model = paramCtx.getModel();
		@SuppressWarnings("unchecked")
		List<ZValue> resultList = (List<ZValue>) model.get("resultList");
		for (int i = 0; i < codeIdData.size(); i++) {
			List<ZValue> codeList = getCodeList(codeIdData.get(i));
			if (CollectionUtils.isNotEmpty(resultList)) {
				for (ZValue vo : resultList) {
					String codeName = cmmnCodeDetailDAO.getCodeName(vo, codeList, propertyNames.get(i));
					PropertyUtils.setProperty(vo, targetPropertyNames.get(i), codeName);
				}
			}
			model.addAttribute(codeIdData.get(i) + "CodeList", codeList);
		}

	}

	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		super.forInsert(paramCtx);

		ModelMap model = paramCtx.getModel();
		for (int i = 0; i < codeIdData.size(); i++) {
			List<ZValue> codeList = getCodeList(codeIdData.get(i));
			model.addAttribute(codeIdData.get(i) + "CodeList", codeList);
		}
	}

	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		super.view(paramCtx);

		ModelMap model = paramCtx.getModel();
		ZValue result = (ZValue) model.get("result");
		for (int i = 0; i < codeIdData.size(); i++) {
			List<ZValue> codeList = getCodeList(codeIdData.get(i));
			String codeName = cmmnCodeDetailDAO.getCodeName(result, codeList, propertyNames.get(i));
			PropertyUtils.setProperty(result, targetPropertyNames.get(i), codeName);

			model.addAttribute(codeIdData.get(i) + "CodeList", codeList);
		}
	}

	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		super.forUpdate(paramCtx);

		ModelMap model = paramCtx.getModel();
		for (int i = 0; i < codeIdData.size(); i++) {
			List<ZValue> codeList = getCodeList(codeIdData.get(i));
			model.addAttribute(codeIdData.get(i) + "CodeList", codeList);
		}
	}

	public List<ZValue> getCodeList(String codeId) throws Exception {
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
