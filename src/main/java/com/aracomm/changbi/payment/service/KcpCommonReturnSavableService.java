package com.aracomm.changbi.payment.service;

import com.aracomm.base.exceptions.UserControlException;
import com.aracomm.changbi.payment.KcpCommonReturnParam;

public abstract class KcpCommonReturnSavableService {
	public abstract int updateVbankReturn(KcpCommonReturnParam kcpCommonReturnParam) throws UserControlException;
}
