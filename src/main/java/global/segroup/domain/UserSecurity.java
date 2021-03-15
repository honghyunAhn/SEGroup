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
 * @Class 설명 : 스프링 시큐리티가 관리하는 User 클래스
 * 
 */
public class UserSecurity implements UserDetails{
	
	private static final long serialVersionUID = -7084588819777716024L;
	
	private User user;
	
	public UserSecurity(User user){
		this.user = user;
	}
	
	public User getUser(){
		return user;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority("ROLE_"+user.getUser_flag()));
		return authorities;
	}

	@Override
	public String getPassword() {
		return user.getUser_pw();
	}

	@Override
	public String getUsername() {
		return user.getUser_nm();
	}

	//기간제 계정의 경우 기간만료 여부 
	//탈퇴여부
	@Override
	public boolean isAccountNonExpired() {
		if(user.getUser_state().equals("A0202")){
			return true;
		}else{
			return false;
		}
	}

	//사용제제 여부
	//정지 여부
	@Override
	public boolean isAccountNonLocked() {
		if(user.getUser_state().equals("A0203")){
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
		if(user.getUser_state().equals("A0201")){
			return true;
		}else{
			return false;
		}
	}
	
}
