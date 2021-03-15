/**
 * 
 */
package global.segroup.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.regex.Pattern;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.UIDFolder;
import javax.mail.internet.MimeMultipart;

import org.apache.commons.codec.binary.Hex;

import com.sun.mail.imap.IMAPFolder;

/**
 * @Author : user
 * @Date : 2019. 1. 23.
 * @Class 설명 :
 * 
 */
public class MailReceptor implements Runnable {

	private Message message;
	private Long messageId;
	private ArrayList<HashMap<String, Object>> allMailList;
	UIDFolder uf;

	public MailReceptor(ArrayList<HashMap<String, Object>> allMailList, IMAPFolder imap, int maxUid, UIDFolder uf) {
		try {
			this.message = imap.getMessageByUID(maxUid);
			if(message!=null)
			this.messageId = uf.getUID(this.message);
			this.allMailList = allMailList;
			this.uf = uf;
		} catch (Exception e) {
			this.allMailList = null;
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Runnable#run()
	 */
	@Override
	public void run() {
		// TODO Auto-generated method stub
		if (message == null || allMailList == null) {
			return;
		} else {
			HashMap<String, Object> hMap = new HashMap<String, Object>();

			String from = null;
			try {
				from = message.getFrom()[0].toString();
				
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (from.contains("UTF-8") && from.split("\\?").length > 4) {
				if (from.split("\\?")[2].equals("B")) {
					byte[] decoded = Base64.getDecoder().decode(from.split("\\?")[3]);
					try {
						from = new String(decoded, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				} else {
					String hexString = from.split("\\?")[3].split("_")[0].replaceAll("=", "");

					try {
						byte[] bytes = Hex.decodeHex(hexString.toCharArray());
						from = new String(bytes, "UTF-8");
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}

			String[] domain = from.split(Pattern.quote("@"));
			if (domain.length > 1) {
				hMap.put("fap_mail_domain", domain[1]);
			} else {
				hMap.put("fap_mail_domain", domain[0]);
			}

			hMap.put("fap_mail_uid", messageId);
			try {
				hMap.put("fap_mail_subject", message.getSubject());
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			hMap.put("fap_mail_from", from);
			try {
				hMap.put("fap_mail_content", getTextFromMessage(message));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				hMap.put("fap_mail_receivedate",
						new SimpleDateFormat("YYYY-MM-dd HH:mm").format(message.getReceivedDate()));
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			allMailList.add(hMap);
		}
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
