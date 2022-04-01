
package kr.co.unp.bbs.validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import kr.co.unp.bbs.vo.BoardVO;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Service("bbsValidator")
public class BbsValidator implements Validator {
	
	protected final String EMAIL_PATTERN = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	protected Pattern pattern;
	protected Matcher matcher;

	@Override
	public boolean supports(Class<?> clazz) {
		return BoardVO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object obj, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "nttSj", "required", "제목은 필수사항입니다.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "nttCn", "required", "내용은 필수사항입니다.");
		BoardVO vo = (BoardVO)obj;
		if( StringUtils.hasText(vo.getNtcrEmail1()) && StringUtils.hasText(vo.getNtcrEmail2()) ){
			String ntcrEmail = vo.getNtcrEmail1() + "@" + vo.getNtcrEmail2();
			pattern = Pattern.compile(EMAIL_PATTERN);
			matcher = pattern.matcher(ntcrEmail);
			if(!matcher.find()) errors.rejectValue("email", "", null, "이메일 형식에 맞지않습니다.");
		}
	}

}
