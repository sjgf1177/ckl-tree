package egovframework.com.cmm;

import java.sql.Clob;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.ibatis.sqlmap.client.extensions.ParameterSetter;
import com.ibatis.sqlmap.client.extensions.ResultGetter;
import com.ibatis.sqlmap.client.extensions.TypeHandlerCallback;

public class OracleCLOBTypeHandler implements TypeHandlerCallback {
	Logger log = Logger.getLogger(this.getClass());
    public void setParameter(ParameterSetter setter, Object param) throws SQLException {

        try {
            setter.setClob((Clob) param);
        } catch (SQLException e) {
            if (log.isErrorEnabled())
                log.error("Failed to set CLOB parameter");
            throw e;
        }
    }


    public Object getResult(ResultGetter getter) throws SQLException {

        Clob clob = null;
        try {
            clob = getter.getClob();
        } catch (SQLException e) {
            if (log.isErrorEnabled())
                log.error("Failed to set CLOB result property");
            throw e;
        }

        return clob;
    }

    public Object valueOf(String arg0) {

        return arg0;
    }

}


