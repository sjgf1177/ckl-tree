package kr.co.unp.cmm.crud.listener;

import java.util.List;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

public class CmmCodeViewListener extends CmmCodeListListener {

	Logger log = Logger.getLogger(this.getClass());

	public CmmCodeViewListener() {
	}

    public CmmCodeViewListener(String codeId, String propertyName, String targetPropertyName) {
    	super(codeId, propertyName, targetPropertyName);
    }

	@Override
	public boolean doAfter(ParameterContext<ZValue> paramCtx) throws Exception {

		ModelMap model = paramCtx.getModel();
		ZValue result = (ZValue)model.get("result");
		@SuppressWarnings("unchecked")
		List<ZValue> resultList = (List<ZValue>)model.get("resultList");
		for(int i=0; i<getCodeIdData().size(); i++){
			List<ZValue> codeList = getCodeList(getCodeIdData().get(i));
			if( result != null ) {
				String codeName = getCmmnCodeDetailDAO().getCodeName(result, codeList, getPropertyNames().get(i));
				result.put(getTargetPropertyNames().get(i), codeName);
			}
			if (model.get("resultList") != null) {
				for(ZValue vo : resultList)
				{
					String codeName = cmmnCodeDetailDAO.getCodeName(vo, codeList, propertyNames.get(i));
					PropertyUtils.setProperty(vo, targetPropertyNames.get(i), codeName);
				}
			}

			model.addAttribute(getCodeIdData().get(i) + "CodeList", codeList);
		}
		return CONTINUE;
	}
}
