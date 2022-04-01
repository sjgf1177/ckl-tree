package kr.co.unp.mail;

import org.springframework.mail.javamail.JavaMailSender;

public abstract class AbstractMessageSender {
	protected String to;
	protected String from;
	protected String subject;
	protected String text;
	protected JavaMailSender sender;
	
	public JavaMailSender getSender() {
		return sender;
	}

	public void setSender(JavaMailSender sender) {
		this.sender = sender;
	}

	public String getTo() {
		return to;
	}

	public String getFrom() {
		return from;
	}

	public String getSubject() {
		return subject;
	}

	public String getText() {
		return text;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public void setText(String text) {
		this.text = text;
	}

	public void setJavaMailSender(JavaMailSender sender) {
		this.sender = sender;
	}
}
