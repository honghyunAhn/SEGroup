package com.aracomm.changbi.community.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.aracomm.base.common.util.FileUploadUtil;
import com.aracomm.base.common.vo.FileVo;
import com.aracomm.changbi.common.dao.CommonDao;
import com.aracomm.changbi.community.dao.LmsCommunityDao;

import global.segroup.util.FileService;

@Service
public class ChangbiCommunityService {

	@Autowired
	LmsCommunityDao dao;
	
	@Autowired
	CommonDao commonDao;
	
	public List<HashMap<String, String>> selectBbsDetailPrevNext(HashMap<String, String> param){
		return dao.selectBbsDetailPrevNext(param);
	};
	
	
	public List<HashMap<String, String>> selectBbsList(Map<String, String> param){
		return dao.selectBbsList(param);
	};
	public int selectBbsListTotCnt(Map<String, String> param) {
		return dao.selectBbsListTotCnt(param);
	};
	
	//전체 공지사항 리스트 가져오기
	public List<HashMap<String, Object>> selectNotice(HashMap<String, Object> params) {
		return dao.selectNotice(params);
	}
	//전체 공지사항 총갯수
	public int selectNoticeTotalCnt(HashMap<String, Object> params) {
		return dao.selectNoticeTotalCnt(params);
	}
	//전체 공지사항 조회수 증가
	public int updateNoticeHit(HashMap<String, Object> params) {
		return dao.updateNoticeHit(params);
	}
	
	//과정별 공지사항 리스트
	public List<HashMap<String,Object>> selectCourseNotice(HashMap<String, Object> params) {
		return dao.selectCourseNotice(params);
	}
	//과정별 공지사항(qna도 사용) 갯수
	public int selectCourseNoticeTotalCnt(HashMap<String, Object> params) {
		return dao.selectCourseNoticeTotalCnt(params);
	}
	public int updateCourseNoticeHit(HashMap<String, Object> params) {
		return dao.updateCourseNoticeHit(params);
	}
	
	//과정 qna 리스트
	public List<HashMap<String,Object>> selectQnaReplyList(HashMap<String, Object> params) {
		return dao.selectQnaReplyList(params);
	}
	
	//과정 qna 총개수
	public int selectQnaReplyListTotalCnt(HashMap<String, Object> params) {
		return dao.selectQnaReplyListTotalCnt(params);
	}
	
	//과정 qna 작성 - file저장은 fap에서 쓰는 fileservice 쓰고, db에 정보저장은 fileuploadutil 씀
	//저장 방식을 관리자(changbi-tt) 와 맞춤
	public int insertQna(HashMap<String, Object> params, MultipartFile file) {
		if(file != null) {
			params.put("attach1_file", saveFileAndReturnId(params, file));
		}
		return dao.insertQna(params);
	}
	//과정 qna삭제
	public int deleteQna(HashMap<String, Object> params) {
		HashMap<String, Object> qna = selectCourseNotice(params).get(0);
		if(qna.get("file") != null) {
			String file_id = (String) qna.get("attach1_file");
			HashMap<String, String> param = new HashMap<>();
			param.put("file_id", file_id);
			commonDao.deleteAttachFile(param);
			commonDao.deleteAttachFileDetail(param);
		}
		return dao.deleteQna(params);
	}
	//과정 qna 댓글등록
	public int insertQnaReply(HashMap<String, Object> params) {
		return dao.insertQnaReply(params);
	}
	//과정 qna 댓글삭제
	public int deleteQnaReply(HashMap<String, Object> params) {
		return dao.deleteQnaReply(params);
	}
	//과정 qna 추천비추천
	public int updateQnaReplyRecommend(HashMap<String, Object> params) {
		return dao.updateQnaReplyRecommend(params);
	}
	
	@Transactional
	public int deleteQnaAttachFile(HashMap<String, Object> params) {
		String file_id = (String) params.get("file_id");
		HashMap<String, String> param = new HashMap<>();
		param.put("file_id", file_id);
		commonDao.deleteAttachFile(param);
		commonDao.deleteAttachFileDetail(param);
		
		return dao.deleteAttachFile(params);
	}
	
	//파일처리
	private String saveFileAndReturnId(HashMap<String, Object> params, MultipartFile file) {
		FileVo fileVo = new FileVo();
		String fileId = FileUploadUtil.newFileId();
		String savedFileName = FileService.saveFile(file, (String)params.get("upload_dir"));
		String originFileName = file.getOriginalFilename();
		String fileExt = originFileName.substring(originFileName.lastIndexOf(".") + 1);
		
		fileVo.setFile_id(fileId);
		fileVo.setFile_name(savedFileName);
		fileVo.setFile_ext(fileExt);
		fileVo.setFile_path("/usr/local/" + (String)params.get("upload_dir") + "/" + savedFileName);
		fileVo.setUrl_path((String)params.get("upload_url") + "/" + savedFileName);
		fileVo.setOrigin_file_name(originFileName);
		fileVo.setFile_size(String.valueOf(file.getSize()));
		fileVo.setUser((String)params.get("user_id"));
		
		commonDao.insertAttachFile(fileVo);
		commonDao.insertAttachFileDetail(fileVo);
		
		return fileId;
	}

}