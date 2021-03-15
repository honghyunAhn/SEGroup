package com.aracomm.changbi.ext.sms;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.sms.dao.SmsDao;

@Service("smsSendService")
public class SmsSendServiceImpl implements SmsSendService {
	private static final Logger logger = LoggerFactory.getLogger(SmsSendServiceImpl.class);

	@Autowired
	private SmsDao dao;

	@Override
	public boolean sendSms(String phone, String callback, String msg) {
		logger.debug("sendPhone:{}, recvPhone{}, cont:{}", new String [] {callback, phone, msg});

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("phone", phone);
		param.put("callback", callback);
		param.put("msg", msg);
		//dao.insertSms(param);

		return true;
	}

}
