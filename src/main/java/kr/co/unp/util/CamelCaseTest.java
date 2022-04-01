package kr.co.unp.util;

import java.util.List;
import java.util.Map;

import kr.co.unp.util.StrUtils;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

public class CamelCaseTest {

    public static void main(String[] args) throws Exception
    {
    	String tableName = "ts_activity";
    	StringBuffer query = new StringBuffer();
    	query.append("SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, COLUMN_COMMENT COMMENTS, ORDINAL_POSITION COLUMN_ID, COLUMN_KEY pk ");
    	query.append("\nFROM information_schema.columns a ");
    	query.append("\nWHERE TABLE_SCHEMA = 'fintech' AND  TABLE_NAME = '").append(tableName).append("'");
    	query.append("\nORDER BY TABLE_NAME, ORDINAL_POSITION");
    	System.out.println(query.toString());

    	ClassPathXmlApplicationContext applicationContext = new ClassPathXmlApplicationContext("/egovframework/spring/com/context-datasource.xml");
    	applicationContext.start();
    	//BasicDataSource ds = applicationContext.getBean("dataSource-oracle-real_test", BasicDataSource.class); //dataSource-oracle-real_test
    	BasicDataSource ds = applicationContext.getBean("dataSource-mysql", BasicDataSource.class); //dataSource-oracle-real_test
    	JdbcTemplate jdbcTemplate = new JdbcTemplate(ds);
    	List<Map<String,Object>> columnList = jdbcTemplate.queryForList(query.toString());
    	System.out.println("\n\n");
    	CamelCaseTest.convertInsertCC(tableName, columnList);
    	System.out.println("\n\n");
    	CamelCaseTest.convertResultMapCC(columnList);
    	System.out.println("\n\n");
    	CamelCaseTest.convertUpdateCC(tableName, columnList);
    	System.out.println("\n\n");
    	CamelCaseTest.printSelect(tableName, columnList);
    	System.out.println("\n\n");
    	CamelCaseTest.printDelete(tableName);
    	applicationContext.close();
    }
    
	public static void convertInsertCC(String tableName, List<Map<String,Object>> columnList){
		StringBuffer result = new StringBuffer();
		result.append("INSERT INTO ").append(tableName).append(" (\n");
		result.append("    ");
		int size = columnList.size();
    	for(int i=0; i<size; i++){
    		Map<String, Object> m = columnList.get(i);
    		result.append(m.get("COLUMN_NAME"));
    		if( i != size-1 ){
    			result.append(",");
    		}
    		if( i != 0 && i % 5 == 0 ){
    			result.append("\n    ");
    		}
    	}
		result.append("\n)\n");
		result.append("VALUES (\n");
		result.append("    ");
    	for(int i=0; i<size; i++){
    		Map<String, Object> m = columnList.get(i);
    		String dataType = m.get("DATA_TYPE").toString();
    		String colName = StrUtils.convert2CamelCase(m.get("COLUMN_NAME").toString());
    		result.append("#").append(colName);
    		if( "CLOB".equals(dataType) ){
    			result.append(":CLOB");
    		}
    		result.append("#");
    		if( i != size-1 ){
    			result.append(",");
    		}
    		if( i != 0 && i % 5 == 0 ){
    			result.append("\n    ");
    		}
    	}
    	result.append("\n)");
    	System.out.println(result.toString());
	}

	public static void convertResultMapCC(List<Map<String,Object>> columnList){
		StringBuffer result = new StringBuffer();
		result.append("<resultMap id=\"mapId\" class=\"zvl\">\n");
		int size = columnList.size();
    	for(int i=0; i<size; i++){
    		Map<String, Object> m = columnList.get(i);
    		String colName = m.get("COLUMN_NAME").toString();
    		String dataType = m.get("DATA_TYPE").toString();
    		result.append("    <result property=\"").append(StrUtils.convert2CamelCase(colName)).append("\" column=\"").append(colName).append("\"");
    		if( "CLOB".equals(dataType) ){
    			result.append(" jdbcType=\"CLOB\" javaType=\"java.lang.String\"");
    		}
    		result.append("/>\n");
    	}
		result.append("</resultMap>");
    	System.out.println(result.toString());
	}

	public static void convertUpdateCC(String tableName, List<Map<String,Object>> columnList){
		StringBuffer result = new StringBuffer();
		result.append("UPDATE ").append(tableName).append("\n");
		result.append("SET \n");
		int size = columnList.size();
    	for(int i=0; i<size; i++){
    		Map<String, Object> m = columnList.get(i);
    		String colName = m.get("COLUMN_NAME").toString();
    		String dataType = m.get("DATA_TYPE").toString();
    		result.append("    ").append(colName).append(" = #").append(StrUtils.convert2CamelCase(colName));
    		if( "CLOB".equals(dataType) ){
    			result.append(":CLOB");
    		}
    		result.append("#");
    		if( i != size-1 ){
    			result.append(",\n");
    		}
    	}
		result.append("\nWHERE 1=1");
    	System.out.println(result.toString());
	}

	public static void printSelect(String tableName, List<Map<String,Object>> columnList){
		StringBuffer result = new StringBuffer();
		result.append("SELECT \n");
		int size = columnList.size();
    	for(int i=0; i<size; i++){
    		Map<String, Object> m = columnList.get(i);
    		String colName = m.get("COLUMN_NAME").toString();
    		result.append("    ").append(colName);
    		if( i != size-1 ){
    			result.append(",\n");
    		}
    	}
    	result.append("\nFROM ").append(tableName).append("\n");
		result.append("WHERE 1=1");
    	System.out.println(result.toString());
	}

	public static void printDelete(String tableName){
		StringBuffer result = new StringBuffer();
		result.append("DELETE FROM ").append(tableName).append("\n");
		result.append("WHERE 1=1");
    	System.out.println(result.toString());
	}
}
