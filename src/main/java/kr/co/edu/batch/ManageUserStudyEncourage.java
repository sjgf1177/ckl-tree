package kr.co.edu.batch;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


import egovframework.com.cmm.service.EgovProperties;

public class ManageUserStudyEncourage{
    public void doTaskProc() throws Exception {

        ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();

        Date dt = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

        String today = "";
        String currentTime = "";
        String type = "";
        
        int smsCnt = 0;
        int mailCnt = 0;
        StringBuffer logSb = new StringBuffer();
        
        try {

            today = sdf.format(dt);

            sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            currentTime = sdf.format(dt);

            logSb.append("[").append(currentTime).append("]\n");

            ManageUserStudyEncourageBean bean = new ManageUserStudyEncourageBean();

            ArrayList<HashMap<String, String>> smsList = bean.sendEncourageMessageSMS();
            ArrayList<HashMap<String, String>> mailList = bean.sendEncourageMessageEMAIL();
            
               
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }


    // 로그 파일 작성
    private static void writeLog(String date, String log, String type) throws Exception {
    	EgovProperties conf = new EgovProperties();
        try {
            String upDir = conf.getProperty("edu.dir.home");

            upDir += "upload\\manage_user_log\\" + date.substring(0, 6);

            File d = new File(upDir); // 월단위로 로그 디렉토리 생성

            if (!d.exists()) {
                d.mkdirs();
            }

            File f = new File(upDir + "\\" + date + "_" + type + ".log");

            if (!f.exists()) {
                f.createNewFile();
            }

            FileWriter fw = new FileWriter(upDir + "\\" + date + "_" + type + ".log", true);
            BufferedWriter bw = new BufferedWriter(fw);

            bw.write(log);
            bw.newLine();
            bw.close();

        } catch (Exception e) {

        }
    }

}
