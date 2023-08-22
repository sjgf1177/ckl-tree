package kr.co.unp.util;

import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.springframework.util.StringUtils;


public class UploadableFile {

	public static final UploadableFileFilter filter = new UploadableFileFilter();
	public static final String webRoot = "D:/newProject/ckl-tree/workspace/ckl-tree"; //원본 파일 위치
	public static final String tempRoot = "D:/Temp/upload/ckl-tree"; //수정된 파일 복사위치
	public static final String[] allowedExt = {".class", ".jsp", ".xml",".properties",".MF",".jar",".tld", ".jpg", ".gif", ".png", ".ico", ".js", ".html", ".htm",".txt",".swf"}; //해당 확장자
	public static final String[] wasExt = {".class", ".jsp", ".xml", ".properties",".MF",".jar",".tld"}; //해당 확장자
	public static final String[] notExt = {".svn"}; //수정된 시간 제외할 확장자
	public static final String[] notFile = {"web1.xml"}; //제외할 파일
	public static final boolean webWasFlag = true; // web/was 파일 분리 여부(true 분리, false 미분리)
	public static final boolean ftpSend = false; // ftp로 전송할 것인지 여부
	public static final String ftpIp = ""; // ftp로 전송될 정보 --- 추후 자그업 예정
	public static final String ftpPort = "";
	public static final String ftpUser = "";
	public static final String ftpPwd = "";
	public static final String ftpLogFile = "";
	public static final String ftpServerPath = "";
	public static String toDay = "";


	public static void main(String[] args) throws IOException {
		// 수정된 파일 복사
		saveUploadableFile(-1, 0, 0);

		//ftp 전송
		if (ftpSend) ftpSend();
	}

	public static void saveUploadableFile(int days, int hours, int minutes) throws IOException{
		Date today = new Date();
		Date date = null;
		if( days != 0 ){
			date = DateUtils.addDays(today, days);
		}
		if( hours != 0 ){
			date = DateUtils.addHours(today, hours);
		}
		if( minutes != 0 ){
			date = DateUtils.addMinutes(today, minutes);
		}
		File root = new File(webRoot);
		if( root.exists() ){
			listFile(root, date);
		}
	}

	public static void listFile(File file, Date date) throws IOException{
		toDay = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
		File[] subFiles = file.listFiles(filter);
		if( ArrayUtils.isNotEmpty(subFiles) ){
			for(File f : subFiles){
				if( f.isDirectory() ){
					listFile(f, date);
				}
				else{
					String fileName = f.getName();
					Date fDate = new Date(f.lastModified());
					boolean condition = false;
					for(String ext : allowedExt){
						if( fileName.endsWith(ext) ){
							condition = true;
							break;
						}
					}
					if( condition && fDate.compareTo(date) >= 0 ){
						String path = f.getAbsolutePath();
						if ( path.indexOf("m2e-wtp") == -1) {

							if (webWasFlag){ // web/was 분리
								// was 파일인지 체크
								condition = false;
								for(String ext : wasExt){
									if( fileName.endsWith(ext) ){
										condition = true;
										break;
									}
								}
								if (condition) {
									path = StringUtils.replace(path, webRoot, tempRoot + "/"+toDay+"/was");
								} else {
									path = StringUtils.replace(path, webRoot, tempRoot + "/"+toDay+"/web");
								}
							} else { //web/was 미분리 경우
								path = StringUtils.replace(path, webRoot, tempRoot + "/"+toDay);
							}
							path = StringUtils.replace(path, "target", "src/main/webapp/WEB-INF");
							File newFile = new File(path);
							FileUtils.copyFile(f, newFile);
							System.out.println(newFile.getAbsolutePath());
						}
					}
				}
			}
		}
	}

	public static class UploadableFileFilter implements FileFilter{


		public boolean accept(File file) {

			boolean condition = true;
			for(String ext : notExt){
				if (file.getName().endsWith(ext)){
					condition = false;
					break;
				} else {
					for(String nFile : notFile){
						if (file.getName().indexOf(nFile)>-1) {
							condition = false;
							break;
						}
					}
				}
			}
			return condition;
			//return file.getName().indexOf(".svn") == -1;
		}

	}



	public static void ftpSend(){
		FTPClient client = null;
		FileInputStream inputStream = null ;
		try {
			client = new FTPClient();
			client.setControlEncoding("euc-kr");
			client.connect(ftpIp);

			// 응답 코드가 비정상적일 경우 종료함
			int reply = client.getReplyCode();
			if (!FTPReply.isPositiveCompletion(reply)) {
				client.disconnect();
				// 로그 파일에 쓰기 - 미작업
				System.out.println("서버 연결 상태 확인");
			} else {
				client.setSoTimeout(10000);
				client.login(ftpUser, ftpPwd);

				File file = new File(tempRoot);
				if( file.exists() ){
					File[] subFiles = file.listFiles(filter);
					if( ArrayUtils.isNotEmpty(subFiles) ){
						for(File f : subFiles){
							inputStream = new FileInputStream(f);
							client.appendFile(ftpServerPath + "/" + f.getAbsolutePath().replaceAll(tempRoot + "/" + toDay + "/src/main/webapp", "") + "/" + f.getName(), inputStream);
							// 로그 파일에 쓰기 - 미작업
							inputStream.close();
						}
					}
				}


			}

		} catch (Exception e) {
			// 로그 파일에 쓰기 - 미작업
			System.out.println("서버 연결 실패");
			e.printStackTrace();

		} finally {
			if (client!=null && client.isConnected()){
				try {
					client.disconnect();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			if (inputStream!=null){
				try {
					inputStream.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
		}
	}

}
