
package kr.co.unp.migration.service;


import java.util.List;

import kr.co.unp.member.vo.UsersVO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service("userMemberUpdateMigrationService")
public class UserMemberUpdateMigrationService extends DefaultMigrationService<UsersVO> {

	Logger log = Logger.getLogger(this.getClass());

	public UserMemberUpdateMigrationService(){
		super.setAsisCountQueryId("asisDAO.selectAsIsUserCnt");
		super.setAsisListQueryId("asisDAO.selectAsIsUser");
		super.setInsertQueryId("memberDAO.insertUserMember");
		super.setMaxQueryId("migrationDAO.selectMaxPlusUserIdx");
	}

	@Override
	protected void initMigration(UsersVO paramVO) throws Exception{
		//sqlDAO.deleteDAO("migrationDAO.deleteUserMember", paramVO);
	}

	@Override
	protected void process(UsersVO paramVO, UsersVO resultVO) throws Exception{

		sqlDAO.updateDAO("migrationDAO.updateUserMemberInfo", resultVO);
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
