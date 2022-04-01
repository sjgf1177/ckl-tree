package kr.co.ckl.listener;

import java.util.ArrayList;

import kr.co.ckl.listener.DynamicFieldListener;
import kr.co.ckl.listener.EtcFieldVO;
import kr.co.ckl.listener.EtcFieldVO.Value;
import kr.co.ckl.listener.FieldVO;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

import org.junit.Before;
import org.junit.Test;
import org.springframework.ui.ModelMap;

public class DynamicFieldListenerTest {

	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void testDoAfter() throws Exception {
		ZValue param = new ZValue();
		param.put("fieldInfo", getFieldInfo());
		ModelMap model = new ModelMap();
		model.put("result", param);
		ParameterContext<ZValue> paramCtx = new ParameterContext<ZValue>();
		paramCtx.setParam(param);
		paramCtx.setTargetMethod("forInsert");
		paramCtx.setModel(model);

		DynamicFieldListener l = new DynamicFieldListener();
		l.after(paramCtx);
	}

	@Test
	public void testParse() throws Exception {
		EtcFieldVO vo = new EtcFieldVO();
		vo.setText("text1");
		vo.setType("radio");

		ArrayList<Value> values = new ArrayList<Value>();
		Value v = new Value();
		v.setCheckedYn("Y");
		v.setValue("val1");
		values.add(v);

		v = new Value();
		v.setCheckedYn("N");
		v.setValue("val2");
		values.add(v);
		vo.setValues(values);

		FieldVO fvo = new FieldVO();
		ArrayList<EtcFieldVO> etcData = new ArrayList<EtcFieldVO>();
		etcData.add(vo);
		fvo.setEtcData(etcData);

		System.out.println(fvo.toXml());

		System.out.println(FieldVO.parseFieldInfo(fvo.toXml()));
	}

	private String getFieldInfo(){
		FieldVO vo = new FieldVO();
		ArrayList<EtcFieldVO> etcData = new ArrayList<EtcFieldVO>();
		EtcFieldVO evo = new EtcFieldVO();
		evo.setText("txt1");
		evo.setType("radio");
		evo.setValue("val1");
		etcData.add(evo);
		vo.setEtcData(etcData);
		return vo.toXml();
	}

}
