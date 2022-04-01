package kr.co.unp.cmm.crud.paging;


public interface PageQuery<T> {

	public String getPageLinkQueryString(T t) throws Exception;
	
	public String getPageQueryString(T t) throws Exception;
}
