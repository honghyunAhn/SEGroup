package com.aracomm.changbi.community.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface LmsCommunityDao {

	public List<HashMap<String, String>> selectBbsDetailPrevNext(HashMap<String, String> param);
	public List<HashMap<String, String>> selectBbsList(Map<String, String> param);
	public int selectBbsListTotCnt(Map<String, String> param);
	//전체 공지사항 리스트 가져오기
	public List<HashMap<String, Object>> selectNotice(HashMap<String, Object> params);
	//전체 공지사항 리스트 총갯수
	public int selectNoticeTotalCnt(HashMap<String, Object> params);
	public int updateNoticeHit(HashMap<String, Object> params);
	//과정별 공지사항 리스트
	public List<HashMap<String,Object>> selectCourseNotice(HashMap<String, Object> params);
	//과정별 공지사항(qna도 사용) 갯수
	public int selectCourseNoticeTotalCnt(HashMap<String, Object> params);
	//과정별 공지사항 조회수
	public int updateCourseNoticeHit(HashMap<String, Object> params);
	//과정 qna 리스트
	public List<HashMap<String,Object>> selectQnaReplyList(HashMap<String, Object> params);
	//과정 qna 총개수
	public int selectQnaReplyListTotalCnt(HashMap<String, Object> params);
	//과정 qna작성
	public int insertQna(HashMap<String, Object> params);
	//과정 qna삭제
	public int deleteQna(HashMap<String, Object> params);
	//과정 qna 첨부파일 삭제
	public int deleteAttachFile(HashMap<String, Object> params);
	//과정 qna 댓글등록
	public int insertQnaReply(HashMap<String, Object> params);
	//과정 qna 댓글삭제
	public int deleteQnaReply(HashMap<String, Object> params);
	//과정 qna 추천비추천
	public int updateQnaReplyRecommend(HashMap<String, Object> params);
}