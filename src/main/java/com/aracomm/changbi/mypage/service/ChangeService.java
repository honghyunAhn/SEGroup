package com.aracomm.changbi.mypage.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.member.dao.PointDao;
import com.aracomm.changbi.mypage.dao.ChangeDao;
import com.aracomm.changbi.mypage.vo.ChangePolicyVo;
import com.aracomm.changbi.mypage.vo.LectureSearchVo;

@Service
public class ChangeService {

	@Autowired
	private ChangeDao dao;

	@Autowired
	private PointDao pointDao;

	@Autowired
	MessageSource messageSource;

	public List<HashMap<String, Object>> selectChangeableLectureList(LectureSearchVo searchVO) {
		ChangePolicyVo policyVO = dao.selectChangePolicy();

		searchVO.setTotalCnt(dao.selectChangeableLectureCnt(searchVO));
		List<HashMap<String, Object>> list = dao.selectChangeableLectureList(searchVO);

		for (HashMap<String, Object> map : list) {
			map.put("CANCELABLE", isCancelableLecture(map, policyVO));
			map.put("DELAYABLE", isDelayableLecture(map, policyVO));
			map.put("CHANGEABLE", isChangeableLecture(map));
		}

		return list;
	}

	public List<HashMap<String, Object>> selectChangedLectureList(LectureSearchVo searchVO) {
		searchVO.setTotalCnt(dao.selectChangedLectureCnt(searchVO));
		return dao.selectChangedLectureList(searchVO);
	}

	public HashMap<String, Object> selectCurrentLecture(HashMap<String, Object> params) {
		return dao.selectCurrentLecture(params);
	}

	public List<HashMap<String, Object>> selectChangeableLecture(HashMap<String, Object> params) {
		return dao.selectOtherChangeableLectureList(params);
	}

	public List<HashMap<String, Object>> selectDelayableLecture(HashMap<String, Object> params) {
		return dao.selectOtherDelayableLectureList(params);
	}


	public int saveChangeLecture(HashMap<String, Object> params) {
		params.put("reqType", GlobalConst.REQ_TYPE_CHANGE);
		dao.updateLearnAppMaster(params);

		return dao.insertLearnChangeApp(params);
	}

	public int saveDelayLecture(HashMap<String, Object> params) {
		params.put("reqType", GlobalConst.REQ_TYPE_DELAY);
		dao.updateLearnAppMaster(params);

		return dao.insertLearnDelayApp(params);
	}

	public int saveCancelLecture(HashMap<String, Object> params) {
		params.put("reqType", GlobalConst.REQ_TYPE_CANCEL);
		dao.updateLearnAppMaster(params);

		/*
		 * 관리자에서 취소할 때 처리
		// 포인트 환급(사용포인트,적립포인트)
		Map<String, Object> point = new HashMap<String, Object>();
		point.put("learn_app_id", params.get("learnAppId"));
		point.put("note", messageSource.getMessage("point.applyCancel", null, "point.applyCancel", Locale.getDefault()));
		pointDao.insertPointForApplyCancel(point);
		*/

		return dao.insertLearnCancelApp(params);
	}

	//취소정책에 따른 취소가능여부
	private boolean isCancelableLecture(HashMap<String, Object> map, ChangePolicyVo policyVO) {
		int cancel = Integer.parseInt(String.valueOf(map.get("CANCEL"))); // (int) map.get("CANCEL");
		int diff_payment = (int) map.get("DIFF_PAYMENT"); //결제일로부터 경과일수
		int diff_learn = (int) map.get("DIFF_LEARN"); //연수시작일로부터 경과일수

		//데이터베이스에 값이 없는경우,
		if (policyVO == null) policyVO = new ChangePolicyVo();

		if (cancel == 0) { //CB_CARDINAL.CANCEL의 값이 0이면 CB_POLICY_DELAY_CANCEL의 정책을 따름.

			/** CANCEL_COURSE_DAY에 의한 정책 : 결제일 기준 */
			if (policyVO.getCancelCourseDay() == 0) {
				//CANCEL_COURSE_DAY가 0이면 취소 불가
				return false;
			} else {
				//결제완료 후 CANCEL_COURSE_DAY 일자까지 취소요청이 가능함.
				if (diff_payment <= policyVO.getCancelCourseDay()) return true;
			}

			/** CANCEL_TRAIN_DAY에 의한 정책 : 연수시작일 기준 */
			if (policyVO.getCancelTrainDay() == 0) {
				//연수시작일 이전까지만 취소가 가능함.
				if (diff_learn > 0) return true;
			} else {
				//연수시작일로부터 CANCEL_TRAIN_DAY 일자까지 취소요청이 가능함.
				if (diff_learn <= policyVO.getCancelTrainDay()) return true;
			}

		} else { //CB_CARDINAL.CANCEL의 값에 따라 결정.
			//결제완료 후 cancel 일자까지 취소요청이 가능함.
			if (diff_payment <= cancel ) return true;
		}

		return false;
	}

	//연기정책에 따른 연기가능여부
	private boolean isDelayableLecture(HashMap<String, Object> map, ChangePolicyVo policyVO) {
		int diff_payment = (int) map.get("DIFF_PAYMENT"); //결제일로부터 경과일수
		int diff_learn = (int) map.get("DIFF_LEARN"); //연수시작일로부터 경과일수

		//데이터베이스에 값이 없는경우,
		if (policyVO == null) policyVO = new ChangePolicyVo();

		/** DELAY_COURSE_DAY에 의한 정책 : 결제일 기준 */
		if (policyVO.getDelayCourseDay() == 0) {
			//DELAY_COURSE_DAY가 0이면 연기 불가
			return false;
		} else {
			//결제완료 후 DELAY_COURSE_DAY 일자까지 연기요청이 가능함.
			if (diff_payment <= policyVO.getDelayCourseDay()) return true;
		}

		/** DELAY_TRAIN_DAY에 의한 정책 : 연수시작일 기준 */
		if (policyVO.getDelayTrainDay() == 0) {
			//연수시작일 이전까지만 연기가 가능함.
			if (diff_learn > 0) return true;
		} else {
			//연수시작일로부터 DELAY_TRAIN_DAY 일자까지 연기요청이 가능함.
			if (diff_learn <= policyVO.getDelayTrainDay()) return true;
		}

		return false;
	}

	//변경정책에 따른 연기가능여부 : 별도의 정책테이블이 없음.
	//결제완료 후 연수시작일 전까지 동일 학점의 과정으로 변경 가능.
	private boolean isChangeableLecture(HashMap<String, Object> map) {
		int diff_learn = (int) map.get("DIFF_LEARN"); //연수시작일로부터 경과일수

		//연수시작일 이전까지만 과정변경이 가능함.
		if (diff_learn > 0) return true;

		return false;
	}
}
