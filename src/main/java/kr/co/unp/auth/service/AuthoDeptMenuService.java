package kr.co.unp.auth.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.auth.dao.AuthoDeptMenuDAO;
import kr.co.unp.cmm.sec.ram.service.DeptAuthor;
import kr.co.unp.cmm.sec.ram.service.impl.DeptAuthorDAO;
import kr.co.unp.mpm.vo.MenuCreatVO;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

@Service("authoDeptMenuService")
public class AuthoDeptMenuService{

	@Resource(name="authoDeptMenuDAO")
	private AuthoDeptMenuDAO authoDeptMenuDAO;

	@Resource(name="deptAuthorDAO")
    private DeptAuthorDAO deptAuthorDAO;

	public void insertDeptMenuCreat_S(ZValue zvl) throws Exception
	{
		authoDeptMenuDAO.insertDeptMenuCreat_S(zvl);
	}

	public void deleteDeptMenuCreat_S(String mapcreatId) throws Exception
	{
		authoDeptMenuDAO.deleteDeptMenuCreat_S(mapcreatId);
	}

	public int selectDeptMenuCreatCnt_S(String mapcreatId) throws Exception
	{
		return authoDeptMenuDAO.selectDeptMenuCreatCnt_S(mapcreatId);
	}

	public List selectDeptMenuCreat_S(ZValue zvl) throws Exception
	{
		return authoDeptMenuDAO.selectDeptMenuCreat_S(zvl);
	}

	public void insertDeptMenuCreatList(ZValue zvl) throws Exception
	{
		String checkedMenuNoForInsert = zvl.getString("checkedMenuNoForInsert");
		//String checkedAuthorForInsert = zvl.getString("checkedAuthorForInsert");
		//롤권한부여가 아닌 담당자별 메뉴직접지정은 기본 롤 ROLE_ANONYMOUS으로 적용함
		String checkedAuthorForInsert = "ROLE_ANONYMOUS";

		String mapcreatId = zvl.getString("mapcreatId");

		//담당자 권한등록및 수정
		/**
		 * TODO : 2010.08.09 임시 주석
		 */
//		int authIdCnt = deptAuthorDAO.selectDeptAuthorCntById(mapcreatId);
		DeptAuthor deptAuthor = new DeptAuthor();
		deptAuthor.setUniqId(mapcreatId);
		deptAuthor.setAuthorCode(checkedAuthorForInsert);
//		if(authIdCnt > 0)
//			deptAuthorDAO.updateDeptAuthor(deptAuthor);
//		else
//			deptAuthorDAO.insertDeptAuthor(deptAuthor);

		MenuCreatVO menuCreatVO = null;
		int AuthorCnt    = 0;
		String [] insertMenuNo = checkedMenuNoForInsert.split(",");

		String     insertAuthor = checkedAuthorForInsert;
		menuCreatVO = new MenuCreatVO();
		menuCreatVO.setAuthorCode(insertAuthor);
		AuthorCnt = authoDeptMenuDAO.selectDeptMenuCreatCnt_S(mapcreatId);

        // 이전에 존재하는 권한코드에 대한 메뉴설정내역 삭제
		if(AuthorCnt>0){
			authoDeptMenuDAO.deleteDeptMenuCreat_S(mapcreatId);
		}
		for (int i=0; i<insertMenuNo.length ; i++){
			if(!"".equals(insertMenuNo[i]))
			{
				ZValue param = new ZValue();
				param.put("authorCode", insertAuthor);
				param.put("menuNo", insertMenuNo[i]);
				param.put("mapcreatId", mapcreatId);
				authoDeptMenuDAO.insertDeptMenuCreat_S(param);
			}
		}
	}

	public List selectProgramList(String siteId) throws Exception
	{
		return authoDeptMenuDAO.selectProgramList(siteId);
	}

	public void insertProgramList(ZValue zvl) throws Exception
	{
		if(authoDeptMenuDAO.existMenuNoInProgramList(zvl.getString("menuNo")) > 0)
		{
			authoDeptMenuDAO.updateProgramList(zvl);
		}
		else
		{
			authoDeptMenuDAO.insertProgramList(zvl);
		}
	}

	public synchronized void processChangeInPersonnel() throws Exception {
		registNewEmployeeAuthor();
		releaseChangeInPersonnel();
	}

	/**
	 * 신규회원 권한롤(ROLE_사번) 자동생성후 해당 관리자에게 권한롤 부여
	 */
	public void registNewEmployeeAuthor() throws Exception {
		List<ZValue> newEmpList = authoDeptMenuDAO.selectNewEmployee();
		if(!CollectionUtils.isEmpty(newEmpList))
		{
			authoDeptMenuDAO.insertNewEmployeeAuthor();

			for(ZValue z : newEmpList)
			{
				DeptAuthor deptAuthor = new DeptAuthor();
	    		deptAuthor.setUniqId(z.getString("userId"));
	    		deptAuthor.setAuthorCode(z.getString("authorCode"));
	    		deptAuthorDAO.insertDeptAuthor(deptAuthor);
			}
		}
	}


	public void releaseChangeInPersonnel() throws Exception {
		List<ZValue> changedList = authoDeptMenuDAO.selectChangeInPersonnelList(null); //부서이동 리스트
		if( !CollectionUtils.isEmpty(changedList) )
		{
			List<String> authorCodeData = new ArrayList<String>();

			for(ZValue val : changedList)
			{
				ZValue param = new ZValue();
				param.put("authorCode", val.getString("authorCode"));
				param.put("authorDeptId", val.getString("deptId"));
				authoDeptMenuDAO.updateAuthorDeptId(param); //이동된 부서로 변경

				authorCodeData.add(val.getString("authorCode"));
			}

			ZValue zvl = new ZValue();
			if( !CollectionUtils.isEmpty(authorCodeData) )
			{
				zvl.put("authorCodeData", authorCodeData);
				authoDeptMenuDAO.releaseChangeInPersonnel(zvl);
			}
		}
	}

}
