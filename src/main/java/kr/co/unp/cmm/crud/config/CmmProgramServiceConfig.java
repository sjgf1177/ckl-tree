package kr.co.unp.cmm.crud.config;

import java.util.ArrayList;
import java.util.List;

import kr.co.unp.cmm.crud.interceptor.CommonCodeAdvice;
import kr.co.unp.util.ZValue;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CmmProgramServiceConfig {

	@Bean
	public CommonCodeAdvice<ZValue> testCommonCodeAdvice(){
		List<String> codeIdData = new ArrayList<String>();
		codeIdData.add("COM083");
		List<String> propertyNames = new ArrayList<String>();
		propertyNames.add("siteName");
		List<String> targetPropertyNames = new ArrayList<String>();
		targetPropertyNames.add("siteName");
		CommonCodeAdvice<ZValue> advice = new CommonCodeAdvice<ZValue>();
		advice.setCodeIdData(codeIdData);
		advice.setPropertyNames(propertyNames);
		advice.setTargetPropertyNames(targetPropertyNames);
		return advice;
	}
}
