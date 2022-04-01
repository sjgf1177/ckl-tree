
package kr.co.unp.migration.service;

import java.util.List;

import kr.co.unp.dept.vo.DeptVO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service("deptMigrationService")
public class DeptMigrationService extends DefaultMigrationService<DeptVO> {

	Logger log = Logger.getLogger(this.getClass());
	
	public DeptMigrationService(){
		super.setAsisCountQueryId("asisDAO.selectAsIsDeptCnt");
		super.setAsisListQueryId("asisDAO.selectAsIsDept");
		super.setInsertQueryId("migrationDAO.insertDept");
	}
	
	@Override
	protected void initMigration(DeptVO paramVO) throws Exception{
			sqlDAO.deleteDAO("migrationDAO.deleteDept", paramVO);
	}
	
	@Override
	public void migration(DeptVO paramVO) throws Exception 
	{
		String orgTableNm = paramVO.getOrgTableNm();
		String tableNm = paramVO.getTableNm();
		Assert.hasText(orgTableNm);
		Assert.hasText(tableNm);
		
		initMigration(paramVO);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(1);
		paginationInfo.setRecordCountPerPage(10);
		paginationInfo.setPageSize(10);

		int cnt = getTotCnt(paramVO);
		paginationInfo.setTotalRecordCount(cnt);

		int totPageCount = paginationInfo.getTotalPageCount();
		log.debug(">cnt : " + cnt);
		log.debug(">paginationInfo.getTotalPageCount() : " + totPageCount);
		
		for(int i=1; i<=totPageCount; i++){

			paginationInfo.setCurrentPageNo(i);
			paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
			paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			List<DeptVO> resultList = getList(paramVO);
			for(DeptVO resultVO : resultList){

				resultVO.setTableNm(tableNm);
				process(paramVO, resultVO);

				insertArticle(resultVO);
				
			}
			
		}
		
		log.debug("migration complete!");
	}
	
	@Override
	protected void process(DeptVO paramVO, DeptVO resultVO) throws Exception{

		
		String upperDeptId = resultVO.getUpperDeptId();
		System.out.println("upperDeptId  :"  + upperDeptId);
		String[] temp = upperDeptId.split(",");
		int tempSize = temp.length - 1;
		resultVO.setInsert_upperDeptId(Integer.parseInt(temp[tempSize]));
		
		

	}
}
