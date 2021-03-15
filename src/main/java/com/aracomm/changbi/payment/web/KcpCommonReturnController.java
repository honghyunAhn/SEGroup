/**
 *
 */
package com.aracomm.changbi.payment.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.base.exceptions.UserControlException;
import com.aracomm.changbi.learn.service.ApplyService;
import com.aracomm.changbi.mypage.service.LectureService;
import com.aracomm.changbi.payment.KcpCommonReturnParam;
import com.aracomm.changbi.payment.service.KcpCommonReturnSavableService;
import com.aracomm.changbi.payment.service.KcpPaymentService;

/**
 * @author Park
 * KCP 공통 통보 처리 Controller
 * - 가상계좌결제에 대한 입금 통보 등의 처리를 위해 kcp에서 호출하는 url
 *
 */
@Controller
public class KcpCommonReturnController {
	private static final Logger logger = LoggerFactory.getLogger(KcpCommonReturnController.class);
	public final static String RESULT_SUCCESS = "0000";	// 정상처리
	public final static String RESULT_FAIL = "9999";	// 처리실패
	private final static String APP_GUBUN_LEARN = "LEARN";	// 신청구분 - 연수신청
	private final static String APP_GUBUN_BOOK = "BOOK";	// 신청구분 - 교재신청

	@Autowired
	private ApplyService learnAppService;

	@Autowired
	private LectureService lectureService;

	@Autowired
	private KcpPaymentService kcpPaymentService;

	@Value("#{config['kcp.common_retrun.server_iplist']}")
	private String kcp_common_return_server_iplist;


	@RequestMapping(value = "/kcp/common_return")
	public String common_return(Model model, HttpServletRequest request,  KcpCommonReturnParam kcpCommonReturnParam) {
		String resultCode = RESULT_FAIL;

	    /* ============================================================================== */
	    /* =   01. 공통 통보 페이지 설명(필독!!)                                        = */
	    /* = -------------------------------------------------------------------------- = */
	    /* =   공통 통보 페이지에서는,                                                  = */
	    /* =   가상계좌 입금 통보 데이터를 KCP를 통해 실시간으로 통보 받을 수 있습니다. = */
	    /* =                                                                            = */
	    /* =   common_return 페이지는 이러한 통보 데이터를 받기 위한 샘플 페이지        = */
	    /* =   입니다. 현재의 페이지를 업체에 맞게 수정하신 후, 아래 사항을 참고하셔서  = */
	    /* =   KCP 관리자 페이지에 등록해 주시기 바랍니다.                              = */
	    /* =                                                                            = */
	    /* =   등록 방법은 다음과 같습니다.                                             = */
	    /* =  - KCP 관리자페이지(admin.kcp.co.kr)에 로그인 합니다.                      = */
	    /* =  - [쇼핑몰 관리] -> [정보변경] -> [공통 URL 정보] -> 공통 URL 변경 후에    = */
	    /* =    가맹점 URL을 입력합니다.                                                = */
	    /* ============================================================================== */


	    /* ============================================================================== */
	    /* =   02. 공통 통보 데이터 받기                                                = */
	    /* = -------------------------------------------------------------------------- = */

		/* = kcpCommonReturnParam 사용으로 기존 처리 대체 									    = */

		/* = -------------------------------------------------------------------------- = */
	    /* =   02-1. 가상계좌 입금 통보 데이터 받기                                     = */
	    /* = -------------------------------------------------------------------------- = */

		/* = kcpCommonReturnParam 사용으로 기존 처리 대체 									    = */

		/* = -------------------------------------------------------------------------- = */

		logger.debug("kcpCommonReturnParam: {}", kcpCommonReturnParam);

		String op_cd = kcpCommonReturnParam.getOp_cd();		// 가상계좌 입금 처리 결과 구분 코드

		//‘13’을 제외한 모든 건 은 입금 건으로 처리 하시기 바랍니다. op_cd = ‘13’ 은 입금이 잘못 된 경우로 가맹점 에 취소 노티가 나갑니다.
		if(!KcpCommonReturnParam.OP_CD_WRONG_IPGM.equals(op_cd)) {	// 잘못된 입금이 아닌 경우만 DB처리
			try {
				// KCP 호출 서버 IP 체크
				checkKcpCommonReturnServerIp(CommonUtil.getRemoteAddr(request));

				// 가상계좌 결제내역조회
				Map<String, Object> kcpPayment = kcpPaymentService.selectVankKcpPaymentByTno(kcpCommonReturnParam.getTno());

				if (kcpPayment == null) throw new UserControlException("not found payment");

				String ordr_idxx = (String)kcpPayment.get("ORDR_IDXX");

				// 주문번호로 주문신청 정보 조회(연수신청, 교재신청)
				Map<String, Object> apply = kcpPaymentService.selectApplyByOrderIdx(ordr_idxx);

				if (apply == null) throw new UserControlException("Not found apply For order_idx (" + ordr_idxx + ")");

				String appGubun = String.valueOf(apply.get("APP_GUBUN"));
				String appId =  String.valueOf(apply.get("ID"));

				// 신청 ID 및 부분입금 여부 설정
				int amount = (int)kcpPayment.get("AMOUNT");
				int ipgm_mnyx = Integer.valueOf(kcpCommonReturnParam.getIpgm_mnyx());
				boolean partialPayment = (amount != ipgm_mnyx);	// 일부입금여부
				kcpCommonReturnParam.setAppId(appId);
				kcpCommonReturnParam.setPartialPayment(partialPayment);

				KcpCommonReturnSavableService service = null;
				if (APP_GUBUN_LEARN.equals(appGubun)) {
					service = learnAppService;
				} else if (APP_GUBUN_BOOK.equals(appGubun)) {
					service = lectureService;

					// 교재신청은 부분입금 상태가 없어 오류 처리
					if (partialPayment) {
						throw new UserControlException("partial payment not permitted (" + ipgm_mnyx + "<>" + ipgm_mnyx +")");
					}
				} else {
					throw new UserControlException("Not found KcpCommonReturnSavableService for app gubun (" + appGubun + ")");
				}

				// DB 업데이트
				int affected = kcpPaymentService.applyCommonReturn(kcpCommonReturnParam, service);

				logger.debug("common return affected count:" + affected);

				if (affected > 0) resultCode = RESULT_SUCCESS;

			} catch (UserControlException ex) {
				resultCode = RESULT_FAIL;
				logger.error(ex.getMessage());
			} catch (Exception ex) {
				resultCode = RESULT_FAIL;
				logger.error("KCP COMMON RETURN FAILED!!", ex);
			}
		} else {
			logger.info("common_return ignored (op_cd: 13)");
			resultCode = RESULT_SUCCESS;
		}

		model.addAttribute("resultCode", resultCode);

		logger.info("common_return responsed. ["+resultCode+"]");

		return "common/kcp/common_return";
	}

	/**
	 * kcp 통보 서버 ip 체크
	 * @param remoteIp
	 * @throws UserControlException
	 */
	private void checkKcpCommonReturnServerIp(String remoteIp) throws UserControlException {
		boolean isReturnServerIp = false;
		if(StringUtils.isEmpty(kcp_common_return_server_iplist)) return;

		String [] ips = kcp_common_return_server_iplist.split(",");
		for(int i=0; i<ips.length; i++) {
			String ip = StringUtils.trim(ips[i]);
			if (StringUtils.isEmpty(ip)) continue;

			if (ip.equals(remoteIp)) {
				isReturnServerIp = true;
				break;
			}
		}

		if (!isReturnServerIp) throw new UserControlException(remoteIp + " is not permitted (kcp return server ip)");
	}

}
