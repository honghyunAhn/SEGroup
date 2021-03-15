package com.aracomm.changbi.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.apache.commons.lang3.StringUtils;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.base.common.vo.FileVo;
import com.aracomm.changbi.common.dao.CommonDao;

@Service
public class CommonService {
	private static final Logger logger = LoggerFactory.getLogger(CommonService.class);

	@Autowired
	private CommonDao commonDao;

	public List<FileVo> selectAttachFileList(String file_id) {
		return commonDao.selectAttachFileList(file_id);
	}

	public List<FileVo> selectAttachFileListByIds(String [] file_ids) {
		return commonDao.selectAttachFileListByIds(file_ids);
	}

	public List<Map<String, String>> selectGroupCodeList(String group_id) {
		return commonDao.selectGroupCodeList(group_id);
	}

	/**
	 * 테이블 기반 시퀀스 획득
	 * @param seq_name 시퀀스키
	 * @return
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public long getSequence(String seq_name) {
		Long seq = getLongSequence(seq_name, false);
		return seq.longValue();
	}

	/**
	 * 테이블 기반 일단위 시퀀스 획득
	 * @param seq_name 시퀀스키
	 * @return
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public long getDailySequence(String seq_name) {
		Long seq = getLongSequence(seq_name, true);
		return seq.longValue();
	}

	/**
	 * 테이블 기반 정수형 시퀀스 획득
	 * @param seq_name 시퀀스키
	 * @return
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public int getIntSequence(String seq_name) {
		Long seq = getLongSequence(seq_name, false);
		return seq.intValue();
	}

	/**
	 * 테이블 기반 정수형 일단위 시퀀스 획득
	 * @param seq_name 시퀀스키
	 * @return
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public int getIntDailySequence(String seq_name) {
		Long seq = getLongSequence(seq_name, true);
		return seq.intValue();
	}

	/**
	 * 테이블 기반 시퀀스 획득
	 * @param seq_name 시퀀스키
	 * @param daily 일단위 시퀀스 여부
	 * @return
	 */

	private Long getLongSequence(String seq_name, boolean daily) {
		/*
		 * multi was 환경에서 중복 시퀀스 발생 방지 위해
		 * sequence 테이블이 innodb 타입일 것
		 */
		Map<String, Object> data = commonDao.selectSequenceForUpdate(seq_name);
		Long seq = (Long)data.get("SEQ");

		String curDate = CommonUtil.getCurrentDate();

		String upd_ymd = (String)data.get("UPD_YMD");
		if (StringUtils.isEmpty(upd_ymd)) {
			commonDao.insertSequence(seq_name);
		} else {
			Map<String, String> param = new HashMap<String, String>();
			param.put("seq_name", seq_name);

			// daily 시퀀스일 경우 일단위로 시퀀스 초기화
			if (daily) {
				if (!curDate.equals(upd_ymd)) {
					param.put("dailyInit", "Y");
					seq = new Long("1");
				}
			}
			commonDao.updateSequence(param);
		}

		return seq;
	}
}
