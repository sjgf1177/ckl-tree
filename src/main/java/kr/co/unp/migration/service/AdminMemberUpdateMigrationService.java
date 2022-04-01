
package kr.co.unp.migration.service;


import java.util.List;

import kr.co.unp.member.vo.UsersVO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service("adminMemberUpdateMigrationService")
public class AdminMemberUpdateMigrationService extends DefaultMigrationService<UsersVO> {

	Logger log = Logger.getLogger(this.getClass());

	public AdminMemberUpdateMigrationService(){
		super.setAsisCountQueryId("asisDAO.selectAsIsAdminUserCnt");
		super.setAsisListQueryId("asisDAO.selectAsIsAdminUser");
		super.setInsertQueryId("migrationDAO.insertAdminUser");
		super.setMaxQueryId("migrationDAO.selectMaxPlusUserIdx");
	}

	@Override
	protected void initMigration(UsersVO paramVO) throws Exception{
		//sqlDAO.deleteDAO("migrationDAO.deleteAdminMember", paramVO);
	}

	@Override
	protected void process(UsersVO paramVO, UsersVO resultVO) throws Exception{
		sqlDAO.updateDAO("migrationDAO.updateAdminMemberInfo", resultVO);
	}

	@Override
	protected void insertArticle(UsersVO mgVO) throws Exception{
		//nothing
	}

	@Override
	protected void batchJob(UsersVO paramVO, List<UsersVO> resultList) throws Exception{
		//nothing
	}

}
