/**
 * 
 */
package global.segroup.util;

import java.io.IOException;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Properties;
import java.util.regex.Pattern;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Transport;
import javax.mail.UIDFolder;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.commons.codec.binary.Hex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import com.sun.mail.imap.IMAPFolder;

/**
 * @Author : 한진규
 * @Date : 2017. 10. 13.
 * @Class 설명 : 메일을 보내는 클래스
 * transport.protocol=smtp
smtp.user=searpier
smtp.host=smtp.gmail.com
smtp.port=587
smtp.starttls.enable=true
smtp.socketFactory.class=javax.net.ssl.SSLSocketFactory
smtp.auth=true
admin.username=searpier
admin.password=wjstkdtntkdtn0
 */
@Component
public class MailService {
	private Authenticator authenticator;

	@Value("#{mail['smtp.user']}")
	private String from="searpier";

	@Value("#{mail['transport.protocol']}")
	private String protocol="smtp";

	@Value("#{mail['smtp.host']}")
	private String host="smtp.gmail.com";

	@Value("#{mail['smtp.port']}")
	private String port="587";

	@Value("#{mail['smtp.starttls.enable']}")
	private String tls="true";

	@Value("#{mail['smtp.socketFactory.class']}")
	private String ssl="javax.net.ssl.SSLSocketFactory";

	@Value("#{mail['smtp.auth']}")
	private String auth="true";

	@Value("#{mail['admin.username']}")
	private String username="searpier@gmail.com";

	@Value("#{mail['admin.password']}")
	private String password="wjstkdtntkdtn0";

	private Properties props_mailing;

	/**
	 * @Method Name : prepareProperties
	 * @Date : 2017. 10. 13.
	 * @User : 한진규
	 * @Param :
	 * @Return :
	 * @Method 설명 : 메일 보낼 때 사용하는 프로퍼티들을 준비한다
	 */
	private void prepareProperties() {
		if (props_mailing != null) {
			return;
		}

		props_mailing = new Properties();

		// 프로토콜 설정
		props_mailing.setProperty("mail.transport.protocol", protocol);

		// SMTP 서비스 주소(호스트)
		props_mailing.setProperty("mail.smtp.host", host);

		// SMTP 서비스 포트 설정
		props_mailing.setProperty("mail.smtp.port", port);

		// 로그인 할때 Transport Layer Security(TLS) 설정
		props_mailing.setProperty("mail.smtp.starttls.enable", tls);

		// Secure Socket Layer(SSL) 설정
		props_mailing.setProperty("mail.smtp.socketFactory.class", ssl);

		// SMTP 인증을 설정
		props_mailing.setProperty("mail.smtp.auth", auth);

		// 유저 설정
		props_mailing.setProperty("mail.smtp.user", from);
	}

	/**
	 * @Method Name : prepareAuthenticator
	 * @Date : 2017. 10. 16.
	 * @User : 한진규
	 * @Param :
	 * @Return :
	 * @Method 설명 : 유저 비밀번호와 아이디를 준비한다
	 */
	private void prepareAuthenticator() {
		if (authenticator != null) {
			return;
		}

		authenticator = new Authenticator() {
			/**
			 * getPasswordAuthentication
			 */
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		};
	}

	/**
	 * @Method Name : sendMail
	 * @Date : 2017. 10. 13.
	 * @User : 한진규
	 * @Param :
	 * @Return :
	 * @Method 설명 : 메일을 보낸다
	 */
	public synchronized void sendMail(String from, String to, String subject, String text) throws MessagingException {
		// 값을 준비한다
		prepareProperties();
		prepareAuthenticator();

		// 메일 세션을 가지고 온다 (무명 클래스 사용)
		Session mailSession = Session.getDefaultInstance(props_mailing, authenticator);

		// 메세지를 작성한다
		Message msg = new MimeMessage(mailSession);

		// 메시지를 세팅한다
		msg.setFrom(new InternetAddress(from));
		msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
		msg.setSubject(subject);
		msg.setText(text);
		msg.setSentDate(new Date());

		Transport.send(msg);
	}
	
	/**
	 * @Method Name : sendHtmlMail
	 * @Date : 2020. 10. 26
	 * @User : 김나영
	 * @Method 설명 : 메일 본문에 html를 포함하기 위한 메소드. 
	 */
	
	public synchronized void sendHtmlMail(String from, String to, String subject, String text) throws MessagingException {
		// 값을 준비한다
		prepareProperties();
		prepareAuthenticator();
		
		// 메세지를 작성한다
		MimeMessage message = mailSender.createMimeMessage();
		
		message.setFrom(new InternetAddress(from));
		message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
		message.setSubject(subject);
		message.setContent(text, "text/html;charset=utf-8");
		message.setSentDate(new Date());

		mailSender.send(message);
	}

	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private JavaMailSender bizMailSender;

	/**
	 * @Method Name : mailSending
	 * @Date : 2018. 08. 23.
	 * @User : 김지훈
	 * @Param :
	 * @Return :
	 * @Method 설명 : 메일을 보낸다
	 */
	public synchronized void mailSending(String fromMail, String toMail, String subject, String content,
			String fileName, String filePath, Date sentDate) throws MessagingException {

		if (sentDate != null) {
			// TaskDB에 저장한 다음(=예약), 시간에 맞춰 TaskService에서 발송하도록한다
		} else {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(fromMail); // 보내는사람 생략하거나 하면 정상작동을 안함
			messageHelper.setTo(toMail); // 받는사람 이메일
			messageHelper.setSubject(subject); // 메일제목은 생략이 가능하다
			messageHelper.setText(content); // 메일 내용

			if (fileName != null && fileName.length() > 0) {
				// 파일첨부1
				FileSystemResource fsr = new FileSystemResource(fileName);
				messageHelper.addAttachment(filePath, fsr); // "D:\\test2.txt"

				// 파일첨부2
				MimeBodyPart mbp = new MimeBodyPart();
				FileDataSource fds = new FileDataSource(filePath);
				mbp.setDataHandler(new DataHandler(fds));
				mbp.setFileName(fds.getName());
				Multipart mp = new MimeMultipart();
				mp.addBodyPart(mbp);
				message.setContent(mp);
			}
			mailSender.send(message);
		}
	}
	
	
	/**
	 * @Method Name : bizMailSending
	 * @Date : 2019. 01. 28.
	 * @User : 전상수
	 * @Param :
	 * @Return :
	 * @Method 설명 : 관리자 기업관리 메일을 보낸다
	 */
	public synchronized void bizMailSending(String fromMail, String toMail, String subject, String content,
			ArrayList<HashMap<String, String>> allMap, Date sentDate) throws MessagingException {
		
			JavaMailSenderImpl mSender = new JavaMailSenderImpl();
			mSender.setHost("smtp.gmail.com");
			mSender.setPort(587);
			mSender.setUsername("searpier@gmail.com");
			mSender.setPassword("wjstkdtntkdtn0");
			
			
			Properties props = mSender.getJavaMailProperties();
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.debug", "true");
		/*  mSender.setHost("smtp.gmail.com");
		    mSender.setPort(587);
		     
		    mSender.setUsername("my.gmail@gmail.com");
		    mSender.setPassword("password");
		     
		    Properties props = mailSender.getJavaMailProperties();
		    props.put("mail.transport.protocol", "smtp");
		    props.put("mail.smtp.auth", "true");
		    props.put("mail.smtp.starttls.enable", "true");
		    props.put("mail.debug", "true");*/
		
		if (sentDate != null) {
			// TaskDB에 저장한 다음(=예약), 시간에 맞춰 TaskService에서 발송하도록한다
		} else {
			MimeMessage message = mSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			int ii = 0;
			messageHelper.setFrom(fromMail); // 보내는사람 생략하거나 하면 정상작동을 안함
			messageHelper.setTo(toMail); // 받는사람 이메일
			messageHelper.setSubject(subject); // 메일제목은 생략이 가능하다
			messageHelper.setText(content); // 메일 내용
			Multipart mp = new MimeMultipart();
			if (allMap.get(0).get("savedfile") != null) {
				ii=allMap.size();
				// 파일첨부1
				//FileSystemResource fsr = new FileSystemResource(fileName);
				//messageHelper.addAttachment(filePath, fsr); // "D:\\test2.txt"
				
				
				for(int i=0;i<allMap.size();i++){
					MimeBodyPart mbp = new MimeBodyPart();
					FileDataSource fds = new FileDataSource("/usr/local/upload/"+allMap.get(i).get("savedfile"));
			
					mbp.setDataHandler(new DataHandler(fds));
					mbp.setFileName(allMap.get(i).get("originalfile"));
					mp.addBodyPart(mbp);
				
					/*FileSystemResource fsr = new FileSystemResource("D:/upload/"+allMap.get(i).get("savedfile"));
					messageHelper.addAttachment("D:/upload/"+allMap.get(i).get("savedfile"), fsr);*/
				}
				
				
			}
			MimeBodyPart mbp = new MimeBodyPart();
			/*mbp.setText(content);
			mp.addBodyPart(mbp);
			message.setContent(mp);	*/
			mbp.setContent(content, "text/html; charset=utf-8");
			mp.addBodyPart(mbp);
			message.setContent(mp);
			mSender.send(message);
	
		}
	}

	

	/**
	 * @Method Name : recieveAllMail
	 * @Date : 2019. 01. 07.
	 * @User : 전상수
	 * @Param :
	 * @Return :
	 * @Method 설명 : Gmail 게정에서 메일을 가져온다.
	 */

	public ArrayList<HashMap<String, Object>> recieveAllMail(HashMap<String, Object> max_mail) {

		ArrayList<HashMap<String, Object>> allMailList = new ArrayList<HashMap<String, Object>>();

		// set properties
		Properties properties = new Properties();
		// You can use imap or imaps , *s -Secured
		properties.put("mail.store.protocol", "imaps");
		// Host Address of Your Mail
		properties.put("mail.imaps.host", "imap.gmail.com");
		// Port number of your Mail Host
		properties.put("mail.imaps.port", "993");

		// properties.put("mail.imaps.timeout", "10000");

		try {

			// create a session
			Session session = Session.getDefaultInstance(properties, null);
			// SET the store for IMAPS
			Store store = session.getStore("imaps");

			System.out.println("Connection initiated......");
			// Trying to connect IMAP server
			store.connect("searpier@gmail.com", "wjstkdtntkdtn0");
			System.out.println("Connection is ready :)");

			// Get inbox folder
			Folder inbox = store.getFolder("inbox");
			// SET readonly format (*You can set read and write)
			inbox.open(Folder.READ_ONLY);

			// Display email Details

			// Inbox email count
			int messageCount = inbox.getMessageCount();
			System.out.println("Total Messages in INBOX:- " + messageCount);

			// Print Last 10 email information

			/*
			 * IMAPFolder imap=(IMAPFolder)inbox; imap.getMessageByUID(arg0);
			 */
			IMAPFolder imap = (IMAPFolder) inbox;

			boolean flag = true;

			if (max_mail != null) {
				int maxUid = ((BigInteger) max_mail.get("fap_mail_uid")).intValue();
				while (flag) {
					Message message = null;
					try {
						message = imap.getMessage(++maxUid);
					} catch (Exception e) {
						flag = false;
						continue;
					}

					if (message == null) {

						flag = false;
						continue;
					} else {
						HashMap<String, Object> hMap = new HashMap<String, Object>();

						String from = message.getFrom()[0].toString();
						System.out.println("******" + from + "************" + maxUid);
						if (from.contains("UTF-8") && from.split("\\?").length > 4) {
							if (from.split("\\?")[2].equals("B")) {
								byte[] decoded = Base64.getDecoder().decode(from.split("\\?")[3]);
								from = new String(decoded, "UTF-8");
							} else {
								String hexString = from.split("\\?")[3].split("_")[0].replaceAll("=", "");
								byte[] bytes = Hex.decodeHex(hexString.toCharArray());
								from = new String(bytes, "UTF-8");
							}
						}

						UIDFolder uf = (UIDFolder) inbox; // cast folder to
															// UIDFolder
															// interface
						Long messageId = uf.getUID(message);

						String[] domain = from.split(Pattern.quote("@"));
						if (domain.length > 1) {
							hMap.put("fap_mail_domain", domain[1]);
						} else {
							hMap.put("fap_mail_domain", domain[0]);
						}

						hMap.put("fap_mail_uid", messageId);
						hMap.put("fap_mail_subject", message.getSubject());
						hMap.put("fap_mail_from", from);
						hMap.put("fap_mail_content", getTextFromMessage(message));
						hMap.put("fap_mail_receivedate",
								new SimpleDateFormat("YYYY-MM-dd HH:mm").format(message.getReceivedDate()));


						allMailList.add(hMap);
					}

				}
			} else {
				int maxUid = 1;
				while (flag) {
					Message message = imap.getMessage(maxUid++);

					if (message == null) {
						flag = false;
					} else {
						HashMap<String, Object> hMap = new HashMap<String, Object>();

						String from = message.getFrom()[0].toString();

						if (from.contains("UTF-8") && from.split("\\?").length > 4) {
							if (from.split("\\?")[2].equals("B")) {
								byte[] decoded = Base64.getDecoder().decode(from.split("\\?")[3]);
								from = new String(decoded, "UTF-8");
							} else {
								String hexString = from.split("\\?")[3].split("_")[0].replaceAll("=", "");
								byte[] bytes = Hex.decodeHex(hexString.toCharArray());
								from = new String(bytes, "UTF-8");
							}
						}

						UIDFolder uf = (UIDFolder) inbox; // cast folder to
															// UIDFolder
															// interface
						Long messageId = uf.getUID(message);

						hMap.put("fap_mail_uid", messageId);

						String[] domain = from.split(Pattern.quote("@"));
						if (domain.length > 1) {
							hMap.put("fap_mail_domain", domain[1]);
						} else {
							hMap.put("fap_mail_domain", domain[0]);
						}

						hMap.put("fap_mail_subject", message.getSubject());
						hMap.put("fap_mail_from", from);
						hMap.put("fap_mail_content", getTextFromMessage(message));
						hMap.put("fap_mail_receivedate",
								new SimpleDateFormat("YYYY-MM-dd HH:mm").format(message.getReceivedDate()));

						allMailList.add(hMap);
					}
				}

			}
			inbox.close(true);
			store.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return allMailList;
	}

	private String getTextFromMessage(Message message) throws MessagingException, IOException {
		String result = "";
		if (message.isMimeType("text/plain")) {
			result = message.getContent().toString();
		} else if (message.isMimeType("multipart/*")) {
			MimeMultipart mimeMultipart = (MimeMultipart) message.getContent();
			result = getTextFromMimeMultipart(mimeMultipart);
		} else {
			result = message.toString();
		}
		return result;
	}

	private String getTextFromMimeMultipart(MimeMultipart mimeMultipart) throws MessagingException, IOException {
		String result = "";
		int count = mimeMultipart.getCount();
		for (int i = 0; i < count; i++) {
			BodyPart bodyPart = mimeMultipart.getBodyPart(i);
			if (bodyPart.isMimeType("text/plain")) {
				result = result + "<br>" + bodyPart.getContent();
				break; // without break same text appears twice in my tests
			} else if (bodyPart.isMimeType("text/html")) {
				String html = (String) bodyPart.getContent();
				result = result + "<br>" + html;
			} else if (bodyPart.getContent() instanceof MimeMultipart) {
				result = result + getTextFromMimeMultipart((MimeMultipart) bodyPart.getContent());
			}
		}
		return result;
	}

}
