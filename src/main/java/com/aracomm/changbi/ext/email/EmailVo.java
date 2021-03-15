package com.aracomm.changbi.ext.email;

/**
 * @Class Name : Email.java
 * @Description : 이메일 발송용 정보
 * @Modification Information
 * @
 * @  수정일                 수정자                       수정내용
 * @ -------    --------    ---------------------------
 * @ 2017.03.21   김준석                      최초 생성
 *
 *  @author kjs
 *  @since 2017.03.21
 *  @version 1.0
 *  @see
 *
 */

public class EmailVo {

    /** 제목 */
    private String subject;

    /** 내용 */
    private String content;

    /** 저장날짜 */
    private String regdate;

    /** 받는 사람 메일주소 */
    private String receiver;

	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
}
