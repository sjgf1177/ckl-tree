package kr.co.unp.pg.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.bbs.service.FnwBBSManager;
import kr.co.unp.pg.vo.FieldAttributeVO;
import kr.co.unp.pg.vo.PageVO;

public class BbsPageTemplate extends PageTemplateImpl
{
	@Resource(name = "fnwBBSManager")
	protected FnwBBSManager fnwBBSManager;

	@Override
	public List<FieldAttributeVO> selectAllFieldList(PageVO pvo) throws Exception {
		/*
		String bbsId = pvo.getBbsId();
		String tableName = TABLE_NAME;
		if( StringUtils.hasText(bbsId) ){
			BoardMasterVO masterVO = fnwBBSManager.getMasterVO(bbsId);
			tableName = masterVO.getTableNm();
		}
		return pageGeneratorDAO.selectAllFieldList(tableName);
		*/
		//BoardMasterVO masterVO = fnwBBSManager.getMasterVO(bbsId);
		pvo.setTableName(TABLE_NAME);

		List<FieldAttributeVO> resultList = new ArrayList<FieldAttributeVO>();
		FieldAttributeVO vo = new FieldAttributeVO();
		vo.setFieldName("GUBUN");
		vo.setFieldText("구분");
		vo.setFieldType("");
		resultList.add(vo);

		vo = new FieldAttributeVO();
		vo.setFieldName("SECRET");
		vo.setFieldText("공개여부");
		vo.setFieldType("");
		resultList.add(vo);

		vo = new FieldAttributeVO();
		vo.setFieldName("NTT_SJ");
		vo.setFieldText("제목");
		vo.setFieldType("text");
		resultList.add(vo);

		vo = new FieldAttributeVO();
		vo.setFieldName("DEPT_NAME");
		vo.setFieldText("사업부");
		vo.setFieldType("empty");
		resultList.add(vo);

		vo = new FieldAttributeVO();
		vo.setFieldName("NTCR_NM");
		vo.setFieldText("작성자");
		vo.setFieldType("text");
		resultList.add(vo);

		vo = new FieldAttributeVO();
		vo.setFieldName("NTCR_TEL");
		vo.setFieldText("전화번호");
		vo.setFieldType("");
		resultList.add(vo);

		vo = new FieldAttributeVO();
		vo.setFieldName("NTCR_MOBILE");
		vo.setFieldText("핸드폰번호");
		vo.setFieldType("");
		resultList.add(vo);

		vo = new FieldAttributeVO();
		vo.setFieldName("NTCR_EMAIL");
		vo.setFieldText("이메일");
		vo.setFieldType("");
		resultList.add(vo);

		vo = new FieldAttributeVO();
		vo.setFieldName("NTCR_ZIPCODE");
		vo.setFieldText("우편번호");
		vo.setFieldType("");
		resultList.add(vo);

		vo = new FieldAttributeVO();
		vo.setFieldName("NTCR_ADDR1");
		vo.setFieldText("기본주소");
		vo.setFieldType("");
		resultList.add(vo);

		vo = new FieldAttributeVO();
		vo.setFieldName("NTCR_ADDR2");
		vo.setFieldText("상세주소");
		vo.setFieldType("");
		resultList.add(vo);

		vo = new FieldAttributeVO();
		vo.setFieldName("NTT_CN");
		vo.setFieldText("내용");
		vo.setFieldType("text");
		resultList.add(vo);

		vo = new FieldAttributeVO();
		vo.setFieldName("ATCH_FILE_ID");
		vo.setFieldText("첨부");
		vo.setFieldType("empty");
		resultList.add(vo);

		for(int i=1; i<=15; i++){
			vo = new FieldAttributeVO();
			vo.setFieldName("OPTION" + i);
			vo.setFieldText("");
			resultList.add(vo);
		}

		vo = new FieldAttributeVO();
		vo.setFieldName("FRST_REGISTER_PNTTM");
		vo.setFieldText("등록일");
		vo.setFieldType("empty");
		resultList.add(vo);

		vo = new FieldAttributeVO();
		vo.setFieldName("INQIRE_CO");
		vo.setFieldText("조회수");
		vo.setFieldType("empty");
		resultList.add(vo);

		vo = new FieldAttributeVO();
		vo.setFieldName("REPLY_AT");
		vo.setFieldText("답변상태");
		vo.setFieldType("");
		resultList.add(vo);

		List<FieldAttributeVO> fieldAttributes = pageGeneratorDAO.selectAllFieldList(pvo);
		for(FieldAttributeVO fvo : resultList){
			for(FieldAttributeVO _fvo : fieldAttributes){
				if(fvo.getFieldName().equals(_fvo.getFieldName())){
					fvo.setCheckedYn("Y");
					fvo.setFieldType(_fvo.getFieldType());
					fvo.setFieldText(_fvo.getFieldText());
					fvo.setFieldList(_fvo.getFieldList());
				}
			}
		}
		return resultList;
	}

}
