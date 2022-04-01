package kr.co.unp.migration.service;


public interface MigrationService<T> {

	public void setAsisCountQueryId(String asisCountQueryId);

	public void setAsisListQueryId(String asisListQueryId);

	public void setInsertQueryId(String insertQueryId);

	public void migration(T t) throws Exception;
	
}
