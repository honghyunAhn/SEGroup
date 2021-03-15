package com.aracomm.changbi.common.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.aracomm.base.common.vo.FileVo;


public interface CommonDao {

	int insertAttachFile(FileVo vo);
	int insertAttachFileDetail(FileVo vo);
	int updateDeleteAttachFile(String file_id);
	int updateDeleteAttachFileDetailAll(String file_id);
	int deleteAttachFile(HashMap<String, String> param);
	int deleteAttachFileDetail(HashMap<String, String> param);
	List<FileVo> selectAttachFileList(String file_id);
	List<FileVo> selectAttachFileListByIds(String [] file_ids);

	// 공통코드
	List<Map<String, String>> selectGroupCodeList(String group_id);

	// 테이블기반 시퀀스
	Map<String, Object> selectSequenceForUpdate(String seq_name);
	void insertSequence(String seq_name);
	void updateSequence(Map<String, String> param);
}
