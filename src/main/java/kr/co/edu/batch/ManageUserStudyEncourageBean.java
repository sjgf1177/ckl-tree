package kr.co.edu.batch;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import egovframework.com.cmm.service.EgovProperties;

import com.mnwise.lts.client.TcpipClient;

import egovframework.com.cmm.service.EgovProperties;
public class ManageUserStudyEncourageBean {

    public int bannerCnt(String viewPoint) {
        int resultCnt = 0;

        return resultCnt;
    }

    /**
     * 메인 배너리스트 조회
     * 
     * @param box receive from the form object and session
     * @return list ArrayList
     * @throws Exception
     */
    public ArrayList<HashMap<String, String>> sendEncourageMessageSMS() throws Exception {

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        ArrayList<HashMap<String, String>> list = null;
        HashMap<String, String> map = null;
        StringBuffer defaultQuery = new StringBuffer();
        StringBuffer query = new StringBuffer();

        String dbURL = "jdbc:oracle:thin:@218.232.93.14:1521:ACADEMY";
        
        EgovProperties conf = new EgovProperties();
        DateFormat df = new SimpleDateFormat("yyyyMMdd");
        Date dt = new Date();
        
        String tran_date = df.format(dt);
        Calendar startCal = Calendar.getInstance();
        startCal.setTime(dt);
        Calendar endCal = Calendar.getInstance();
        endCal.setTime(dt);
        
        /* 학습시작 7일 경과 */
        startCal.add(Calendar.DATE,-7);
        String start7 = df.format(startCal.getTime());
        
        /* 학습시작 15일 경과 */
        startCal.add(Calendar.DATE,-8);
        String start15 = df.format(startCal.getTime());
        
        
        /* 학습종료 당일 */
        endCal.add(Calendar.DATE, 0);
        String end0 = df.format(endCal.getTime());
        
        /* 학습종료 3일전 */
        endCal.add(Calendar.DATE, 3);
        String end3 = df.format(endCal.getTime());
        
        /* 학습종료 7일전 */
        endCal.add(Calendar.DATE, 4);
        String end7 = df.format(endCal.getTime());
        
        

        String p_fromPhone = conf.getProperty("sms.onedu.tel");
        
        String[] startDate = {start7, start15};  
        String[] endDate = {end7, end3, end0};  
        String tDate = this.substring(tran_date, 4, 6) + "월 " + this.substring(tran_date, 6, 8) + "일 ";
        
        String p_msg = "";
        String v_subjnm = "";
        int resultCnt[] = null;
        
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(dbURL, "kocca", "kocca2");
            conn.setAutoCommit(false);
            list = new ArrayList<HashMap<String, String>>();
            
            defaultQuery.append("    select crypto.dec('normal', handPhone) as tel, b.userid, c.name,	\n");
            defaultQuery.append("           b.edustart, a.subj, a.subjnm, a.subjseq, b.tstep, b.eduend, \n");
            defaultQuery.append("           decode( b.ISGRADUATED , 'Y', 1) as ISGRADUATED,   			\n");  
            defaultQuery.append("           decode( b.ISGRADUATED , 'N', 1) as ISNOTGRADUATED  			\n");  
            defaultQuery.append("      from tz_subjseq a	                                            \n");
            defaultQuery.append("     inner join tz_student b                                           \n");
            defaultQuery.append("        on a.subj 		= b.subj                                        \n");
            defaultQuery.append("       and a.year 		= b.year                                        \n");
            defaultQuery.append("       and a.subjseq 	= b.subjseq                                     \n");
            defaultQuery.append("     inner join tz_member c                                            \n");
            defaultQuery.append("        on a.grcode 	= c.grcode                                      \n");
            defaultQuery.append("       and b.userid 	= c.userid                                      \n");
            defaultQuery.append("     where a.grcode 	= 'N000001'                                     \n");
            defaultQuery.append("       and a.year 		= '2015'                                        \n");
            defaultQuery.append("       and grseq 		= '0017'                                        \n");
            defaultQuery.append("       and issms 		= 'Y'                                           \n");
            defaultQuery.append("       and isgraduated = 'N'                                          	\n");
            
            for(int i=0; i<startDate.length; i++){
            	query.setLength(0);
            	query.append(defaultQuery);
            	if(i == 0){
            		query.append("       and b.tstep = 0                            					\n");
            	}
            	query.append("       and b.edustart = '").append(startDate[i]).append("' 				\n");
            	
            	pstmt = conn.prepareStatement(query.toString());
                rs = pstmt.executeQuery();
                
                while (rs.next()) {
                	map = new HashMap<String, String>();
                    map.put("tel", rs.getString("tel"));
                    map.put("userid", rs.getString("userid"));
                    map.put("edustart", rs.getString("edustart"));
                    
                    v_subjnm = rs.getString("subjnm");
                    if (v_subjnm.length() > 8)
                        p_msg = this.substring(v_subjnm, 0, 7) + "..";
                    else
                        p_msg = v_subjnm;
                    
                    if(i == 0){
                        p_msg = "[EDUKOCCA] " + p_msg + " 학습7일차! 아직 진도율이 0%네요. 학습시작해 주세요.";
                    } else if(i == 1){
                    	p_msg = "[EDUKOCCA] " + p_msg + " 학습15일차! 처음 마음가짐으로 지금 바로 학습하세요.";
                    } else {
                        
                    }
                    
                    map.put("tstep", rs.getString("tstep"));
                    map.put("msg", p_msg);
                    list.add(map);
                }
            }
            
            for(int i=0; i<endDate.length; i++){
            	query.setLength(0);
            	query.append(defaultQuery);
            	if(i == 0){
            		query.append("       and b.tstep = 0                            					\n");
            	}else if(i == 1){
            		query.append("       and b.tstep between 40 and 70                 					\n");
            	}
            	query.append("       and b.eduend = '").append(endDate[i]).append("' 					\n");
            	
            	pstmt = conn.prepareStatement(query.toString());
                rs = pstmt.executeQuery();
                
                while (rs.next()) {
                	map = new HashMap<String, String>();
                    map.put("tel", rs.getString("tel"));
                    map.put("userid", rs.getString("userid"));
                    map.put("edustart", rs.getString("edustart"));
                    
                    v_subjnm = rs.getString("subjnm");
                    if (v_subjnm.length() > 8)
                        p_msg = this.substring(v_subjnm, 0, 7) + "..";
                    else
                        p_msg = v_subjnm;
                    
                    if(i == 0){
                        p_msg = "[EDUKOCCA] " + p_msg + " 학습종료 D-7! 오늘부터 집중하시면 수료 가능합니다.";
                    } else if(i == 1){
                    	p_msg = "[EDUKOCCA] " + p_msg + " 학습종료 D-3! 현재 진도율 "+rs.getString("tstep")+"%, 수료기준은 70%입니다.";
                    } else {
                    	p_msg = "[EDUKOCCA] " + p_msg + " 학습종료일입니다. 학습 마무리하시고 수료증 받으세요!";
                    }
                    
                    map.put("tstep", rs.getString("tstep"));
                    map.put("msg", p_msg);
                    list.add(map);
                }
            }
            
            if(list.size() > 0){
            	
                query.setLength(0);
                query.append(" insert into em_smt_tran (mt_pr, date_client_req, mt_refkey, content, callback, service_type, broadcast_yn, msg_status, recipient_num) \n");
                query.append("  values (sq_em_smt_tran_01.nextval, sysdate, 'academy', ?, ?, '0', 'N', '1', ?)  \n");
                
                pstmt = conn.prepareStatement(query.toString());
                
                for (int j = 0; j < list.size(); j++) {
                    map = new HashMap<String, String>();
                    map = (HashMap<String, String>) list.get(j);
    
                    pstmt.setString(1, map.get("msg"));
                    pstmt.setString(2, p_fromPhone);
                    pstmt.setString(3, map.get("tel"));
                    
                    pstmt.addBatch();
                }
            }                    
            resultCnt = pstmt.executeBatch();


            if ( resultCnt.length > 0 ) {
                conn.commit();
            } else  {
                conn.rollback();
            }
        } catch (Exception ex) {
        	ex.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                    conn = null;
                } catch (Exception e10) {
                }
            }
        }
        
        return list;

    }
    
    
    public ArrayList<HashMap<String, String>> sendEncourageMessageEMAIL() throws Exception {

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        ArrayList<HashMap<String, String>> list = null;
        HashMap<String, String> map = null;
        StringBuffer sql = new StringBuffer();

        //String dbURL = "jdbc:oracle:thin:@10.10.3.91:1521:ACADEMY";
        String dbURL = "jdbc:oracle:thin:@218.232.93.14:1521:ACADEMY";
        
        DateFormat df = new SimpleDateFormat("yyyyMMdd");
        Date dt = new Date();
        
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        
        cal.add(Calendar.DATE,-15   );
        String cal15 = df.format(cal.getTime());
        System.out.println("cal15 : " + df.format(cal.getTime()));
        
        String[] checkDate = {cal15};  
        
        
        int resultCnt[] = null;
        
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(dbURL, "kocca", "kocca2");

            conn.setAutoCommit(false);
            
            for(int i = 0; i < checkDate.length; i++){
            	list = new ArrayList<HashMap<String, String>>();
                sql.setLength(0);
                sql.append("    select  crypto.dec('normal', handPhone) tel , crypto.dec('normal', email) email ,b.userid, c.name, a.subj, a.subjnm, a.subjseq, b.tstep                            \n");
                sql.append("    , b.eduend,  decode( b.ISGRADUATED , 'Y', 1) ISGRADUATED, decode( b.ISGRADUATED , 'N', 1) ISNOTGRADUATED \n");
                sql.append("    , ( select count(lesson) lesson from tz_subjlesson where subj= a.subj) lessonCnt, decode(gradstep, 0, 70, gradstep) as gradstep                 \n");
                sql.append("    , case when b.edustart is null then a.edustart else b.edustart end as edustart                  \n");
                sql.append("    , case when b.eduend is null then a.eduend else b.eduend end as eduend                  \n");
                sql.append("    from tz_subjseq a, tz_student b , tz_member c                                                             \n");
                sql.append("    where a.subj = b.subj                                                                                     \n");
                sql.append("    and a.year = b.year                                                                                       \n");
                sql.append("    and a.subjseq = b.subjseq                                                                                 \n");
                sql.append("    and a.grcode = c.grcode                                                                                 \n");
                sql.append("    and b.userid = c.userid                                                                                 \n");
                sql.append("    and a.grcode = 'N000001'                                                                                  \n");
                sql.append("    and a.year = '2015'                                                                                       \n");
                sql.append("    and grseq = '0017'                                                                                        \n");
                sql.append("    and ismailing = 'Y'                                                                                        \n");
                sql.append("    and b.tstep < 70                                                                                           \n");
                sql.append("    AND ISGRADUATED = 'N'                                                                                     \n");
                sql.append("    and b.edustart = '").append(checkDate[i]).append("' \n");
                
                
                System.out.println(sql.toString());
                pstmt = conn.prepareStatement(sql.toString());
                rs = pstmt.executeQuery();

                
                String subjnm = "";
                String name = "";
                String tel = "";
                String email = "";
                String lessonCnt = "";
                String eduStart = ""; 
                String eduend = ""; 
                String gradstep = "";
                String title = "";
                while (rs.next()) {
                    
                    map = new HashMap<String, String>();
                    
                    subjnm = rs.getString("subjnm");
                    name = rs.getString("name");
                    tel = rs.getString("tel");
                    email = rs.getString("email");
                    lessonCnt = rs.getInt("lessonCnt") == 0 ? "" : Integer.toString( rs.getInt("lessonCnt") )+ "차시";  
                    
                    eduStart = rs.getString("edustart");
                    eduend = rs.getString("eduend");
                    gradstep = rs.getString("gradstep");
                    list.add(map);
                
                    if(list.size() > 0){
                        
                        //pstmt.addBatch();
                        StringBuffer contSb = new StringBuffer();
                        
                        if(cal15.equals( eduStart )){
                            eduStart = this.substring(eduStart, 0, 4) + "년 " + this.substring(eduStart, 4, 6) + "월 " + this.substring(eduStart, 6, 8) + "일 ";
                            eduend = this.substring(eduend, 0, 4) + "년 " + this.substring(eduend, 4, 6) + "월 " + this.substring(eduend, 6, 8) + "일 ";
                            
                            
                            title = "[EDUKOCCA] '{subjnm}' 과정 학습기간 및 수료기준 안내";
                            if(subjnm.length() > 5){
                            	title = title.replace("{subjnm}", subjnm.substring(0, 5) + "...");
                            }else{
                            	title = title.replace("{subjnm}", subjnm);
                            }
                            
                            // 메일 보내기
                            contSb.append("<div style=\"font-weight:bold; font-size:13px;\">안녕하세요, "+name+" 님!</div>	");
                            contSb.append("<br/>																		");
                            contSb.append("<span>아래 신청하신 과정에 대한 학습일정과 수료기준을 안내해 드립니다.</span><br/>						");
                            contSb.append("<span>참고하셔서 기간 내에 학습 진행 부탁 드립니다.</span><br/>									");
                            contSb.append("<br/>																		");
                            contSb.append("<ul style=\"font-weight:bold;\">												");
                            contSb.append("    <li>과 정 명 : <span style=\"color:#0054FF;\">"+subjnm+"</span></li>			");
                            contSb.append("    <li>학습차시 : "+lessonCnt+"</li>											");
                            contSb.append("    <li>학습기간 : "+eduStart+" ~ "+eduend+"</li> 								");
                            contSb.append("    <li>수료기준 : 진도율 70% 이상</li>												");
                            contSb.append("</ul>																		");
                            contSb.append("<br/>																		");
                            contSb.append("<span>학습기간 내에 진도율 70% 이상 달성하여 과정을 수료하시면</span><br/>							");
                            contSb.append("<span>수료증 출력이 가능합니다.</span><br/>											");
                            contSb.append("<br/>																		");
                            contSb.append("<span>EDUKOCCA와 함께 유익한 학습이 되시기 바랍니다.</span><br/>							");
                            contSb.append("<span>감사합니다.</span>															");
                            

                			String domain = EgovProperties.getProperty("Globals.SendMail.domain");
                			String port = EgovProperties.getProperty("Globals.SendMail.port");
                            TcpipClient tc = new TcpipClient(); // 메일발송 socket connection open
                		    tc.open(domain, Integer.parseInt(port));   //9100 추후변경
    
                            tc.setAID("34");
                            tc.setArg("INAME", "");
                            tc.setArg("IUSERID", "");
                            tc.setArg("IEMAIL", email);
                            tc.setArg("TITLE", title);
                            tc.setData("CONTENT", contSb.toString() );
                            
                            // 메일 발송
                            tc.commit();
                        }
                        //System.out.println(j);
                    
                    }         
                }
            }
            
        } catch (Exception ex) {
        	ex.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                    conn = null;
                } catch (Exception e10) {
                }
            }
        }
        
        return list;

    }
    
	public String substring(String str, int beginIndex, int endIndex) {
		String result = "";

		if(str != null) {
			result = str.substring(beginIndex, endIndex);
		}

		return result;
	}
}
