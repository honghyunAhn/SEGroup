package com.aracomm.changbi.member.service;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.aracomm.changbi.member.dao.MemberDao;
import com.aracomm.changbi.member.dao.PointDao;
import com.aracomm.changbi.member.vo.MemberForm;

@Service
public class MemberService {

	@Autowired
	private MemberDao dao;

	@Autowired
	private PointDao pointDao;

	@Autowired
	SessionLocaleResolver localeResolver;

	@Autowired
	MessageSource messageSource;

	public HashMap<String, Object> selectMember1(String id) {
		return dao.selectMember1(id);
	}

	public HashMap<String, Object> selectValidMemberByDi(String iden_di) {
		return dao.selectValidMemberByDi(iden_di);
	}


	public int selectValidMemberCountById(String id) {
		return dao.selectValidMemberCountById(id);
	}

	public int selectMemberCountByNeis(String neis_num) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("neis_num", neis_num);
		return dao.selectMemberCountByNeis(param);
	}

	public int selectMemberCountByNeis(String neis_num, String user_id) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("neis_num", neis_num);
		param.put("user_id", user_id);
		return dao.selectMemberCountByNeis(param);
	}

	@Transactional
	public int saveMember(MemberForm memberForm) {
		// 회원등록
		memberForm.toString();
		int affected = dao.insertUser(memberForm);

		// 정첵에 따른 포인트 등록
		Map<String, Object> pointPolicy = pointDao.selectPolicyPoint();
		Map<String, Object> point;
		if (pointPolicy != null) {
			// 회원가입 포인트 등록
			String useYn = (String)pointPolicy.get("SAVE_JOIN_USE");
			if("Y".equals(useYn)) {
				point = new HashMap<String, Object>();
				point.put("user_id", memberForm.getId());
				point.put("learn_app_id", null);
				//point.put("name", memberForm.getName());
				point.put("give", pointPolicy.get("SAVE_JOIN_POINT"));
				point.put("withdraw", 0);
				point.put("note", messageSource.getMessage("point.joinSave", null, "point.joinSave", Locale.getDefault()));
				pointDao.insertPoint(point);
			}

			// 추천인 포인트 등록
			String recomm_id = memberForm.getRecomm_id();
			if(!StringUtils.isEmpty(recomm_id)) {
				point = new HashMap<String, Object>();
				point.put("user_id", recomm_id);
				point.put("learn_app_id", null);
				//point.put("name", memberForm.getName());
				point.put("give", pointPolicy.get("SAVE_JOIN_POINT"));
				point.put("withdraw", 0);
				point.put("note", messageSource.getMessage("point.recommenderSave", new String [] {memberForm.getId()}, "point.recommenderSave", Locale.getDefault()));
				pointDao.insertPoint(point);
			}
		}

		return affected;
	}

	public HashMap<String, String> selectMemberForFindId(String name, String phone) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("name", name);
		param.put("phone", phone);
		return dao.selectMemberForFindId(param);
	}

	public HashMap<String, String> selectMemberForFindPw(String id, String phone) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		param.put("phone", phone);
		return dao.selectMemberForFindPw(param);
	}

	public int selectMemberCountByIdPasswd(String id, String passwd) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		param.put("pw", passwd);
		return dao.selectMemberCountByIdPasswd(param);
	}

	public int updateTempPassword(String id, String phone, String passwd) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		param.put("phone", phone);
		param.put("pw", passwd);
		return dao.updateTempPassword(param);
	}
	
	public int selectMemberCountById(String id) {
		return dao.selectMemberCountById(id);
	}

	public int updatePassword(String user_id, String user_pw) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", user_id);
		param.put("pw", user_pw);
		return dao.updatePassword(param);
	}

	public int checkEmailDuplicated(String email) {
		return dao.checkEmailDuplicated(email);
	}
	

	


}
