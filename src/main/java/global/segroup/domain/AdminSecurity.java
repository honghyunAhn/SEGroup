/**
 * 
 */
package global.segroup.domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * @Author : 이종호
 * @Date : 2017. 8. 8.
 * @Class 설명 : 스프링 시큐리티가 관리하는 Admin VO 클래스
 * 
 */
public class AdminSecurity implements UserDetails {

	private static final long serialVersionUID = -2019409004670680172L;
	
	private Admin admin;
	
	public AdminSecurity(Admin admin){
		this.admin = admin;
	}
	
	public Admin getAdmin(){
		return admin;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority("ROLE_"+admin.getAdmin_grade()));
		return authorities;
	}

	@Override
	public String getPassword() {
		return admin.getAdmin_pw();
	}

	@Override
	public String getUsername() {
		return admin.getAdmin_nm();
	}

	//기간제 계정의 경우 기간만료 여부
	@Override
	public boolean isAccountNonExpired() {
		if(admin.getAdmin_state().equals("A0802")){
			return true;
		}else{
			return false;
		}
	}
	
	//사용제제 여부
	@Override
	public boolean isAccountNonLocked() {
		if(admin.getAdmin_state().equals("A0803")){
			return true;
		}else{
			return false;
		}
	}
	
	//인증정보 만료 여부
	@Override
	public boolean isCredentialsNonExpired() {
		return false;
	}

	//휴면계정 여부
	@Override
	public boolean isEnabled() {
		if(admin.getAdmin_state().equals("A0801")){
			return true;
		}else{
			return false;
		}
	}
	
}
