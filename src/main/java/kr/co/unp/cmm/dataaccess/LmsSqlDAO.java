package kr.co.unp.cmm.dataaccess;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository("lmsSqlDAO")
public class LmsSqlDAO<T> extends SqlDAO<T> {

	@Resource(name="lmsSqlMapClient")
	public void setSuperSqlMapClient(SqlMapClient sqlMapClient) {
        super.setSuperSqlMapClient(sqlMapClient);
    }

}
