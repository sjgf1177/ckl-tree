package kr.co.unp.cmm.crud.config.xml;

import kr.co.unp.bbs.service.FnwBBSManageServiceImpl;
import kr.co.unp.pg.dao.PageGeneratorDAO;
/**
 * 
 * @author KHD
 *
 */
public class BbsManageParserCpFactoryBean extends CmmProgramParserCpFactoryBean<FnwBBSManageServiceImpl> {

    private String delPermanentlyQueryId;
    private String restoreQueryId;
    private String replyListQueryId;
    private String updateInqireCoQueryId;
    private String prevQueryId;
    private String nextQueryId;

    private PageGeneratorDAO pageGeneratorDAO;
	
	@Override
	public Class<FnwBBSManageServiceImpl> getObjectType() {
		return FnwBBSManageServiceImpl.class;
	}

	@Override
	protected FnwBBSManageServiceImpl createInstance() {
		FnwBBSManageServiceImpl service = getService();
		
		super.setProperties(service);
		
		if( delPermanentlyQueryId != null ){
			service.setDelPermanentlyQueryId(delPermanentlyQueryId);
		}
		if( restoreQueryId != null ){
			service.setRestoreQueryId(restoreQueryId);
		}
		if( replyListQueryId != null ){
			service.setReplyListQueryId(replyListQueryId);
		}
		if( updateInqireCoQueryId != null ){
			service.setUpdateInqireCoQueryId(updateInqireCoQueryId);
		}
		if( prevQueryId != null ){
			service.setPrevQueryId(prevQueryId);
		}
		if( nextQueryId != null ){
			service.setNextQueryId(nextQueryId);
		}
		if( pageGeneratorDAO != null ){
			service.setPageGeneratorDAO(pageGeneratorDAO);
		}
		if( getAccessor() != null ){
			service.setAccessor(getAccessor());
		}
		return service;
	}

	@Override
	protected FnwBBSManageServiceImpl getService(){
		FnwBBSManageServiceImpl service = null;
		if (getTargetObject() != null) {
			service = (FnwBBSManageServiceImpl)getTargetObject();
		}
		else {
			service = new FnwBBSManageServiceImpl();
		}
		return service;
	}

	public String getDelPermanentlyQueryId() {
		return delPermanentlyQueryId;
	}

	public void setDelPermanentlyQueryId(String delPermanentlyQueryId) {
		this.delPermanentlyQueryId = delPermanentlyQueryId;
	}

	public String getRestoreQueryId() {
		return restoreQueryId;
	}

	public void setRestoreQueryId(String restoreQueryId) {
		this.restoreQueryId = restoreQueryId;
	}

	public String getReplyListQueryId() {
		return replyListQueryId;
	}

	public void setReplyListQueryId(String replyListQueryId) {
		this.replyListQueryId = replyListQueryId;
	}

	public String getUpdateInqireCoQueryId() {
		return updateInqireCoQueryId;
	}

	public void setUpdateInqireCoQueryId(String updateInqireCoQueryId) {
		this.updateInqireCoQueryId = updateInqireCoQueryId;
	}

	public String getPrevQueryId() {
		return prevQueryId;
	}

	public void setPrevQueryId(String prevQueryId) {
		this.prevQueryId = prevQueryId;
	}

	public String getNextQueryId() {
		return nextQueryId;
	}

	public void setNextQueryId(String nextQueryId) {
		this.nextQueryId = nextQueryId;
	}

	public PageGeneratorDAO getPageGeneratorDAO() {
		return pageGeneratorDAO;
	}

	public void setPageGeneratorDAO(PageGeneratorDAO pageGeneratorDAO) {
		this.pageGeneratorDAO = pageGeneratorDAO;
	}
}
