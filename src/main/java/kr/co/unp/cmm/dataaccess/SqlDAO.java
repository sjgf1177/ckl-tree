package kr.co.unp.cmm.dataaccess;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapExecutor;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("SqlDAO")
public class SqlDAO<T> extends EgovAbstractDAO implements ISqlDAO<T>{
	Logger log = Logger.getLogger(this.getClass());

	/**
	 * List 실행
	 * @param queryId
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<T> listDAO(String queryId, T t) throws Exception {
		log.debug("QueryId===============:" +queryId);
		return (List<T>)list(queryId, t);
	}

	@SuppressWarnings({ "unchecked", "deprecation" })
	public Map<String, T> queryForMap(String queryId, T t, String id) throws Exception {
		log.debug("QueryId===============:" +queryId);
		return (Map<String, T>)getSqlMapClientTemplate().queryForMap(queryId, t, id);
	}

	/**
	 * SELECT 실행
	 * @param queryId
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public T selectDAO(String queryId, T t) throws Exception {
		log.debug("QueryId===============:" +queryId);
		return (T)selectByPk(queryId, t);
	}

	/**
	 * COUNT 실행
	 * @param queryId
	 * @param t
	 * @return
	 * @throws Exception
	 */
	@Override
	public int selectCount(String queryId, T t) throws Exception {
		log.debug("QueryId===============:" +queryId);
		return (Integer)selectByPk(queryId, t);
	}


	/**
	 * String 실행
	 * @param queryId
	 * @param t
	 * @return
	 * @throws Exception
	 */
	@Override
	public String selectString(String queryId, T t) throws Exception {
		log.debug("QueryId===============:" +queryId);
		return (String)selectByPk(queryId, t);
	}

	/**
	 * UPDATE 실행
	 * @param queryId
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	@Override
	public int updateDAO(String queryId, T t) throws Exception {
		log.debug("QueryId===============:" +queryId);
		return update(queryId, t);
	}

	/**
	 * DELETE 실행
	 * @param queryId
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	@Override
	public int deleteDAO(String queryId, T t) throws Exception {
		log.debug("QueryId===============:" +queryId);
		return delete(queryId, t);
	}

	/**
	 * INSERT 실행
	 * @param queryId
	 * @param parameterMap
	 * @return
	 * @throws Exception
	 */
	@Override
	public Object insertDAO(String queryId, T t) throws Exception {
		log.debug("QueryId===============:" +queryId);
		return insert(queryId, t);
	}

	@Override
    @SuppressWarnings({ "unchecked", "deprecation", "rawtypes" })
	public Integer batchInsert(final String queryId, final List<T> list) {
        return (Integer) getSqlMapClientTemplate().execute(
            new SqlMapClientCallback() {
                public Object doInSqlMapClient(SqlMapExecutor executor)
                        throws SQLException {

                    executor.startBatch();

                    for (Iterator<T> itr = list.iterator(); itr.hasNext();) {
                        executor.insert(queryId, itr.next());
                    }

                    return executor.executeBatch();
                }
            }
        );
    }

	@Override
    @SuppressWarnings({ "unchecked", "deprecation", "rawtypes" })
	public Integer batchUpdate(final String queryId, final List<T> list) {
        return (Integer) getSqlMapClientTemplate().execute(
            new SqlMapClientCallback() {
                public Object doInSqlMapClient(SqlMapExecutor executor)
                        throws SQLException {

                    executor.startBatch();

                    for (Iterator<T> itr = list.iterator(); itr.hasNext();) {
                        executor.update(queryId, itr.next());
                    }

                    return executor.executeBatch();
                }
            }
        );
    }
}
