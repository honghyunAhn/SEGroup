package com.aracomm.changbi.ext.sms;

public interface SmsSendService {
	public boolean sendSms(String sendPhone, String recvPhone, String cont);	// sms 단문 발송
}
