package kr.co.edu.batch;


public class EduQuartzJob {

	/**
	 * 이메일 수신거부 배치
	 * @throws Exception
	 */
	public void doTaskProc() throws Exception {
        try {
        	EduQuartzJobBean bean = new EduQuartzJobBean();
        	
        	
        	bean.checkEmainReject();
        	
        } catch (Exception e) {
            e.printStackTrace();
        }

    } 
}
