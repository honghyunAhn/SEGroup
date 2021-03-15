package com.aracomm.changbi.serviceCenter.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.aracomm.changbi.board.vo.BoardSearchVo;

public interface BbsDao {

	List<HashMap<String, String>> selectBbsCodeList(String code_group);

	int selectBbsListTotCnt(Map<String, String> param);
	List<HashMap<String, String>> selectBbsList(Map<String, String> param);
	List<HashMap<String, String>> selectBbsFixedNoticeListAll(Map<String, String> param);

	HashMap<String, String> selectBbsDetail(HashMap<String, String> param);
	List<HashMap<String, String>> selectBbsDetailPrevNext(HashMap<String, String> param);

	int selectFaqListTotCnt(Map<String, String> param);
	List<HashMap<String, String>> selectFaqList(HashMap<String, String> param);

	int selectQnaListTotCnt(Map<String, String> param);
	List<HashMap<String, String>> selectQnaList(Map<String, String> param);
	HashMap<String, String> selectQnaDetail(Map<String, String> param);

	HashMap<String, String> selectBbsForAuth (String id);
	int insertBbs(HashMap<String, String> param);
	int updateBbs(HashMap<String, String> param);
	int updateBbsDelete(String id);

	int updateHits(String id);

	HashMap<String, String> selectReplyDetail(String id);
	int updateReplyHits(String id);

	int updateBbsDeleteAttachFile1(Map<String, String> param);
	int updateBbsDeleteAttachFile2(Map<String, String> param);

	int updateDeleteAttachFileForBbs(String id);

	List<Map<String, Object>> selectSimpleTopBoardList(BoardSearchVo searchVo);

	List<HashMap<String, String>> selectSearchReviewListAll(HashMap<String, String> param);
}
