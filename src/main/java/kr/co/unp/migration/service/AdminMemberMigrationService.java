
package kr.co.unp.migration.service;


import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.member.vo.UsersVO;

import org.apache.log4j.Logger;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service("adminMemberMigrationService")
public class AdminMemberMigrationService extends DefaultMigrationService<UsersVO> {
	
	@Resource(name = "passwordEncoder")
	protected PasswordEncoder passwordEncoder;

	Logger log = Logger.getLogger(this.getClass());
	
	public AdminMemberMigrationService(){
		super.setAsisCountQueryId("asisDAO.selectAsIsAdminUserCnt");
		super.setAsisListQueryId("asisDAO.selectAsIsAdminUser");
		super.setInsertQueryId("migrationDAO.insertAdminUser");
		super.setMaxQueryId("migrationDAO.selectMaxPlusUserIdx");
	}		
	
	@Override
	protected void initMigration(UsersVO paramVO) throws Exception{
		sqlDAO.deleteDAO("migrationDAO.deleteAdminMember", paramVO);
	}
	
	@Override
	protected void process(UsersVO paramVO, UsersVO resultVO) throws Exception{
		//비밀번호 암호화
		String password = resultVO.getPassword();
		resultVO.setPassword(passwordEncoder.encodePassword(password, null));
		

	}

	@Override
	protected void insertArticle(UsersVO mgVO) throws Exception{
		//nothing
	}	

	@Override
	protected void batchJob(UsersVO paramVO, List<UsersVO> resultList) throws Exception{
		sqlDAO.batchInsert(getInsertQueryId(), resultList);
	}

}
