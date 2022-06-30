package kr.co.unp.cmm.crud.service;

import java.sql.*;

public abstract class MariaDBSendSms {
	public static void mariaDbSend(String toPhone, String fromPhone, String msg) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		String url = "jdbc:mariadb://210.96.133.36:3306/koccadb?allowMultiQueries=true";
		String id = "koccaHome";
		String pass = "curonsys!@";

		sql = "INSERT INTO SC_TRAN (TR_SENDDATE, TR_SENDSTAT, TR_MSGTYPE, TR_PHONE , TR_CALLBACK, TR_MSG)";
		//sql +="VALUES(NOW(), '0', '0','" + param.getString("phone") + "','" + param.getString("callback") + "', '" + param.getString("msg") + "' ) ";
		sql +="VALUES(NOW(), '0', '0','" + toPhone + "','0263100770', '" + msg + "' ) ";
		try {

			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url, id, pass);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			System.out.println(sql);
           /* while(rs.next()) {

            }*/

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try{
				if(rs != null) {
					rs.close();
				}
				if(pstmt != null){
					pstmt.close();
				}
				if(con != null && !con.isClosed()) {
					con.close();
				}
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
