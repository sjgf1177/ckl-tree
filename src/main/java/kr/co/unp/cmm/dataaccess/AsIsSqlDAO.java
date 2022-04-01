package kr.co.unp.cmm.dataaccess;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository("asIsSqlDAO")
public class AsIsSqlDAO<T> extends SqlDAO<T> {

	@Resource(name="asIsSqlMapClient")
	public void setSuperSqlMapClient(SqlMapClient sqlMapClient) {
        super.setSuperSqlMapClient(sqlMapClient);
    }

}
