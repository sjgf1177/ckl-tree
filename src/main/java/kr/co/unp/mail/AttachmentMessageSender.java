package kr.co.unp.mail;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import kr.co.unp.util.ZValue;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;

public class AttachmentMessageSender extends AbstractMessageSender {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "EgovFileMngUtil")
	protected EgovFileMngUtil fileUtil;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	public void sendMessage() throws MessagingException 
	{
		MimeMessage msg = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(msg, true, "utf-8");
		helper.setTo(to);
		helper.setFrom(from);
		helper.setSubject(subject);
		helper.setText(text, true);
		
		sender.send(msg);
	}
	
	public void sendMessage(ZValue zvl, Map<String, MultipartFile> files) throws Exception {

		MimeMessage msg = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(msg, true, "utf-8");
		helper.setTo(to);
		helper.setFrom(from);
		helper.setSubject(zvl.getString("subject"));
		helper.setText(zvl.getString("text"), true);
		
		if (!files.isEmpty()) 
		{
			String strPath = propertyService.getString("Globals.fileStorePath") + "/email";
			List<FileVO> fileList =  fileUtil.parseFileInf(files, "EMAIL", 0, "TEMP", strPath);
			for(FileVO vo : fileList)
			{
				String path = vo.getFileStreCours() + File.separator + vo.getStreFileNm();
				String orgFileName = vo.getOrignlFileNm();
				log.debug("Attatch file path " + path);
				log.debug("Attatch file orgFileName " + orgFileName);
				orgFileName = EgovStringUtil.toEng(orgFileName);
				FileSystemResource file = new FileSystemResource(new File(path));
				helper.addAttachment(orgFileName,file);
			}
		}
		
		sender.send(msg);
			
	}
	
}
