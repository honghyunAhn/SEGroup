package com.aracomm.changbi.serviceCenter.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.base.common.vo.FileVo;
import com.aracomm.changbi.common.dao.CommonDao;
import com.aracomm.changbi.serviceCenter.dao.TeacherAppDao;

@Service
public class TeacherAppService {
	@Autowired
	private TeacherAppDao dao;

	@Autowired
	private CommonDao commonDao;

	@Transactional
	public int insertTeacherApp(Map<String, String> param, List<FileVo> fileList) {

		// 업로드 파일 정보 저장
		for(int i=0; i<fileList.size(); i++) {
			FileVo fileVo = fileList.get(i);
			commonDao.insertAttachFile(fileVo);
			commonDao.insertAttachFileDetail(fileVo);
		}

		return dao.insertTeacherApp(param);
	}
}
