package com.aracomm.changbi.mypage.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aracomm.changbi.mypage.dao.PrivateDao;

@Service
public class PrivateService {
	@Autowired
	private PrivateDao dao;

	public Map<String, Object> selectMyInfo(String user_id) {
		return dao.selectMyInfo(user_id);
	}

	public int updateMember(Map<String, String> param) {
		return dao.updateMember(param);
	}

	@Transactional
	public int saveWithdraw(Map<String, String> param) {
		// TODO 탈퇴시 처리해야할 부가 내용 입수 후 수정할 것(포인트, 쿠폰 등)

		// 회원정보 초기화
		String user_id = param.get("user_id");
		dao.updateMemberOut(user_id);

		// 탈퇴정보 등록
		return dao.insertMemberOut(param);
	}

	public Map<String, String> selectMyInfoForWithdraw(String user_id) {
		return dao.selectMyInfoForWithdraw(user_id);
	}

}
