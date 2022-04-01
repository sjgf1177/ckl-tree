package kr.co.ckl.search;

import java.util.HashMap;
import java.util.Map;

import kr.co.ckl.search.SearchService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

import org.junit.Before;
import org.junit.Test;
import org.springframework.ui.ModelMap;

public class SearchServiceTest {

	public static Map<String, String> categoryMap = new HashMap<String, String>();
	static{
		categoryMap.put("01", "매매체결시스템 > 거래소 > 주식매매 수작업처리");
	}

	@Before
	public void setUp() throws Exception {
		Map<String, String> category = SearchServiceTest.categoryMap;
	}

	@Test
	public void test() throws Exception {

		SearchService service = new SearchService();
		ParameterContext<ZValue> paramCtx = new ParameterContext<ZValue>();
		ZValue param = new ZValue();
		param.put("q", "뉴스");
		paramCtx.setParam(param);
		ModelMap model = new ModelMap();
		paramCtx.setModel(model);
		service.list(paramCtx);
	}

	@Test
	public void testCode() throws Exception {
		int i = 12593;
		System.out.println((char)i);
	}

	@Test
	public void testRelace() throws Exception {
		String s = "1|2|5|9|3";
		System.out.println(s.replaceAll("\\|", ","));
	}

}
