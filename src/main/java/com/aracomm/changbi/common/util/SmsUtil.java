package com.aracomm.changbi.common.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.HttpClients;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.sms.dao.SmsDao;

/**
 * 
 * @Author : 이종호
 * @Date : 2019. 7. 10.
 * @Class 설명 : LMS SMS Util 클래스
 * 
 */
@Service
public class SmsUtil {
	
	@Value("#{config['sms.send.url']}")
	private String smsSendUrl;
	
	@Value("#{config['sms.send.id']}")
	private String smsSendId;
	
	@Value("#{config['sms.send.key']}")
	private String smsSendKey;
	
	@Value("#{config['sms.send.phone']}")
	private String smsSendPhone;
	
	@Value("#{config['sms.send.encType']}")
	private String smsSendEncType;
	
	@Autowired
	private SmsDao dao;
	
	/**
	* @Method Name : send_sms
	* @Date : 2019. 7. 10.
	* @User : 이종호
	* @Param : 
	* @Return : 
	* @Method 설명 : LMS
	*/
	public boolean send_sms(String id, String phone, String msg, String title, String rdate, String rtime) {
		String responseStr = "";
		String result_code = "0";
		boolean result_flag = false;
		try {
			
			//설정
			
			final String boundary = "____boundary____";
			
			String receiver = CommonUtil.removeTelSeparator(phone);
			String destination = receiver+"|"+id;
			
			Map<String, String> sms = new HashMap<>();
			
			sms.put("user_id", smsSendId);
			sms.put("key", smsSendKey);
			sms.put("msg", msg);
			sms.put("receiver", receiver);
			sms.put("destination", destination);
			sms.put("sender", smsSendPhone);
			sms.put("title", title);
			
			if(rdate != null && rtime != null) {
				sms.put("rdate", rdate); //예약일자 - 20190710 : 2019-07-10일 기준
				sms.put("rtime", rtime); //예약시간 - 1830 : 오후 6시 30분
			}

			System.out.println(sms);
			
			//전송
			MultipartEntityBuilder builder = MultipartEntityBuilder.create();
			
			builder.setBoundary(boundary);
			builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
			builder.setCharset(Charset.forName(smsSendEncType));
			
			for(Iterator<String> i = sms.keySet().iterator(); i.hasNext();){
				String key = i.next();
				builder.addTextBody(key, sms.get(key)
						, ContentType.create("Multipart/related", smsSendEncType));
			}
			
			HttpEntity entity = builder.build();
			HttpClient client = HttpClients.createDefault();
			HttpPost post = new HttpPost(smsSendUrl);
			post.setEntity(entity);
			
			HttpResponse res = client.execute(post);
			
			if(res != null){
				BufferedReader in = new BufferedReader(new InputStreamReader(res.getEntity().getContent(), smsSendEncType));
				String buffer = null;
				while((buffer = in.readLine())!=null){
					responseStr += buffer;
				}
				in.close();
			}
			
			Map<String, Object> param = new HashMap<>();
			param.put("user_id", id);
			param.put("phone", phone);
			param.put("subject", title);
			param.put("content", msg);
			param.put("reg_id", id);
			
			
			System.out.println("responseStr : " + responseStr);
			
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(responseStr);
			JSONObject jsonObj = (JSONObject)obj;

			result_code = (String) jsonObj.get("result_code");
			
			if(result_code.equals("1")) {
				result_flag = true;
				dao.insertSmsHistroy(param);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result_flag;
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
