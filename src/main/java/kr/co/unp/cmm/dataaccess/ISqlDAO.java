package kr.co.unp.cmm.dataaccess;

import java.util.List;
import java.util.Map;

public interface ISqlDAO<T> {

	/**
	 * List 실행
	 * @param queryId
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public List<T> listDAO(String queryId, T t) throws Exception;


	public Map<String, T> queryForMap(String queryId, T t, String id) throws Exception;

	/**
	 * SELECT 실행
	 * @param queryId
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public T selectDAO(String queryId, T t) throws Exception;

	/**
	 * COUNT 실행
	 * @param queryId
	 * @param t
	 * @return
	 * @throws Exception
	 */
	public int selectCount(String queryId, T t) throws Exception;

	public String selectString(String queryId, T t) throws Exception;

	/**
	 * UPDATE 실행
	 * @param queryId
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public int updateDAO(String queryId, T t) throws Exception;

	/**
	 * DELETE 실행
	 * @param queryId
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public int deleteDAO(String queryId, T t) throws Exception;

	/**
	 * INSERT 실행
	 * @param queryId
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	public Object insertDAO(String queryId, T t) throws Exception;

	/**
	 * batchInsert 실행
	 * @param queryId
	 * @param list
	 * @return
	 */
	public Integer batchInsert(final String queryId, final List<T> list);

	/**
	 * batchUpdate 실행
	 * @param queryId
	 * @param list
	 * @return
	 */
	public Integer batchUpdate(final String queryId, final List<T> list);
}
