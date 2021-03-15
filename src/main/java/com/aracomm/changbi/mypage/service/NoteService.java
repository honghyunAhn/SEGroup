package com.aracomm.changbi.mypage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.mypage.dao.NoteDao;
import com.aracomm.changbi.mypage.vo.NoteSearchVo;

@Service
public class NoteService {
	@Autowired
	NoteDao dao;

	public List<Map<String, Object>> selectNoteList(NoteSearchVo searchVo) {
		searchVo.setTotalCnt(dao.selectNoteListTotCnt(searchVo));
		return dao.selectNoteList(searchVo);
	}

	public Map<String, Object> selectNote(NoteSearchVo searchVo) {
		return dao.selectNote(searchVo);
	}

	public Map<String, Object> selectNoteWithView(NoteSearchVo searchVo) {
		if ("R".equals(searchVo.getGubun())) {
			dao.updateNoteRead(searchVo);
		}
		return dao.selectNote(searchVo);
	}

	public int selectNoteListTotCnt(NoteSearchVo searchVo) {
		return dao.selectNoteListTotCnt(searchVo);
	}

	public int insertNote(Map<String, Object> param) {
		return dao.insertNote(param);
	}

	public int deleteNote(NoteSearchVo searchVo) {
		return dao.updateDeleteNote(searchVo);
	}

}
