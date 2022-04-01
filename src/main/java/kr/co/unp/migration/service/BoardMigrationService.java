
package kr.co.unp.migration.service;

import kr.co.unp.bbs.vo.BoardVO;
import kr.co.unp.migration.vo.MigrationVO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service("boardMigrationService")
public class BoardMigrationService extends DefaultMigrationService<MigrationVO> {

	Logger log = Logger.getLogger(this.getClass());

	public BoardMigrationService(){
		super.setAsisCountQueryId("asisDAO.selectAsIsArticlesCnt");
		super.setAsisListQueryId("asisDAO.selectAsIsBbsArticles");
		super.setInsertQueryId("migrationDAO.insertBasicBoardArticle");
		super.setMaxQueryId("migrationDAO.selectMaxPlusNttId");
	}

	@Override
	protected void initMigration(MigrationVO paramVO) throws Exception{
		//if( paramVO.getCurrentSize() == 0 && !StringUtils.hasText(paramVO.getDeleteFileYn())){
/*			sqlDAO.deleteDAO("migrationDAO.deleteFile", paramVO);
			sqlDAO.deleteDAO("migrationDAO.deleteFileDetail", paramVO);
			sqlDAO.deleteDAO("migrationDAO.deleteBbs", paramVO);
			sqlDAO.deleteDAO("migrationDAO.deleteCommnet", paramVO);*/
		//}
	}
	/*
	@Override
	protected int getTotCnt(MigrationVO mgVO) throws Exception{
		return 10;
	}
	*/
	@Override
	protected void process(MigrationVO paramVO, MigrationVO resultVO) throws Exception{

		resultVO.setNttId(maxPlusNttId);
		resultVO.setBbsId(paramVO.getBbsId());
		if( !StringUtils.hasText(resultVO.getNttType()) ) resultVO.setNttType(BoardVO.BASIC_NTT_TYPE);
		if( !StringUtils.hasText(resultVO.getSecret()) ) resultVO.setSecret(BoardVO.PUBLIC);
		if( !StringUtils.hasText(resultVO.getUseAt()) ) resultVO.setUseAt(BoardVO.USE);
		if( !StringUtils.hasText(resultVO.getHtmlYn()) ) resultVO.setHtmlYn("Y");
		if( !StringUtils.hasText(resultVO.getDelCode()) ) resultVO.setDelCode(BoardVO.NON_DELETION);
		if( resultVO.getNttCn() == null ) resultVO.setNttCn("");

	}
}
