package com.aracomm.changbi.learn.service;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.apache.commons.lang3.StringUtils;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.base.exceptions.InvalidAccessException;
import com.aracomm.base.exceptions.UserControlException;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.util.PointUtil;
import com.aracomm.changbi.learn.dao.ApplyDao;
import com.aracomm.changbi.member.dao.PointDao;
import com.aracomm.changbi.mypage.dao.BookAppDao;
import com.aracomm.changbi.mypage.dao.CouponDao;
import com.aracomm.changbi.mypage.vo.CouponSearchVo;
import com.aracomm.changbi.payment.KcpCommonReturnParam;
import com.aracomm.changbi.payment.KcpPaymentParam;
import com.aracomm.changbi.payment.dao.KcpPaymentDao;
import com.aracomm.changbi.payment.service.KcpCommonReturnSavableService;


@Service
public class ApplyService extends KcpCommonReturnSavableService {
	private static final Logger logger = LoggerFactory.getLogger(ApplyService.class);

	@Autowired
	private ApplyDao dao;

	@Autowired
	private PointDao pointDao;

	@Autowired
	private CouponDao couponDao;

	@Autowired
	private KcpPaymentDao kcpPaymentDao;

	@Autowired
	private BookAppDao bookAppDao;

	@Autowired
	MessageSource messageSource;

	@Transactional
	public int saveApply(HashMap<String,String> param, KcpPaymentParam kcpPaymentParam) {
		// 수강신청 등록
		int affected = insertApplyWithPointCoupon(param);

		// 결제정보 등록
		if (affected > 0) kcpPaymentParam.setBsucc(KcpPaymentParam.BSUCC_SUCCESS);
		else kcpPaymentParam.setBsucc(KcpPaymentParam.BSUCC_FAIL);
		kcpPaymentDao.insertKcpPayment(kcpPaymentParam);

		return affected;
	}

	@Transactional
	public int saveApply(HashMap<String,String> param) {
		return insertApplyWithPointCoupon(param);
	}

	private int insertApplyWithPointCoupon(HashMap<String,String> param) {
		// 1. 수강신청 등록
		int affected = dao.insertApply(param);

		// 2. 교재신청 등록
		String main_tb_id = param.get("main_tb_id");
		if (!StringUtils.isEmpty(main_tb_id)) {
			bookAppDao.insertBookAppFromLearnApp(param);
		}

		// 3. 사용포인트 등록
		String user_id = param.get("user_id");
		String learn_app_id = String.valueOf(param.get("id"));
		int usePoint= Integer.valueOf(param.get("dis_point"));

		if (usePoint > 0) {
			// 가용포인트 체크
			HashMap<String, Object> myPoint = pointDao.selectPointSummary(user_id);
			int availPoint = CommonUtil.getIntValue(myPoint.get("BALANCE"));
			if (usePoint > availPoint) {
				throw new InvalidAccessException(messageSource.getMessage("msg.apply.pointlack", null, "msg.apply.pointlack", Locale.getDefault()));
			}

			Map<String, Object> point = new HashMap<String, Object>();
			point.put("user_id", user_id);
			point.put("learn_app_id", learn_app_id);
			//point.put("name", memberForm.getName());
			point.put("give", 0);
			point.put("withdraw", usePoint);
			point.put("note", messageSource.getMessage("point.applyUse", null, "point.applyUse", Locale.getDefault()));
			pointDao.insertPoint(point);
		}

		// 4. 포인트 적립 (결제완료시에 포인트정책에 의함)
		/*String payment_state = param.get("payment_state");
		if (GlobalConst.PAYMENT_STATE_DONE.equals(payment_state)) {
			int target_amount = Integer.valueOf(param.get("real_payment")) - Integer.valueOf(param.get("main_price"));
			if (target_amount > 0 && !StringUtils.isEmpty(user_id) && !StringUtils.isEmpty(learn_app_id)) {
				Map<String, Object> pointPolicy = pointDao.selectPolicyPoint();
				Map<String, Object> point;
				if (pointPolicy != null) {
					// 수강신청 포인트 등록(수강료에 대해서만 적립됨)
					String useYn = (String)pointPolicy.get("SAVE_LECTURE_USE");
					if("Y".equals(useYn)) {
						target_amount = Integer.valueOf(param.get("real_payment")) - Integer.valueOf(param.get("main_price"));
						String type = (String)pointPolicy.get("SAVE_LECTURE_TYPE");
						int save = (Integer)pointPolicy.get("SAVE_LECTURE_POINT");

						point = new HashMap<String, Object>();
						point.put("user_id", user_id);
						point.put("learn_app_id", learn_app_id);
						//point.put("name", memberForm.getName());
						point.put("give", PointUtil.getSavePoint(target_amount, type, save));
						point.put("withdraw", 0);
						point.put("note", messageSource.getMessage("point.applySave", null, "point.applySave", Locale.getDefault()));
						pointDao.insertPoint(point);
					}
				}
			}
		}*/

		// 5. 쿠폰 사용 처리
		String coupon_num = param.get("coupon_num");
		if (!StringUtils.isEmpty(coupon_num)) {
			// 가용 쿠폰 체크 (과정ID은 체크하지 않음)
			HashMap<String, Object> coupon = couponDao.selectCouponByCouponNum(coupon_num);
			if (coupon == null || !user_id.equals((String)coupon.get("USER_ID"))) {
				throw new InvalidAccessException(messageSource.getMessage("msg.apply.invalidcoupon", null, "msg.apply.invalidcoupon", Locale.getDefault()));
			}

			couponDao.updateCouponUse(coupon_num);
		}

		return affected;
	}

	public int updateDonePaymentByOrderIdx(String order_idx) {
		return dao.updateDonePayment(order_idx);
	}

	public Object selectUserCourseCouponList(CouponSearchVo searchVo) {
		searchVo.setTotalCnt(couponDao.selectUserCouponListTotCnt(searchVo));
		return couponDao.selectUserCouponList(searchVo);
	}

	public int selectUserApplyCourseCount(String user_id, String course_id, String cardinal_id) {
		Map<String, String> param= new HashMap<String, String>();
		param.put("user_id", user_id);
		param.put("course_id", course_id);
		param.put("cardinal_id", cardinal_id);
		return dao.selectUserApplyCourseCount(param);
	}

	/**
	 * 가상계좌 입금 통보 업데이트
	 */
	@Override
	@Transactional
	public int updateVbankReturn(KcpCommonReturnParam kcpCommonReturnParam) throws UserControlException {
		int affected = 0;

		boolean partial = kcpCommonReturnParam.isPartialPayment();

		// 신청정보 결제완료 상태 업데이트
		if (partial) {
			dao.updatePartialPayment(kcpCommonReturnParam.getAppId());
		} else {
			dao.updateDonePayment(kcpCommonReturnParam.getAppId());
		}

		// 결제내역 통보정보 업데이트
		affected = kcpPaymentDao.updateVankKcpReturn(kcpCommonReturnParam);

		return affected;
	}

	public int selectApplyCountByDesNum(String des_num, String user_id, String learn_id) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("des_num", des_num);
		param.put("user_id", user_id);
		param.put("learn_id", learn_id);
		return dao.selectApplyCountByDesNum(param);
	}
	
	public Map<String, Object> selectUserAddress(String user_id) {
		Map<String, Object> userAddress = dao.selectUserAddress(user_id);
		return userAddress;
	}

}
