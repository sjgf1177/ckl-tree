package kr.co.edu.batch;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class EduQuartzJobBean {

	
	/**
	 * 이메일 수신거부 배치
	 * @throws Exception
	 */
	public void checkEmainReject() throws Exception {
		Connection eduConn = null;
		Connection cklConn = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt2 = null;
        PreparedStatement pstmt3 = null;
        PreparedStatement pstmt4 = null;
        ResultSet rs = null;
        StringBuffer query = new StringBuffer();
        StringBuffer query2 = new StringBuffer();
        StringBuffer query3 = new StringBuffer();
        StringBuffer query4 = new StringBuffer();
        
        int pstmtIndex = 1;
        String campaignNo	= "";
    	String resultSeq	= "";
    	String listSeq		= "";
    	String recordSeq	= "";
    	String customerId	= "";
        
        String dbURL = "jdbc:oracle:thin:@218.232.93.14:1521:ACADEMY";
        try{
        	Class.forName("oracle.jdbc.driver.OracleDriver");
        	eduConn = DriverManager.getConnection(dbURL, "kocca", "kocca2");
        	cklConn = DriverManager.getConnection(dbURL, "CKL_TREE", "CKL_TREE");
        	
        	eduConn.setAutoCommit(false);
        	cklConn.setAutoCommit(false);
        	
        	// 대량메일 수신거부목록
        	query.append("\n select campaign_no, result_seq, list_seq,					");
        	query.append("\n        record_seq, customer_id								");
        	query.append("\n   from wiseu.nvreject a									");
        	query.append("\n  where not exists (select 1								");
        	query.append("\n                         from nvreject_his					");
        	query.append("\n                        where campaign_no = a.campaign_no	");
        	query.append("\n                          and result_seq = a.result_seq		");
        	query.append("\n                          and list_seq = a.list_seq			");
        	query.append("\n                          and record_seq = a.record_seq		");
        	query.append("\n                          and customer_id = a.customer_id)	");
        	
        	pstmt = eduConn.prepareStatement(query.toString());
        	rs = pstmt.executeQuery();
        	
        	// LMS회원정보 메일수신거부 설정
        	query2.append("\n update tz_member 			");
        	query2.append("\n    set ismailing 	= 'N' 	");
        	query2.append("\n  where userid 	= ?		");
        	pstmt2 = eduConn.prepareStatement(query2.toString());
        	
        	// 통합회원정보 메일수신거부 설정
        	query3.append("\n update tm_user 			");
        	query3.append("\n    set email_at 	= 'N' 	");
        	query3.append("\n  where user_id 	= ?		");
        	pstmt3 = cklConn.prepareStatement(query3.toString());
        	
        	// 대량메일 수신거부목록 이력등록
        	query4.append("\n insert into nvreject_his(	");
        	query4.append("\n     campaign_no,			");
        	query4.append("\n     result_seq,			");
        	query4.append("\n     list_seq,				");
        	query4.append("\n     record_seq,			");
        	query4.append("\n     customer_id,			");
        	query4.append("\n     indate				");
        	query4.append("\n )							");
        	query4.append("\n values(					");
        	query4.append("\n     ?, ?, ?, ?, ?, 		");
        	query4.append("\n     to_char(sysdate, 'yyyyMMddhh24mi') ");
        	query4.append("\n )							");
        	pstmt4 = eduConn.prepareStatement(query4.toString());
        	
        	while (rs.next()) {
        		campaignNo	= rs.getString("campaign_no");
        		resultSeq	= rs.getString("result_seq");
        		listSeq		= rs.getString("list_seq");
        		recordSeq	= rs.getString("record_seq");
        		customerId	= rs.getString("customer_id");
        		
        		
    			pstmtIndex = 1;
    			pstmt2.setString(pstmtIndex++, customerId);
    			pstmt2.addBatch();
    			pstmt2.clearParameters();
        		
        		
        		pstmtIndex = 1;
        		pstmt3.setString(pstmtIndex++, customerId);
        		pstmt3.addBatch();
        		pstmt3.clearParameters();
        		
        		pstmtIndex = 1;
        		pstmt4.setString(pstmtIndex++, campaignNo);
        		pstmt4.setString(pstmtIndex++, resultSeq);
        		pstmt4.setString(pstmtIndex++, listSeq);
        		pstmt4.setString(pstmtIndex++, recordSeq);
        		pstmt4.setString(pstmtIndex++, customerId);
        		pstmt4.addBatch();
        		pstmt4.clearParameters();
        	}
        	
        	pstmt2.executeBatch();
        	pstmt3.executeBatch();
        	pstmt4.executeBatch();
        	
        	eduConn.commit();
        	cklConn.commit();
        	
        }catch (Exception ex) {
        	ex.printStackTrace();
        	eduConn.rollback();
        	cklConn.rollback();
        }finally{
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {}
            }
            if (pstmt != null) {
            	try {
            		pstmt.close();
            	} catch (Exception e10) {}
            }
            if (pstmt2 != null) {
            	try {
            		pstmt2.close();
            	} catch (Exception e10) {}
            }
            if (pstmt3 != null) {
            	try {
            		pstmt3.close();
            	} catch (Exception e10) {}
            }
            if (pstmt4 != null) {
            	try {
            		pstmt4.close();
            	} catch (Exception e10) {}
            }
            if (eduConn != null) {
                try {
                	eduConn.close();
                	eduConn = null;
                } catch (Exception e10) {
                }
            }
            if (cklConn != null) {
            	try {
            		cklConn.close();
            		cklConn = null;
            	} catch (Exception e10) {
            	}
            }
        }
	}
}
