package com.aracomm.changbi.payment.dao;

import java.util.Map;

import com.aracomm.changbi.payment.KcpCommonReturnParam;
import com.aracomm.changbi.payment.KcpPaymentParam;

public interface KcpPaymentDao {
	int insertKcpPayment(KcpPaymentParam kcpPaymentParam);

	Map<String, Object> selectApplyByOrderIdx(String ordr_idxx);

	Map<String, Object> selectVankKcpPaymentByTno(String tno);

	int updateVankKcpReturn(KcpCommonReturnParam kcpCommonReturnParam);

}
