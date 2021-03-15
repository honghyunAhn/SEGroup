package com.aracomm.changbi.user.vo;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class AttendanceInfoTime {

	private int attInfoTimeSeq;
	private int attDtSeq;
	private String cardinalId;
	private String userId;
	private String userNm;
	private String inTime;
	private String outTime;
	private String memo;
	private String attFinalGubun;
	private String regOriginFile;
	private String regSavedFile;
	private CommonsMultipartFile regFile;
	private String certificationAttached;
	
	
	public AttendanceInfoTime() {
		super();
	}

	public AttendanceInfoTime(int attInfoTimeSeq, int attDtSeq, String cardinalId, String userId, String userNm,
			String inTime, String outTime, String memo, String attFinalGubun, String regOriginFile, String regSavedFile,
			CommonsMultipartFile regFile, String certificationAttached) {
		super();
		this.attInfoTimeSeq = attInfoTimeSeq;
		this.attDtSeq = attDtSeq;
		this.cardinalId = cardinalId;
		this.userId = userId;
		this.userNm = userNm;
		this.inTime = inTime;
		this.outTime = outTime;
		this.memo = memo;
		this.attFinalGubun = attFinalGubun;
		this.regOriginFile = regOriginFile;
		this.regSavedFile = regSavedFile;
		this.regFile = regFile;
		this.certificationAttached = certificationAttached;
	}

	public int getAttInfoTimeSeq() {
		return attInfoTimeSeq;
	}

	public void setAttInfoTimeSeq(int attInfoTimeSeq) {
		this.attInfoTimeSeq = attInfoTimeSeq;
	}

	public int getAttDtSeq() {
		return attDtSeq;
	}

	public void setAttDtSeq(int attDtSeq) {
		this.attDtSeq = attDtSeq;
	}

	public String getCardinalId() {
		return cardinalId;
	}

	public void setCardinalId(String cardinalId) {
		this.cardinalId = cardinalId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getInTime() {
		return inTime;
	}

	public void setInTime(String inTime) {
		this.inTime = inTime;
	}

	public String getOutTime() {
		return outTime;
	}

	public void setOutTime(String outTime) {
		this.outTime = outTime;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getAttFinalGubun() {
		return attFinalGubun;
	}

	public void setAttFinalGubun(String attFinalGubun) {
		this.attFinalGubun = attFinalGubun;
	}

	public String getRegOriginFile() {
		return regOriginFile;
	}

	public void setRegOriginFile(String regOriginFile) {
		this.regOriginFile = regOriginFile;
	}

	public String getRegSavedFile() {
		return regSavedFile;
	}

	public void setRegSavedFile(String regSavedFile) {
		this.regSavedFile = regSavedFile;
	}

	public CommonsMultipartFile getRegFile() {
		return regFile;
	}

	public void setRegFile(CommonsMultipartFile regFile) {
		this.regFile = regFile;
	}

	public String getCertificationAttached() {
		return certificationAttached;
	}

	public void setCertificationAttached(String certificationAttached) {
		this.certificationAttached = certificationAttached;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	@Override
	public String toString() {
		return "AttendanceInfoTime [attInfoTimeSeq=" + attInfoTimeSeq + ", attDtSeq=" + attDtSeq + ", cardinalId="
				+ cardinalId + ", userId=" + userId + ", userNm=" + userNm + ", inTime=" + inTime + ", outTime="
				+ outTime + ", memo=" + memo + ", attFinalGubun=" + attFinalGubun + ", regOriginFile=" + regOriginFile
				+ ", regSavedFile=" + regSavedFile + ", regFile=" + regFile + ", certificationAttached="
				+ certificationAttached + "]";
	}
}
