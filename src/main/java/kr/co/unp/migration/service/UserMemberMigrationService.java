
package kr.co.unp.migration.service;


import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.member.vo.UsersVO;

import org.apache.log4j.Logger;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service("userMemberMigrationService")
public class UserMemberMigrationService extends DefaultMigrationService<UsersVO> {

	@Resource(name = "passwordEncoder")
	protected PasswordEncoder passwordEncoder;

	Logger log = Logger.getLogger(this.getClass());

	public UserMemberMigrationService(){
		super.setAsisCountQueryId("asisDAO.selectAsIsUserCnt");
		super.setAsisListQueryId("asisDAO.selectAsIsUser");
		super.setInsertQueryId("migrationDAO.insertUserMember");
		super.setMaxQueryId("migrationDAO.selectMaxPlusUserIdx");
	}

	@Override
	protected void initMigration(UsersVO paramVO) throws Exception{
		//sqlDAO.deleteDAO("migrationDAO.deleteUserMember", paramVO);
	}

	@Override
	protected void process(UsersVO paramVO, UsersVO resultVO) throws Exception{
		resultVO.setUserIdx(maxPlusNttId);
		//비밀번호 암호화
		String password = resultVO.getPassword();
		resultVO.setPassword(passwordEncoder.encodePassword(password, null));
		resultVO.setUserKey(resultVO.getDupInfo());

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
