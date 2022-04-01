package kr.co.unp.cmm.crud.interceptor;

import static org.mockito.Mockito.*;

import java.util.ArrayList;
import java.util.List;

import kr.co.unp.cmm.crud.interceptor.CommonCodeAdvice;
import kr.co.unp.cmmncode.dao.CmmnCodeDetailDAO;
import kr.co.unp.util.ZValue;

import org.junit.Test;




public class CommonCodeAdviceTest {

	@Test
	public void testInvoke() throws Exception {
		ZValue p = new ZValue();
		p.put("codeId", "COM012");
		List<ZValue> list = new ArrayList<ZValue>();
		ZValue r = new ZValue();
		r.put("codeId", "COM012");
		r.put("codeNm", "테스트1");
		r.put("code", "01");
		list.add(r);
		ZValue r1 = new ZValue();
		r1.put("codeId", "COM012");
		r1.put("codeNm", "테스트2");
		r1.put("code", "02");
		list.add(r1);

		CmmnCodeDetailDAO cdao = mock(CmmnCodeDetailDAO.class);
		when(cdao.getDetailCodeList(p)).thenReturn(list);

		List<String> codeIdData = new ArrayList<String>();
		codeIdData.add("COM012");

		List<String> propertyNames = new ArrayList<String>();
		propertyNames.add("p1");

		List<String> targetPropertyNames = new ArrayList<String>();
		targetPropertyNames.add("p2");

		CommonCodeAdvice<ZValue> ca = new CommonCodeAdvice<ZValue>();
		ca.setCmmnCodeDetailDAO(cdao);
		ca.setCodeIdData(codeIdData);
		ca.setPropertyNames(propertyNames);
		ca.setTargetPropertyNames(targetPropertyNames);

	}

}
