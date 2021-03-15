package com.aracomm.changbi.ext.email;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;


@Component
public class EmailSender {
	@Autowired
    protected JavaMailSender mailSender;

	@Value("#{config['Globals.Mail.UserName']}")
	String mailFromUser;

	public void sendTextEmail(EmailVo vo) throws Exception {
		sendEmail(vo, false);
	}
	public void sendHtmlEmail(EmailVo vo) throws Exception {
		sendEmail(vo,true);
	}
    public void sendEmail(EmailVo vo, boolean html) throws Exception {
        MimeMessage msg = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg);

        helper.setFrom(this.mailFromUser);
        helper.setTo(vo.getReceiver());
        helper.setSubject(vo.getSubject());
        helper.setText(vo.getContent(), html);

        mailSender.send(msg);
    }
}

