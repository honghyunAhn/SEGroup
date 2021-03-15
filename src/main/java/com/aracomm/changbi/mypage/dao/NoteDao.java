package com.aracomm.changbi.mypage.dao;

import java.util.List;
import java.util.Map;

import com.aracomm.changbi.mypage.vo.NoteSearchVo;

public interface NoteDao {

	List<Map<String, Object>> selectNoteList(NoteSearchVo searchVo);

	Map<String, Object> selectNote(NoteSearchVo searchVo);

	int selectNoteListTotCnt(NoteSearchVo searchVo);

	int insertNote(Map<String, Object> param);

	int updateNoteRead(NoteSearchVo searchVo);

	int updateDeleteNote(NoteSearchVo searchVo);

}
