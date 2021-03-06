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
		 * ??????????????? ????????? ??? ??????
		// ????????? ??????(???????????????,???????????????)
		Map<String, Object> point = new HashMap<String, Object>();
		point.put("learn_app_id", params.get("learnAppId"));
		point.put("note", messageSource.getMessage("point.applyCancel", null, "point.applyCancel", Locale.getDefault()));
		pointDao.insertPointForApplyCancel(point);
		*/

		return dao.insertLearnCancelApp(params);
	}

	//??????????????? ?????? ??????????????????
	private boolean isCancelableLecture(HashMap<String, Object> map, ChangePolicyVo policyVO) {
		int cancel = Integer.parseInt(String.valueOf(map.get("CANCEL"))); // (int) map.get("CANCEL");
		int diff_payment = (int) map.get("DIFF_PAYMENT"); //?????????????????? ????????????
		int diff_learn = (int) map.get("DIFF_LEARN"); //???????????????????????? ????????????

		//????????????????????? ?????? ????????????,
		if (policyVO == null) policyVO = new ChangePolicyVo();

		if (cancel == 0) { //CB_CARDINAL.CANCEL??? ?????? 0?????? CB_POLICY_DELAY_CANCEL??? ????????? ??????.

			/** CANCEL_COURSE_DAY??? ?????? ?????? : ????????? ?????? */
			if (policyVO.getCancelCourseDay() == 0) {
				//CANCEL_COURSE_DAY??? 0?????? ?????? ??????
				return false;
			} else {
				//???????????? ??? CANCEL_COURSE_DAY ???????????? ??????????????? ?????????.
				if (diff_payment <= policyVO.getCancelCourseDay()) return true;
			}

			/** CANCEL_TRAIN_DAY??? ?????? ?????? : ??????????????? ?????? */
			if (policyVO.getCancelTrainDay() == 0) {
				//??????????????? ??????????????? ????????? ?????????.
				if (diff_learn > 0) return true;
			} else {
				//???????????????????????? CANCEL_TRAIN_DAY ???????????? ??????????????? ?????????.
				if (diff_learn <= policyVO.getCancelTrainDay()) return true;
			}

		} else { //CB_CARDINAL.CANCEL??? ?????? ?????? ??????.
			//???????????? ??? cancel ???????????? ??????????????? ?????????.
			if (diff_payment <= cancel ) return true;
		}

		return false;
	}

	//??????????????? ?????? ??????????????????
	private boolean isDelayableLecture(HashMap<String, Object> map, ChangePolicyVo policyVO) {
		int diff_payment = (int) map.get("DIFF_PAYMENT"); //?????????????????? ????????????
		int diff_learn = (int) map.get("DIFF_LEARN"); //???????????????????????? ????????????

		//????????????????????? ?????? ????????????,
		if (policyVO == null) policyVO = new ChangePolicyVo();

		/** DELAY_COURSE_DAY??? ?????? ?????? : ????????? ?????? */
		if (policyVO.getDelayCourseDay() == 0) {
			//DELAY_COURSE_DAY??? 0?????? ?????? ??????
			return false;
		} else {
			//???????????? ??? DELAY_COURSE_DAY ???????????? ??????????????? ?????????.
			if (diff_payment <= policyVO.getDelayCourseDay()) return true;
		}

		/** DELAY_TRAIN_DAY??? ?????? ?????? : ??????????????? ?????? */
		if (policyVO.getDelayTrainDay() == 0) {
			//??????????????? ??????????????? ????????? ?????????.
			if (diff_learn > 0) return true;
		} else {
			//???????????????????????? DELAY_TRAIN_DAY ???????????? ??????????????? ?????????.
			if (diff_learn <= policyVO.getDelayTrainDay()) return true;
		}

		return false;
	}

	//??????????????? ?????? ?????????????????? : ????????? ?????????????????? ??????.
	//???????????? ??? ??????????????? ????????? ?????? ????????? ???????????? ?????? ??????.
	private boolean isChangeableLecture(HashMap<String, Object> map) {
		int diff_learn = (int) map.get("DIFF_LEARN"); //???????????????????????? ????????????

		//??????????????? ??????????????? ??????????????? ?????????.
		if (diff_learn > 0) return true;

		return false;
	}
}
