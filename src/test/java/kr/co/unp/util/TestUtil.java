package kr.co.unp.util;

import org.apache.commons.lang.ArrayUtils;
import org.junit.Test;


public class TestUtil {
	
	@Test
	public void test(){
		String s = "s";
		String[] a = StrUtils.split(s, "|");
		System.out.println(ArrayUtils.toString(a));
	}
}
