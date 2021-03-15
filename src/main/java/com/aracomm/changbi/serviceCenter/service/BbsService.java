package com.aracomm.changbi.serviceCenter.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aracomm.base.common.vo.FileVo;
import com.aracomm.changbi.board.vo.BoardSearchVo;
import com.aracomm.changbi.common.dao.CommonDao;
import com.aracomm.changbi.serviceCenter.dao.BbsDao;


@Service
public class BbsService {
	private static final Logger logger = LoggerFactory.getLogger(BbsService.class);

	@Autowired
	private BbsDao dao;

	@Autowired
	private CommonDao commonDao;

	public List<HashMap<String, String>> selectBbsCodeList(String code_group) {
		return dao.selectBbsCodeList(code_group);
	}

	public int selectBbsListTotCnt(HashMap<String, String> param) {
		return dao.selectBbsListTotCnt(param);
	}

	public List<HashMap<String, String>> selectBbsList(HashMap<String, String> param) {
		return dao.selectBbsList(param);
	}

	public List<HashMap<String, String>> selectBbsFixedNoticeListAll(HashMap<String, String> param) {
		return dao.selectBbsFixedNoticeListAll(param);
	}

	public HashMap<String, String> selectBbsDetail(HashMap<String, String> param) {
		return dao.selectBbsDetail(param);
	}

	public List<HashMap<String, String>> selectBbsDetailPrevNext(HashMap<String, String> param) {
		return dao.selectBbsDetailPrevNext(param);
	}

	public int selectFaqListTotCnt(HashMap<String, String> param) {
		return dao.selectFaqListTotCnt(param);
	}

	public List<HashMap<String, String>> selectFaqList(HashMap<String, String> param) {
		return dao.selectFaqList(param);
	}

	public int selectQnaListTotCnt(HashMap<String, String> param) {
		return dao.selectQnaListTotCnt(param);
	}

	public List<HashMap<String, String>> selectQnaList(HashMap<String, String> param) {
		return dao.selectQnaList(param);
	}

	public HashMap<String, String> selectReplayDetail(String id) {
		dao.updateReplyHits(id);
		return dao.selectReplyDetail(id);
	}

	@Transactional
	public int attachFileDelete(HashMap<String, String> param) {
		int rst = 0;
		rst = commonDao.deleteAttachFile(param);
		rst = commonDao.deleteAttachFileDetail(param);
		return rst;
	}

	@Transactional
	public int deleteBbs(String id) {
		dao.updateDeleteAttachFileForBbs(id);
		return dao.updateBbsDelete(id);
	}

	@Transactional
	public int insertBbs(HashMap<String, String> param, List<FileVo> fileList) {
		// 업로드 파일 정보 저장
		for(int i=0; i<fileList.size(); i++) {
			FileVo fileVo = fileList.get(i);
			commonDao.insertAttachFile(fileVo);
			commonDao.insertAttachFileDetail(fileVo);
		}

		return dao.insertBbs(param);
	}

	@Transactional
	public int updateBbs(HashMap<String, String> param, List<FileVo> fileList) {
		// 업로드 파일 정보 저장
		for(int i=0; i<fileList.size(); i++) {
			FileVo fileVo = fileList.get(i);
			commonDao.insertAttachFile(fileVo);
			commonDao.insertAttachFileDetail(fileVo);
		}

		return dao.updateBbs(param);
	}

	@Transactional
	public void deleteBbsAttachFile(String board_id, String file_id) {
		commonDao.updateDeleteAttachFile(file_id);
		//commonDao.updateDeleteAttachFileDetailAll(file_id);


		Map<String, String> param = new HashMap<String, String>();
		param.put("id", board_id);
		// 파일1 확인 후 NULL 업데이트
		param.put("file_id", file_id);
		dao.updateBbsDeleteAttachFile1(param);

		// 파일2 확인 후 NULL 업데이트
		dao.updateBbsDeleteAttachFile2(param);
	}

	public Map<String, String> selectBbsForAuth(String board_id) {
		return dao.selectBbsForAuth(board_id);
	}


	public List<Map<String, Object>> selectSimpleTopBoardList(BoardSearchVo searchVo) {
		return dao.selectSimpleTopBoardList(searchVo);
	}


	public int updateHits(String id) {
		return dao.updateHits(id);
	}

	public List<HashMap<String, String>> selectSearchReviewListAll(HashMap<String, String> param) {
		return dao.selectSearchReviewListAll(param);
	}
}
