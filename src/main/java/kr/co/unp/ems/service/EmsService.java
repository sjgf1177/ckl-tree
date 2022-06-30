package kr.co.unp.ems.service;


import javax.annotation.Resource;

import kr.co.edu.batch.ManageUserStudyEncourageBean;
import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.ZValue;
import kr.co.unp.cmm.crud.service.MariaDBSendSms;

import org.springframework.stereotype.Service;

import com.mnwise.lts.client.TcpipClient;

import egovframework.com.cmm.service.EgovProperties;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

@Service("emsService")
public class EmsService  {

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDao;

	@Resource(name = "siteMngService")
	private SiteMngService siteMngService;

	public EmsService(){
	}

    public boolean sndngEmail(ZValue param) throws Exception {

		//ZValue site = siteMngService.getSiteBySiteName((String)PropertyUtils.getProperty(param, "siteName"));
		//String siteNm = param.getString("siteName");
		//String emailCnStr = FileUtils.readFileToString(new File(Globals.WEB_ROOT_PATH+"/files/template/email/"+siteNm+"/crtfcEmail.html"), "UTF-8");

		//emailCnStr = emailCnStr.replace("@userId@", param.getString("userId"));
		//emailCnStr = emailCnStr.replace("@userNm@", param.getString("userNm"));
		//emailCnStr = emailCnStr.replaceAll("@siteUrl@", site.getString("siteUrl"));

		//param.put("fromName", "한국콘텐츠아카데미");
		//param.put("fromEmail", "test@gmail.com");
		//param.put("sj", "한국콘텐츠아카데미입니다.");
		//param.put("cn", emailCnStr);
		//emsSqlDAO.insertDAO("Ems65DAO.emailInsert", param);
		String title = param.getString("title");
		String reciveEmail = param.getString("email");
		String sendName = param.getString("name");
		String content = param.getString("content");

		String sendMailResult = "";

		try {
			String domain = EgovProperties.getProperty("Globals.SendMail.domain");
			String port = EgovProperties.getProperty("Globals.SendMail.port");
			
		    TcpipClient tc = new TcpipClient(); // 메일발송 socket connection open
		    tc.open(domain, Integer.parseInt(port));   //9100 추후변경
		    
		    if ("ckl".equals(param.getString("siteName"))) tc.setAID("37");
		    else tc.setAID("38");
		   
		    tc.setArg("INAME", sendName);
		    tc.setArg("IUSERID", "");
		    tc.setArg("IEMAIL", reciveEmail);
		    tc.setArg("TITLE", title);
		    tc.setData("CONTENT", content );
		    
		    // 메일 발송
		    sendMailResult = tc.commit();
		    // sendMailResult = "250";
		    
		    // 메일 발송 성공이면 DB에 인증 정보 입력
		    if ( sendMailResult.equals("250") ) return true;
		    else return false;
		}
		catch (Exception e) {
			e.printStackTrace();
			return false;
		}
    }

    /**
     * sms발송
     * @param param
     * @throws Exception
     */
    public void sndngSms(ZValue param) throws Exception {

    	param.put("tranPhone", param.getString("phone"));
    	param.put("tranCallback", param.getString("callback"));
    	param.put("refkey", param.getString("refkey"));
    	param.put("tranMsg", param.getString("msg"));
		//sqlDao.insertDAO("emsDAO.insertSms", param);

		MariaDBSendSms.mariaDbSend(param.getString("phone"), param.getString("callback"), param.getString("msg"));
    }

}
