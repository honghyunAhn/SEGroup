/**
 * 
 */
package global.segroup.domain;

/**
 * @Author : 전상수
 * @Date : 2018. 9. 12.
 * @Class 설명 : 휴대폰본인인증정보
 * 
 */
public class UserVerification {

	private String veriCi;
	private String veriDi;
	private String veriPhone;
	private String veriCom;
	private String veriBirth;
	private String veriGender;
	private String veriNation;
	private String veriName;
	private String veriNum;
	private String veriTime;
	private String user_id;

	/**
	 * @Desc :
	 * @param veriCi
	 * @param veriDi
	 * @param veriPhone
	 * @param veriCom
	 * @param veriBirth
	 * @param veriGender
	 * @param veriNation
	 * @param veriName
	 * @param veriNum
	 * @param veriTime
	 * @param user_id
	 */
	public UserVerification(String veriCi, String veriDi, String veriPhone, String veriCom, String veriBirth,
			String veriGender, String veriNation, String veriName, String veriNum, String veriTime, String user_id) {
		super();
		this.veriCi = veriCi;
		this.veriDi = veriDi;
		this.veriPhone = veriPhone;
		this.veriCom = veriCom;
		this.veriBirth = veriBirth;
		this.veriGender = veriGender;
		this.veriNation = veriNation;
		this.veriName = veriName;
		this.veriNum = veriNum;
		this.veriTime = veriTime;
		this.user_id = user_id;
	}

	/**
	 * @Desc :
	 */
	public UserVerification() {
		super();
	}

	public String getVeriCi() {
		return veriCi;
	}

	public void setVeriCi(String veriCi) {
		this.veriCi = veriCi;
	}

	public String getVeriDi() {
		return veriDi;
	}

	public void setVeriDi(String veriDi) {
		this.veriDi = veriDi;
	}

	public String getVeriPhone() {
		return veriPhone;
	}

	public void setVeriPhone(String veriPhone) {
		this.veriPhone = veriPhone;
	}

	public String getVeriCom() {
		return veriCom;
	}

	public void setVeriCom(String veriCom) {
		this.veriCom = veriCom;
	}

	public String getVeriBirth() {
		return veriBirth;
	}

	public void setVeriBirth(String veriBirth) {
		this.veriBirth = veriBirth;
	}

	public String getVeriGender() {
		return veriGender;
	}

	public void setVeriGender(String veriGender) {
		this.veriGender = veriGender;
	}

	public String getVeriNation() {
		return veriNation;
	}

	public void setVeriNation(String veriNation) {
		this.veriNation = veriNation;
	}

	public String getVeriName() {
		return veriName;
	}

	public void setVeriName(String veriName) {
		this.veriName = veriName;
	}

	public String getVeriNum() {
		return veriNum;
	}

	public void setVeriNum(String veriNum) {
		this.veriNum = veriNum;
	}

	public String getVeriTime() {
		return veriTime;
	}

	public void setVeriTime(String veriTime) {
		this.veriTime = veriTime;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	@Override
	public String toString() {
		return "UserVerification [veriCi=" + veriCi + ", veriDi=" + veriDi + ", veriPhone=" + veriPhone + ", veriCom="
				+ veriCom + ", veriBirth=" + veriBirth + ", veriGender=" + veriGender + ", veriNation=" + veriNation
				+ ", veriName=" + veriName + ", veriNum=" + veriNum + ", veriTime=" + veriTime + ", user_id=" + user_id
				+ "]";
	}

}
