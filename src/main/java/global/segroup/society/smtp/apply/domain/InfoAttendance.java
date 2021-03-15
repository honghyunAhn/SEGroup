package global.segroup.society.smtp.apply.domain;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class InfoAttendance {
	
	private int attInfoSeq;
	private int attDtSeq;
	private int attDtSeqGroup;
	private String userId;
	private String inTime;
	private String outTime;
	private String attInfoGubun;
	private String memo;
	private String regOriginFile;
	private String regSavedFile;
	private CommonsMultipartFile regFile;
	private String regDate;
	private String regUser;
	private String updUser;
	private String updDate;
	
	
	public InfoAttendance(int attInfoSeq, int attDtSeq, int attDtSeqGroup, String userId, String inTime, String outTime,
			String attInfoGubun, String memo, String regOriginFile, String regSavedFile, CommonsMultipartFile regFile,
			String regDate, String regUser, String updUser, String updDate) {
		super();
		this.attInfoSeq = attInfoSeq;
		this.attDtSeq = attDtSeq;
		this.attDtSeqGroup = attDtSeqGroup;
		this.userId = userId;
		this.inTime = inTime;
		this.outTime = outTime;
		this.attInfoGubun = attInfoGubun;
		this.memo = memo;
		this.regOriginFile = regOriginFile;
		this.regSavedFile = regSavedFile;
		this.regFile = regFile;
		this.regDate = regDate;
		this.regUser = regUser;
		this.updUser = updUser;
		this.updDate = updDate;
	}

	public InfoAttendance() {
		super();
	}

	public int getAttInfoSeq() {
		return attInfoSeq;
	}

	public void setAttInfoSeq(int attInfoSeq) {
		this.attInfoSeq = attInfoSeq;
	}

	public int getAttDtSeq() {
		return attDtSeq;
	}

	public void setAttDtSeq(int attDtSeq) {
		this.attDtSeq = attDtSeq;
	}

	public int getAttDtSeqGroup() {
		return attDtSeqGroup;
	}

	public void setAttDtSeqGroup(int attDtSeqGroup) {
		this.attDtSeqGroup = attDtSeqGroup;
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

	public String getAttInfoGubun() {
		return attInfoGubun;
	}

	public void setAttInfoGubun(String attInfoGubun) {
		this.attInfoGubun = attInfoGubun;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
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

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getRegUser() {
		return regUser;
	}

	public void setRegUser(String regUser) {
		this.regUser = regUser;
	}

	public String getUpdUser() {
		return updUser;
	}

	public void setUpdUser(String updUser) {
		this.updUser = updUser;
	}

	public String getUpdDate() {
		return updDate;
	}

	public void setUpdDate(String updDate) {
		this.updDate = updDate;
	}

	@Override
	public String toString() {
		return "InfoAttendance [attInfoSeq=" + attInfoSeq + ", attDtSeq=" + attDtSeq + ", attDtSeqGroup="
				+ attDtSeqGroup + ", userId=" + userId + ", inTime=" + inTime + ", outTime=" + outTime
				+ ", attInfoGubun=" + attInfoGubun + ", memo=" + memo + ", regOriginFile=" + regOriginFile
				+ ", regSavedFile=" + regSavedFile + ", regFile=" + regFile + ", regDate=" + regDate + ", regUser="
				+ regUser + ", updUser=" + updUser + ", updDate=" + updDate + "]";
	}
	
}
