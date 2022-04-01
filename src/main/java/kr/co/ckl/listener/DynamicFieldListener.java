package kr.co.ckl.listener;

import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.listener.CmmProgramListenerSupport;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.cmm.file.service.FnwFileMngService;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

public class DynamicFieldListener extends CmmProgramListenerSupport<ZValue> {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "fnwFileMngService")
    private FnwFileMngService fnwFileMngService;
	@Resource(name = "SqlDAO")
    private ISqlDAO<ZValue> sqlDao;
	private String filePrefix = "value_";
	private String fieldInfoUpdateQuery = "";
	private String resultName = "entResult";
	private String atchFileIdName = "atchFileId";

	@Override
	public boolean doAfter(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		String targetMethod = paramCtx.getTargetMethod();
		if( "forInsert".equals(targetMethod) ){
			ZValue result = (ZValue)model.get(getResultName());
			if( result != null ){
				String fieldInfo = result.getString("fieldInfo");
				log.debug("xml fieldInfo : " + fieldInfo);
				FieldVO fieldVO = null;
				if( StringUtils.hasText(fieldInfo) ){
					fieldVO = FieldVO.parseFieldInfo(fieldInfo);
					log.debug("parsed field info : " + fieldVO);
					model.addAttribute("fieldInfoVO", fieldVO);
				}
			}
		}
		else if( "view".equals(targetMethod) ||  "forUpdate".equals(targetMethod) ){
			ZValue result = (ZValue)model.get(getResultName());
			if( result != null ){
				String xml = result.getString("fieldInfo");
				if( StringUtils.hasText(xml) ){
					FieldVO fieldVO = FieldVO.parseFieldInfo(xml);
					result.put("fieldVO", fieldVO);
				}
			}
		}
		else if( "insert".equals(targetMethod) ||  "update".equals(targetMethod) ){
			String atchFileId = param.getString(getAtchFileIdName());
			if( StringUtils.hasText(atchFileId) ){
				FileVO vo = new FileVO();
				vo.setAtchFileId(atchFileId);
				List<FileVO> files = fnwFileMngService.selectFileInfs(vo);
				if( CollectionUtils.isNotEmpty(files) ){
					for(int i=0; i<files.size(); i++){
						FileVO fileVO = files.get(i);
						String ffn = fileVO.getFileFieldName();
						if( ffn.startsWith(getFilePrefix()) ){
							param.putObject(ffn, fileVO.getFileSn());
							param.putObject("checkedYn_" + StrUtils.replace(ffn, "value_", ""), "Y");
						}
					}
				}
			}

			String fieldInfo = FieldVO.toXml(param);
			log.debug("init method fieldInfo : {}", fieldInfo);
			param.put("fieldInfo", fieldInfo);

			if( StringUtils.hasText(atchFileId) ) {
				sqlDao.updateDAO(fieldInfoUpdateQuery, param);
			}
		}

		return CONTINUE;
	}

	public String getResultName() {
		return resultName;
	}

	public void setResultName(String resultName) {
		this.resultName = resultName;
	}

	public String getFilePrefix() {
		return filePrefix;
	}

	public void setFilePrefix(String filePrefix) {
		this.filePrefix = filePrefix;
	}

	public ISqlDAO<ZValue> getSqlDao() {
		return sqlDao;
	}

	public void setSqlDao(ISqlDAO<ZValue> sqlDao) {
		this.sqlDao = sqlDao;
	}

	public String getFieldInfoUpdateQuery() {
		return fieldInfoUpdateQuery;
	}

	public void setFieldInfoUpdateQuery(String fieldInfoUpdateQuery) {
		this.fieldInfoUpdateQuery = fieldInfoUpdateQuery;
	}

	public String getAtchFileIdName() {
		return atchFileIdName;
	}

	public void setAtchFileIdName(String atchFileIdName) {
		this.atchFileIdName = atchFileIdName;
	}

}
