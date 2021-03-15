package com.aracomm.changbi.common.util;

public class PointUtil {
	public final static String SAVE_RULE_MONEY = "1";
	public final static String SAVE_RULE_PERCENT = "2";

	/**
	 * 적립포인트
	 * @param amount	대상금액
	 * @param saveType	적립유형(1:포인트,2:퍼센트)
	 * @param point		적립(포인트,퍼센트 수치)
	 * @return
	 */
	public static int getSavePoint(int amount, String saveType, int point) {
		int save = 0;
		if (SAVE_RULE_MONEY.equals(saveType)) {	// 지정된 포인트 적립
			save = point;
		} else if (SAVE_RULE_PERCENT.equals(saveType)) {	// 대상금액에 %만큼 적립
			save = Math.round(amount * (float)point/100);
		} else {
			throw new RuntimeException("unknown point save rule");
		}

		return save;
	}
}
